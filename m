Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01947A87A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240779; cv=none; b=jlei4IIufJ9o+X1TpxisMXHfn3LW/HVE2j3BBZjZ6i1pMknMoBGCnxr/EfZ0FoawrHsfN1Peaalad2pJURJWh++ghz+zCTcTbdxHUasOhyvlwVmzV08oxjEvfqJH+BkJktBeEtgOJD4AFykQIrsvuNCeYbuO8SNNWv6jcYS1fkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240779; c=relaxed/simple;
	bh=VsgVHP+jBwZx+Mxv3PnKAQ5UUfC8WobB+yUTyn1adTM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ib3UG0R5Xd9VQ47FOL1zZK700WEpECQAv14bdJ57jFxlYftlp7vyuRelTWSQ0TPIqcF/UARrnXBB7wJHP96IQ5lgwVL14E8q63lhS6U1BflgYzk6kdJLC/DISju+COBuXqdZ+iWBsl3mBq+eHUhksGMjEocgpbiPnzrBNhR3B7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgYB5WAl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgYB5WAl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so887596a91.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240762; x=1787845562; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NJpaQGyId8XAw9G51KmxUUm44NWnmeFrUK68rSnHLSg=;
        b=rgYB5WAl/MJWDkxhq8cycdeGZMSLXFxO8dY6UMB5rBkgwsXXLu6F4EDIiN5RQsceCp
         sgIVqU31tDTP5wldnxNxaVqEVBOGPcG7d4JmzlabbvWfcw63jh4EPSyixlleGr7bVyx3
         mfVfEIm7BafXu0sXPri4jaySAbzRzdzRB5p8Bbm3jJRHrIfkAh5gz4t3T1gswQxrBiwe
         0CyUmpgnKrkZu4ixUm7kOZVosSSWzI0WkTnHRYGIYMylzvY5E9Xbwr5EugVi80OEyAhb
         +Ea8M+P/+Df1SVT4R3phYQytcMWFPJAdrFzzU+cqBp1CczdEONsFdALkIcXNpYSy5krl
         eBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240762; x=1787845562;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJpaQGyId8XAw9G51KmxUUm44NWnmeFrUK68rSnHLSg=;
        b=qQjT1Moxwb6sQ+1ybW9RaAZXiMysJdwvG3ylyLpTbqW5TktwXRAXHsm714K65kqjno
         lspjN5l+y6fnzMmlbtqQR074dvRIEXYTiYfyabXBDU+PCXpcbQn06r09FeHQ8XEBfKfR
         zk9ou6I6IP0DTMyFO1PBRhjjBJiRo2gKY/PXS+rCF4sjo0IctFxpckyo6UuK+6bJBFHb
         LW2/AtkCbBchf1md0+h28VWuJGGmaKOx2iqC1N7KGbvkiczERdOLGyDzz8bSWh32hAvF
         Oj01VhQ5hwr2gPW0a1tPD9Zmb8uNvXcTA3u4Qz2RQREEl9HojJUZT+euCd5eVtvNvo0h
         zffg==
X-Gm-Message-State: AFuF++mYkeYf8HdjNgg0ozg5OyZmU26fGlrSUG0asXO1Nw+CzG6nO6gj
	8g1BNN8vqLrX8KE6JaqMKf078Bgjgtr2S64N9iDbfE3lHmNvyDJ5fT0j8L94OQ==
