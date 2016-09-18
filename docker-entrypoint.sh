#!/bin/bash

sed -e "s/\${DB_HOST}/$DB_HOST/" \
    -e "s/\${DB_NAME}/$DB_NAME/" \
    -e "s/\${DB_USER}/$DB_USER/" \
    -e "s/\${DB_PASSWORD}/$DB_PASSWORD/" \
    -e "s/\${DB_TABLE}/$DB_TABLE/" \
    /config/logstash.conf.template > /config/logstash.conf

set -e

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
if [ "$1" = 'logstash' ]; then
	set -- gosu logstash "$@"
fi

exec "$@"