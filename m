Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77389201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbdBVOHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:40 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33185 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbdBVOHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:38 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so560023pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkYj6brOfFQXA7vrllO/QF7hCdfFvmUVk2srHp0B+fs=;
        b=FjFkrse9bgUZ+zpHyKG6mXgjNeKx8mJWGsGIDOkFAjn1Zn5nzXDXpomWJ9X/6b+6uB
         e6GhYnkQCCZ8xJvwdBrcqiedNyL9y782oia9w0ekOFQxlBJ3UxDzz4W4y050N9JNnLEE
         9sfcvlssVTlG99NDyWNw1yXaM1K/PhGQqjXZN77l/N/8Jn2WOQECJrvBteZq1mKHcccN
         TJWTpEsbdRelGvldnVeo4Jb1nn0B0a2D3mxZxBcgjgLIWXZ0G59WR23PoK50KAHOJNvf
         NPB0vHLTpvApucsaOTyiHVpkRcrKMGgyYn7OT3Slz5lM2CBeFre5Qzuc04wU1UiXU9b4
         fFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkYj6brOfFQXA7vrllO/QF7hCdfFvmUVk2srHp0B+fs=;
        b=X9OICOkO36Q2KXGxkNLmAv7ovStoB/+RLDSMVsx4UAURLhzPOip5FO1FpKJ6puMcwi
         A3c8Aw6s9R9l3erm4IttwM0d1X10xpi9i20feLw+Uw0WP5jiGD6bLQOKSC7kX1FUmr+4
         z2Q2oI5mXd04N1fu6NatbivbK74oX3fdHgzxs1+IQ0pUS6dBPQ8Fj1OvG045JT9jc7G3
         U6zmsS8+bvv58gVW+ZCZnKyHAc1vN9t39gd8n8wipVQZF4ixC32mgw3XaEnS+8srsCci
         12/dHyBbGV9kC/v02ywF85Fn/BuVJ3ltU6Z18Pp4WzbtvPA9G2+WijiXFEXI6q9+ZUaw
         AeaA==
X-Gm-Message-State: AMke39ksGyGGI+fx+e+3s9vz8VIRZjTxFbdPX11BN/vPxpvv7eFBvNPgLqUaNAYIEw04jA==
X-Received: by 10.84.138.165 with SMTP id 34mr48109347plp.37.1487772457401;
        Wed, 22 Feb 2017 06:07:37 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t87sm4094328pfe.59.2017.02.22.06.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:30 +0700
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
Subject: [PATCH v5 16/24] files-backend: replace submodule_allowed check in files_downcast()
Date:   Wed, 22 Feb 2017 21:04:42 +0700
Message-Id: <20170222140450.30886-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend.c is unlearning submodules. Instead of having a specific
check for submodules to see what operation is allowed, files backend
now takes a set of flags at init. Each operation will check if the
required flags is present before performing.

For now we have four flags: read, write and odb access. Main ref store
has all flags, obviously, while submodule stores are read-only and have
access to odb (*).

The "main" flag stays because many functions in the backend calls
frontend ones without a ref store, so these functions always target the
main ref store. Ideally the flag should be gone after ref-store-aware
api is in place and used by backends.

(*) Submodule code needs for_each_ref. Try take REF_STORE_ODB flag
out. At least t3404 would fail. The "have access to odb" in submodule is
a bit hacky since we don't know from he whether add_submodule_odb() has
been called.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 15 ++++++---
 refs/files-backend.c | 86 +++++++++++++++++++++++++++++++++-------------------
 refs/refs-internal.h |  9 +++++-
 3 files changed, 73 insertions(+), 37 deletions(-)

diff --git a/refs.c b/refs.c
index 67acae60c..2dc97891a 100644
--- a/refs.c
+++ b/refs.c
@@ -1416,7 +1416,8 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
  * Create, record, and return a ref_store instance for the specified
  * gitdir.
  */
