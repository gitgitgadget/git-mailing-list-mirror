Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437411C871F
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238161; cv=none; b=KDG4CPbjkCCoK8kmE3MC0gULxBLLg//8QSUjGz6AaDFNrePJZ8dePeCWiGhNIk34/4O63/N0qrerBExFS9DZlsWBTmIsfiG2fPYHMxiy1jXYNtjlrZVSTqpUVbAwM88N5gPB0OXAqXsri/C2YM9mqsS8L81q2KrvMEJifVtZge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238161; c=relaxed/simple;
	bh=JI2xruuiRHvfCkX+EY+iQgB4uv+0i1KF3x/W+p590Lc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dYYGo6TQpHIcaRr2925z93o/pLeTVbZXFx+eErbdcD/NFgLZ9SR4E8weNvTLGmn1wTB1ID8ZWXRamw4/hOfygWPEC+oMe4s24dW++vHmLxV/aCu0guRKb+WMauzhc7l5Wroo+Tn7X7v1yX92iWjSzwmShMeUyXlRlYLpD8tgY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2je8hre; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2je8hre"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso798360966b.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238157; x=1724842957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zz4XpJM65mIX03N6iEZ2pkr61O2ui9mg1/XnqVESuk=;
        b=M2je8hreaqX2lxcxtao08oV4v8YPEXWPWjdYcHkJDlifpIBAi+LQeSr3brJ7pse4Uh
         QLFQP2PMVpuFh0GW+dH0GpBjYiYJAJ44ENXz+GvtuBa7xCM4o3su8xAj+XZa6fpGNu6e
         Sk5slTbUyb9QWGzE2JLPFsPHO8iMX+qa8xvkIyQcc6MQnQLuPQVJSkiqI3Vwm9OzhnYc
         MqmVIEIO0/ekr+U4X5ZKaimnMC7ceVd2LgzcK7W2o9SsOJ28wpa4G5ZCk7fvzyXlPQIT
         692h75qUO8Y41XTpYAH5sEpDHAds4X6G/eu+OsFOhJ5ZiDL475gcBssDO4T8PQC2n9YY
         Al7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238157; x=1724842957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zz4XpJM65mIX03N6iEZ2pkr61O2ui9mg1/XnqVESuk=;
        b=PF2cZhhgn0qcVdGGoNd9Qc5tGmWwjCxOIpY4XorXoLg8JjgGS+1pPXxCq5BXeNLQBf
         fhaZCDnWYTWbzgIIjQ1s3QcdJa/88XyF7o4XawGYONgfxS53H/cNjnhGqH/tPYLnTOqX
         YeTYX0rcOE2vZmvxs8qS6xH78U4S7tTYV+UPSaKp6DrUh8vMst1NPoWUPd2FtUjLMOKL
         tlBevhF5aCdTFUyYmi7dysZJvxsUvKSK2un9miMAKWCycQJgd5SyY0BbkXCM/tWVThg8
         2CuXw2C07KX6NHnBgNd8R94d68v0ukyzZHHCMhl2TWbpJLyqcP9dnHYQc58uKVs8tbMz
         iUHw==
X-Gm-Message-State: AOJu0Yx1SPmCNPcCFxwmZSwqCntRmpBxcSZ6QRI3TfBYgqPa+BKOcS5C
	Rtqzqsowp5Cbrb52gA2HJeWOZH7RYxdJoY/cgvsxUDXRk8xniLCSA7mZ4w==
X-Google-Smtp-Source: AGHT+IHsshIY7HfN5JeWU06hcF9vfaAYEktXZ3sOnYMJ27dclCkQnnhGrnPT5kPtAd4BrhA62MfCVw==
X-Received: by 2002:a17:907:e604:b0:a86:68b5:4d96 with SMTP id a640c23a62f3a-a866f39f17bmr159122766b.38.1724238156527;
        Wed, 21 Aug 2024 04:02:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8680428902sm30792266b.199.2024.08.21.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:36 -0700 (PDT)
