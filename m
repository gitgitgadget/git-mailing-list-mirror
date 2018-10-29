Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5861F453
	for <e@80x24.org>; Mon, 29 Oct 2018 20:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeJ3FP5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 01:15:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38936 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeJ3FP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 01:15:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id e4so5831819qkh.6
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=4xhp+qbKpyK/HDsShpQ3hHXvnvbbXD+9ALlGV5xkvP8=;
        b=Cdh5SnegoIeG721DB5wU/8VlvTQuaiTcRupKFevi+925Hdk3l8yVybVlG607gWT+Q8
         YaZDDIcyC3eRsCqi5SRLIp0Rbl0UBWCWbj82XO5QM9PeySnsO5NzCVI0rE1Vs8Vja/dU
         qc8nfv5Z8SETlAc3dpBmpPzl6vlRTgapX6Fj2qBzJo+SS1lKmdWRzPx96r5dBC9l5eyL
         lvgqGA0366s8/N7WaTFYI2opjQeNuAOfTg6MucgY1laS8LtVK5G2WtTAFE2JefCHFyHa
         NM5sxyWKOhY+CfGZ+x/UvhgUdismAjvR1C8xFm4H872rxrghEef9upy7bH5++8Kg5ibI
         wxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4xhp+qbKpyK/HDsShpQ3hHXvnvbbXD+9ALlGV5xkvP8=;
        b=clS27BKWOnOp9TEO2dl5noxk4K3fgCHT7O3eVZP7wkiJRW399ejvEc6sgPFZ6lnGqo
         TKQOXNqWVXETwvDtPa26rwW//VKxVQ8HjX745rVNWw5ybnWO12wOSPPLvn6AvQeDdo6b
         ml/MG61Z1C/yAZu+OK5IpqUu462Wg09WUyXMx5fnDOlIAjlL+zBBniwWAFp/VXl1oMYR
         VzxBjl/ofl/+SAeXnBm9EJWpkMdCp3/nVQxEf1F1bvzYI+6QlHULzuD4WMA5eruwK108
         P0MCe+0PuK1jDclU3BFhGHm7vcHTdbt9BXMkPgwQBVhvBser4cGnXEKLEigz3gRQgM/n
         tquQ==
X-Gm-Message-State: AGRZ1gJXHsxQ/yNswqDuU6F+yszsxt4fi0GA3EDW0NokX/ByMOWKcDL/
        UF9H1UKcQgzqjFETwM7Nd/Y=
X-Google-Smtp-Source: AJdET5drWz1hpqTv+0/MAAoa+bSxzdPlgeBFUaCOEvWqN3XzZl0vS2aTKXs8NTFHH7cYFvMOHFnKiw==
X-Received: by 2002:a37:1b2a:: with SMTP id b42mr13777962qkb.198.1540844739873;
        Mon, 29 Oct 2018 13:25:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:59a3:5b1:9f9a:d149? ([2001:4898:8010:0:42d9:5b1:9f9a:d149])
        by smtp.gmail.com with ESMTPSA id a186-v6sm2892765qkd.82.2018.10.29.13.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:25:39 -0700 (PDT)
Subject: Re: [RFC] Generation Number v2
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
Message-ID: <3576719c-3cfb-547a-3548-3aaebfe6e8a2@gmail.com>
Date:   Mon, 29 Oct 2018 16:25:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a re-formatted version of the tables I introduced earlier.
The tables were too wide for public-inbox to render correctly (when
paired with my email client). Hopefully this bulleted-list format
works better. Thanks, Stefan, for pointing out the rendering
problems!

### Test 1: `git log --topo-order -N`

This test focuses on the number of commits that are parsed during
a `git log --topo-order` before writing `N` commits to output.

You can reproduce this test using `topo-order-tests.sh` and
see all the data in `topo-order-summary.txt`. The values reported
here are a sampling of the data, ignoring tests where all values
were the same or extremely close in value.

android-base, N = 100
     V0: 5487
     V1: 8534
     V2: 6937
     V3: 6419
     V4: 6453
android-base, N = 1000
     V0: 36029
     V1: 44030
     V2: 41493
     V3: 41206
     V4: 45431
chromium, N = 100
     V0:    101
     V1: 424406
     V2:    101
     V3:    101
     V4:    101
gerrit, N = 100
     V0: 8212
     V1: 8533
     V2:  164
     V3:  159
     V4:  162
gerrit, N = 1000
     V0: 8512
     V1: 8533
     V2: 1990
     V3: 1973
     V4: 3766
Linux, N = 100
     V0: 12458
     V1: 12444
     V2: 13683
     V3: 13123
     V4: 13124
Linux, N = 1000
     V0: 24436
     V1: 26247
     V2: 27878
     V3: 26430
     V4: 27875
Linux, N = 10000
     V0: 30364
     V1: 28891
     V2: 27878
     V3: 26430
     V4: 27875
electron, N = 1000
     V0: 19927
     V1: 18733
     V2:  1072
     V3: 18214
     V4: 18214
Ffmpeg, N = 10000
     V0: 32154
     V1: 47429
     V2: 10435
     V3: 11054
     V4: 11054
jgit, N = 1000
     V0: 1550
     V1: 6264
     V2: 1067
     V3: 1060
     V4: 1233
julia, N = 10000
     V0: 43043
     V1: 43043
     V2: 10201
     V3: 23505
     V4: 23828
odoo, N = 1000
     V0: 17175
     V1:  9714
     V2:  4043
     V3:  4046
     V4:  4111
php-src, N = 1000
     V0: 19014
     V1: 27530
     V2:  1311
     V3:  1305
     V4:  1320
rails, N = 100
     V0: 1420
     V1: 2041
     V2: 1757
     V3: 1428
     V4: 1441
