Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378151F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbcIDQLv (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:11:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56457 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754128AbcIDQLt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:49 -0400
X-AuditID: 12074411-a07ff70000000932-8f-57cc474f5ead
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id B0.ED.02354.F474CC75; Sun,  4 Sep 2016 12:09:51 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5r026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:49 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 31/38] refs: add method iterator_begin
Date:   Sun,  4 Sep 2016 18:08:37 +0200
Message-Id: <61aae94372a352f6048ea22132ec78d5891f41a0.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqOvvfibcoP+zmEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujKaTv5kK5ktVnDq/hrWBcaFoFyMn
        h4SAicSUmzdYQGwhga2MEnfbtLsYuYDsk0wSLy+sZANJsAnoSizqaWYCsUUE1CQmth1iASli
        BimaNXEmexcjB4ewgKXEyTdJIDUsAqoSc/dOYwWxeQWiJHZsmcsMsUxO4tK2L2A2p4CFxJnd
        IHEOoGXmEu0vsicw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJu
        gjsYZ5yUO8QowMGoxMM7QfdMuBBrYllxZe4hRkkOJiVR3lkHT4YL8SXlp1RmJBZnxBeV5qQW
        H2KU4GBWEuHVdgEq501JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8Ea5
        ATUKFqWmp1akZeaUIKSZODhBhvMADe8DqeEtLkjMLc5Mh8ifYlSUEud96QqUEABJZJTmwfXC
        0sErRnGgV4R5E0DaeYCpBK77FdBgJqDB63afBhlckoiQkmpgdK9S7gvRyFLeVWvxvrB3+dT/
        qifNj91rPMVyMOanxMHl1sdF/lb9c3aIvZPmaDcxs8FBft6L26/4n56/seylVPf0+p3WwTWX
        NsVv9rR1eDrVe8Yd6frt1/lD3nyKqz45zfPypUaj6nWTmA6ri8Uv+j7nhfEXx6kierIXiswN
        fu60f+7s16dpr8RSnJFoqMVcVJwIAI4lgcjiAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               |  2 +-
 refs/files-backend.c |  3 ++-
 refs/refs-internal.h | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index d00126b..798b08a 100644
--- a/refs.c
+++ b/refs.c
@@ -1157,7 +1157,7 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = files_ref_iterator_begin(refs, prefix, flags);
+	iter = refs->be->iterator_begin(refs, prefix, flags);
 	iter = prefix_ref_iterator_begin(iter, prefix, trim);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f521b5d..4451e13 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1862,7 +1862,7 @@ static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	files_ref_iterator_abort
 };
 
-struct ref_iterator *files_ref_iterator_begin(
+static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags)
 {
@@ -4054,6 +4054,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 
+	files_ref_iterator_begin,
 	files_read_raw_ref,
 	files_verify_refname_available
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0af1079..5be62a2 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -404,18 +404,6 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 					       const char *prefix,
 					       int trim);
 
-struct ref_store;
-
-/*
- * Iterate over the packed and loose references in the specified
- * ref_store that are within find_containing_dir(prefix). If prefix is
- * NULL or the empty string, iterate over all references in the
- * submodule.
- */
-struct ref_iterator *files_ref_iterator_begin(struct ref_store *ref_store,
-					      const char *prefix,
-					      unsigned int flags);
-
 /*
  * Iterate over the references in the main ref_store that have a
  * reflog. The paths within a directory are iterated over in arbitrary
@@ -488,6 +476,8 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 /* refs backends */
 
+struct ref_store;
+
 /*
  * Initialize the ref_store for the specified submodule, or for the
  * main repository if submodule == NULL. These functions should call
@@ -509,6 +499,15 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *logmsg);
 
 /*
+ * Iterate over the references in the specified ref_store that are
+ * within find_containing_dir(prefix). If prefix is NULL or the empty
+ * string, iterate over all references in the submodule.
+ */
+typedef struct ref_iterator *ref_iterator_begin_fn(
+		struct ref_store *ref_store,
+		const char *prefix, unsigned int flags);
+
+/*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
  *
@@ -566,6 +565,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 
+	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
 };
-- 
2.9.3

