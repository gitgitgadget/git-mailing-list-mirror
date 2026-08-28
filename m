Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EC308F03
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930391; cv=none; b=fcmlvbJ9r9zg/MfzaGwksGTn/Q10rxqpB+im05KxaULnEdSXs879D75AQNIT5b18+agb77K3Dg04uMX5Fky9C0RoTYB3IBOzAjsPuNxHttCYfii7/nqfa64R9J0FYasrdhfPARDqFCsimILmVlryddwWxksx9MomQSQV886EcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930391; c=relaxed/simple;
	bh=Nf3cwdeV1hDk55shghd1uphUIK2e6F/4TX6K+Bs/2lk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z/Z03+a+Vhp3V2z2/a2T5RWOYg++GeFXUnuZja/EWobqnK9uMTa+J1HfX5WVwjtebBkTA2XeAIx3UUFfJAgs/j9aIlGKxSVcW6OSbNbC/lFNO+aMhsFzvx6jpvOLAbcMjlp25FpjmTRCNhtwAYgiM3Zk5U94pkEWKOJ9rkHF5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6i9jJ4K; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6i9jJ4K"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4472500e25fso527206fac.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787930388; x=1788535188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1kpl/1+8LntopjQghxozCcL5oNI4U9fhc0nSm9LIbG4=;
        b=b6i9jJ4KrE268OWJf4Hip3ws2jqvhXy7KbWgKW/yz9ZYUX/gVnuItjagLlY0AsyaJR
         EnnvZSaZOcgcQN20IXxJeo30ZL4qYiLOzurKYNkhusaKmAymIn8V7xmBAneG4SylfqHu
         5532TaEpJLswcMYa9V26jM4a0vJoku5zmQbXpi5rGZYZqjtDXxOwjesAGNRR7XnuvWiE
         mzDCXkQfFIR4uIMmI+H0DKNOVuQ02YXdgQvPpl/dazF3l3n15LqsHJQcAXLP9PsqRx8D
         RDv7o6AT2F8Xd7vVcQmR8c7cD2edPhfc9ROblSp4K/Rb5vb8JGp1PZbjzgLCzPtPQSvn
         4GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930388; x=1788535188;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1kpl/1+8LntopjQghxozCcL5oNI4U9fhc0nSm9LIbG4=;
        b=S0EaVwePbwjCAhyiGJvPWgSmRG3iCPFW3pS7ysEU6QQ3x5T863Wq+CwE1N28iCvOAZ
         vI/cCMjdO8rCdEMU0aQVUkZWhNZva6Ec83m5r4l8gyUQBmJkB5wNrRj3etpK2T8p/TH2
         5GkOAdvhs38Du1N7iv9bDAU05OUwldzb2FHMzhAfsje16oI/kAGRBWWHTgWYff+NyKhX
         2+9vbfVgkqOXhKNoGjOpdWMNk7Osb4vDm6qbkZi1GoR9/OIoYNHKFsQ0wJ/e7cdZM+VC
         2moJnVmEmuF1sEBBkxLUUBqbG1xaBqQ0n1mILCRpOcFZHewQcRAGt/B6WRWEc+0soIMC
         jjIw==
X-Gm-Message-State: AFuF++lqSjYJj8gnS0fXjTy87j+jY6uwNMFmA4utA36AXZ+b2ZeSkp05
	AZ5OrJWxCBD8ocHIMwiMKaI/gA9hIt6+XXGbiMidKq7/ZkfQEygJWaXnbzrc8g==
X-Gm-Gg: AR+sD11goUB9eAGiWbKR3JvOLDcb20dNL7xoluKEr//8ZNicc30cH8L8Vfa1loTS9Ay
	Jza/+gu3QeiAbHvAhrID5LVF5BF5qdorArDiBZyLNBa6xV62F3Cs6/TQseezr62d3x+kJdnBeUi
	xBbFajP1nfAP023O9sc2AHGFYAFmek3YlKTzKTbS1yTeQ/A1HL+Yrn35t1WomB2EVsfqXXwd/Sx
	RI3O1ByZucAZraR8dlYRM1ZTkRKqDKcQ1ZML1EDAiN6nwfw6EnZUIIoly6aRNPjRkn0FlTSDFF9
	VhlSffDn1jYMOQhlRfkNpCxvEWw2Gj9tFkHo5F5wIjJsTfqMW3Fkab0kI25VmoSkrOgnjTlQgOq
	ocDPVmVlBZjD0UxYQ+GYW/kExx6uNQJYpoei7h65KH2wChP5tN9pjoofU8+0PukTxZ8IBFyu6pF
	WvsCzZfDRY+zrg2mCjUs2HF8ziInQO63ZcF6ntO3z8lTSdCrE9fb3GhpzkZkD45g==
