Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3FC201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932680AbdBVOGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:30 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36615 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbdBVOG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:06:27 -0500
Received: by mail-pg0-f67.google.com with SMTP id z128so538028pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FS7I7vBmK1sBhaMiVIi2sBvvOrhfeyvqsghwtQkLyOU=;
        b=WiVxuhtCW3Kc0usOmmTVr5+2Hl2VpEynJJtd6U5wyrnOizelCkR2x7mvy8AdNk2K79
         SwV6rqpErf/M7eqcWkyfI1fcZv6q6y3PgWq9REmsIWvOqUSyytESn/BKFBLVqGXO8Cgo
         aKHoH3lGdM75vmBvWL6EvFkc5kVwhsrvT3lzLElZ5RgamSEJlaBTWWzCyfalYyrXUwEW
         WHGrPREoYu+TXXMAFTxCrKUj3wDLFIh9513BDhwcv3QKQoY8L2nbGtJFVchTVxtFSKDR
         WdSkqaLHZdmd2mXluW/LBRvmOPznxIy4pTqb2/oastwT5Sr4NrHUr7wLP00uYQYPLnA5
         PzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FS7I7vBmK1sBhaMiVIi2sBvvOrhfeyvqsghwtQkLyOU=;
        b=g93Tv3lc8CJCGxm95WvhKbRPhzrz1dYE/adZmAnXOQX4CYYfrAT3mXoMxjRSigzVgu
         blDpSv+xCvWgs/w4qm8+tRvxhkHPFAJuYLVmrxgg2yY8vpkU/ltzT0hGPDPO0KPYyda0
         x9m+1Tdmh/r2Z7z/8JAaRjor6+CjNAFYlB3omPyB13vGlollNzf2N05AVWFHdmC8IomV
         fCIANUovcPufwZem0dWhALKZQ4DPTDh0EBk1CKA6vo4mxnNRklnzJnSe7OY/L67QII7L
         oz3OkuBNR0V6IvpeQH36LagMoJBbzGuZ6L5MmyqhiWRXBFbnga2VFXIofQsEySRpJL08
         mEYw==
X-Gm-Message-State: AMke39n9vCBqGMXTfWem3e+U6tjdmSJ6cah6kptP7UnUlXgi7NENzLqH+Li09F6UCEwjBA==
X-Received: by 10.98.192.25 with SMTP id x25mr22889686pff.158.1487772376429;
        Wed, 22 Feb 2017 06:06:16 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id y201sm4114664pfb.16.2017.02.22.06.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:06:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:08 +0700
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
Subject: [PATCH v5 06/24] files-backend: add and use files_reflog_path()
Date:   Wed, 22 Feb 2017 21:04:32 +0700
Message-Id: <20170222140450.30886-7-pclouds@gmail.com>
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

Keep repo-related path handling in one place. This will make it easier
to add submodule/multiworktree support later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 148 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 59 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 69946b0de..7b4ea4c56 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,7 +165,8 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
-static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+static int files_log_ref_write(struct files_ref_store *refs,
+			       const char *refname, const unsigned char *old_sha1,
 			       const unsigned char *new_sha1, const char *msg,
 			       int flags, struct strbuf *err);
 
@@ -1167,6 +1168,18 @@ static const char *files_packed_refs_path(struct files_ref_store *refs)
 	return refs->packed_refs_path;
 }
 
+static void files_reflog_path(struct files_ref_store *refs,
+			      struct strbuf *sb,
+			      const char *refname)
+{
+	if (!refname) {
+		strbuf_git_path(sb, "logs");
+		return;
+	}
+
+	strbuf_git_path(sb, "logs/%s", refname);
+}
+
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
  * creating it if necessary.
@@ -2316,7 +2329,9 @@ enum {
  * subdirs. flags is a combination of REMOVE_EMPTY_PARENTS_REF and/or
  * REMOVE_EMPTY_PARENTS_REFLOG.
  */
-static void try_remove_empty_parents(const char *refname, unsigned int flags)
+static void try_remove_empty_parents(struct files_ref_store *refs,
+				     const char *refname,
+				     unsigned int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -2348,7 +2363,7 @@ static void try_remove_empty_parents(const char *refname, unsigned int flags)
 			flags &= ~REMOVE_EMPTY_PARENTS_REF;
 
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "logs/%s", buf.buf);
+		files_reflog_path(refs, &sb, buf.buf);
 		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REFLOG;
 	}
@@ -2541,15 +2556,15 @@ static int rename_tmp_log_callback(const char *path, void *cb_data)
 	}
 }
 
