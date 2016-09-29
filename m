Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582BB207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 15:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755072AbcI2P3p (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 11:29:45 -0400
Received: from mout.web.de ([212.227.15.4]:64436 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754639AbcI2P3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 11:29:43 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MgOUY-1bbw9P3Yes-00NezO; Thu, 29 Sep 2016 17:29:37
 +0200
Subject: [PATCH 3/3] remove unnecessary check before QSORT
To:     Git List <git@vger.kernel.org>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <51040709-64da-37bf-b5b4-0228e2be51b4@web.de>
Date:   Thu, 29 Sep 2016 17:29:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hum6vAUERDV59Mj2AiMVnxx4s8KOpzFjyORyfGnP+Mr4HLe2cX1
 oGz8PgkRihndpkOqrO43JPvWB9+NEuoGlVh+BuC7seMtIuQ7POfdnhJGfgyzf8z3RZ2YqLQ
 YEkSgl4zjeAxWquwJFBrYPeTNob9EZQAdQPettJWihYNrB2tvBGtlUvF5OEcKjxeqCc3suw
 KwU1bpWdToYDGFYrrz1AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:almnKcdGuGY=:0GMrsnlA4piMtgUveA7j2j
 XhWxgT6UXCHgheL311JjyNejMcgzleacWHTNWdNgus5/Qs3zMIv31jFRtftRlYHB83xYmcCPV
 FbzihCyQRphV5cNrvm3rZ0N9bOJlQHhr1cMo7O+kMJFGrfVN6FCE1E3jNfM75Vh+wMkFH+6Ia
 +2eZmYxiv94CbB4UX1SSRtPlSEDirpfjB1vH5u/Z+LrLxsnfHkPwhNVLdfVAXyQXj2Tf12ovL
 /zui/8MBadA7QcYlzoWNyOhiy7Ax1CISRMNu512INluW8yrKu4e5+muTiLypHoyMYG2rFZ5cN
 7ZzMlYzliogT32TBwRTH/9cRNYQd2Rx/jLOV5Q0698A3NzxFFy3j0cX1U8+Y5uj0cGkt3udy0
 1fYgYSn2gF3JoLm9zL94YQuj61ZYYN+/VrzxTnZPWbbnZ580MucekjA2NCybNizhs3NcFXznT
 4QEBm1ZzPE/LiHj63aT+LywF8xOyukwM6Ap44N5TwwA3lnISuTHGjZn3IeR37/bf5MdTAV26p
 sMdXkMu41L32EBYQkdfyvznu/rLMEdG8gaWXNG+ZR2QGgtQ1XhqxBWrAnBv+LItzPctDtxx90
 9t12uhH95MNd3ckA8vF4xeRui6TVHTOX2mnnSR+5oCokI7cjM3SHjlnGnaJuauAdlL2Kwkoul
 CLVJ2hDeR2p4gWxbVRF7S2pqzDdE9xvsD+IMTt0IltKcx8oSpHdmdlzrFFJ8zoC3QtL7ySiUb
 0s1irzGU7EMUT2unDhzC68KQUkEVvv47dCRskKQdfI6RuH8uyYwheMBz8n3FA1eTU2R9G4pVV
 vC1iyP8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch for removing checks similar to the one that QSORT
already does internally and apply it to the code base.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fmt-merge-msg.c        | 10 ++++------
 contrib/coccinelle/qsort.cocci | 18 ++++++++++++++++++
 sh-i18n--envsubst.c            |  3 +--
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4976967..efab62f 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -314,12 +314,10 @@ static void add_people_info(struct strbuf *out,
 			    struct string_list *authors,
 			    struct string_list *committers)
 {
-	if (authors->nr)
-		QSORT(authors->items, authors->nr,
-		      cmp_string_list_util_as_integral);
-	if (committers->nr)
-		QSORT(committers->items, committers->nr,
-		      cmp_string_list_util_as_integral);
+	QSORT(authors->items, authors->nr,
+	      cmp_string_list_util_as_integral);
+	QSORT(committers->items, committers->nr,
+	      cmp_string_list_util_as_integral);
 
 	credit_people(out, authors, 'a');
 	credit_people(out, committers, 'c');
diff --git a/contrib/coccinelle/qsort.cocci b/contrib/coccinelle/qsort.cocci
index a094e7c..22b93a9 100644
--- a/contrib/coccinelle/qsort.cocci
+++ b/contrib/coccinelle/qsort.cocci
@@ -17,3 +17,21 @@ expression nmemb, compar;
 @@
 - qsort(base, nmemb, sizeof(T), compar);
 + QSORT(base, nmemb, compar);
+
+@@
+expression base, nmemb, compar;
+@@
+- if (nmemb)
+    QSORT(base, nmemb, compar);
+
+@@
+expression base, nmemb, compar;
+@@
+- if (nmemb > 0)
+    QSORT(base, nmemb, compar);
+
+@@
+expression base, nmemb, compar;
+@@
+- if (nmemb > 1)
+    QSORT(base, nmemb, compar);
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 3637a2a..c3a2b5a 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -230,8 +230,7 @@ cmp_string (const void *pstr1, const void *pstr2)
 static inline void
 string_list_sort (string_list_ty *slp)
 {
-  if (slp->nitems > 0)
-    QSORT(slp->item, slp->nitems, cmp_string);
+  QSORT(slp->item, slp->nitems, cmp_string);
 }
 
 /* Test whether a sorted string list contains a given string.  */
-- 
2.10.0

