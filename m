Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A8C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiCLDMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiCLDMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4F2923FD
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so6366893wmp.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddKKUtypkHQnlEezFWPhcKPgt68JnCsvp2du9u1RLkI=;
        b=TKxjHUiKDGHtQJ1EuVczmSnTZmWtmRiY19rVlf6wXwVNJ+JEg7k7HcMTT7wQfzswYC
         +/6z88pG0hJbMHuU8OjsXgX7gUjv31Iw7FsY2ZyWpVJmoGbryaPX8YadBmHo0Fbp3I/5
         jR02cGoQ51UWUxN5gMP1r0sWv9vpcr3vyGNxhbAkA1DqtMBwwpvp2ox/9UoVr6UGwBdZ
         r2Ax8kUom43HE5qgvoeiqxW32ocmZEhIB1bGic6uFPnMMl21oSEIs0wm1TCDe/mlkj9o
         XMZD+Y7xePda4Tm7T/ITkNOHzW2oITVwy2nSzmOdXfd5LYKLoq4D+Tzpg8gsRbxhfQ2T
         B6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddKKUtypkHQnlEezFWPhcKPgt68JnCsvp2du9u1RLkI=;
        b=D3fH51553VcxYh+aD7h6vonYFZ9RYMkkkTj5hd/Fo3h72owbiNTR+xS54Xaqar0kDS
         AW/PFmNdj+2GelReNfABodFc7GdDVxYp57yRzLcifyZByrmuUu9e25sRiekjgjabY0yz
         vZpWSwNemesxFPU2x+5uWVNQRrnl72NImRQQUW4TnpPOuFGWGdHzxYw4CwK9Sl7/8BJV
         Moj+ypO/NwenHp65yXVgmoeyEwl1jBobozvjXxyCiuwb2aHYFnI2epqyQ+Lq4wOeX2H1
         szr6aowsmEYo0K9xTEC0YYTQiQPKGkXT4jgd2SvvolJmeYvy3TzbjoE94Le7feR5tsl4
         k7QA==
X-Gm-Message-State: AOAM532cXc9GZDqEZ/NLYxuacRriCJ9b3k2iunEbfpRHndPq2g5QUojE
        1MJIExRrvSx+mxDW9WwsNLVNeT9/Jg0=
X-Google-Smtp-Source: ABdhPJwu3gIy6W7KY4op1gxSMejwpV/lYDrH/23NSyU/pTrVsH4lln7qvWvgKBxuNYv/iDJYGCAuMg==
X-Received: by 2002:a1c:f719:0:b0:381:ba:5247 with SMTP id v25-20020a1cf719000000b0038100ba5247mr9700656wmh.183.1647054683727;
        Fri, 11 Mar 2022 19:11:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm7857196wrw.49.2022.03.11.19.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:23 -0800 (PST)
Message-Id: <05dba7069c5e0c1aec1a7206f9cbea593d8d68cb.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:13 +0000
Subject: [PATCH v2 1/9] tests: stop assuming --no-cone is the default mode for
 sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add an explicit --no-cone to several sparse-checkout invocations in
preparation for changing the default to cone mode.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 15 ++++++++-------
 t/t3602-rm-sparse-checkout.sh      |  6 +++---
 t/t3705-add-sparse-checkout.sh     |  4 ++--
 t/t6428-merge-conflicts-sparse.sh  |  4 ++--
 t/t7002-mv-sparse-checkout.sh      |  2 +-
 t/t7012-skip-worktree-writing.sh   |  2 +-
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9a900310186..de1ec89007d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -72,7 +72,7 @@ test_expect_success 'git sparse-checkout list (populated)' '
 '
 
 test_expect_success 'git sparse-checkout init' '
-	git -C repo sparse-checkout init &&
+	git -C repo sparse-checkout init --no-cone &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -111,6 +111,7 @@ test_expect_success 'init with existing sparse-checkout' '
 
 test_expect_success 'clone --sparse' '
 	git clone --sparse "file://$(pwd)/repo" clone &&
