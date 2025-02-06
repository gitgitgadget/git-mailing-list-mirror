Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE0152196
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815618; cv=none; b=KGTGMcJ2NrnCZmgPZKZTPqL5IJvPF2P005ToeJ9eWYbLp8X5bPKWPflP9kYBYplmtiXnt0J0Oty0URTLXff7ebH8tuYbZjdHmHcWI2ijES75Qz5md5isMV4J1agDXuop2LTKwdCw9HSPzGuFhniDi87oq6IGgDYGoea/AvmOvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815618; c=relaxed/simple;
	bh=KMf7nDGg5XmYLlcO1PYAGKcIwIaFW8ClgiEHMB16I/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvqC0k/6yeYJSu1YkvpXjrbkZ1LM1xXwXvHjOUeT5f2fFFeTArSw2rT3dghPO2sL6p44XqVEvUrjkLSUWEHS7hf5Wqz+LWvMTG6P9OsRocJVRm1hQGsE9WEtwTCWs5n+A9Sha2+rCsXeonqkkeS0PaSjAMsjFbvirZeeRVL4l9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4McR0YK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4McR0YK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f2339dcfdso6718715ad.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 20:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738815616; x=1739420416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RdokglLNGU4GDISJ30LyP07aU9kqp1gBENXSdxaiXk=;
        b=D4McR0YKxH86QQ7HxYWgOrhhRueMcK+35q8mH5YQkfLW/bJF2/vk/jV8BvXVFCsC9c
         fsUj+khixNnKen4UrdVeAf+6+2p0cLwV9z81hpGlXY/PWKIvO1Cu4PKrY5NoKUbuKjvv
         x2L1WaTHN2yGOjMBQZe2FDg1k68azFNvbuUzqYMLLz6jh015gPMC35wH7JdfAeXmtr1H
         fK8mQnidObmu+4S/hx23ybnm8q5edjRZyMO6fU2N73+zf4CGk2GU/96pEzWda1Cq48fy
         znw0toSPNNUkxM8q0MoCx9JCC7rI4gAzTNABuSldrXmeX/pdxzJLfTN2FUZMcJuJTYWF
         ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738815616; x=1739420416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RdokglLNGU4GDISJ30LyP07aU9kqp1gBENXSdxaiXk=;
        b=Aqgh2sIlQG2dSV1jD6kEzBkNDdepddKEuwQtFZMm4hJq10QsPqiB9C103+Hl+cGvD8
         HeXfu/ArNZD0bwjIO9CGUKmisk5fldbKCNJJ54R8vc3gptio6XeIKPrkV/Ei48MCsoXI
         3UICXnDUadjdnJzhtAyGWWWg90fDQ2jv5XugFgZ2MgQwMe4ntvRY6A7hQFDXxMdwshLD
         v/+QZQ9Gc5Zf/mI4YURwPiLQbuWRXI2RQVWtl6pNFwdc3eP7EZgVOz2cXS8+3W4ggg9z
         r5QLbocEnklo7NNRRW7YFPExdi8xliqzGK/9QnHE3bEPYMU9WWpOG2HgrpC4Q6PFOhIr
         jU8g==
X-Gm-Message-State: AOJu0YylMVWdMp65BPA1o4lh68KRv3rCqHX+cFYejfPC/IetMSX8cchd
	kdAF7bN2cJyJaXYMyHsYAkkXp66fm+GpArbarZEOKxkcvA58+yjtzBCVZA==
X-Gm-Gg: ASbGncu14i3FvRHvC5mcw3emPKDN8gz95YDvTvDmxpRQyrAl6SCqtqhuQZhcYvN4MQ2
	Mc5L7j8kW+5CAljObjnclu4cMu0omCxIjqD/s416c5gxpetRoWPXYQwnfNyJRlcdW8yICPaZGJO
	uxGqNhTWY0EqHPSgFImsahpAQCe9uL2+6991xH771p6lYTgpXedreD6nyJqMrxZOR7jG8BSVnDg
	l5BzhkfdH8lIGWYQu/5AYZGi4CWfFdH2ExgJFdzxn0ABgogoysZIvYpNzWYMqHkrLZejYqeB9vM
	SsiwEKeoJMbCXZpS9LEt6SEtFw==
