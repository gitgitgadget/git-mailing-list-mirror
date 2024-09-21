Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1D36C
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726880563; cv=none; b=BGkrEOTD2bynxZX2TyIlL1EgwOjwlriwva5OhO9wqlKh/HR1/OI73jC8AT4NBP023QkdpZYWEHDH2ckoSH6fiC9eDXezKt8RAO9n3xUKNl0f80Skjpvnmu7Uf1kyY2XTvSwbGKp6pEZnacMiLc1joZp8g6CBf7/95smV5sloJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726880563; c=relaxed/simple;
	bh=KgztP/RJ7blG9KKMYGS+CAxyCAy2du6husw5WzRL2FU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AHSaNuD4gkDtnFUaw3zTSp7Jgj9Itz4W09ga/RChpbfibpuKtKcMZ386b58CgZ5yY+u1HfwMZaWbHtXuGBZg+YFVx6uuva10zrU6N5TpC4Yhzyt+q4sW8f8myQedDVEJ9GSX7jRaI2z5K2nx5KbFYFmttTv5QW63aB1iNzGup8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdvg+yJK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdvg+yJK"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso443728166b.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 18:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726880555; x=1727485355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fX9wFZVAEEl0OGtnxE0H/xLACcIULlykP6wIrzQRAyY=;
        b=Gdvg+yJKJl+pDFjzlAponqUh5rto8O/PJ8EdnoroO5X+b4LIIqQ7WNUklmmpE/u4Nq
         qqnc8kUcRWTNzkA51kymK64eMH7ASvmQ9Ip7fr8Ym3dFfhWjWUABObVvU4IzN54q2cYj
         pFVXvX5td6cZ5sv3XIq531j/Ba5SJIgE5WJQCqOcu0G5NZ+gEvz8p8up0xrKyRxnSmyw
         6Rce2n6KO3fVfLPyn1ZXm6IRxm/A9jFPJFcGjRZ3ckZ4QuVdmUdROXf3Ne8hl/L7cGev
         yLHa7bvYA9lEKFvjVLL987Y9WlApsrqzMD6CANuB2Uyb/tmRzaMJSgpx2nt7ZEBzDHde
         vVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726880555; x=1727485355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fX9wFZVAEEl0OGtnxE0H/xLACcIULlykP6wIrzQRAyY=;
        b=nBM861pOa8GQXI6i0vUqt8ojRNwKzAQnfMEx6D17RZwv23bisQFjCkHK67jS7V70zF
         QODJ6GhhtJlFCl/XjcagZtYD6mJzmsils+ZmQdqOhVAwcnQgW4w+AW1rN4eAbdUR/zbx
         muEMLcxmaI0OZt0qkfcXMgxBdZxlkrkTmCURLcHCQ26cWoF4Dlv9ldb7ElE8ELOKJS2f
         HqfLZd8Cm5b14aEAWgZkyF7KOTPk0k97wziHSl+GqF9qEQvOk6+4SvkVWIecr/WS/iVj
         /9UfETLTkKkhSjlAIw7SvHhAp+U7rn84Zc1D6b2G6zx+hlTKdfEZxrkYRVS78nAaJIz/
         IlsQ==
X-Gm-Message-State: AOJu0YzZ70L+6pdXjsOEdcriCMklahAevb6Sf0KDykxhGPpmUF8YuqjK
	VziJBTIdRBxnqKn6jU47V3rLCry8/dWEvocL05qvd3iUxzWSJJ4UtIU+SA==
X-Google-Smtp-Source: AGHT+IEpt+/4d1KfdRv5L/ePzdo3puAzNv9EJkLjtuofYQ3K/7iMwdPPtz3rUSEzjx/f95znU7utJg==
X-Received: by 2002:a17:907:268e:b0:a8a:754a:e1c1 with SMTP id a640c23a62f3a-a90c1c73fabmr867218366b.8.1726880553640;
        Fri, 20 Sep 2024 18:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df770sm925359066b.145.2024.09.20.18.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 18:02:33 -0700 (PDT)
Message-Id: <pull.1783.git.git.1726880551891.gitgitgadget@gmail.com>
From: "Francesco Guastella via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Sep 2024 01:02:31 +0000
Subject: [PATCH] builtin/worktree: support relative paths for worktrees
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Francesco Guastella <guastella.francesco@gmail.com>,
    Francesco Guastella <guastella.francesco@gmail.com>

From: Francesco Guastella <guastella.francesco@gmail.com>

Add a new configuration option, `worktree.useRelativePaths`, which allows
users to choose between storing relative or absolute paths in the files
Git uses to maintain links between the main worktree and any additional
ones.

By default, `git worktree add` will continue to use absolute paths,
maintaining the existing behavior and therefore ensuring compatibility.
However, when the `worktree.useRelativePaths` configuration is set to
true, all newly added worktrees will use relative paths, offering
greater flexibility, especially for repositories that are accessed from
different operating systems.

Additionally, the `git worktree move` command has been enhanced to
adhere to the current value of `worktree.useRelativePaths`. When moving
a worktree, the path formats will be adjusted to match the desired
configuration.

The `git worktree repair` command has also been updated to automatically
adjust paths between relative and absolute formats based on the
`worktree.useRelativePaths` setting.

Signed-off-by: Francesco Guastella <guastella.francesco@gmail.com>
---
    builtin/worktree: support relative paths for worktrees
    
    As of now, when creating or managing worktrees, paths are always stored
    in absolute form. While this behavior works well in many scenarios, it
    presents significant challenges when worktrees are accessed across
    different operating systems or when the repository is moved to a
    different location in the filesystem. Absolute paths hard-coded in the
    .git and gitdir files can break these links, causing issues that may
    require manual intervention to resolve.
    
    To address this, I have introduced a new configuration option:
    worktree.useRelativePaths. This option allows users to specify whether
    they prefer Git to store worktree paths in relative form rather than
    absolute. The new feature enhances Git’s flexibility, particularly in
    environments where repositories need to be portable across different
    systems or where directories are frequently relocated.
    
    Key Changes: The new worktree.useRelativePaths option can be enabled by
    the user to store paths in relative form. When enabled, any new
    worktrees added using the git worktree add command will have their paths
    stored as relative paths in the necessary git files.
    
    The git worktree move command has been updated to respect the current
    value of worktree.useRelativePaths. When a worktree is moved, Git will
    now automatically adjust the path format (relative or absolute) to match
    the user's configuration setting.
    
    The git worktree repair command has been similarly enhanced. It will now
    automatically convert paths between relative and absolute forms based on
    the worktree.useRelativePaths setting, making it easier to maintain
    consistent links across different environments.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1783%2Fromeoxbm%2Frelative-paths-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1783/romeoxbm/relative-paths-v1
Pull-Request: https://github.com/git/git/pull/1783

 Documentation/git-worktree.txt |   18 +
 abspath.c                      |   38 +
 abspath.h                      |   44 +
 builtin/mv.c                   |    6 +-
 builtin/submodule--helper.c    |    2 +-
 builtin/worktree.c             |   51 +-
 config.c                       |   10 +
 config.h                       |   15 +
 dir.c                          |  106 +-
 dir.h                          |   75 +-
 submodule.c                    |   12 +-
 t/lib-worktree.sh              |  156 +++
 t/t2400-worktree-add.sh        | 1729 +++++++++++++++++---------------
 t/t2401-worktree-prune.sh      |   96 +-
 t/t2403-worktree-move.sh       |   10 +
 t/t2406-worktree-repair.sh     |  262 ++---
 t/test-lib.sh                  |   38 +-
 worktree.c                     |   78 +-
 18 files changed, 1682 insertions(+), 1064 deletions(-)
 create mode 100644 t/lib-worktree.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 2a240f53ba7..c4f59229194 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -105,6 +105,15 @@ passed to the command. In the event the repository has a remote and
 `--guess-remote` is used, but no remote or local branches exist, then the
 command fails with a warning reminding the user to fetch from their remote
 first (or override by using `-f/--force`).
++
+By default, the `git worktree add` command links the main worktree with the
+newly created worktree using absolute paths.
+However, this behavior may not be desirable when a repository needs
+to be accessed from different operating systems. To address this, Git can
+be configured to use relative paths instead. To enable this behavior, set the
+`worktree.useRelativePaths` configuration option to `true`. Once enabled,
+all newly added worktrees will be linked using relative paths.
+
 
 list::
 
@@ -128,6 +137,11 @@ Move a worktree to a new location. Note that the main worktree or linked
 worktrees containing submodules cannot be moved with this command. (The
 `git worktree repair` command, however, can reestablish the connection
 with linked worktrees if you move the main worktree manually.)
++
+When moving a worktree, the path formats will be adjusted to align with the
+current value of `worktree.useRelativePaths`. This means that if the worktree
+was created using absolute paths and the configuration is later set to `true`,
+the link will be reestablished using relative paths during the move.
 
 prune::
 
@@ -357,6 +371,10 @@ directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
 (e.g. `/path/main/.git`). These settings are made in a `.git` file located at
 the top directory of the linked worktree.
 
+If `worktree.useRelativePaths` is enabled, the paths in this `.git` file
+will be stored in a relative format. Conversely, if it is disabled, the paths
+will be stored in an absolute format.
+
 Path resolution via `git rev-parse --git-path` uses either
 `$GIT_DIR` or `$GIT_COMMON_DIR` depending on the path. For example, in the
 linked worktree `git rev-parse --git-path HEAD` returns
diff --git a/abspath.c b/abspath.c
index 1202cde23db..7a03becce99 100644
--- a/abspath.c
+++ b/abspath.c
@@ -1,6 +1,9 @@
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "environment.h"
+#include "path.h"
 #include "strbuf.h"
+#include "worktree.h"
 
 /*
  * Do not use this for inspecting *tracked* content.  When path is a
@@ -290,6 +293,41 @@ char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
 	return prefix_filename(pfx, arg);
 }
 
+char *worktree_real_pathdup(const char *wt_path)
+{
+	struct strbuf abs_wt_path_sb = STRBUF_INIT;
+	char *retval = NULL;
+	char *git_dir_real_path = NULL;
+	char *repo_real_path = NULL;
+
+	if (!is_absolute_path(wt_path)) {
+		git_dir_real_path = real_pathdup(get_git_common_dir(), 1);
+		repo_real_path = strip_path_suffix(git_dir_real_path, ".git");
+		if (repo_real_path) {
+			strbuf_addf(&abs_wt_path_sb, "%s/%s", repo_real_path,
+				    wt_path);
+		} else {
+			strbuf_addf(&abs_wt_path_sb, "%s/%s", git_dir_real_path,
+				    wt_path);
+		}
+
+		strbuf_realpath_forgiving(&abs_wt_path_sb, abs_wt_path_sb.buf, 1);
+		retval = strbuf_detach(&abs_wt_path_sb, NULL);
+	} else {
+		retval = xstrdup(wt_path);
+	}
+
+	free(git_dir_real_path);
+	free(repo_real_path);
+	strbuf_release(&abs_wt_path_sb);
+	return retval;
+}
+
+char *worktree_real_pathdup_for_wt(struct worktree *wt)
+{
+	return worktree_real_pathdup(wt->path);
+}
+
 void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
 {
 	if (!*path)
diff --git a/abspath.h b/abspath.h
index 4653080d5e4..4163ac9c18d 100644
--- a/abspath.h
+++ b/abspath.h
@@ -1,6 +1,8 @@
 #ifndef ABSPATH_H
 #define ABSPATH_H
 
+struct worktree;
+
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
@@ -25,6 +27,48 @@ char *prefix_filename(const char *prefix, const char *path);
 /* Likewise, but path=="-" always yields "-" */
 char *prefix_filename_except_for_dash(const char *prefix, const char *path);
 
+/**
+ * worktree_real_pathdup - Duplicate the absolute path of a worktree.
+ *
+ * @wt_path: The path to the worktree. This can be either an absolute or
+ *           relative path.
+ *
+ * Return: A newly allocated string containing the absolute path. If the input
+ *         path is already absolute, it returns a duplicate of the input path.
+ *         If the path is relative, it constructs the absolute path by appending
+ *         the relative path to the repository directory. The repository
+ *         directory is derived from get_git_common_dir(), and the '.git' suffix
+ *         is removed if present.
+ *
+ *         The returned path is resolved into its canonical form using
+ *         strbuf_realpath_forgiving to handle symbolic links or non-existent
+ *         paths gracefully.
+ *
+ * The caller is responsible for freeing the returned string when it is no
+ * longer needed.
+ */
+char *worktree_real_pathdup(const char *wt_path);
+
+/**
+ * worktree_real_pathdup_for_wt - Duplicate the absolute path of a worktree from
+ *                                a worktree structure.
+ *
+ * @wt: A pointer to the worktree structure.
+ *
+ * Return: A newly allocated string containing the absolute path of the worktree.
+ *         If the worktree's path is relative, it constructs the absolute path
+ *         by appending the relative path to the repository directory (derived
+ *         from get_git_common_dir()). If the path is already absolute, it returns
+ *         a duplicate of the worktree's path.
+ *
+ * The caller is responsible for freeing the returned string when it is no
+ * longer needed.
+ *
+ * This function is similar to worktree_real_pathdup() but takes a pointer to a
+ * worktree structure instead of a raw path.
+ */
+char *worktree_real_pathdup_for_wt(struct worktree *wt);
+
 static inline int is_absolute_path(const char *path)
 {
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
diff --git a/builtin/mv.c b/builtin/mv.c
index 6c69033c5f5..8604525b85c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -490,9 +490,9 @@ remove_entry:
 			if (!update_path_in_gitmodules(src, dst))
 				gitmodules_modified = 1;
 			if (submodule_gitfiles[i] != SUBMODULE_WITH_GITDIR)
-				connect_work_tree_and_git_dir(dst,
-							      submodule_gitfiles[i],
-							      1);
+				connect_submodule_work_tree_and_git_dir(dst,
+									submodule_gitfiles[i],
+									1);
 		}
 
 		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3e0b6c45c03..98c0c1f6722 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1806,7 +1806,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		      "git dir"), sm_gitdir);
 	}
 
-	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
+	connect_submodule_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
 	p = git_pathdup_submodule(clone_data_path, "config");
 	if (!p)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e7f6a3271..d217857843e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -214,8 +214,12 @@ static void prune_worktrees(void)
 		strbuf_reset(&reason);
 		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
-		else if (path)
-			string_list_append_nodup(&kept, path)->util = xstrdup(d->d_name);
+		else if (path) {
+			string_list_append_nodup(&kept,
+						 worktree_real_pathdup(path))
+				->util = xstrdup(d->d_name);
+			free(path);
+		}
 	}
 	closedir(dir);
 
@@ -414,7 +418,7 @@ static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT, realpath = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
 	const char *name;
 	struct strvec child_env = STRVEC_INIT;
 	unsigned int counter = 0;
@@ -425,6 +429,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb_name = STRBUF_INIT;
 	struct worktree **worktrees, *wt = NULL;
 	struct ref_store *wt_refs;
+	int use_relative_paths = 0;
 
 	worktrees = get_worktrees();
 	check_candidate_path(path, opts->force, worktrees, "add");
