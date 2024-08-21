Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C21C93B1
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238163; cv=none; b=Z3WopfL4EQeJmA308OBCkt6n40Q1wSErWkhrLKpBiVWt9UqhLxtZLRXWGpoMvapx2uIr90wJUb2JZLIVjp6kIYQyAnc/yLoDXGWwAl+Wi7mbiFegFA+pQH3NTf8QmTAjRAgm4SkAx1IlYePy8GxFD83aWvmgqYZ1Ze7N2mNzl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238163; c=relaxed/simple;
	bh=6i+4m2ELOQ5VxuLFumaDn9mCSLj3YXs7KLBYe8LlUV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ObaE2NuTozu4uKeRwdYOytPst4yjtUto7g304dyv9jRmFGLrBsh5hv/9BWKZjtMXL5P7Lvp/9w50ROvyuTsKD3hGYT1TBoe5eGuhRUggimkZEnPZOJ2vDgwg6h5UJc6zN+Y3Xug8dzxS6Akw5/kYz6XQbX99+x950LTGwZgW2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0nIUQPt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0nIUQPt"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so5639576a12.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238159; x=1724842959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7RM30Pze8ou9OM3x269OS0C7Iq7kpipaXpg+zeqL1M=;
        b=O0nIUQPtEXavwNjazDRuSC70MoFNq+tN+agLsGTYN+SJFI0/2ILkSzG+kaMy4VNMQh
         iAqQE/TPIu/Hap08AqcgVSSTvMiP5fdU5doIFzQq4YpCXkoGqcoDtVqn8PVK/uQIx2ek
         NX29KfI9vS46bZeOr4Tl+PDzzqM28Huse+RQH3glEZgYAoN3snPM+h3m6s74OWWka3oc
         5AjxLStPnROdPZwM5kZ2U7XlOxtEBFq3U9bFuRCShOUC9OJWG5JvMdExlKJPwTFeE+c/
         ipf1fSHOpS8p0kGiz4WEXdUJvtMeYqusEOSqe2lUWwwsz2RqeTtR9gR6RPGsEHom1YAu
         jMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238159; x=1724842959;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7RM30Pze8ou9OM3x269OS0C7Iq7kpipaXpg+zeqL1M=;
        b=oawwcFTiIwL0ya/ZljWunRC7C2rVdgcNJu6B0Q2LvPQ7I6jeFB7n3/Hwo9Es0EBc3A
         x+wJXBRORnFH8MdajFdMMeOT0DvYqfQWg9Qs/U7BrWPQjGOrjmmT9wTU6tEPGxCvGjzm
         b01MG2GoIm+OJUHIA+t3M+QhDBtDzEVA0pvvMH8lOyFVH9HOC5b5eyoTLx9B3ghQOkzh
         SUjDE16sqavUw4GZVUQTY1S26RBZiQWkafjOeRWsMWfNQfn+4Wj++XYBDBnCoHmA+/d3
         1ccaAp6Qd9ifKrOTlN8VF0lc7Hy+peIyynw5JciCDS26bFRzucICdjgebxN0/6ZL6yzD
         2HFQ==
X-Gm-Message-State: AOJu0YyBzx9paCkaMoc/H79o9GpYUY1st66ZMXT5o0wuRywucNbPv2Qf
	eTUCasLdxJvT5bD3mp3AQts7sU07k0SkOcjziSb+inqC5ZSg/OPxS/qdUQ==
X-Google-Smtp-Source: AGHT+IGiOTChfuIOyjdn4nl3dzUGOSYRIQNQKvzFqLg0kqPhKtDfAHJ6x/m2XJnpR6KXpsUh8e8vZQ==
X-Received: by 2002:a05:6402:1d4d:b0:5bf:50:266b with SMTP id 4fb4d7f45d1cf-5bf1f1598bamr1210572a12.19.1724238158550;
        Wed, 21 Aug 2024 04:02:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc0810a9sm7962830a12.79.2024.08.21.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:38 -0700 (PDT)
Message-Id: <1ce8a8050e13fa5f24dace3ae03ff0e6a5a71aa9.1724238153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:29 +0000
Subject: [PATCH 4/7] t6000: add GIT_ADVICE=1 to advice tests
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
 t/t6001-rev-list-graft.sh      |  4 ++--
 t/t6050-replace.sh             |  6 +++---
 t/t6436-merge-overwrite.sh     |  6 +++---
 t/t6437-submodule-merge.sh     | 16 ++++++++--------
 t/t6439-merge-co-error-msgs.sh | 12 ++++++------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 3553bbbfe73..e3f19621727 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -118,10 +118,10 @@ do
 done
 
 test_expect_success 'show advice that grafts are deprecated' '
-	git show HEAD 2>err &&
+	GIT_ADVICE=1 git show HEAD 2>err &&
 	test_grep "git replace" err &&
 	test_config advice.graftFileDeprecated false &&
-	git show HEAD 2>err &&
+	GIT_ADVICE=1 git show HEAD 2>err &&
 	test_grep ! "git replace" err
 '
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c6e9b33e44e..fc48cb4b0ad 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -489,9 +489,9 @@ test_expect_success '--convert-graft-file' '
 	printf "%s\n%s %s\n\n# comment\n%s\n" \
 		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
 		>.git/info/grafts &&
-	git status 2>stderr &&
+	GIT_ADVICE=1 git status 2>stderr &&
 	test_grep "hint:.*grafts is deprecated" stderr &&
-	git replace --convert-graft-file 2>stderr &&
+	GIT_ADVICE=1 git replace --convert-graft-file 2>stderr &&
 	test_grep ! "hint:.*grafts is deprecated" stderr &&
 	test_path_is_missing .git/info/grafts &&
 
