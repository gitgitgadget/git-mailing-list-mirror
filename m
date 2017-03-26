Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51CF20969
	for <e@80x24.org>; Sun, 26 Mar 2017 02:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdCZCmv (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:42:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35591 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZCmu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:42:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id n11so4063418pfg.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nt7S5YrpmWeln9Dl7mjfUQm0wwBbWMc5mHKfh8wP704=;
        b=FGQTJ1lhdXjdpwoTOv9tQ55y0VLz5yKFu6PObUTSTxjIZJllAnEHl4vG7vz91vCGhE
         S1Nfm41Vpsav++h4Uqcv3LpkrDGU9DZa+L1qGL7sBpSe1hDMMZj8Pfzviyc0q1o6Ahdt
         n+J7gjffRw6ZC2nTc8BEifbbgAUkweNGz8N+N5/nTuU56FaBaOciWlV9dRJzh2L3gy4X
         hvMggSC5TXpNXRu9nJFZMW/tUPUmRoz9/EbBzjZAEluFTxXgIInEUqKY8IWV7/w7wpGJ
         Iz/OM308uQlm9MRjdJcAlndDE9GU9PFHHzS1mg+6EfnmOQ7PvDCbysUBr+8u3qY4zbsy
         oqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nt7S5YrpmWeln9Dl7mjfUQm0wwBbWMc5mHKfh8wP704=;
        b=CB+dKM3tCGpisj6LKa6x/mCGzqnq5FocUJCotf2Abc/z7IS0/4fC2vJlr6hK5nLCuF
         Ox2TWBwDansEoKSBisXok+qmNhe9RjVXGVSaabNvOdtTATw+AWYAVv4aOTbeZu+Ea7+p
         fuqQ2Qytv6EdfJJgV6E6DRE4rUpTkiJboEFaoUGOzBWM0PVJ7U5IQsXm0sW/rGYUoKwH
         xOgKmoFKrIr9XrFj86F5Gh3fP/E2iGUciAoMGUHDi3wqlofPXZEF035CT/JmPgKKmnsq
         RQ2Z9y0h/yYvnaP4rWRjjNAD41nUgIFWtxQO2fKu3cYUlBvDu7Tw89UdoFtwhjlKAKII
         tMQg==
X-Gm-Message-State: AFeK/H2xnKueO4RQn2e8puoM8p4a8buAtsKthSdCtoB1CaJA+Ntb6B0t8Q+Vyry0PLpyUA==
X-Received: by 10.84.236.2 with SMTP id q2mr20925595plk.157.1490496168536;
        Sat, 25 Mar 2017 19:42:48 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id 189sm12763208pgd.30.2017.03.25.19.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:42:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:42:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 00/28] Remove submodule from files-backend.c
Date:   Sun, 26 Mar 2017 09:42:13 +0700
Message-Id: <20170326024241.31984-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v7 is mostly about style changes except the one bug in
test-ref-store.c, missing setup_git_directory().

There's one new patch, 03/28, which maps to the "if (!refs)" deletion
in the interdiff.

The one comment from v6 I haven't addressed in v7 is whether to delete
REF_STORE_READ. But if it is deleted, I think I'm doing it in
nd/worktree-kill-parse-ref, which is partly about cleanup refs code
anyway, to avoid another re-roll in this series.

diff --git a/refs.c b/refs.c
index 77a39f8b17..ec1f563824 100644
--- a/refs.c
+++ b/refs.c
@@ -1523,18 +1523,15 @@ static struct ref_store *ref_store_init(const char *gitdir,
 
 struct ref_store *get_main_ref_store(void)
 {
-	struct ref_store *refs;
-
 	if (main_ref_store)
 		return main_ref_store;
 
-	refs = ref_store_init(get_git_dir(),
-			      (REF_STORE_READ |
-			       REF_STORE_WRITE |
-			       REF_STORE_ODB |
-			       REF_STORE_MAIN));
-	main_ref_store = refs;
-	return refs;
+	main_ref_store = ref_store_init(get_git_dir(),
+					(REF_STORE_READ |
+					 REF_STORE_WRITE |
+					 REF_STORE_ODB |
+					 REF_STORE_MAIN));
+	return main_ref_store;
 }
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4242486118..a5b405436f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1195,9 +1195,9 @@ static void files_reflog_path(struct files_ref_store *refs,
 	}
 }
 
