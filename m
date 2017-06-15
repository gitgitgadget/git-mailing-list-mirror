Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6124420401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdFOOsd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:33 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50888 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752693AbdFOOsb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:31 -0400
X-AuditID: 1207440d-7e5ff70000001eab-a3-59429e3da4b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.1A.07851.D3E92495; Thu, 15 Jun 2017 10:48:30 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRG014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/28] packed_refs_lock(): function renamed from lock_packed_refs()
Date:   Thu, 15 Jun 2017 16:47:27 +0200
Message-Id: <fdc991cfb05588fc93778a6ce3df197ac6c95146.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqGs3zynSYPs+fou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDIOT3jPVPBctmLlpR2sDYxPJboY
        OTkkBEwk5s/4ytbFyMUhJLCDSeLP0amMEM5JJomN/0EynBxsAroSi3qamUBsEQE1iYlth1hA
        ipgFJjFLvL22ECwhLBAsceRXGzuIzSKgKrGo6zVYnFcgSqLx2TN2iHXyErvaLrKC2JwCFhKz
        v6xj7mLkANpmLnFsucYERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3
        MUKCjncH4/91MocYBTgYlXh4FRqcIoVYE8uKK3MPMUpyMCmJ8vLLAYX4kvJTKjMSizPii0pz
        UosPMUpwMCuJ8E6dA5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw
        Gs8FahQsSk1PrUjLzClBSDNxcIIM5wEa/hdseHFBYm5xZjpE/hSjopQ4bxZIswBIIqM0D64X
        lhReMYoDvSLM+wWknQeYUOC6XwENZgIaHHTBAWRwSSJCSqqBMVXm8q0A0/d3b2zVjnI5HlW6
        obHOf6PvlkN3vzUfWSZZe5kvVGrSMz8zt9QdXSzGV60D5337WLfFv+7nNId32lYsN29a/rrm
        uLfw+gqVi5PFKoUfKVlcds/c47LAOWvhgkszSiJ2fk+9u137UIPSz6Sijpz/C1huRSvOWXu8
        IuLicav/XWvrzyixFGckGmoxFxUnAgD1MPzN5QIAAA==
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
index 4323394a52..3fc2254e33 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1084,7 +1084,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
 
-	lock_packed_refs(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
+	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -2667,7 +2667,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (lock_packed_refs(refs->packed_ref_store, 0)) {
+	if (packed_refs_lock(refs->packed_ref_store, 0)) {
 		strbuf_addf(err, "unable to lock packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6619052e96..eb9da04576 100644
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