@@ -502,7 +502,7 @@ test_expect_success '--convert-graft-file' '
 	: create invalid graft file and verify that it is not deleted &&
 	test_when_finished "rm -f .git/info/grafts" &&
 	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
-	test_must_fail git replace --convert-graft-file 2>err &&
+	test_env GIT_ADVICE=1 test_must_fail git replace --convert-graft-file 2>err &&
 	test_grep "$EMPTY_BLOB $EMPTY_TREE" err &&
 	test_grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
 '
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index ccc620477d4..7c9f5b623f1 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -104,7 +104,7 @@ test_expect_success 'will not overwrite unstaged changes in renamed file' '
 	cp important other.c &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test_must_fail git merge c1a >out 2>err &&
+		test_env GIT_ADVICE=1 test_must_fail git merge c1a >out 2>err &&
 		test_grep "would be overwritten by merge" err &&
 		test_cmp important other.c &&
 		test_path_is_missing .git/MERGE_HEAD
@@ -140,7 +140,7 @@ test_expect_success 'will not overwrite untracked file in leading path' '
 	rm -rf sub &&
 	cp important sub &&
 	cp important sub2 &&
-	test_must_fail git merge sub 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git merge sub 2>out &&
 	test_cmp out expect &&
 	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important sub &&
@@ -175,7 +175,7 @@ test_expect_success 'will not overwrite untracked file on unborn branch' '
 	git rm -fr . &&
 	git checkout --orphan new &&
 	cp important c0.c &&
-	test_must_fail git merge c0 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git merge c0 2>out &&
 	test_cmp out expect
 '
 
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 7a3f1cb27c1..9265cebca75 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -113,11 +113,11 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	 git checkout -b test-nonforward-a b &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
-		test_must_fail git merge c 2>actual &&
+		test_env GIT_ADVICE=1 test_must_fail git merge c 2>actual &&
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
 		grep "$sub_expect" actual
 	  else
-		test_must_fail git merge c 2> actual
+		test_env GIT_ADVICE=1 test_must_fail git merge c 2> actual
 	  fi)
 '
 
@@ -154,11 +154,11 @@ test_expect_success 'merging should conflict for non fast-forward (resolution ex
 	  git rev-parse --short sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
-		test_must_fail git merge c >actual 2>sub-actual &&
+		test_env GIT_ADVICE=1 test_must_fail git merge c >actual 2>sub-actual &&
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
 		grep "$sub_expect" sub-actual
 	  else
-		test_must_fail git merge c 2> actual
+		test_env GIT_ADVICE=1 test_must_fail git merge c 2> actual
 	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
 	 git reset --hard)
@@ -181,11 +181,11 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 ) &&
 	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	 then
-		test_must_fail git merge c >actual 2>sub-actual &&
+		test_env GIT_ADVICE=1 test_must_fail git merge c >actual 2>sub-actual &&
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
 		grep "$sub_expect" sub-actual
 	 else
-		test_must_fail git merge c 2> actual
+		test_env GIT_ADVICE=1 test_must_fail git merge c 2> actual
 	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
@@ -227,7 +227,7 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git merge f 2>actual &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     then
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
@@ -535,7 +535,7 @@ test_expect_success 'merging should fail with no merge base' '
 	git checkout -b b init &&
 	git add sub &&
 	git commit -m "b" &&
-	test_must_fail git merge a 2>actual &&
+	test_env GIT_ADVICE=1 test_must_fail git merge a 2>actual &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     then
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short HEAD^1)" &&
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 0cbec57cdab..dcc7d45ac75 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -40,13 +40,13 @@ Aborting
 EOF
 
 test_expect_success 'untracked files overwritten by merge (fast and non-fast forward)' '
-	test_must_fail git merge branch 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git merge branch 2>out &&
 	test_cmp out expect &&
 	git commit --allow-empty -m empty &&
 	(
 		GIT_MERGE_VERBOSITY=0 &&
 		export GIT_MERGE_VERBOSITY &&
-		test_must_fail git merge branch 2>out2
+		test_env GIT_ADVICE=1 test_must_fail git merge branch 2>out2
 	) &&
 	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>expect &&
 	test_cmp out2 expect &&
@@ -69,7 +69,7 @@ test_expect_success 'untracked files or local changes ovewritten by merge' '
 	git add two &&
 	git add three &&
 	git add four &&
-	test_must_fail git merge branch 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git merge branch 2>out &&
 	test_cmp out expect
 '
 
@@ -91,7 +91,7 @@ test_expect_success 'cannot switch branches because of local changes' '
 	git checkout main &&
 	echo uno >rep/one &&
 	echo dos >rep/two &&
-	test_must_fail git checkout branch 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git checkout branch 2>out &&
 	test_cmp out expect
 '
 
@@ -105,7 +105,7 @@ EOF
 
 test_expect_success 'not uptodate file porcelain checkout error' '
 	git add rep/one rep/two &&
-	test_must_fail git checkout branch 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git checkout branch 2>out &&
 	test_cmp out expect
 '
 
@@ -136,7 +136,7 @@ test_expect_success 'not_uptodate_dir porcelain checkout error' '
 	git checkout main &&
 	>rep/untracked-file &&
 	>rep2/untracked-file &&
-	test_must_fail git checkout branch 2>out &&
+	test_env GIT_ADVICE=1 test_must_fail git checkout branch 2>out &&
 	test_cmp out ../expect
 '
 
-- 
gitgitgadget