rails, N = 1000
     V0:  7952
     V1: 10145
     V2: 10053
     V3:  8373
     V4:  8373
swift, N = 1000
     V0: 1914
     V1: 4004
     V2: 2071
     V3: 1939
     V4: 1940
tensorflow, N = 1000
     V0: 10019
     V1: 39221
     V2:  6711
     V3: 10051
     V4: 10051
TypeScript, N = 1000
     V0:  2873
     V1: 12014
     V2:  3049
     V3:  2876
     V4:  2876


### Test 2: `git log --topo-order -10 A..B`

This test focuses on the number of commits that are parsed during
a `git log --topo-order A..B` before writing ten commits to output.
Since we fix a very small set of output commits, we care more about
the part of the walk that determines which commits are reachable
from `B` but not reachable from `A`. This part of the walk uses
commit date as a heuristic in the existing implementation.

You can reproduce this test using `topo-compare-tests.sh` and
see all the data in `topo-compare-summary.txt`. The values reported
here are a sampling of the data, ignoring tests where all values
were the same or extremely close in value.

_Note:_ For some of the rows, the `A` and `B` values may be
swapped from what is expected. This is due to (1) a bug in the
reference implementation that doesn't short-circuit the walk
when `A` can reach `B`, and (2) data-entry errors by the author.
The bug can be fixed, but would have introduced strange-looking
rows in this table.

android-base 53c1972bc8f 92f18ac3e39
   OLD: 39403
    V0:  1544
    V1:  6957
    V2:    26
    V3:  1015
    V4:  1098
gerrit c4311f7642 777a8cd1e0
   OLD:  6457
    V0:  7836
    V1: 10869
    V2:   415
    V3:   414
    V4:   445
electron 7da7dd85e addf069f2
   OLD: 18164
    V0:   945
    V1:  6528
    V2:    17
    V3:    17
    V4:    18
julia 7faee1b201 e2022b9f0f
   OLD: 22800
    V0:  4221
    V1: 12710
    V2:   377
    V3:   213
    V4:   213
julia ae69259cd9 c8b5402afc
   OLD:  1864
    V0:  1859
    V1: 13287
    V2:    12
    V3:  1859
    V4:  1859
Linux 69973b830859 c470abd4fde4
   OLD: 111692
    V0:  77263
    V1:  96598
    V2:  80238
    V3:  76332
    V4:  76495
Linux c3b92c878736 19f949f52599
   OLD: 167418
    V0:   5736
    V1:   4684
    V2:   9675
    V3:   3887
    V4:   3923
Linux c8d2bc9bc39e 69973b830859
   OLD: 44940
    V0:  4056
    V1: 16636
    V2: 10405
    V3:  3475
    V4:  4022
odoo 4a31f55d0a0 93fb2b4a616
   OLD: 25139
    V0: 19528
    V1: 20418
    V2: 19874
    V3: 19634
    V4: 27247
swift 4046359efd b34b6a14c7
   OLD: 13411
    V0:   662
    V1:   321
    V2:    12
    V3:    80
    V4:   134
tensorflow ec6d17219c fa1db5eb0d
   OLD: 10373
    V0:  4762
    V1: 36272
    V2:   174
    V3:  3631
    V4:  3632
TypeScript 35ea2bea76 123edced90
   OLD:  3450
    V0:   267
    V1: 10386
    V2:    27
    V3:   259
    V4:   259


### Test 3: `git merge-base A B`

This test focuses on the number of commits that are parsed during
a `git merge-base A B`. This part of the walk uses commit date as
a heuristic in the existing implementation.

You can reproduce this test using `merge-base-tests.sh` and
see all the data in `merge-base-summary.txt`. The values reported
here are a sampling of the data, ignoring tests where all values
were the same or extremely close in value.

android-base 53c1972bc8f 92f18ac3e39
   OLD:  81999
    V0: 109025
    V1:  81885
    V2:  77475
    V3:  81999
    V4:  82001
gerrit c4311f7642 777a8cd1e0
   OLD: 6468
    V0: 7995
    V1: 6566
    V2: 6478
    V3: 6468
    V4: 6468
electron 7da7dd85e addf069f2
   OLD: 18160
    V0: 19871
    V1: 18670
    V2:  2231
    V3: 18160
    V4: 18160
julia 7faee1b201 e2022b9f0f
   OLD: 22803
    V0: 42339
    V1: 42212
    V2:  6803
    V3: 22803
    V4: 22803
julia c8b5402afc ae69259cd9
   OLD:  7076
    V0: 42909
    V1: 42770
    V2:  2690
    V3:  7076
    V4:  7076
Linux 69973b830859 c470abd4fde4
   OLD: 44984
    V0: 47457
    V1: 44679
    V2: 38461
    V3: 44984
    V4: 44984
Linux c3b92c878736 19f949f52599
   OLD: 111740
    V0: 111027
    V1: 111196
    V2: 107835
    V3: 111771
    V4: 111368
Linux c8d2bc9bc39e 69973b830859
   OLD: 167468
    V0: 635579
    V1: 630138
    V2:  33716
    V3: 167496
    V4: 153774
odoo 4a31f55d0a0 93fb2b4a616
   OLD: 25150
    V0: 27259
    V1: 23977
    V2: 24041
    V3: 23974
    V4: 26829
swift 4046359efd b34b6a14c7
   OLD: 13434
    V0: 13254
    V1: 13940
    V2: 16023
    V3: 13127
    V4: 15008
tensorflow ec6d17219c fa1db5eb0d
   OLD: 10377
    V0: 10448
    V1: 10377
    V2:  8460
    V3: 10377
    V4: 10377
TypeScript 35ea2bea76 123edced90
   OLD: 3464
    V0: 3439
    V1: 3464
    V2: 3581
    V3: 3464
    V4: 3464

