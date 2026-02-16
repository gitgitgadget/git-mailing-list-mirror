Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377419CC28
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258724; cv=none; b=c1mHIKAvewBotopeOo9r/h8qvjv+39xCqmUbz/1yFCbZPA8vRtVXplCB8stpluNmVF8TgVNua0FqzrLlUByeRNcxy6Bmg9K3FO8lB0vU8UGJi2Yev1jfVQ0kvfw2VrD1pKxeCrDXVWJhwtvrbZCdlJg1t0rEatLVNE60s+AmmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258724; c=relaxed/simple;
	bh=OvqfsEm9Gnwt4ofYzfxHME13tXzZJmVcHgqIZbhSFSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ4hS0gLDeb3o1B6dDxid+2rJBMrUvbb6Jxjv7zpZHxQLJQ/c84DS2ySo0Sr6/BwVpucimRwcGFveBMz3dfd6ZRBgCc0b0eHDkNGjMchF5xvroovCA3k1hmiroNYrl0WCOQ+L3kZiofts8qLLy7uVH1xuPivGK49fAEekFMQ1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+qAhvFA; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+qAhvFA"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4359228b7c6so2528249f8f.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771258721; x=1771863521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ENGMK8E66Mm92JJ26peFl7vWDIwWrn5taqa8DUxuEs=;
        b=K+qAhvFAAio2fHfcJASyK5dtw6zc0VDK8+jFxDlV0+kcS/Q+P4GDzyP7/t2TvRidSA
         2z+qUWa91FyI2TOjsOnGUJ559ig3A8ShsBlUqnPrIsW756kx5PB1z5GrhJsXS7SFpRQC
         ZidBRm7qS/vnSdIZZq5z7LcAF0yb+q1l5CrYdfzRQc6j0BADyXZZkd+curme88zKHKwQ
         F4mobaeDLcYQlxt9pKzO+tUPiab4bsa54LUtkNcg7cqyvVOY3Y2jYsCJyWJjVB7ScWHK
         upczhxzOAZIEJkPEKJ2LTro3mH45WxiVKcPRZfJBIjRPMCLJfTsgI7xvCjGHkCsNeviF
         Tn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258721; x=1771863521;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ENGMK8E66Mm92JJ26peFl7vWDIwWrn5taqa8DUxuEs=;
        b=SwGTyMT3i6NacYhdybYCITGVah0/RsbLT/LmzUmpBoon1ggaUuSXq0k0hSfY499afg
         arA5OOY4jJxKLeo3YwBLpvY+5hfvDTutcohZHJSMkYGak2YnfmeP4TST8ErHSqej7IAv
         FOqLA7yEsUmX4PE/Dl/cwnOScla372so0u6/FJBILnwFIaZtC+dNfEm71b9t1SPBsr6c
         B5uoe2czvu4I2ivKQtt0F7MzmHavB1e0C6yiHTptAvrQR40aBhDaesi6rf9alyZpfiH1
         ZIMDh55ke/VMYPy43Qy29iO4qiE+dp9GACQcnenn7o8PEpRirL+qHFczNc1/QRjiEDw3
         9bHQ==
X-Gm-Message-State: AOJu0YzFJLHuebEPyDMbs9Og1ASh16Wnp13W8V+77T2Tyxwqs8vxQqW3
	IsPwUIdWKXSHTfHdw9dIJnxCX1YZMtIPh9dbp0PCAuOlQw3zD5IXiOxBjqqE8JPY
X-Gm-Gg: AZuq6aI8vgoIWhyMh11to/dkAUrlXsI+k2nfzfPYkXuUpplWyrs4pvvX0+AeDMm3irj
	vKa3OscSHcZj/ToULxbToZlMMjSwIWZMB5F12b0gNtbK2X/rKmhSVsxaxiBzIU3SQ/xsLjQld/3
	7tfPh+vs/Wuh1FgV9rZA3vbG8uCp5sErUxhp+Ja7fv7OPj8HuNeACD++jmRRYhPkBUxB/Giwxg8
	8NKpexS9Tvyfdom7jDto/p3hYfm/1q3pgaoA82lgHK3CtycENr4n674EMTn13O8fdf710GbWPBS
	40QvrHvaGdYiBIq6gRTRs6ecmModkN/N1a/vtbBU4jfzQjsI/KZ9HS7fEii5dVp9bDFXKmcku1h
	RnVSgzIo1Zc2vYULnGCzTu816sTaQz/JxN0qHi9wEQeori7/wjvKMt2ptMnzFtbA128WPMxegtY
	7SnlelE1RWa8qzTd5Sn1pL/iZZgOQ=
X-Received: by 2002:a05:6000:2f83:b0:435:975a:131c with SMTP id ffacd0b85a97d-4379db987aamr14359175f8f.36.1771258720547;
        Mon, 16 Feb 2026 08:18:40 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm29396714f8f.23.2026.02.16.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:18:40 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] path: remove repository argument from worktree_git_path()
Date: Mon, 16 Feb 2026 16:18:10 +0000
Message-ID: <23b8a355b414da2b6216a50006bf2276dd3ea6ae.1771258688.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com> <cover.1771258688.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

worktree_git_path() takes a struct repository and a struct worktree
which also contains a struct repository. The repository argument
was added by a973f60dc7c (path: stop relying on `the_repository` in
`worktree_git_path()`, 2024-08-13) and exists because the worktree
argument is optional. Having two ways of passing a repository is
a potential foot-gun as if the the worktree argument is present the
repository argument must match the worktree's repository member. Since
the last commit there are no callers that pass a NULL worktree so lets
remove the repository argument. This removes the potential confusion
and lets us delete a number of uses of "the_repository".

