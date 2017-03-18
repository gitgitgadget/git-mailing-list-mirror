Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462D22095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdCRCg5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:36:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36673 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdCRCgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:36:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id r137so6557260pfr.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oRWD5fT8MDEwpR5shXifcb7XkB/j5IgGqdf3Vk1avw=;
        b=PUUBkpZPyohItuxPJqP2Ck7jFls+ihlEniPpn1GASScDyXubiHaaBMBkdMUXp3k5K2
         5DUd66iS8eVOye2YeBkCdIy6ldD9W7SAvUCXc+jX622Dng8irIn2G0o7w8bpTV+C8o4Z
         MAK+tJnhHQG9Imw5O3aQu390GILUhlt4Hy/te4Nh4wgoo95m7UMyp8V4gDDGkPICOBjb
         Ob77Jh8lk7z5bvCX3JfT72J9kdobr+JV0p7wlQTYtJhSLg6NA10ZwoGEEAMmh+z8qatt
         kFed9/E85EPBoHjnj/AmsHXRQEE0FOMWtQxfcvH1pkBQ375KNVdxErCt+11ZtWaTfVCc
         tWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oRWD5fT8MDEwpR5shXifcb7XkB/j5IgGqdf3Vk1avw=;
        b=UGHg9CM6F5XhpO/hTfMTQkXSpHFvdnAiLpw5umPzVVwfJWZ9uLfzuYY1OglALHQ7MM
         Dr5g7ChKgZ8WEBjxs3fJ9rc7CFzym+55j02JAqPMXmXROztJ6m2WIrHDSG7VDcgQbdMn
         A2yFz2d/wEBGfuYRoNG8aXS+a/DZu/keZWdaU0xInOusBxvgQGpsvmQbyabw207Vr4zy
         HWAwF2CbtTFnWrRvAldYkU76cyxnXrS04MHQ6VfgSHd8ytYr52c8TVSBZqFSldE1gfn6
         YqtrKx4OCBsSkVGDaiL3Ahs3DhsG1fh9mMO9EKnkSAi59HhM7wUgSZOJI9vu6pd/mYw5
         vS9A==
X-Gm-Message-State: AFeK/H2UsAtCC0mY3yvPHg1iCIRUyIJZkKjvDUS+Ch6C2UmOHyZG9YdwuMZWd74UZA2qDA==
X-Received: by 10.98.7.86 with SMTP id b83mr19899828pfd.66.1489802642792;
        Fri, 17 Mar 2017 19:04:02 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id q194sm19059898pfq.43.2017.03.17.19.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:03:54 +0700
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
Subject: [PATCH v6 00/27] Remove submodule from files-backend.c
Date:   Sat, 18 Mar 2017 09:03:10 +0700
Message-Id: <20170318020337.22767-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 should address all Micheal's comments in v5, except a few that I
replied back. The interdiff looks a bit messy due to some new
refactoring (05/27) in files_rename_ref(), but it makes the final
output easier to read.

03/27 and 27/27 are also new patches that are not really necessary but
nice to have.

The series is rebased on latest master and does not depend on any
other topics, since they all have graduated to master.

diff --git a/path.c b/path.c
index 3451d2916f..03e7e33b6e 100644
--- a/path.c
+++ b/path.c
@@ -471,7 +471,6 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 }
 
 /* Returns 0 on success, negative on failure. */
-#define SUBMODULE_PATH_ERR_NOT_CONFIGURED -1
 static int do_submodule_path(struct strbuf *buf, const char *path,
 			     const char *fmt, va_list args)
 {
diff --git a/refs.c b/refs.c
index 4e4945bd1c..24c7113d36 100644
--- a/refs.c
+++ b/refs.c
@@ -171,11 +171,23 @@ int refname_is_safe(const char *refname)
 	return 1;
 }
 
+char *refs_resolve_refdup(struct ref_store *refs,
+			  const char *refname, int resolve_flags,
+			  unsigned char *sha1, int *flags)
+{
+	const char *result;
+
+	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+					 sha1, flags);
+	return xstrdup_or_null(result);
+}
+
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     unsigned char *sha1, int *flags)
 {
-	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
-						  sha1, flags));
+	return refs_resolve_refdup(get_main_ref_store(),
+				   refname, resolve_flags,
+				   sha1, flags);
 }
 
 /* The argument to filter_refs */
@@ -1521,12 +1533,7 @@ struct ref_store *get_main_ref_store(void)
 			       REF_STORE_WRITE |
 			       REF_STORE_ODB |
 			       REF_STORE_MAIN));
-	if (refs) {
-		if (main_ref_store)
-			die("BUG: main_ref_store initialized twice");
-
-		main_ref_store = refs;
-	}
+	main_ref_store = refs;
 	return refs;
 }
 
@@ -1569,17 +1576,20 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	ret = is_nonbare_repository_dir(&submodule_sb);
 	strbuf_release(&submodule_sb);
 	if (!ret)
