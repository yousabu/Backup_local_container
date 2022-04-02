#!/bin/bash

DATE=$(date +%H-%M-%S)


# local and container wordpress datafile
tar -czf wp_red_local_$DATE.tar.gz /var/www/html/wp-content/themes

tar -czf wp_blue_con_$DATE.tar.gz /home/youssef/blue_wp_con/wordpress_data/wp-content/themes

# mysql backup from container
sudo mysqldump -u root -P 8083  --protocol=tcp -pWord@500 --column-statistics=0 wordpress > wp_DB_con_$DATE.sql

# mysql backup from local
sudo mysqldump -u root -pYoussef@500 wordpress > wp_DB_local_$DATE.sql


# aws craid 
export AWS_SECRET_ACCESS_KEY=o8ROPS9a9VeUpQEf2N15c6HFaSsteqrJX/ePTzBT
export AWS_ACCESS_KEY_ID=AKIAYORXP2IZSMNP7HXP


# Uploading..........

echo "Uploading your wp_red_local_$DATE.tar.gz  backup...." && \
aws s3 cp wp_red_local_$DATE.tar.gz  s3://wptask/wp_red_local_$DATE.tar.gz

echo "Uploading your wp_DB_local_$DATE.sql  backup...." && \
aws s3 cp wp_DB_local_$DATE.sql  s3://wptask/wp_DB_local_$DATE.sql


echo "Uploading your wp_blue_con_$DATE.tar.gz  backup...." && \
aws s3 cp wp_blue_con_$DATE.tar.gz  s3://wptask/wp_blue_con_$DATE.tar.gz


echo "Uploading your wp_DB_con_$DATE.sql  backup...." && \
aws s3 cp wp_DB_con_$DATE.sql  s3://wptask/wp_DB_con_$DATE.sql
