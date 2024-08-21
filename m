Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345F1C93CC
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238164; cv=none; b=joKzy6ovqC/+MHqTn8G5jn1L3i5c3rHa24kmU6OL0PPGGkEzZICWyrEs6TbKmZh4yXEejoz9TfyY6e8neNyFLLFENJ+mASdbuzgNWQN0pYepOsNVb3UFiaGpmhAW0WNdyUV029OK9EAIC6cQTviNOLUSwwAARw34SSHhnGVtdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238164; c=relaxed/simple;
	bh=Aiox9OCgyAopwr2oiVRewxLoAiljGKZZWmS9XKONIYc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SOC6Ks/6jB/UoI60bC9ewRRBZ8j4w8778KBM3/aGf+anPdc01B42RnWMoIbTluFMMH88LlHiAwHqlhCG6qtyqNBRtKVgSIj+jyqHvuG7Lbv5eJ1HpcOo/IDFTEpAN9vOwZutQOXkSPu00zaCQ1EJROaOOrg7WdTRXHkNUB2GwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/eBeJyb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/eBeJyb"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so1083316a12.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238160; x=1724842960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Vt/foPze2A/lcxQ1vFGr98iUWGsAYRJd7doXha/ZA=;
        b=U/eBeJybZ2MC5PYEo1+vzznjdzN6HhHzfrHQjVySZDtM3Bvsp1dSCm1Uc+Sdzf/pp2
         yjPYMKVbsGO56XKOq2I9yLZelUo0rBzrK3eycyNDlvoTx5roFo10ATPnBpGM9DY+0UEU
         V10dRaGQESVCTuixS1hmsiclD0ag1S4Xih2skECak83A/eYhUh3QLpCYUUxhKPlQ8B1W
         gMcinoEhUCY39teUckarrk3Hvm3vTmTbPnFvOmaTMLT1PfTmZ1GLtYJm9nTkOSKbbFrQ
         fUjnVrrTaFrkQq0+Uiq3XG3Ym56w3ztK6hvbGGkTKCMI/T6EY/tUjrSt99UyrytJn8FS
         0YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238160; x=1724842960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8Vt/foPze2A/lcxQ1vFGr98iUWGsAYRJd7doXha/ZA=;
        b=R1i9JVyxjx01h10nt2syIhlFSLKs2OEelO6ZSsx+5Vv8ABEXn4VQk5O4uYk2yKr0u3
         wLInVMP4Tr3zaA0Tcmr97VlxvC4jlu0eeLhwnMBH//yyK6iehc261m4jKhxDkc6NHOVr
         jCUPkwOPXAY75wfOxY6HcCOLWwkLpabRy0zMan7gXYCiZDEfim5dErwTl2cdhEB0EySo
         CXsI04okzBjuY+sh7LnYWoYH74R9LKgUtSR9cf2+o1m3QnqhajOPBV6CPIfJoLObKBNl
         PJIyUlOXetx+JPycuji+oWN5ePVx48azN43Jg5NaAJiIubl58bdX3kPX/Nja622vYXUV
         wOEg==
X-Gm-Message-State: AOJu0Yzt9wKR6Fkql0OpyMCYtYGqxewgO3zrH/ET7Lp/ScSYZO1ydYkw
	Oc90o/XiSCW2T82acWSLMhadGz1l1f3/SDT45sqrUUcORnnmE3LU5fBovg==
X-Google-Smtp-Source: AGHT+IFudPyamvwa84d7qTT5UwP7NxPiyK31K6VqQCKZ2aMlGw+e/U95y4jEKqyq4btV9uJXUlsnVg==
X-Received: by 2002:a05:6402:2790:b0:585:5697:b882 with SMTP id 4fb4d7f45d1cf-5bf1e6bf988mr1787170a12.3.1724238159433;
        Wed, 21 Aug 2024 04:02:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f05dsm7921311a12.78.2024.08.21.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:39 -0700 (PDT)
Message-Id: <ce725bb8991e8f7e61e85e30967f147a6c00a823.1724238153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:30 +0000
Subject: [PATCH 5/7] t7000: add GIT_ADVICE=1 to advice tests
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
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

Several tests validate the exact output of stderr, including when the stderr
file should be empty. In advance of modifying the advice system to only
output when stderr is a terminal, force the advice system to output in these
cases.

