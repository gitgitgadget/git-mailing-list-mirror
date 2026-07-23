Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCD3E49C6
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842848; cv=none; b=M6mdX7rXMvRsTQRm5JeneV/jVcmTx4GDbMzOJI/qXWq4VHNV6DuRKElpMuDEI4WRGKWqkr/tN8dZk0h8Ill2zF/mFzJ+OFvT0JQQI/LO//N7MsGzpZERrBptyHXmVTJfD9aJ3YhcbkCisB/StiSyYoi0iFn4JPqb2bkKDdVF65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842848; c=relaxed/simple;
	bh=h++RS6ktiAp/btHZyg5H2t39QnDH7KNnd2dZA0lvS+8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D4LGWRSFhkHXrLJXEjA6zIC1tS5+JWSckYGCmXMxBYTJXNY01/VkaYThIERIJSbm2nYd1GT9Xw4PSG78+FYaSFG3/FECfW76hp0xTv3QLkPk0heO+gSEFTW5pxGf8QuYe7goShtiouYiVYXeodKYq0USFen9A6UoW1Vgkw8EAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai94clbP; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai94clbP"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9d7464b71so525494a34.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842839; x=1785447639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OPNAuB40Q/qwPMozR/UTBtUXtSmu8wBta/IGcdtQ0mc=;
        b=ai94clbP5NGTkTL/eUUYax+BNSTwej1SO4JgNT4T25sckfpDhmLpKwTPs1oWb5SHlC
         xBdvA8hkG9iEtmMEmcLOmx1O7APtX3dsNQGFJ1s/v+g4qVB1gJJ6oyiHT8sMaaHeLqUE
         3mR3uWo6vYzL25VvRC2VxA2NAYr/dC7v7APF522lZNXVhjH7tw4v4K+/3CmwjO7llVQq
         TgAiXYITYPrylLJROH8NmYDCFePw9rv+PreZ/cYW9gBTjbXkBmNJEmWFQk9Ko2V8CeRY
         0RFYYCXBqQ891tyGDotbxYsaJB/ZFjtlPZO77b+fLTEAN9yAvtB7U2l14Pajw/4EZ5ID
         8Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842839; x=1785447639;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPNAuB40Q/qwPMozR/UTBtUXtSmu8wBta/IGcdtQ0mc=;
        b=jT+Pvr5U3dGl42S0mMmwUJcguDw9fvPpTJimo/Dx4EX3ZLyfJB7fJ4m2yujkOqTlb5
         hf98oCUGuZlFSL2ufDFKWcgDqH2Z6MhIhAH0AHAs1cKQnY7hb9Rx8KnqwwebYm2MoE01
         hIbOnh/c3rLlafzIT2nf4sYJQlydAZJf2QjgnL885puW5IsBjEQO1Dx3qT2RV+GMJ+pI
         apZi+smGw/CNy0F9d/GJCOqGU4Cq+YkeYw4fL1ug3aUq7vPAxyRSaMRe2JEkQYV5l270
         k2BGr8iqNm9GnVrqVtn0UknLusyeH82dVs5tqG0xq2RNv9dVOPgTBNnmIpLm8iCH8DlC
         U2eQ==
X-Gm-Message-State: AOJu0YwDhT15nWTUtNCMszwKpNrNIubWfkgiG6yusgCzngAw+NV2QKtj
	z6h1Myl2ijqen7Pj8LS27+O94eI4NywuhfelFsooiaOWL3JHrP46uAUxy70JiQ==
