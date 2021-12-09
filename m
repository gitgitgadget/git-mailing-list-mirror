Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E5C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhLIFMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhLIFMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD0C061A72
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso5657111wms.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dUqcJxoIyRNhT/d40bbWgVezeRZEeZaEZxI7e2Onbj0=;
        b=VPqFp1r+Sl5X+56EPi3XXOmWT+fWXQRcdVcyLX6w9RpG0K14QVwXc01xSSbmGBc7G+
         tohLIBYumMZYHu6ZzgUgcr2+jkqdhiNFS/LBbhmtT6GaGOMDiOAsr6NtycpNYGYmp/u2
         YHmFOq5twF/l41bWrWiPQZRI1NDY4XHM1noW7pGA4WsGxJz/EFxfxfRyHrewuq0K1U+J
         fEhl/b3GRgXnd/rufcd0EPl+xjTv14oAhazhjYR25hJ6m2dMkK/SJr2CX967As7cEUYx
         Aj/A6jPP4niP9Fj61BHymkO44EZQ8dVIgOHjma4uw3KINxyCZ6YUh4aZ+dfF9MYm0Edv
         4c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dUqcJxoIyRNhT/d40bbWgVezeRZEeZaEZxI7e2Onbj0=;
        b=DSrnmNSMliV0fX7DMRA1xOZUlwPEoruGRV0xPSWgVFJuznIZsfDpJ7exIulkCEQtzi
         62IW+mInP8rxv4CfGlNWE9Nv9Qmji6XCCL3ZVof11cF/A8SBUnOWVkMaPhlKqkqRCsOi
         8xvNJ5WpgLgJU+RueSweRzeX/MbZAQNL0yhXlOVxHLVPU13qyDKhF50CFx4QSJcl4cA1
         5rVqgkERAVz7pczo2XEqfmgGuDEbxUQsRuROzCr9bQQk9dFUrrnCqdGMS3OnvjQCs8+x
         BCNbxZGTlLkD4TcM090AA8kxMFwYz6Rn73J/COOXk48S8Lj9acPrZ1/Gk0MW/axEGsGN
         h9Qw==
X-Gm-Message-State: AOAM5317hJ4AS7tFeyo3zcP92wzhfMJzxDzS9p4sF0lv43VK1fZ1u70L
        KzDmLtg8JjNv6+kiYKQdruykrld5pQQ=
X-Google-Smtp-Source: ABdhPJyKh6cuzly2yoMfNsHlDFWFypICD0SoqUzdNOn5oCFgW3MbmwkWD0tvTKUcgDFjMEqAISNDIQ==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr4095809wmq.54.1639026526792;
        Wed, 08 Dec 2021 21:08:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm4458263wrn.53.2021.12.08.21.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:46 -0800 (PST)
Message-Id: <63781ed8b8e9a6bfb7326c04f3338c45a0dd5f1f.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:35 +0000
Subject: [PATCH v6 11/11] t2501: simplify the tests since we can now assume
 desired behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We no longer are dealing with a mixture of previous and desired
behavior, so simplify the tests a bit.

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 123 +++++++++++++------------------------------
 1 file changed, 36 insertions(+), 87 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index bc92230f2f2..f6d8d7d03d7 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -32,9 +32,6 @@ test_expect_success setup '
 '
 
 test_incidental_dir_removal () {
-	works=$1 &&
-	shift &&
-
 	test_when_finished "git reset --hard" &&
 
 	git checkout foo/bar/baz^{commit} &&
@@ -44,88 +41,57 @@ test_incidental_dir_removal () {
 		cd foo &&
 		"$@" &&
 
-		# Although we want pwd & git status to pass, test for existing
-		# rather than desired behavior.
-		if test "$works" = "success"
-		then
-			test-tool getcwd &&
-			git status --porcelain
-		else
-			! test-tool getcwd &&
-			test_might_fail git status --porcelain
-		fi
+		# Make sure foo still exists, and commands needing it work
+		test-tool getcwd &&
+		git status --porcelain
 	) &&
 	test_path_is_missing foo/bar/baz &&
 	test_path_is_missing foo/bar &&
 
-	# Although we want dir to be present, test for existing rather
-	# than desired behavior.
-	if test "$works" = "success"
-	then
-		test_path_is_dir foo
-	else
-		test_path_is_missing foo
-	fi
+	test_path_is_dir foo
 }
 
 test_required_dir_removal () {
-	works=$1 &&
-	shift &&
-
 	git checkout df_conflict^{commit} &&
 	test_when_finished "git clean -fdx" &&
 
 	(
 		cd dirORfile &&
 
-		# We'd like for the command to fail (much as it would if there
-		# was an untracked file there), and for the index and worktree
-		# to be left clean with pwd and git status working afterwards.
-		# But test for existing rather than desired behavior.
-		if test "$works" = "success"
-		then
-			test_must_fail "$@" 2>../error &&
-			grep "Refusing to remove.*current working directory" ../error &&
-
-			git diff --exit-code HEAD &&
-
-			test-tool getcwd &&
-			git status --porcelain
-		else
-			"$@" &&
-			! test-tool getcwd &&
-			test_might_fail git status --porcelain
-		fi
+		# Ensure command refuses to run
+		test_must_fail "$@" 2>../error &&
+		grep "Refusing to remove.*current working directory" ../error &&
+
+		# ...and that the index and working tree are left clean
+		git diff --exit-code HEAD &&
+
+		# Ensure that getcwd and git status do not error out (which
+		# they might if the current working directory had been removed)
+		test-tool getcwd &&
+		git status --porcelain
 	) &&
 
-	# Although we want dirORfile to be present, test for existing rather
-	# than desired behavior.
-	if test "$works" = "success"
-	then
-		test_path_is_dir dirORfile
-	else
-		test_path_is_file dirORfile
-	fi
+	test_path_is_dir dirORfile
 }
 
 test_expect_success 'checkout does not clean cwd incidentally' '