X-Received: by 2002:a05:6820:1504:b0:6b1:bf9f:2af1 with SMTP id 006d021491bc7-6b1c6776996mr6146593eaf.33.1787930387666;
        Fri, 28 Aug 2026 08:19:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.52.240])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce3c487fsm1806530eaf.15.2026.08.28.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:19:47 -0700 (PDT)
Message-Id: <pull.2205.v4.git.1787930386252.gitgitgadget@gmail.com>
In-Reply-To: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 15:19:46 +0000
Subject: [PATCH v4] worktree repair: detect relative path in .git file
 correctly
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
Cc: Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Given a state in which the cross-references between the worktree and
the repository (specifically worktree/id/gitdir in the main repository
and the .git file in the worktree) are recorded using absolute paths,
setting 'worktree.useRelativePaths=true' and running 'git worktree
repair' within the main worktree converts them to relative paths.

Conversely, given a state in which the cross-references are recorded
using relative paths, one would expect that setting
'worktree.useRelativePaths=false' and running 'git worktree repair'
would convert them to absolute paths. However, they remain as relative
paths.

This is because we incorrectly use read_gitfile_gently(), which always
returns an absolute path. To fix this, introduce read_gitfile_raw(),
which reads the path from the .git file without resolving it to an
absolute path.

Because read_gitfile_raw() does not validate the path with
is_git_directory(), repair_gitfile() performs this validation to
preserve the existing behavior.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree repair: detect relative path in .git file correctly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2205%2Fyoichi%2Fworktree-repair-relative-path-handling-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2205/yoichi/worktree-repair-relative-path-handling-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2205

Range-diff vs v3:

 1:  1cd25e315e ! 1:  abff315880 worktree repair: detect relative path in .git file correctly
     @@ Commit message
      
          This is because we incorrectly use read_gitfile_gently(), which always
          returns an absolute path. To fix this, introduce read_gitfile_raw(),
     -    which is almost identical to read_gitfile_gently(), but skips checking
     -    the existence of the referenced repository and returns the path as-is
     -    from the .git file.
     +    which reads the path from the .git file without resolving it to an
     +    absolute path.
     +
     +    Because read_gitfile_raw() does not validate the path with
     +    is_git_directory(), repair_gitfile() performs this validation to
     +    preserve the existing behavior.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
     @@ setup.c: void read_gitfile_error_die(int error_code, const char *path)
      +	return error_code ? NULL : realpath.buf;
      +}
      +
     ++/*
     ++ * Read the path following "gitdir: " from the .git file into strbuf.
     ++ *
     ++ * Unlike read_gitfile_gently(), this function does not resolve a
     ++ * relative path or validate it using is_git_directory().
     ++ */
      +int read_gitfile_raw(struct strbuf *contents, const char *path)
       {
       	const int max_file_size = 1 << 20;  /* 1MB */


 setup.c                    | 69 ++++++++++++++++++++++++--------------
 setup.h                    |  1 +
 t/t2406-worktree-repair.sh | 54 ++++++++++++++++++++++-------
 worktree.c                 | 20 +++++------
 4 files changed, 94 insertions(+), 50 deletions(-)

diff --git a/setup.c b/setup.c
index 95909e9603..d6a00cdbb4 100644
--- a/setup.c
+++ b/setup.c
@@ -962,16 +962,54 @@ void read_gitfile_error_die(int error_code, const char *path)
  * cases).
  */
 const char *read_gitfile_gently(const char *path, int *return_error_code)