X-Google-Smtp-Source: AGHT+IF4FplxmlAyXkhJ1OLgI0IAktQOgB9Z6yqiUm6cWWqKKZjs9lS0VdGybgxD+pav+dJ5RCxH0Q==
X-Received: by 2002:a17:902:fc8d:b0:215:44fe:163d with SMTP id d9443c01a7336-21f2f1a7664mr29983205ad.17.1738815615795;
        Wed, 05 Feb 2025 20:20:15 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e63fsm2384045ad.41.2025.02.05.20.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:20:15 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 2/3] difftool: eliminate use of the_repository
Date: Wed,  5 Feb 2025 20:20:09 -0800
Message-ID: <20250206042010.865947-2-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.461.g612e419e04
In-Reply-To: <20250206042010.865947-1-davvid@gmail.com>
References: <20250206042010.865947-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make callers pass a repository struct into each function instead
of relying on the global the_repository variable.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 54 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 0b6b92aee0..81d733dfdf 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -72,7 +72,8 @@ static int print_tool_help(void)
 	return run_command(&cmd);
 }
 
-static int parse_index_info(char *p, int *mode1, int *mode2,
+static int parse_index_info(struct repository *repo,
+			    char *p, int *mode1, int *mode2,
 			    struct object_id *oid1, struct object_id *oid2,
 			    char *status)
 {
@@ -84,11 +85,11 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
 	*mode2 = (int)strtol(p + 1, &p, 8);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (parse_oid_hex(++p, oid1, (const char **)&p))
+	if (parse_oid_hex_algop(++p, oid1, (const char **)&p, repo->hash_algo))
 		return error("expected object ID, got '%s'", p);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (parse_oid_hex(++p, oid2, (const char **)&p))
+	if (parse_oid_hex_algop(++p, oid2, (const char **)&p, repo->hash_algo))
 		return error("expected object ID, got '%s'", p);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
@@ -115,7 +116,8 @@ static void add_path(struct strbuf *buf, size_t base_len, const char *path)
 /*
  * Determine whether we can simply reuse the file in the worktree.
  */
-static int use_wt_file(const char *workdir, const char *name,
+static int use_wt_file(struct repository *repo,
+		       const char *workdir, const char *name,
 		       struct object_id *oid)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -130,7 +132,7 @@ static int use_wt_file(const char *workdir, const char *name,
 		int fd = open(buf.buf, O_RDONLY);
 
 		if (fd >= 0 &&
-		    !index_fd(the_repository->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
+		    !index_fd(repo->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
 			if (is_null_oid(oid)) {
 				oidcpy(oid, &wt_oid);
 				use = 1;
@@ -221,13 +223,14 @@ static int path_entry_cmp(const void *cmp_data UNUSED,
 	return strcmp(a->path, key ? key : b->path);
 }
 
-static void changed_files(struct hashmap *result, const char *index_path,
+static void changed_files(struct repository *repo,
+			  struct hashmap *result, const char *index_path,
 			  const char *workdir)
 {
 	struct child_process update_index = CHILD_PROCESS_INIT;
 	struct child_process diff_files = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *git_dir = absolute_path(repo_get_git_dir(the_repository));
+	const char *git_dir = absolute_path(repo_get_git_dir(repo));
 	FILE *fp;
 
 	strvec_pushl(&update_index.args,
@@ -300,7 +303,8 @@ static int ensure_leading_directories(char *path)
  * to compare the readlink(2) result as text, even on a filesystem that is
  * capable of doing a symbolic link.
  */
-static char *get_symlink(struct difftool_options *dt_options,
+static char *get_symlink(struct repository *repo,
+			 struct difftool_options *dt_options,
 			 const struct object_id *oid, const char *path)
 {
 	char *data;
@@ -317,8 +321,7 @@ static char *get_symlink(struct difftool_options *dt_options,
 	} else {
 		enum object_type type;
 		unsigned long size;
-		data = repo_read_object_file(the_repository, oid, &type,
-					     &size);
+		data = repo_read_object_file(repo, oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
 				oid_to_hex(oid), path);
@@ -365,7 +368,8 @@ static void write_standin_files(struct pair_entry *entry,
 		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
 }
 
-static int run_dir_diff(struct difftool_options *dt_options,
+static int run_dir_diff(struct repository *repo,
+			struct difftool_options *dt_options,
 			const char *extcmd, const char *prefix,
 			struct child_process *child)
 {
@@ -386,7 +390,7 @@ static int run_dir_diff(struct difftool_options *dt_options,
 	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
-	struct index_state wtindex = INDEX_STATE_INIT(the_repository);
+	struct index_state wtindex = INDEX_STATE_INIT(repo);
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -394,7 +398,7 @@ static int run_dir_diff(struct difftool_options *dt_options,
 	struct hashmap tmp_modified = HASHMAP_INIT(path_entry_cmp, NULL);
 	int indices_loaded = 0;
 
-	workdir = repo_get_work_tree(the_repository);
+	workdir = repo_get_work_tree(repo);
 
 	/* Setup temp directories */
 	tmp = getenv("TMPDIR");
@@ -449,8 +453,7 @@ static int run_dir_diff(struct difftool_options *dt_options,
 			       "not supported in\n"
 			       "directory diff mode ('-d' and '--dir-diff')."));
 
-		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
-				     &status))
+		if (parse_index_info(repo, info.buf, &lmode, &rmode, &loid, &roid, &status))
 			break;
 		if (strbuf_getline_nul(&lpath, fp))
 			break;
@@ -480,13 +483,13 @@ static int run_dir_diff(struct difftool_options *dt_options,
 		}
 
 		if (S_ISLNK(lmode)) {
-			char *content = get_symlink(dt_options, &loid, src_path);
+			char *content = get_symlink(repo, dt_options, &loid, src_path);
 			add_left_or_right(&symlinks2, src_path, content, 0);
 			free(content);
 		}
 
 		if (S_ISLNK(rmode)) {
-			char *content = get_symlink(dt_options, &roid, dst_path);
+			char *content = get_symlink(repo, dt_options, &roid, dst_path);
 			add_left_or_right(&symlinks2, dst_path, content, 1);
 			free(content);
 		}
@@ -511,7 +514,7 @@ static int run_dir_diff(struct difftool_options *dt_options,
 			}
 			hashmap_add(&working_tree_dups, &entry->entry);
 
-			if (!use_wt_file(workdir, dst_path, &roid)) {
+			if (!use_wt_file(repo, workdir, dst_path, &roid)) {
 				if (checkout_path(rmode, &roid, dst_path,
 						  &rstate)) {
 					ret = error("could not write '%s'",
@@ -637,9 +640,9 @@ static int run_dir_diff(struct difftool_options *dt_options,
 				ret = error("could not write %s", buf.buf);
 				goto finish;
 			}
-			changed_files(&wt_modified, buf.buf, workdir);
+			changed_files(repo, &wt_modified, buf.buf, workdir);
 			strbuf_setlen(&rdir, rdir_len);
-			changed_files(&tmp_modified, buf.buf, rdir.buf);
+			changed_files(repo, &tmp_modified, buf.buf, rdir.buf);
 			add_path(&rdir, rdir_len, name);
 			indices_loaded = 1;
 		}
@@ -713,7 +716,7 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	int use_gui_tool = -1, dir_diff = 0, prompt = -1, tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
@@ -749,7 +752,8 @@ int cmd_difftool(int argc,
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	git_config(difftool_config, &dt_options);
+	if (repo)
+		repo_config(repo, difftool_config, &dt_options);
 	dt_options.symlinks = dt_options.has_symlinks;
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
@@ -764,8 +768,8 @@ int cmd_difftool(int argc,
 
 	if (!no_index){
 		setup_work_tree();
-		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
-		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
+		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(repo)), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(repo)), 1);
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
@@ -814,6 +818,6 @@ int cmd_difftool(int argc,
 	strvec_pushv(&child.args, argv);
 
 	if (dir_diff)
-		return run_dir_diff(&dt_options, extcmd, prefix, &child);
+		return run_dir_diff(repo, &dt_options, extcmd, prefix, &child);
 	return run_file_diff(prompt, prefix, &child);
 }
-- 
2.48.1.461.g612e419e04

