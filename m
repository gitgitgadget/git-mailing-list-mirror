Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A458620193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbcIDQMC (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:02 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54561 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754345AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 1207440d-bf7ff700000008af-26-57cc474d9f83
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id A5.86.02223.D474CC75; Sun,  4 Sep 2016 12:09:49 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5q026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:48 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 30/38] files_ref_iterator_begin(): take a ref_store argument
Date:   Sun,  4 Sep 2016 18:08:36 +0200
Message-Id: <0437f726a01114dce8e4d6871d51458277356b32.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqOvrfibcoK9HxaLrSjeTRUPvFWaL
        2yvmM1ssefia2aJ7yltGix8tPcwWM69aW5x508jowOHx9/0HJo+ds+6ye3S1H2HzeNa7h9Hj
        4iVlj/1Lt7F5LH7g5fF5k1wARxSXTUpqTmZZapG+XQJXxu8JU1gLVgtXrFnzn62B8S5/FyMn
        h4SAicS8hrMsXYxcHEICWxklVh7uZoVwTjJJ7Dy5lRGkik1AV2JRTzMTiC0ioCYxse0QWAcz
        SNGsiTPZQRLCAv4SD1q/s4HYLAKqEs//XQOL8wpESbTuP8EKsU5O4tK2L8wgNqeAhcSZ3XOB
        bA6gbeYS7S+yJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mil5pSuokREnK8
        Oxj/r5M5xCjAwajEw2uhfSZciDWxrLgy9xCjJAeTkijvrIMnw4X4kvJTKjMSizPii0pzUosP
        MUpwMCuJ8Gq7AJXzpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4r7sC
        NQoWpaanVqRl5pQgpJk4OEGG8wANvwlSw1tckJhbnJkOkT/FqCglzvsSJCEAksgozYPrhaWE
        V4ziQK8I8yq6AVXxANMJXPcroMFMQIPX7T4NMrgkESEl1cA4PzJ9w7Mk35OLV6n4tx/f9tPx
        f9Lqrv+72OalH+Ti+T1l4dqjH9K1tBbZfGBU7OxYGjB72ytTzymnV76dvfBzdb5al2H/vtXR
        B2fYnFG/HDTxFKPypSkeGvcq5pcXnhcW62RIl2ZNcjSunm/lrOkVxOYhovJh5tRXR1+b74tn
        Tf3AN+HwtxMZSizFGYmGWsxFxYkAuCuskeQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 2 +-
 refs/files-backend.c | 4 ++--
 refs/refs-internal.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index f10f86a..d00126b 100644
--- a/refs.c
+++ b/refs.c
@@ -1157,7 +1157,7 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = files_ref_iterator_begin(submodule, prefix, flags);
+	iter = files_ref_iterator_begin(refs, prefix, flags);
 	iter = prefix_ref_iterator_begin(iter, prefix, trim);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3a0db5a..f521b5d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1863,11 +1863,11 @@ static struct ref_iterator_vtable files_ref_iterator_vtable = {
 };
 
 struct ref_iterator *files_ref_iterator_begin(
-		const char *submodule,
+		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(submodule, "ref_iterator_begin");
+		files_downcast(ref_store, 1, "ref_iterator_begin");
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 84c81ad..0af1079 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -404,13 +404,15 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
 					       int trim);
 
+struct ref_store;
+
 /*
  * Iterate over the packed and loose references in the specified
- * submodule that are within find_containing_dir(prefix). If prefix is
+ * ref_store that are within find_containing_dir(prefix). If prefix is
  * NULL or the empty string, iterate over all references in the
  * submodule.
  */
-struct ref_iterator *files_ref_iterator_begin(const char *submodule,
+struct ref_iterator *files_ref_iterator_begin(struct ref_store *ref_store,
 					      const char *prefix,
 					      unsigned int flags);
 
@@ -484,8 +486,6 @@ extern struct ref_iterator *current_ref_iter;
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
-struct ref_store;
-
 /* refs backends */
 
 /*
-- 
2.9.3