Message-Id: <483fcc94355e69e21f76ed4a6d8cd8b885bd7f75.1724238152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:27 +0000
Subject: [PATCH 2/7] t3000-4000: add GIT_ADVICE=1 to advice tests
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
 t/t3200-branch.sh               |  4 ++--
 t/t3404-rebase-interactive.sh   |  2 +-
 t/t3501-revert-cherry-pick.sh   |  2 +-
 t/t3507-cherry-pick-conflict.sh |  4 ++--
 t/t3510-cherry-pick-sequence.sh |  6 +++---
 t/t3600-rm.sh                   | 12 ++++++------
 t/t3602-rm-sparse-checkout.sh   | 18 +++++++++---------
 t/t3700-add.sh                  |  6 +++---
 t/t3705-add-sparse-checkout.sh  | 32 ++++++++++++++++----------------
 t/t4150-am.sh                   | 14 +++++++-------
 10 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ccfa6a720d0..9ff64fe4f1a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1161,7 +1161,7 @@ test_expect_success 'avoid ambiguous track and advise' '
 	hint: different remotes'\'' fetch refspecs map into different
 	hint: tracking namespaces.
 	EOF
-	test_must_fail git branch all1 main 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git branch all1 main 2>actual &&
 	test_cmp expected actual &&
 	test -z "$(git config branch.all1.merge)"
 '
@@ -1699,7 +1699,7 @@ test_expect_success 'errors if given a bad branch name' '
 	hint: See `man git check-ref-format`
 	hint: Disable this message with "git config advice.refSyntax false"
 	EOF
-	test_must_fail git branch foo..bar >actual 2>&1 &&
+	test_env GIT_ADVICE=1 test_must_fail git branch foo..bar >actual 2>&1 &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f92baad1381..c31ca807f7b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2229,7 +2229,7 @@ test_expect_success 'non-merge commands reject merge commits' '
 	EOF
 	(
 		set_replace_editor todo &&
-		test_must_fail git rebase -i HEAD 2>actual
+		test_env GIT_ADVICE=1 test_must_fail git rebase -i HEAD 2>actual
 	) &&
 	cat >expect <<-EOF &&
 	error: ${SQ}pick${SQ} does not accept merge commits
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 411027fb58c..3478a8a588f 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -181,7 +181,7 @@ test_expect_success 'advice from failed revert' '
 	hint: Disable this message with "git config advice.mergeConflict false"
 	EOF
 	test_commit --append --no-tag "double-add dream" dream dream &&
-	test_must_fail git revert HEAD^ 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git revert HEAD^ 2>actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index f3947b400a3..5633a10659d 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -62,7 +62,7 @@ test_expect_success 'advice from failed cherry-pick' '
 	hint: run "git cherry-pick --abort".
 	hint: Disable this message with "git config advice.mergeConflict false"
 	EOF
-	test_must_fail git cherry-pick picked 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git cherry-pick picked 2>actual &&
 
 	test_cmp expected actual
 '
@@ -77,7 +77,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	hint: with 'git add <paths>' or 'git rm <paths>'
 	hint: Disable this message with \"git config advice.mergeConflict false\"
 	EOF
-	test_must_fail git cherry-pick --no-commit picked 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
 	test_cmp expected actual
 "
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7eb52b12edc..291c5de4f7d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -231,7 +231,7 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	echo c >foo &&
 	git commit -a &&
 	test_path_is_missing .git/CHERRY_PICK_HEAD &&
-	test_must_fail git cherry-pick --skip 2>advice &&
+	test_env GIT_ADVICE=1 test_must_fail git cherry-pick --skip 2>advice &&
 	test_cmp expect advice
 '
 
@@ -243,7 +243,7 @@ test_expect_success 'selectively advise --skip while launching another sequence'
 	fatal: cherry-pick failed
 	EOF
 	test_must_fail git cherry-pick picked..yetanotherpick &&
-	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_env GIT_ADVICE=1 test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
 	test_cmp expect advice &&
 	cat >expect <<-EOF &&
 	error: cherry-pick is already in progress
@@ -251,7 +251,7 @@ test_expect_success 'selectively advise --skip while launching another sequence'
 	fatal: cherry-pick failed
 	EOF
 	git reset --merge &&
-	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_env GIT_ADVICE=1 test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
 	test_cmp expect advice
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 31ac31d4bcd..90a30a3a002 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -822,7 +822,7 @@ test_expect_success 'rm files with different staged content' '
 	EOF
 	echo content1 >foo.txt &&
 	echo content1 >bar.txt &&
-	test_must_fail git rm foo.txt bar.txt 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git rm foo.txt bar.txt 2>actual &&
 	test_cmp expect actual
 '
 
@@ -847,7 +847,7 @@ test_expect_success 'rm file with local modification' '
 	EOF
 	git commit -m "testing rm 3" &&
 	echo content3 >foo.txt &&
