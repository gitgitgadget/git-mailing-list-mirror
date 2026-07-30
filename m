Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3996411A16
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410893; cv=none; b=mDCf7NuMahug27X2+UNt2+LRdTWi2bVkoG1wR2o4PxL4OLWMGfbOfV157MkLJCODZaKQQmP2f1JfHoBpMrXUVmlYxqatrJJeE1UWgyaQr6Dxcwog87VlsPh5dkZSFNBAjhmJvjOciPOYWl+flsBqPT8j/WbvWIKGg907ahBN90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410893; c=relaxed/simple;
	bh=zx6FCgktV/BPk4gLfwwyTDnQqJArHMVN+fMvUvqt7eA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X5kFI/a1uQd00yCqA5y+brJZ/E530dSuhlSzWHtaBwu5/EyuexbB/gVjjE8PW4s3LfB4ZLsAPxMYiIQk84IxOpusYKRH/CWxhQYKV8ELl8HxOVNGdQGgQBhQ5cbDQ0yN7Ni77BrVwZporDttiKW+p7t5F92WkwxGL0V1vxWGRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ5ng7RJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ5ng7RJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso23822745ad.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785410891; x=1786015691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4rIKW4dcdCXvHAPAgaDV19js9bd3EoLyoIBY77YB7rA=;
        b=bZ5ng7RJB7r2wsBAocwWtH29vFWeYg9t6sbLfu9Nd2WV1A+Z+//MRcPlbBFgW+psD8
         3XkFMt5Gfn/MuyScftPcbq+LDk6kSj0QwskgazzDwZWWyttoLuAD0SKuQaDPdX4Fvo6U
         YizCSwmhSpT5EVKR24K6ecgOUo2WC9Kql6bvKW7pnuZS8L96OQ/sW+vvG7CD5z05O2Qs
         PA4mk6pWwiDnAWNkyjY4zVtSHh9m8fZmeAPLCC9lDnnXnPuHt0b6qQjXFdTbeMbRXDcQ
         2kcRlELYa1QWmKKcD1MIPJF1c3mlUpUCfp408NK6KME4PI5+kySzqyOY5iWGRkQ898Sh
         545w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785410891; x=1786015691;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rIKW4dcdCXvHAPAgaDV19js9bd3EoLyoIBY77YB7rA=;
        b=Llp8b6vTGnNF5H36NFyKKU+dk8CLh34Bkzi2cRJsxUy45ePD8XOTmCc9WCqir1GU7x
         hTIBFm1Q3Xr+aMRTJrwC+U5YuoTa6t/Uh8krQZ9GppEui+0WqPP0bm2HMIOP8/W6R4ex
         6t8bAMBNf/OMmusbbD/5KSpi3m414YKBH73BkWba7NGJhF00nSmzVPm4sDoGlaAApzqz
         YMWzX+Wn2ALbUOhEVWlwk6gTuz/o4B6asUAN6bduTAoMJJzk5/gVUchsBcPlguirf73c
         Xw32vOdUl78R3igkQy0bpWlnbjIp6KXKmqwfR9ELf/k1ubhJKc/qfqs3v+qkMKDQHoit
         Rdjw==
X-Gm-Message-State: AOJu0YwYv9aIW4QZHa23u9bqKJaUikbwQ2fnw/AFa7cQbSdzLALmJ2+N
	dRC3MJQDNtGM7tniPl4ISn3VgWNObEd9T2hRKFkXQOVv7fzcs0l63QhrkLGOKw==
X-Gm-Gg: AR+sD100TxXTYcmP58r5W8VsR71O4C9+0Y+fCbJZXB0vpPnxGE+Qsd7MTdzMBF3V5J+
	FTGQ5kukZgq5FXLaS4JEGOzwItV0fDsazPdfkYTY8ND4PdG8QlSccmijLWxRWl7Nf1hDogvVf/0
	v2YwVAZCGOOgGYvYQvvOU7tKMQZ2Fyh9mfVDl18c/gWFxtIFTT6fOZXWwCL9LR/JtrfmSaErUEI
	dv6gPQuKn64z3im2TY+m4sewhq9iSxGFS43tklDXgiRe4mF+6bcmSqahoz5B+hWZc8iVWK/9uKw
	c4yt04ps5KYoOzNZX3tPaTFRgHa1hgMqKAQ20ACeuvoZ+8IOnkTF0Yc5e2zEI1Nrt86+CjP6Udp
	YBFu6GJfcgo24GIRMBYSMHmQkuWkBiljFIiyXjyYEOV7M+ylsVuNxaOp7gKUP5NDRz/kb6UIDTF
	bWEeVvuUdtN3/bSlCMznqCWL35XSBbBEXW20pv6L9NYCQIVtKiuLOe6E395QFurVemFhGkftk2W
	5w=