X-Gm-Gg: AR+sD11KgFja7kJYinC9SnKEMncl4e2hWiowD1QjR6/1Y+Eack+nog+w7vEsONujwER
	iEgST81lvl+TITacMv1GhTrhz6ELN5NcAVkAFn/l9NmiMbDF0RarD9oaU8DcY8QnTxFa/WgW+oC
	573gqWc99YcoZ26kXHaIoma2ttdrfEI7W5R/qaG3khs8AcHhNpOZn8qJOFcHIaDqk+7dMLd1q+Y
	J7pe/fgMMc/skJKZakcEuhaCo+G+QH4QvKDfpHmk9BTIgIno8f/yWYX+LvQ6c87sMgdSZ0U7Fp7
	pfVKkNN7eRiFsPYyH4jARK0zwQ0YwKKqPq2MZnjf00B5xEV/gy7RkiDeyUScp/R2kmuQ3AzJKHr
	UHyJgZp2EOK/2HBsWuN1oAos9qYBRbx+CCPWAxpO/n5h2V4OCcCXglCRdr2J6mKWZjV7ekUNoPf
	gyRJgQ
X-Received: by 2002:a05:6830:6994:b0:7e7:8dc0:3951 with SMTP id 46e09a7af769-7ee43a9fed1mr2439967a34.8.1784842834042;
        Thu, 23 Jul 2026 14:40:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.139.85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db292esm4420511a34.6.2026.07.23.14.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:40:32 -0700 (PDT)
Message-Id: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
References: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:40:29 +0000
Subject: [PATCH v3 0/2] mv: report missing destination leading directory
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

Changes in v3:

 * changed check from lstat to stat so it follows symlinks as suggested by
   Junio C Hamano
 * added ENOTDIR verification as suggested by Junio C Hamano
 * added S_ISDIR check to catch files as path components as suggested by
   Junio C Hamano
 * fixed indentation

Changes in v2:

 * altered the error message to include both source and destination as
   suggested by Ben Knoble

Lucas Zamboni Orioli (2):
  mv: name both source and destination when rename fails
  mv: check for missing destination directory before renaming

 builtin/mv.c  | 26 +++++++++++++++++++++++++-
 t/t7001-mv.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2356%2FZamboniL%2Fmv-detect-non-existing-target-folder-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2356/ZamboniL/mv-detect-non-existing-target-folder-v3
Pull-Request: https://github.com/git/git/pull/2356

