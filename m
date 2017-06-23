Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C768920401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbdFWHCz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:55 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62625 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754155AbdFWHCr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:47 -0400
X-AuditID: 1207440e-8bfff70000006f9a-e8-594cbd164723
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 09.F0.28570.61DBC495; Fri, 23 Jun 2017 03:02:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o68001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/29] packed_refs_lock(): function renamed from lock_packed_refs()
Date:   Fri, 23 Jun 2017 09:01:41 +0200
Message-Id: <b8e31c58c6096b99eb78cf76c1aad0bd8adcabc0.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCu21yfSYPIyVYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJmbcwseCBbMfe4eQPjU4kuRk4O
        CQETicv3vzF3MXJxCAnsYJJo2fiZEcI5xSSxbeFJFpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXM
        ApOYJd5eWwiWEBYIk3ix7BqYzSKgKtHz8wU7iM0rECWxY9leNoh18hK72i6ygticAhYSPROX
        g9UICZhLrPq9mnUCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGCEh
        x7eDsX29zCFGAQ5GJR7eHee9I4VYE8uKK3MPMUpyMCmJ8mpG+kQK8SXlp1RmJBZnxBeV5qQW
        H2KU4GBWEuHVWQWU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8Iru
        AWoULEpNT61Iy8wpQUgzcXCCDOcBGu6xGWR4cUFibnFmOkT+FKOilDjvht1ACQGQREZpHlwv
        LCW8YhQHekWYNxGkigeYTuC6XwENZgIaPGMN2OCSRISUVAOj51sP6ZXnd07yfMWvdvaKco1T
        Sb208v/4/QZlDFfXMDzjqLoWlZLSZlAT1fo56tSahEyWLbbz9F8YsP6K3SESNH0Dt9WNfCFW
        2b06Ju9/bqznM9gkscDD9qyPTEDYrP7pkwtm5YnO7TweKa6yY81Xuzkbz0289vn5l+j0E5vM
        J8U+7Dj2QLtGiaU4I9FQi7moOBEAFnujxOQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename `lock_packed_refs()` to `packed_refs_lock()` for consistency
with how other methods are named. Also, it's about to get some
companions.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  |  4 ++--
 refs/packed-backend.c | 10 +++++-----
 refs/packed-backend.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2810785efc..88de907148 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1096,7 +1096,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
 
-	lock_packed_refs(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
+	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -2679,7 +2679,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (lock_packed_refs(refs->packed_ref_store, 0)) {
+	if (packed_refs_lock(refs->packed_ref_store, 0)) {
 		strbuf_addf(err, "unable to lock packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 71f92ed6f0..cd214e07a1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -321,7 +321,7 @@ static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
 /*
  * Add or overwrite a reference in the in-memory packed reference
  * cache. This may only be called while the packed-refs file is locked
- * (see lock_packed_refs()). To actually write the packed-refs file,
+ * (see packed_refs_lock()). To actually write the packed-refs file,
  * call commit_packed_refs().
  */
 void add_packed_ref(struct ref_store *ref_store,
@@ -515,11 +515,11 @@ static int write_packed_entry(FILE *fh, const char *refname,
 	return 0;
 }
 
-int lock_packed_refs(struct ref_store *ref_store, int flags)
+int packed_refs_lock(struct ref_store *ref_store, int flags)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
-				"lock_packed_refs");
+				"packed_refs_lock");
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
@@ -567,7 +567,7 @@ static const char PACKED_REFS_HEADER[] =
 /*
  * Write the current version of the packed refs cache from memory to
  * disk. The packed-refs file must already be locked for writing (see
- * lock_packed_refs()). Return zero on success. On errors, rollback
+ * packed_refs_lock()). Return zero on success. On errors, rollback
  * the lockfile, write an error message to `err`, and return a nonzero
  * value.
  */
@@ -698,7 +698,7 @@ int repack_without_refs(struct ref_store *ref_store,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(&refs->base, 0)) {
+	if (packed_refs_lock(&refs->base, 0)) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 3d4057b65b..dbc00d3396 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -9,7 +9,7 @@ struct ref_store *packed_ref_store_create(const char *path,
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
  * errno appropriately and return a nonzero value.
  */
-int lock_packed_refs(struct ref_store *ref_store, int flags);
+int packed_refs_lock(struct ref_store *ref_store, int flags);
 
 void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
-- 
2.11.0

