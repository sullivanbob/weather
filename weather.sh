#!/bin/sh
# In weather.dat you’ll find daily weather data for 
# Morristown, NJ for June 2002. Download this text file,
# then write a program to output the day number (column one)
# with the smallest temperature spread (the maximum temperature 
# is the second column, the minimum the third column). 
#
# URL : http://codekata.pragprog.com/2007/01/kata_four_data_.html
# Bob Sullivan
# 
cat > weather.awk << EOF
BEGIN { DEBUG = 0; cnt = 0; lday = 0; lmin = 0; lmax = 0; sday = 0; smin = 0; smax = 9999; }

// { if (\$1 ~ /[0-9]+/)
     {
        cnt++;
        if (2 == DEBUG)
        {
            printf("Idx: %d, Line %30.30s\n", cnt, \$0);
        }
        lday = \$1;
        lmax = \$2;
        lmin = \$3;
        if (1 == DEBUG)
        {
            printf("Cnt: %d, Min %d, Max %d, Diff %d\n", lday, lmin, lmax, (lmax - lmin));
        }
        if ((smax - smin) > (lmax - lmin))
        {
            sday = lday;
            smin = lmin;
            smax = lmax;
            if (1 == DEBUG)
            {
                printf("Save Cnt: %d, Min %d, Max %d Diff %d\n", 
                        sday, smin, smax, (smax - smin));
            }
        }
     }
   }
END { printf("  %02d  %02d    %02d\n", sday, smax, smin); }
EOF

cat weather.dat | awk -f weather.awk
