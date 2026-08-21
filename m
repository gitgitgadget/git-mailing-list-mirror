Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25767CA6B
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344590; cv=none; b=RsWZimXDXNNEaTAUSmlxDbOFzCXq47/f4aTApzS8PtN9CT7g+vDPnxVCVYkdbj7BSbZ/f8vV9DwEi+7ZGHnV7l7QgirHLLR8a5NJbwHBytgSwvBlNvT+Xdzj7AxNAkskl1HSNv9k+ehdDlR3vLcJceiLFJscNwQvDEnyRWzMZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344590; c=relaxed/simple;
	bh=MyRfIe0FCLXgeISboIuXxtswOjcvZILJNgEbOORlEwU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qskmVVACV5d0rUTG0esxAhlKv5Hh0LxidE2IaK7e6+i526eugMX7E0X+AqZyYSHcN7+y9LMXn7eWIEVF5qU/AWL+JSvLMXlDZ7cm1sEpdh/NUK9QlYWU7ghhpFacVoXwaVwUtVwA9IGOdkXJKiIz3Ql17t9Uzdf/3oylUt9/di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAUieU5r; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAUieU5r"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1548430a91.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787344588; x=1787949388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=khpGg35U3qnPSjbDivk7jl+9jRhyMn2z9u0bTQyhYuA=;
        b=GAUieU5rkkzdYqxGUF45FCK5wG1I907q2K0ZNVjH2AADjXr+kK0Z5bLCw2FSkJBvoY
         zWIYbgJFabRPC8lxraTRwQuTmJUmvQ7jYVLxnxoYW931fMYHSui7TA/mDWGolkIfhFdR
         s4fjFGSKwDgeCF5FXW3dH7Un2AuOCA6r1hwdYN14zdLY1ZVz5EclewfChkyBRDzfWjIN
         L6NkEWHAN+nKotOPUYVYZthGqZ2/5sSisv+pmY30ukXUDBazgHTM6u9GlcyotC2VGjS2
         ROI/WA4lQbBg+z5NT0jhfQnGQeaULHJuhz3QTpUdSogLkHSkgzPZ4EzwFChm4ZTA+MJY
         XEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787344588; x=1787949388;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khpGg35U3qnPSjbDivk7jl+9jRhyMn2z9u0bTQyhYuA=;
        b=k85YeFsOUUaxtVaUDRYy6IBh+9p123mUA6q5l4c5hV1Yfte/9lj58N0NsJ6p94OgQR
         0EL7Ak8N5wUdH7SFyu+7Tf9h3AXPuxkBgTgu9rxC9EuRuRsHofLrp9pYEYsmn90WyhWS
         81OaZJweAoilLr6+nWt1kzcLmkD7MOVOVxkSHMKHRCQG6tEBgohtrW+tfxZhguAjpbQY
         wb/Xbi+qKgkXUPgCDjD7+ojGZAzsCPKzGoOvtDTmxnVgzgnEbx9OprmTsDCaoE/jyYkc
         Y6JT3S5ElkEj9MIx97jCNLNMMr5yy+Li7kO2Y8sTjXOlvpRXbEn7yUy7B1qTscoEDiBt
         tEfg==
X-Gm-Message-State: AFuF++nWBEbTrjVV2Pul9MXUX4svLN4DP7WXis/CIh9xamulXiU+Dg7S
	7SZL7f02JMevGyMVtRy0yu4/5qVPPCYWyGFHor+ukfPGTxvMHQRdKlp16+HKig==
X-Gm-Gg: AR+sD12HQrOkkIEHT9RnyK44gm+3jcYDRIy86t6JJYBvz8etrSIFDYyRwyui9JD0Fdv
	V2BvoCVtofBzJmoP7U6bgsaI4h90dAE28DuoKh8iKyYVL5Uwb0G0KOQWCH6uRLlzW5h8ld8M6hF
	hovzKs8N0lj8Q4yXYECUznHceuO5KGHhyufrpnEVg1DRZoo/+zhI9m+SpT7RS90Jqw44SAkrfMC
	uFDJWDEjLG4Z4QNvitSoD7FlKAvwh6f731gjxKXbN2IYiAm0ELsvOsmKOBVJqNAOdz0DfsHIhrE
	GtpeIy8KZh0dk4C7D85MG8lX1I31lGnrwns9ly6Tg4s4dSfOu2+KVkgbwMqSae7HjxpAqoKTinu
	cDKstmv17azQ02PTMyTzGgUElZtGfgC/l8fOrODp1isBztbVaPVNvBomtcL6VqzrZzF8XNQe813
	FEdMvAOYwliKrhOBYRo9SMHDtaeitGUvYD1tXBWWQFMCEzO7+DqCtnzr2V4AsgqBo=