+{
+	int error_code = 0;
+	const char *slash;
+	struct strbuf contents = STRBUF_INIT;
+	static struct strbuf realpath = STRBUF_INIT;
+
+	error_code = read_gitfile_raw(&contents, path);
+	if (error_code)
+		goto cleanup_return;
+
+	if (!is_absolute_path(contents.buf) && (slash = strrchr(path, '/'))) {
+		size_t pathlen = slash+1 - path;
+		char *dir = xstrfmt("%.*s%s", (int)pathlen, path, contents.buf);
+		strbuf_reset(&contents);
+		strbuf_addstr(&contents, dir);
+		free(dir);
+	}
+	if (!is_git_directory(contents.buf)) {
+		error_code = READ_GITFILE_ERR_NOT_A_REPO;
+		goto cleanup_return;
+	}
+
+	strbuf_realpath(&realpath, contents.buf, 1);
+
+cleanup_return:
+	if (return_error_code)
+		*return_error_code = error_code;
+	else if (error_code)
+		read_gitfile_error_die(error_code, path);
+
+	strbuf_release(&contents);
+	return error_code ? NULL : realpath.buf;
+}
+
+/*
+ * Read the path following "gitdir: " from the .git file into strbuf.
+ *
+ * Unlike read_gitfile_gently(), this function does not resolve a
+ * relative path or validate it using is_git_directory().
+ */
+int read_gitfile_raw(struct strbuf *contents, const char *path)
 {
 	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
 	char *buf = NULL;
-	char *dir = NULL;
-	const char *slash;
 	struct stat st;
 	int fd;
 	ssize_t len;
-	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
 		if (errno == ENOENT || errno == ENOTDIR)
@@ -1014,32 +1052,11 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 		error_code = READ_GITFILE_ERR_NO_PATH;
 		goto cleanup_return;
 	}
-	buf[len] = '\0';
-	dir = buf + 8;
-
-	if (!is_absolute_path(dir) && (slash = strrchr(path, '/'))) {
-		size_t pathlen = slash+1 - path;
-		dir = xstrfmt("%.*s%.*s", (int)pathlen, path,
-			      (int)(len - 8), buf + 8);
-		free(buf);
-		buf = dir;
-	}
-	if (!is_git_directory(dir)) {
-		error_code = READ_GITFILE_ERR_NOT_A_REPO;
-		goto cleanup_return;
-	}
-
-	strbuf_realpath(&realpath, dir, 1);
-	path = realpath.buf;
+	strbuf_add(contents, buf+8, len-8);
 
 cleanup_return:
-	if (return_error_code)
-		*return_error_code = error_code;
-	else if (error_code)
-		read_gitfile_error_die(error_code, path);
-
 	free(buf);
-	return error_code ? NULL : path;
+	return error_code;
 }
 
 static void apply_gitdir_and_environment(struct repository *repo, const char *path)
diff --git a/setup.h b/setup.h
index 654f10e059..e6e71bda3d 100644
--- a/setup.h
+++ b/setup.h
@@ -40,6 +40,7 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
+int read_gitfile_raw(struct strbuf *contents, const char *path);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index f5f19b3169..d4e53d492b 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -228,30 +228,60 @@ test_expect_success 'repair worktree with relative path with missing gitfile' '
 	test_cmp expect wt/.git
 '
 
-test_expect_success 'repair absolute worktree to use relative paths' '
-	test_when_finished "rm -rf main side sidemoved" &&
+test_expect_success 'repair absolute to relative from side worktree' '
+	test_when_finished "rm -rf main side" &&
 	test_create_repo main &&
 	test_commit -C main init &&
 	git -C main worktree add --detach ../side &&
-	echo "../../../../sidemoved/.git" >expect-gitdir &&
+	echo "../../../../side/.git" >expect-gitdir &&
 	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
-	mv side sidemoved &&
-	git -C main worktree repair --relative-paths ../sidemoved &&
+	git -C main worktree repair --relative-paths ../side 2>main/err &&
+	test_grep "gitdir absolute/relative path mismatch" main/err &&
 	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
-	test_cmp expect-gitfile sidemoved/.git
+	test_cmp expect-gitfile side/.git
 '
 