In addition, two more edits were made while in the neighborhood:

 1. In t7002, a redirected stderr was ignored and is now checked as empty.

 2. In t7060 and 7500, the output of "git status" has paranthetical messages
    that appear only when advice is enabled, even though it is sent to stdout.

 3. In t7400, a command was checked for failure with "!" but is now checked
    via test_must_fail.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t7002-mv-sparse-checkout.sh   | 85 +++++++++++++++++----------------
 t/t7004-tag.sh                  |  2 +-
 t/t7060-wtstatus.sh             | 11 +++--
 t/t7201-co.sh                   |  2 +-
 t/t7400-submodule-basic.sh      |  2 +-
 t/t7402-submodule-rebase.sh     |  3 +-
 t/t7406-submodule-update.sh     |  2 +-
 t/t7512-status-help.sh          |  4 +-
 t/t7520-ignored-hook-warning.sh |  8 ++--
 9 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 57969ce805a..3b194bfa2f7 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -55,13 +55,13 @@ test_expect_success 'mv refuses to move sparse-to-sparse' '
 	git reset --hard &&
 	git sparse-checkout set --no-cone a &&
 	touch b &&
-	test_must_fail git mv b e 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv b e 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo b >>expect &&
 	echo e >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
-	git mv --sparse b e 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse b e 2>stderr &&
 	test_must_be_empty stderr
 '
 
@@ -72,7 +72,7 @@ test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
 
 	# tracked-to-untracked
 	touch b &&
-	git mv -k b e 2>stderr &&
+	GIT_ADVICE=1 git mv -k b e 2>stderr &&
 	test_path_exists b &&
 	test_path_is_missing e &&
 	cat sparse_error_header >expect &&
@@ -81,7 +81,7 @@ test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse b e 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse b e 2>stderr &&
 	test_must_be_empty stderr &&
 	test_path_is_missing b &&
 	test_path_exists e &&
@@ -89,7 +89,7 @@ test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
 	# tracked-to-tracked
 	git reset --hard &&
 	touch b &&
-	git mv -k b c 2>stderr &&
+	GIT_ADVICE=1 git mv -k b c 2>stderr &&
 	test_path_exists b &&
 	test_path_is_missing c &&
 	cat sparse_error_header >expect &&
@@ -98,7 +98,7 @@ test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse b c 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse b c 2>stderr &&
 	test_must_be_empty stderr &&
 	test_path_is_missing b &&
 	test_path_exists c
@@ -110,14 +110,14 @@ test_expect_success 'mv refuses to move non-sparse-to-sparse' '
 	git sparse-checkout set a &&
 
 	# tracked-to-untracked
-	test_must_fail git mv a e 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv a e 2>stderr &&
 	test_path_exists a &&
 	test_path_is_missing e &&
 	cat sparse_error_header >expect &&
 	echo e >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
-	git mv --sparse a e 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse a e 2>stderr &&
 	test_must_be_empty stderr &&
 	test_path_is_missing a &&
 	test_path_exists e &&
@@ -125,14 +125,14 @@ test_expect_success 'mv refuses to move non-sparse-to-sparse' '
 	# tracked-to-tracked
 	rm e &&
 	git reset --hard &&
-	test_must_fail git mv a c 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv a c 2>stderr &&
 	test_path_exists a &&
 	test_path_is_missing c &&
 	cat sparse_error_header >expect &&
 	echo c >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
-	git mv --sparse a c 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse a c 2>stderr &&
 	test_must_be_empty stderr &&
 	test_path_is_missing a &&
 	test_path_exists c
@@ -145,12 +145,12 @@ test_expect_success 'mv refuses to move sparse-to-non-sparse' '
 
 	# tracked-to-untracked
 	touch b &&
-	test_must_fail git mv b e 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv b e 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo b >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
-	git mv --sparse b e 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse b e 2>stderr &&
 	test_must_be_empty stderr
 '
 
@@ -164,7 +164,7 @@ test_expect_success 'recursive mv refuses to move (possible) sparse' '
 	mkdir sub/dir2 &&
 	touch sub/d sub/dir2/e &&
 
-	test_must_fail git mv sub sub2 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub sub2 2>stderr &&
 	cat sparse_error_header >expect &&
 	cat >>expect <<-\EOF &&
 	sub/d