X-Received: by 2002:a17:90b:3d87:b0:38f:837e:fc5d with SMTP id 98e67ed59e1d1-395c334050emr17271686a91.3.1787344588263;
        Fri, 21 Aug 2026 13:36:28 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.183.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49985fcsm97468a91.7.2026.08.21.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:36:27 -0700 (PDT)
Message-Id: <pull.2205.v3.git.1787344586470.gitgitgadget@gmail.com>
In-Reply-To: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 20:36:26 +0000
Subject: [PATCH v3] worktree repair: detect relative path in .git file
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
which is almost identical to read_gitfile_gently(), but skips checking
the existence of the referenced repository and returns the path as-is
from the .git file.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree repair: detect relative path in .git file correctly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2205%2Fyoichi%2Fworktree-repair-relative-path-handling-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2205/yoichi/worktree-repair-relative-path-handling-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2205

Range-diff vs v2:

 1:  5bcf19ef50 ! 1:  1cd25e315e worktree repair: detect relative path in .git file correctly
     @@ Metadata
       ## Commit message ##
          worktree repair: detect relative path in .git file correctly
      
     -    Given a state where the cross references between the worktree and the
     -    repository (specifically worktree/id/gitdir in the main repository and
     -    the .git file in the worktree) are recorded using absolute paths,
     +    Given a state in which the cross-references between the worktree and
     +    the repository (specifically worktree/id/gitdir in the main repository
     +    and the .git file in the worktree) are recorded using absolute paths,
          setting 'worktree.useRelativePaths=true' and running 'git worktree
          repair' within the main worktree converts them to relative paths.
      
     -    On the other hand, given a state where the cross references are
     -    recorded using relative paths, one would expect (by symmetry) that
     -    setting 'worktree.useRelativePath=false' and running 'git worktree
     -    repair' would convert them to absolute paths. However, they remain as
     -    relative paths.
     +    Conversely, given a state in which the cross-references are recorded
     +    using relative paths, one would expect that setting
     +    'worktree.useRelativePaths=false' and running 'git worktree repair'
     +    would convert them to absolute paths. However, they remain as relative
     +    paths.
      
     -    This is because we wrongly use read_gitfile_gently() which always
     -    returns an absolute path. To fix this, introduce read_gitfile_raw()
     -    that is almost same as read_gitfile_gently(), but it skips existence
     -    check of the referenced repository and returns the unmodified path
     -    read from .git file.
     +    This is because we incorrectly use read_gitfile_gently(), which always
     +    returns an absolute path. To fix this, introduce read_gitfile_raw(),
     +    which is almost identical to read_gitfile_gently(), but skips checking
     +    the existence of the referenced repository and returns the path as-is
     +    from the .git file.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## setup.c ##
      @@ setup.c: void read_gitfile_error_die(int error_code, const char *path)
     +  * cases).
        */
       const char *read_gitfile_gently(const char *path, int *return_error_code)
     - {
     --	const int max_file_size = 1 << 20;  /* 1MB */
     - 	int error_code = 0;
     - 	char *buf = NULL;
     --	char *dir = NULL;
     - 	const char *slash;
     ++{
     ++	int error_code = 0;
     ++	const char *slash;
     ++	struct strbuf contents = STRBUF_INIT;
      +	static struct strbuf realpath = STRBUF_INIT;
      +
     -+	buf = xstrdup_or_null(read_gitfile_raw(path, &error_code));
     ++	error_code = read_gitfile_raw(&contents, path);
      +	if (error_code)
      +		goto cleanup_return;
      +
     -+	if (!is_absolute_path(buf) && (slash = strrchr(path, '/'))) {
     ++	if (!is_absolute_path(contents.buf) && (slash = strrchr(path, '/'))) {
      +		size_t pathlen = slash+1 - path;
     -+		char *dir = xstrfmt("%.*s%.*s", (int)pathlen, path,
     -+				    (int)strlen(buf), buf);
     -+		free(buf);
     -+		buf = dir;
     ++		char *dir = xstrfmt("%.*s%s", (int)pathlen, path, contents.buf);
     ++		strbuf_reset(&contents);
     ++		strbuf_addstr(&contents, dir);
     ++		free(dir);
      +	}
     -+	if (!is_git_directory(buf)) {
     ++	if (!is_git_directory(contents.buf)) {
      +		error_code = READ_GITFILE_ERR_NOT_A_REPO;
      +		goto cleanup_return;
      +	}
      +
     -+	strbuf_realpath(&realpath, buf, 1);
     ++	strbuf_realpath(&realpath, contents.buf, 1);
      +
      +cleanup_return:
      +	if (return_error_code)
     @@ setup.c: void read_gitfile_error_die(int error_code, const char *path)
      +	else if (error_code)
      +		read_gitfile_error_die(error_code, path);
      +
     -+	free(buf);
     ++	strbuf_release(&contents);
      +	return error_code ? NULL : realpath.buf;
      +}
      +
     -+const char *read_gitfile_raw(const char *path, int *return_error_code)
     -+{
     -+	const int max_file_size = 1 << 20;  /* 1MB */
     -+	int error_code = 0;
     -+	char *buf = NULL;
     ++int read_gitfile_raw(struct strbuf *contents, const char *path)
     + {
     + 	const int max_file_size = 1 << 20;  /* 1MB */
     + 	int error_code = 0;
     + 	char *buf = NULL;
     +-	char *dir = NULL;
     +-	const char *slash;
       	struct stat st;
       	int fd;
       	ssize_t len;
      -	static struct strbuf realpath = STRBUF_INIT;
     -+	static struct strbuf contents = STRBUF_INIT;
       
       	if (stat(path, &st)) {
       		if (errno == ENOENT || errno == ENOTDIR)
     @@ setup.c: const char *read_gitfile_gently(const char *path, int *return_error_cod
      -
      -	strbuf_realpath(&realpath, dir, 1);
      -	path = realpath.buf;
     -+	strbuf_reset(&contents);
     -+	strbuf_add(&contents, buf+8, len-8);
     ++	strbuf_add(contents, buf+8, len-8);
       
       cleanup_return:
      -	if (return_error_code)
     @@ setup.c: const char *read_gitfile_gently(const char *path, int *return_error_cod
      -	else if (error_code)
      -		read_gitfile_error_die(error_code, path);
      -
     -+	*return_error_code = error_code;
       	free(buf);
      -	return error_code ? NULL : path;
     -+	return error_code ? NULL : contents.buf;
     ++	return error_code;
       }
       
       static void apply_gitdir_and_environment(struct repository *repo, const char *path)
     @@ setup.h: int is_nonbare_repository_dir(struct strbuf *path);
       #define READ_GITFILE_ERR_IS_A_DIR 10
       void read_gitfile_error_die(int error_code, const char *path);
       const char *read_gitfile_gently(const char *path, int *return_error_code);
     -+const char *read_gitfile_raw(const char *path, int *return_error_code);
     ++int read_gitfile_raw(struct strbuf *contents, const char *path);
       #define read_gitfile(path) read_gitfile_gently((path), NULL)
       const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
       #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair worktree with relative p
       test_done
      
       ## worktree.c ##
     +@@ worktree.c: static void repair_gitfile(struct worktree *wt,
     + 	struct strbuf gitdir = STRBUF_INIT;
     + 	struct strbuf repo = STRBUF_INIT;
     + 	struct strbuf backlink = STRBUF_INIT;
     +-	char *dotgit_contents = NULL;
     ++	struct strbuf contents = STRBUF_INIT;
     ++	const char *dotgit_contents = NULL;
     + 	const char *repair = NULL;
     + 	char *path = NULL;
     + 	int err;
      @@ worktree.c: static void repair_gitfile(struct worktree *wt,
       	strbuf_realpath(&repo, path, 1);
       	strbuf_addf(&dotgit, "%s/.git", wt->path);
       	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
      -	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
     -+	dotgit_contents = xstrdup_or_null(read_gitfile_raw(dotgit.buf, &err));
     ++	err = read_gitfile_raw(&contents, dotgit.buf);
     ++	if (!err)
     ++		dotgit_contents = contents.buf;
       
       	if (dotgit_contents) {
       		if (is_absolute_path(dotgit_contents)) {
     @@ worktree.c: static void repair_gitfile(struct worktree *wt,
       		repair = _(".git file broken");
       	else if (fspathcmp(backlink.buf, repo.buf))
       		repair = _(".git file incorrect");
     +@@ worktree.c: static void repair_gitfile(struct worktree *wt,
     + 	}
     + 
     + done:
     +-	free(dotgit_contents);
     + 	free(path);
     + 	strbuf_release(&repo);
     + 	strbuf_release(&dotgit);
     + 	strbuf_release(&gitdir);
     + 	strbuf_release(&backlink);
     ++	strbuf_release(&contents);
     + }
     + 
     + static void repair_noop(int iserr UNUSED,
      @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
       	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
       	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));


 setup.c                    | 63 ++++++++++++++++++++++----------------
 setup.h                    |  1 +
 t/t2406-worktree-repair.sh | 54 ++++++++++++++++++++++++--------
 worktree.c                 | 20 +++++-------
 4 files changed, 88 insertions(+), 50 deletions(-)

diff --git a/setup.c b/setup.c
index 95909e9603..9041827336 100644
--- a/setup.c
+++ b/setup.c
@@ -962,16 +962,48 @@ void read_gitfile_error_die(int error_code, const char *path)
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
@@ -1014,32 +1046,11 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
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
