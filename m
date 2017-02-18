Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A77201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbdBRNdf (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:33:35 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34948 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdBRNdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:33:33 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so157810pgz.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkTDOe+36Zr9DVSyl+bZ2jfLR4RMN8m0qrsAnRxJiKY=;
        b=caDf1QQyYD04dFqEZhI6CRDXA4mXkpG3t49qwuzVcg+J+SireJ0K30uJCmc1Hwl/NN
         CWDcD5JGh0ANU85zHOaFREuVkAE5pY/o2+Lr5UCwJGIxJDFTeMeftSVhzgmrQUzzjaLA
         yBc2OAKQn78q/PP9XK0i4QNc52hae9j2Fxu3nIBHgOSTMoRdBkYUy/F5HzwwdOGiq7Vn
         ci2iDi6kFhyl5Q8mkqW8sGUJqQNFktJhVrQ4f2A/KWVyL3EqWraGZ/QYjZymULWRMORS
         QpjweDuSGq8q3hynj08p7sypxBDOdtQguHe9CsBJTp/OATM91i26jp3U1stWBEgUGIPv
         eSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkTDOe+36Zr9DVSyl+bZ2jfLR4RMN8m0qrsAnRxJiKY=;
        b=lsVo+gpfdNbXL0rON/axVhzoYCPoifyj/VlGGyr+SOd4TAkFqnk4R3z4GR5HyqFIMX
         dx/N2h6rP4p7QPlBcoiW3j+Unepchems21KgDxb2ELlDhXZDhgBw7cvqV8zPFJaeMwm6
         PAFXGkWDK3yBj664CcH6IPYWZt3HRBHPUdijg+FsjenEhUaHFlC6q6BRKg9RCk6aDLyM
         Zo8E88bmEBYVDQNv3NulYWr1VtNnNmHLaX1zBs1Dv1Ksp1eGKs3bpFq9RIw+Q0GzIzxk
         LLSa8WNNMbmuQU8HksVb3C4OLS1PhHOZVzdCrFjj/0SORT80vsxLizV3vZCjEWaaibw2
         r0bw==
X-Gm-Message-State: AMke39n9hnUzGpkPpH+U4ybQEASBAwMWtj51Mud7APRB8YCfIctmBo48eLc32/oJDd/QGA==
X-Received: by 10.84.142.1 with SMTP id 1mr18460499plw.127.1487424812895;
        Sat, 18 Feb 2017 05:33:32 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id j28sm25557112pfj.2.2017.02.18.05.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:33:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:25 +0700
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
Subject: [PATCH v4 02/15] files-backend: convert git_path() to strbuf_git_path()
Date:   Sat, 18 Feb 2017 20:32:50 +0700
Message-Id: <20170218133303.3682-3-pclouds@gmail.com>
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

git_path() and friends are going to be killed in files-backend.c in near
future. And because there's a risk with overwriting buffer in
git_path(), let's convert them all to strbuf_git_path(). We'll have
easier time killing/converting strbuf_git_path() then because we won't
have to worry about memory management again.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 146 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 115 insertions(+), 31 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1ebd59ec0..c6c86f850 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2151,6 +2151,8 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
 
 	files_assert_main_repository(refs, "lock_packed_refs");
 
@@ -2159,10 +2161,13 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 		timeout_configured = 1;
 	}
 
-	if (hold_lock_file_for_update_timeout(
-			    &packlock, git_path("packed-refs"),
-			    flags, timeout_value) < 0)
+	strbuf_git_path(&sb, "packed-refs");
+	ret = hold_lock_file_for_update_timeout(&packlock, sb.buf,
+						flags, timeout_value);
+	strbuf_release(&sb);
+	if (ret < 0)
 		return -1;
+
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
 	 * packed-refs file has been modified since we last read it,
