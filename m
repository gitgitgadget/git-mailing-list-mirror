Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94171C871D
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238161; cv=none; b=krMuCAoBZU25gHKrOO5ExRyupVlONEafVTlTLfDmG7P0Z9yzeJPGDt3aNO/Zns5SAkcPwpRUJLQ5AgHic7v3oHxzBVqBTzCO5yFyTWNY7TQBY738GvZIrqGzCWjoQdBJWxjhmW/L7vT97M7AZ0Fz3eBRcNJoPfqB5lYEEYG5d0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238161; c=relaxed/simple;
	bh=/+333XZEioziizlyL4BptQ9XHI+OgM/tmG3oln/b/cU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u84dEutEeS6OOTm0Lyk9X+2KycU1E/56GrbP4V/RtBGey/Oo3yaaImtmXt7YUL+cetF1C/7/VTLdBa4/YauzYa23QeqngqnqEQA6CKpA9MV6lL2gnTBdyYsf2eqG3YfvS5EYRYCx5T3z86DXZid2go+lzxhWmfZDziElJIRqwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvgGO6Vc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvgGO6Vc"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533488ffb03so734935e87.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238156; x=1724842956; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVqN2emrzRX7C9FhSRRDYU6w1L+1Lx+d82/BficLDXo=;
        b=jvgGO6Vc9YTtswaZ+wkmyM71Lx3hyBeNsPJ3CQ7rhi8/p0IeLccj8tttRXJWHEo3PR
         uxmCMoed0F2NmGHH0vIrkLCo037X0rJZVdaZeem/Zgx3Q6wNQ+efiU/qe+8bddVOtIaX
         UXL5gBjAeV8SX4x0dIHKuZ1rV3SqCmPqCr2gW/b2OWKCOu3FsxKsfCakkJZbMzg53d9L
         o4LkPgQ4dzO5qa25Bu0kD8BydMj4n15of+uSuvKhYB7XO6dJtDekeNPSl9jzfF67dkVm
         X0BNTfnxoq+TwRgRg5YG1uq9sKmbyX9P8beG3f7sf2ureLNh5DGAwmZOHQMwYTobctW3
         qXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238156; x=1724842956;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVqN2emrzRX7C9FhSRRDYU6w1L+1Lx+d82/BficLDXo=;
        b=qgAtKhaJsW9EQza2SE9AjbzWRw7+FdQ7g1LDmx2wlP+zAYOT7wPEzRhWdwbp8VHNlD
         53ENui3XJriL5tM3L0p8OEuWBvfAtGyUJc7Pr4235+UzOpIgHnlSsQmJvVL2Bt+GMJtE
         oV4ih5J6p93U1JlYq5VMBUfcCF6G1NCB70l/l4FrTfEfMuR1Ekk+DzXl9sYTkdfKK/oM
         CwMI5p0Iih1HJnF02TZy6qTiFP8W0yXlaByRn9pf7SaXpML/4oH8TCq9JWwoPF7Y7W2E
         Rje0TVv8wTvIdpDuMebUOJaXPFo6kiDMhlISu8f5aFpB4cSUIyvTUJSd5Z6nDgGGYe+A
         QDUQ==
X-Gm-Message-State: AOJu0YxOXwvVlzxEsQX5po6nNSNUrIupsUzFocllty9VejTcZrbHhYRO
	q3XDe9lVmxxIbQ4ULKrd6mwIaqLJ84bxrrqIjoVbjVKzyE2mCaawffQQsw==
X-Google-Smtp-Source: AGHT+IHmn0a4F7bLJC6W9f17GMIlWU+RS5H7/XeEUH0bM4ae51r929fYscXSU3JN9iNqR4JnZZrSGQ==
X-Received: by 2002:a05:6512:2251:b0:530:aa82:a50a with SMTP id 2adb3069b0e04-53348594c82mr901119e87.45.1724238155480;
        Wed, 21 Aug 2024 04:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6693sm881241066b.42.2024.08.21.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:35 -0700 (PDT)
Message-Id: <37eaab2f76341d6a4dd253b67b1567c807c2e219.1724238152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:26 +0000
Subject: [PATCH 1/7] t1000-2000: add GIT_ADVICE=1 for advice tests
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

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh  | 18 ++++++++--------
 t/t2020-checkout-detach.sh                | 25 ++++++++++++++---------
 t/t2024-checkout-dwim.sh                  |  5 +++--
 t/t2060-switch.sh                         |  4 ++--
 t/t2204-add-ignored.sh                    |  8 ++++----
 t/t2400-worktree-add.sh                   | 12 +++++------
 t/t7500-commit-template-squash-signoff.sh |  3 ++-
 7 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a2c0e1b4dcc..b5183ea7c83 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -411,10 +411,10 @@ test_expect_success 'add outside sparse cone' '
 	run_on_sparse mkdir folder1 &&
 	run_on_sparse ../edit-contents folder1/a &&
 	run_on_sparse ../edit-contents folder1/newfile &&