@@ -482,19 +487,14 @@ static int add_worktree(const char *path, const char *refname,
 	else
 		write_file(sb.buf, _("initializing"));
 
-	strbuf_addf(&sb_git, "%s/.git", path);
-	if (safe_create_leading_directories_const(sb_git.buf))
-		die_errno(_("could not create leading directories of '%s'"),
-			  sb_git.buf);
 	junk_work_tree = xstrdup(path);
 
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	strbuf_realpath(&realpath, sb_git.buf, 1);
-	write_file(sb.buf, "%s", realpath.buf);
-	strbuf_realpath(&realpath, get_git_common_dir(), 1);
-	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
-		   realpath.buf, name);
+	use_relative_paths = repo_config_get_worktree_use_relative_paths(the_repository);
+	strbuf_realpath_forgiving(&sb, path, 1);
+	connect_work_tree_and_git_dir(sb.buf, sb_repo.buf, use_relative_paths);
+	connect_gitdir_file_and_work_tree(sb.buf, name, use_relative_paths);
+
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
@@ -536,6 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	if (the_repository->repository_format_worktree_config)
 		copy_filtered_worktree_config(sb_repo.buf);
 
+	strbuf_addf(&sb_git, "%s/.git", path);
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 
@@ -582,7 +583,6 @@ done:
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
 	strbuf_release(&sb_name);
-	strbuf_release(&realpath);
 	free_worktree(wt);
 	return ret;
 }
@@ -1185,8 +1185,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	int force = 0;
 	struct option options[] = {
 		OPT__FORCE(&force,
-			 N_("force move even if worktree is dirty or locked"),
-			 PARSE_OPT_NOCOMPLETE),
+			   N_("force move even if worktree is dirty or locked"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
@@ -1263,6 +1263,7 @@ static void check_clean_worktree(struct worktree *wt,
 	struct child_process cp;
 	char buf[1];
 	int ret;
+	char *absolute_wt_path = NULL;
 
 	/*
 	 * Until we sort this out, all submodules are "dirty" and
@@ -1271,15 +1272,15 @@ static void check_clean_worktree(struct worktree *wt,
 	validate_no_submodules(wt);
 
 	child_process_init(&cp);
-	strvec_pushf(&cp.env, "%s=%s/.git",
-		     GIT_DIR_ENVIRONMENT, wt->path);
-	strvec_pushf(&cp.env, "%s=%s",
-		     GIT_WORK_TREE_ENVIRONMENT, wt->path);
-	strvec_pushl(&cp.args, "status",
-		     "--porcelain", "--ignore-submodules=none",
-		     NULL);
+	absolute_wt_path = worktree_real_pathdup_for_wt(wt);
+	strvec_pushf(&cp.env, "%s=%s/.git", GIT_DIR_ENVIRONMENT,
+		     absolute_wt_path);
+	strvec_pushf(&cp.env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT,
+		     absolute_wt_path);
+	strvec_pushl(&cp.args, "status", "--porcelain",
+		     "--ignore-submodules=none", NULL);
 	cp.git_cmd = 1;
-	cp.dir = wt->path;
+	cp.dir = absolute_wt_path;
 	cp.out = -1;
 	ret = start_command(&cp);
 	if (ret)
@@ -1294,6 +1295,8 @@ static void check_clean_worktree(struct worktree *wt,
 	if (ret)
 		die_errno(_("failed to run 'git status' on '%s', code %d"),
 			  original_path, ret);
+
+	free(absolute_wt_path);
 }
 
 static int delete_git_work_tree(struct worktree *wt)
diff --git a/config.c b/config.c
index 56b5862e59d..5750d258ac9 100644
--- a/config.c
+++ b/config.c
@@ -2731,6 +2731,16 @@ int repo_config_get_expiry_in_days(struct repository *r, const char *key,
 	return -1; /* thing exists but cannot be parsed */
 }
 
+int repo_config_get_worktree_use_relative_paths(struct repository *r)
+{
+	int val;
+
+	if (!repo_config_get_maybe_bool(r, "worktree.userelativepaths", &val))
+		return val;
+
+	return 0; /* by default, absolute paths are used */
+}
+
 int repo_config_get_split_index(struct repository *r)
 {
 	int val;
diff --git a/config.h b/config.h
index d0497157c52..77e1c3812fb 100644
--- a/config.h
+++ b/config.h
@@ -678,6 +678,21 @@ int repo_config_get_expiry(struct repository *r, const char *key, char **output)
 int repo_config_get_expiry_in_days(struct repository *r, const char *key,
 				   timestamp_t *, timestamp_t now);
 
+/**
+ * Retrieves the configuration that determines if worktrees should use relative paths.
+ *
+ * This function checks the "worktree.userelativepaths" configuration.
+ * If the configuration was found and is a valid boolean value, the function returns that value.
+ * If the configuration was not found or invalid, the function returns 0,
+ * indicating that by default, absolute paths are used for worktrees.
+ *
+ * Return:
+ * - 1: If "worktree.userelativepaths" is set to true (use relative paths).
+ * - 0: If "worktree.userelativepaths" is set to false or is not set
+ *      (use absolute paths by default).
+ */
+int repo_config_get_worktree_use_relative_paths(struct repository *r);
+
 /**
  * First prints the error message specified by the caller in `err` and then
  * dies printing the line number and the file name of the highest priority
diff --git a/dir.c b/dir.c
index 5a23376bdae..49aba2c0a72 100644
--- a/dir.c
+++ b/dir.c
@@ -4041,43 +4041,117 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 		strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
 		submodule_name_to_gitdir(&sub_gd, &subrepo, sub->name);
 
-		connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 1);
+		connect_submodule_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf,
+							1);
 	}
 	strbuf_release(&sub_wt);
 	strbuf_release(&sub_gd);
 	repo_clear(&subrepo);
 }
 
-void connect_work_tree_and_git_dir(const char *work_tree_,
-				   const char *git_dir_,
-				   int recurse_into_nested)
+void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_,
+				   int use_relative_paths_)
 {
+	struct strbuf rel_path_sb = STRBUF_INIT;
 	struct strbuf gitfile_sb = STRBUF_INIT;
+	char *git_dir = NULL, *work_tree = NULL;
+	const char *rel_path = NULL;
+	int free_gitdir = 0;
+
+	work_tree = worktree_real_pathdup(work_tree_);
+	strbuf_addf(&gitfile_sb, "%s/.git", work_tree);
+	if (safe_create_leading_directories_const(gitfile_sb.buf))
+		die(_("could not create directories for %s"), gitfile_sb.buf);
+
+	if (!is_absolute_path(git_dir_)) {
+		git_dir = real_pathdup(git_dir_, 1);
+		free_gitdir = 1;
+	} else
+		git_dir = (char *)git_dir_;
+
+	if (use_relative_paths_) {
+		rel_path = relative_path(git_dir, work_tree, &rel_path_sb);
+
+		/* Write a relative path */
+		write_file(gitfile_sb.buf, "gitdir: %s", rel_path);
+	} else {
+		/* Write an absolute path */
+		write_file(gitfile_sb.buf, "gitdir: %s", git_dir);
+	}
+
+	if (free_gitdir)
+		free(git_dir);
+
+	free(work_tree);
+	strbuf_release(&rel_path_sb);
+	strbuf_release(&gitfile_sb);
+}
+
+void connect_gitdir_file_and_work_tree(const char *wt_dir_,
+				       const char *wt_name_,
+				       int use_relative_paths_)
+{
+	struct strbuf gitdirfile_sb = STRBUF_INIT;
+	struct strbuf rel_path_sb = STRBUF_INIT;
+	char *git_dir_real_path = NULL;
+	char *repo_real_path = NULL, *work_tree = NULL;
+	const char *rel_path = NULL;
+
+	git_path_buf(&gitdirfile_sb, "worktrees/%s/gitdir", wt_name_);
+	if (safe_create_leading_directories_const(gitdirfile_sb.buf)) {
+		die(_("could not create directories for %s"),
+		    gitdirfile_sb.buf);
+	}
+
+	work_tree = worktree_real_pathdup(wt_dir_);
+	if (use_relative_paths_) {
+		git_dir_real_path = real_pathdup(get_git_common_dir(), 1);
+		repo_real_path = strip_path_suffix(git_dir_real_path, ".git");
+		if (repo_real_path) {
+			rel_path = relative_path(work_tree, repo_real_path,
+						 &rel_path_sb);
+		} else {
+			rel_path = relative_path(work_tree, git_dir_real_path,
+						 &rel_path_sb);
+		}
+
+		/* Write a relative path */
+		write_file(gitdirfile_sb.buf, "%s/.git", rel_path);
+	} else {
+		/* Write an absolute path */
+		write_file(gitdirfile_sb.buf, "%s/.git", work_tree);
+	}
+
+	free(repo_real_path);
+	free(work_tree);
+	free(git_dir_real_path);
+	strbuf_release(&rel_path_sb);
+	strbuf_release(&gitdirfile_sb);
+}
+
+void connect_submodule_work_tree_and_git_dir(const char *work_tree_,
+					     const char *git_dir_,
+					     int recurse_into_nested)
+{
 	struct strbuf cfg_sb = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
 	char *git_dir, *work_tree;
 
-	/* Prepare .git file */
-	strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
-	if (safe_create_leading_directories_const(gitfile_sb.buf))
-		die(_("could not create directories for %s"), gitfile_sb.buf);
+	git_dir = real_pathdup(git_dir_, 1);
+	work_tree = real_pathdup(work_tree_, 1);
+
+	/* Write .git file */
+	connect_work_tree_and_git_dir(work_tree, git_dir, 1);
 
 	/* Prepare config file */
 	strbuf_addf(&cfg_sb, "%s/config", git_dir_);
 	if (safe_create_leading_directories_const(cfg_sb.buf))
 		die(_("could not create directories for %s"), cfg_sb.buf);
 
-	git_dir = real_pathdup(git_dir_, 1);
-	work_tree = real_pathdup(work_tree_, 1);
-
-	/* Write .git file */
-	write_file(gitfile_sb.buf, "gitdir: %s",
-		   relative_path(git_dir, work_tree, &rel_path));
 	/* Update core.worktree setting */
 	git_config_set_in_file(cfg_sb.buf, "core.worktree",
 			       relative_path(work_tree, git_dir, &rel_path));
 
-	strbuf_release(&gitfile_sb);
 	strbuf_release(&cfg_sb);
 	strbuf_release(&rel_path);
 
@@ -4097,7 +4171,7 @@ void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
 		die_errno(_("could not migrate git directory from '%s' to '%s'"),
 			old_git_dir, new_git_dir);
 
-	connect_work_tree_and_git_dir(path, new_git_dir, 0);
+	connect_submodule_work_tree_and_git_dir(path, new_git_dir, 0);
 }
 
 int path_match_flags(const char *const str, const enum path_match_flags flags)
diff --git a/dir.h b/dir.h
index a3a2f00f5d9..56e8224167e 100644
--- a/dir.h
+++ b/dir.h
@@ -597,6 +597,75 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
 
+/**
+ * connect_work_tree_and_git_dir - Create a .git file in the worktree that
+ *                                 points to the main repository.
+ *
+ * @work_tree_: The path to the worktree that needs to be connected. This can
+ *              be either an absolute or relative path.
+ * @git_dir_: The path to the main repository's git directory (.git). This can
+ *            be either an absolute or relative path.
+ * @use_relative_paths_: Flag indicating whether to use relative paths when
+ *                       creating the connection. If non-zero, a relative path
+ *                       between the git directory and the worktree is used.
+ *                       Otherwise, absolute paths are used.
+ *
+ * This function creates a `.git` file in the specified worktree directory,
+ * which contains either a relative or absolute path pointing back to the main
+ * repository's .git directory. This connection allows the worktree to function
+ * as an independent working directory while still being linked to the main
+ * repository.
+ *
+ * If `use_relative_paths_` is set to non-zero, the function writes a relative
+ * path from the worktree to the git directory in the `.git` file. If the
+ * worktree path is provided as a relative path, it is first converted to an
+ * absolute path before determining the relative path.
+ *
+ * If `use_relative_paths_` is zero, the function writes an absolute path to
+ * the git directory in the `.git` file.
+ *
+ * In case of any errors during directory creation or file writing, the
+ * function terminates execution with an error message.
+ */
+void connect_work_tree_and_git_dir(const char *work_tree_,
+				   const char *git_dir_,
+				   int use_relative_paths_);
+
+/**
+ * connect_gitdir_file_and_work_tree - Connect a gitdir file to a worktree.
+ *
+ * @wt_dir_: The path to the worktree directory. This can be either an
+ *           absolute or relative path.
+ * @wt_name_: The name of the worktree as it appears in the git repository's
+ *            worktrees directory.
+ * @use_relative_paths_: Flag indicating whether to use relative paths when
+ *                       creating the connection. If non-zero, a relative path
+ *                       between the git directory and the worktree is used.
+ *                       Otherwise, absolute paths are used.
+ *
+ * This function creates a gitdir file in the git repository's worktrees
+ * directory, which contains a path to the worktree directory. The path
+ * can be relative or absolute based on the value of `use_relative_paths_`.
+ *
+ * The gitdir file is created under the worktrees directory with a name that
+ * matches the `wt_name_` parameter. The file contains a reference to the
+ * worktree's `.git` file.
+ *
+ * If `use_relative_paths_` is set to non-zero, the function writes a relative
+ * path from the repository root to the worktree in the gitdir file. If the
+ * worktree path is provided as a relative path, it is first converted to an
+ * absolute path before determining the relative path.
+ *
+ * If `use_relative_paths_` is zero, the function writes an absolute path to
+ * the work tree in the gitdir file.
+ *
+ * In case of any errors during directory creation or file writing, the
+ * function terminates execution with an error message.
+ */
+void connect_gitdir_file_and_work_tree(const char *wt_dir_,
+				       const char *wt_name_,
+				       int use_relative_paths_);
+
 /*
  * Connect a worktree to a git directory by creating (or overwriting) a
  * '.git' file containing the location of the git directory. In the git
@@ -604,9 +673,9 @@ void remove_untracked_cache(struct index_state *istate);
  * When `recurse_into_nested` is set, recurse into any nested submodules,
  * connecting them as well.
  */
-void connect_work_tree_and_git_dir(const char *work_tree,
-				   const char *git_dir,
-				   int recurse_into_nested);
+void connect_submodule_work_tree_and_git_dir(const char *work_tree,
+					     const char *git_dir,
+					     int recurse_into_nested);
 void relocate_gitdir(const char *path,
 		     const char *old_git_dir,
 		     const char *new_git_dir);
diff --git a/submodule.c b/submodule.c
index 97516b0fec1..1b3c6bde4a9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1672,7 +1672,7 @@ get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
 		 * core.worktree when they are populated/unpopulated by
 		 * "git checkout" (and similar commands, see
 		 * submodule_move_head() and
-		 * connect_work_tree_and_git_dir()), but if the
+		 * connect_submodule_work_tree_and_git_dir()), but if the
 		 * submodule is unpopulated in another way (e.g. "git
 		 * rm", "rm -r"), core.worktree will still be set even
 		 * though the directory doesn't exist, and the child
@@ -2147,7 +2147,7 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
 		/*
 		 * Pass non NULL pointer to is_submodule_populated_gently
-		 * to prevent die()-ing. We'll use connect_work_tree_and_git_dir
+		 * to prevent die()-ing. We'll use connect_submodule_work_tree_and_git_dir
 		 * to fixup the submodule in the force case later.
 		 */
 		error_code_ptr = &error_code;
@@ -2194,7 +2194,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 				die(_("refusing to create/use '%s' in another "
 				      "submodule's git dir"),
 				    gitdir.buf);
-			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
+			connect_submodule_work_tree_and_git_dir(path,
+								gitdir.buf, 0);
 			strbuf_release(&gitdir);
 
 			/* make sure the index is clean as well */
@@ -2205,7 +2206,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
 						 sub->name);