@@ -2312,6 +2317,7 @@ enum {
 static void try_remove_empty_parents(const char *refname, unsigned int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
 	char *p, *q;
 	int i;
 
@@ -2333,14 +2339,19 @@ static void try_remove_empty_parents(const char *refname, unsigned int flags)
 		if (q == p)
 			break;
 		strbuf_setlen(&buf, q - buf.buf);
-		if ((flags & REMOVE_EMPTY_PARENTS_REF) &&
-		    rmdir(git_path("%s", buf.buf)))
+
+		strbuf_reset(&sb);
+		strbuf_git_path(&sb, "%s", buf.buf);
+		if ((flags & REMOVE_EMPTY_PARENTS_REF) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REF;
-		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) &&
-		    rmdir(git_path("logs/%s", buf.buf)))
+
+		strbuf_reset(&sb);
+		strbuf_git_path(&sb, "logs/%s", buf.buf);
+		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REFLOG;
 	}
 	strbuf_release(&buf);
+	strbuf_release(&sb);
 }
 
 /* make sure nobody touched the ref, and unlink */
@@ -2426,7 +2437,11 @@ static int repack_without_refs(struct files_ref_store *refs,
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(refs, 0)) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_git_path(&sb, "packed-refs");
+		unable_to_lock_message(sb.buf, errno, err);
+		strbuf_release(&sb);
 		return -1;
 	}
 	packed = get_packed_refs(refs);
@@ -2504,9 +2519,11 @@ static int files_delete_refs(struct ref_store *ref_store,
 
 static int rename_tmp_log_callback(const char *path, void *cb)
 {
+	struct strbuf sb = STRBUF_INIT;
 	int *true_errno = cb;
 
-	if (rename(git_path(TMP_RENAMED_LOG), path)) {
+	strbuf_git_path(&sb, TMP_RENAMED_LOG);
+	if (rename(sb.buf, path)) {
 		/*
 		 * rename(a, b) when b is an existing directory ought
 		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
@@ -2515,30 +2532,40 @@ static int rename_tmp_log_callback(const char *path, void *cb)
 		 * that it knows to retry.
 		 */
 		*true_errno = errno;
+		strbuf_release(&sb);
 		if (errno == ENOTDIR)
 			errno = EISDIR;
 		return -1;
 	} else {
+		strbuf_release(&sb);
 		return 0;
 	}
 }
 
 static int rename_tmp_log(const char *newrefname)
 {
-	char *path = git_pathdup("logs/%s", newrefname);
+	struct strbuf sb = STRBUF_INIT;
+	const char *path;
 	int ret, true_errno;
 
+	strbuf_git_path(&sb, "logs/%s", newrefname);
+	path = sb.buf;
 	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
 	if (ret) {
 		if (errno == EISDIR)
 			error("directory not empty: %s", path);
-		else
+		else {
+			struct strbuf tmp_renamed = STRBUF_INIT;
+
+			strbuf_git_path(&tmp_renamed, TMP_RENAMED_LOG);
 			error("unable to move logfile %s to %s: %s",
-			      git_path(TMP_RENAMED_LOG), path,
+			      tmp_renamed.buf, path,
 			      strerror(true_errno));
+			strbuf_release(&tmp_renamed);
+		}
 	}
 
-	free(path);
+	strbuf_release(&sb);
 	return ret;
 }
 
@@ -2579,9 +2606,15 @@ static int files_rename_ref(struct ref_store *ref_store,
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
+	struct strbuf sb_oldref = STRBUF_INIT;
+	struct strbuf sb_newref = STRBUF_INIT;
+	struct strbuf tmp_renamed_log = STRBUF_INIT;
+	int log, ret;
 	struct strbuf err = STRBUF_INIT;
 
+	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	log = !lstat(sb_oldref.buf, &loginfo);
+	strbuf_release(&sb_oldref);
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
@@ -2595,7 +2628,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
+	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
+	strbuf_release(&sb_oldref);
+	strbuf_release(&tmp_renamed_log);
+	if (ret)
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
@@ -2674,13 +2712,19 @@ static int files_rename_ref(struct ref_store *ref_store,
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
+	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
+	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
+	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
 	if (!logmoved && log &&
-	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
+	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
+	strbuf_release(&sb_newref);
+	strbuf_release(&sb_oldref);
+	strbuf_release(&tmp_renamed_log);
 
 	return 1;
 }
@@ -2854,18 +2898,24 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
+		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
 
+		strbuf_git_path(&sb, "logs/%s", refname);
 		strbuf_addf(err, "unable to append to '%s': %s",
-			    git_path("logs/%s", refname), strerror(save_errno));
+			    sb.buf, strerror(save_errno));
+		strbuf_release(&sb);
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
+		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
 
+		strbuf_git_path(&sb, "logs/%s", refname);
 		strbuf_addf(err, "unable to append to '%s': %s",
-			    git_path("logs/%s", refname), strerror(save_errno));
+			    sb.buf, strerror(save_errno));
+		strbuf_release(&sb);
 		return -1;
 	}
 	return 0;
@@ -3085,22 +3135,32 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
+	int ret;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "reflog_exists");
 
