Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FC3515CC
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097079; cv=none; b=Suom6A/d2X8rnPWwGRAy9WG3XwxF5PiKiDcU3iXgqyzJTDYYMww2Np//oaTkNFChykbExrpxfVnqJL1/lk+HbcDITd8LwgUrMgK0BB1JUoI/GgyJGYf+HaE60PAhxMaF5edgrOKL0zxuiBxAls2Kq8zdoPhmpgSs/04dNuqkvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097079; c=relaxed/simple;
	bh=p0BxTycnHL1y/9vWE9kvXY1iNn34OHbr8t6L2XySqok=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nd0VbOqH2+4r/JfVgAknd5sTvh1PQH3dQZqRVFESNQLqbPw1oF4YbbNOMQggsp2RK27WN5suYBT6ZU0OVLgBfOIgsBqSZ3I/m+alZrwaTLNh7y/oFspjNrfuPhX9Ignh0VhPCYR26OUllSh//jBWTaQ8nOBEVmCTNylzj/zal2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAE57psI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAE57psI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c05dcdf49so22423171cf.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097077; x=1785701877; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YmcMM6AlP/RQde1RfCFOqEMNg1tug0gqufr9R8Wo0m8=;
        b=JAE57psI8P9jx07Vxmd6hL1NQO1HClAgT6CSWARCmnO4auTmwEwK8hg0Wr2mJLwmQe
         k4baHHnsfkkaVJLMtW7vyRyaP7NlzHSw612th1RyNt/wG6z+F6+9V0CNyFU9ODNeZibL
         T8aPTYjPfGIWSinKsvPJv0ZlV1nEJuATnEX83wCyihAWTNl8eXksxMg0hHulBY1QF2oY
         6A6KEdV2u6bJqw80Omr5ZS5CqM+iVeByOGnn24PCkXNH/MtewMQnPx428zkD7UAgs8bd
         LDrWoP2LINlcyYjSvI+s0YzCTleXxkIDAso0DK+Rt4bmmUFuCByV+Hq7UzeYtPppekgF
         C5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097077; x=1785701877;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmcMM6AlP/RQde1RfCFOqEMNg1tug0gqufr9R8Wo0m8=;
        b=sDg672b5fB3ed3LpxzXDum3nCzSg36vTCZKSro2tk6g+DQiou8TsvgznEoMIkIYVna
         VY+fI1tJdq7nVWRmMAGAV/iT1/ShkmJ9uY13KhIHLfzDlYzp9mlHLgKsT8JDY1FsPFSt
         u3/40ynRP12Qs2/bK/xybNNYmGEs4EDF7UOnuStYdSoWKu/1y4TRC8cDdFhrEg3lppyr
         CAk1ej5OxFYE9DtcENKLzKLVJExhOx9CfKBD6znXf6gNhelnJQUadzKPp578AR/yolbU
         10UGORMqiiexKrsKialG45DNp6gcb4LyxN5FuOhhSdv9K4FxEyH4f4E9N6aglQOaJTrb
         1zrA==
X-Gm-Message-State: AOJu0Yyu2AuPSwGOgfAilzOUdCpNpCKiDu/JCDFltzSZKV0Itg3OPNCH
	dzp/AjHGsefR7LuVJ6hIlEre6C3ww2+5/J3ckA9gF2oIs7e0/NVhsT1bwrq7ww==
X-Gm-Gg: AR+sD124P5SdjGFvz8xkz5qcAJvCZH26GLTwG7/PFst0C616Df6MPIx+LDYdURl4BRW
	R7/HFkMAZd41T+t+KTZho/FPs9LJFVwCdS246k0+Z7e1AXSF8cAQ6oZECiOO+7+bWE8RZeLdmAJ
	TudpZt9P5LZ0OsRKFJIAcfgBv4Z8p+gOSwSDmVClTFWHGdzgzehZiQty7HkHxSNXXY0iwn1l35f
	5dRVyjbR3P0hOwFTTGHmRFjkRkHaVcE6GFUBAViiilif/HCgkNrL0AbTSws+m01eSZrabIGKeVt
	LlAVRpoO5vxlzdXZ3Wyht6gl3a4bHfYdb9LYVHvYm9Y9TVIRuXsrJ00fAA/I3N07m1sFJQ8Mfvl
	zzprJpb/XHnnYwA60Ik66a4Ig4kclMnK3zQCCCWryNjbN+8cNaqRtgw2UUHlFrE2Nkp+RRqvhck
	lYhif7
X-Received: by 2002:ac8:5f84:0:b0:527:2b06:2bc9 with SMTP id d75a77b69052e-529a888cb73mr61287661cf.83.1785097076807;
        Sun, 26 Jul 2026 13:17:56 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2989b24sm40205331cf.15.2026.07.26.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:17:55 -0700 (PDT)
Message-Id: <6b72efb4130d96947c7f90026042fa09a440d091.1785097071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
References: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
	<pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 20:17:51 +0000
Subject: [PATCH v4 2/2] mv: reject a destination whose leading path is missing
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

Moving a file into a destination whose leading directories are not all
present, real directories is only diagnosed later at rename(2), and for
a symlinked component is not diagnosed at all.

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
 builtin/mv.c  | 35 ++++++++++++++++++++++
 t/t7001-mv.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 35e504484a..535599e6be 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -22,6 +22,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
+#include "symlinks.h"
 
 #include "setup.h"
 #include "strvec.h"
@@ -443,6 +444,40 @@ dir_check:
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
+		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
+			char *dst_dir = xstrdup(dst);
+			char *slash = strrchr(dst_dir, '/');
+
+			if (slash) {
+				struct stat dir_st;
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
+			}
+			free(dst_dir);
+
+			if (bad)
+				goto act_on_entry;
+		}
 
 		if (ignore_sparse &&
 		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7cf4aa5ba1..7905d629d8 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -114,6 +114,89 @@ test_expect_success 'clean up' '
 	git reset --hard
 '
 
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
