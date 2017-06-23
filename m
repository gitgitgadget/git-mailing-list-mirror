Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0269A20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754634AbdFWHCQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:16 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58773 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754626AbdFWHCO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:14 -0400
X-AuditID: 12074413-b2dff700000069ec-90-594cbce95c8b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 51.53.27116.9ECBC495; Fri, 23 Jun 2017 03:02:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5m001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/29] packed_ref_store: new struct
Date:   Fri, 23 Jun 2017 09:01:21 +0200
Message-Id: <5e1a4c206e0558ff3f2e87f5a007700c4fd6a9ba.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPtqj0+kwcweNYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDI2nFjJXrBRumLdy1mMDYyvxboY
        OTkkBEwkOp/eZu5i5OIQEtjBJPFt4mQmCOcUk8THv8+ZQKrYBHQlFvU0g9kiAmoSE9sOsYAU
        MQtMYpZ4e20hWEJYwEziycnD7CA2i4CqxM9L29lAbF6BKImLZx8yQ6yTl9jVdpEVxOYUsJDo
        mbgcrF5IwFxi1e/VrBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3E
        CAk74R2Mu07KHWIU4GBU4uFNOOsdKcSaWFZcmXuIUZKDSUmUVzPSJ1KILyk/pTIjsTgjvqg0
        J7X4EKMEB7OSCK/OKqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC
        VxQYX0KCRanpqRVpmTklCGkmDk6Q4TxAwz02gwwvLkjMLc5Mh8ifYlSUEufdsBsoIQCSyCjN
        g+uFpYVXjOJArwjzJoJU8QBTClz3K6DBTECDZ6wBG1ySiJCSamCcWxJ/rK3yoaDmxh3d1zqY
        2taEGSzh2HjyG0u9ztY962od3YLY8pa92TD/g+H6U27dyY8vr+SV7Fi/2+uWsKbeFDMbU08B
        bv7ZZm+WtZksd+Xw7gi9yjS/TNfRP3Cj+7cmP5ZZb6Mnz2G+prZ6wRXbu5c70g+7pes45WvP
        eazpzhKgu1ZbMFyJpTgj0VCLuag4EQA1nYSZ5gIAAA==
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