-	return !lstat(git_path("logs/%s", refname), &st) &&
-		S_ISREG(st.st_mode);
+	strbuf_git_path(&sb, "logs/%s", refname);
+	ret = !lstat(sb.buf, &st) && S_ISREG(st.st_mode);
+	strbuf_release(&sb);
+	return ret;
 }
 
 static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
+
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "delete_reflog");
 
-	return remove_path(git_path("logs/%s", refname));
+	strbuf_git_path(&sb, "logs/%s", refname);
+	ret = remove_path(sb.buf);
+	strbuf_release(&sb);
+	return ret;
 }
 
 static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
@@ -3155,7 +3215,9 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
 
-	logfp = fopen(git_path("logs/%s", refname), "r");
+	strbuf_git_path(&sb, "logs/%s", refname);
+	logfp = fopen(sb.buf, "r");
+	strbuf_release(&sb);
 	if (!logfp)
 		return -1;
 
@@ -3261,7 +3323,9 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "for_each_reflog_ent");
 
-	logfp = fopen(git_path("logs/%s", refname), "r");
+	strbuf_git_path(&sb, "logs/%s", refname);
+	logfp = fopen(sb.buf, "r");
+	strbuf_release(&sb);
 	if (!logfp)
 		return -1;
 
@@ -3343,12 +3407,15 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 {
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
+	struct strbuf sb = STRBUF_INIT;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "reflog_iterator_begin");
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	strbuf_git_path(&sb, "logs");
+	iter->dir_iterator = dir_iterator_begin(sb.buf);
+	strbuf_release(&sb);
 	return ref_iterator;
 }
 
@@ -3686,6 +3753,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	char *head_ref = NULL;
 	int head_type;
 	struct object_id head_oid;
+	struct strbuf sb = STRBUF_INIT;
 
 	assert(err);
 
@@ -3807,7 +3875,9 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			if (!(update->type & REF_ISPACKED) ||
 			    update->type & REF_ISSYMREF) {
 				/* It is a loose reference. */
-				if (unlink_or_msg(git_path("%s", lock->ref_name), err)) {
+				strbuf_reset(&sb);
+				strbuf_git_path(&sb, "%s", lock->ref_name);
+				if (unlink_or_msg(sb.buf, err)) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
 				}
@@ -3827,9 +3897,13 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 	/* Delete the reflogs of any references that were deleted: */
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (!unlink_or_warn(git_path("logs/%s", ref_to_delete->string)))
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_git_path(&sb, "logs/%s", ref_to_delete->string);
+		if (!unlink_or_warn(sb.buf))
 			try_remove_empty_parents(ref_to_delete->string,
 						 REMOVE_EMPTY_PARENTS_REFLOG);
+		strbuf_release(&sb);
 	}
 
 	clear_loose_ref_cache(refs);
@@ -4101,18 +4175,28 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
+	struct strbuf sb = STRBUF_INIT;
+
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "init_db");
 
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	safe_create_dir(git_path("refs/heads"), 1);
-	safe_create_dir(git_path("refs/tags"), 1);
+	strbuf_git_path(&sb, "refs/heads");
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+	strbuf_git_path(&sb, "refs/tags");
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
 	if (get_shared_repository()) {
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
+		strbuf_git_path(&sb, "refs/heads");
+		adjust_shared_perm(sb.buf);
+		strbuf_reset(&sb);
+		strbuf_git_path(&sb, "refs/tags");
+		adjust_shared_perm(sb.buf);
 	}
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.11.0.157.gd943d85

