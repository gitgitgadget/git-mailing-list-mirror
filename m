From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/13] nd/worktree-various-heads
Date: Fri, 22 Apr 2016 20:01:23 +0700
Message-ID: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:01:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ataiB-0006lT-H2
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbcDVNB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 09:01:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34283 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcDVNBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:01:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so2502486pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8rDqxURWKCJLjAaryp4Pc31ZG0s995pRvGwTwfTQmI=;
        b=wKZsT/HZehsM2ipypH06ediASHv5miW+xBZK4cyAi2wYHRPUoExb9tru6Xuu/I8M5l
         A2p9BmQRMHrUbjH2tzVyt1KynUPBDFnqb7xWjz9pqDX39A+SzWhO46cOQDstJqHjxQas
         efCuzVXLdwmv1qbl6DWUivSK5eb5llTj0W9GTjyqEbUx5B6Li0ryb9XQiWJe98BWcWf0
         S2CS+umrz2kevWpenS8jr7bjA0J/I2kGry994nK+xuXsX0D3iRXxQS/UUfRA3wfsQZdi
         Y6oqWMT7BfuHMx+p9hWqlTvF9RU6FFGNSKGzv/Oj3LP0GJur811uAdJO8nYtQnYfW1mg
         ZpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8rDqxURWKCJLjAaryp4Pc31ZG0s995pRvGwTwfTQmI=;
        b=VqgNoGjjMXOQqp+U+eiSAn5HJQ6bGoN35yFVWshbsk5oNtmquxRi1ubtl2JE3wolGU
         uX/dkXz6nT33nApzMQhzu1BrXF9k/6jwYuFx0ZcOylskHEjCVHyTKB8iVywTmCBZGaN4
         6j3AqWiNtkuoQmVTJC0Suhh20j71/AWRVYIIpKqzERE8qsGpidIhKBxGI8COt6sgwv89
         KQUuCXcotIOyOrTspSVmtYZKPTRVvSGtLAgV24VD69QfBTtlSXZ2CDqso5LWLSs/4mjr
         LDoj3Nu4OpPOHvfYiYuEj+bnyeN1/Nyro2bVr9jlIlM+RmWErTj/b67D4Huv07CKzfdf
         aTXA==
X-Gm-Message-State: AOPr4FVL9aJdFj7xZ5N5a/Ba1P9DGQc5If7o0vjEvfrzOO7kbU/SdBfPfd3u5LxSYZqvtg==
X-Received: by 10.98.27.78 with SMTP id b75mr9468719pfb.49.1461330084668;
        Fri, 22 Apr 2016 06:01:24 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id h2sm8388816pfd.91.2016.04.22.06.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:01:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:01:37 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292189>

v3 fixes all the things found in v2, deletes unused stuff and adds a
new patch 01/13 that renames str(n)cmp_icase to fspath(n)cmp.

Interdiff

diff --git a/branch.c b/branch.c
index 8e323d3..a5a8dcb 100644
--- a/branch.c
+++ b/branch.c
@@ -338,12 +338,12 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
 	const struct worktree *wt;
 
-	wt = find_shared_symref("HEAD", branch, ignore_current_worktree);
-	if (wt) {
-		skip_prefix(branch, "refs/heads/", &branch);
-		die(_("'%s' is already checked out at '%s'"),
-		    branch, wt->path);
-	}
+	wt = find_shared_symref("HEAD", branch);
+	if (!wt || (ignore_current_worktree && wt->is_current))
+		return;
+	skip_prefix(branch, "refs/heads/", &branch);
+	die(_("'%s' is already checked out at '%s'"),
+	    branch, wt->path);
 }
 
 int replace_each_worktree_head_symref(const char *oldref, const char *newref)
diff --git a/builtin/branch.c b/builtin/branch.c
index 3a2eceb..b488c3f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -221,7 +221,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const struct worktree *wt =
-				find_shared_symref("HEAD", name, 0);
+				find_shared_symref("HEAD", name);
 			if (wt) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
