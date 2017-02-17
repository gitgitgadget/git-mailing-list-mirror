Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E08E20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbdBQOGn (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32964 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934043AbdBQOGm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:06:42 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so5046436pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lpZiqbe6XE1WfcsCqa7xIKI65j7dmiHCh+HUdcHOY4=;
        b=DHRwXlEMFduOVO3UUuEL/PKMmPR65ne5HNbdrL7bxEcyCB+1O8jseAR4FBOFBL2sV3
         pKKbtG+qLz5WnhfY56UoTQtOK1OtAwseVLZn2c+vHaTSHwC0+mMmL/CTveSF51/JXyHr
         kQw1C+zVrTa77ZWPcG3P4f9XrF/tjmTzLlxclOb7CauMRnRfnq7zlKk11/G10WjX+syV
         PLApmoU19ZtOQ62Hf5xeM+SjK8wsP41AfpB3b0NdsPlAXOJnRNCG01Cd9oTMeCJoZJ/W
         Yye5LQBQIKfF28Z/bKKKErhp4YOD34FgAv+/vAx0RzcFCVVGId7+/ilgWMNKUlhN/xj9
         eE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lpZiqbe6XE1WfcsCqa7xIKI65j7dmiHCh+HUdcHOY4=;
        b=c6b/9OfgHb08yQAK8nFx+FepLeT2idNxtGJMCuDZb2MMJtEE6JIoOYg68cFrK3Mnis
         hbac/41ZoCCel47cd93dOSbmgUzK0a1ZfnPc3vzrzw/OHLrXNzdSZ7TZmkX6vitAc/YL
         Ucfd77SXZpiKmPtLKgogvITiXUazcJlCVFywSRMqZFi8fHYbB9r3KyBBiwpE16aTI80c
         mIyb2jOK1/dS9EN1oi6IKWwRwbq9AeWmPCP8ZBH5S0dQz3LbkQmHS5GqA8HZhNy5fp9F
         5TE2qUUzSlAXMzmE+AQplVr6GVQ2oraEQo720xryVxdikybbsxxAUlSMMNhXB1nMP7A2
         CweQ==
X-Gm-Message-State: AMke39mhrrQb0mpSDCKdhbDeaJ9Qj3V87NK2lqKM4fxh8LHDo4i0JFmG43Xv3MQMF9A/DA==
X-Received: by 10.99.115.12 with SMTP id o12mr10180718pgc.165.1487340401291;
        Fri, 17 Feb 2017 06:06:41 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id y5sm4074325pgy.28.2017.02.17.06.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:06:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:06:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 15/16] files-backend: remove submodule_allowed from files_downcast()
Date:   Fri, 17 Feb 2017 21:04:35 +0700
Message-Id: <20170217140436.17336-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since submodule or not is irrelevant to files-backend after the last
patch, remove the parameter from files_downcast() and kill
files_assert_main_repository().

PS. This implies that all ref operations are allowed for submodules. But
we may need to look more closely to see if that's really true...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 70 ++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 627466043..d35032fcd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1019,24 +1019,13 @@ static struct ref_store *files_ref_store_create(const char *gitdir)
 }
 
 /*
- * Die if refs is for a submodule (i.e., not for the main repository).
- * caller is used in any necessary error messages.
- */
-static void files_assert_main_repository(struct files_ref_store *refs,
-					 const char *caller)
-{
-	/* This function is to be deleted in the next patch */
-}
-
-/*
  * Downcast ref_store to files_ref_store. Die if ref_store is not a
  * files_ref_store. If submodule_allowed is not true, then also die if
  * files_ref_store is for a submodule (i.e., not for the main
  * repository). caller is used in any necessary error messages.
  */
