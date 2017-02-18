Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73148201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdBRNfF (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:35:05 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35296 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdBRNfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:35:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so160119pgz.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQIxpLSEYxqiiS7OmWk9V8V2Qj6QZUFLvk+/sm1xnzQ=;
        b=O8l7RVOZ6hLIq3diVct2crx22HVAxIiiJ9h8tQCcP8LUaHmakTph/7J7Ttqq0IZCWM
         ADn8hBbZB2J8NX3A/s0RhyD3pbWyVYhG8lIcXmNLeh7vQq4vyzl9QkW0yu/mFaQrxfgj
         M2QeOUm0YtEWDGzKpCQyKTOY1FSM3wqOnZ8NzVni6yzApvv7jZaGunOJxIctiwIs7lpQ
         PuX656o+1eKVJkREb67xqyw3hf8Wwde5pshbK3z0LSl8EI3tj300HpaCxcAg5DxoSghP
         nBwgQO4OmUv5wxhd9dTxMWeNwuwMZMhtvMR3JWYLKF9m92aAus7e1Tp6PYMj1M0ep/VB
         rMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQIxpLSEYxqiiS7OmWk9V8V2Qj6QZUFLvk+/sm1xnzQ=;
        b=quZIP4JOxHJfvlpgHpKxY7dJRhB9oW07DL3cW1KN3c1clW5QYLCHaRNlWdGzLEMfQ7
         xc3TF2waXxhC89g5y715voV8bX79vW8r4kDm4DUssAxF57tWiNlGMciVsjNyfC0eZxxO
         7qIrAqkVB3rnCoIsr6k9YINeDarXLF8CKnEV75RqENEKLwb2Xo58YmOanopEBFxGC2qC
         CxaFKUkXxAnzqYRN0VWhaF9ZezB4qNx7RAlFrSf5hv1VTKZAdGGSxNUDHe9mki+OmgCO
         9CGmEaXmkUjOusNxCAuVYpdcya+PC4KevS5rZWIx24lcxxS//zOJUSEcHfWfssLfD59i
         UOpw==
X-Gm-Message-State: AMke39lnAosJ/aaRHgQ9S8l2b6CEZxXLib06FY7RpGM240ugMH8bQVsEq1aAdjKkTkoZGA==
X-Received: by 10.98.198.90 with SMTP id m87mr14990747pfg.153.1487424904060;
        Sat, 18 Feb 2017 05:35:04 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m29sm25523254pfi.54.2017.02.18.05.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:35:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:57 +0700
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
Subject: [PATCH v4 14/15] files-backend: remove submodule_allowed from files_downcast()
Date:   Sat, 18 Feb 2017 20:33:02 +0700
Message-Id: <20170218133303.3682-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
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
index 529c80af1..b8ccf4e47 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1030,24 +1030,13 @@ static struct ref_store *files_ref_store_create(const char *gitdir)
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
 
@@ -1057,9 +1046,6 @@ static struct files_ref_store *files_downcast(
 
 	refs = (struct files_ref_store *)ref_store;
 
-	if (!submodule_allowed)
-		files_assert_main_repository(refs, caller);
-
 	return refs;
 }
 
@@ -1395,7 +1381,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "read_raw_ref");
+		files_downcast(ref_store, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1588,7 +1574,6 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	assert(err);
-	files_assert_main_repository(refs, "lock_raw_ref");
 
 	*type = 0;
 
@@ -1812,7 +1797,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 static int files_peel_ref(struct ref_store *ref_store,
 			  const char *refname, unsigned char *sha1)
 {
-	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
+	struct files_ref_store *refs = files_downcast(ref_store, "peel_ref");
 	int flag;
 	unsigned char base[20];
 
@@ -1921,7 +1906,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "ref_iterator_begin");
+		files_downcast(ref_store, "ref_iterator_begin");
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
@@ -2059,7 +2044,6 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
 
-	files_assert_main_repository(refs, "lock_ref_sha1_basic");
 	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2184,8 +2168,6 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	files_assert_main_repository(refs, "lock_packed_refs");
-
 	if (!timeout_configured) {
 		git_config_get_int("core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
@@ -2225,8 +2207,6 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	int save_errno = 0;
 	FILE *out;
 
-	files_assert_main_repository(refs, "commit_packed_refs");
-
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 
@@ -2258,8 +2238,6 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 
-	files_assert_main_repository(refs, "rollback_packed_refs");
-
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
@@ -2420,7 +2398,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "pack_refs");
+		files_downcast(ref_store, "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
@@ -2453,7 +2431,6 @@ static int repack_without_refs(struct files_ref_store *refs,
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
-	files_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
@@ -2503,7 +2480,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_refs");
+		files_downcast(ref_store, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
@@ -2615,7 +2592,7 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 					  struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "verify_refname_available");
+		files_downcast(ref_store, "verify_refname_available");
 	struct ref_dir *packed_refs = get_packed_refs(refs);
 	struct ref_dir *loose_refs = get_loose_refs(refs);
 
@@ -2640,7 +2617,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			    const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "rename_ref");
+		files_downcast(ref_store, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -2883,7 +2860,7 @@ static int files_create_reflog(struct ref_store *ref_store,
 			       struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_reflog");
+		files_downcast(ref_store, "create_reflog");
 	int fd;
 
 	if (log_ref_setup(refs, refname, force_create, &fd, err))
@@ -3014,8 +2991,6 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	files_assert_main_repository(refs, "commit_ref_update");
-
 	clear_loose_ref_cache(refs);
 	if (files_log_ref_write(refs, lock->ref_name, lock->old_oid.hash,
 				sha1, logmsg, 0, err)) {
@@ -3124,7 +3099,7 @@ static int files_create_symref(struct ref_store *ref_store,
 			       const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_symref");
+		files_downcast(ref_store, "create_symref");
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
@@ -3150,7 +3125,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
+		files_downcast(get_ref_store(NULL), "set_head_symref");
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
@@ -3188,7 +3163,7 @@ static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_exists");
+		files_downcast(ref_store, "reflog_exists");
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	int ret;
@@ -3203,7 +3178,7 @@ static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_reflog");
+		files_downcast(ref_store, "delete_reflog");
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
@@ -3258,7 +3233,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					     void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
+		files_downcast(ref_store, "for_each_reflog_ent_reverse");
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
@@ -3366,7 +3341,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 				     each_reflog_ent_fn fn, void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent");
+		files_downcast(ref_store, "for_each_reflog_ent");
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
@@ -3454,7 +3429,7 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_iterator_begin");
+		files_downcast(ref_store, "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
@@ -3666,8 +3641,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	int ret;
 	struct ref_lock *lock;
 
-	files_assert_main_repository(refs, "lock_ref_for_update");
-
 	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 		update->flags |= REF_DELETING;
 
@@ -3792,7 +3765,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 				    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "ref_transaction_commit");
+		files_downcast(ref_store, "ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -4000,7 +3973,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 					    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "initial_ref_transaction_commit");
+		files_downcast(ref_store, "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -4122,7 +4095,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			       void *policy_cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_expire");
+		files_downcast(ref_store, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -4227,8 +4200,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "init_db");
+	struct files_ref_store *refs = files_downcast(ref_store, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
 	/*
-- 
2.11.0.157.gd943d85