X-Gm-Gg: AR+sD1105k3qtb31nTGfUj8XK9HiJbcQ/BQNqZ3t/z94MljD5inZjIEc1M8wtOGahWL
	+QFtAVgfx+C4TTrS5q/v1tiFfEn3RF6LsQSYcsEW5Oc0U1YdzTkhd+DnEY4lzNeatXDc8hb0PrE
	gJzdxKOklqFUah98zTZaM/0jrCuQeYc1QuKUbu9KP1CD/OhB5O0JsIGFOn2T3CVcxyAJnDIJA8+
	7Iifi8zguwZFBbTAwVWfBw9eZOSD/fBYz+Qh7idW/l0SSr0kzDzOKl5DwsKRHghKLYR2vKOlE3J
	8OG2JALtfEkT9MsUaPmixb322NSaSUcIQW0CG9wCMbppFgee8dl5ysS7GAlCJ87gZFBhLELoZ85
	ohIm9opnNYmyLxFHuLJShNZLPDmhMf3Fxc85/CKt6p+4pMFDdt5tdqPJ8rTaGxblfZiA6jAumtz
	R5K9mY+jaYpAPUDG9mmdRh30Wwyz3dHXzZlznqr8ZCO5rqbZu7c4vRgH/DH7DDyXWlMQ+2ZCeQ
X-Received: by 2002:a17:90b:224c:b0:36b:b903:994 with SMTP id 98e67ed59e1d1-395a044f27dmr9407780a91.4.1787240761736;
        Thu, 20 Aug 2026 08:46:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.47.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad3dd20sm16002210c88.3.2026.08.20.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:46:00 -0700 (PDT)
Message-Id: <pull.2205.v2.git.1787240760069.gitgitgadget@gmail.com>
In-Reply-To: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 15:46:00 +0000
Subject: [PATCH v2] worktree repair: detect relative path in .git file
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

Given a state where the cross references between the worktree and the
repository (specifically worktree/id/gitdir in the main repository and
the .git file in the worktree) are recorded using absolute paths,
setting 'worktree.useRelativePaths=true' and running 'git worktree
repair' within the main worktree converts them to relative paths.

On the other hand, given a state where the cross references are
recorded using relative paths, one would expect (by symmetry) that
setting 'worktree.useRelativePath=false' and running 'git worktree
repair' would convert them to absolute paths. However, they remain as
relative paths.

This is because we wrongly use read_gitfile_gently() which always
returns an absolute path. To fix this, introduce read_gitfile_raw()
that is almost same as read_gitfile_gently(), but it skips existence
check of the referenced repository and returns the unmodified path
read from .git file.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree repair: detect relative path in .git file correctly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2205%2Fyoichi%2Fworktree-repair-relative-path-handling-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2205/yoichi/worktree-repair-relative-path-handling-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2205

