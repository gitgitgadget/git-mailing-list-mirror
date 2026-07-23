Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81B330B3F
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842848; cv=none; b=ZkJ7DSVMCQywjdtk343bD/pUvX8jdlbdhv37iINq6qh1IlAguOb3XAlb6BksAyokOlijFv18NtsbSvXEO3RBPx6DnAOk3dx1yt/k0RuHqdUAOr4BYW18c5dGbCzVgeBTpkWuvj/Y30F8z5XuBnTEeJs+tNCa4SybUFoWy0lqvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842848; c=relaxed/simple;
	bh=xvHE8iMYBsu5QTYriOJjeIr8elvk+GJraN9xFnzsjps=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TGfrXCEPkBHZgwz/wXGRpZ8DSt7q+cnmf3VL+hUp2CO8OZlXORkbIwPYkharIQHyrmgyHPWa6mHELAKu0IcFLRKQ5T5tmTXNMqfKvI1m9ijDzdsBNaO93LYqN7D/lfqu23GjnQEW9CmpswUCLLg8hBZCQaaTfjpxpSCeYEqUuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I93YWss/; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I93YWss/"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a31c05e092so488445eaf.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842839; x=1785447639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OJAJ0q4+UU+5I7arnubhVxip3J8tC4Qklaelp8L4VAM=;
        b=I93YWss/VAW7CztampY1MqL4CRY0EzNsnPtrTSN2b7grI6KuX1oLxHicEqOT+mNbRx
         +RGZJbT4TcciVc5IHxhKl+qCkGwT6PGdE61tlLlCdkDp0pvOtZ1rk/w/A31um0rwn+Ep
         na1/rJNT9b5NxzhZ5/UJEA6+uKzhbd1xVFW7CJTo/0WwtqAo/kpG4apcTgFC9Cnze5Ob
         7wSF9Z7MqJJiltPP0KqOXYDEK6UnNvAvR2rifvlKarK37XNy69ILRHNqvqJRN/TsvypE
         qtVg4yvlj5cyejT7EAX8mkyPHQKdORifEB3sujPcWwsa9lY3qyijgB59jh5ZVNABSk9Z
         UcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842839; x=1785447639;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJAJ0q4+UU+5I7arnubhVxip3J8tC4Qklaelp8L4VAM=;
        b=XM47hGTHM7mcHd184RQgDHLzwzgXw5LWM5majiM0t8YyRTsMxv4qSIt+2lM/O/fjCk
         unoj5UmanBV/uYdqqbNCPZr1s5LuWnyyGicqgYyWjkYt/LXEB/T6SybfE25qwkQ5FsqV
         VdVKiZ3uh0PE5Mj8C6faQ/1p11+aw4FMINQNrZGXpFr3/Kp6CrnJ9NtSSbgQVE45MXc4
         smIDQjNT0RowiIGNWRTSrl/XhyxwMEA66wLDmIJl4cBCqEDUHtqhLRm3kZpCIZHE5+tL
         MrH/zUya6rhM/iIqnAZSDHliTmfAZJYB98JF8QLMwBDa5kLEXx8WH9KnYhOWBC6tMS+7
         EASw==
X-Gm-Message-State: AOJu0YwTdKYJU2RQmnzCoj/+d+iOk1u9Szcb3hDsMJRTV0I/GcMVGX/x
	qpYMPXuIoS+1l3q+5VaI0Cc0K4/pWfZ59jF7nswC4OjXmVb8E0yt1dHTdUStAg==
X-Gm-Gg: AR+sD12I8YeirzpjTZuofjU1RQB+T0fglLw7HG5pnzjnLLRpCT6/+GemF6BGdXou2Yl
	IWM4wdPMQ/tDclE9LORyjt7EgTNsjE5SfLsaQmit6gxUvrlOsK+727pJ93mYHpThsitTLTf5egU
	fiMa4/tmLtltB/JtyxtxgAuj1mmDJsZsbqi6L8laVO2Wo4jShcFdHRSot9b7e/8WI5MzDQe21K7
	N6LU34RDPEhl9NshXDRrZBQ2UaMOHOARQTwcbu6UgXNVHEeBCpZdcOAreHpOuI88LHEwt+s7AeY
	QYRuRqWf+N4rCBnu+POUEVUR9g4fivj/wKGy4vVcMog396YqNPWCGp+ezdQ8ZRJNzCJ281vhuc1
	3odxmWAdVCElslGyt9PtVRY4vs8ATgGjuM/mPMMh3dp4jXcWjM6XTWOB6+k7eTRnK/LFa1sMriL
	tVkfme
