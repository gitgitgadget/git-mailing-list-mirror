Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D6C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhK2XNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98429C041F7F
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so40046567wrd.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=38ehGeaGxEUIF3ddVkCoPe7PaPM/RZKFC2CXvMnVvlQ=;
        b=HI3MfWlILXtniJbmVH2W7k4QI/CTamnnSTnNZoAQlN1zoaU4pypNZ3OnePwHUvLGjX
         Trn+0FdLOFAAUlMclWQk8jYLbhuELEW0EXygsaDrZzM6KvY+hjE0k3iT70irBdIyfwuK
         50dTLRAaAr0RMhmt88QfmND+xSxbSzjinuWkcZcxqwoBzlScCwGdSj2c/kzJLwc/D5M0
         YKUrlO1GxMbp7XLsZMHeqpHAJLD1Y0Q+HP2xFAwXWqWNC0AYpomXt7k7DGX5SWnULGKa
         9Lms/v1KlUkGWTFCyRmcWn7v4C/IcMae4D85UvuSkmpOO2vJzKxqcnLsBbU27C8/RB9M
         Vqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=38ehGeaGxEUIF3ddVkCoPe7PaPM/RZKFC2CXvMnVvlQ=;
        b=DIE7qMx/6VWqOwJw+Bj/GLNy+xQGHk4AoAbZEH83Nnkomm5qwn0RQx5pjDKV/Dy/od
         I/jAESCiWVXKQpZaUdn/R+NnN760YvnnViSJVzyDXyXrJGL1C0+TyunRmq9CFVq8LTfy
         24NQ8/OfHjMDznFybHlOXOYSQY+bUSU3BkTqmjWBAyuKsHN1rPsVIUhMt0HBu8UaGN0i
         Bbyt26Ml/RtOg9Hk3WnfcF8tqtipuGiYYAcrI+vXylaocUIME6glg+mQ22Lafz3hWSUO
         914MnY9rOGVkGJglHu5BJDGkv5lgM2/lDKZio1ejQW/a1VEN03RzMkdv4X24RJPE7iC0
         cGgQ==
X-Gm-Message-State: AOAM532qCefW2PDIJr5M6UpEEB2OSvemO9fHi3XM/GdMhYaHStOltXID
        Ha2Akl+LYuIhHsPMIAfxC2mAGwZeFsA=
X-Google-Smtp-Source: ABdhPJyPRMEI4S9I+rK8XCoKcL9fx9Bk/PrE8AVwt/DzuKwJoafKenHGP4J1XFFz9p1vVvlRKCGUQA==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr37432517wrm.470.1638225443970;
        Mon, 29 Nov 2021 14:37:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm627587wms.15.2021.11.29.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:23 -0800 (PST)
Message-Id: <21ff99a767ce2bbb79b3ec22a338ab19cd088ef3.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:14 +0000
Subject: [PATCH v4 11/11] t2501: simplify the tests since we can now assume
 desired behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We no longer are dealing with a mixture of previous and desired
behavior, so simplify the tests a bit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 123 +++++++++++++------------------------------
 1 file changed, 36 insertions(+), 87 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 6d8f68c08dd..f6d8d7d03d7 100755
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
-		if test "$works" == "success"
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
-	if test "$works" == "success"
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
-		if test "$works" == "success"
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
-	if test "$works" == "success"
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
-		if test "$works" == "success"
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
-	if test "$works" == "success"
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