@@ -174,7 +174,7 @@ test_expect_success 'recursive mv refuses to move (possible) sparse' '
 	EOF
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
-	git mv --sparse sub sub2 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse sub sub2 2>stderr &&
 	test_must_be_empty stderr &&
 	git commit -m "moved sub to sub2" &&
 	git rev-parse HEAD~1:sub >expect &&
@@ -193,7 +193,7 @@ test_expect_success 'recursive mv refuses to move sparse' '
 	mkdir sub/dir2 &&
 	touch sub/dir2/e &&
 
-	test_must_fail git mv sub sub2 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub sub2 2>stderr &&
 	cat sparse_error_header >expect &&
 	cat >>expect <<-\EOF &&
 	sub/dir2/e
@@ -201,7 +201,7 @@ test_expect_success 'recursive mv refuses to move sparse' '
 	EOF
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
-	git mv --sparse sub sub2 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse sub sub2 2>stderr &&
 	test_must_be_empty stderr &&
 	git commit -m "moved sub to sub2" &&
 	git rev-parse HEAD~1:sub >expect &&
@@ -216,8 +216,9 @@ test_expect_success 'can move files to non-sparse dir' '
 	git sparse-checkout set a b c w !/x y/ &&
 	mkdir -p w x/y &&
 
-	git mv a w/new-a 2>stderr &&
-	git mv b x/y/new-b 2>stderr &&
+	GIT_ADVICE=1 git mv a w/new-a 2>stderr &&
+	test_must_be_empty stderr &&
+	GIT_ADVICE=1 git mv b x/y/new-b 2>stderr &&
 	test_must_be_empty stderr
 '
 
@@ -228,7 +229,7 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	git sparse-checkout set a !/x y/ !x/y/z &&
 	mkdir -p x/y/z &&
 
-	test_must_fail git mv a x/y/z/new-a 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv a x/y/z/new-a 2>stderr &&
 	echo x/y/z/new-a | cat sparse_error_header - sparse_hint >expect &&
 	test_cmp expect stderr
 '
@@ -237,7 +238,7 @@ test_expect_success 'refuse to move out-of-cone directory without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-	test_must_fail git mv folder1 sub 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv folder1 sub 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo folder1/file1 >>expect &&
 	cat sparse_hint >>expect &&
@@ -248,7 +249,7 @@ test_expect_success 'can move out-of-cone directory with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-	git mv --sparse folder1 sub 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse folder1 sub 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_dir sub/folder1 &&
@@ -259,7 +260,7 @@ test_expect_success 'refuse to move out-of-cone file without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-	test_must_fail git mv folder1/file1 sub 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv folder1/file1 sub 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo folder1/file1 >>expect &&
 	cat sparse_hint >>expect &&
@@ -270,7 +271,7 @@ test_expect_success 'can move out-of-cone file with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-	git mv --sparse folder1/file1 sub 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse folder1/file1 sub 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_file sub/file1
@@ -284,7 +285,7 @@ test_expect_success 'refuse to move sparse file to existing destination' '
 	git add folder1 sub/file1 &&
 	git sparse-checkout set --cone sub &&
 
-	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
 	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
 	test_cmp expect stderr
 '
@@ -298,7 +299,7 @@ test_expect_success 'move sparse file to existing destination with --force and -
 	git add folder1 sub/file1 &&
 	git sparse-checkout set --cone sub &&
 
-	git mv --sparse --force folder1/file1 sub 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse --force folder1/file1 sub 2>stderr &&
 	test_must_be_empty stderr &&
 	echo "overwrite" >expect &&
 	test_cmp expect sub/file1
@@ -308,13 +309,13 @@ test_expect_success 'move clean path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-	test_must_fail git mv sub/d folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/d folder1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/d" >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse sub/d folder1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse sub/d folder1 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_missing sub/d &&
@@ -330,18 +331,18 @@ test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
 	echo "sub/file1 overwrite" >sub/file1 &&
 	git add sub/file1 &&
 
-	test_must_fail git mv sub/file1 folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/file1 folder1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/file1" >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	test_must_fail git mv --sparse sub/file1 folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv --sparse sub/file1 folder1 2>stderr &&
 	echo "fatal: destination exists in the index, source=sub/file1, destination=folder1/file1" \
 	>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse -f sub/file1 folder1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse -f sub/file1 folder1 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_missing sub/file1 &&
