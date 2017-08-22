Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,WEIRD_PORT shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B8B208CD
	for <e@80x24.org>; Tue, 22 Aug 2017 05:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdHVFLB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 01:11:01 -0400
Received: from mout.web.de ([217.72.192.78]:49463 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdHVFLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 01:11:00 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetQh-1dD6I01Kd5-00ql6y for
 <git@vger.kernel.org>; Tue, 22 Aug 2017 07:10:59 +0200
Date:   Tue, 22 Aug 2017 07:10:59 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     git@vger.kernel.org
Subject: t5551 hangs ?
Message-ID: <20170822051059.GA26331@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:Y+EmrjkiBDWwfLXSsURm/nEQvCUwPgW4MOHIhYPj3qnf2wUi3Vi
 QhMzQ8ZvZqXpmevordNAoSuG8MhJ2Aj7edJtw/MjT9jxx20TrCTS3l7w5Ao42b9+EyvifDP
 EcCUkuyfszca+Ozno2+FL+4SU4O3JxH1PSEGy6oNyR4Zvn9oApGzfk4Q9hrzMvKJBzkksbJ
 2LOJkXM5EehvxpDNa6YUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HfoEeAUNuzs=:VQvQe4Efkgl6xRI7+nWQec
 QWiEj+TdfqiD+cDqoLAJAeDDMmcbzwjmW/zxPt+NykJRieZKPFgQdQkd+nRvwzB9+o5JEya3u
 I4tNm0L+ga+DAuOo6cSbrtl041OZAQYjLbyk3bVtKADiSYXV+dQ13BirS78o3ueZ0k6I+rL+Z
 1gqfsNUgMs6Ri1LtdKI7HhipV0kVEC7hHqF3jiK4WfrD0ns4wSY5Q2YKt/OttKcJ+I/o/YfiU
 AshNBnaKdI9S77CGPenSIjolKw9KgLjtLDko03y2zlLwUuQAoFcroBwd4UL1XmFpFbHkWJ3Ga
 S98alUxAKHC8zPGwtpc5u5aZ/3+OF8pPWxCzBqZFm0oFbCoMqClGs/9Krs7gXT1IVoyVgsAaj
 M7clXMwUy1cJMBRzYJl6I/O7KbrNPpEkKJUfh/1NAbPoalR5Qk333w0IbvOePXlu83Xhsw+2P
 Dp7r+NnDpZgdg80uLhdGu8cjjlO3EuTJE7gEyjlGIw8g7wYuMmighSNf1m9Scnn6PM0l1Jklo
 Ec3u7Fyr8kMHF87B5cTVfyokeYWOecpLHUEF1rpOju2NxpRURklNBGUk5WCNzl4x5tUahwG1Q
 VMmExJN5N6/rBi8eYbsVdSwdZiwOD/yLWZAx5I4iOj30bOVnYt4RR8Eedq/eB72JlH6eujqGM
 SYtkMUuQegl/0iMv7vEIlJbH5zAsOUdTSNF9yt41N3cph2bdePRerXw6giMOwo/Z0YO4C/M4T
 BqfS1zhpytPiN/7Fn8oLMxsVfeR9P81YFIJiisCdC/6sjieAKEjOr4SzKRMhyYRHXX4hQtn88
 GbjJ9RZt4bCjKvm5Ii+csFYmbFc6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej,
I found 2 threads about hanging t5551, one in 2016, and one question
from Junio somewhen in 2017.
I have it reproducable here:
- Debian 8, 64 bit
- SSD
- Half-modern processor ;-)

The last thing I can see is:
ok 29 - test allowanysha1inwant with unreachable
-----------
A simplified ps -ef shows:
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/usr/sbin/apache2 -d /home/blalbla/t/trash directory.t5551-http-fetch-smart/httpd -f /home/blalbla/t/lib-httpd/apache.conf -c Listen 127.0.0.1:5551 -k start
/home/blalbla/git -C too-many-refs fetch -q --tags
/home/blalbla/git-remote-http origin http://127.0.0.1:5551/smart/repo.git
-------------
The tests passes on another box (real old laptop, spinning disk)

Anything that can be done to debug it ?