-	test_sparse_match test_must_fail git add folder1/a &&
+	test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder1/a &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
-	test_sparse_match test_must_fail git add folder1/newfile &&
+	test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder1/newfile &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/newfile
 '
@@ -466,13 +466,13 @@ test_expect_success 'status/add: outside sparse cone' '
 	test_sparse_match git status --porcelain=v2 &&
 
 	# Adding the path outside of the sparse-checkout cone should fail.
-	test_sparse_match test_must_fail git add folder1/a &&
+	test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder1/a &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
 	test_all_match git add --refresh folder1/a &&
 	test_must_be_empty sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
-	test_sparse_match test_must_fail git add folder1/new &&
+	test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder1/new &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/new &&
 	test_sparse_match git add --sparse folder1/a &&
@@ -1018,7 +1018,7 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
-	test_sparse_match test_must_fail git add folder1/a &&
+	test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder1/a &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
 	test_all_match git add --sparse folder1/a &&
@@ -1027,7 +1027,7 @@ test_expect_success 'merge with conflict outside cone' '
 	# 3. Rename the file to another sparse filename and
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
-	test_sparse_match test_must_fail git add folder2 &&
+	test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder2 &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder2/z &&
 	test_all_match git add --sparse folder2 &&
@@ -1058,7 +1058,7 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		# NEEDSWORK: Even though the merge conflict removed the
 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 		# warn that this is a problematic add.
-		test_sparse_match test_must_fail git add folder1/a &&
+		test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder1/a &&
 		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 		test_sparse_unstaged folder1/a &&
 		test_all_match git add --sparse folder1/a &&
@@ -1070,7 +1070,7 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		# outside of the sparse-checkout cone and does not match an
 		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
-		test_sparse_match test_must_fail git add folder2 &&
+		test_env GIT_ADVICE=1 test_sparse_match test_must_fail git add folder2 &&
 		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 		test_sparse_unstaged folder2/z &&
 		test_all_match git add --sparse folder2 &&
@@ -2341,7 +2341,7 @@ test_expect_success 'advice.sparseIndexExpanded' '
 	git -C sparse-index sparse-checkout set deep/deeper1 &&
 	mkdir -p sparse-index/deep/deeper2/deepest &&
 	touch sparse-index/deep/deeper2/deepest/bogus &&
-	git -C sparse-index status 2>err &&
+	GIT_ADVICE=1 git -C sparse-index status 2>err &&
 	grep "The sparse index is expanding to a full index" err
 '
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8d90d028504..43ee72b19bd 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -175,7 +175,7 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	git config branch.child.remote . &&
 	git config branch.child.merge refs/heads/main &&
 	git checkout child^ &&
-	git checkout child >stdout &&
+	GIT_ADVICE=1 git checkout child >stdout &&
 	test_cmp expect stdout &&
 
 	git checkout --detach child >stdout &&
@@ -251,15 +251,17 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 	# Various ways of *not* asking for ellipses
 
 	sane_unset GIT_PRINT_SHA1_ELLIPSIS &&
-	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 1st_detach actual &&
 
-	GIT_PRINT_SHA1_ELLIPSIS="no" git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1  GIT_PRINT_SHA1_ELLIPSIS="no" git -c 'core.abbrev=12' \
+		checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 2nd_detach actual &&
 
-	GIT_PRINT_SHA1_ELLIPSIS= git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 GIT_PRINT_SHA1_ELLIPSIS= git -c 'core.abbrev=12' \
+		checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 3rd_detach actual &&
 
@@ -270,17 +272,17 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 	check_not_detached &&
 
 	# Make no mention of the env var at all
-	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 1st_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS='nope' &&
-	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 2nd_detach actual &&
 
 	GIT_PRINT_SHA1_ELLIPSIS=nein &&
-	git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 3rd_detach actual &&
 
@@ -333,15 +335,18 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 	# Various ways of asking for ellipses...
 	# The user can just use any kind of quoting (including none).
 
-	GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 GIT_PRINT_SHA1_ELLIPSIS=yes git -c 'core.abbrev=12' \
+		checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 1st_detach actual &&
 
-	GIT_PRINT_SHA1_ELLIPSIS=Yes git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 GIT_PRINT_SHA1_ELLIPSIS=Yes git -c 'core.abbrev=12' \
+		checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 2nd_detach actual &&
 
-	GIT_PRINT_SHA1_ELLIPSIS=YES git -c 'core.abbrev=12' checkout HEAD^ >actual 2>&1 &&
+	GIT_ADVICE=1 GIT_PRINT_SHA1_ELLIPSIS=YES git -c 'core.abbrev=12' \
+		checkout HEAD^ >actual 2>&1 &&
 	check_detached &&
 	test_cmp 3rd_detach actual &&
 
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 2caada3d834..56be88b1620 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -103,11 +103,12 @@ test_expect_success 'when arg matches multiple remotes, do not fallback to inter
 test_expect_success 'checkout of branch from multiple remotes fails with advice' '
 	git checkout -B main &&
 	test_might_fail git branch -D foo &&
