Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB73201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbdBRNdu (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:33:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36215 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdBRNdt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:33:49 -0500
Received: by mail-pf0-f195.google.com with SMTP id c193so1458465pfb.3
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/mx6BAbLy7/b5w3nTfwT8uaUaT9Krt8aTQgG+zKuH4=;
        b=QC2sNCGaVA0mQas5HZOJA21p3qqFkPWI50PGDSwqpXP6NAJoR+qoli+kMZy8ZbKxZj
         cfUfk40o8bwv3eFsZ8YFZcCwRblmWSl8MW6DbnUjtOMlnrcXDmoSClHulUAKs8C1SUCV
         TJsxhpakhZ3infCV0KMUG1y0gpGGJpvyaHXGnef1He1itNAzrQd+H40Zj2mK0QEDQBjJ
         e8zsGgJyJ3HMND1l+8IiseUUCcx10mbOFpVylvJeQ9AqhiSGYqk8DD2etCVJd+dl0DDB
         DyQH6k94jV+ycYDFNgXupo55n5tOvT9XgLHnL9MES5O7yf7Mt5JUWBvIzIdiDQlQ1WKD
         8l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/mx6BAbLy7/b5w3nTfwT8uaUaT9Krt8aTQgG+zKuH4=;
        b=NdRSg8/wL9f4dryqcN/LHOZgC7/gKoKgvJq2/XfzdQKftCObpz5E6DlXa66r+w1sgg
         u0C8SKptwxzjNqqQPogmrVjGY7mRnRaVwCWAcwDrkRO4BHS9NonApUPJUTjmsjHKeKkO
         0YnFFCgfeYvCCi50k+v8VvTIsgj2FA7eAIHvTP7wjuCk5bP++S5MUUlq5F//iUe9N5AN
         JkN9gQ7w1X5fmS5q3czytmL0EbR6ZjzyHkNzIkA/sFByla4/KJ6xOy6xN6AwKbOeJgsO
         FYkrij9fnp4jPi8Q1vBM23wI/Xi7OBjru0Azx3Rp3hdqsWvU+UCuvRcgE1TMyIEoVPkr
         9VXQ==
X-Gm-Message-State: AMke39lFtac/M3C5SFw8X1T71lWs0MqlJwTjiHOhmRmUNUT8OgiipEwF2WrabzL2NGnzYA==
X-Received: by 10.98.8.215 with SMTP id 84mr15042161pfi.149.1487424828165;
        Sat, 18 Feb 2017 05:33:48 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id a62sm25588778pgc.60.2017.02.18.05.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:33:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:40 +0700
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
Subject: [PATCH v4 04/15] files-backend: replace *git_path*() with files_path()
Date:   Sat, 18 Feb 2017 20:32:52 +0700
Message-Id: <20170218133303.3682-5-pclouds@gmail.com>
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

This centralizes all path rewriting of files-backend.c in one place so
we have easier time removing the path rewriting later. There could be
some hidden indirect git_path() though, I didn't audit the code to the
bottom.

Side note: set_worktree_head_symref() is a bad boy and should not be in
files-backend.c (probably should not exist in the first place). But
we'll leave it there until we have better multi-worktree support in refs
before we update it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 208 +++++++++++++++++++++++++++------------------------
 1 file changed, 111 insertions(+), 97 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7eaf28bd6..b599ddf92 100644
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
 
@@ -1178,12 +1179,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
 	char *packed_refs_file;
+	struct strbuf sb = STRBUF_INIT;
 
-	if (refs->submodule)
-		packed_refs_file = git_pathdup_submodule(refs->submodule,
-							 "packed-refs");
-	else
-		packed_refs_file = git_pathdup("packed-refs");
+	files_path(refs, &sb, "packed-refs");
+	packed_refs_file = strbuf_detach(&sb, NULL);
 
 	if (refs->packed &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
@@ -1249,10 +1248,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	size_t path_baselen;
 	int err = 0;
 
-	if (refs->submodule)
-		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
-	else
-		strbuf_git_path(&path, "%s", dirname);
+	files_path(refs, &path, "%s", dirname);
 	path_baselen = path.len;
 
 	if (err) {
@@ -1394,10 +1390,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	if (refs->submodule)
-		strbuf_git_path_submodule(&sb_path, refs->submodule, "%s", refname);
-	else
-		strbuf_git_path(&sb_path, "%s", refname);
+	files_path(refs, &sb_path, "%s", refname);
 
 	path = sb_path.buf;
 
@@ -1585,7 +1578,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_path(refs, &ref_file, "%s", refname);
 
 retry:
 	switch (safe_create_leading_directories(ref_file.buf)) {
@@ -2057,7 +2050,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_path(refs, &ref_file, "%s", refname);
 	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
 					lock->old_oid.hash, type);
 	if (!resolved && errno == EISDIR) {
@@ -2179,7 +2172,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 		timeout_configured = 1;
 	}
 
-	strbuf_git_path(&sb, "packed-refs");
+	files_path(refs, &sb, "packed-refs");
 	ret = hold_lock_file_for_update_timeout(&packlock, sb.buf,
 						flags, timeout_value);
 	strbuf_release(&sb);
@@ -2332,7 +2325,9 @@ enum {
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
@@ -2359,12 +2354,12 @@ static void try_remove_empty_parents(const char *refname, unsigned int flags)
 		strbuf_setlen(&buf, q - buf.buf);
 
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "%s", buf.buf);
+		files_path(refs, &sb, "%s", buf.buf);
 		if ((flags & REMOVE_EMPTY_PARENTS_REF) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REF;
 
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "logs/%s", buf.buf);
+		files_path(refs, &sb, "logs/%s", buf.buf);
 		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REFLOG;
 	}
@@ -2373,7 +2368,7 @@ static void try_remove_empty_parents(const char *refname, unsigned int flags)
 }
 
 /* make sure nobody touched the ref, and unlink */
-static void prune_ref(struct ref_to_prune *r)
+static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2395,10 +2390,10 @@ static void prune_ref(struct ref_to_prune *r)
 	strbuf_release(&err);
 }
 
