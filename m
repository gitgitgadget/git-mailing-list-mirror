Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338CC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443378AbiDVCfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443375AbiDVCfX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3799B4B421
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c10so9081058wrb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddKKUtypkHQnlEezFWPhcKPgt68JnCsvp2du9u1RLkI=;
        b=NPkwqKBkeLqhATuavayCJ/gZb9u7H/7XTohBS1OBl2AtQJWnhN9ftSm9orX9xz12dq
         4sodibLNtpP28KRb5TWciMypApzjNhytf61vj5cN2QFpFE/YLjXWiN5TZKnIULZQECQg
         REDzkmpc3EEdRQPfRDUwenY0DAOYeWU/tZc2QDPv3smSjTA+BQBQJDD6eG/1psY5QQ3b
         YXzaeF7WCD0omfq0H7+Et3fGd30xMWWFAVDBfTyWJH2MJb5sOm9WHblwuKsPnTDljUrV
         JQcXWMzLSEfAc63RMfGoJXw+xfMKj3Z4bUO7jDPBnVAkNclzpzgFFJEKiZ9koexB3Mcu
         tqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddKKUtypkHQnlEezFWPhcKPgt68JnCsvp2du9u1RLkI=;
        b=1FTnFuNX7s2ugPDk+vLcVC7KdY+kh3HVmrqCnErpyXi8yyY9q1qgTgF8OnshFYc2As
         DmIlngHwPIH5v1JwmhiVbRK9ltj6p0PpP5FeU2WEez0bUQ0CD+Kz0mjjQEvlvN4ONP0P
         3tTNKCF4MRdJ3Mv4tu2Wwj2rFnp1U+VVzSxu0MfDydmG1Oe3tLwSnvwcvZyRpwuaRQAp
         ZJPGXOUePgAaRSJNz1qdEqHxqNEluHPCjMgNOeT3Y9I38nyR/xKHHrSmixRiRCMX4rO7
         1yoGqPBe/opcXAoy7pd8wxsxiKiJWjYkt4ygrzzy+OcVOJ/aC6g0s6fkmX7a6XXw4xGe
         AzGA==
X-Gm-Message-State: AOAM5326rEjxZUvstbmALfFrJVkIGu8+RPkBkjEDB4hi/ngONahsH8Oi
        OY1nbc9lxATziskdh7K7S/kR1fQriz0=
X-Google-Smtp-Source: ABdhPJzYFTtSqk82lQwYAAcMt75lumgCjN8wJuB6cu6/bov8jMKq1B+GR7p3CXprjY75fD34nUQKOA==
X-Received: by 2002:adf:f98e:0:b0:207:9eed:60d8 with SMTP id f14-20020adff98e000000b002079eed60d8mr1773431wrr.566.1650594749391;
        Thu, 21 Apr 2022 19:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000008200b00207a6f32833sm599442wrx.117.2022.04.21.19.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:28 -0700 (PDT)
Message-Id: <05dba7069c5e0c1aec1a7206f9cbea593d8d68cb.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:18 +0000
Subject: [PATCH v3 1/9] tests: stop assuming --no-cone is the default mode for
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