-	test_must_fail git checkout foo 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
 	test_grep "^hint: " stderr &&
-	test_must_fail git -c advice.checkoutAmbiguousRemoteBranchName=false \
+	test_env GIT_ADVICE=1 test_must_fail git \
+		-c advice.checkoutAmbiguousRemoteBranchName=false \
 		checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 77b2346291b..d84b3accf0e 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -34,13 +34,13 @@ test_expect_success 'switch and detach' '
 '
 
 test_expect_success 'suggestion to detach' '
-	test_must_fail git switch main^{commit} 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git switch main^{commit} 2>stderr &&
 	grep "try again with the --detach option" stderr
 '
 
 test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
 	test_config advice.suggestDetachingHead false &&
-	test_must_fail git switch main^{commit} 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git switch main^{commit} 2>stderr &&
 	! grep "try again with the --detach option" stderr
 '
 
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index b7cf1e492c1..ca46bbd22c7 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -30,7 +30,7 @@ for i in ign dir/ign dir/sub dir/sub/*ign sub/file sub sub/*
 do
 	test_expect_success "complaints for ignored $i" '
 		rm -f .git/index &&
-		test_must_fail git add "$i" 2>err &&
+		test_env GIT_ADVICE=1 test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
 		test_must_be_empty out
 	'
@@ -41,7 +41,7 @@ do
 
 	test_expect_success "complaints for ignored $i with unignored file" '
 		rm -f .git/index &&
-		test_must_fail git add "$i" file 2>err &&
+		test_env GIT_ADVICE=1 test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
 		test_must_be_empty out
 	'
@@ -56,7 +56,7 @@ do
 		rm -f .git/index &&
 		(
 			cd dir &&
-			test_must_fail git add "$i" 2>err &&
+			test_env GIT_ADVICE=1 test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
 			test_must_be_empty out
 		)
@@ -76,7 +76,7 @@ do
 		rm -f .git/index &&
 		(
 			cd sub &&
-			test_must_fail git add "$i" 2>err &&
+			test_env GIT_ADVICE=1 test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
 			test_must_be_empty out
 		)
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798..742002ff41e 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -436,7 +436,7 @@ test_wt_add_orphan_hint () {
 		git init repo &&
 		(cd repo && test_commit commit) &&
 		git -C repo switch --orphan noref &&
-		test_must_fail git -C repo worktree add $opts foobar/ 2>actual &&
+		test_env GIT_ADVICE=1 test_must_fail git -C repo worktree add $opts foobar/ 2>actual &&
 		! grep "error: unknown switch" actual &&
 		grep "hint: If you meant to create a worktree containing a new unborn branch" actual &&
 		if [ $use_branch -eq 1 ]
@@ -983,7 +983,7 @@ test_dwim_orphan () {
 			fi &&
 			if [ "$outcome" = "infer" ]
 			then
-				git $dashc_args worktree add $args 2>actual &&
+				GIT_ADVICE=1 git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
 					test_must_be_empty actual
@@ -992,7 +992,7 @@ test_dwim_orphan () {
 				fi
 			elif [ "$outcome" = "no_infer" ]
 			then
-				git $dashc_args worktree add $args 2>actual &&
+				GIT_ADVICE=1 git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
 					test_must_be_empty actual
@@ -1001,11 +1001,11 @@ test_dwim_orphan () {
 				fi
 			elif [ "$outcome" = "fetch_error" ]
 			then
-				test_must_fail git $dashc_args worktree add $args 2>actual &&
+				test_env GIT_ADVICE=1 test_must_fail git $dashc_args worktree add $args 2>actual &&
 				grep "$fetch_error_text" actual
 			elif [ "$outcome" = "fatal_orphan_bad_combo" ]
 			then
-				test_must_fail git $dashc_args worktree add $args 2>actual &&
+				test_env GIT_ADVICE=1 test_must_fail git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
 					! grep "$info_text" actual
@@ -1015,7 +1015,7 @@ test_dwim_orphan () {
 				grep "$bad_combo_regex" actual
 			elif [ "$outcome" = "warn_bad_head" ]
 			then
-				test_must_fail git $dashc_args worktree add $args 2>actual &&
+				test_env GIT_ADVICE=1 test_must_fail git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
 					grep "$invalid_ref_regex" actual &&
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a77..546b6f2f373 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -554,7 +554,8 @@ test_expect_success 'commit without staging files fails and displays hints' '
 	git add file &&
 	git commit -m initial &&
 	echo "changes" >>file &&
-	test_must_fail git commit -m update >actual &&
+	test_env GIT_ADVICE=1 test_must_fail \
+		git commit -m update >actual &&
 	test_grep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
 '
 
-- 
gitgitgadget