-	test_must_fail git rm foo.txt 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git rm foo.txt 2>actual &&
 	test_cmp expect actual
 '
 
@@ -857,7 +857,7 @@ test_expect_success 'rm file with local modification without hints' '
 	    bar.txt
 	EOF
 	echo content4 >bar.txt &&
-	test_must_fail git -c advice.rmhints=false rm bar.txt 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git -c advice.rmhints=false rm bar.txt 2>actual &&
 	test_cmp expect actual
 '
 
@@ -870,7 +870,7 @@ test_expect_success 'rm file with changes in the index' '
 	git reset --hard &&
 	echo content5 >foo.txt &&
 	git add foo.txt &&
-	test_must_fail git rm foo.txt 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git rm foo.txt 2>actual &&
 	test_cmp expect actual
 '
 
@@ -879,7 +879,7 @@ test_expect_success 'rm file with changes in the index without hints' '
 	error: the following file has changes staged in the index:
 	    foo.txt
 	EOF
-	test_must_fail git -c advice.rmhints=false rm foo.txt 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git -c advice.rmhints=false rm foo.txt 2>actual &&
 	test_cmp expect actual
 '
 
@@ -898,7 +898,7 @@ test_expect_success 'rm files with two different errors' '
 	echo content6 >foo1.txt &&
 	echo content6 >bar1.txt &&
 	git add bar1.txt &&
-	test_must_fail git rm bar1.txt foo1.txt 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git rm bar1.txt foo1.txt 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index fcdefba48cc..c2b197046d4 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -32,7 +32,7 @@ for opt in "" -f --dry-run
 do
 	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
 		git sparse-checkout set --no-cone a &&
-		test_must_fail git rm $opt b 2>stderr &&
+		test_env GIT_ADVICE=1 test_must_fail git rm $opt b 2>stderr &&
 		test_cmp b_error_and_hint stderr &&
 		git ls-files --error-unmatch b
 	'
@@ -72,14 +72,14 @@ test_expect_success 'recursive rm --sparse removes sparse entries' '
 test_expect_success 'rm obeys advice.updateSparsePath' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-	test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
 	test_cmp sparse_entry_b_error stderr
 '
 
 test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-	test_must_fail git rm nonexistent 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git rm nonexistent 2>stderr &&
 	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
 	! grep -F -f sparse_error_header stderr
 '
@@ -87,7 +87,7 @@ test_expect_success 'do not advice about sparse entries when they do not match t
 test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-	git rm "[ba]" 2>stderr &&
+	GIT_ADVICE=1 git rm "[ba]" 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --error-unmatch b &&
 	test_must_fail git ls-files --error-unmatch a
@@ -96,7 +96,7 @@ test_expect_success 'do not warn about sparse entries when pathspec matches dens
 test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-	git rm --ignore-unmatch b 2>stderr &&
+	GIT_ADVICE=1 git rm --ignore-unmatch b 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --error-unmatch b
 '
@@ -105,9 +105,9 @@ test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone'
 	git reset --hard &&
 	git sparse-checkout set a &&
 	git update-index --no-skip-worktree b &&
-	test_must_fail git rm b 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git rm b 2>stderr &&
 	test_cmp b_error_and_hint stderr &&
-	git rm --sparse b 2>stderr &&
+	GIT_ADVICE=1 git rm --sparse b 2>stderr &&
 	test_must_be_empty stderr &&
 	test_path_is_missing b
 '
@@ -120,7 +120,7 @@ test_expect_success 'can remove files from non-sparse dir' '
 	test_commit x/y/f &&
 
 	git sparse-checkout set --no-cone w !/x y/ &&
-	git rm w/f.t x/y/f.t 2>stderr &&
+	GIT_ADVICE=1 git rm w/f.t x/y/f.t 2>stderr &&
 	test_must_be_empty stderr
 '
 
@@ -132,7 +132,7 @@ test_expect_success 'refuse to remove non-skip-worktree file from sparse dir' '
 	git sparse-checkout set --no-cone !/x y/ !x/y/z &&
 
 	git update-index --no-skip-worktree x/y/z/f.t &&
-	test_must_fail git rm x/y/z/f.t 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git rm x/y/z/f.t 2>stderr &&
 	echo x/y/z/f.t | cat sparse_error_header - sparse_hint >expect &&
 	test_cmp expect stderr
 '
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 839c904745a..8042c3bc34a 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -34,7 +34,7 @@ test_expect_success 'Test with no pathspecs' '
 	hint: Maybe you wanted to say ${SQ}git add .${SQ}?
 	hint: Disable this message with "git config advice.addEmptyPathspec false"
 	EOF
