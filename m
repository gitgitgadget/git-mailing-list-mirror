Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A97C1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfAQBOi (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:14:38 -0500
Received: from avasout05.plus.net ([84.93.230.250]:40588 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfAQBOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:14:38 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 20:14:37 EST
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id jw99gjxra52tXjw9Ag8qpt; Thu, 17 Jan 2019 01:07:06 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=c9mFvy1l c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=rDwNCPTlXx4RAHM9DZsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] repository.c: fix sparse warning
Message-ID: <419519f9-1b48-93bb-eead-eacf6b383f70@ramsayjones.plus.com>
Date:   Thu, 17 Jan 2019 01:07:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO1Ak27XWBT492zzGHmlK/Q+hfWo68dNEx4J8oKZWSUdbx5OWwUWnafTT8fFR7YhMz7CTT+j5ddvXk63ClOzHPuYRS8TFBvhs2HqHbyXFtVt20ECjr8I
 YJ63lxG2tavKwbU3+9PF+1+qhMnwxM9+LiG9jvg/X2GHXyphxHIXVs+KB2e806nqBrTWja9iJKnltA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/the-index-final' branch, could you
please squash this into the relevant patch (commit 4478671442,
"cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch", 2019-01-12).

[the warning is caused by the lack of the extern declaration of the
'the_index' symbol.]

Thanks!

ATB,
Ramsay Jones

 repository.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/repository.c b/repository.c
index 0c6814627e..3ecbb1b6e3 100644
--- a/repository.c
+++ b/repository.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "repository.h"
 #include "object-store.h"
-- 
2.20.0