-		return refs;
+		return NULL;
 
 	ret = submodule_to_gitdir(&submodule_sb, submodule);
-	if (!ret)
-		/* pretend that add_submodule_odb() has been called */
-		refs = ref_store_init(submodule_sb.buf,
-				      REF_STORE_READ | REF_STORE_ODB);
-	strbuf_release(&submodule_sb);
+	if (ret) {
+		strbuf_release(&submodule_sb);
+		return NULL;
+	}
 
-	if (refs)
-		register_submodule_ref_store(refs, submodule);
+	/* pretend that add_submodule_odb() has been called */
+	refs = ref_store_init(submodule_sb.buf,
+			      REF_STORE_READ | REF_STORE_ODB);
+	register_submodule_ref_store(refs, submodule);
+
+	strbuf_release(&submodule_sb);
 	return refs;
 }
 
diff --git a/refs.h b/refs.h
index 3fc140c16f..4f9983816a 100644
--- a/refs.h
+++ b/refs.h
@@ -3,7 +3,6 @@
 
 struct object_id;
 struct ref_store;
-struct ref_transaction;
 struct strbuf;
 struct string_list;
 
@@ -66,6 +65,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags);
 
+char *refs_resolve_refdup(struct ref_store *refs,
+			  const char *refname, int resolve_flags,
+			  unsigned char *sha1, int *flags);
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     unsigned char *sha1, int *flags);
 
@@ -183,6 +185,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  * `ref_transaction_commit` is called.  So `ref_transaction_verify`
  * won't report a verification failure until the commit is attempted.
  */
+struct ref_transaction;
 
 /*
  * Bit values set in the flags argument passed to each_ref_fn() and
@@ -227,7 +230,7 @@ typedef int each_ref_fn(const char *refname,
  * it is not safe to modify references while an iteration is in
  * progress, unless the same callback function invocation that
  * modifies the reference also returns a nonzero value to immediately
- * stop the iteration.
+ * stop the iteration. Returned references are sorted.
  */
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
@@ -367,7 +370,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
- * and returns the value
+ * and returns the value. Reflog file order is unspecified.
  */
 int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_reflog(each_ref_fn fn, void *cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 89acf38e36..04298ba9fa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1282,16 +1282,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	struct strbuf refname;
 	struct strbuf path = STRBUF_INIT;
 	size_t path_baselen;
-	int err = 0;
 
 	files_refname_path(refs, &path, dirname);
 	path_baselen = path.len;
 
-	if (err) {
-		strbuf_release(&path);
-		return;
-	}
-
 	d = opendir(path.buf);
 	if (!d) {
 		strbuf_release(&path);
@@ -2661,30 +2655,37 @@ static int files_rename_ref(struct ref_store *ref_store,
 	struct strbuf err = STRBUF_INIT;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
+	files_reflog_path(refs, &sb_newref, newrefname);
+	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
+
 	log = !lstat(sb_oldref.buf, &loginfo);
-	strbuf_release(&sb_oldref);
-	if (log && S_ISLNK(loginfo.st_mode))
-		return error("reflog for %s is a symlink", oldrefname);
+	if (log && S_ISLNK(loginfo.st_mode)) {
+		ret = error("reflog for %s is a symlink", oldrefname);
+		goto out;
+	}
 
 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				     orig_sha1, &flag))
-		return error("refname %s not found", oldrefname);
+				orig_sha1, &flag)) {
+		ret = error("refname %s not found", oldrefname);
+		goto out;
+	}
 
-	if (flag & REF_ISSYMREF)
-		return error("refname %s is a symbolic ref, renaming it is not supported",
-			oldrefname);
-	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname))
-		return 1;
+	if (flag & REF_ISSYMREF) {
+		ret = error("refname %s is a symbolic ref, renaming it is not supported",
+			    oldrefname);
+		goto out;
+	}
+	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
+		ret = 1;
+		goto out;
+	}
 
-	files_reflog_path(refs, &sb_oldref, oldrefname);
-	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
-	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
-	strbuf_release(&sb_oldref);
-	strbuf_release(&tmp_renamed_log);
-	if (ret)
-		return error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
+	if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
+		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
+			    oldrefname, strerror(errno));
+		goto out;
+	}
 
 	if (refs_delete_ref(&refs->base, logmsg, oldrefname,
 			    orig_sha1, REF_NODEREF)) {
@@ -2743,7 +2744,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto rollback;
 	}
 
-	return 0;
+	ret = 0;
+	goto out;
 
  rollback:
 	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
@@ -2764,21 +2766,20 @@ static int files_rename_ref(struct ref_store *ref_store,
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	files_reflog_path(refs, &sb_newref, newrefname);
-	files_reflog_path(refs, &sb_oldref, oldrefname);
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
-	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
+	ret = 1;
+ out:
 	strbuf_release(&sb_newref);
 	strbuf_release(&sb_oldref);
 	strbuf_release(&tmp_renamed_log);
 
-	return 1;
+	return ret;
 }
 
 static int close_ref(struct ref_lock *lock)