-	git add 2>actual &&
+	GIT_ADVICE=1 git add 2>actual &&
 	test_cmp expect actual
 '
 
@@ -360,7 +360,7 @@ test_expect_success '"git add" a embedded repository' '
 			git -C $name commit --allow-empty -m $name ||
 				return 1
 		done &&
-		git add . 2>actual &&
+		GIT_ADVICE=1 git add . 2>actual &&
 		cat >expect <<-EOF &&
 		warning: adding embedded git repository: inner1
 		hint: You${SQ}ve added another git repository inside your current repository.
@@ -421,7 +421,7 @@ add 'track-this'
 EOF
 
 test_expect_success 'git add --dry-run --ignore-missing of non-existing file' '
-	test_must_fail git add --dry-run --ignore-missing track-this ignored-file >actual.out 2>actual.err
+	test_env GIT_ADVICE=1 test_must_fail git add --dry-run --ignore-missing track-this ignored-file >actual.out 2>actual.err
 '
 
 test_expect_success 'git add --dry-run --ignore-missing of non-existing file output' '
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2bade9e804f..c06e803c0e9 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -64,7 +64,7 @@ test_expect_success 'setup' "
 test_expect_success 'git add does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
-	test_must_fail git add sparse_entry 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add sparse_entry 2>stderr &&
 	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
@@ -74,7 +74,7 @@ test_expect_success 'git add -A does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	setup_gitignore &&
-	git add -A 2>stderr &&
+	GIT_ADVICE=1 git add -A 2>stderr &&
 	test_must_be_empty stderr &&
 	test_sparse_entry_unchanged
 '
@@ -83,7 +83,7 @@ test_expect_success 'git add . does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	setup_gitignore &&
-	test_must_fail git add . 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add . 2>stderr &&
 	test_sparse_entry_unstaged &&
 
 	cat sparse_error_header >expect &&
@@ -99,7 +99,7 @@ do
 	test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
 		setup_sparse_entry &&
 		echo modified >sparse_entry &&
-		test_must_fail git add $opt sparse_entry 2>stderr &&
+		test_env GIT_ADVICE=1 test_must_fail git add $opt sparse_entry 2>stderr &&
 		test_sparse_entry_unstaged &&
 		test_cmp error_and_hint stderr &&
 		test_sparse_entry_unchanged
@@ -110,7 +110,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	setup_sparse_entry &&
 	git ls-files --debug sparse_entry | grep mtime >before &&
 	test-tool chmtime -60 sparse_entry &&
-	test_must_fail git add --refresh sparse_entry 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add --refresh sparse_entry 2>stderr &&
 	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	git ls-files --debug sparse_entry | grep mtime >after &&
@@ -119,7 +119,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 
 test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
-	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
 	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged &&
@@ -131,7 +131,7 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
 	test_config core.autocrlf false &&
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
-	test_must_fail git add --renormalize sparse_entry 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add --renormalize sparse_entry 2>stderr &&
 	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
@@ -140,7 +140,7 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
 test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
-	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
 	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
@@ -148,7 +148,7 @@ test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
 
 test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
 	setup_sparse_entry &&
-	test_must_fail git add nonexistent 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add nonexistent 2>stderr &&
 	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
 	! grep -F -f sparse_error_header stderr
 '
@@ -157,7 +157,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 	setup_sparse_entry &&
 	echo modified >sparse_entry &&
 	>dense_entry &&
-	git add "*_entry" 2>stderr &&
+	GIT_ADVICE=1 git add "*_entry" 2>stderr &&
 	test_must_be_empty stderr &&
 	test_sparse_entry_unchanged &&
 	git ls-files --error-unmatch dense_entry
@@ -181,12 +181,12 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_sparse_entry_unstaged &&
 
 	# Avoid munging CRLFs to avoid an error message
-	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
+	GIT_ADVICE=1 git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
 	grep "^100644 .*sparse_entry\$" actual &&
 
-	git add --sparse --chmod=+x sparse_entry 2>stderr &&
+	GIT_ADVICE=1 git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
 	grep "^100755 .*sparse_entry\$" actual &&
@@ -201,7 +201,7 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
 	setup_sparse_entry &&