X-Received: by 2002:a05:6820:a094:b0:6aa:dadb:454f with SMTP id 006d021491bc7-6aadadb467emr1087988eaf.7.1784842838871;
        Thu, 23 Jul 2026 14:40:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.139.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm5468188fac.10.2026.07.23.14.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:40:37 -0700 (PDT)
Message-Id: <5ac15873623a3f519b01aa7419c579a310be164b.1784842831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
References: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:40:31 +0000
Subject: [PATCH v3 2/2] mv: check for missing destination directory before
 renaming
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
    Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

Moving a file into a directory that does not exist fails at rename(2)
with ENOENT. The checking phase already rejects a missing destination
directory when the destination ends in a slash, but a destination that
names a file inside a non-existent directory is not caught and only
fails later at the syscall. The same is true when a leading path
component exists but is not a directory: rename(2) fails with ENOTDIR,
again only at the syscall. As a consequence "git mv -n" does not detect
either problem: the dry run never reaches rename(2) and reports a move
that would not actually succeed.

Detect this during the checking phase. For entries that will be renamed
on disk, stat the destination's leading directory and fail with a
suitable message if it is missing or is not a directory. stat() is used
rather than lstat() so that the check follows symlinks the same way
rename(2) does: a symlink to a directory is accepted, while a symlink to
a file is rejected. A missing directory or a non-directory path
component (ENOENT or ENOTDIR) reuses the existing "destination directory
does not exist" message; a leading component that resolves to a
non-directory reports "destination is not a directory". Other stat()
errors fall through to rename(2), which reports them as before.

Add tests covering the missing directory, a path component that is a
file, a symlink to a file, a symlink to a directory (which must still
succeed), and dry-run detection.

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
 builtin/mv.c  | 24 ++++++++++++++++++++++++
 t/t7001-mv.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 35e504484a..08e27484f2 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -444,6 +444,30 @@ dir_check:
 			goto act_on_entry;
 		}
 
+		/*
+		 * If we are going to move SRC to DST on disk, DST's leading
+		 * directories must already exist.
+		 */
+		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
+			char *dst_dir = xstrdup(dst);
+			char *slash = strrchr(dst_dir, '/');
+
+			if (slash) {
+				struct stat dir_st;
+				*slash = '\0';
+				if (stat(dst_dir, &dir_st) < 0) {
+					/* other errors fall through to rename(), which reports them */
+					if (errno == ENOENT || errno == ENOTDIR)
+						bad = _("destination directory does not exist");
+				} else if (!S_ISDIR(dir_st.st_mode))
+					bad = _("destination is not a directory");
+			}
+			free(dst_dir);
+			if (bad)
+				goto act_on_entry;
+		}
+
 		if (ignore_sparse &&
 		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
 		    index_entry_exists(the_repository->index, dst, strlen(dst))) {
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7cf4aa5ba1..c878fb92a8 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -114,6 +114,55 @@ test_expect_success 'clean up' '
 	git reset --hard
 '
 
+test_expect_success 'moving to a non-existent path component in the destination' '
+	git reset --hard &&
+	mkdir -p from &&
+	echo content >from/file &&
+	git add from/file &&
+	test_must_fail git mv from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
+test_expect_success 'moving to a destination with a file as a path component' '
+	git reset --hard &&
+	mkdir -p from &&
+	echo contents >from/file &&
+	echo blocker >not-dir &&
+	git add from/file &&
+	test_must_fail git mv from/file not-dir/file 2>actual &&
+	test_grep "destination is not a directory" actual
+'
+
+test_expect_success SYMLINKS 'moving to a destination with a symlink to a file as a path component' '
+	git reset --hard &&
+	mkdir -p from &&
+	echo contents >from/file &&
+	echo target >regular &&
+	ln -s regular link-to-file &&
+	git add from/file &&
+	test_must_fail git mv from/file link-to-file/file 2>actual &&
+	test_grep "not a directory" actual
+'
+
+test_expect_success SYMLINKS 'moving to a destination with a symlink to a directory' '
+	git reset --hard &&
+	mkdir -p from realdir &&
+	echo contents >from/file &&
+	ln -s realdir link-to-dir &&
+	git add from/file &&
+	git mv from/file link-to-dir/file &&
+	test_path_is_file realdir/file
+'
+
+test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
+	git reset --hard &&
+	mkdir -p from &&
+	echo content >from/file &&
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