+	git -C clone sparse-checkout reapply --no-cone &&
 	git -C clone sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
 	/*
@@ -124,7 +125,7 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 	git init bad-patterns &&
 	(
 		cd bad-patterns &&
-		git sparse-checkout init &&
+		git sparse-checkout init --no-cone &&
 		git sparse-checkout add dir &&
 		git config --worktree core.sparseCheckoutCone true &&
 		test_must_fail git sparse-checkout add dir 2>err &&
@@ -402,7 +403,7 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 		git sparse-checkout set nothing 2>err &&
 		test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
 		test_i18ngrep ! ".git/index.lock" err &&
-		git sparse-checkout set file
+		git sparse-checkout set --no-cone file
 	)
 '
 
@@ -424,7 +425,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	git clone repo dirty &&
 	echo dirty >dirty/folder1/a &&
 
-	git -C dirty sparse-checkout init 2>err &&
+	git -C dirty sparse-checkout init --no-cone 2>err &&
 	test_i18ngrep "warning.*The following paths are not up to date" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
@@ -435,7 +436,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	test_must_be_empty err &&
 
 	git -C dirty reset --hard &&
-	git -C dirty sparse-checkout init &&
+	git -C dirty sparse-checkout init --no-cone &&
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
 	test_path_is_missing dirty/folder1/a &&
 	git -C dirty sparse-checkout disable &&
@@ -451,7 +452,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	EOF
 	git -C unmerged update-index --index-info <input &&
 
-	git -C unmerged sparse-checkout init 2>err &&
+	git -C unmerged sparse-checkout init --no-cone 2>err &&
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 
 	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
@@ -462,7 +463,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 
 	git -C unmerged reset --hard &&
-	git -C unmerged sparse-checkout init &&
+	git -C unmerged sparse-checkout init --no-cone &&
 	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
 	git -C unmerged sparse-checkout disable
 '
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 034ec010910..08580fd3dcc 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -30,7 +30,7 @@ test_expect_success 'setup' "
 for opt in "" -f --dry-run
 do
 	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
-		git sparse-checkout set a &&
+		git sparse-checkout set --no-cone a &&
 		test_must_fail git rm $opt b 2>stderr &&
 		test_cmp b_error_and_hint stderr &&
 		git ls-files --error-unmatch b
@@ -118,7 +118,7 @@ test_expect_success 'can remove files from non-sparse dir' '
 	test_commit w/f &&
 	test_commit x/y/f &&
 
-	git sparse-checkout set w !/x y/ &&
+	git sparse-checkout set --no-cone w !/x y/ &&
 	git rm w/f.t x/y/f.t 2>stderr &&
 	test_must_be_empty stderr
 '
@@ -128,7 +128,7 @@ test_expect_success 'refuse to remove non-skip-worktree file from sparse dir' '
 	git sparse-checkout disable &&
 	mkdir -p x/y/z &&
 	test_commit x/y/z/f &&
-	git sparse-checkout set !/x y/ !x/y/z &&
+	git sparse-checkout set --no-cone !/x y/ !x/y/z &&
 
 	git update-index --no-skip-worktree x/y/z/f.t &&
 	test_must_fail git rm x/y/z/f.t 2>stderr &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 95609046c61..2bade9e804f 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -166,7 +166,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_when_finished git sparse-checkout disable &&
 	test_commit a &&
-	git sparse-checkout init &&
+	git sparse-checkout init --no-cone &&
 	git sparse-checkout set a &&
 	echo >>sparse_entry &&
 
@@ -208,7 +208,7 @@ test_expect_success 'add obeys advice.updateSparsePath' '
 '
 
 test_expect_success 'add allows sparse entries with --sparse' '
-	git sparse-checkout set a &&
+	git sparse-checkout set --no-cone a &&
 	echo modified >sparse_entry &&
 	test_must_fail git add sparse_entry &&
 	test_sparse_entry_unchanged &&
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 142c9aaabc5..064be1b629e 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -87,7 +87,7 @@ test_expect_success 'conflicting entries written to worktree even if sparse' '
 		test_path_is_file numerals &&
 
 		git sparse-checkout init &&
-		git sparse-checkout set README &&
+		git sparse-checkout set --no-cone README &&
 
 		test_path_is_file README &&
 		test_path_is_missing numerals &&
@@ -123,7 +123,7 @@ test_expect_success 'present-despite-SKIP_WORKTREE handled reasonably' '
 		test_path_is_file numerals &&
 
 		git sparse-checkout init &&
-		git sparse-checkout set README &&
+		git sparse-checkout set --no-cone README &&
 
 		test_path_is_file README &&
 		test_path_is_missing numerals &&
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1d3d2aca21c..f0f7cbfcdb7 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' "
 test_expect_success 'mv refuses to move sparse-to-sparse' '
 	test_when_finished rm -f e &&
 	git reset --hard &&
-	git sparse-checkout set a &&
+	git sparse-checkout set --no-cone a &&
 	touch b &&
 	test_must_fail git mv b e 2>stderr &&
 	cat sparse_error_header >expect &&
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index cb9f1a6981e..cd5c20fe51b 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -151,7 +151,7 @@ test_expect_success 'stash restore in sparse checkout' '
 
 		git stash push &&
 
-		git sparse-checkout set subdir &&
+		git sparse-checkout set --no-cone subdir &&
 
 		# Ensure after sparse-checkout we only have expected files
 		cat >expect <<-EOF &&
-- 
gitgitgadget