@@ -366,18 +367,18 @@ test_expect_success 'move clean path from in-cone to out-of-cone file overwrite'
 	echo "sub/file1 overwrite" >sub/file1 &&
 	git add sub/file1 &&
 
-	test_must_fail git mv sub/file1 folder1/file1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/file1 folder1/file1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/file1" >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	test_must_fail git mv --sparse sub/file1 folder1/file1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv --sparse sub/file1 folder1/file1 2>stderr &&
 	echo "fatal: destination exists in the index, source=sub/file1, destination=folder1/file1" \
 	>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse -f sub/file1 folder1/file1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse -f sub/file1 folder1/file1 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_missing sub/file1 &&
@@ -403,19 +404,19 @@ test_expect_success 'move directory with one of the files overwrite' '
 	echo test >sub/dir/file1 &&
 	git add sub/dir/file1 &&
 
-	test_must_fail git mv sub/dir folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/dir folder1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/dir/e" >>expect &&
 	echo "folder1/dir/file1" >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	test_must_fail git mv --sparse sub/dir folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv --sparse sub/dir folder1 2>stderr &&
 	echo "fatal: destination exists in the index, source=sub/dir/file1, destination=folder1/dir/file1" \
 	>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse -f sub/dir folder1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse -f sub/dir folder1 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_missing sub/dir/file1 &&
@@ -438,13 +439,13 @@ test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	setup_sparse_checkout &&
 	echo "modified" >>sub/d &&
 
-	test_must_fail git mv sub/d folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/d folder1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/d" >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse sub/d folder1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse sub/d folder1 2>stderr &&
 	cat dirty_error_header >expect &&
 	echo "folder1/d" >>expect &&
 	cat dirty_hint >>expect &&
@@ -462,13 +463,13 @@ test_expect_success 'move dir from in-cone to out-of-cone' '
 	setup_sparse_checkout &&
 	mkdir sub/dir/deep &&
 
-	test_must_fail git mv sub/dir folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/dir folder1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/dir/e" >>expect &&
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse sub/dir folder1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse sub/dir folder1 2>stderr &&
 	test_must_be_empty stderr &&
 
 	test_path_is_missing sub/dir &&
@@ -487,7 +488,7 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	echo "modified" >>sub/dir/e2 &&
 	echo "modified" >>sub/dir/e3 &&
 
-	test_must_fail git mv sub/dir folder1 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git mv sub/dir folder1 2>stderr &&
 	cat sparse_error_header >expect &&
 	echo "folder1/dir/e" >>expect &&
 	echo "folder1/dir/e2" >>expect &&
@@ -495,7 +496,7 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	cat sparse_hint >>expect &&
 	test_cmp expect stderr &&
 
-	git mv --sparse sub/dir folder1 2>stderr &&
+	GIT_ADVICE=1 git mv --sparse sub/dir folder1 2>stderr &&
 	cat dirty_error_header >expect &&
 	echo "folder1/dir/e2" >>expect &&
 	echo "folder1/dir/e3" >>expect &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f46..bc216d012cb 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1852,7 +1852,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: 	git tag -f nested annotated-v4.0^{}
 	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
-	git tag -m nested nested annotated-v4.0 2>actual &&
+	GIT_ADVICE=1 git tag -m nested nested annotated-v4.0 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index aaeb4a53344..8dfb6885156 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -56,9 +56,10 @@ EOF
 		git rm foo &&
 		git commit -m delete &&
 		test_must_fail git merge main &&
-		test_must_fail git commit --dry-run >../actual &&
+		test_env GIT_ADVICE=1 test_must_fail \
+			git commit --dry-run >../actual &&
 		test_cmp ../expect ../actual &&
-		git status >../actual &&
+		test_env GIT_ADVICE=1 git status >../actual &&
 		test_cmp ../expect ../actual
 	)
 '
@@ -151,7 +152,7 @@ Unmerged paths:
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-	git status --untracked-files=no >actual &&
+	GIT_ADVICE=1 git status --untracked-files=no >actual &&
 	test_cmp expected actual
 '
 
@@ -185,7 +186,7 @@ Unmerged paths:
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
-	git status --untracked-files=no >actual &&
+	GIT_ADVICE=1 git status --untracked-files=no >actual &&
 	test_cmp expected actual
 '
 
@@ -210,7 +211,7 @@ Unmerged paths:
 
 Untracked files not listed (use -u option to show untracked files)
 EOF