Range-diff vs v2:

 1:  0d67da588b = 1:  0d67da588b mv: name both source and destination when rename fails
 2:  1a790e0016 ! 2:  5ac1587362 mv: check for missing destination directory before renaming
     @@ Commit message
          with ENOENT. The checking phase already rejects a missing destination
          directory when the destination ends in a slash, but a destination that
          names a file inside a non-existent directory is not caught and only
     -    fails later at the syscall. As a consequence "git mv -n" does not
     -    detect the problem either: the dry run never reaches rename(2) and
     -    reports a move that would not actually succeed.
     +    fails later at the syscall. The same is true when a leading path
     +    component exists but is not a directory: rename(2) fails with ENOTDIR,
     +    again only at the syscall. As a consequence "git mv -n" does not detect
     +    either problem: the dry run never reaches rename(2) and reports a move
     +    that would not actually succeed.
      
          Detect this during the checking phase. For entries that will be renamed
     -    on disk, stat the destination's leading directory and, if it is
     -    missing, fail with the existing "destination directory does not exist"
     -    message. Guard the check with the same condition under which rename(2)
     -    is invoked, so that directory moves, whose child entries are expanded
     -    to paths under a not-yet-created directory, and sparse or out-of-cone
     -    destinations, which are not written to the worktree, are not flagged
     -    incorrectly.
     +    on disk, stat the destination's leading directory and fail with a
     +    suitable message if it is missing or is not a directory. stat() is used
     +    rather than lstat() so that the check follows symlinks the same way
     +    rename(2) does: a symlink to a directory is accepted, while a symlink to
     +    a file is rejected. A missing directory or a non-directory path
     +    component (ENOENT or ENOTDIR) reuses the existing "destination directory
     +    does not exist" message; a leading component that resolves to a
     +    non-directory reports "destination is not a directory". Other stat()
     +    errors fall through to rename(2), which reports them as before.
      
     -    This is a best-effort diagnostic rather than a guarantee: the
     -    destination directory can still disappear between the check and the
     -    rename(2). It fixes the common case and, unlike the syscall path,
     -    lets "git mv -n" report the failure.
     -
     -    Add tests covering both the error path and the dry-run detection.
     +    Add tests covering the missing directory, a path component that is a
     +    file, a symlink to a file, a symlink to a directory (which must still
     +    succeed), and dry-run detection.
      
          Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
      
     @@ builtin/mv.c: dir_check:
       		}
       
      +		/*
     -+		* If we are going to move SRC to DST on disk, DST's leading
     -+		* directories must already exist.
     -+		*/
     ++		 * If we are going to move SRC to DST on disk, DST's leading
     ++		 * directories must already exist.
     ++		 */
      +		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
      +				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
     -+				char *dst_dir = xstrdup(dst);
     -+				char *slash = strrchr(dst_dir, '/');
     ++			char *dst_dir = xstrdup(dst);
     ++			char *slash = strrchr(dst_dir, '/');
      +
     -+				if (slash) {
     -+						struct stat dir_st;
     -+						*slash = '\0';
     -+						if (lstat(dst_dir, &dir_st) < 0 && errno == ENOENT) {
     -+								free(dst_dir);
     -+								bad = _("destination directory does not exist");
     -+								goto act_on_entry;
     -+						}
     -+				}
     -+				free(dst_dir);
     ++			if (slash) {
     ++				struct stat dir_st;
     ++				*slash = '\0';
     ++				if (stat(dst_dir, &dir_st) < 0) {
     ++					/* other errors fall through to rename(), which reports them */
     ++					if (errno == ENOENT || errno == ENOTDIR)
     ++						bad = _("destination directory does not exist");
     ++				} else if (!S_ISDIR(dir_st.st_mode))
     ++					bad = _("destination is not a directory");
     ++			}
     ++			free(dst_dir);
     ++			if (bad)
     ++				goto act_on_entry;
      +		}
      +
       		if (ignore_sparse &&
     @@ t/t7001-mv.sh: test_expect_success 'clean up' '
       	git reset --hard
       '
       
     -+test_expect_success 'moving to non-existent destination parent directory' '
     ++test_expect_success 'moving to a non-existent path component in the destination' '
      +	git reset --hard &&
      +	mkdir -p from &&
      +	echo content >from/file &&
     @@ t/t7001-mv.sh: test_expect_success 'clean up' '
      +	test_grep "destination directory does not exist" actual
      +'
      +
     ++test_expect_success 'moving to a destination with a file as a path component' '
     ++	git reset --hard &&
     ++	mkdir -p from &&
     ++	echo contents >from/file &&
     ++	echo blocker >not-dir &&
     ++	git add from/file &&
     ++	test_must_fail git mv from/file not-dir/file 2>actual &&
     ++	test_grep "destination is not a directory" actual
     ++'
     ++
     ++test_expect_success SYMLINKS 'moving to a destination with a symlink to a file as a path component' '
     ++	git reset --hard &&
     ++	mkdir -p from &&
     ++	echo contents >from/file &&
     ++	echo target >regular &&
     ++	ln -s regular link-to-file &&
     ++	git add from/file &&
     ++	test_must_fail git mv from/file link-to-file/file 2>actual &&
     ++	test_grep "not a directory" actual
     ++'
     ++
     ++test_expect_success SYMLINKS 'moving to a destination with a symlink to a directory' '
     ++	git reset --hard &&
     ++	mkdir -p from realdir &&
     ++	echo contents >from/file &&
     ++	ln -s realdir link-to-dir &&
     ++	git add from/file &&
     ++	git mv from/file link-to-dir/file &&
     ++	test_path_is_file realdir/file
     ++'
     ++
      +test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
     ++	git reset --hard &&
     ++	mkdir -p from &&
     ++	echo content >from/file &&
     ++	git add from/file &&
      +	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
      +	test_grep "destination directory does not exist" actual
      +'

-- 
gitgitgadget
