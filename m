Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405A120401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdFOOr7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:47:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63420 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752483AbdFOOr5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:47:57 -0400
X-AuditID: 1207440e-20fff70000000c7e-19-59429e12d5cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.56.03198.21E92495; Thu, 15 Jun 2017 10:47:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbQu014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/28] packed_ref_store: new struct
Date:   Thu, 15 Jun 2017 16:47:07 +0200
Message-Id: <f15a626f80ccddbdeceb01438e02d61dd8483275.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqCs0zynSYNEdSYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDI2nFjJXrBRumLdy1mMDYyvxboY
        OTkkBEwk7s9fw9jFyMUhJLCDSWL76vlMEM5JJolzk1pZQarYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWMBYYkLjL3YQm0VAVWLK9TtgNq9AlMSGN+uYINbJS+xquwg2lFPAQmL2
        l3XMXYwcQNvMJY4t15jAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukm
        RkjQ8e1gbF8vc4hRgINRiYdXocEpUog1say4MvcQoyQHk5IoL78cUIgvKT+lMiOxOCO+qDQn
        tfgQowQHs5II79Q5QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSv
        8VygRsGi1PTUirTMnBKENBMHJ8hwHqDhf8GGFxck5hZnpkPkTzEqSonzeoAkBEASGaV5cL2w
        pPCKURzoFWHeeSBVPMCEAtf9CmgwE9DgoAsOIINLEhFSUg2MCw80TNnFMWlCzmm37e49P0Rl
        Vp2JVXBReLfChyGE9VnJ/0luCVflu/9/LV6a8aE3Rb7eZ8nFTV7e3Z810qcH68Y67ni6VqGj
        +LfGygL76PRHgma/D8pWRLiv1L7jJBjkGBEY1s6kJ3gl+NqDhsjI+X16+wJ57SVv+euXrzoa
        /czO6prnuxtKLMUZiYZazEXFiQAy4qr15QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start extracting the packed-refs-related data structures into a new
class, `packed_ref_store`. It doesn't yet implement `ref_store`, but
it will.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 87cecde231..2efb71cee9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -47,6 +47,28 @@ struct packed_ref_cache {
 	struct stat_validity validity;
 };
 
+/*
+ * A container for `packed-refs`-related data. It is not (yet) a
+ * `ref_store`.
+ */
+struct packed_ref_store {
+	unsigned int store_flags;
+
+	/*
+	 * A cache of the values read from the `packed-refs` file, if
+	 * it might still be current; otherwise, NULL.
+	 */
+	struct packed_ref_cache *cache;
+};
+
+static struct packed_ref_store *packed_ref_store_create(unsigned int store_flags)
+{
+	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
+
+	refs->store_flags = store_flags;
+	return refs;
+}
+
 /*
  * Future: need to be in "struct repository"
  * when doing a full libification.
@@ -60,13 +82,14 @@ struct files_ref_store {
 	char *packed_refs_path;
 
 	struct ref_cache *loose;
-	struct packed_ref_cache *packed;
 
 	/*
 	 * Lock used for the "packed-refs" file. Note that this (and
 	 * thus the enclosing `files_ref_store`) must not be freed.
 	 */
 	struct lock_file packed_refs_lock;
+
+	struct packed_ref_store *packed_ref_store;
 };
 
 /*
@@ -95,12 +118,12 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 
 static void clear_packed_ref_cache(struct files_ref_store *refs)
 {
-	if (refs->packed) {
-		struct packed_ref_cache *packed_refs = refs->packed;
+	if (refs->packed_ref_store->cache) {
+		struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
 
 		if (is_lock_file_locked(&refs->packed_refs_lock))
 			die("BUG: packed-ref cache cleared while locked");
-		refs->packed = NULL;
+		refs->packed_ref_store->cache = NULL;
 		release_packed_ref_cache(packed_refs);
 	}
 }
@@ -132,6 +155,7 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
 	refs->packed_refs_path = strbuf_detach(&sb, NULL);
+	refs->packed_ref_store = packed_ref_store_create(flags);
 
 	return ref_store;
 }
@@ -375,8 +399,8 @@ static void files_ref_path(struct files_ref_store *refs,
  */
 static void validate_packed_ref_cache(struct files_ref_store *refs)
 {
-	if (refs->packed &&
-	    !stat_validity_check(&refs->packed->validity,
+	if (refs->packed_ref_store->cache &&
+	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
 				 files_packed_refs_path(refs)))
 		clear_packed_ref_cache(refs);
 }
@@ -396,10 +420,10 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		validate_packed_ref_cache(refs);
 
-	if (!refs->packed)
-		refs->packed = read_packed_refs(packed_refs_file);
+	if (!refs->packed_ref_store->cache)
+		refs->packed_ref_store->cache = read_packed_refs(packed_refs_file);
 
-	return refs->packed;
+	return refs->packed_ref_store->cache;
 }
 
 static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
-- 
2.11.0