worktree_git_path() has the following callers:

 - builtin/worktree.c:validate_no_submodules() which is called from
   check_clean_worktree() and move_worktree(), both of which supply
   a non-NULL worktree.

 - builtin/fsck.c:cmd_fsck() which loops over all worktrees.

 - revision.c:add_index_objects_to_pending() which loops over all
   worktrees.

 - worktree.c:worktree_lock_reason() which dereferences wt before
   calling worktree_git_path().

 - wt-status.c:wt_status_check_bisect() and wt_status_check_rebase()
   which are always called with a non-NULL worktree after the last
   commit.

 - wt-status.c:git_branch() which is only called by
   wt_status_check_bisect() and wt_status_check_rebase().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/fsck.c     |  2 +-
 builtin/worktree.c |  4 ++--
 path.c             |  9 ++++-----
 path.h             |  8 +++-----
 revision.c         |  2 +-
 worktree.c         |  2 +-
 wt-status.c        | 14 +++++++-------
 7 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0512f78a87f..42ba0afb91a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1137,7 +1137,7 @@ int cmd_fsck(int argc,
 			 * and may get overwritten by other calls
 			 * while we're examining the index.
 			 */
-			path = xstrdup(worktree_git_path(the_repository, wt, "index"));
+			path = xstrdup(worktree_git_path(wt, "index"));
 			wt_gitdir = get_worktree_git_dir(wt);
 
 			read_index_from(&istate, path, wt_gitdir);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3d6547c23b4..62fd4642e5d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1191,14 +1191,14 @@ static void validate_no_submodules(const struct worktree *wt)
 
 	wt_gitdir = get_worktree_git_dir(wt);
 
-	if (is_directory(worktree_git_path(the_repository, wt, "modules"))) {
+	if (is_directory(worktree_git_path(wt, "modules"))) {
 		/*
 		 * There could be false positives, e.g. the "modules"
 		 * directory exists but is empty. But it's a rare case and
 		 * this simpler check is probably good enough for now.
 		 */
 		found_submodules = 1;
-	} else if (read_index_from(&istate, worktree_git_path(the_repository, wt, "index"),
+	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
 				   wt_gitdir) > 0) {
 		for (i = 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce = istate.cache[i];
diff --git a/path.c b/path.c
index d726537622c..073f631b914 100644
--- a/path.c
+++ b/path.c
@@ -486,17 +486,16 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
 
-const char *worktree_git_path(struct repository *r,
-			      const struct worktree *wt, const char *fmt, ...)
+const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 {
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 
-	if (wt && wt->repo != r)
-		BUG("worktree not connected to expected repository");
+	if (!wt)
+		BUG("%s() called with NULL worktree", __func__);
 
 	va_start(args, fmt);
-	repo_git_pathv(r, wt, pathname, fmt, args);
+	repo_git_pathv(wt->repo, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
diff --git a/path.h b/path.h
index 0ec95a0b079..cbcad254a0a 100644
--- a/path.h
+++ b/path.h
@@ -66,13 +66,11 @@ const char *repo_git_path_replace(struct repository *repo,
 
 /*
  * Similar to repo_git_path() but can produce paths for a specified
- * worktree instead of current one. When no worktree is given, then the path is
- * computed relative to main worktree of the given repository.
+ * worktree instead of current one.
  */
-const char *worktree_git_path(struct repository *r,
-			      const struct worktree *wt,
+const char *worktree_git_path(const struct worktree *wt,
 			      const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
+	__attribute__((format (printf, 2, 3)));
 
 /*
  * The `repo_worktree_path` family of functions will construct a path into a
diff --git a/revision.c b/revision.c
index 29972c3a198..ca3481c1902 100644
--- a/revision.c
+++ b/revision.c
@@ -1847,7 +1847,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 		wt_gitdir = get_worktree_git_dir(wt);
 
 		if (read_index_from(&istate,
-				    worktree_git_path(the_repository, wt, "index"),
+				    worktree_git_path(wt, "index"),
 				    wt_gitdir) > 0)
 			do_add_index_objects_to_pending(revs, &istate, flags);
 
diff --git a/worktree.c b/worktree.c
index fd182c319b7..efd2b75608d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -308,7 +308,7 @@ const char *worktree_lock_reason(struct worktree *wt)
 	if (!wt->lock_reason_valid) {
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&path, worktree_git_path(the_repository, wt, "locked"));
+		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
 		if (file_exists(path.buf)) {
 			struct strbuf lock_reason = STRBUF_INIT;
 			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
diff --git a/wt-status.c b/wt-status.c
index 2debda534c1..68257d6dfd2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1648,7 +1648,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
 	struct object_id oid;
 	const char *branch_name;
 
-	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
+	if (strbuf_read_file(&sb, worktree_git_path(wt, "%s", path), 0) <= 0)
 		goto got_nothing;
 
 	while (sb.len && sb.buf[sb.len - 1] == '\n')
@@ -1750,18 +1750,18 @@ int wt_status_check_rebase(const struct worktree *wt,
 	if (!wt)
 		BUG("wt_status_check_rebase() called with NULL worktree");
 
-	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
-			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
+			if (!stat(worktree_git_path(wt, "rebase-apply/patch"), &st) && !st.st_size)
 				state->am_empty_patch = 1;
 		} else {
 			state->rebase_in_progress = 1;
 			state->branch = get_branch(wt, "rebase-apply/head-name");
 			state->onto = get_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
@@ -1780,7 +1780,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 	if (!wt)
 		BUG("wt_status_check_bisect() called with NULL worktree");
 
-	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(wt, "BISECT_START");
 		return 1;
-- 
2.52.0.362.g884e03848a9