-static struct ref_store *ref_store_init(const char *gitdir)
+static struct ref_store *ref_store_init(const char *gitdir,
+					unsigned int flags)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
@@ -1425,7 +1426,7 @@ static struct ref_store *ref_store_init(const char *gitdir)
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	refs = be->init(gitdir);
+	refs = be->init(gitdir, flags);
 	return refs;
 }
 
@@ -1436,7 +1437,11 @@ struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	refs = ref_store_init(get_git_dir());
+	refs = ref_store_init(get_git_dir(),
+			      (REF_STORE_READ |
+			       REF_STORE_WRITE |
+			       REF_STORE_ODB |
+			       REF_STORE_MAIN));
 	if (refs) {
 		if (main_ref_store)
 			die("BUG: main_ref_store initialized twice");
@@ -1485,7 +1490,9 @@ struct ref_store *get_ref_store(const char *submodule)
 
 	ret = submodule_to_gitdir(&submodule_sb, submodule);
 	if (!ret)
-		refs = ref_store_init(submodule_sb.buf);
+		/* pretend that add_submodule_odb() has been called */
+		refs = ref_store_init(submodule_sb.buf,
+				      REF_STORE_READ | REF_STORE_ODB);
 	strbuf_release(&submodule_sb);
 
 	if (refs)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 37443369b..474d1027c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -916,6 +916,7 @@ struct packed_ref_cache {
  */
 struct files_ref_store {
 	struct ref_store base;
+	unsigned int store_flags;
 
 	char *gitdir;
 	char *gitcommondir;
@@ -976,13 +977,15 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *gitdir)
+static struct ref_store *files_ref_store_create(const char *gitdir,
+						unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_store_init(ref_store, &refs_be_files);
+	refs->store_flags = flags;
 
 	refs->gitdir = xstrdup(gitdir);
 	get_common_dir_noenv(&sb, gitdir);
@@ -994,13 +997,17 @@ static struct ref_store *files_ref_store_create(const char *gitdir)
 }
 
 /*
- * Die if refs is for a submodule (i.e., not for the main repository).
- * caller is used in any necessary error messages.
+ * Die if refs is not the main ref store. caller is used in any
+ * necessary error messages.
  */
 static void files_assert_main_repository(struct files_ref_store *refs,
 					 const char *caller)
 {
-	/* This function is to be deleted in the next patch */
+	if (refs->store_flags & REF_STORE_MAIN)
+		return;
+
+	die("BUG: unallowed operation (%s), only works "
+	    "on main ref store\n", caller);
 }
 
 /*
@@ -1009,9 +1016,9 @@ static void files_assert_main_repository(struct files_ref_store *refs,
  * files_ref_store is for a submodule (i.e., not for the main
  * repository). caller is used in any necessary error messages.
  */
-static struct files_ref_store *files_downcast(
-		struct ref_store *ref_store, int submodule_allowed,
-		const char *caller)
+static struct files_ref_store *files_downcast(struct ref_store *ref_store,
+					      unsigned int required_flags,
+					      const char *caller)
 {
 	struct files_ref_store *refs;
 
@@ -1021,8 +1028,9 @@ static struct files_ref_store *files_downcast(
 
 	refs = (struct files_ref_store *)ref_store;
 
-	if (!submodule_allowed)
-		files_assert_main_repository(refs, caller);
+	if ((refs->store_flags & required_flags) != required_flags)
+		die("BUG: unallowed operation (%s), requires %x, has %x\n",
+		    caller, required_flags, refs->store_flags);
 
 	return refs;
 }
@@ -1404,7 +1412,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "read_raw_ref");
+		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1821,10 +1829,14 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 static int files_peel_ref(struct ref_store *ref_store,
 			  const char *refname, unsigned char *sha1)
 {
-	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
+			       "peel_ref");
 	int flag;
 	unsigned char base[20];
 
+	files_assert_main_repository(refs, "peel_ref");
+
 	if (current_ref_iter && current_ref_iter->refname == refname) {
 		struct object_id peeled;
 
@@ -1929,21 +1941,23 @@ static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
 		const char *prefix, unsigned int flags)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "ref_iterator_begin");
+	struct files_ref_store *refs;
 	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 
-	if (!refs)
-		return empty_ref_iterator_begin();
-
 	if (ref_paranoia < 0)
 		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
 	if (ref_paranoia)
 		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
 
+	refs = files_downcast(ref_store,
+			      REF_STORE_READ | (ref_paranoia ? 0 : REF_STORE_ODB),
+			      "ref_iterator_begin");
+	if (!refs)
+		return empty_ref_iterator_begin();
+
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
@@ -2424,7 +2438,8 @@ static void prune_refs(struct ref_to_prune *r)
 static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "pack_refs");