-static int rename_tmp_log(const char *newrefname)
+static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 {
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	struct rename_cb cb;
 	int ret;
 
-	strbuf_git_path(&path, "logs/%s", newrefname);
-	strbuf_git_path(&tmp, "logs/%s", TMP_RENAMED_LOG);
+	files_reflog_path(refs, &path, newrefname);
+	files_reflog_path(refs, &tmp, TMP_RENAMED_LOG);
 	cb.tmp_renamed_log = tmp.buf;
 	ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
 	if (ret) {
@@ -2609,7 +2624,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
 
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	files_reflog_path(refs, &sb_oldref, oldrefname);
 	log = !lstat(sb_oldref.buf, &loginfo);
 	strbuf_release(&sb_oldref);
 	if (log && S_ISLNK(loginfo.st_mode))
@@ -2625,8 +2640,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
-	strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
+	files_reflog_path(refs, &sb_oldref, oldrefname);
+	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
 	strbuf_release(&sb_oldref);
 	strbuf_release(&tmp_renamed_log);
@@ -2667,7 +2682,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 		}
 	}
 
-	if (log && rename_tmp_log(newrefname))
+	if (log && rename_tmp_log(refs, newrefname))
 		goto rollback;
 
 	logmoved = log;
@@ -2709,12 +2724,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	files_reflog_path(refs, &sb_newref, newrefname);
+	files_reflog_path(refs, &sb_oldref, oldrefname);
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
-	strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
+	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
@@ -2782,10 +2797,15 @@ static int open_or_create_logfile(const char *path, void *cb)
  * set *logfd to -1. On failure, fill in *err, set *logfd to -1, and
  * return -1.
  */