@@ -3885,10 +3886,9 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	 * head_ref within the transaction, then split_head_update()
 	 * arranges for the reflog of HEAD to be updated, too.
 	 */
-	head_ref = (char *)refs_resolve_ref_unsafe(ref_store, "HEAD",
-						   RESOLVE_REF_NO_RECURSE,
-						   head_oid.hash, &head_type);
-	head_ref = xstrdup_or_null(head_ref);
+	head_ref = refs_resolve_refdup(ref_store, "HEAD",
+				       RESOLVE_REF_NO_RECURSE,
+				       head_oid.hash, &head_type);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
 		free(head_ref);
@@ -4267,17 +4267,11 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	 */
 	files_refname_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
+
 	strbuf_reset(&sb);
 	files_refname_path(refs, &sb, "refs/tags");
 	safe_create_dir(sb.buf, 1);
-	strbuf_reset(&sb);
-	if (get_shared_repository()) {
-		files_refname_path(refs, &sb, "refs/heads");
-		adjust_shared_perm(sb.buf);
-		strbuf_reset(&sb);
-		files_refname_path(refs, &sb, "refs/tags");
-		adjust_shared_perm(sb.buf);
-	}
+
 	strbuf_release(&sb);
 	return 0;
 }
diff --git a/submodule.c b/submodule.c
index 36b8d1d113..193243102d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1515,6 +1515,11 @@ void absorb_git_dir_into_superproject(const char *prefix,
 	}
 }
 
+/*
+ * Given a submodule path (as in the index), return the repository
+ * path of that submodule in 'buf'. Return -1 on error or when the
+ * submodule is not initialized.
+ */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 {
 	const struct submodule *sub;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index c4c670acd3..4cecf6b42e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -195,6 +195,7 @@ static int cmd_reflog_expire(struct ref_store *refs, const char **argv)
 
 static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 {
+	const char *msg = notnull(*argv++, "msg");
 	const char *refname = notnull(*argv++, "refname");
 	const char *sha1_buf = notnull(*argv++, "old-sha1");
 	unsigned int flags = arg_flags(*argv++, "flags");
@@ -203,7 +204,7 @@ static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 	if (get_sha1_hex(sha1_buf, old_sha1))
 		die("not sha-1");
 
-	return refs_delete_ref(refs, refname, old_sha1, flags);
+	return refs_delete_ref(refs, msg, refname, old_sha1, flags);
 }
 
 static int cmd_update_ref(struct ref_store *refs, const char **argv)
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 0999829f1f..490521f8cb 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -53,6 +53,12 @@ test_expect_success 'for_each_ref(refs/heads/)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_ref() is sorted' '
+	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	sort actual > expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'resolve_ref(new-master)' '
 	SHA1=`git rev-parse new-master` &&
 	echo "$SHA1 refs/heads/new-master 0x0" >expected &&
@@ -65,11 +71,11 @@ test_expect_success 'verify_ref(new-master)' '
 '
 
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | cut -c 42- >actual &&
+	$RUN for-each-reflog | sort | cut -c 42- >actual &&
 	cat >expected <<-\EOF &&
+	HEAD 0x1
 	refs/heads/master 0x0
 	refs/heads/new-master 0x0
-	HEAD 0x1
 	EOF
 	test_cmp expected actual
 '
@@ -116,7 +122,7 @@ test_expect_success 'delete_ref(refs/heads/foo)' '
 test_expect_success 'delete_ref(refs/heads/foo)' '
 	SHA1=`git rev-parse foo` &&
 	git checkout --detach &&
-	$RUN delete-ref refs/heads/foo $SHA1 0 &&
+	$RUN delete-ref msg refs/heads/foo $SHA1 0 &&
 	test_must_fail git rev-parse refs/heads/foo --
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 3b30ba62f2..13b5454c56 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -47,6 +47,12 @@ test_expect_success 'for_each_ref(refs/heads/)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_ref() is sorted' '
+	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	sort actual > expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'resolve_ref(master)' '
 	SHA1=`git -C sub rev-parse master` &&
 	echo "$SHA1 refs/heads/master 0x0" >expected &&
@@ -59,11 +65,11 @@ test_expect_success 'verify_ref(new-master)' '
 '
 
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | cut -c 42- >actual &&
+	$RUN for-each-reflog | sort | cut -c 42- >actual &&
 	cat >expected <<-\EOF &&
+	HEAD 0x1
 	refs/heads/master 0x0
 	refs/heads/new-master 0x0
-	HEAD 0x1
 	EOF
 	test_cmp expected actual
 '
-- 
2.11.0.157.gd943d85