-static struct files_ref_store *files_downcast(
-		struct ref_store *ref_store, int submodule_allowed,
-		const char *caller)
+static struct files_ref_store *files_downcast(struct ref_store *ref_store,
+					      const char *caller)
 {
 	struct files_ref_store *refs;
 
@@ -1046,9 +1035,6 @@ static struct files_ref_store *files_downcast(
 
 	refs = (struct files_ref_store *)ref_store;
 
-	if (!submodule_allowed)
-		files_assert_main_repository(refs, caller);
-
 	return refs;
 }
 
@@ -1384,7 +1370,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "read_raw_ref");
+		files_downcast(ref_store, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1577,7 +1563,6 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	assert(err);
-	files_assert_main_repository(refs, "lock_raw_ref");
 
 	*type = 0;
 
@@ -1801,7 +1786,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 static int files_peel_ref(struct ref_store *ref_store,
 			  const char *refname, unsigned char *sha1)
 {
-	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
+	struct files_ref_store *refs = files_downcast(ref_store, "peel_ref");
 	int flag;
 	unsigned char base[20];
 
@@ -1910,7 +1895,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "ref_iterator_begin");
+		files_downcast(ref_store, "ref_iterator_begin");
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
@@ -2043,7 +2028,6 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	int attempts_remaining = 3;
 	int resolved;
 
-	files_assert_main_repository(refs, "lock_ref_sha1_basic");
 	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2191,8 +2175,6 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	files_assert_main_repository(refs, "lock_packed_refs");
-
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
@@ -2232,8 +2214,6 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	int save_errno = 0;
 	FILE *out;
 
-	files_assert_main_repository(refs, "commit_packed_refs");
-
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 
@@ -2265,8 +2245,6 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 
-	files_assert_main_repository(refs, "rollback_packed_refs");
-
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
@@ -2412,7 +2390,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "pack_refs");
+		files_downcast(ref_store, "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
@@ -2445,7 +2423,6 @@ static int repack_without_refs(struct files_ref_store *refs,
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
-	files_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
@@ -2513,7 +2490,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_refs");
+		files_downcast(ref_store, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
@@ -2621,7 +2598,7 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 					  struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "verify_refname_available");
+		files_downcast(ref_store, "verify_refname_available");
 	struct ref_dir *packed_refs = get_packed_refs(refs);
 	struct ref_dir *loose_refs = get_loose_refs(refs);
 
@@ -2646,7 +2623,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			    const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "rename_ref");
+		files_downcast(ref_store, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -2868,7 +2845,7 @@ static int files_create_reflog(struct ref_store *ref_store,
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_reflog");
+		files_downcast(ref_store, "create_reflog");
 
 	ret = log_ref_setup(refs, refname, &sb, err, force_create);
 	strbuf_release(&sb);
@@ -3006,8 +2983,6 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	files_assert_main_repository(refs, "commit_ref_update");
-
 	clear_loose_ref_cache(refs);
 	if (log_ref_write(refs, lock->ref_name, lock->old_oid.hash,
 			  sha1, logmsg, 0, err)) {
@@ -3116,7 +3091,7 @@ static int files_create_symref(struct ref_store *ref_store,
 			       const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_symref");
+		files_downcast(ref_store, "create_symref");
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
@@ -3142,7 +3117,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
+		files_downcast(get_ref_store(NULL), "set_head_symref");
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
@@ -3180,7 +3155,7 @@ static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_exists");
+		files_downcast(ref_store, "reflog_exists");
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	int ret;
@@ -3195,7 +3170,7 @@ static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_reflog");
+		files_downcast(ref_store, "delete_reflog");
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
@@ -3250,7 +3225,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					     void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
+		files_downcast(ref_store, "for_each_reflog_ent_reverse");
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
@@ -3358,7 +3333,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 				     each_reflog_ent_fn fn, void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent");
+		files_downcast(ref_store, "for_each_reflog_ent");
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
@@ -3446,7 +3421,7 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_iterator_begin");
+		files_downcast(ref_store, "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
@@ -3658,8 +3633,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	int ret;
 	struct ref_lock *lock;
 
-	files_assert_main_repository(refs, "lock_ref_for_update");
-
 	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 		update->flags |= REF_DELETING;
 
@@ -3784,7 +3757,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 				    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "ref_transaction_commit");
+		files_downcast(ref_store, "ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -3958,7 +3931,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 					    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "initial_ref_transaction_commit");
+		files_downcast(ref_store, "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -4080,7 +4053,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			       void *policy_cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_expire");
+		files_downcast(ref_store, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -4185,8 +4158,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "init_db");
+	struct files_ref_store *refs = files_downcast(ref_store, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
 	/*
-- 
2.11.0.157.gd943d85