-static void prune_refs(struct ref_to_prune *r)
+static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	while (r) {
-		prune_ref(r);
+		prune_ref(refs, r);
 		r = r->next;
 	}
 }
@@ -2421,7 +2416,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
-	prune_refs(cbdata.ref_to_prune);
+	prune_refs(refs, cbdata.ref_to_prune);
 	return 0;
 }
 
@@ -2457,7 +2452,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	if (lock_packed_refs(refs, 0)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		strbuf_git_path(&sb, "packed-refs");
+		files_path(refs, &sb, "packed-refs");
 		unable_to_lock_message(sb.buf, errno, err);
 		strbuf_release(&sb);
 		return -1;
@@ -2535,12 +2530,17 @@ static int files_delete_refs(struct ref_store *ref_store,
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
-static int rename_tmp_log_callback(const char *path, void *cb)
+struct rename_tmp_log_cb {
+	struct files_ref_store *refs;
+	int true_errno;
+};
+
+static int rename_tmp_log_callback(const char *path, void *cb_)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int *true_errno = cb;
+	struct rename_tmp_log_cb *cb = cb_;
 
-	strbuf_git_path(&sb, TMP_RENAMED_LOG);
+	files_path(cb->refs, &sb, TMP_RENAMED_LOG);
 	if (rename(sb.buf, path)) {
 		/*
 		 * rename(a, b) when b is an existing directory ought
@@ -2549,7 +2549,7 @@ static int rename_tmp_log_callback(const char *path, void *cb)
 		 * but report EISDIR to raceproof_create_file() so
 		 * that it knows to retry.
 		 */
-		*true_errno = errno;
+		cb->true_errno = errno;
 		strbuf_release(&sb);
 		if (errno == ENOTDIR)
 			errno = EISDIR;
@@ -2560,25 +2560,27 @@ static int rename_tmp_log_callback(const char *path, void *cb)
 	}
 }
 
-static int rename_tmp_log(const char *newrefname)
+static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 {
 	struct strbuf sb = STRBUF_INIT;
+	struct rename_tmp_log_cb cb;
 	const char *path;
-	int ret, true_errno;
+	int ret;
 
-	strbuf_git_path(&sb, "logs/%s", newrefname);
+	files_path(refs, &sb, "logs/%s", newrefname);
 	path = sb.buf;
-	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
+	cb.refs = refs;
+	ret = raceproof_create_file(path, rename_tmp_log_callback, &cb);
 	if (ret) {
 		if (errno == EISDIR)
 			error("directory not empty: %s", path);
 		else {
 			struct strbuf tmp_renamed = STRBUF_INIT;
 
-			strbuf_git_path(&tmp_renamed, TMP_RENAMED_LOG);
+			files_path(refs, &tmp_renamed, TMP_RENAMED_LOG);
 			error("unable to move logfile %s to %s: %s",
 			      tmp_renamed.buf, path,
-			      strerror(true_errno));
+			      strerror(cb.true_errno));
 			strbuf_release(&tmp_renamed);
 		}
 	}
@@ -2630,7 +2632,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
 
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	files_path(refs, &sb_oldref, "logs/%s", oldrefname);
 	log = !lstat(sb_oldref.buf, &loginfo);
 	strbuf_release(&sb_oldref);
 	if (log && S_ISLNK(loginfo.st_mode))
@@ -2646,8 +2648,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	files_path(refs, &sb_oldref, "logs/%s", oldrefname);
+	files_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
 	strbuf_release(&sb_oldref);
 	strbuf_release(&tmp_renamed_log);
@@ -2674,7 +2676,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-			strbuf_git_path(&path, "%s", newrefname);
+			files_path(refs, &path, "%s", newrefname);
 			result = remove_empty_directories(&path);
 			strbuf_release(&path);
 
@@ -2688,7 +2690,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 		}
 	}
 