-	test_incidental_dir_removal success git checkout init
+	test_incidental_dir_removal git checkout init
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
-	test_required_dir_removal success git checkout fd_conflict
+	test_required_dir_removal git checkout fd_conflict
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
-	test_incidental_dir_removal success git reset --hard init
+	test_incidental_dir_removal git reset --hard init
 '
 
 test_expect_success 'reset --hard fails if cwd needs to be removed' '
-	test_required_dir_removal success git reset --hard fd_conflict
+	test_required_dir_removal git reset --hard fd_conflict
 '
 
 test_expect_success 'merge does not clean cwd incidentally' '
-	test_incidental_dir_removal success git merge reverted
+	test_incidental_dir_removal git merge reverted
 '
 
 # This file uses some simple merges where
@@ -154,46 +120,43 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 GIT_TEST_MERGE_ALGORITHM=ort
 
 test_expect_success 'merge fails if cwd needs to be removed' '
-	test_required_dir_removal success git merge fd_conflict
+	test_required_dir_removal git merge fd_conflict
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
-	test_incidental_dir_removal success git cherry-pick reverted
+	test_incidental_dir_removal git cherry-pick reverted
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
-	test_required_dir_removal success git cherry-pick fd_conflict
+	test_required_dir_removal git cherry-pick fd_conflict
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
-	test_incidental_dir_removal success git rebase reverted
+	test_incidental_dir_removal git rebase reverted
 '
 
 test_expect_success 'rebase fails if cwd needs to be removed' '
-	test_required_dir_removal success git rebase fd_conflict
+	test_required_dir_removal git rebase fd_conflict
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-	test_incidental_dir_removal success git revert HEAD
+	test_incidental_dir_removal git revert HEAD
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-	test_required_dir_removal success git revert undo_fd_conflict
+	test_required_dir_removal git revert undo_fd_conflict
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
-	test_incidental_dir_removal success git rm bar/baz.t
+	test_incidental_dir_removal git rm bar/baz.t
 '
 
 test_expect_success 'apply does not remove cwd incidentally' '
 	git diff HEAD HEAD~1 >patch &&
-	test_incidental_dir_removal success git apply ../patch
+	test_incidental_dir_removal git apply ../patch
 '
 
 test_incidental_untracked_dir_removal () {
-	works=$1 &&
-	shift &&
-
 	test_when_finished "git reset --hard" &&
 
 	git checkout foo/bar/baz^{commit} &&
@@ -205,38 +168,24 @@ test_incidental_untracked_dir_removal () {
 		cd untracked &&
 		"$@" &&
 
-		# Although we want pwd & git status to pass, test for existing
-		# rather than desired behavior.
-		if test "$works" = "success"
-		then
-			test-tool getcwd &&
-			git status --porcelain
-		else
-			! test-tool getcwd &&
-			test_might_fail git status --porcelain
-		fi
+		# Make sure untracked still exists, and commands needing it work
+		test-tool getcwd &&
+		git status --porcelain
 	) &&
 	test_path_is_missing empty &&
 	test_path_is_missing untracked/random &&
 
-	# Although we want dir to be present, test for existing rather
-	# than desired behavior.
-	if test "$works" = "success"
-	then
-		test_path_is_dir untracked
-	else
-		test_path_is_missing untracked
-	fi
+	test_path_is_dir untracked
 }
 
 test_expect_success 'clean does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal success \
+	test_incidental_untracked_dir_removal \
 		git -C .. clean -fd -e warnings . >warnings &&
 	grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal success \
+	test_incidental_untracked_dir_removal \
 		git stash --include-untracked
 '
 
-- 
gitgitgadget
