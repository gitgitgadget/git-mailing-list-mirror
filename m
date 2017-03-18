Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA86A2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdCRCQk (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:16:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35328 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdCRCQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:16:38 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so12102809pge.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buuUZQqUwFuHtisB3Syhb/lksH2XzWnUiTKYQRkhEdc=;
        b=EpyPIPdoGLkJY+g4Rj2XMtVfQZufD+hz3Dao25fZ+HWrLAgo6/iX5QH4AGx8xQBhzu
         f3E38dWKBtKFJz8qRUXIWGtyQha8IqQ9++SQrOn62fd9sELdmRVO2LfACIOEGkkB+N+M
         naBXBZWD9WeMAePGy8ZYc6VVcAkJJAWBSzlkdICrOh6AaE1/0nVDKmJ6Q6qKcIUrfNbf
         8/W7uIeVZCzkTm26DwKsB0XxYmcJcITgvqy/u4H+7li+Z4m2ipv0WBmDkKYLjDCEn4/A
         ZqxjLTwe/7FFc0Q5Yr3e9QTyOTHPpgipMoFE9urU/e8LQl9kQh1ivucNzQlaOBUh82yd
         SPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buuUZQqUwFuHtisB3Syhb/lksH2XzWnUiTKYQRkhEdc=;
        b=aTgTNoF7ECNqmxauzHUBvzUMc3fM9AazvTxz7MYnEH34V0qezewh51g3z7cQXK8ajn
         iwn2EbfyPeQnI003SdtpeezZalWNO4NrQF7oOkMV1DX5MSaPOY8oEQWso0XZedImEi6m
         n5U1PdTcy1zQuuhFzehJ6hg6YZkM2McY6QKe0zjbDPFsZb7x4GbUlLXCUnpP+SFnpg8A
         +vIh02wEY2OLvYNIGRxL/uC5nFmG7BJeCs3Lej2i/8iXAakS6Dlitg8Bqr8X/RuLN8bT
         04XELLbqkAHTkrF3gxcGu9gwftS2sCpx11nViSBCu7xg+ua/13WvKb47ivlX2WhK3rsR
         FatQ==
X-Gm-Message-State: AFeK/H21PSmeK3Yo3z4IiQwnoIoNpBHsiPuuRMd3Hiq8wxw+BMyPbLH5y7TkjD+vyJgCwQ==
X-Received: by 10.99.37.199 with SMTP id l190mr19635561pgl.86.1489802754963;
        Fri, 17 Mar 2017 19:05:54 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y5sm19217530pgy.28.2017.03.17.19.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:48 +0700
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
Subject: [PATCH v6 18/27] files-backend: replace submodule_allowed check in files_downcast()
Date:   Sat, 18 Mar 2017 09:03:28 +0700
Message-Id: <20170318020337.22767-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
index fe724869b8..305ab71249 100644
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
 	main_ref_store = refs;
 	return refs;
 }
@@ -1484,7 +1489,9 @@ struct ref_store *get_ref_store(const char *submodule)
 		return NULL;
 	}
 
-	refs = ref_store_init(submodule_sb.buf);
+	/* pretend that add_submodule_odb() has been called */
+	refs = ref_store_init(submodule_sb.buf,
+			      REF_STORE_READ | REF_STORE_ODB);
 	register_submodule_ref_store(refs, submodule);
 
 	strbuf_release(&submodule_sb);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index db335e4ca6..7d8d4dcc16 100644
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
@@ -1398,7 +1406,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 			      struct strbuf *referent, unsigned int *type)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "read_raw_ref");
+		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1815,10 +1823,14 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
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
 
@@ -1923,21 +1935,23 @@ static struct ref_iterator *files_ref_iterator_begin(
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
@@ -2418,7 +2432,8 @@ static void prune_refs(struct ref_to_prune *r)
 static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "pack_refs");
+		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
+			       "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
@@ -2497,7 +2512,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_refs");
+		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
@@ -2601,7 +2616,7 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 					  struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 1, "verify_refname_available");
+		files_downcast(ref_store, REF_STORE_READ, "verify_refname_available");
 	struct ref_dir *packed_refs = get_packed_refs(refs);
 	struct ref_dir *loose_refs = get_loose_refs(refs);
 
@@ -2626,7 +2641,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			    const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "rename_ref");
+		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -2876,7 +2891,7 @@ static int files_create_reflog(struct ref_store *ref_store,
 			       struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_reflog");
+		files_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
 	int fd;
 
 	if (log_ref_setup(refs, refname, force_create, &fd, err))
@@ -3120,7 +3135,7 @@ static int files_create_symref(struct ref_store *ref_store,
 			       const char *logmsg)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "create_symref");
+		files_downcast(ref_store, REF_STORE_WRITE, "create_symref");
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
@@ -3146,7 +3161,9 @@ int set_worktree_head_symref(const char *gitdir, const char *target, const char
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_main_ref_store(), 0, "set_head_symref");
+		files_downcast(get_main_ref_store(),
+			       REF_STORE_WRITE,
+			       "set_head_symref");
 
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
@@ -3185,7 +3202,7 @@ static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_exists");
+		files_downcast(ref_store, REF_STORE_READ, "reflog_exists");
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	int ret;
@@ -3200,7 +3217,7 @@ static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "delete_reflog");
+		files_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
@@ -3256,7 +3273,8 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					     void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
+		files_downcast(ref_store, REF_STORE_READ,
+			       "for_each_reflog_ent_reverse");
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
@@ -3364,7 +3382,8 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 				     each_reflog_ent_fn fn, void *cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "for_each_reflog_ent");
+		files_downcast(ref_store, REF_STORE_READ,
+			       "for_each_reflog_ent");
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
@@ -3452,7 +3471,8 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_iterator_begin");
+		files_downcast(ref_store, REF_STORE_READ,
+			       "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
@@ -3790,7 +3810,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 				    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "ref_transaction_commit");
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -3995,7 +4016,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 					    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "initial_ref_transaction_commit");
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -4117,7 +4139,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			       void *policy_cb_data)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "reflog_expire");
+		files_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -4223,7 +4245,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "init_db");
+		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
 	/*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dfa1817929..0cca280b5c 100644
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