-static void files_refname_path(struct files_ref_store *refs,
-			       struct strbuf *sb,
-			       const char *refname)
+static void files_ref_path(struct files_ref_store *refs,
+			   struct strbuf *sb,
+			   const char *refname)
 {
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
@@ -1283,7 +1283,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	struct strbuf path = STRBUF_INIT;
 	size_t path_baselen;
 
-	files_refname_path(refs, &path, dirname);
+	files_ref_path(refs, &path, dirname);
 	path_baselen = path.len;
 
 	d = opendir(path.buf);
@@ -1420,7 +1420,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	files_refname_path(refs, &sb_path, refname);
+	files_ref_path(refs, &sb_path, refname);
 
 	path = sb_path.buf;
 
@@ -1608,7 +1608,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	files_refname_path(refs, &ref_file, refname);
+	files_ref_path(refs, &ref_file, refname);
 
 retry:
 	switch (safe_create_leading_directories(ref_file.buf)) {
@@ -1949,8 +1949,6 @@ static struct ref_iterator *files_ref_iterator_begin(
 	refs = files_downcast(ref_store,
 			      REF_STORE_READ | (ref_paranoia ? 0 : REF_STORE_ODB),
 			      "ref_iterator_begin");
-	if (!refs)
-		return empty_ref_iterator_begin();
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
@@ -2086,7 +2084,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
-	files_refname_path(refs, &ref_file, refname);
+	files_ref_path(refs, &ref_file, refname);
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
 					     refname, resolve_flags,
 					     lock->old_oid.hash, type);
@@ -2387,7 +2385,7 @@ static void try_remove_empty_parents(struct files_ref_store *refs,
 		strbuf_setlen(&buf, q - buf.buf);
 
 		strbuf_reset(&sb);
-		files_refname_path(refs, &sb, buf.buf);
+		files_ref_path(refs, &sb, buf.buf);
 		if ((flags & REMOVE_EMPTY_PARENTS_REF) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REF;
 
@@ -2709,7 +2707,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-			files_refname_path(refs, &path, newrefname);
+			files_ref_path(refs, &path, newrefname);
 			result = remove_empty_directories(&path);
 			strbuf_release(&path);
 
@@ -2935,10 +2933,10 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-int files_log_ref_write(struct files_ref_store *refs,
-			const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err)
+static int files_log_ref_write(struct files_ref_store *refs,
+			       const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err)
 {
 	int logfd, result;
 
@@ -3957,7 +3955,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			    update->type & REF_ISSYMREF) {
 				/* It is a loose reference. */
 				strbuf_reset(&sb);
-				files_refname_path(refs, &sb, lock->ref_name);
+				files_ref_path(refs, &sb, lock->ref_name);
 				if (unlink_or_msg(sb.buf, err)) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -4266,11 +4264,11 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	files_refname_path(refs, &sb, "refs/heads");
+	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 
 	strbuf_reset(&sb);
-	files_refname_path(refs, &sb, "refs/tags");
+	files_ref_path(refs, &sb, "refs/tags");
 	safe_create_dir(sb.buf, 1);
 
 	strbuf_release(&sb);
diff --git a/submodule.c b/submodule.c
index 3c445f274e..a31f68812c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1597,11 +1597,6 @@ const char *get_superproject_working_tree(void)
 	return ret;
 }
 
-/*
- * Given a submodule path (as in the index), return the repository
- * path of that submodule in 'buf'. Return -1 on error or when the
- * submodule is not initialized.
- */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 {
 	const struct submodule *sub;
diff --git a/submodule.h b/submodule.h
index bddbba7f32..fce2fb64d2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -81,6 +81,11 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
+/*
+ * Given a submodule path (as in the index), return the repository
+ * path of that submodule in 'buf'. Return -1 on error or when the
+ * submodule is not initialized.
+ */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
 /*
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 57849ee59a..2d84c45ffe 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -261,6 +261,8 @@ int cmd_main(int argc, const char **argv)
 	const char *func;
 	struct command *cmd;
 
+	setup_git_directory();
+
 	argv = get_store(argv + 1, &refs);
 
 	func = *argv++;

-- 
2.11.0.157.gd943d85