X-Received: by 2002:a17:903:3888:b0:2ca:f8ef:33e4 with SMTP id d9443c01a7336-2d035be2696mr22305075ad.17.1785410891214;
        Thu, 30 Jul 2026 04:28:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.212.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a16088sm25762905ad.9.2026.07.30.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:28:10 -0700 (PDT)
Message-Id: <6c2909e609a6212b359b092d845c0a97ef0b4879.1785410884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com>
References: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
	<pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 11:28:04 +0000
Subject: [PATCH v5 2/2] mv: reject a destination whose leading path is missing
 or a symlink
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
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

When moving a file, if any leading directory in the destination path
is missing or is not a real directory, the problem is detected only
later when rename() is called. Furthermore, if a leading directory
component is a symbolic link, the issue is not detected at all.

Three cases reach rename(2) unchecked today:

  - A leading directory is missing: rename(2) fails with ENOENT,
    reported against the source (misleading), and "git mv -n" does not
    detect it since the dry run never reaches the syscall.

  - A leading component is a non-directory ("git mv x a/b" with 'a' a
    file): rename(2) fails with ENOTDIR, again only at the syscall.

  - A leading component is a symbolic link: "git mv" follows it. Since
    Git tracks symlinks, the destination is really occupied by a
    tracked object, and following it is wrong regardless of the link
    target. The move is done on disk at the resolved location while the
    index records the literal path, leaving the index describing a
    worktree that does not exist. A later "git add" can reconcile it,
    but "git mv" alone has already corrupted the state.

Detect all three in the checking phase. Reject a destination that goes
through a symlink with has_symlink_leading_path(), which uses lstat()
and never follows the link, so the refusal is independent of the
target. Then lstat() the leading directory: report "destination
directory does not exist" for ENOENT/ENOTDIR and "destination is not a
directory" for a non-directory. Other errors fall through to rename().
Guard the directory check with the same condition under which rename(2)
runs, so directory moves and sparse/out-of-cone destinations are not
flagged incorrectly.

This changes behavior: a move through a tracked symlink that previously
"succeeded" while corrupting the index is now refused. The other two
cases only change when the failure is diagnosed.

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
 builtin/mv.c  |  45 +++++++++++++++++++++-
 t/t7001-mv.sh | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 35e504484a..373d4aeba3 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -22,6 +22,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
+#include "symlinks.h"
 
 #include "setup.h"
 #include "strvec.h"
@@ -48,6 +49,12 @@ enum update_mode {
 	MOVE_VIA_PARENT_DIR = (1 << 5),
 };
 
+static int needs_worktree_rename(enum update_mode mode, enum update_mode dst_mode)
+{
+	return !(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+	       !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE));
+}
+
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
 
@@ -443,6 +450,41 @@ dir_check:
 			bad = _("destination directory does not exist");
 			goto act_on_entry;
 		}