+		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
+			       "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
@@ -2503,7 +2518,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_refs");
+		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
@@ -2607,7 +2622,7 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 					  struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "verify_refname_available");
+		files_downcast(ref_store, REF_STORE_READ, "verify_refname_available");
 	struct ref_dir *packed_refs = get_packed_refs(refs);
 	struct ref_dir *loose_refs = get_loose_refs(refs);
 
@@ -2632,7 +2647,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			    const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "rename_ref");
+		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -2875,7 +2890,7 @@ static int files_create_reflog(struct ref_store *ref_store,
 			       struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_reflog");
+		files_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
 	int fd;
 
 	if (log_ref_setup(refs, refname, force_create, &fd, err))
@@ -3119,7 +3134,7 @@ static int files_create_symref(struct ref_store *ref_store,
 			       const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_symref");
+		files_downcast(ref_store, REF_STORE_WRITE, "create_symref");
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
@@ -3145,7 +3160,9 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_main_ref_store(), 0, "set_head_symref");
+		files_downcast(get_main_ref_store(),
+			       REF_STORE_WRITE,
+			       "set_head_symref");
 
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
@@ -3184,7 +3201,7 @@ static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_exists");
+		files_downcast(ref_store, REF_STORE_READ, "reflog_exists");
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	int ret;
@@ -3199,7 +3216,7 @@ static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_reflog");
+		files_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
@@ -3254,7 +3271,8 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					     void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
+		files_downcast(ref_store, REF_STORE_READ,
+			       "for_each_reflog_ent_reverse");
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
@@ -3362,7 +3380,8 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 				     each_reflog_ent_fn fn, void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent");
+		files_downcast(ref_store, REF_STORE_READ,
+			       "for_each_reflog_ent");
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
@@ -3450,7 +3469,8 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_iterator_begin");
+		files_downcast(ref_store, REF_STORE_READ,
+			       "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
@@ -3788,7 +3808,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 				    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "ref_transaction_commit");
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -3993,7 +4014,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 					    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "initial_ref_transaction_commit");
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -4115,7 +4137,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			       void *policy_cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_expire");
+		files_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -4221,7 +4243,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "init_db");
+		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
 	/*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dfa181792..0cca280b5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -481,12 +481,19 @@ struct ref_store;
 
 /* refs backends */
 
+/* ref_store_init flags */
+#define REF_STORE_READ		(1 << 0)
+#define REF_STORE_WRITE		(1 << 1) /* can perform update operations */
+#define REF_STORE_ODB		(1 << 2) /* has access to object database */
+#define REF_STORE_MAIN		(1 << 3)
+
 /*
  * Initialize the ref_store for the specified gitdir. These functions
  * should call base_ref_store_init() to initialize the shared part of
  * the ref_store and to record the ref_store for later lookup.
  */
-typedef struct ref_store *ref_store_init_fn(const char *gitdir);
+typedef struct ref_store *ref_store_init_fn(const char *gitdir,
+					    unsigned int flags);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
-- 
2.11.0.157.gd943d85

