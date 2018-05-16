Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E841F406
	for <e@80x24.org>; Wed, 16 May 2018 22:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEPWKl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:10:41 -0400
Received: from avasout04.plus.net ([212.159.14.19]:51310 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPWKl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:10:41 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id J4d4fVHqKI9T1J4d5fFhlq; Wed, 16 May 2018 23:10:40 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=W00TjjkRrrdDMDzCiXoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] shallow: remove unused variable
Message-ID: <ae96f1c4-add2-d9d8-f08b-a765fe277232@ramsayjones.plus.com>
Date:   Wed, 16 May 2018 23:10:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKsYUUP70XsShE8xWbFn+MpgZxGGWYM86hF41OTFVLz3jojQSYtyjb0IcZWMZ++8HuQmtZZtq8E9TvFNRcWQ5KyPkO8odqDCV9+IsY3z3SAs1A2qrDRL
 kR/393bivtvAfUyfeyDM/ID/VyuaGc+pNO9htbgxFMhbKJcXrkomhoWGFdjdkeLDwP8wjzeFYuCw7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/object-store-grafts' branch, could
you please squash this into the relevant patch (whichever one that
would be)! ;-)

I have not looked to see which patch needs to change (just being
lazy, sorry!), but this variable was introduced by commit d73b49b707
("shallow: migrate shallow information into the object parser", 2018-05-15).

That commit seems to rename the 'shallow_stat' symbol to the 'the_repository_shallow_stat' symbol, but at the same time adds an 'shallow_stat' field to the parsed_object_pool struct, so ... :(

Thanks!

ATB,
Ramsay Jones

 shallow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 74bc78801..51447608a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -17,8 +17,6 @@
 #include "commit-slab.h"
 #include "repository.h"
 
-struct stat_validity the_repository_shallow_stat;
-
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
 	if (r->parsed_objects->is_shallow != -1)
-- 
2.17.0