-	if (log && rename_tmp_log(newrefname))
+	if (log && rename_tmp_log(refs, newrefname))
 		goto rollback;
 
 	logmoved = log;
@@ -2730,12 +2732,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	files_path(refs, &sb_newref, "logs/%s", newrefname);
+	files_path(refs, &sb_oldref, "logs/%s", oldrefname);
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	files_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
@@ -2803,10 +2805,15 @@ static int open_or_create_logfile(const char *path, void *cb)
  * set *logfd to -1. On failure, fill in *err, set *logfd to -1, and
  * return -1.
  */
-static int log_ref_setup(const char *refname, int force_create,
+static int log_ref_setup(struct files_ref_store *refs,
+			 const char *refname, int force_create,
 			 int *logfd, struct strbuf *err)
 {
-	char *logfile = git_pathdup("logs/%s", refname);
+	struct strbuf sb = STRBUF_INIT;
+	char *logfile;
+
+	files_path(refs, &sb, "logs/%s", refname);
+	logfile = strbuf_detach(&sb, NULL);
 
 	if (force_create || should_autocreate_reflog(refname)) {
 		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
@@ -2856,12 +2863,11 @@ static int files_create_reflog(struct ref_store *ref_store,
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
@@ -2896,7 +2902,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+int files_log_ref_write(struct files_ref_store *refs,
+			const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err)
 {
@@ -2905,7 +2912,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates == LOG_REFS_UNSET)
 		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
-	result = log_ref_setup(refname, flags & REF_FORCE_CREATE_REFLOG,
+	result = log_ref_setup(refs, refname, flags & REF_FORCE_CREATE_REFLOG,
 			       &logfd, err);
 
 	if (result)
@@ -2919,7 +2926,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
 
-		strbuf_git_path(&sb, "logs/%s", refname);
+		files_path(refs, &sb, "logs/%s", refname);
 		strbuf_addf(err, "unable to append to '%s': %s",
 			    sb.buf, strerror(save_errno));
 		strbuf_release(&sb);
@@ -2930,7 +2937,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
 
-		strbuf_git_path(&sb, "logs/%s", refname);
+		files_path(refs, &sb, "logs/%s", refname);
 		strbuf_addf(err, "unable to append to '%s': %s",
 			    sb.buf, strerror(save_errno));
 		strbuf_release(&sb);
@@ -2991,8 +2998,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 	files_assert_main_repository(refs, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
-	if (files_log_ref_write(lock->ref_name, lock->old_oid.hash, sha1,
-				logmsg, 0, err)) {
+	if (files_log_ref_write(refs, lock->ref_name, lock->old_oid.hash,
+				sha1, logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -3023,8 +3030,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write("HEAD", lock->old_oid.hash, sha1,
-					  logmsg, 0, &log_err)) {
+			if (files_log_ref_write(refs, "HEAD", lock->old_oid.hash,
+						sha1, logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
@@ -3056,24 +3063,26 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
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
+	    files_log_ref_write(refs, refname, lock->old_oid.hash, new_sha1,
 				logmsg, 0, &err)) {
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
 
@@ -3081,7 +3090,7 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 		return error("unable to fdopen %s: %s",
 			     lock->lk->tempfile.filename.buf, strerror(errno));
 
-	update_symref_reflog(lock, refname, target, logmsg);
+	update_symref_reflog(refs, lock, refname, target, logmsg);
 
 	/* no error check; commit_ref will check ferror */
 	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
@@ -3110,13 +3119,19 @@ static int files_create_symref(struct ref_store *ref_store,
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
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
@@ -3143,7 +3158,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
 
-	ret = create_symref_locked(lock, head_rel, target, NULL);
+	ret = create_symref_locked(refs, lock, head_rel, target, NULL);
 
 	unlock_ref(lock); /* will free lock */
 	strbuf_release(&head_path);
@@ -3153,14 +3168,13 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
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
+	files_path(refs, &sb, "logs/%s", refname);
 	ret = !lstat(sb.buf, &st) && S_ISREG(st.st_mode);
 	strbuf_release(&sb);
 	return ret;
@@ -3169,13 +3183,12 @@ static int files_reflog_exists(struct ref_store *ref_store,
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
+	files_path(refs, &sb, "logs/%s", refname);
 	ret = remove_path(sb.buf);
 	strbuf_release(&sb);
 	return ret;
@@ -3225,15 +3238,14 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
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
+	files_path(refs, &sb, "logs/%s", refname);
 	logfp = fopen(sb.buf, "r");
 	strbuf_release(&sb);
 	if (!logfp)
@@ -3334,14 +3346,13 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
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
+	files_path(refs, &sb, "logs/%s", refname);
 	logfp = fopen(sb.buf, "r");
 	strbuf_release(&sb);
 	if (!logfp)
@@ -3423,15 +3434,14 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 
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
+	files_path(refs, &sb, "logs");
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	strbuf_release(&sb);
 	return ref_iterator;
@@ -3856,7 +3866,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (files_log_ref_write(lock->ref_name,
+			if (files_log_ref_write(refs,
+						lock->ref_name,
 						lock->old_oid.hash,
 						update->new_sha1,
 						update->msg, update->flags,
@@ -3894,7 +3905,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			    update->type & REF_ISSYMREF) {
 				/* It is a loose reference. */
 				strbuf_reset(&sb);
-				strbuf_git_path(&sb, "%s", lock->ref_name);
+				files_path(refs, &sb, "%s", lock->ref_name);
 				if (unlink_or_msg(sb.buf, err)) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3917,9 +3928,10 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
 		struct strbuf sb = STRBUF_INIT;
 
-		strbuf_git_path(&sb, "logs/%s", ref_to_delete->string);
+		files_path(refs, &sb, "logs/%s", ref_to_delete->string);
 		if (!unlink_or_warn(sb.buf))
-			try_remove_empty_parents(ref_to_delete->string,
+			try_remove_empty_parents(refs,
+						 ref_to_delete->string,
 						 REMOVE_EMPTY_PARENTS_REFLOG);
 		strbuf_release(&sb);
 	}
@@ -3943,7 +3955,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			 * can only work because we have already
 			 * removed the lockfile.)
 			 */
-			try_remove_empty_parents(update->refname,
+			try_remove_empty_parents(refs,
+						 update->refname,
 						 REMOVE_EMPTY_PARENTS_REF);
 		}
 	}
@@ -4098,6 +4111,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4122,7 +4136,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		return 0;
 	}
 
-	log_file = git_pathdup("logs/%s", refname);
+	files_path(refs, &sb, "logs/%s", refname);
+	log_file = strbuf_detach(&sb, NULL);
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		/*
 		 * Even though holding $GIT_DIR/logs/$reflog.lock has
@@ -4193,25 +4208,24 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "init_db");
-
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strbuf_git_path(&sb, "refs/heads");
+	files_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 	strbuf_reset(&sb);
-	strbuf_git_path(&sb, "refs/tags");
+	files_path(refs, &sb, "refs/tags");
 	safe_create_dir(sb.buf, 1);
 	strbuf_reset(&sb);
 	if (get_shared_repository()) {
-		strbuf_git_path(&sb, "refs/heads");
+		files_path(refs, &sb, "refs/heads");
 		adjust_shared_perm(sb.buf);
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "refs/tags");
+		files_path(refs, &sb, "refs/tags");
 		adjust_shared_perm(sb.buf);
 	}
 	strbuf_release(&sb);
-- 
2.11.0.157.gd943d85