-			connect_work_tree_and_git_dir(path, gitdir.buf, 1);
+			connect_submodule_work_tree_and_git_dir(path,
+								gitdir.buf, 1);
 			strbuf_release(&gitdir);
 		}
 	}
@@ -2457,7 +2459,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		submodule_name_to_gitdir(&sub_gitdir, the_repository, sub->name);
-		connect_work_tree_and_git_dir(path, sub_gitdir.buf, 0);
+		connect_submodule_work_tree_and_git_dir(path, sub_gitdir.buf, 0);
 		strbuf_release(&sub_gitdir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
diff --git a/t/lib-worktree.sh b/t/lib-worktree.sh
new file mode 100644
index 00000000000..245612b6e4d
--- /dev/null
+++ b/t/lib-worktree.sh
@@ -0,0 +1,156 @@
+# Helper functions for git worktree tests
+
+# is_absolute_path - Determine if a given path is absolute.
+#
+# This function checks if the provided path is an absolute path.
+# It handles Unix-like and Windows-style paths.
+#
+# Parameters:
+# $1 - The path to check.
+#
+# Returns:
+# 0 if the path is absolute.
+# 1 if the path is relative.
+is_absolute_path() {
+	local path="$1"
+
+	# Check for Unix-style absolute path (starts with /)
+	case "$path" in
+		/*) return 0 ;;
+	esac
+
+	# Check for Windows-style absolute path with backslashes (starts with drive letter followed by :\)
+	case "$path" in
+		[a-zA-Z]:\\*) return 0 ;;
+	esac
+
+	# Check for Windows-style absolute path with forward slashes (starts with drive letter followed by :/)
+	case "$path" in
+		[a-zA-Z]:/*) return 0 ;;
+	esac
+
+	return 1
+}
+
+# check_worktree_paths - Verify the format of the worktree paths.
+#
+# This function checks whether the paths specified in the worktree's
+# configuration files (.git and gitdir files) are in the expected format,
+# based on the provided configuration for relative or absolute paths.
+#
+# Parameters:
+# $1 - Boolean value ("true" or "false") indicating whether relative paths
+#      are expected. If "true", the function expects relative paths; otherwise,
+#      it expects absolute paths.
+# $2 - The path to the worktree directory.
+#
+# Functionality:
+# - Reads the .git file in the specified worktree directory to extract the path
+#   to the gitdir file.
+# - Determines whether the extracted path is relative or absolute based
+#   on the value of $1.
+# - Checks if the gitdir file exists and if its contents match the expected path
+#   format (relative or absolute).
+# - Verify that the path in the gitdir file points back to the original worktree .git file.
+# - Prints an error message and returns a non-zero exit code if any issues are
+#   found, such as missing files or incorrect path formats.
+# - Returns 0 if all checks pass and the paths are in the expected format.
+check_worktree_paths() {
+	local func_name="check_worktree_paths"
+	local use_relative_paths="$1"
+	local worktree_path="$2"
+	if [ -d "$worktree_path" ]; then
+		worktree_path="$(cd "$worktree_path" && pwd -P)"
+	else
+		echo "[$func_name] Error: Directory "$worktree_path" does not exist."
+		return 1
+	fi
+
+	# Full path to the .git file in the worktree
+	local git_file="$worktree_path/.git"
+
+	# Check if the .git file exists
+	if [ ! -f "$git_file" ]; then
+		echo "[$func_name] Error: .git file not found in $worktree_path"
+		return 1
+	fi
+
+	# Extract the path from the .git file
+	local gitdir_path="$(sed 's/^gitdir: //' "$git_file")"
+
+	# Check if the path is absolute or relative
+	if [ "$use_relative_paths" = "true" ]; then
+		# Ensure the path is relative
+		if is_absolute_path "$gitdir_path"; then
+			echo "[$func_name] Error: .git file contains an absolute path when a relative path was expected."
+			echo "[$func_name] Path read from .git file: $gitdir_path"
+			return 1
+		fi
+	else
+		# Ensure the path is absolute
+		if ! is_absolute_path "$gitdir_path"; then
+			echo "[$func_name] Error: .git file contains a relative path when an absolute path was expected."
+			echo "[$func_name] Path read from .git file: $gitdir_path"
+			return 1
+		fi
+	fi
+
+	# Resolve the gitdir path relative to worktree if necessary
+	if ! is_absolute_path "$gitdir_path"; then
+		gitdir_path="$(cd "$worktree_path"/"$gitdir_path" && pwd -P)"
+	fi
+
+	# Verify if gitdir_path is correct and the gitdir file exists
+	local gitdir_file="$gitdir_path/gitdir"
+	if [ ! -f "$gitdir_file" ]; then
+		echo "[$func_name] Error: $gitdir_file not found"
+		return 1
+	fi
+
+	# Read the stored path from the gitdir file
+	local stored_path="$(cat "$gitdir_file")"
+
+	if [ "$use_relative_paths" = "true" ]; then
+		# Ensure the path is relative
+		if is_absolute_path "$stored_path"; then
+			echo "[$func_name] Error: $gitdir_file contains an absolute path when a relative path was expected."
+			echo "[$func_name] Path read from gitdir file: $stored_path"
+			return 1
+		fi
+	else
+		# Ensure the path is absolute
+		if ! is_absolute_path "$stored_path"; then
+			echo "[$func_name] Error: $gitdir_file contains a relative path when an absolute path was expected."
+			echo "[$func_name] Path read from gitdir file: $stored_path"
+			return 1
+		fi
+	fi
+
+	# Resolve the stored_path path to an absolute path
+	if ! is_absolute_path "$stored_path"; then
+		# Determine the repo dir, by removing the /.git/worktrees/<worktree_dir> or /worktrees/<worktree_dir> part
+		local repo_dir="${gitdir_path%/*/*}"
+		repo_dir="${repo_dir%/.git}"
+
+		# If repo_dir is a relative path, resolve it against worktree_path
+		if ! is_absolute_path "$repo_dir"; then
+			repo_dir="$(cd "$worktree_path/$repo_dir" && pwd -P)"
+		fi
+
+		stored_path="$(cd "$(dirname "$repo_dir/$stored_path")" && pwd -P)/.git"
+		if [ ! -f "$stored_path" ]; then
+			echo "[$func_name] Error: File $stored_path does not exist."
+			return 1
+		fi
+	fi
+
+	# Verify that the stored_path points back to the original worktree .git file
+	if [ "$stored_path" != "$git_file" ]; then
+		echo "[$func_name]  Error: The gitdir file does not correctly reference the original .git file."
+		echo "Expected: $git_file"
+		echo "Found: $stored_path"
+		return 1
+	fi
+
+	return 0
+}
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798..ca9bbf0aac5 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -10,421 +10,21 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
+. "$TEST_DIRECTORY"/lib-worktree.sh
 
-test_expect_success 'setup' '
-	test_commit init
-'
-
-test_expect_success '"add" an existing worktree' '
-	mkdir -p existing/subtree &&
-	test_must_fail git worktree add --detach existing main
-'
-
-test_expect_success '"add" an existing empty worktree' '
-	mkdir existing_empty &&
-	git worktree add --detach existing_empty main
-'
-
-test_expect_success '"add" using shorthand - fails when no previous branch' '
-	test_must_fail git worktree add existing_short -
-'
-
-test_expect_success '"add" using - shorthand' '
-	git checkout -b newbranch &&
-	echo hello >myworld &&
-	git add myworld &&
-	git commit -m myworld &&
-	git checkout main &&
-	git worktree add short-hand - &&
-	echo refs/heads/newbranch >expect &&
-	git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success '"add" refuses to checkout locked branch' '
-	test_must_fail git worktree add zere main &&
-	! test -d zere &&
-	! test -d .git/worktrees/zere
-'
-
-test_expect_success 'checking out paths not complaining about linked checkouts' '
-	(
-	cd existing_empty &&
-	echo dirty >>init.t &&
-	git checkout main -- init.t
-	)
-'
-
-test_expect_success '"add" worktree' '
-	git rev-parse HEAD >expect &&
-	git worktree add --detach here main &&
-	(
-		cd here &&
-		test_cmp ../init.t init.t &&
-		test_must_fail git symbolic-ref HEAD &&
-		git rev-parse HEAD >actual &&
-		test_cmp ../expect actual &&
-		git fsck
-	)
-'
-
-test_expect_success '"add" worktree with lock' '
-	git worktree add --detach --lock here-with-lock main &&
-	test_when_finished "git worktree unlock here-with-lock || :" &&
-	test -f .git/worktrees/here-with-lock/locked
-'
-
-test_expect_success '"add" worktree with lock and reason' '
-	lock_reason="why not" &&
-	git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
-	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
-	test -f .git/worktrees/here-with-lock-reason/locked &&
-	echo "$lock_reason" >expect &&
-	test_cmp expect .git/worktrees/here-with-lock-reason/locked
-'
-
-test_expect_success '"add" worktree with reason but no lock' '
-	test_must_fail git worktree add --detach --reason "why not" here-with-reason-only main &&
-	test_path_is_missing .git/worktrees/here-with-reason-only/locked
-'
-
-test_expect_success '"add" worktree from a subdir' '
-	(
-		mkdir sub &&
-		cd sub &&
-		git worktree add --detach here main &&
-		cd here &&
-		test_cmp ../../init.t init.t
-	)
-'
-
-test_expect_success '"add" from a linked checkout' '
-	(
-		cd here &&
-		git worktree add --detach nested-here main &&
-		cd nested-here &&
-		git fsck
-	)
-'
-
-test_expect_success '"add" worktree creating new branch' '
-	git worktree add -b newmain there main &&
-	(
-		cd there &&
-		test_cmp ../init.t init.t &&
-		git symbolic-ref HEAD >actual &&
-		echo refs/heads/newmain >expect &&
-		test_cmp expect actual &&
-		git fsck
-	)
-'
-
-test_expect_success 'die the same branch is already checked out' '
-	(
-		cd here &&
-		test_must_fail git checkout newmain 2>actual &&
-		grep "already used by worktree at" actual
-	)
-'
-
-test_expect_success 'refuse to reset a branch in use elsewhere' '
-	(
-		cd here &&
-
-		# we know we are on detached HEAD but just in case ...
-		git checkout --detach HEAD &&
-		git rev-parse --verify HEAD >old.head &&
-
-		git rev-parse --verify refs/heads/newmain >old.branch &&
-		test_must_fail git checkout -B newmain 2>error &&
-		git rev-parse --verify refs/heads/newmain >new.branch &&
-		git rev-parse --verify HEAD >new.head &&
-
-		grep "already used by worktree at" error &&
-		test_cmp old.branch new.branch &&
-		test_cmp old.head new.head &&
-
-		# and we must be still on the same detached HEAD state
-		test_must_fail git symbolic-ref HEAD
-	)
-'
-
-test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
-	head=$(git -C there rev-parse --git-path HEAD) &&
-	ref=$(git -C there symbolic-ref HEAD) &&
-	rm "$head" &&
-	ln -s "$ref" "$head" &&
-	test_must_fail git -C here checkout newmain
-'
-
-test_expect_success 'not die the same branch is already checked out' '
-	(
-		cd here &&
-		git worktree add --force anothernewmain newmain
-	)
-'
-
-test_expect_success 'not die on re-checking out current branch' '
-	(
-		cd there &&
-		git checkout newmain
-	)
-'
-
-test_expect_success '"add" from a bare repo' '
-	(
-		git clone --bare . bare &&
-		cd bare &&
-		git worktree add -b bare-main ../there2 main
-	)
-'
-
-test_expect_success 'checkout from a bare repo without "add"' '
-	(
-		cd bare &&
-		test_must_fail git checkout main
-	)
-'
-
-test_expect_success '"add" default branch of a bare repo' '
-	(
-		git clone --bare . bare2 &&
-		cd bare2 &&
-		git worktree add ../there3 main &&
-		cd ../there3 &&
-		# Simple check that a Git command does not
-		# immediately fail with the current setup
-		git status
-	) &&
-	cat >expect <<-EOF &&
-	init.t
-	EOF
-	ls there3 >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success '"add" to bare repo with worktree config' '
-	(
-		git clone --bare . bare3 &&
-		cd bare3 &&
-		git config extensions.worktreeconfig true &&
-
-		# Add config values that are erroneous to have in
-		# a config.worktree file outside of the main
-		# working tree, to check that Git filters them out
-		# when copying config during "git worktree add".
-		git config --worktree core.bare true &&
-		git config --worktree core.worktree "$(pwd)" &&
-
-		# We want to check that bogus.key is copied
-		git config --worktree bogus.key value &&
-		git config --unset core.bare &&
-		git worktree add ../there4 main &&
-		cd ../there4 &&
-
-		# Simple check that a Git command does not
-		# immediately fail with the current setup
-		git status &&
-		git worktree add --detach ../there5 &&
-		cd ../there5 &&
-		git status
-	) &&
-
-	# the worktree has the arbitrary value copied.
-	test_cmp_config -C there4 value bogus.key &&
-	test_cmp_config -C there5 value bogus.key &&
-
-	# however, core.bare and core.worktree were removed.
-	test_must_fail git -C there4 config core.bare &&
-	test_must_fail git -C there4 config core.worktree &&
-
-	cat >expect <<-EOF &&
-	init.t
-	EOF
-
-	ls there4 >actual &&
-	test_cmp expect actual &&
-	ls there5 >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'checkout with grafts' '
-	test_when_finished rm .git/info/grafts &&
-	test_commit abc &&
-	SHA1=$(git rev-parse HEAD) &&
-	test_commit def &&
-	test_commit xyz &&
-	mkdir .git/info &&
-	echo "$(git rev-parse HEAD) $SHA1" >.git/info/grafts &&
-	cat >expected <<-\EOF &&
-	xyz
-	abc
-	EOF
-	git log --format=%s -2 >actual &&
-	test_cmp expected actual &&
-	git worktree add --detach grafted main &&
-	git --git-dir=grafted/.git log --format=%s -2 >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success '"add" from relative HEAD' '
-	test_commit a &&
-	test_commit b &&
-	test_commit c &&
-	git rev-parse HEAD~1 >expected &&
-	git worktree add relhead HEAD~1 &&
-	git -C relhead rev-parse HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success '"add -b" with <branch> omitted' '
-	git worktree add -b burble flornk &&
-	test_cmp_rev HEAD burble
-'
-
-test_expect_success '"add --detach" with <branch> omitted' '
-	git worktree add --detach fishhook &&
-	git rev-parse HEAD >expected &&
-	git -C fishhook rev-parse HEAD >actual &&
-	test_cmp expected actual &&
-	test_must_fail git -C fishhook symbolic-ref HEAD
-'
-
-test_expect_success '"add" with <branch> omitted' '
-	git worktree add wiffle/bat &&
-	test_cmp_rev HEAD bat
-'
-
-test_expect_success '"add" checks out existing branch of dwimd name' '
-	git branch dwim HEAD~1 &&
-	git worktree add dwim &&
-	test_cmp_rev HEAD~1 dwim &&
-	(
-		cd dwim &&
-		test_cmp_rev HEAD dwim
-	)
-'
-
-test_expect_success '"add <path>" dwim fails with checked out branch' '
-	git checkout -b test-branch &&
-	test_must_fail git worktree add test-branch &&
-	test_path_is_missing test-branch
-'
-
-test_expect_success '"add --force" with existing dwimd name doesnt die' '
-	git checkout test-branch &&
-	git worktree add --force test-branch
-'
-
-test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
-	git worktree add --detach mish/mash &&
-	test_must_fail git rev-parse mash -- &&
-	test_must_fail git -C mish/mash symbolic-ref HEAD
-'
 
 # Helper function to test mutually exclusive options.
 #
 # Note: Quoted arguments containing spaces are not supported.
 test_wt_add_excl () {
-	local opts="$*" &&
+	local opts="$*"
+
 	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
 		test_must_fail git worktree add $opts 2>actual &&
 		grep -E "fatal:( options)? .* cannot be used together" actual
 	'
 }
 
