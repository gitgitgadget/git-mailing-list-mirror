Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1933F375
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511211; cv=none; b=BQvav0bGY//zrlEeEbKpDr+RhRYvWQ4l3QItJJ5C4vbzltYYXCAZH+JQ3RurXmB5f0MN8bmGL33Xg368u2zyz3wbjiev/76jc0z4ZktAez+hcohMmnV1kXbY6kT5vou1Lacf6dvDZCH7axiwrsDNw8UBXdE74LLUohjxxELkxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511211; c=relaxed/simple;
	bh=+BxoC+YYmTJmZk+S0ppaTwN85ACwkkSb2nVaMNuK0oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuPCD+acSfOs5r8A6xY3wjYLA5OpVe+rDUdnA8ku5858CykozVMX7ztiEWPf11Ngy7Om1YHk1T4HuJRpdK4N9DGHV1eaMLzWn0XW2o098/f4GcdlVOzBwzCK/hWBLIkPVTPoPh4nowvoODGvX3Nmg2kANt55hH4pcuSavYjxdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSIRBM4j; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSIRBM4j"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43767807cf3so791458f8f.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771511208; x=1772116008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ohs+2ZW/8ZpDAiuV7jbG8XRc0v+wOJSnbjb9nCxNs7Q=;
        b=lSIRBM4jERgJfc4Ct/9edEb7JyNtVzFowe9tagUdmCASYKFH/O0PN2WPVsmu6rX9Lp
         RKITgyvMh2qag79UPtvIoUcPlgDKIXIv5VQUNfY1/2v0xOc+48R0OHhYownQGbKkUO7H
         tPAe3RC2rhIyKCaesSOjzRVBTo/jL2dSET3CY9YTkBkkASM/Di60nITRQqV8xUHLIY7a
         yXIsFwWoNTuKULWqMdxGeY/Lcr8PAtgeQlBAWuc2HC/I+ZLI4EgmJAbueQlq/YmLguCm
         bNumW7ueXvrrr7UYODauHAEMB9LN6EPpnJJh9X3ppaVXmV61jRiqrqLz9c25qiI8ozCU
         nPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511208; x=1772116008;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohs+2ZW/8ZpDAiuV7jbG8XRc0v+wOJSnbjb9nCxNs7Q=;
        b=X2hB53f2ZiaAh22zOLwW7Dx00vszpvJpKIWIzCtshMp3Ye5gEainohIRKlrKxK2MwT
         sNuF6TWpQ/QKNZd7HfGV0tdrZJt8fq1cJcr9mr3hrwNed3V7PCMySKvJtYFA1katUMpA
         Vjd52IUqekZcgoAJSrBBpVKj99fk2lPyCoUq6srkdULAf6HLdAN0DlvYfj7BSSnZ9yxS
         zPU/IFBg1lKK6KWQ39Kc66ZHv4Ba6qVG6Je0it0WVauFdwIGwl1g194G5bekeOmHUydS
         dhUXYIfrSXTPuwZoxrnUDYU6QUIebOozRl34RYBdvmiG+GztzDKv7G2v/V0PynOGcggo
         KUww==
X-Gm-Message-State: AOJu0YxrsKJUYHHvXFbT90N52e7CGnx7DWqprXjbORHAuK/w+jOU5WhF
	imxxuBcmNZn6TRMmqkRlLTdnTjEt1P5Fyr4rTZtW2s+hXagmyXk7Fc+RW9VBFJ9E
X-Gm-Gg: AZuq6aKqpenXI+FokPiZnkfCA9v4RDutvYv6Kv0hhVSXgMNA0GB+Oo403OUVIGBcjkk
	9fj4GPxEfKINqeggFiDpome5zyZhzmuyR2DCZrYHp0URcd7ZaDmWnReCokcED5QS2UWwkgH9CIq
	U2NR+J2l8LKdV9i2t/EBWNKY4pd0dBYmMqQxMAotZXT7DL7HBm35clCLT640aHk8eN2a/AiKc7J
	dwqNjNu7316ztD+qUVAYHBTEwAELQlYYaA9GIF4qFJn7zg1cWddizMiHNtDUreJ28ENEM2FDSbn
	EmbODIoc3n7AfwFYDyMBUqHTBzt5T9MC6XyQwjhnUEtMXghRWAyIyMwdDo0hiGLpaIrJO8Emj/b
	t+SmzfNtR71A43QDsHzL3JgC5YSs5aMcY8g/QNJTXXZCAaWU2Svzm0bzmHAgjRUkExoyydyu/zN
	81MsYxoB3nopvCPZ4UG8TvPY2H9X8=
X-Received: by 2002:a05:600c:a09:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-48379bbc49emr283932275e9.11.1771511207850;
        Thu, 19 Feb 2026 06:26:47 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f99275esm21611135e9.32.2026.02.19.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:26:47 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/2] path: remove repository argument from worktree_git_path()
Date: Thu, 19 Feb 2026 14:26:33 +0000
Message-ID: <db9d519cbda44c46986e127e820b5b7b0ba31206.1771511192.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1771511192.git.phillip.wood@dunelm.org.uk>
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk> <cover.1771511192.git.phillip.wood@dunelm.org.uk>
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
index 218c332a66d..6e2f0f78283 100644
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