-test_expect_success 'repair relative worktree to use absolute paths' '
-	test_when_finished "rm -rf main side sidemoved" &&
+test_expect_success 'repair relative to absolute from side worktree' '
+	test_when_finished "rm -rf main side" &&
 	test_create_repo main &&
 	test_commit -C main init &&
 	git -C main worktree add --relative-paths --detach ../side &&
-	echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
+	echo "$(pwd)/side/.git" >expect-gitdir &&
 	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
-	mv side sidemoved &&
-	git -C main worktree repair ../sidemoved &&
+	git -C main worktree repair ../side 2>main/err &&
+	test_grep "gitdir absolute/relative path mismatch" main/err &&
 	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
-	test_cmp expect-gitfile sidemoved/.git
+	test_cmp expect-gitfile side/.git
+'
+
+test_expect_success 'repair absolute to relative from main worktree' '
+	test_when_finished "rm -rf main side" &&
+	test_create_repo main &&
+	git -C main config worktree.useRelativePaths false &&
+	test_commit -C main init &&
+	git -C main worktree add --detach ../side &&
+	echo "../../../../side/.git" >expect-gitdir &&
+	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
+	git -C main config worktree.useRelativePaths true &&
+	git -C main worktree repair 2>main/err &&
+	test_grep ".git file absolute/relative path mismatch" main/err &&
+	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+	test_cmp expect-gitfile side/.git
+'
+
+test_expect_success 'repair relative to absolute from main worktree' '
+	test_when_finished "rm -rf main side" &&
+	test_create_repo main &&
+	git -C main config worktree.useRelativePaths true &&
+	test_commit -C main init &&
+	git -C main worktree add --detach ../side &&
+	echo "$(pwd)/side/.git" >expect-gitdir &&
+	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
+	git -C main config worktree.useRelativePaths false &&
+	git -C main worktree repair 2>main/err &&
+	test_grep ".git file absolute/relative path mismatch" main/err &&
+	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+	test_cmp expect-gitfile side/.git
 '
 
 test_done
diff --git a/worktree.c b/worktree.c
index cbf95328a3..8cb8637b18 100644
--- a/worktree.c
+++ b/worktree.c
@@ -649,7 +649,8 @@ static void repair_gitfile(struct worktree *wt,
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf repo = STRBUF_INIT;
 	struct strbuf backlink = STRBUF_INIT;
-	char *dotgit_contents = NULL;
+	struct strbuf contents = STRBUF_INIT;
+	const char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	char *path = NULL;
 	int err;
@@ -667,7 +668,9 @@ static void repair_gitfile(struct worktree *wt,
 	strbuf_realpath(&repo, path, 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
 	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
-	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+	err = read_gitfile_raw(&contents, dotgit.buf);
+	if (!err)
+		dotgit_contents = contents.buf;
 
 	if (dotgit_contents) {
 		if (is_absolute_path(dotgit_contents)) {
@@ -681,7 +684,7 @@ static void repair_gitfile(struct worktree *wt,
 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 		err == READ_GITFILE_ERR_IS_A_DIR)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
-	else if (err)
+	else if (err || !is_git_directory(backlink.buf))
 		repair = _(".git file broken");
 	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
@@ -695,12 +698,12 @@ static void repair_gitfile(struct worktree *wt,
 	}
 
 done:
-	free(dotgit_contents);
 	free(path);
 	strbuf_release(&repo);
 	strbuf_release(&dotgit);
 	strbuf_release(&gitdir);
 	strbuf_release(&backlink);
+	strbuf_release(&contents);
 }
 
 static void repair_noop(int iserr UNUSED,
@@ -857,14 +860,7 @@ void repair_worktree_at_path(struct repository *repo,
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
 	if (dotgit_contents) {
-		if (is_absolute_path(dotgit_contents)) {
-			strbuf_addstr(&backlink, dotgit_contents);
-		} else {
-			strbuf_addbuf(&backlink, &dotgit);
-			strbuf_strip_suffix(&backlink, ".git");
-			strbuf_addstr(&backlink, dotgit_contents);
-			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
-		}
+		strbuf_addstr(&backlink, dotgit_contents);
 	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 			err == READ_GITFILE_ERR_IS_A_DIR) {
 		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);

base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
-- 
gitgitgadget
