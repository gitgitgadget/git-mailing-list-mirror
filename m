Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403EF20705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbcGGUMR (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:12:17 -0400
Received: from mout.web.de ([212.227.17.11]:59853 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbcGGUMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:12:16 -0400
Received: from [192.168.178.36] ([79.237.54.245]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MVcdn-1amthA0O8l-00YxZK; Thu, 07 Jul 2016 22:11:59
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] .gitattributes: set file type for C files
Message-ID: <577EB786.7020806@web.de>
Date:	Thu, 7 Jul 2016 22:11:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KSFd+xV5aeZjfh52vQpYUBnWrbETT9mXoCMFlqHnk3DlLEIcgu/
 AfVe5cz0wCsem2kCrl7WZXD//cfW/ewn63PygYA2Q0wpSlkEWMQjhlNi7MOqbvI9p3FQqmc
 07IJTl4Ighx+hkWCO6vhZ7jarFQFKt6h+xiwHTotpgOfaTJpXCmdRmnMUPpF8y5pOi/nDlK
 jikcDyfdwQfNx/Ojw/dvw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:lrki0MCFa8o=:4NnWjKxjoXCPcldPaZO31+
 N5N32BS8h8/yc4tV/DjEFTuZevbzVBIr0Oh65oVqxe8ZWpgS0aW9f3nEcqd/64X0fP8M81HDy
 nnhNcpQS9Iuwjy5s0p9pmR5i67CKzMK0HS5OQ/9/O36WyZhgZhgpAAJLiu5cSB3v3QO81+Pve
 Go0fUqDbACotGIU+lsVNZVT1RoslKI9144yy6YBwmXIb/ywiQKriFISHGzr8Wj8tj3nDQYxLt
 gpfsEtEjUeW8KqBVcKxxwNrZetc4iaGwTf9U1Lb1EEn/KA0MmCg5DsfhAJB/5uZuyPY4UPY2O
 USyyE6j87OEsrmwjVpw4oJobotzIrDUyEGZWS50j5dt3Iv9zIP5aXGB+EfIvvEVZE2jij8Vxs
 wmPUKjhXqPzTOUuyoAQb3yKFKA0F/6YSia9j2NSAl4INodywGr20W9j8l7DnHwlx2w/b5fgrO
 Ck30QaJ3pc3g40lWcMVf2xDLa0usewwqlQ7riqNNj36672a7kK7dJIUSF0wnCEQOW3uY+tj59
 zGBrvEXqCy/NUNINO3/x55U6lwqqFslX7NUI7eWfohKh8zIlfx1VkQgYengBnxz1Nm2a2yn14
 QY41C92qLb70X2tLiP+BWiH21JZwQjkjq4vszW4qWdnK9IEYK2Zgx2FxP6tfldaDP13+kYBUm
 IfZu7FQlDZSMy8rWpMxeTTgGz+YGm37ey2x/ww6FvvUusiSAsAQiakt3w9J4iEWlnlx2YY+9n
 YLSX9hJkGS0bmNgudQdPtrv8v+6Z3SW0Dvr8JTpJiAyiYp1VymO2pS2pLidoaVmIwm1UuafWt
 rxlxEY4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Set the diff attribute for C source file to "cpp" in order to improve
git's ability to determine hunk headers.  In particular it helps avoid
showing unindented labels in hunk headers.  That in turn is useful for
git diff -W and git grep -W, which show whole functions now instead of
stopping at a label.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 5e98806..320e33c 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,3 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space
+*.[ch] whitespace=indent,trail,space diff=cpp
 *.sh whitespace=indent,trail,space
-- 
2.9.0