-static int log_ref_setup(const char *refname, int force_create,
+static int log_ref_setup(struct files_ref_store *refs,
+			 const char *refname, int force_create,
 			 int *logfd, struct strbuf *err)
 {
-	char *logfile = git_pathdup("logs/%s", refname);
+	struct strbuf logfile_sb = STRBUF_INIT;
+	char *logfile;
+
+	files_reflog_path(refs, &logfile_sb, refname);
+	logfile = strbuf_detach(&logfile_sb, NULL);
 
 	if (force_create || should_autocreate_reflog(refname)) {
 		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
@@ -2835,12 +2855,11 @@ static int files_create_reflog(struct ref_store *ref_store,
 			       const char *refname, int force_create,
 			       struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "create_reflog");
 	int fd;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "create_reflog");
-
-	if (log_ref_setup(refname, force_create, &fd, err))
+	if (log_ref_setup(refs, refname, force_create, &fd, err))
 		return -1;
 
 	if (fd >= 0)
@@ -2875,7 +2894,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+int files_log_ref_write(struct files_ref_store *refs,
+			const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err)
 {
@@ -2884,7 +2904,8 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates == LOG_REFS_UNSET)
 		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
-	result = log_ref_setup(refname, flags & REF_FORCE_CREATE_REFLOG,
+	result = log_ref_setup(refs, refname,
+			       flags & REF_FORCE_CREATE_REFLOG,
 			       &logfd, err);
 
 	if (result)
@@ -2898,7 +2919,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
 
-		strbuf_git_path(&sb, "logs/%s", refname);
+		files_reflog_path(refs, &sb, refname);
 		strbuf_addf(err, "unable to append to '%s': %s",
 			    sb.buf, strerror(save_errno));
 		strbuf_release(&sb);
@@ -2909,7 +2930,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
 
-		strbuf_git_path(&sb, "logs/%s", refname);
+		files_reflog_path(refs, &sb, refname);
 		strbuf_addf(err, "unable to append to '%s': %s",
 			    sb.buf, strerror(save_errno));
 		strbuf_release(&sb);
@@ -2970,7 +2991,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 	files_assert_main_repository(refs, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
-	if (files_log_ref_write(lock->ref_name, lock->old_oid.hash, sha1,
+	if (files_log_ref_write(refs, lock->ref_name,
+				lock->old_oid.hash, sha1,
 				logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
@@ -3002,8 +3024,9 @@ static int commit_ref_update(struct files_ref_store *refs,
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write("HEAD", lock->old_oid.hash, sha1,
-					  logmsg, 0, &log_err)) {
+			if (files_log_ref_write(refs, "HEAD",
+						lock->old_oid.hash, sha1,
+						logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
@@ -3035,24 +3058,26 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 	return ret;
 }
 
-static void update_symref_reflog(struct ref_lock *lock, const char *refname,
+static void update_symref_reflog(struct files_ref_store *refs,
+				 struct ref_lock *lock, const char *refname,
 				 const char *target, const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	unsigned char new_sha1[20];
 	if (logmsg && !read_ref(target, new_sha1) &&
-	    files_log_ref_write(refname, lock->old_oid.hash, new_sha1,
-				logmsg, 0, &err)) {
+	    files_log_ref_write(refs, refname, lock->old_oid.hash,
+				new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
 }
 
-static int create_symref_locked(struct ref_lock *lock, const char *refname,
+static int create_symref_locked(struct files_ref_store *refs,
+				struct ref_lock *lock, const char *refname,
 				const char *target, const char *logmsg)
 {
 	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
-		update_symref_reflog(lock, refname, target, logmsg);
+		update_symref_reflog(refs, lock, refname, target, logmsg);
 		return 0;
 	}
 
@@ -3060,7 +3085,7 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 		return error("unable to fdopen %s: %s",
 			     lock->lk->tempfile.filename.buf, strerror(errno));
 
-	update_symref_reflog(lock, refname, target, logmsg);
+	update_symref_reflog(refs, lock, refname, target, logmsg);
 
 	/* no error check; commit_ref will check ferror */
 	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
@@ -3089,13 +3114,20 @@ static int files_create_symref(struct ref_store *ref_store,
 		return -1;
 	}
 
-	ret = create_symref_locked(lock, refname, target, logmsg);
+	ret = create_symref_locked(refs, lock, refname, target, logmsg);
 	unlock_ref(lock);
 	return ret;
 }
 
 int set_worktree_head_symref(const char *gitdir, const char *target)
 {
+	/*
+	 * FIXME: this obviously will not work well for future refs
+	 * backends. This function needs to die.
+	 */
+	struct files_ref_store *refs =
+		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
+
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
@@ -3122,7 +3154,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
 
-	ret = create_symref_locked(lock, head_rel, target, NULL);
+	ret = create_symref_locked(refs, lock, head_rel, target, NULL);
 
 	unlock_ref(lock); /* will free lock */
 	strbuf_release(&head_path);
@@ -3132,14 +3164,13 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "reflog_exists");
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	int ret;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "reflog_exists");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_reflog_path(refs, &sb, refname);
 	ret = !lstat(sb.buf, &st) && S_ISREG(st.st_mode);
 	strbuf_release(&sb);
 	return ret;
@@ -3148,13 +3179,12 @@ static int files_reflog_exists(struct ref_store *ref_store,
 static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "delete_reflog");
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "delete_reflog");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_reflog_path(refs, &sb, refname);
 	ret = remove_path(sb.buf);
 	strbuf_release(&sb);
 	return ret;
@@ -3204,15 +3234,14 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					     each_reflog_ent_fn fn,
 					     void *cb_data)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
 	int ret = 0, at_tail = 1;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_reflog_path(refs, &sb, refname);
 	logfp = fopen(sb.buf, "r");
 	strbuf_release(&sb);
 	if (!logfp)
@@ -3313,14 +3342,13 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 				     const char *refname,
 				     each_reflog_ent_fn fn, void *cb_data)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "for_each_reflog_ent");
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "for_each_reflog_ent");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_reflog_path(refs, &sb, refname);
 	logfp = fopen(sb.buf, "r");
 	strbuf_release(&sb);
 	if (!logfp)
@@ -3402,15 +3430,14 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "reflog_iterator_begin");
-
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	strbuf_git_path(&sb, "logs");
+	files_reflog_path(refs, &sb, NULL);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	strbuf_release(&sb);
 	return ref_iterator;
@@ -3835,7 +3862,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (files_log_ref_write(lock->ref_name,
+			if (files_log_ref_write(refs,
+						lock->ref_name,
 						lock->old_oid.hash,
 						update->new_sha1,
 						update->msg, update->flags,
@@ -3895,9 +3923,9 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	/* Delete the reflogs of any references that were deleted: */
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "logs/%s", ref_to_delete->string);
+		files_reflog_path(refs, &sb, ref_to_delete->string);
 		if (!unlink_or_warn(sb.buf))
-			try_remove_empty_parents(ref_to_delete->string,
+			try_remove_empty_parents(refs, ref_to_delete->string,
 						 REMOVE_EMPTY_PARENTS_REFLOG);
 	}
 
@@ -3921,7 +3949,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			 * can only work because we have already
 			 * removed the lockfile.)
 			 */
-			try_remove_empty_parents(update->refname,
+			try_remove_empty_parents(refs, update->refname,
 						 REMOVE_EMPTY_PARENTS_REF);
 		}
 	}
@@ -4072,6 +4100,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
+	struct strbuf log_file_sb = STRBUF_INIT;
 	char *log_file;
 	int status = 0;
 	int type;
@@ -4100,7 +4129,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		return 0;
 	}
 
-	log_file = git_pathdup("logs/%s", refname);
+	files_reflog_path(refs, &log_file_sb, refname);
+	log_file = strbuf_detach(&log_file_sb, NULL);
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		/*
 		 * Even though holding $GIT_DIR/logs/$reflog.lock has
-- 
2.11.0.157.gd943d85