Range-diff vs v1:

 1:  c97b948565 ! 1:  5bcf19ef50 worktree repair: detect relative path in .git file correctly
     @@ Metadata
       ## Commit message ##
          worktree repair: detect relative path in .git file correctly
      
     -    Since read_gitfile_gently() always returns an absolute path, the
     -    conversion from a relative path to an absolute path was not
     -    functioning and dead code existed.
     +    Given a state where the cross references between the worktree and the
     +    repository (specifically worktree/id/gitdir in the main repository and
     +    the .git file in the worktree) are recorded using absolute paths,
     +    setting 'worktree.useRelativePaths=true' and running 'git worktree
     +    repair' within the main worktree converts them to relative paths.
      
     -    Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
     +    On the other hand, given a state where the cross references are
     +    recorded using relative paths, one would expect (by symmetry) that
     +    setting 'worktree.useRelativePath=false' and running 'git worktree
     +    repair' would convert them to absolute paths. However, they remain as
     +    relative paths.
      
     - ## builtin/init-db.c ##
     -@@ builtin/init-db.c: int cmd_init_db(int argc,
     - 		const char *p;
     - 		struct strbuf sb = STRBUF_INIT;
     - 
     --		p = read_gitfile_gently(git_dir, &err);
     -+		p = read_gitfile_gently(git_dir, NULL, &err);
     - 		if (p && get_common_dir(&sb, p)) {
     - 			struct strbuf mainwt = STRBUF_INIT;
     - 
     +    This is because we wrongly use read_gitfile_gently() which always
     +    returns an absolute path. To fix this, introduce read_gitfile_raw()
     +    that is almost same as read_gitfile_gently(), but it skips existence
     +    check of the referenced repository and returns the unmodified path
     +    read from .git file.
     +
     +    Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## setup.c ##
     -@@ setup.c: int is_nonbare_repository_dir(struct strbuf *path)
     - 	assert(orig_path_len != 0);
     - 	strbuf_complete(path, '/');
     - 	strbuf_addstr(path, ".git");
     --	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
     -+	if (read_gitfile_gently(path->buf, NULL, &gitfile_error) || is_git_directory(path->buf))
     - 		ret = 1;
     - 	if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
     - 	    gitfile_error == READ_GITFILE_ERR_READ_FAILED)
      @@ setup.c: void read_gitfile_error_die(int error_code, const char *path)
     -  * return path to git directory if found. The return value comes from
     -  * a shared buffer.
     -  *
     -+ * On success, if absolute is not NULL, it will be set to whether the
     -+ * path in .git file is an absolute path.
     -+ *
     -  * On failure, if return_error_code is not NULL, return_error_code
     -  * will be set to an error code and NULL will be returned. If
     -  * return_error_code is NULL the function will die instead (for most
     -  * cases).
        */
     --const char *read_gitfile_gently(const char *path, int *return_error_code)
     -+const char *read_gitfile_gently(const char *path, bool *absolute, int *return_error_code)
     + const char *read_gitfile_gently(const char *path, int *return_error_code)
       {
     - 	const int max_file_size = 1 << 20;  /* 1MB */
     +-	const int max_file_size = 1 << 20;  /* 1MB */
       	int error_code = 0;
     + 	char *buf = NULL;
     +-	char *dir = NULL;
     + 	const char *slash;
     ++	static struct strbuf realpath = STRBUF_INIT;
     ++
     ++	buf = xstrdup_or_null(read_gitfile_raw(path, &error_code));
     ++	if (error_code)
     ++		goto cleanup_return;
     ++
     ++	if (!is_absolute_path(buf) && (slash = strrchr(path, '/'))) {
     ++		size_t pathlen = slash+1 - path;
     ++		char *dir = xstrfmt("%.*s%.*s", (int)pathlen, path,
     ++				    (int)strlen(buf), buf);
     ++		free(buf);
     ++		buf = dir;
     ++	}
     ++	if (!is_git_directory(buf)) {
     ++		error_code = READ_GITFILE_ERR_NOT_A_REPO;
     ++		goto cleanup_return;
     ++	}
     ++
     ++	strbuf_realpath(&realpath, buf, 1);
     ++
     ++cleanup_return:
     ++	if (return_error_code)
     ++		*return_error_code = error_code;
     ++	else if (error_code)
     ++		read_gitfile_error_die(error_code, path);
     ++
     ++	free(buf);
     ++	return error_code ? NULL : realpath.buf;
     ++}
     ++
     ++const char *read_gitfile_raw(const char *path, int *return_error_code)
     ++{
     ++	const int max_file_size = 1 << 20;  /* 1MB */
     ++	int error_code = 0;
     ++	char *buf = NULL;
     + 	struct stat st;
     + 	int fd;
     + 	ssize_t len;
     +-	static struct strbuf realpath = STRBUF_INIT;
     ++	static struct strbuf contents = STRBUF_INIT;
     + 
     + 	if (stat(path, &st)) {
     + 		if (errno == ENOENT || errno == ENOTDIR)
      @@ setup.c: const char *read_gitfile_gently(const char *path, int *return_error_code)
     + 		error_code = READ_GITFILE_ERR_NO_PATH;
     + 		goto cleanup_return;
       	}
     - 	buf[len] = '\0';
     - 	dir = buf + 8;
     -+	if (absolute)
     -+		*absolute = is_absolute_path(dir);
     +-	buf[len] = '\0';
     +-	dir = buf + 8;
     +-
     +-	if (!is_absolute_path(dir) && (slash = strrchr(path, '/'))) {
     +-		size_t pathlen = slash+1 - path;
     +-		dir = xstrfmt("%.*s%.*s", (int)pathlen, path,
     +-			      (int)(len - 8), buf + 8);
     +-		free(buf);
     +-		buf = dir;
     +-	}
     +-	if (!is_git_directory(dir)) {
     +-		error_code = READ_GITFILE_ERR_NOT_A_REPO;
     +-		goto cleanup_return;
     +-	}
     +-
     +-	strbuf_realpath(&realpath, dir, 1);
     +-	path = realpath.buf;
     ++	strbuf_reset(&contents);
     ++	strbuf_add(&contents, buf+8, len-8);
       
     - 	if (!is_absolute_path(dir) && (slash = strrchr(path, '/'))) {
     - 		size_t pathlen = slash+1 - path;
     -@@ setup.c: static enum discovery_result repo_discovery_find_dir(struct strbuf *dir,
     - 		if (offset > min_offset)
     - 			strbuf_addch(dir, '/');
     - 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
     --		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
     -+		gitdirenv = read_gitfile_gently(dir->buf, NULL, &error_code);
     - 		if (!gitdirenv) {
     - 			switch (error_code) {
     - 			case READ_GITFILE_ERR_MISSING:
     -@@ setup.c: const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
     - {
     - 	if (is_git_directory(suspect))
     - 		return suspect;
     --	return read_gitfile_gently(suspect, return_error_code);
     -+	return read_gitfile_gently(suspect, NULL, return_error_code);
     + cleanup_return:
     +-	if (return_error_code)
     +-		*return_error_code = error_code;
     +-	else if (error_code)
     +-		read_gitfile_error_die(error_code, path);
     +-
     ++	*return_error_code = error_code;
     + 	free(buf);
     +-	return error_code ? NULL : path;
     ++	return error_code ? NULL : contents.buf;
       }
       
     - /* if any standard file descriptor is missing open it to /dev/null */
     + static void apply_gitdir_and_environment(struct repository *repo, const char *path)
      
       ## setup.h ##
      @@ setup.h: int is_nonbare_repository_dir(struct strbuf *path);
     - #define READ_GITFILE_ERR_MISSING 9
       #define READ_GITFILE_ERR_IS_A_DIR 10
       void read_gitfile_error_die(int error_code, const char *path);
     --const char *read_gitfile_gently(const char *path, int *return_error_code);
     --#define read_gitfile(path) read_gitfile_gently((path), NULL)
     -+const char *read_gitfile_gently(const char *path, bool *absolute, int *return_error_code);
     -+#define read_gitfile(path) read_gitfile_gently((path), NULL, NULL)
     + const char *read_gitfile_gently(const char *path, int *return_error_code);
     ++const char *read_gitfile_raw(const char *path, int *return_error_code);
     + #define read_gitfile(path) read_gitfile_gently((path), NULL)
       const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
       #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
     - 
      
       ## t/t2406-worktree-repair.sh ##
      @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative path with missing gitfile' '
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
       
      -test_expect_success 'repair absolute worktree to use relative paths' '
      -	test_when_finished "rm -rf main side sidemoved" &&
     -+test_expect_success 'repair absolute to relative in side worktree' '
     ++test_expect_success 'repair absolute to relative from side worktree' '
      +	test_when_finished "rm -rf main side" &&
       	test_create_repo main &&
       	test_commit -C main init &&
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
       	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
      -	mv side sidemoved &&
      -	git -C main worktree repair --relative-paths ../sidemoved &&
     -+	git -C side worktree repair --relative-paths 2>main/err &&
     ++	git -C main worktree repair --relative-paths ../side 2>main/err &&
      +	test_grep "gitdir absolute/relative path mismatch" main/err &&
       	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
      -	test_cmp expect-gitfile sidemoved/.git
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
       
      -test_expect_success 'repair relative worktree to use absolute paths' '
      -	test_when_finished "rm -rf main side sidemoved" &&
     -+test_expect_success 'repair relative to absolute in side worktree' '
     ++test_expect_success 'repair relative to absolute from side worktree' '
      +	test_when_finished "rm -rf main side" &&
       	test_create_repo main &&
       	test_commit -C main init &&
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
       	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
      -	mv side sidemoved &&
      -	git -C main worktree repair ../sidemoved &&
     -+	git -C side worktree repair 2>main/err &&
     ++	git -C main worktree repair ../side 2>main/err &&
      +	test_grep "gitdir absolute/relative path mismatch" main/err &&
       	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
      -	test_cmp expect-gitfile sidemoved/.git
      +	test_cmp expect-gitfile side/.git
      +'
      +
     -+test_expect_success 'repair absolute to relative in main worktree' '
     ++test_expect_success 'repair absolute to relative from main worktree' '
      +	test_when_finished "rm -rf main side" &&
      +	test_create_repo main &&
      +	git -C main config worktree.useRelativePaths false &&
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
      +	test_cmp expect-gitfile side/.git
      +'
      +
     -+test_expect_success 'repair relative to absolute in main worktree' '
     ++test_expect_success 'repair relative to absolute from main worktree' '
      +	test_when_finished "rm -rf main side" &&
      +	test_create_repo main &&
      +	git -C main config worktree.useRelativePaths true &&
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
       test_done
      
       ## worktree.c ##
     -@@ worktree.c: int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
     - 		goto done;
     - 	}
     - 
     --	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, &err));
     -+	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, NULL, &err));
     - 	if (!path) {
     - 		strbuf_addf_gently(errmsg, _("'%s' is not a .git file, error code %d"),
     - 				   wt_path.buf, err);
     -@@ worktree.c: static void repair_gitfile(struct worktree *wt,
     - 	struct strbuf repo = STRBUF_INIT;
     - 	struct strbuf backlink = STRBUF_INIT;
     - 	char *dotgit_contents = NULL;
     -+	bool absolute;
     - 	const char *repair = NULL;
     - 	char *path = NULL;
     - 	int err;
      @@ worktree.c: static void repair_gitfile(struct worktree *wt,
       	strbuf_realpath(&repo, path, 1);
       	strbuf_addf(&dotgit, "%s/.git", wt->path);
       	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
      -	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
     -+	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &absolute, &err));
     - 
     --	if (dotgit_contents) {
     --		if (is_absolute_path(dotgit_contents)) {
     --			strbuf_addstr(&backlink, dotgit_contents);
     --		} else {
     --			strbuf_addf(&backlink, "%s/%s", wt->path, dotgit_contents);
     --			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
     --		}
     --	}
     -+	if (dotgit_contents)
     -+		strbuf_addstr(&backlink, dotgit_contents);
     ++	dotgit_contents = xstrdup_or_null(read_gitfile_raw(dotgit.buf, &err));
       
     + 	if (dotgit_contents) {
     + 		if (is_absolute_path(dotgit_contents)) {
     +@@ worktree.c: static void repair_gitfile(struct worktree *wt,
       	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
       		err == READ_GITFILE_ERR_IS_A_DIR)
     -@@ worktree.c: static void repair_gitfile(struct worktree *wt,
     + 		fn(1, wt->path, _(".git is not a file"), cb_data);
     +-	else if (err)
     ++	else if (err || !is_git_directory(backlink.buf))
       		repair = _(".git file broken");
       	else if (fspathcmp(backlink.buf, repo.buf))
       		repair = _(".git file incorrect");
     --	else if (use_relative_paths == is_absolute_path(dotgit_contents))
     -+	else if (use_relative_paths == absolute)
     - 		repair = _(".git file absolute/relative path mismatch");
     - 
     - 	if (repair) {
      @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
     - 
     - 	infer_backlink(repo, dotgit.buf, &inferred_backlink);
       	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
     --	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
     -+	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, NULL, &err));
     + 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
       	if (dotgit_contents) {
      -		if (is_absolute_path(dotgit_contents)) {
      -			strbuf_addstr(&backlink, dotgit_contents);


 setup.c                    | 66 +++++++++++++++++++++++---------------
 setup.h                    |  1 +
 t/t2406-worktree-repair.sh | 54 ++++++++++++++++++++++++-------
 worktree.c                 | 13 ++------
 4 files changed, 86 insertions(+), 48 deletions(-)

diff --git a/setup.c b/setup.c
index 95909e9603..73111e08af 100644
--- a/setup.c
+++ b/setup.c
@@ -963,15 +963,48 @@ void read_gitfile_error_die(int error_code, const char *path)
  */
 const char *read_gitfile_gently(const char *path, int *return_error_code)
 {
-	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
 	char *buf = NULL;
-	char *dir = NULL;
 	const char *slash;
+	static struct strbuf realpath = STRBUF_INIT;
+
+	buf = xstrdup_or_null(read_gitfile_raw(path, &error_code));
+	if (error_code)
+		goto cleanup_return;
+
+	if (!is_absolute_path(buf) && (slash = strrchr(path, '/'))) {
+		size_t pathlen = slash+1 - path;
+		char *dir = xstrfmt("%.*s%.*s", (int)pathlen, path,
+				    (int)strlen(buf), buf);
+		free(buf);
+		buf = dir;
+	}
+	if (!is_git_directory(buf)) {
+		error_code = READ_GITFILE_ERR_NOT_A_REPO;
+		goto cleanup_return;
+	}
+
+	strbuf_realpath(&realpath, buf, 1);
+
+cleanup_return:
+	if (return_error_code)
+		*return_error_code = error_code;
+	else if (error_code)
+		read_gitfile_error_die(error_code, path);
+
+	free(buf);
+	return error_code ? NULL : realpath.buf;
+}
+
+const char *read_gitfile_raw(const char *path, int *return_error_code)
+{
+	const int max_file_size = 1 << 20;  /* 1MB */
+	int error_code = 0;
+	char *buf = NULL;
 	struct stat st;
 	int fd;
 	ssize_t len;
-	static struct strbuf realpath = STRBUF_INIT;
+	static struct strbuf contents = STRBUF_INIT;
 
 	if (stat(path, &st)) {
 		if (errno == ENOENT || errno == ENOTDIR)
@@ -1014,32 +1047,13 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
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
+	strbuf_reset(&contents);
+	strbuf_add(&contents, buf+8, len-8);
 
 cleanup_return:
-	if (return_error_code)
-		*return_error_code = error_code;
-	else if (error_code)
-		read_gitfile_error_die(error_code, path);
-
+	*return_error_code = error_code;
 	free(buf);
-	return error_code ? NULL : path;
+	return error_code ? NULL : contents.buf;
 }
 
 static void apply_gitdir_and_environment(struct repository *repo, const char *path)
diff --git a/setup.h b/setup.h
index 654f10e059..442acd8954 100644
--- a/setup.h
+++ b/setup.h
@@ -40,6 +40,7 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
+const char *read_gitfile_raw(const char *path, int *return_error_code);
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
index cbf95328a3..48e77636cf 100644
--- a/worktree.c
+++ b/worktree.c
@@ -667,7 +667,7 @@ static void repair_gitfile(struct worktree *wt,
 	strbuf_realpath(&repo, path, 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
 	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
-	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+	dotgit_contents = xstrdup_or_null(read_gitfile_raw(dotgit.buf, &err));
 
 	if (dotgit_contents) {
 		if (is_absolute_path(dotgit_contents)) {
@@ -681,7 +681,7 @@ static void repair_gitfile(struct worktree *wt,
 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 		err == READ_GITFILE_ERR_IS_A_DIR)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
-	else if (err)
+	else if (err || !is_git_directory(backlink.buf))
 		repair = _(".git file broken");
 	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
@@ -857,14 +857,7 @@ void repair_worktree_at_path(struct repository *repo,
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
