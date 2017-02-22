Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A0B201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbdBVOGO (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:14 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33701 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbdBVOGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:06:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so553743pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l26OJ+GKMsxcO9LWbhc4SRHhJO7r68si6m98WQILYLE=;
        b=RZB1se4Sxg2N2xL6txlzEjo7cwVedqa1ZYfbJPnRo+Ls8YaFNjJlaCtQCDUoiN5Tro
         g2EMjn85TepyHkkBbOPVAf4filXfbUqo7EFlcqeBe1cnndiCpZo9hlIVPiw17GQzilB+
         71KmLUu0WaPN8c2/Q2+RLdw+ejlxfscogcHiaA7TJ680q/H2pvYJTz9HttY2c9mJ7rhZ
         FgQp1nwiVRYdSjzrrM5Nnd8YFVJWerV8wJ8vvhs9nG5J8xq37l1tUpgJ4YnkFUy0tQPf
         4gl72SIlqVnjyNWNwZ4rbaobgtZa5k+Cd9of23ESyn+EQfOBcrtTjCarmLbJ7R+K5Gwl
         helw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l26OJ+GKMsxcO9LWbhc4SRHhJO7r68si6m98WQILYLE=;
        b=tM6xxFUL6uaets2YFYohrinNntAEVAPSblpIuXWQ2H4fUWsrYhKA/Ysk7rm0IkkyyH
         mW9Yf25b7sV2eMBXBpVKoU+FOPFaJ9hJO5yOTSrLbfPJU0tHE2M856RbjAp/Cw1wuSf4
         UamBK6zmG0L8ITKRojYg2ALR6hGuU2KYfCXmra0r8XA2H5elvvIUecN5xfPWYlrIE4++
         Oie7imN3L3HzLxqkyUFrHmGiKyeruH1i1w7FKZESuIvSfR+eMHPAYo+ZDUh4tl+0idaq
         +gvuq5osiac/yNGktmQR1Ns1uf6KMjOTox1iJz/mLRz6jpQoU+oyFXsIX4sHsqO17tLG
         Af7g==
X-Gm-Message-State: AMke39khMERtEoQg16XYvGWGJ2oJjQSGAehsOGZC6YtFCsltoQJ3EAPkAn00rakQ2gW31w==
X-Received: by 10.98.28.72 with SMTP id c69mr20418230pfc.8.1487772360334;
        Wed, 22 Feb 2017 06:06:00 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id n189sm4045665pfn.108.2017.02.22.06.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:05:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:05:53 +0700
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
Subject: [PATCH v5 04/24] files-backend: convert git_path() to strbuf_git_path()
Date:   Wed, 22 Feb 2017 21:04:30 +0700
Message-Id: <20170222140450.30886-5-pclouds@gmail.com>
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

git_path() and friends are going to be killed in files-backend.c in near
future. And because there's a risk with overwriting buffer in
git_path(), let's convert them all to strbuf_git_path(). We'll have
easier time killing/converting strbuf_git_path() then because we won't
have to worry about memory management again.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 139 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 106 insertions(+), 33 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4676525de..435db1293 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2319,6 +2319,7 @@ enum {
 static void try_remove_empty_parents(const char *refname, unsigned int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
 	char *p, *q;
 	int i;
 
@@ -2340,14 +2341,19 @@ static void try_remove_empty_parents(const char *refname, unsigned int flags)
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
@@ -2509,11 +2515,16 @@ static int files_delete_refs(struct ref_store *ref_store,
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
-static int rename_tmp_log_callback(const char *path, void *cb)
+struct rename_cb {
+	const char *tmp_renamed_log;
+	int true_errno;
+};
+
+static int rename_tmp_log_callback(const char *path, void *cb_data)
 {
-	int *true_errno = cb;
+	struct rename_cb *cb = cb_data;
 
-	if (rename(git_path(TMP_RENAMED_LOG), path)) {
+	if (rename(cb->tmp_renamed_log, path)) {
 		/*
 		 * rename(a, b) when b is an existing directory ought
 		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
@@ -2521,7 +2532,7 @@ static int rename_tmp_log_callback(const char *path, void *cb)
 		 * but report EISDIR to raceproof_create_file() so
 		 * that it knows to retry.
 		 */
-		*true_errno = errno;
+		cb->true_errno = errno;
 		if (errno == ENOTDIR)
 			errno = EISDIR;
 		return -1;
@@ -2532,20 +2543,26 @@ static int rename_tmp_log_callback(const char *path, void *cb)
 
 static int rename_tmp_log(const char *newrefname)
 {
-	char *path = git_pathdup("logs/%s", newrefname);
-	int ret, true_errno;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+	struct rename_cb cb;
+	int ret;
 
-	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
+	strbuf_git_path(&path, "logs/%s", newrefname);
+	strbuf_git_path(&tmp, TMP_RENAMED_LOG);
+	cb.tmp_renamed_log = tmp.buf;
+	ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
 	if (ret) {
 		if (errno == EISDIR)
-			error("directory not empty: %s", path);
+			error("directory not empty: %s", path.buf);
 		else
 			error("unable to move logfile %s to %s: %s",
-			      git_path(TMP_RENAMED_LOG), path,
-			      strerror(true_errno));
+			      tmp.buf, path.buf,
+			      strerror(cb.true_errno));
 	}
 
-	free(path);
+	strbuf_release(&path);
+	strbuf_release(&tmp);
 	return ret;
 }
 
@@ -2586,9 +2603,15 @@ static int files_rename_ref(struct ref_store *ref_store,
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
 
@@ -2602,7 +2625,12 @@ static int files_rename_ref(struct ref_store *ref_store,
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
 
@@ -2681,13 +2709,19 @@ static int files_rename_ref(struct ref_store *ref_store,
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
@@ -2861,18 +2895,24 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
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
@@ -3092,22 +3132,32 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
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
@@ -3162,7 +3212,9 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
 
-	logfp = fopen(git_path("logs/%s", refname), "r");
+	strbuf_git_path(&sb, "logs/%s", refname);
+	logfp = fopen(sb.buf, "r");
+	strbuf_release(&sb);
 	if (!logfp)
 		return -1;
 
@@ -3268,7 +3320,9 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "for_each_reflog_ent");
 
-	logfp = fopen(git_path("logs/%s", refname), "r");
+	strbuf_git_path(&sb, "logs/%s", refname);
+	logfp = fopen(sb.buf, "r");
+	strbuf_release(&sb);
 	if (!logfp)
 		return -1;
 
@@ -3350,12 +3404,15 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
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
 
@@ -3693,6 +3750,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	char *head_ref = NULL;
 	int head_type;
 	struct object_id head_oid;
+	struct strbuf sb = STRBUF_INIT;
 
 	assert(err);
 
@@ -3814,7 +3872,9 @@ static int files_transaction_commit(struct ref_store *ref_store,
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
@@ -3834,7 +3894,9 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 	/* Delete the reflogs of any references that were deleted: */
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (!unlink_or_warn(git_path("logs/%s", ref_to_delete->string)))
+		strbuf_reset(&sb);
+		strbuf_git_path(&sb, "logs/%s", ref_to_delete->string);
+		if (!unlink_or_warn(sb.buf))
 			try_remove_empty_parents(ref_to_delete->string,
 						 REMOVE_EMPTY_PARENTS_REFLOG);
 	}
@@ -3842,6 +3904,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	clear_loose_ref_cache(refs);
 
 cleanup:
+	strbuf_release(&sb);
 	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < transaction->nr; i++) {
@@ -4108,18 +4171,28 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
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