-test_wt_add_excl -b poodle -B poodle bamboo main
-test_wt_add_excl -b poodle --detach bamboo main
-test_wt_add_excl -B poodle --detach bamboo main
-test_wt_add_excl --orphan --detach bamboo
-test_wt_add_excl --orphan --no-checkout bamboo
-test_wt_add_excl --orphan bamboo main
-test_wt_add_excl --orphan -b bamboo wtdir/ main
-
-test_expect_success '"add -B" fails if the branch is checked out' '
-	git rev-parse newmain >before &&
-	test_must_fail git worktree add -B newmain bamboo main &&
-	git rev-parse newmain >after &&
-	test_cmp before after
-'
-
-test_expect_success 'add -B' '
-	git worktree add -B poodle bamboo2 main^ &&
-	git -C bamboo2 symbolic-ref HEAD >actual &&
-	echo refs/heads/poodle >expected &&
-	test_cmp expected actual &&
-	test_cmp_rev main^ poodle
-'
-
-test_expect_success 'add --quiet' '
-	test_when_finished "git worktree remove -f -f another-worktree" &&
-	git worktree add --quiet another-worktree main 2>actual &&
-	test_must_be_empty actual
-'
-
-test_expect_success 'add --quiet -b' '
-	test_when_finished "git branch -D quietnewbranch" &&
-	test_when_finished "git worktree remove -f -f another-worktree" &&
-	git worktree add --quiet -b quietnewbranch another-worktree 2>actual &&
-	test_must_be_empty actual
-'
-
-test_expect_success '"add --orphan"' '
-	test_when_finished "git worktree remove -f -f orphandir" &&
-	git worktree add --orphan -b neworphan orphandir &&
-	echo refs/heads/neworphan >expected &&
-	git -C orphandir symbolic-ref HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success '"add --orphan (no -b)"' '
-	test_when_finished "git worktree remove -f -f neworphan" &&
-	git worktree add --orphan neworphan &&
-	echo refs/heads/neworphan >expected &&
-	git -C neworphan symbolic-ref HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success '"add --orphan --quiet"' '
-	test_when_finished "git worktree remove -f -f orphandir" &&
-	git worktree add --quiet --orphan -b neworphan orphandir 2>log.actual &&
-	test_must_be_empty log.actual &&
-	echo refs/heads/neworphan >expected &&
-	git -C orphandir symbolic-ref HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success '"add --orphan" fails if the branch already exists' '
-	test_when_finished "git branch -D existingbranch" &&
-	git worktree add -b existingbranch orphandir main &&
-	git worktree remove orphandir &&
-	test_must_fail git worktree add --orphan -b existingbranch orphandir
-'
-
-test_expect_success '"add --orphan" with empty repository' '
-	test_when_finished "rm -rf empty_repo" &&
-	echo refs/heads/newbranch >expected &&
-	GIT_DIR="empty_repo" git init --bare &&
-	git -C empty_repo worktree add --orphan -b newbranch worktreedir &&
-	git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success '"add" worktree with orphan branch and lock' '
-	git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
-	test_when_finished "git worktree unlock orphan-with-lock || :" &&
-	test -f .git/worktrees/orphan-with-lock/locked
-'
-
-test_expect_success '"add" worktree with orphan branch, lock, and reason' '
-	lock_reason="why not" &&
-	git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
-	test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
-	test -f .git/worktrees/orphan-with-lock-reason/locked &&
-	echo "$lock_reason" >expect &&
-	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
-'
-
 # Note: Quoted arguments containing spaces are not supported.
 test_wt_add_orphan_hint () {
 	local context="$1" &&
@@ -449,100 +49,6 @@ test_wt_add_orphan_hint () {
 	'
 }
 
-test_wt_add_orphan_hint 'no opts' 0
-test_wt_add_orphan_hint '-b' 1 -b foobar_branch
-test_wt_add_orphan_hint '-B' 1 -B foobar_branch
-
-test_expect_success "'worktree add' doesn't show orphan hint in bad/orphan HEAD w/ --quiet" '
-	test_when_finished "rm -rf repo" &&
-	git init repo &&
-	(cd repo && test_commit commit) &&
-	test_must_fail git -C repo worktree add --quiet foobar_branch foobar/ 2>actual &&
-	! grep "error: unknown switch" actual &&
-	! grep "hint: If you meant to create a worktree containing a new unborn branch" actual
-'
-
-test_expect_success 'local clone from linked checkout' '
-	git clone --local here here-clone &&
-	( cd here-clone && git fsck )
-'
-
-test_expect_success 'local clone --shared from linked checkout' '
-	git -C bare worktree add --detach ../baretree &&
-	git clone --local --shared baretree bare-clone &&
-	grep /bare/ bare-clone/.git/objects/info/alternates
-'
-
-test_expect_success '"add" worktree with --no-checkout' '
-	git worktree add --no-checkout -b swamp swamp &&
-	! test -e swamp/init.t &&
-	git -C swamp reset --hard &&
-	test_cmp init.t swamp/init.t
-'
-
-test_expect_success '"add" worktree with --checkout' '
-	git worktree add --checkout -b swmap2 swamp2 &&
-	test_cmp init.t swamp2/init.t
-'
-
-test_expect_success 'put a worktree under rebase' '
-	git worktree add under-rebase &&
-	(
-		cd under-rebase &&
-		set_fake_editor &&
-		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-		git worktree list >actual &&
-		grep "under-rebase.*detached HEAD" actual
-	)
-'
-
-test_expect_success 'add a worktree, checking out a rebased branch' '
-	test_must_fail git worktree add new-rebase under-rebase &&
-	! test -d new-rebase
-'
-
-test_expect_success 'checking out a rebased branch from another worktree' '
-	git worktree add new-place &&
-	test_must_fail git -C new-place checkout under-rebase
-'
-
-test_expect_success 'not allow to delete a branch under rebase' '
-	(
-		cd under-rebase &&
-		test_must_fail git branch -D under-rebase
-	)
-'
-
-test_expect_success 'rename a branch under rebase not allowed' '
-	test_must_fail git branch -M under-rebase rebase-with-new-name
-'
-
-test_expect_success 'check out from current worktree branch ok' '
-	(
-		cd under-rebase &&
-		git checkout under-rebase &&
-		git checkout - &&
-		git rebase --abort
-	)
-'
-
-test_expect_success 'checkout a branch under bisect' '
-	git worktree add under-bisect &&
-	(
-		cd under-bisect &&
-		git bisect start &&
-		git bisect bad &&
-		git bisect good HEAD~2 &&
-		git worktree list >actual &&
-		grep "under-bisect.*detached HEAD" actual &&
-		test_must_fail git worktree add new-bisect under-bisect &&
-		! test -d new-bisect
-	)
-'
-
-test_expect_success 'rename a branch under bisect not allowed' '
-	test_must_fail git branch -M under-bisect bisect-with-new-name
-'
 # Is branch "refs/heads/$1" set to pull from "$2/$3"?
 test_branch_upstream () {
 	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
@@ -553,12 +59,6 @@ test_branch_upstream () {
 	test_cmp expect.upstream actual.upstream
 }
 
-test_expect_success '--track sets up tracking' '
-	test_when_finished rm -rf track &&
-	git worktree add --track -b track track main &&
-	test_branch_upstream track . main
-'
-
 # setup remote repository $1 and repository $2 with $1 set up as
 # remote.  The remote has two branches, main and foo.
 setup_remote_repo () {
@@ -580,157 +80,6 @@ setup_remote_repo () {
 	)
 }
 
-test_expect_success '"add" <path> <remote/branch> w/ no HEAD' '
-	test_when_finished rm -rf repo_upstream repo_local foo &&
-	setup_remote_repo repo_upstream repo_local &&
-	git -C repo_local config --bool core.bare true &&
-	git -C repo_local branch -D main &&
-	git -C repo_local worktree add ./foo repo_upstream/foo
-'
-
-test_expect_success '--no-track avoids setting up tracking' '
-	test_when_finished rm -rf repo_upstream repo_local foo &&
-	setup_remote_repo repo_upstream repo_local &&
-	(
-		cd repo_local &&
-		git worktree add --no-track -b foo ../foo repo_upstream/foo
-	) &&
-	(
-		cd foo &&
-		test_must_fail git config "branch.foo.remote" &&
-		test_must_fail git config "branch.foo.merge" &&
-		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
-	)
-'
-
-test_expect_success '"add" <path> <non-existent-branch> fails' '
-	test_must_fail git worktree add foo non-existent
-'
-
-test_expect_success '"add" <path> <branch> dwims' '
-	test_when_finished rm -rf repo_upstream repo_dwim foo &&
-	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
-	(
-		cd repo_dwim &&
-		git worktree add ../foo foo
-	) &&
-	(
-		cd foo &&
-		test_branch_upstream foo repo_upstream foo &&
-		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
-	)
-'
-
-test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
-	test_when_finished rm -rf repo_upstream repo_dwim foo &&
-	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
-	(
-		cd repo_dwim &&
-		git remote add repo_upstream2 ../repo_upstream &&
-		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
-		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
-		git status -uno --porcelain >status.actual &&
-		test_must_be_empty status.actual
-	) &&
-	(
-		cd foo &&
-		test_branch_upstream foo repo_upstream foo &&
-		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
-	)
-'
-
-test_expect_success 'git worktree add does not match remote' '
-	test_when_finished rm -rf repo_a repo_b foo &&
-	setup_remote_repo repo_a repo_b &&
-	(
-		cd repo_b &&
-		git worktree add ../foo
-	) &&
-	(
-		cd foo &&
-		test_must_fail git config "branch.foo.remote" &&
-		test_must_fail git config "branch.foo.merge" &&
-		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
-	)
-'
-
-test_expect_success 'git worktree add --guess-remote sets up tracking' '
-	test_when_finished rm -rf repo_a repo_b foo &&
-	setup_remote_repo repo_a repo_b &&
-	(
-		cd repo_b &&
-		git worktree add --guess-remote ../foo
-	) &&
-	(
-		cd foo &&
-		test_branch_upstream foo repo_a foo &&
-		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
-	)
-'
-test_expect_success 'git worktree add --guess-remote sets up tracking (quiet)' '
-	test_when_finished rm -rf repo_a repo_b foo &&
-	setup_remote_repo repo_a repo_b &&
-	(
-		cd repo_b &&
-		git worktree add --quiet --guess-remote ../foo 2>actual &&
-		test_must_be_empty actual
-	) &&
-	(
-		cd foo &&
-		test_branch_upstream foo repo_a foo &&
-		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
-	)
-'
-
-test_expect_success 'git worktree --no-guess-remote (quiet)' '
-	test_when_finished rm -rf repo_a repo_b foo &&
-	setup_remote_repo repo_a repo_b &&
-	(
-		cd repo_b &&
-		git worktree add --quiet --no-guess-remote ../foo
-	) &&
-	(
-		cd foo &&
-		test_must_fail git config "branch.foo.remote" &&
-		test_must_fail git config "branch.foo.merge" &&
-		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
-	)
-'
-
-test_expect_success 'git worktree add with worktree.guessRemote sets up tracking' '
-	test_when_finished rm -rf repo_a repo_b foo &&
-	setup_remote_repo repo_a repo_b &&
-	(
-		cd repo_b &&
-		git config worktree.guessRemote true &&
-		git worktree add ../foo
-	) &&
-	(
-		cd foo &&
-		test_branch_upstream foo repo_a foo &&
-		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
-	)
-'
-
-test_expect_success 'git worktree --no-guess-remote option overrides config' '
-	test_when_finished rm -rf repo_a repo_b foo &&
-	setup_remote_repo repo_a repo_b &&
-	(
-		cd repo_b &&
-		git config worktree.guessRemote true &&
-		git worktree add --no-guess-remote ../foo
-	) &&
-	(
-		cd foo &&
-		test_must_fail git config "branch.foo.remote" &&
-		test_must_fail git config "branch.foo.merge" &&
-		test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
-	)
-'
-
 test_dwim_orphan () {
 	local info_text="No possible source branch, inferring '--orphan'" &&
 	local fetch_error_text="fatal: No local or remote refs exist despite at least one remote" &&
@@ -751,10 +100,11 @@ test_dwim_orphan () {
 	local use_detach=0 &&
 	local use_new_branch=0 &&
 
-	local outcome="$1" &&
+	local use_relative_paths="$1" &&
+	local outcome="$2" &&
 	local outcome_text &&
 	local success &&
-	shift &&
+	shift 2 &&
 	local args="" &&
 	local context="" &&
 	case "$outcome" in
@@ -791,25 +141,25 @@ test_dwim_orphan () {
 			use_cd=0 &&
 			git_ns="repo" &&
 			dashc_args="-C $git_ns" &&
-			context="$context, 'git -C repo'"
+			context="$context, 'git -C $git_ns'"
 			;;
 		"-C_wt")
 			use_cd=0 &&
 			git_ns="wt" &&
 			dashc_args="-C $git_ns" &&
-			context="$context, 'git -C wt'"
+			context="$context, 'git -C $git_ns'"
 			;;
 		"cd_repo")
 			use_cd=1 &&
 			git_ns="repo" &&
 			dashc_args="" &&
-			context="$context, 'cd repo && git'"
+			context="$context, 'cd $git_ns && git'"
 			;;
 		"cd_wt")
 			use_cd=1 &&
 			git_ns="wt" &&
 			dashc_args="" &&
-			context="$context, 'cd wt && git'"
+			context="$context, 'cd $git_ns && git'"
 			;;
 
 		# Bypass the "pull first" warning
@@ -948,6 +298,7 @@ test_dwim_orphan () {
 		then
 			test_when_finished "git -C repo worktree remove -f ../wt" &&
 			git -C repo worktree add --orphan -b main ../wt &&
+			check_worktree_paths "$use_relative_paths" wt &&
 			(cd wt && test_commit commit) &&
 			if [ $bad_head -eq 1 ]
 			then
@@ -956,7 +307,8 @@ test_dwim_orphan () {
 		elif [ $local_ref -eq 0 ] && [ "$git_ns" = "wt" ]
 		then
 			test_when_finished "git -C repo worktree remove -f ../wt" &&
-			git -C repo worktree add --orphan -b orphanbranch ../wt
+			git -C repo worktree add --orphan -b orphanbranch ../wt &&
+			check_worktree_paths "$use_relative_paths" wt
 		fi &&
 
 		if [ $remote -eq 1 ]
@@ -977,13 +329,18 @@ test_dwim_orphan () {
 			test_when_finished git -C repo worktree remove ../foo
 		fi &&
 		(
+			local wt_prefix &&
 			if [ $use_cd -eq 1 ]
 			then
-				cd $git_ns
+				cd $git_ns &&
+				wt_prefix=".."
+			else
+				wt_prefix="."
 			fi &&
 			if [ "$outcome" = "infer" ]
 			then
 				git $dashc_args worktree add $args 2>actual &&
+				check_worktree_paths "$use_relative_paths" "$wt_prefix/foo" &&
 				if [ $use_quiet -eq 1 ]
 				then
 					test_must_be_empty actual
@@ -993,6 +350,7 @@ test_dwim_orphan () {
 			elif [ "$outcome" = "no_infer" ]
 			then
 				git $dashc_args worktree add $args 2>actual &&
+				check_worktree_paths "$use_relative_paths" "$wt_prefix/foo" &&
 				if [ $use_quiet -eq 1 ]
 				then
 					test_must_be_empty actual
@@ -1042,169 +400,906 @@ test_dwim_orphan () {
 	'
 }
 
-for quiet_mode in "no_quiet" "quiet"
-do
-	for changedir_type in "cd_repo" "cd_wt" "-C_repo" "-C_wt"
-	do
-		dwim_test_args="$quiet_mode $changedir_type"
-		test_dwim_orphan 'infer' $dwim_test_args no_-b
-		test_dwim_orphan 'no_infer' $dwim_test_args no_-b local_ref good_head
-		test_dwim_orphan 'infer' $dwim_test_args no_-b no_local_ref no_remote no_remote_ref no_guess_remote
-		test_dwim_orphan 'infer' $dwim_test_args no_-b no_local_ref remote no_remote_ref no_guess_remote
-		test_dwim_orphan 'fetch_error' $dwim_test_args no_-b no_local_ref remote no_remote_ref guess_remote
-		test_dwim_orphan 'infer' $dwim_test_args no_-b no_local_ref remote no_remote_ref guess_remote force
-		test_dwim_orphan 'no_infer' $dwim_test_args no_-b no_local_ref remote remote_ref guess_remote
-
-		test_dwim_orphan 'infer' $dwim_test_args -b
-		test_dwim_orphan 'no_infer' $dwim_test_args -b local_ref good_head
-		test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref no_remote no_remote_ref no_guess_remote
-		test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote no_remote_ref no_guess_remote
-		test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote no_remote_ref guess_remote
-		test_dwim_orphan 'infer' $dwim_test_args -b no_local_ref remote remote_ref guess_remote
-
-		test_dwim_orphan 'warn_bad_head' $dwim_test_args no_-b local_ref bad_head
-		test_dwim_orphan 'warn_bad_head' $dwim_test_args -b local_ref bad_head
-		test_dwim_orphan 'warn_bad_head' $dwim_test_args detach local_ref bad_head
-	done
-
-	test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode no_-b no_checkout
-	test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode no_-b track
-	test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode -b no_checkout
-	test_dwim_orphan 'fatal_orphan_bad_combo' $quiet_mode -b track
-done
-
 post_checkout_hook () {
 	test_when_finished "rm -rf .git/hooks" &&
 	mkdir .git/hooks &&
-	test_hook -C "$1" post-checkout <<-\EOF
+	test_hook -C "$1" post-checkout <<-'EOF'
 	{
 		echo $*
 		git rev-parse --git-dir --show-toplevel
 	} >hook.actual
-	EOF
+EOF
 }
 
-test_expect_success '"add" invokes post-checkout hook (branch)' '
-	post_checkout_hook &&
-	{
-		echo $ZERO_OID $(git rev-parse HEAD) 1 &&
-		echo $(pwd)/.git/worktrees/gumby &&
-		echo $(pwd)/gumby
-	} >hook.expect &&
-	git worktree add gumby &&
-	test_cmp hook.expect gumby/hook.actual
-'
-
-test_expect_success '"add" invokes post-checkout hook (detached)' '
-	post_checkout_hook &&
-	{
-		echo $ZERO_OID $(git rev-parse HEAD) 1 &&
-		echo $(pwd)/.git/worktrees/grumpy &&
-		echo $(pwd)/grumpy
-	} >hook.expect &&
-	git worktree add --detach grumpy &&
-	test_cmp hook.expect grumpy/hook.actual
-'
-
-test_expect_success '"add --no-checkout" suppresses post-checkout hook' '
-	post_checkout_hook &&
-	rm -f hook.actual &&
-	git worktree add --no-checkout gloopy &&
-	test_path_is_missing gloopy/hook.actual
-'
-
-test_expect_success '"add" in other worktree invokes post-checkout hook' '
-	post_checkout_hook &&
-	{
-		echo $ZERO_OID $(git rev-parse HEAD) 1 &&
-		echo $(pwd)/.git/worktrees/guppy &&
-		echo $(pwd)/guppy
-	} >hook.expect &&
-	git -C gloopy worktree add --detach ../guppy &&
-	test_cmp hook.expect guppy/hook.actual
-'
-
-test_expect_success '"add" in bare repo invokes post-checkout hook' '
-	rm -rf bare &&
-	git clone --bare . bare &&
-	{
-		echo $ZERO_OID $(git --git-dir=bare rev-parse HEAD) 1 &&
-		echo $(pwd)/bare/worktrees/goozy &&
-		echo $(pwd)/goozy
-	} >hook.expect &&
-	post_checkout_hook bare &&
-	git -C bare worktree add --detach ../goozy &&
-	test_cmp hook.expect goozy/hook.actual
-'
-
-test_expect_success '"add" an existing but missing worktree' '
-	git worktree add --detach pneu &&
-	test_must_fail git worktree add --detach pneu &&
-	rm -fr pneu &&
-	test_must_fail git worktree add --detach pneu &&
-	git worktree add --force --detach pneu
-'
-
-test_expect_success '"add" an existing locked but missing worktree' '
-	git worktree add --detach gnoo &&
-	git worktree lock gnoo &&
-	test_when_finished "git worktree unlock gnoo || :" &&
-	rm -fr gnoo &&
-	test_must_fail git worktree add --detach gnoo &&
-	test_must_fail git worktree add --force --detach gnoo &&
-	git worktree add --force --force --detach gnoo
-'
-
-test_expect_success '"add" not tripped up by magic worktree matching"' '
-	# if worktree "sub1/bar" exists, "git worktree add bar" in distinct
-	# directory `sub2` should not mistakenly complain that `bar` is an
-	# already-registered worktree
-	mkdir sub1 sub2 &&
-	git -C sub1 --git-dir=../.git worktree add --detach bozo &&
-	git -C sub2 --git-dir=../.git worktree add --detach bozo
-'
-
-test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
-	git worktree add --detach ".  weird*..?.lock.lock" &&
-	test -d .git/worktrees/---weird-.-
-'
-
-test_expect_success '"add" should not fail because of another bad worktree' '
-	git init add-fail &&
-	(
-		cd add-fail &&
-		test_commit first &&
-		mkdir sub &&
-		git worktree add sub/to-be-deleted &&
-		rm -rf sub &&
-		git worktree add second
-	)
-'
-
-test_expect_success '"add" with uninitialized submodule, with submodule.recurse unset' '
-	test_config_global protocol.file.allow always &&
-	test_create_repo submodule &&
-	test_commit -C submodule first &&
-	test_create_repo project &&
-	git -C project submodule add ../submodule &&
-	git -C project add submodule &&
-	test_tick &&
-	git -C project commit -m add_sub &&
-	git clone project project-clone &&
-	git -C project-clone worktree add ../project-2
-'
-test_expect_success '"add" with uninitialized submodule, with submodule.recurse set' '
-	git -C project-clone -c submodule.recurse worktree add ../project-3
-'
-
-test_expect_success '"add" with initialized submodule, with submodule.recurse unset' '
-	test_config_global protocol.file.allow always &&
-	git -C project-clone submodule update --init &&
-	git -C project-clone worktree add ../project-4
-'
-
-test_expect_success '"add" with initialized submodule, with submodule.recurse set' '
-	git -C project-clone -c submodule.recurse worktree add ../project-5
-'
+run_worktree_add_tests() {
+	local use_relative_paths="$1"
+
+	# Set the Git config variable based on the parameter
+	test_config_global worktree.userelativepaths "$use_relative_paths"
+
+	test_expect_success 'setup' '
+		test_commit init
+	'
+
+	test_expect_success '"add" an existing worktree' '
+		mkdir -p existing/subtree &&
+		test_must_fail git worktree add --detach existing main
+	'
+
+	test_expect_success '"add" an existing empty worktree' '
+		mkdir existing_empty &&
+		git worktree add --detach existing_empty main &&
+		check_worktree_paths "$use_relative_paths" existing_empty
+	'
+
+	test_expect_success '"add" using shorthand - fails when no previous branch' '
+		test_must_fail git worktree add existing_short -
+	'
+
+	test_expect_success '"add" using - shorthand' '
+		git checkout -b newbranch &&
+		echo hello >myworld &&
+		git add myworld &&
+		git commit -m myworld &&
+		git checkout main &&
+		git worktree add short-hand - &&
+		echo refs/heads/newbranch >expect &&
+		git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&
+		test_cmp expect actual &&
+		check_worktree_paths "$use_relative_paths" short-hand
+	'
+
+	test_expect_success '"add" refuses to checkout locked branch' '
+		test_must_fail git worktree add zere main &&
+		! test -d zere &&
+		! test -d .git/worktrees/zere
+	'
+
+	test_expect_success 'checking out paths not complaining about linked checkouts' '
+		(
+		cd existing_empty &&
+		echo dirty >>init.t &&
+		git checkout main -- init.t
+		)
+	'
+
+	test_expect_success '"add" worktree' '
+		git rev-parse HEAD >expect &&
+		git worktree add --detach here main &&
+		(
+			cd here &&
+			test_cmp ../init.t init.t &&
+			test_must_fail git symbolic-ref HEAD &&
+			git rev-parse HEAD >actual &&
+			test_cmp ../expect actual &&
+			git fsck
+		) &&
+		check_worktree_paths "$use_relative_paths" here
+	'
+
+	test_expect_success '"add" worktree with lock' '
+		git worktree add --detach --lock here-with-lock main &&
+		test_when_finished "git worktree unlock here-with-lock || :" &&
+		test -f .git/worktrees/here-with-lock/locked &&
+		check_worktree_paths "$use_relative_paths" here-with-lock
+	'
+
+	test_expect_success '"add" worktree with lock and reason' '
+		lock_reason="why not" &&
+		git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
+		test_when_finished "git worktree unlock here-with-lock-reason || :" &&
+		test -f .git/worktrees/here-with-lock-reason/locked &&
+		echo "$lock_reason" >expect &&
+		test_cmp expect .git/worktrees/here-with-lock-reason/locked &&
+		check_worktree_paths "$use_relative_paths" here-with-lock-reason
+	'
+
+	test_expect_success '"add" worktree with reason but no lock' '
+		test_must_fail git worktree add --detach --reason "why not" here-with-reason-only main &&
+		test_path_is_missing .git/worktrees/here-with-reason-only/locked
+	'
+
+	test_expect_success '"add" worktree from a subdir' '
+		(
+			mkdir sub &&
+			cd sub &&
+			git worktree add --detach here main &&
+			cd here &&
+			test_cmp ../../init.t init.t &&
+			check_worktree_paths "$use_relative_paths" .
+		)
+	'
+
+	test_expect_success '"add" from a linked checkout' '
+		(
+			cd here &&
+			git worktree add --detach nested-here main &&
+			cd nested-here &&
+			git fsck &&
+			check_worktree_paths "$use_relative_paths" .
+		)
+	'
+
+	test_expect_success '"add" worktree creating new branch' '
+		git worktree add -b newmain there main &&
+		(
+			cd there &&
+			test_cmp ../init.t init.t &&
+			git symbolic-ref HEAD >actual &&
+			echo refs/heads/newmain >expect &&
+			test_cmp expect actual &&
+			git fsck &&
+			check_worktree_paths "$use_relative_paths" .
+		)
+	'
+
+	test_expect_success 'die the same branch is already checked out' '
+		(
+			cd here &&
+			test_must_fail git checkout newmain 2>actual &&
+			grep "already used by worktree at" actual
+		)
+	'
+
+	test_expect_success 'refuse to reset a branch in use elsewhere' '
+		(
+			cd here &&
+
+			# we know we are on detached HEAD but just in case ...
+			git checkout --detach HEAD &&
+			git rev-parse --verify HEAD >old.head &&
+
+			git rev-parse --verify refs/heads/newmain >old.branch &&
+			test_must_fail git checkout -B newmain 2>error &&
+			git rev-parse --verify refs/heads/newmain >new.branch &&
+			git rev-parse --verify HEAD >new.head &&
+
+			grep "already used by worktree at" error &&
+			test_cmp old.branch new.branch &&
+			test_cmp old.head new.head &&
+
+			# and we must be still on the same detached HEAD state
+			test_must_fail git symbolic-ref HEAD
+		)
+	'
+
+	test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
+		head=$(git -C there rev-parse --git-path HEAD) &&
+		ref=$(git -C there symbolic-ref HEAD) &&
+		rm "$head" &&
+		ln -s "$ref" "$head" &&
+		test_must_fail git -C here checkout newmain
+	'
+
+	test_expect_success 'not die the same branch is already checked out' '
+		(
+			cd here &&
+			git worktree add --force anothernewmain newmain &&
+			check_worktree_paths "$use_relative_paths" anothernewmain
+		)
+	'
+
+	test_expect_success 'not die on re-checking out current branch' '
+		(
+			cd there &&
+			git checkout newmain
+		)
+	'
+
+	test_expect_success '"add" from a bare repo' '
+		(
+			git clone --bare . bare &&
+			cd bare &&
+			git worktree add -b bare-main ../there2 main &&
+			check_worktree_paths "$use_relative_paths" ../there2
+		)
+	'
+
+	test_expect_success 'checkout from a bare repo without "add"' '
+		(
+			cd bare &&
+			test_must_fail git checkout main
+		)
+	'
+
+	test_expect_success '"add" default branch of a bare repo' '
+		(
+			git clone --bare . bare2 &&
+			cd bare2 &&
+			git worktree add ../there3 main &&
+			check_worktree_paths "$use_relative_paths" ../there3 &&
+			cd ../there3 &&
+			# Simple check that a Git command does not
+			# immediately fail with the current setup
+			git status
+		) &&
+		cat >expect <<-EOF &&
+		init.t
+		EOF
+		ls there3 >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success '"add" to bare repo with worktree config' '
+		(
+			git clone --bare . bare3 &&
+			cd bare3 &&
+			git config extensions.worktreeconfig true &&
+
+			# Add config values that are erroneous to have in
+			# a config.worktree file outside of the main
+			# working tree, to check that Git filters them out
+			# when copying config during "git worktree add".
+			git config --worktree core.bare true &&
+			git config --worktree core.worktree "$(pwd)" &&
+
+			# We want to check that bogus.key is copied
+			git config --worktree bogus.key value &&
+			git config --unset core.bare &&
+			git worktree add ../there4 main &&
+			check_worktree_paths "$use_relative_paths" ../there4 &&
+			cd ../there4 &&
+
+			# Simple check that a Git command does not
+			# immediately fail with the current setup
+			git status &&
+			git worktree add --detach ../there5 &&
+			check_worktree_paths "$use_relative_paths" ../there5 &&
+			cd ../there5 &&
+			git status
+		) &&
+
+		# the worktree has the arbitrary value copied.
+		test_cmp_config -C there4 value bogus.key &&
+		test_cmp_config -C there5 value bogus.key &&
+
+		# however, core.bare and core.worktree were removed.
+		test_must_fail git -C there4 config core.bare &&
+		test_must_fail git -C there4 config core.worktree &&
+
+		cat >expect <<-EOF &&
+		init.t
+		EOF
+
+		ls there4 >actual &&
+		test_cmp expect actual &&
+		ls there5 >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success 'checkout with grafts' '
+		test_when_finished rm .git/info/grafts &&
+		test_commit abc &&
+		SHA1=$(git rev-parse HEAD) &&
+		test_commit def &&
+		test_commit xyz &&
+		mkdir .git/info &&
+		echo "$(git rev-parse HEAD) $SHA1" >.git/info/grafts &&
+		cat >expected <<-\EOF &&
+		xyz
+		abc
+		EOF
+		git log --format=%s -2 >actual &&
+		test_cmp expected actual &&
+		git worktree add --detach grafted main &&
+		check_worktree_paths "$use_relative_paths" grafted &&
+		git --git-dir=grafted/.git log --format=%s -2 >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success '"add" from relative HEAD' '
+		test_commit a &&
+		test_commit b &&
+		test_commit c &&
+		git rev-parse HEAD~1 >expected &&
+		git worktree add relhead HEAD~1 &&
+		check_worktree_paths "$use_relative_paths" relhead &&
+		git -C relhead rev-parse HEAD >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success '"add -b" with <branch> omitted' '
+		git worktree add -b burble flornk &&
+		check_worktree_paths "$use_relative_paths" flornk &&
+		test_cmp_rev HEAD burble
+	'
+
+	test_expect_success '"add --detach" with <branch> omitted' '
+		git worktree add --detach fishhook &&
+		check_worktree_paths "$use_relative_paths" fishhook &&
+		git rev-parse HEAD >expected &&
+		git -C fishhook rev-parse HEAD >actual &&
+		test_cmp expected actual &&
+		test_must_fail git -C fishhook symbolic-ref HEAD
+	'
+
+	test_expect_success '"add" with <branch> omitted' '
+		git worktree add wiffle/bat &&
+		check_worktree_paths "$use_relative_paths" wiffle/bat &&
+		test_cmp_rev HEAD bat
+	'
+
+	test_expect_success '"add" checks out existing branch of dwimd name' '
+		git branch dwim HEAD~1 &&
+		git worktree add dwim &&
+		check_worktree_paths "$use_relative_paths" dwim &&
+		test_cmp_rev HEAD~1 dwim &&
+		(
+			cd dwim &&
+			test_cmp_rev HEAD dwim
+		)
+	'
+
+	test_expect_success '"add <path>" dwim fails with checked out branch' '
+		git checkout -b test-branch &&
+		test_must_fail git worktree add test-branch &&
+		test_path_is_missing test-branch
+	'
+
+	test_expect_success '"add --force" with existing dwimd name doesnt die' '
+		git checkout test-branch &&
+		git worktree add --force test-branch
+	'
+
+	test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
+		git worktree add --detach mish/mash &&
+		check_worktree_paths "$use_relative_paths" mish/mash &&
+		test_must_fail git rev-parse mash -- &&
+		test_must_fail git -C mish/mash symbolic-ref HEAD
+	'
+
+	test_expect_success '"add -B" fails if the branch is checked out' '
+		git rev-parse newmain >before &&
+		test_must_fail git worktree add -B newmain bamboo main &&
+		git rev-parse newmain >after &&
+		test_cmp before after
+	'
+
+	test_expect_success 'add -B' '
+		git worktree add -B poodle bamboo2 main^ &&
+		check_worktree_paths "$use_relative_paths" bamboo2 &&
+		git -C bamboo2 symbolic-ref HEAD >actual &&
+		echo refs/heads/poodle >expected &&
+		test_cmp expected actual &&
+		test_cmp_rev main^ poodle
+	'
+
+	test_expect_success 'add --quiet' '
+		test_when_finished "git worktree remove -f -f another-worktree" &&
+		git worktree add --quiet another-worktree main 2>actual &&
+		check_worktree_paths "$use_relative_paths" another-worktree &&
+		test_must_be_empty actual
+	'
+
+	test_expect_success 'add --quiet -b' '
+		test_when_finished "git branch -D quietnewbranch" &&
+		test_when_finished "git worktree remove -f -f another-worktree" &&
+		git worktree add --quiet -b quietnewbranch another-worktree 2>actual &&
+		check_worktree_paths "$use_relative_paths" another-worktree &&
+		test_must_be_empty actual
+	'
+
+	test_expect_success '"add --orphan"' '
+		test_when_finished "git worktree remove -f -f orphandir" &&
+		git worktree add --orphan -b neworphan orphandir &&
+		check_worktree_paths "$use_relative_paths" orphandir &&
+		echo refs/heads/neworphan >expected &&
+		git -C orphandir symbolic-ref HEAD >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success '"add --orphan (no -b)"' '
+		test_when_finished "git worktree remove -f -f neworphan" &&
+		git worktree add --orphan neworphan &&
+		check_worktree_paths "$use_relative_paths" neworphan &&
+		echo refs/heads/neworphan >expected &&
+		git -C neworphan symbolic-ref HEAD >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success '"add --orphan --quiet"' '
+		test_when_finished "git worktree remove -f -f orphandir" &&
+		git worktree add --quiet --orphan -b neworphan orphandir 2>log.actual &&
+		check_worktree_paths "$use_relative_paths" orphandir &&
+		test_must_be_empty log.actual &&
+		echo refs/heads/neworphan >expected &&
+		git -C orphandir symbolic-ref HEAD >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success '"add --orphan" fails if the branch already exists' '
+		test_when_finished "git branch -D existingbranch" &&
+		git worktree add -b existingbranch orphandir main &&
+		check_worktree_paths "$use_relative_paths" orphandir &&
+		git worktree remove orphandir &&
+		test_must_fail git worktree add --orphan -b existingbranch orphandir
+	'
+
+	test_expect_success '"add --orphan" with empty repository' '
+		test_when_finished "rm -rf empty_repo" &&
+		echo refs/heads/newbranch >expected &&
+		GIT_DIR="empty_repo" git init --bare &&
+		git -C empty_repo worktree add --orphan -b newbranch worktreedir &&
+		check_worktree_paths "$use_relative_paths" empty_repo/worktreedir &&
+		git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success '"add" worktree with orphan branch and lock' '
+		git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
+		check_worktree_paths "$use_relative_paths" orphan-with-lock &&
+		test_when_finished "git worktree unlock orphan-with-lock || :" &&
+		test -f .git/worktrees/orphan-with-lock/locked
+	'
+
+	test_expect_success '"add" worktree with orphan branch, lock, and reason' '
+		lock_reason="why not" &&
+		git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
+		check_worktree_paths "$use_relative_paths" orphan-with-lock-reason &&
+		test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
+		test -f .git/worktrees/orphan-with-lock-reason/locked &&
+		echo "$lock_reason" >expect &&
+		test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
+	'
+
+	test_expect_success "'worktree add' doesn't show orphan hint in bad/orphan HEAD w/ --quiet" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(cd repo && test_commit commit) &&
+		test_must_fail git -C repo worktree add --quiet foobar_branch foobar/ 2>actual &&
+		! grep "error: unknown switch" actual &&
+		! grep "hint: If you meant to create a worktree containing a new unborn branch" actual
+	'
+
+	test_expect_success 'local clone from linked checkout' '
+		git clone --local here here-clone &&
+		( cd here-clone && git fsck )
+	'
+
+	test_expect_success 'local clone --shared from linked checkout' '
+		git -C bare worktree add --detach ../baretree &&
+		check_worktree_paths "$use_relative_paths" baretree &&
+		git clone --local --shared baretree bare-clone &&
+		grep /bare/ bare-clone/.git/objects/info/alternates
+	'
+
+	test_expect_success '"add" worktree with --no-checkout' '
+		git worktree add --no-checkout -b swamp swamp &&
+		check_worktree_paths "$use_relative_paths" swamp &&
+		! test -e swamp/init.t &&
+		git -C swamp reset --hard &&
+		test_cmp init.t swamp/init.t
+	'
+
+	test_expect_success '"add" worktree with --checkout' '
+		git worktree add --checkout -b swmap2 swamp2 &&
+		check_worktree_paths "$use_relative_paths" swamp2 &&
+		test_cmp init.t swamp2/init.t
+	'
+
+	test_expect_success 'put a worktree under rebase' '
+		git worktree add under-rebase &&
+		check_worktree_paths "$use_relative_paths" under-rebase &&
+		(
+			cd under-rebase &&
+			set_fake_editor &&
+			FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+			git worktree list >actual &&
+			grep "under-rebase.*detached HEAD" actual
+		)
+	'
+
+	test_expect_success 'add a worktree, checking out a rebased branch' '
+		test_must_fail git worktree add new-rebase under-rebase &&
+		! test -d new-rebase
+	'
+
+	test_expect_success 'checking out a rebased branch from another worktree' '
+		git worktree add new-place &&
+		check_worktree_paths "$use_relative_paths" new-place &&
+		test_must_fail git -C new-place checkout under-rebase
+	'
+
+	test_expect_success 'not allow to delete a branch under rebase' '
+		(
+			cd under-rebase &&
+			test_must_fail git branch -D under-rebase
+		)
+	'
+
+	test_expect_success 'rename a branch under rebase not allowed' '
+		test_must_fail git branch -M under-rebase rebase-with-new-name
+	'
+
+	test_expect_success 'check out from current worktree branch ok' '
+		(
+			cd under-rebase &&
+			git checkout under-rebase &&
+			git checkout - &&
+			git rebase --abort
+		)
+	'
+
+	test_expect_success 'checkout a branch under bisect' '
+		git worktree add under-bisect &&
+		check_worktree_paths "$use_relative_paths" under-bisect &&
+		(
+			cd under-bisect &&
+			git bisect start &&
+			git bisect bad &&
+			git bisect good HEAD~2 &&
+			git worktree list >actual &&
+			grep "under-bisect.*detached HEAD" actual &&
+			test_must_fail git worktree add new-bisect under-bisect &&
+			! test -d new-bisect
+		)
+	'
+
+	test_expect_success 'rename a branch under bisect not allowed' '
+		test_must_fail git branch -M under-bisect bisect-with-new-name
+	'
+
+	test_expect_success '--track sets up tracking' '
+		test_when_finished rm -rf track &&
+		git worktree add --track -b track track main &&
+		check_worktree_paths "$use_relative_paths" track &&
+		test_branch_upstream track . main
+	'
+
+	test_expect_success '"add" <path> <remote/branch> w/ no HEAD' '
+		test_when_finished rm -rf repo_upstream repo_local foo &&
+		setup_remote_repo repo_upstream repo_local &&
+		git -C repo_local config --bool core.bare true &&
+		git -C repo_local branch -D main &&
+		git -C repo_local worktree add ./foo repo_upstream/foo &&
+		check_worktree_paths "$use_relative_paths" repo_local/foo
+	'
+
+	test_expect_success '--no-track avoids setting up tracking' '
+		test_when_finished rm -rf repo_upstream repo_local foo &&
+		setup_remote_repo repo_upstream repo_local &&
+		(
+			cd repo_local &&
+			git worktree add --no-track -b foo ../foo repo_upstream/foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_must_fail git config "branch.foo.remote" &&
+			test_must_fail git config "branch.foo.merge" &&
+			test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success '"add" <path> <non-existent-branch> fails' '
+		test_must_fail git worktree add foo non-existent
+	'
+
+	test_expect_success '"add" <path> <branch> dwims' '
+		test_when_finished rm -rf repo_upstream repo_dwim foo &&
+		setup_remote_repo repo_upstream repo_dwim &&
+		git init repo_dwim &&
+		(
+			cd repo_dwim &&
+			git worktree add ../foo foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_branch_upstream foo repo_upstream foo &&
+			test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
+		test_when_finished rm -rf repo_upstream repo_dwim foo &&
+		setup_remote_repo repo_upstream repo_dwim &&
+		git init repo_dwim &&
+		(
+			cd repo_dwim &&
+			git remote add repo_upstream2 ../repo_upstream &&
+			git fetch repo_upstream2 &&
+			test_must_fail git worktree add ../foo foo &&
+			git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
+			check_worktree_paths "$use_relative_paths" ../foo &&
+			git status -uno --porcelain >status.actual &&
+			test_must_be_empty status.actual
+		) &&
+		(
+			cd foo &&
+			test_branch_upstream foo repo_upstream foo &&
+			test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success 'git worktree add does not match remote' '
+		test_when_finished rm -rf repo_a repo_b foo &&
+		setup_remote_repo repo_a repo_b &&
+		(
+			cd repo_b &&
+			git worktree add ../foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_must_fail git config "branch.foo.remote" &&
+			test_must_fail git config "branch.foo.merge" &&
+			test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success 'git worktree add --guess-remote sets up tracking' '
+		test_when_finished rm -rf repo_a repo_b foo &&
+		setup_remote_repo repo_a repo_b &&
+		(
+			cd repo_b &&
+			git worktree add --guess-remote ../foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_branch_upstream foo repo_a foo &&
+			test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		)
+	'
+	test_expect_success 'git worktree add --guess-remote sets up tracking (quiet)' '
+		test_when_finished rm -rf repo_a repo_b foo &&
+		setup_remote_repo repo_a repo_b &&
+		(
+			cd repo_b &&
+			git worktree add --quiet --guess-remote ../foo 2>actual &&
+			check_worktree_paths "$use_relative_paths" ../foo &&
+			test_must_be_empty actual
+		) &&
+		(
+			cd foo &&
+			test_branch_upstream foo repo_a foo &&
+			test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success 'git worktree --no-guess-remote (quiet)' '
+		test_when_finished rm -rf repo_a repo_b foo &&
+		setup_remote_repo repo_a repo_b &&
+		(
+			cd repo_b &&
+			git worktree add --quiet --no-guess-remote ../foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_must_fail git config "branch.foo.remote" &&
+			test_must_fail git config "branch.foo.merge" &&
+			test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success 'git worktree add with worktree.guessRemote sets up tracking' '
+		test_when_finished rm -rf repo_a repo_b foo &&
+		setup_remote_repo repo_a repo_b &&
+		(
+			cd repo_b &&
+			git config worktree.guessRemote true &&
+			git worktree add ../foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_branch_upstream foo repo_a foo &&
+			test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+		)
+	'
+
+	test_expect_success 'git worktree --no-guess-remote option overrides config' '
+		test_when_finished rm -rf repo_a repo_b foo &&
+		setup_remote_repo repo_a repo_b &&
+		(
+			cd repo_b &&
+			git config worktree.guessRemote true &&
+			git worktree add --no-guess-remote ../foo &&
+			check_worktree_paths "$use_relative_paths" ../foo
+		) &&
+		(
+			cd foo &&
+			test_must_fail git config "branch.foo.remote" &&
+			test_must_fail git config "branch.foo.merge" &&
+			test_cmp_rev ! refs/remotes/repo_a/foo refs/heads/foo
+		)
+	'
+
+	for quiet_mode in "no_quiet" "quiet"
+	do
+		for changedir_type in "cd_repo" "cd_wt" "-C_repo" "-C_wt"
+		do
+			dwim_test_args="$quiet_mode $changedir_type"
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args no_-b
+			test_dwim_orphan $use_relative_paths 'no_infer' $dwim_test_args no_-b local_ref good_head
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args no_-b no_local_ref no_remote no_remote_ref no_guess_remote
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args no_-b no_local_ref remote no_remote_ref no_guess_remote
+			test_dwim_orphan $use_relative_paths 'fetch_error' $dwim_test_args no_-b no_local_ref remote no_remote_ref guess_remote
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args no_-b no_local_ref remote no_remote_ref guess_remote force
+			test_dwim_orphan $use_relative_paths 'no_infer' $dwim_test_args no_-b no_local_ref remote remote_ref guess_remote
+
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args -b
+			test_dwim_orphan $use_relative_paths 'no_infer' $dwim_test_args -b local_ref good_head
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args -b no_local_ref no_remote no_remote_ref no_guess_remote
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args -b no_local_ref remote no_remote_ref no_guess_remote
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args -b no_local_ref remote no_remote_ref guess_remote
+			test_dwim_orphan $use_relative_paths 'infer' $dwim_test_args -b no_local_ref remote remote_ref guess_remote
+
+			test_dwim_orphan $use_relative_paths 'warn_bad_head' $dwim_test_args no_-b local_ref bad_head
+			test_dwim_orphan $use_relative_paths 'warn_bad_head' $dwim_test_args -b local_ref bad_head
+			test_dwim_orphan $use_relative_paths 'warn_bad_head' $dwim_test_args detach local_ref bad_head
+		done
+
+		test_dwim_orphan $use_relative_paths 'fatal_orphan_bad_combo' $quiet_mode no_-b no_checkout
+		test_dwim_orphan $use_relative_paths 'fatal_orphan_bad_combo' $quiet_mode no_-b track
+		test_dwim_orphan $use_relative_paths 'fatal_orphan_bad_combo' $quiet_mode -b no_checkout
+		test_dwim_orphan $use_relative_paths 'fatal_orphan_bad_combo' $quiet_mode -b track
+	done
+
+	test_expect_success '"add" invokes post-checkout hook (branch)' '
+		post_checkout_hook &&
+		{
+			echo $ZERO_OID $(git rev-parse HEAD) 1 &&
+			echo $(pwd)/.git/worktrees/gumby &&
+			echo $(pwd)/gumby
+		} >hook.expect &&
+		git worktree add gumby &&
+		check_worktree_paths "$use_relative_paths" gumby &&
+		test_cmp hook.expect gumby/hook.actual
+	'
+
+	test_expect_success '"add" invokes post-checkout hook (detached)' '
+		post_checkout_hook &&
+		{
+			echo $ZERO_OID $(git rev-parse HEAD) 1 &&
+			echo $(pwd)/.git/worktrees/grumpy &&
+			echo $(pwd)/grumpy
+		} >hook.expect &&
+		git worktree add --detach grumpy &&
+		check_worktree_paths "$use_relative_paths" grumpy &&
+		test_cmp hook.expect grumpy/hook.actual
+	'
+
+	test_expect_success '"add --no-checkout" suppresses post-checkout hook' '
+		post_checkout_hook &&
+		rm -f hook.actual &&
+		git worktree add --no-checkout gloopy &&
+		check_worktree_paths "$use_relative_paths" gloopy &&
+		test_path_is_missing gloopy/hook.actual
+	'
+
+	test_expect_success '"add" in other worktree invokes post-checkout hook' '
+		post_checkout_hook &&
+		{
+			echo $ZERO_OID $(git rev-parse HEAD) 1 &&
+			echo $(pwd)/.git/worktrees/guppy &&
+			echo $(pwd)/guppy
+		} >hook.expect &&
+		git -C gloopy worktree add --detach ../guppy &&
+		check_worktree_paths "$use_relative_paths" guppy &&
+		test_cmp hook.expect guppy/hook.actual
+	'
+
+	test_expect_success '"add" in bare repo invokes post-checkout hook' '
+		rm -rf bare &&
+		git clone --bare . bare &&
+		{
+			echo $ZERO_OID $(git --git-dir=bare rev-parse HEAD) 1 &&
+			echo $(pwd)/bare/worktrees/goozy &&
+			echo $(pwd)/goozy
+		} >hook.expect &&
+		post_checkout_hook bare &&
+		git -C bare worktree add --detach ../goozy &&
+		check_worktree_paths "$use_relative_paths" goozy &&
+		test_cmp hook.expect goozy/hook.actual
+	'
+
+	test_expect_success '"add" an existing but missing worktree' '
+		git worktree add --detach pneu &&
+		check_worktree_paths "$use_relative_paths" pneu &&
+		test_must_fail git worktree add --detach pneu &&
+		rm -fr pneu &&
+		test_must_fail git worktree add --detach pneu &&
+		git worktree add --force --detach pneu &&
+		check_worktree_paths "$use_relative_paths" pneu
+	'
+
+	test_expect_success '"add" an existing locked but missing worktree' '
+		git worktree add --detach gnoo &&
+		check_worktree_paths "$use_relative_paths" gnoo &&
+		git worktree lock gnoo &&
+		test_when_finished "git worktree unlock gnoo || :" &&
+		rm -fr gnoo &&
+		test_must_fail git worktree add --detach gnoo &&
+		test_must_fail git worktree add --force --detach gnoo &&
+		git worktree add --force --force --detach gnoo &&
+		check_worktree_paths "$use_relative_paths" gnoo
+	'
+
+	test_expect_success '"add" not tripped up by magic worktree matching"' '
+		# if worktree "sub1/bar" exists, "git worktree add bar" in distinct
+		# directory `sub2` should not mistakenly complain that `bar` is an
+		# already-registered worktree
+		mkdir sub1 sub2 &&
+		git -C sub1 --git-dir=../.git worktree add --detach bozo &&
+		check_worktree_paths "$use_relative_paths" sub1/bozo &&
+		git -C sub2 --git-dir=../.git worktree add --detach bozo &&
+		check_worktree_paths "$use_relative_paths" sub2/bozo
+	'
+
+	test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
+		git worktree add --detach ".  weird*..?.lock.lock" &&
+		check_worktree_paths "$use_relative_paths" ".  weird*..?.lock.lock" &&
+		test -d .git/worktrees/---weird-.-
+	'
+
+	test_expect_success '"add" should not fail because of another bad worktree' '
+		git init add-fail &&
+		(
+			cd add-fail &&
+			test_commit first &&
+			mkdir sub &&
+			git worktree add sub/to-be-deleted &&
+			check_worktree_paths "$use_relative_paths" sub/to-be-deleted &&
+			rm -rf sub &&
+			git worktree add second &&
+			check_worktree_paths "$use_relative_paths" second
+		)
+	'
+
+	test_expect_success '"add" with uninitialized submodule, with submodule.recurse unset' '
+		test_config_global protocol.file.allow always &&
+		test_create_repo submodule &&
+		test_commit -C submodule first &&
+		test_create_repo project &&
+		git -C project submodule add ../submodule &&
+		git -C project add submodule &&
+		test_tick &&
+		git -C project commit -m add_sub &&
+		git clone project project-clone &&
+		git -C project-clone worktree add ../project-2 &&
+		check_worktree_paths "$use_relative_paths" project-2
+	'
+	test_expect_success '"add" with uninitialized submodule, with submodule.recurse set' '
+		git -C project-clone -c submodule.recurse worktree add ../project-3 &&
+		check_worktree_paths "$use_relative_paths" project-3
+	'
+
+	test_expect_success '"add" with initialized submodule, with submodule.recurse unset' '
+		test_config_global protocol.file.allow always &&
+		git -C project-clone submodule update --init &&
+		git -C project-clone worktree add ../project-4 &&
+		check_worktree_paths "$use_relative_paths" project-4
+	'
+
+	test_expect_success '"add" with initialized submodule, with submodule.recurse set' '
+		git -C project-clone -c submodule.recurse worktree add ../project-5 &&
+		check_worktree_paths "$use_relative_paths" project-5
+	'
+}
+
+say "Run tests with worktree.userelativepaths set to false"
+run_worktree_add_tests false
+
+cd ..
+setup_test_repo
+
+say "Run tests with worktree.userelativepaths set to true"
+run_worktree_add_tests true
+
+say "All other tests"
+test_wt_add_excl -b poodle -B poodle bamboo main
+test_wt_add_excl -b poodle --detach bamboo main
+test_wt_add_excl -B poodle --detach bamboo main
+test_wt_add_excl --orphan --detach bamboo
+test_wt_add_excl --orphan --no-checkout bamboo
+test_wt_add_excl --orphan bamboo main
+test_wt_add_excl --orphan -b bamboo wtdir/ main
+
+test_wt_add_orphan_hint 'no opts' 0
+test_wt_add_orphan_hint '-b' 1 -b foobar_branch
+test_wt_add_orphan_hint '-B' 1 -B foobar_branch
 
 test_done
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 71aa9bcd620..7ff6e794027 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -80,44 +80,66 @@ test_expect_success 'not prune locked checkout' '
 	test -d .git/worktrees/ghi
 '
 
-test_expect_success 'not prune recent checkouts' '
-	test_when_finished rm -r .git/worktrees &&
-	git worktree add jlm HEAD &&
-	test -d .git/worktrees/jlm &&
-	rm -rf jlm &&
-	git worktree prune --verbose --expire=2.days.ago &&
-	test -d .git/worktrees/jlm
-'
-
-test_expect_success 'not prune proper checkouts' '
-	test_when_finished rm -r .git/worktrees &&
-	git worktree add --detach "$PWD/nop" main &&
-	git worktree prune &&
-	test -d .git/worktrees/nop
-'
-
-test_expect_success 'prune duplicate (linked/linked)' '
-	test_when_finished rm -fr .git/worktrees w1 w2 &&
-	git worktree add --detach w1 &&
-	git worktree add --detach w2 &&
-	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
-	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
-	git worktree prune --verbose 2>actual &&
-	test_grep "duplicate entry" actual &&
-	test -d .git/worktrees/w1 &&
-	! test -d .git/worktrees/w2
+run_worktree_prune_tests() {
+	local use_relative_paths="$1"
+
+	# Set the Git config variable based on the parameter
+	test_config_global worktree.userelativepaths "$use_relative_paths"
+
+	test_expect_success 'not prune recent checkouts' '
+		test_when_finished rm -r .git/worktrees &&
+		git worktree add jlm HEAD &&
+		test -d .git/worktrees/jlm &&
+		rm -rf jlm &&
+		git worktree prune --verbose --expire=2.days.ago &&
+		test -d .git/worktrees/jlm
+	'
+
+	test_expect_success 'not prune proper checkouts' '
+		test_when_finished rm -r .git/worktrees &&
+		git worktree add --detach "$PWD/nop" main &&
+		git worktree prune &&
+		test -d .git/worktrees/nop
+	'
+
+	test_expect_success 'prune duplicate (linked/linked)' '
+		test_when_finished rm -fr .git/worktrees w1 w2 &&
+		git worktree add --detach w1 &&
+		git worktree add --detach w2 &&
+		sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
+		mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
+		git worktree prune --verbose 2>actual &&
+		test_grep "duplicate entry" actual &&
+		test -d .git/worktrees/w1 &&
+		! test -d .git/worktrees/w2
+	'
+
+	test_expect_success 'prune duplicate (main/linked)' '
+		test_when_finished rm -fr repo wt &&
+		test_create_repo repo &&
+		test_commit -C repo x &&
+		git -C repo worktree add --detach ../wt &&
+		rm -fr wt &&
+		mv repo wt &&
+		git -C wt worktree prune --verbose 2>actual &&
+		echo "FOO" &&
+		cat actual &&
+		echo "BAR" &&
+		test_grep "duplicate entry" actual &&
+		! test -d .git/worktrees/wt
+	'
+}
+
+say "Run tests with worktree.userelativepaths set to false"
+run_worktree_prune_tests false
+
+cd ..
+setup_test_repo
+test_expect_success initialize '
+	git commit --allow-empty -m init
 '
 
-test_expect_success 'prune duplicate (main/linked)' '
-	test_when_finished rm -fr repo wt &&
-	test_create_repo repo &&
-	test_commit -C repo x &&
-	git -C repo worktree add --detach ../wt &&
-	rm -fr wt &&
-	mv repo wt &&
-	git -C wt worktree prune --verbose 2>actual &&
-	test_grep "duplicate entry" actual &&
-	! test -d .git/worktrees/wt
-'
+say "Run tests with worktree.userelativepaths set to true"
+run_worktree_prune_tests true
 
 test_done
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 901342ea09b..90fab3800bc 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -4,6 +4,7 @@ test_description='test git worktree move, remove, lock and unlock'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-worktree.sh
 
 test_expect_success 'setup' '
 	test_commit init &&
@@ -247,4 +248,13 @@ test_expect_success 'not remove a repo with initialized submodule' '
 	)
 '
 
+test_expect_success 'move worktree and verify path format' '
+	test_config worktree.userelativepaths false &&
+	git worktree add fred &&
+	check_worktree_paths false fred &&
+	test_config worktree.userelativepaths true &&
+	git worktree move fred barney &&
+	check_worktree_paths true barney
+'
+
 test_done
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index edbf502ec57..ae9cdd2f031 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -5,6 +5,145 @@ test_description='test git worktree repair'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-worktree.sh
+
+test_corrupt_gitfile () {
+	local use_relative_paths="$1" &&
+	local butcher="$2" &&
+	local problem="$3" &&
+	local repairdir="${4:-.}" &&
+	test_when_finished 'rm -rf corrupt && git worktree prune' &&
+	git worktree add --detach corrupt &&
+	git -C corrupt rev-parse --absolute-git-dir >expect &&
+	eval "$butcher" &&
+	git -C "$repairdir" worktree repair 2>err &&
+	check_worktree_paths "$use_relative_paths" corrupt &&
+	test_grep "$problem" err &&
+	git -C corrupt rev-parse --absolute-git-dir >actual &&
+	test_cmp expect actual
+}
+
+run_worktree_repair_tests() {
+	local use_relative_paths="$1"
+
+	# Set the Git config variable based on the parameter
+	test_config_global worktree.userelativepaths "$use_relative_paths"
+
+	test_expect_success setup '
+		test_commit init
+	'
+
+	test_expect_success 'repair missing .git file' '
+		test_corrupt_gitfile "$use_relative_paths" "rm -f corrupt/.git" ".git file broken"
+	'
+
+	test_expect_success 'repair bogus .git file' '
+		test_corrupt_gitfile "$use_relative_paths" "echo \"gitdir: /nowhere\" >corrupt/.git" \
+			".git file broken"
+	'
+
+	test_expect_success 'repair incorrect .git file' '
+		test_when_finished "rm -rf other && git worktree prune" &&
+		test_create_repo other &&
+		other=$(git -C other rev-parse --absolute-git-dir) &&
+		test_corrupt_gitfile "$use_relative_paths" "echo \"gitdir: $other\" >corrupt/.git" \
+			".git file incorrect"
+	'
+
+	test_expect_success 'repair .git file from main/.git' '
+		test_corrupt_gitfile "$use_relative_paths" "rm -f corrupt/.git" ".git file broken" .git
+	'
+
+	test_expect_success 'repair .git file from linked worktree' '
+		test_when_finished "rm -rf other && git worktree prune" &&
+		git worktree add --detach other &&
+		test_corrupt_gitfile "$use_relative_paths" "rm -f corrupt/.git" ".git file broken" other
+	'
+
+	test_expect_success 'repair .git file from bare.git' '
+		test_when_finished "rm -rf bare.git corrupt && git worktree prune" &&
+		git clone --bare . bare.git &&
+		git -C bare.git worktree add --detach ../corrupt &&
+		git -C corrupt rev-parse --absolute-git-dir >expect &&
+		rm -f corrupt/.git &&
+		git -C bare.git worktree repair &&
+		check_worktree_paths "$use_relative_paths" corrupt &&
+		git -C corrupt rev-parse --absolute-git-dir >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success 'repair broken gitdir' '
+		test_when_finished "rm -rf orig moved && git worktree prune" &&
+		git worktree add --detach orig &&
+		sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+		rm .git/worktrees/orig/gitdir &&
+		mv orig moved &&
+		git worktree repair moved 2>err &&
+		check_worktree_paths "$use_relative_paths" moved &&
+		test_cmp expect .git/worktrees/orig/gitdir &&
+		test_grep "gitdir unreadable" err
+	'
+
+	test_expect_success 'repair incorrect gitdir' '
+		test_when_finished "rm -rf orig moved && git worktree prune" &&
+		git worktree add --detach orig &&
+		sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+		mv orig moved &&
+		git worktree repair moved 2>err &&
+		check_worktree_paths "$use_relative_paths" moved &&
+		test_cmp expect .git/worktrees/orig/gitdir &&
+		test_grep "gitdir incorrect" err
+	'
+
+	test_expect_success 'repair gitdir (implicit) from linked worktree' '
+		test_when_finished "rm -rf orig moved && git worktree prune" &&
+		git worktree add --detach orig &&
+		sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
+		mv orig moved &&
+		git -C moved worktree repair 2>err &&
+		check_worktree_paths "$use_relative_paths" moved &&
+		test_cmp expect .git/worktrees/orig/gitdir &&
+		test_grep "gitdir incorrect" err
+	'
+
+	test_expect_success 'repair multiple gitdir files' '
+		test_when_finished "rm -rf orig1 orig2 moved1 moved2 &&
+			git worktree prune" &&
+		git worktree add --detach orig1 &&
+		git worktree add --detach orig2 &&
+		sed s,orig1/\.git$,moved1/.git, .git/worktrees/orig1/gitdir >expect1 &&
+		sed s,orig2/\.git$,moved2/.git, .git/worktrees/orig2/gitdir >expect2 &&
+		mv orig1 moved1 &&
+		mv orig2 moved2 &&
+		git worktree repair moved1 moved2 2>err &&
+		check_worktree_paths "$use_relative_paths" moved1 &&
+		check_worktree_paths "$use_relative_paths" moved2 &&
+		test_cmp expect1 .git/worktrees/orig1/gitdir &&
+		test_cmp expect2 .git/worktrees/orig2/gitdir &&
+		test_grep "gitdir incorrect:.*orig1/gitdir$" err &&
+		test_grep "gitdir incorrect:.*orig2/gitdir$" err
+	'
+
+	test_expect_success 'repair moved main and linked worktrees' '
+		test_when_finished "rm -rf main side mainmoved sidemoved" &&
+		test_create_repo main &&
+		test_commit -C main init &&
+		git -C main worktree add --detach ../side &&
+		sed "s,side/\.git$,sidemoved/.git," \
+			main/.git/worktrees/side/gitdir >expect-gitdir &&
+		sed "s,main/.git/worktrees/side$,mainmoved/.git/worktrees/side," \
+			side/.git >expect-gitfile &&
+		mv main mainmoved &&
+		mv side sidemoved &&
+		git -C mainmoved worktree repair ../sidemoved &&
+		check_worktree_paths "$use_relative_paths" sidemoved &&
+		test_cmp expect-gitdir mainmoved/.git/worktrees/side/gitdir &&
+		test_cmp expect-gitfile sidemoved/.git
+	'
+}
+
+say "Expected failures due to inability to repair the broken worktree."
+
 test_expect_success setup '
 	test_commit init
 '
@@ -38,58 +177,6 @@ test_expect_success "don't clobber .git repo" '
 	test_grep ".git is not a file" err
 '
 
-test_corrupt_gitfile () {
-	butcher=$1 &&
-	problem=$2 &&
-	repairdir=${3:-.} &&
-	test_when_finished 'rm -rf corrupt && git worktree prune' &&
-	git worktree add --detach corrupt &&
-	git -C corrupt rev-parse --absolute-git-dir >expect &&
-	eval "$butcher" &&
-	git -C "$repairdir" worktree repair 2>err &&
-	test_grep "$problem" err &&
-	git -C corrupt rev-parse --absolute-git-dir >actual &&
-	test_cmp expect actual
-}
-
-test_expect_success 'repair missing .git file' '
-	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken"
-'
-
-test_expect_success 'repair bogus .git file' '
-	test_corrupt_gitfile "echo \"gitdir: /nowhere\" >corrupt/.git" \
-		".git file broken"
-'
-
-test_expect_success 'repair incorrect .git file' '
-	test_when_finished "rm -rf other && git worktree prune" &&
-	test_create_repo other &&
-	other=$(git -C other rev-parse --absolute-git-dir) &&
-	test_corrupt_gitfile "echo \"gitdir: $other\" >corrupt/.git" \
-		".git file incorrect"
-'
-
-test_expect_success 'repair .git file from main/.git' '
-	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken" .git
-'
-
-test_expect_success 'repair .git file from linked worktree' '
-	test_when_finished "rm -rf other && git worktree prune" &&
-	git worktree add --detach other &&
-	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken" other
-'
-
-test_expect_success 'repair .git file from bare.git' '
-	test_when_finished "rm -rf bare.git corrupt && git worktree prune" &&
-	git clone --bare . bare.git &&
-	git -C bare.git worktree add --detach ../corrupt &&
-	git -C corrupt rev-parse --absolute-git-dir >expect &&
-	rm -f corrupt/.git &&
-	git -C bare.git worktree repair &&
-	git -C corrupt rev-parse --absolute-git-dir >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'invalid worktree path' '
 	test_must_fail git worktree repair /notvalid >out 2>err &&
 	test_must_be_empty out &&
@@ -124,37 +211,6 @@ test_expect_success 'repo not found; .git file broken' '
 	test_grep ".git file broken" err
 '
 
-test_expect_success 'repair broken gitdir' '
-	test_when_finished "rm -rf orig moved && git worktree prune" &&
-	git worktree add --detach orig &&
-	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
-	rm .git/worktrees/orig/gitdir &&
-	mv orig moved &&
-	git worktree repair moved 2>err &&
-	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_grep "gitdir unreadable" err
-'
-
-test_expect_success 'repair incorrect gitdir' '
-	test_when_finished "rm -rf orig moved && git worktree prune" &&
-	git worktree add --detach orig &&
-	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
-	mv orig moved &&
-	git worktree repair moved 2>err &&
-	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_grep "gitdir incorrect" err
-'
-
-test_expect_success 'repair gitdir (implicit) from linked worktree' '
-	test_when_finished "rm -rf orig moved && git worktree prune" &&
-	git worktree add --detach orig &&
-	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
-	mv orig moved &&
-	git -C moved worktree repair 2>err &&
-	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_grep "gitdir incorrect" err
-'
-
 test_expect_success 'unable to repair gitdir (implicit) from main worktree' '
 	test_when_finished "rm -rf orig moved && git worktree prune" &&
 	git worktree add --detach orig &&
@@ -165,36 +221,16 @@ test_expect_success 'unable to repair gitdir (implicit) from main worktree' '
 	test_must_be_empty err
 '
 
-test_expect_success 'repair multiple gitdir files' '
-	test_when_finished "rm -rf orig1 orig2 moved1 moved2 &&
-		git worktree prune" &&
-	git worktree add --detach orig1 &&
-	git worktree add --detach orig2 &&
-	sed s,orig1/\.git$,moved1/.git, .git/worktrees/orig1/gitdir >expect1 &&
-	sed s,orig2/\.git$,moved2/.git, .git/worktrees/orig2/gitdir >expect2 &&
-	mv orig1 moved1 &&
-	mv orig2 moved2 &&
-	git worktree repair moved1 moved2 2>err &&
-	test_cmp expect1 .git/worktrees/orig1/gitdir &&
-	test_cmp expect2 .git/worktrees/orig2/gitdir &&
-	test_grep "gitdir incorrect:.*orig1/gitdir$" err &&
-	test_grep "gitdir incorrect:.*orig2/gitdir$" err
-'
+cd ..
+setup_test_repo
 
-test_expect_success 'repair moved main and linked worktrees' '
-	test_when_finished "rm -rf main side mainmoved sidemoved" &&
-	test_create_repo main &&
-	test_commit -C main init &&
-	git -C main worktree add --detach ../side &&
-	sed "s,side/\.git$,sidemoved/.git," \
-		main/.git/worktrees/side/gitdir >expect-gitdir &&
-	sed "s,main/.git/worktrees/side$,mainmoved/.git/worktrees/side," \
-		side/.git >expect-gitfile &&
-	mv main mainmoved &&
-	mv side sidemoved &&
-	git -C mainmoved worktree repair ../sidemoved &&
-	test_cmp expect-gitdir mainmoved/.git/worktrees/side/gitdir &&
-	test_cmp expect-gitfile sidemoved/.git
-'
+say "Run tests with worktree.userelativepaths set to false"
+run_worktree_repair_tests false
+
+cd ..
+setup_test_repo
+
+say "Run tests with worktree.userelativepaths set to true"
+run_worktree_repair_tests true
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 278d1215f15..c1fe8df2c39 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1627,26 +1627,30 @@ remove_trash_directory () {
 	! test -d "$dir"
 }
 
-# Test repository
-remove_trash_directory "$TRASH_DIRECTORY" || {
-	BAIL_OUT 'cannot prepare test area'
-}
+setup_test_repo() {
+	# Remove the trash directory if it exists
+	remove_trash_directory "$TRASH_DIRECTORY" || {
+		BAIL_OUT 'cannot prepare test area'
+	}
 
-remove_trash=t
-if test -z "$TEST_NO_CREATE_REPO"
-then
-	git init \
-	    ${TEST_CREATE_REPO_NO_TEMPLATE:+--template=} \
-	    "$TRASH_DIRECTORY" >&3 2>&4 ||
-	error "cannot run git init"
-else
-	mkdir -p "$TRASH_DIRECTORY"
-fi
+	remove_trash=t
 
-# Use -P to resolve symlinks in our working directory so that the cwd
-# in subprocesses like git equals our $PWD (for pathname comparisons).
-cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
+	# Initialize a new Git repository or create the directory
+	if [ -z "$TEST_NO_CREATE_REPO" ]; then
+		git init \
+			${TEST_CREATE_REPO_NO_TEMPLATE:+--template=} \
+			"$TRASH_DIRECTORY" >&3 2>&4 ||
+		error "cannot run git init"
+	else
+		mkdir -p "$TRASH_DIRECTORY"
+	fi
+
+	# Use -P to resolve symlinks in our working directory so that the cwd
+	# in subprocesses like git equals our $PWD (for pathname comparisons).
+	cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
+}
 
+setup_test_repo
 start_test_output "$0"
 
 # Convenience
diff --git a/worktree.c b/worktree.c
index 30a947426ee..a3a8c580508 100644
--- a/worktree.c
+++ b/worktree.c
@@ -328,17 +328,6 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		goto done;
 	}
 
-	/*
-	 * Make sure "gitdir" file points to a real .git file and that
-	 * file points back here.
-	 */
-	if (!is_absolute_path(wt->path)) {
-		strbuf_addf_gently(errmsg,
-				   _("'%s' file does not contain absolute path to the working tree location"),
-				   git_common_path("worktrees/%s/gitdir", wt->id));
-		goto done;
-	}
-
 	if (flags & WT_VALIDATE_WORKTREE_MISSING_OK &&
 	    !file_exists(wt->path)) {
 		ret = 0;
@@ -372,19 +361,30 @@ done:
 
 void update_worktree_location(struct worktree *wt, const char *path_)
 {
-	struct strbuf path = STRBUF_INIT;
+	struct strbuf worktree_new_path = STRBUF_INIT;
+	int use_relative_paths = 0;
 
 	if (is_main_worktree(wt))
 		BUG("can't relocate main worktree");
 
-	strbuf_realpath(&path, path_, 1);
-	if (fspathcmp(wt->path, path.buf)) {
-		write_file(git_common_path("worktrees/%s/gitdir", wt->id),
-			   "%s/.git", path.buf);
-		free(wt->path);
-		wt->path = strbuf_detach(&path, NULL);
-	}
-	strbuf_release(&path);
+	strbuf_realpath(&worktree_new_path, path_, 1);
+
+	use_relative_paths = repo_config_get_worktree_use_relative_paths(the_repository);
+	connect_work_tree_and_git_dir(worktree_new_path.buf,
+				      git_common_path("worktrees/%s", wt->id),
+				      use_relative_paths);
+	connect_gitdir_file_and_work_tree(worktree_new_path.buf, wt->id,
+					  use_relative_paths);
+
+	/* Update worktree's path */
+	free(wt->path);
+	/*
+	TODO: This is setting the worktree's path to an absolute path, not
+	sure if always correct, especially when using relative paths.
+	*/
+	wt->path = strbuf_detach(&worktree_new_path, NULL);
+
+	strbuf_release(&worktree_new_path);
 }
 
 int is_worktree_being_rebased(const struct worktree *wt,
@@ -564,21 +564,25 @@ static void repair_gitfile(struct worktree *wt,
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf repo = STRBUF_INIT;
-	char *backlink;
+	char *backlink = NULL;
 	const char *repair = NULL;
+	char *abs_wt_path = NULL;
 	int err;
+	int use_relative_paths = 0;
+
+	abs_wt_path = worktree_real_pathdup_for_wt(wt);
 
 	/* missing worktree can't be repaired */
-	if (!file_exists(wt->path))
-		return;
+	if (!file_exists(abs_wt_path))
+		goto done;
 
-	if (!is_directory(wt->path)) {
+	if (!is_directory(abs_wt_path)) {
 		fn(1, wt->path, _("not a directory"), cb_data);
-		return;
+		goto done;
 	}
 
 	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
-	strbuf_addf(&dotgit, "%s/.git", wt->path);
+	strbuf_addf(&dotgit, "%s/.git", abs_wt_path);
 	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
 
 	if (err == READ_GITFILE_ERR_NOT_A_FILE)
@@ -590,10 +594,16 @@ static void repair_gitfile(struct worktree *wt,
 
 	if (repair) {
 		fn(0, wt->path, repair, cb_data);
-		write_file(dotgit.buf, "gitdir: %s", repo.buf);
+
+		use_relative_paths =
+			repo_config_get_worktree_use_relative_paths(the_repository);
+		connect_work_tree_and_git_dir(abs_wt_path, repo.buf,
+					      use_relative_paths);
 	}
 
+done:
 	free(backlink);
+	free(abs_wt_path);
 	strbuf_release(&repo);
 	strbuf_release(&dotgit);
 }
@@ -682,9 +692,11 @@ void repair_worktree_at_path(const char *path,
 	struct strbuf realdotgit = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
+	struct strbuf abs_wt_path_sb = STRBUF_INIT;
 	char *backlink = NULL;
 	const char *repair = NULL;
 	int err;
+	int use_relative_paths = 0;
 
 	if (!fn)
 		fn = repair_noop;
@@ -717,16 +729,26 @@ void repair_worktree_at_path(const char *path,
 		repair = _("gitdir unreadable");
 	else {
 		strbuf_rtrim(&olddotgit);
+		if (!is_absolute_path(olddotgit.buf))
+			strbuf_realpath_forgiving(&olddotgit, olddotgit.buf, 1);
+
 		if (fspathcmp(olddotgit.buf, realdotgit.buf))
 			repair = _("gitdir incorrect");
 	}
 
 	if (repair) {
 		fn(0, gitdir.buf, repair, cb_data);
-		write_file(gitdir.buf, "%s", realdotgit.buf);
+
+		use_relative_paths =
+			repo_config_get_worktree_use_relative_paths(the_repository);
+
+		strbuf_add_real_path(&abs_wt_path_sb, path);
+		connect_gitdir_file_and_work_tree(abs_wt_path_sb.buf, basename(backlink),
+						  use_relative_paths);
 	}
 done:
 	free(backlink);
+	strbuf_release(&abs_wt_path_sb);
 	strbuf_release(&olddotgit);
 	strbuf_release(&gitdir);
 	strbuf_release(&realdotgit);

base-commit: 6531f31ef3bead57a3255fa08efa6e7553c5a9a7
-- 
gitgitgadget