-	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
 	test_sparse_entry_unstaged &&
 	test_cmp sparse_entry_error stderr
 
@@ -212,7 +212,7 @@ test_expect_success 'add allows sparse entries with --sparse' '
 	echo modified >sparse_entry &&
 	test_must_fail git add sparse_entry &&
 	test_sparse_entry_unchanged &&
-	git add --sparse sparse_entry 2>stderr &&
+	GIT_ADVICE=1 git add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr
 '
 
@@ -220,7 +220,7 @@ test_expect_success 'can add files from non-sparse dir' '
 	git sparse-checkout set w !/x y/ &&
 	mkdir -p w x/y &&
 	touch w/f x/y/f &&
-	git add w/f x/y/f 2>stderr &&
+	GIT_ADVICE=1 git add w/f x/y/f 2>stderr &&
 	test_must_be_empty stderr
 '
 
@@ -228,7 +228,7 @@ test_expect_success 'refuse to add non-skip-worktree file from sparse dir' '
 	git sparse-checkout set !/x y/ !x/y/z &&
 	mkdir -p x/y/z &&
 	touch x/y/z/f &&
-	test_must_fail git add x/y/z/f 2>stderr &&
+	test_env GIT_ADVICE=1 test_must_fail git add x/y/z/f 2>stderr &&
 	echo x/y/z/f | cat sparse_error_header - sparse_hint >expect &&
 	test_cmp expect stderr
 '
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5e2b6c80eae..68a62ff330e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -678,7 +678,7 @@ test_expect_success 'am -3 -q is quiet' '
 	rm -fr .git/rebase-apply &&
 	git checkout -f lorem2 &&
 	git reset base3way --hard &&
-	git am -3 -q lorem-move.patch >output.out 2>&1 &&
+	GIT_ADVICE=1 git am -3 -q lorem-move.patch >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
@@ -921,7 +921,7 @@ test_expect_success 'am -q is quiet' '
 	git reset --hard &&
 	git checkout first &&
 	test_tick &&
-	git am -q <patch1 >output.out 2>&1 &&
+	GIT_ADVICE=1 git am -q <patch1 >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
@@ -930,7 +930,7 @@ test_expect_success 'am empty-file does not infloop' '
 	git reset --hard &&
 	touch empty-file &&
 	test_tick &&
-	test_must_fail git am empty-file 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git am empty-file 2>actual &&
 	echo Patch format detection failed. >expected &&
 	test_cmp expected actual
 '
@@ -1180,7 +1180,7 @@ test_expect_success 'apply binary blob in partial clone' '
 
 test_expect_success 'an empty input file is error regardless of --empty option' '
 	test_when_finished "git am --abort || :" &&
-	test_must_fail git am --empty=drop empty.patch 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git am --empty=drop empty.patch 2>actual &&
 	echo "Patch format detection failed." >expected &&
 	test_cmp expected actual
 '
@@ -1188,7 +1188,7 @@ test_expect_success 'an empty input file is error regardless of --empty option'
 test_expect_success 'invalid when passing the --empty option alone' '
 	test_when_finished "git am --abort || :" &&
 	git checkout empty-commit^ &&
-	test_must_fail git am --empty empty-commit.patch 2>err &&
+	test_env GIT_ADVICE=1 test_must_fail git am --empty empty-commit.patch 2>err &&
 	echo "error: invalid value for '\''--empty'\'': '\''empty-commit.patch'\''" >expected &&
 	test_cmp expected err
 '
@@ -1224,7 +1224,7 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
 
 test_expect_success 'skip an empty patch in the middle of an am session' '
 	git checkout empty-commit^ &&
-	test_must_fail git am empty-commit.patch >out 2>err &&
+	test_env GIT_ADVICE=1 test_must_fail git am empty-commit.patch >out 2>err &&
 	grep "Patch is empty." out &&
 	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git am --skip &&
@@ -1236,7 +1236,7 @@ test_expect_success 'skip an empty patch in the middle of an am session' '
 
 test_expect_success 'record an empty patch as an empty commit in the middle of an am session' '
 	git checkout empty-commit^ &&
-	test_must_fail git am empty-commit.patch >out 2>err &&
+	test_env GIT_ADVICE=1 test_must_fail git am empty-commit.patch >out 2>err &&
 	grep "Patch is empty." out &&
 	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git am --allow-empty >output &&
-- 
gitgitgadget