+		if (has_symlink_leading_path(dst, strlen(dst))) {
+			bad = _("destination is beyond a symbolic link");
+			goto act_on_entry;
+		}
+
+		/*
+		 * If we are going to move SRC to DST on disk, DST's leading
+		 * directories must already exist.
+		 */
+		if (needs_worktree_rename(modes[i], dst_mode)) {
+			const char *slash_ = strrchr(dst, '/');
+
+			if (slash_) {
+				struct stat dir_st;
+				char *dst_dir = xstrdup(dst);
+				char *slash = &dst_dir[slash_ - dst];
+
+				*slash = '\0';
+				if (lstat(dst_dir, &dir_st) < 0) {
+					/*
+					 * other errors fall through to rename(),
+					 * which reports them
+					 */
+					if (errno == ENOENT || errno == ENOTDIR)
+						bad = _("destination directory does not exist");
+				} else if (!S_ISDIR(dir_st.st_mode)) {
+					bad = _("destination is not a directory");
+				}
+
+				free(dst_dir);
+			}
+
+			if (bad)
+				goto act_on_entry;
+		}
 
 		if (ignore_sparse &&
 		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
@@ -544,8 +586,7 @@ remove_entry:
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
-		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
+		if (needs_worktree_rename(mode, dst_mode) &&
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7cf4aa5ba1..719562a118 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -114,6 +114,108 @@ test_expect_success 'clean up' '
 	git reset --hard
 '
 
+test_expect_success 'moving file to directory without trailing slash' '
+	git reset --hard HEAD &&
+	rm -rf file.txt target && mkdir target &&
+	echo content > file.txt &&
+	git add file.txt &&
+	git mv file.txt target &&
+	test_path_is_file target/file.txt
+'
+
+test_expect_success 'moving file to a bare filename in the cwd' '
+	git reset --hard &&
+	rm -rf from dest.txt &&
+	mkdir from &&
+	echo content >from/file &&
+	git add from/file &&
+	git mv from/file dest.txt &&
+	test_path_is_file dest.txt
+'
+
+test_expect_success 'moving to a non-existent directory' '
+	git reset --hard &&
+	rm -rf from && mkdir from &&
+	echo content >from/file &&
+	git add from/file &&
+	test_must_fail git mv from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
+test_expect_success 'moving to a destination with a file as a leading path component' '
+	git reset --hard &&
+	rm -rf from && mkdir from &&
+	echo contents >from/file &&
+	echo blocker >not-dir &&
+	git add from/file &&
+	test_must_fail git mv from/file not-dir/file 2>actual &&
+	test_grep "destination is not a directory" actual
+'
+
+test_expect_success SYMLINKS 'moving to a destination beyond a symlink' '
+	git reset --hard &&
+	rm -rf from regular-dir link-to-dir &&
+	mkdir from regular-dir &&
+	echo contents >from/file &&
+	ln -s regular-dir link-to-dir &&
+	git add from/file &&
+	test_must_fail git mv from/file link-to-dir/file 2>actual &&
+	test_grep "destination is beyond a symbolic link" actual
+'
+
+test_expect_success SYMLINKS 'moving to a destination with a symlink as an intermediate component' '
+	git reset --hard &&
+	rm -rf from && mkdir -p from/real/inner &&
+	echo contents >from/file &&
+	ln -s real from/link &&
+	git add from/file from/link &&
+	test_must_fail git mv from/file from/link/inner/dst 2>actual &&
+	test_grep "destination is beyond a symbolic link" actual
+'
+
+test_expect_success SYMLINKS 'refuses to overwrite a symlink at the destination' '
+	git reset --hard &&
+	rm -rf from && mkdir from &&
+	echo contents >from/file &&
+	ln -s target from/link &&
+	git add from/file from/link &&
+	test_must_fail git mv from/file from/link 2>actual &&
+	test_grep "destination exists" actual
+'
+
+test_expect_success SYMLINKS 'mv through a symlinked leading path does not touch the index' '
+	git reset --hard &&
+	rm -rf from && mkdir from &&
+	echo contents >from/src &&
+	ln -s . from/link &&
+	git add from/src from/link &&
+	git commit -m "setup symlink case" &&
+	git ls-files --stage >expect.index &&
+	test_must_fail git mv from/src from/link/real/dst 2>actual &&
+	test_grep "destination is beyond a symbolic link" actual &&
+	git ls-files --stage >actual.index &&
+	test_cmp expect.index actual.index
+'
+
+test_expect_success SYMLINKS 'mv -f does not follow a symlinked leading path' '
+	git reset --hard &&
+	rm -rf from && mkdir from &&
+	echo contents >from/src &&
+	ln -s file from/link &&
+	git add from/src from/link &&
+	test_must_fail git mv -f from/src from/link/dst 2>actual &&
+	test_grep "destination is beyond a symbolic link" actual
+'
+
+test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
+	git reset --hard &&
+	rm -rf from && mkdir from &&
+	echo contents >from/file &&
+	git add from/file &&
+	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
 test_expect_success 'moving to existing untracked target with trailing slash' '
 	mkdir path1 &&
 	git mv path0/ path1/ &&
-- 
gitgitgadget