-	git status --untracked-files=no >actual &&
+	GIT_ADVICE=1 git status --untracked-files=no >actual &&
 	test_cmp expected actual &&
 	git reset --hard &&
 	git checkout main
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 2d984eb4c6a..9ee2374e3d2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -249,7 +249,7 @@ test_expect_success 'checkout to detach HEAD' '
 	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer &&
 	git clean -f &&
-	git checkout renamer^ 2>messages &&
+	GIT_ADVICE=1 git checkout renamer^ 2>messages &&
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 098d8833b65..95e4bacd19e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -219,7 +219,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		echo "*" > .gitignore &&
 		git add --force .gitignore &&
 		git commit -m"Ignore everything" &&
-		! git submodule add "$submodurl" submod >actual 2>&1 &&
+		test_env GIT_ADVICE=1 test_must_fail git submodule add "$submodurl" submod >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index aa2fdc31d1a..b155bd6e1c3 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -116,7 +116,8 @@ test_expect_success 'rebasing submodule that should conflict' '
 	test_tick &&
 	git commit -m fourth &&
 
-	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 2>actual_output &&
+	test_env GIT_ADVICE=1 test_must_fail git rebase \
+		--onto HEAD^^ HEAD^ HEAD^0 2>actual_output &&
 	git ls-files -s submodule >actual &&
 	(
 		cd submodule &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 297c6c3b5cc..560eeea9c99 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -206,7 +206,7 @@ test_expect_success 'submodule update should fail due to local changes' '
 	 (cd submodule &&
 	  compare_head
 	 ) &&
-	 test_must_fail git submodule update submodule 2>../actual.raw
+	 test_env GIT_ADVICE=1 test_must_fail git submodule update submodule 2>../actual.raw
 	) &&
 	sed "s/^> //" >expect <<-\EOF &&
 	> error: Your local changes to the following files would be overwritten by checkout:
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index cdd5f2c6979..de277257d50 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -847,7 +847,7 @@ EOF
 test_expect_success 'status shows cherry-pick with invalid oid' '
 	mkdir .git/sequencer &&
 	test_write_lines "pick invalid-oid" >.git/sequencer/todo &&
-	git status --untracked-files=no >actual 2>err &&
+	GIT_ADVICE=1 git status --untracked-files=no >actual 2>err &&
 	git cherry-pick --quit &&
 	test_must_be_empty err &&
 	test_cmp expected actual
@@ -856,7 +856,7 @@ test_expect_success 'status shows cherry-pick with invalid oid' '
 test_expect_success 'status does not show error if .git/sequencer is a file' '
 	test_when_finished "rm .git/sequencer" &&
 	test_write_lines hello >.git/sequencer &&
-	git status --untracked-files=no 2>err &&
+	GIT_ADVICE=1 git status --untracked-files=no 2>err &&
 	test_must_be_empty err
 '
 
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index 3b63c34a309..21e088894c3 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -12,27 +12,27 @@ test_expect_success setup '
 '
 
 test_expect_success 'no warning if hook is not ignored' '
-	git commit --allow-empty -m "more" 2>message &&
+	GIT_ADVICE=1 git commit --allow-empty -m "more" 2>message &&
 	test_grep ! -e "hook was ignored" message
 '
 
 test_expect_success POSIXPERM 'warning if hook is ignored' '
 	test_hook --disable pre-commit &&
-	git commit --allow-empty -m "even more" 2>message &&
+	GIT_ADVICE=1 git commit --allow-empty -m "even more" 2>message &&
 	test_grep -e "hook was ignored" message
 '
 
 test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to false' '
 	test_config advice.ignoredHook false &&
 	test_hook --disable pre-commit &&
-	git commit --allow-empty -m "even more" 2>message &&
+	GIT_ADVICE=1 git commit --allow-empty -m "even more" 2>message &&
 	test_grep ! -e "hook was ignored" message
 '
 
 test_expect_success 'no warning if unset advice.ignoredHook and hook removed' '
 	test_hook --remove pre-commit &&
 	test_unconfig advice.ignoredHook &&
-	git commit --allow-empty -m "even more" 2>message &&
+	GIT_ADVICE=1 git commit --allow-empty -m "even more" 2>message &&
 	test_grep ! -e "hook was ignored" message
 '
 
-- 
gitgitgadget