diff --git a/builtin/notes.c b/builtin/notes.c
index f154a69..c65b59a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -852,7 +852,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref(), 0);
+		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
 		if (wt)
 			die(_("A notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
diff --git a/dir.c b/dir.c
index 996653b..f04bd3b 100644
--- a/dir.c
+++ b/dir.c
@@ -53,13 +53,12 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
-/* helper string functions with support for the ignore_case flag */
-int strcmp_icase(const char *a, const char *b)
+int fspathcmp(const char *a, const char *b)
 {
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
 }
 
-int strncmp_icase(const char *a, const char *b, size_t count)
+int fspathncmp(const char *a, const char *b, size_t count)
 {
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
@@ -802,12 +801,12 @@ int match_basename(const char *basename, int basenamelen,
 {
 	if (prefix == patternlen) {
 		if (patternlen == basenamelen &&
-		    !strncmp_icase(pattern, basename, basenamelen))
+		    !fspathncmp(pattern, basename, basenamelen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		/* "*literal" matching against "fooliteral" */
 		if (patternlen - 1 <= basenamelen &&
-		    !strncmp_icase(pattern + 1,
+		    !fspathncmp(pattern + 1,
 				   basename + basenamelen - (patternlen - 1),
 				   patternlen - 1))
 			return 1;
@@ -844,7 +843,7 @@ int match_pathname(const char *pathname, int pathlen,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] != '/') ||
-	    strncmp_icase(pathname, base, baselen))
+	    fspathncmp(pathname, base, baselen))
 		return 0;
 
 	namelen = baselen ? pathlen - baselen - 1 : pathlen;
@@ -858,7 +857,7 @@ int match_pathname(const char *pathname, int pathlen,
 		if (prefix > namelen)
 			return 0;
 
-		if (strncmp_icase(pattern, name, prefix))
+		if (fspathncmp(pattern, name, prefix))
 			return 0;
 		pattern += prefix;
 		patternlen -= prefix;
diff --git a/dir.h b/dir.h
index 301b737..e34d555 100644
--- a/dir.h
+++ b/dir.h
@@ -270,8 +270,8 @@ extern int remove_dir_recursively(struct strbuf *path, int flag);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
-extern int strcmp_icase(const char *a, const char *b);
-extern int strncmp_icase(const char *a, const char *b, size_t count);
+extern int fspathcmp(const char *a, const char *b);
+extern int fspathncmp(const char *a, const char *b, size_t count);
 extern int fnmatch_icase(const char *pattern, const char *string, int flags);
 
 /*
diff --git a/fast-import.c b/fast-import.c
index 9fc7093..339cd38 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1512,7 +1512,7 @@ static int tree_content_set(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !fspathncmp(p, e->name->str_dat, n)) {
 			if (!*slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
@@ -1602,7 +1602,7 @@ static int tree_content_remove(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !fspathncmp(p, e->name->str_dat, n)) {
 			if (*slash1 && !S_ISDIR(e->versions[1].mode))
 				/*
 				 * If p names a file in some subdirectory, and a
@@ -1669,7 +1669,7 @@ static int tree_content_get(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !fspathncmp(p, e->name->str_dat, n)) {
 			if (!*slash1)
 				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
diff --git a/path.c b/path.c
index c421d37..8fdd187 100644
--- a/path.c
+++ b/path.c
@@ -466,16 +466,6 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 	return pathname->buf;
 }
 
-char *worktree_git_pathdup(const struct worktree *wt, const char *fmt, ...)
-{
-	struct strbuf path = STRBUF_INIT;
-	va_list args;
-	va_start(args, fmt);
-	do_git_path(wt, &path, fmt, args);
-	va_end(args);
-	return strbuf_detach(&path, NULL);
-}
-
 static void do_submodule_path(struct strbuf *buf, const char *path,
 			      const char *fmt, va_list args)
 {
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..ea6381b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -301,7 +301,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 			return -1;
 		}
 	}
-	if (!strcmp_icase(ent->base, normalized_objdir)) {
+	if (!fspathcmp(ent->base, normalized_objdir)) {
 		free(ent);
 		return -1;
 	}
diff --git a/worktree.c b/worktree.c
index 8a3d394..4817d60 100644
--- a/worktree.c
+++ b/worktree.c
@@ -151,14 +151,32 @@ done:
 	return worktree;
 }
 
+static void mark_current_worktree(struct worktree **worktrees)
+{
+	struct strbuf git_dir = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	int i;
+
+	strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
+	for (i = 0; worktrees[i]; i++) {
+		struct worktree *wt = worktrees[i];
+		strbuf_addstr(&path, absolute_path(get_worktree_git_dir(wt)));
+		wt->is_current = !fspathcmp(git_dir.buf, path.buf);
+		strbuf_reset(&path);
+		if (wt->is_current)
+			break;
+	}
+	strbuf_release(&git_dir);
+	strbuf_release(&path);
+}
+
 struct worktree **get_worktrees(void)
 {
 	struct worktree **list = NULL;
-	struct strbuf git_dir = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
-	int i, counter = 0, alloc = 2;
+	int counter = 0, alloc = 2;
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
@@ -184,17 +202,7 @@ struct worktree **get_worktrees(void)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] = NULL;
 
-	strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
-	for (i = 0; i < counter; i++) {
-		struct worktree *wt = list[i];
-		strbuf_addstr(&path, absolute_path(get_worktree_git_dir(wt)));
-		wt->is_current = !strcmp_icase(git_dir.buf, path.buf);
-		strbuf_reset(&path);
-		if (wt->is_current)
-			break;
-	}
-	strbuf_release(&git_dir);
-	strbuf_release(&path);
+	mark_current_worktree(list);
 	return list;
 }
 
@@ -241,9 +249,14 @@ int is_worktree_being_bisected(const struct worktree *wt,
 	return found_rebase;
 }
 
+/*
+ * note: this function should be able to detect shared symref even if
+ * HEAD is temporarily detached (e.g. in the middle of rebase or
+ * bisect). New commands that do similar things should update this
+ * function as well.
+ */
 const struct worktree *find_shared_symref(const char *symref,
-					  const char *target,
-					  int ignore_current_worktree)
+					  const char *target)
 {
 	const struct worktree *existing = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -258,9 +271,6 @@ const struct worktree *find_shared_symref(const char *symref,
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 
-		if (ignore_current_worktree && wt->is_current)
-			continue;
-
 		if (wt->is_detached && !strcmp(symref, "HEAD")) {
 			if (is_worktree_being_rebased(wt, target)) {
 				existing = wt;
diff --git a/worktree.h b/worktree.h
index d4a3534..1394909 100644
--- a/worktree.h
+++ b/worktree.h
@@ -36,26 +36,21 @@ extern void free_worktrees(struct worktree **);
 
 /*
  * Check if a per-worktree symref points to a ref in the main worktree
- * or any linked worktree, and return the path to the exising worktree
- * if it is. Returns NULL if there is no existing ref. The result
- * may be destroyed by the next call.
+ * or any linked worktree, and return the worktree that holds the ref,
+ * or NULL otherwise. The result may be destroyed by the next call.
  */
 extern const struct worktree *find_shared_symref(const char *symref,
-						 const char *target,
-						 int ignore_current_worktree);
+						 const char *target);
 
 int is_worktree_being_rebased(const struct worktree *wt, const char *target);
 int is_worktree_being_bisected(const struct worktree *wt, const char *target);
 
 /*
- * Similar to git_path() and git_pathdup() but can produce paths for a
- * specified worktree instead of current one
+ * Similar to git_path() but can produce paths for a specified
+ * worktree instead of current one
  */
 extern const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-extern char *worktree_git_pathdup(const struct worktree *wt,
-				  const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
 
 #endif
diff --git a/wt-status.c b/wt-status.c
index 971e071..0032ef5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1410,7 +1410,7 @@ void wt_status_get_state(struct wt_status_state *state,
 	if (!stat(git_path_merge_head(), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
-		; /* all set */
+		;		/* all set */
 	} else if (!stat(git_path_cherry_pick_head(), &st) &&
 			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
 		state->cherry_pick_in_progress = 1;

  [01/13] dir.c: rename str(n)cmp_icase to fspath(n)cmp
  [02/13] path.c: add git_common_path() and strbuf_git_common_path()
  [03/13] worktree.c: store "id" instead of "git_dir"
  [04/13] worktree.c: make find_shared_symref() return struct worktree *
  [05/13] worktree.c: mark current worktree
  [06/13] path.c: refactor and add worktree_git_path()
  [07/13] wt-status.c: split rebase detection out of wt_status_get_state()
  [08/13] wt-status.c: make wt_status_check_rebase() work on any worktree
  [09/13] worktree.c: avoid referencing to worktrees[i] multiple times
  [10/13] worktree.c: check whether branch is rebased in another worktree
  [11/13] wt-status.c: split bisect detection out of wt_status_get_state()
  [12/13] worktree.c: check whether branch is bisected in another worktree
  [13/13] branch: do not rename a branch under bisect or rebase

Total 17 files changed, 344 insertions(+), 82 deletions(-)
--
Duy
