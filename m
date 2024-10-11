Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419327702
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728691211; cv=none; b=RUdCubTv9pWUOGX7yI+tx2Lyoxam9uUPhxP5nm3EOV3n1pD+zvIPY3dIzopl9StMVtSR7OH0QEPEn+BkEtgZc/CM9ZD+p8puTFyfNKW2vJP/nGVKuLvsN09L4zJf+rjRsoK55OXHZA8XEg4dzr/meL5eL6KJzKDJ+WLePZElpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728691211; c=relaxed/simple;
	bh=50XNwk8GZX/N6Ae1bVwNicTnxkBQsGZxeoN0OVfCHkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exTepWhj2Xb5CdDTDxgTEu3aid2WIeYSR8UTC8StaY8dS08tjo4B7o1srW4Kq6DzV9QmM3sDWc1GdPtXbukSMsIco7dJFuQhU1B4O54+Ny2bKfz9qt8pANw/SOb0ijG3zSleX901uaazQCMsZyBwuQ8N533UAA1a0y6FFFz2z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEBM4XJ8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEBM4XJ8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4311ae6426aso14161985e9.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728691207; x=1729296007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvKlqi6NPU9W2r4Mze6qUN5Ue5CsPaOFUxOXVN/6uX0=;
        b=TEBM4XJ8TY0aHxUWIZE1a/rndYUEpOkdKos1v+BbP5HKlzaNVdSofJtPABmS1yKIvH
         XEOe69YItr1Y1eRzorGNqiJOsz+WW0jZYnbQKMtbc6uyi0DHysUTlpWnoWQ7Gb0mPVxy
         EVls7F3xwr/jvTBJ2TUEpDVagSUtundHHdS1y94YlHx3MVeoOEJl7QZtCVcjKt3VUcdL
         S82b4pZ2Fyw/XxyQb+uYeArdP5tp7Rjhqhn8dkmdkiu+RA1jnfwQv4RlKLqqXHx2sVSO
         Q5m1ZEy/u9/5f32U9fx6W7fuEI8JWKRdrkVHsnIzBMi7SSMKAXaXHRkxsBrUquGB2+cb
         uqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728691207; x=1729296007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvKlqi6NPU9W2r4Mze6qUN5Ue5CsPaOFUxOXVN/6uX0=;
        b=IuCaCdX5JLbI7Y68QJRjpQnyGLR75HaSTJ4Z/WC66GyBV9TORdntAKzBXuSy+EKC+f
         miKvIIOsCUuZWszrDUhzyLbcsPT0Qy0+XW8dJw2FPpA4jlIUOzdw7QJO7MMOpJtBm0Re
         mF8qKLcUxOUIjFC4ksDq4XWzC/1Zh7Sr9RUBxQ6HpnuZRIXki7f4Ck5J7JFlAHCFCode
         O47uWWTbvBo8PDbfFlAi44eYlXXXg+/JtHnda/uEPRhooCKDFLAQia9ukP0evlb5FyNn
         K9uEPaNiYde476zUfP4m6vHEKpzTiXjG6mVNNAnYJgAwph9Lr/8F6roMIaX+my7P9xqK
         UlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW1Iuqjsah7PIAk+4rT9AJGtBhomXn3qXcddIjpgTl5hwp/MRJFz6jb4aWNKY73XJL6O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0XS/+Ei5Fr/x4oxdR3/iSXoKt9H7as813Ugjv1t/lPygUTe/
	maYwjsaszbm1P8nQdqq+5hnDZONaAYY1M26kkgOxf5CWGum+gg==
X-Google-Smtp-Source: AGHT+IGpUf79/loxLfwElnybG4Zy9sRlumrjPRzWsdSNYVcYyHD3YOOXkGMOEr2NDSzndHUibxO/yQ==
X-Received: by 2002:a05:600c:1c19:b0:431:1513:34a5 with SMTP id 5b1f17b1804b1-4311df474a0mr30840195e9.23.1728691206905;
        Fri, 11 Oct 2024 17:00:06 -0700 (PDT)
Received: from zihco-Latitude-7390-2-in-1.. ([105.113.33.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d4b2780c1sm5012449f8f.0.2024.10.11.17.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 17:00:06 -0700 (PDT)
From: chizobajames21@gmail.com
To: gitster@pobox.com
Cc: chizobajames21@gmail.com,
	git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	sunshine@sunshineco.com
Subject: [Outreachy][PATCH v4] t6050: avoid pipes with upstream Git commands
Date: Sat, 12 Oct 2024 00:59:59 +0100
Message-Id: <20241011235959.596136-1-chizobajames21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xmqqzfnaedh6.fsf@gitster.g>
References: <xmqqzfnaedh6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chizoba ODINAKA <chizobajames21@gmail.com>

In pipes, the exit code of a chain of commands is determined by
the final command. In order not to miss the exit code of a failed
Git command, avoid pipes instead write output of Git commands
into a file.
For better debugging experience, instances of "grep" were changed
to "test_grep". "test_grep" provides more context in case of a
failed "grep".

Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
---
Changes in v4:
- Correct the subject
- fixed some ommitted output option in sorts that where writing to
  stdout

Range-diff against v3:
1:  3ef388e9aa ! 1:  28cab4c752 t6050: avoid pipes with downstream Git commands
    @@ Metadata
     Author: Chizoba ODINAKA <chizobajames21@gmail.com>
     
      ## Commit message ##
    -    t6050: avoid pipes with downstream Git commands
    +    t6050: avoid pipes with upstream Git commands
     
         In pipes, the exit code of a chain of commands is determined by
         the final command. In order not to miss the exit code of a failed
    @@ Commit message
         failed "grep".
     
         Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
    +    Changes in v4:
    +    - Correct the subject
    +    - fixed some ommitted output option in sorts that where writing to
    +      stdout
     
      ## t/t6050-replace.sh ##
     @@ t/t6050-replace.sh: test_expect_success 'set up buggy branch' '
    @@ t/t6050-replace.sh: test_expect_success 'test --format medium' '
      	} | sort >expected &&
     -	git replace -l --format medium | sort >actual &&
     +	git replace -l --format medium >actual &&
    -+	sort actual &&
    ++	sort actual -o actual &&
      	test_cmp expected actual
      '
      
    @@ t/t6050-replace.sh: test_expect_success 'test --format long' '
      	} | sort >expected &&
     -	git replace --format=long | sort >actual &&
     +	git replace --format=long >actual &&
    -+	sort actual &&
    ++	sort actual -o actual &&
      	test_cmp expected actual
      '
      

 t/t6050-replace.sh | 133 +++++++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 47 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d7702fc756..018d672c1b 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -98,30 +98,42 @@ test_expect_success 'set up buggy branch' '
 '
 
 test_expect_success 'replace the author' '
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $R | grep "author O Thor" &&
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
+	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $R >actual &&
+	test_grep "author O Thor" actual &&
 	git update-ref refs/replace/$HASH2 $R &&
-	git show HEAD~5 | grep "O Thor" &&
-	git show $HASH2 | grep "O Thor"
+	git show HEAD~5 >actual &&
+	test_grep "O Thor" actual &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual
 '
 
 test_expect_success 'test --no-replace-objects option' '
-	git cat-file commit $HASH2 | grep "author O Thor" &&
-	git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
-	git show $HASH2 | grep "O Thor" &&
-	git --no-replace-objects show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author O Thor" actual &&
+	git --no-replace-objects cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
+	git --no-replace-objects show $HASH2 >actual &&
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
-	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
-	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
+	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor"  actual &&
+	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 >actual &&
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'test core.usereplacerefs config option' '
 	test_config core.usereplacerefs false &&
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	git show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
+	git show $HASH2 >actual &&
+	test_grep "A U Thor" actual
 '
 
 cat >tag.sig <<EOF
@@ -148,14 +160,18 @@ test_expect_success 'repack, clone and fetch work' '
 	git clone --no-hardlinks . clone_dir &&
 	(
 		cd clone_dir &&
-		git show HEAD~5 | grep "A U Thor" &&
-		git show $HASH2 | grep "A U Thor" &&
+		git show HEAD~5 >actual &&
+		test_grep "A U Thor" actual &&
+		git show $HASH2 >actual &&
+		test_grep "A U Thor" actual &&
 		git cat-file commit $R &&
 		git repack -a -d &&
 		test_must_fail git cat-file commit $R &&
 		git fetch ../ "refs/replace/*:refs/replace/*" &&
-		git show HEAD~5 | grep "O Thor" &&
-		git show $HASH2 | grep "O Thor" &&
+		git show HEAD~5 >actual &&
+		test_grep "O Thor" actual &&
+		git show $HASH2 >actual &&
+		test_grep "O Thor" actual &&
 		git cat-file commit $R
 	)
 '
@@ -169,13 +185,15 @@ test_expect_success '"git replace" listing and deleting' '
 	test_must_fail git replace --delete &&
 	test_must_fail git replace -l -d $HASH2 &&
 	git replace -d $HASH2 &&
-	git show $HASH2 | grep "A U Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "A U Thor" actual &&
 	test -z "$(git replace -l)"
 '
 
 test_expect_success '"git replace" replacing' '
 	git replace $HASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace -f &&
@@ -186,7 +204,8 @@ test_expect_success '"git replace" resolves sha1' '
 	SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
 	git replace -d $SHORTHASH2 &&
 	git replace $SHORTHASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace --force &&
@@ -209,10 +228,12 @@ test_expect_success '"git replace" resolves sha1' '
 #
 test_expect_success 'create parallel branch without the bug' '
 	git replace -d $HASH2 &&
-	git show $HASH2 | grep "A U Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "A U Thor" actual &&
 	git checkout $HASH1 &&
 	git cherry-pick $HASH2 &&
-	git show $HASH5 | git apply &&
+	git show $HASH5 >actual &&
+	git apply actual &&
 	git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
 	PARA2=$(git rev-parse --verify HEAD) &&
 	git cherry-pick $HASH3 &&
@@ -225,7 +246,8 @@ test_expect_success 'create parallel branch without the bug' '
 	git checkout main &&
 	cur=$(git rev-parse --verify HEAD) &&
 	test "$cur" = "$HASH7" &&
-	git log --pretty=oneline | grep $PARA2 &&
+	git log --pretty=oneline >actual &&
+	test_grep $PARA2 actual &&
 	git remote add cloned ./clone_dir
 '
 
@@ -234,23 +256,30 @@ test_expect_success 'push to cloned repo' '
 	(
 		cd clone_dir &&
 		git checkout parallel &&
-		git log --pretty=oneline | grep $PARA2
+		git log --pretty=oneline >actual &&
+		test_grep $PARA2 actual
 	)
 '
 
 test_expect_success 'push branch with replacement' '
-	git cat-file commit $PARA3 | grep "author A U Thor" &&
-	S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $S | grep "author O Thor" &&
+	git cat-file commit $PARA3 >actual &&
+	test_grep "author A U Thor" actual &&
+	S=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $S >actual &&
+	test_grep "author O Thor" actual &&
 	git replace $PARA3 $S &&
-	git show $HASH6~2 | grep "O Thor" &&
-	git show $PARA3 | grep "O Thor" &&
+	git show $HASH6~2 >actual &&
+	test_grep "O Thor" actual &&
+	git show $PARA3 >actual &&
+	test_grep "O Thor" actual &&
 	git push cloned $HASH6^:refs/heads/parallel2 &&
 	(
 		cd clone_dir &&
 		git checkout parallel2 &&
-		git log --pretty=oneline | grep $PARA3 &&
-		git show $PARA3 | grep "A U Thor"
+		git log --pretty=oneline >actual &&
+		test_grep $PARA3 actual &&
+		git show $PARA3 >actual &&
+		test_grep "A U Thor" actual
 	)
 '
 
@@ -260,14 +289,14 @@ test_expect_success 'fetch branch with replacement' '
 		cd clone_dir &&
 		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
 		git log --pretty=oneline parallel3 >output.txt &&
-		! grep $PARA3 output.txt &&
+		test_grep ! $PARA3 output.txt &&
 		git show $PARA3 >para3.txt &&
-		grep "A U Thor" para3.txt &&
+		test_grep "A U Thor" para3.txt &&
 		git fetch origin "refs/replace/*:refs/replace/*" &&
 		git log --pretty=oneline parallel3 >output.txt &&
-		grep $PARA3 output.txt &&
+		test_grep $PARA3 output.txt &&
 		git show $PARA3 >para3.txt &&
-		grep "O Thor" para3.txt
+		test_grep "O Thor" para3.txt
 	)
 '
 
@@ -284,8 +313,8 @@ test_expect_success 'bisect and replacements' '
 '
 
 test_expect_success 'index-pack and replacements' '
-	git --no-replace-objects rev-list --objects HEAD |
-	git --no-replace-objects pack-objects test- &&
+	git --no-replace-objects rev-list --objects HEAD >actual &&
+	git --no-replace-objects pack-objects test- <actual &&
 	git index-pack test-*.pack
 '
 
@@ -319,7 +348,8 @@ test_expect_success '-f option bypasses the type check' '
 '
 
 test_expect_success 'git cat-file --batch works on replace objects' '
-	git replace | grep $PARA3 &&
+	git replace >actual &&
+	test_grep $PARA3 actual &&
 	echo $PARA3 | git cat-file --batch
 '
 
@@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
 		echo "$PARA3 -> $S" &&
 		echo "$MYTAG -> $HASH1"
 	} | sort >expected &&
-	git replace -l --format medium | sort >actual &&
+	git replace -l --format medium >actual &&
+	sort actual -o actual &&
 	test_cmp expected actual
 '
 
@@ -356,7 +387,8 @@ test_expect_success 'test --format long' '
 		echo "$PARA3 (commit) -> $S (commit)" &&
 		echo "$MYTAG (tag) -> $HASH1 (commit)"
 	} | sort >expected &&
-	git replace --format=long | sort >actual &&
+	git replace --format=long >actual &&
+	sort actual -o actual &&
 	test_cmp expected actual
 '
 
@@ -374,12 +406,16 @@ test_expect_success 'setup fake editors' '
 test_expect_success '--edit with and without already replaced object' '
 	test_must_fail env GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --force --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor" &&
+	git replace -l >actual &&
+	test_grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual &&
+	test_grep "A fake Thor" actual &&
 	git replace -d "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor"
+	git replace -l >actual &&
+	test_grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual &&
+	test_grep "A fake Thor" actual
 '
 
 test_expect_success '--edit and change nothing or command failed' '
@@ -387,8 +423,10 @@ test_expect_success '--edit and change nothing or command failed' '
 	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
 	test_must_fail env GIT_EDITOR="./failingfakeeditor" git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor"
+	git replace -l >actual &&
+	test_grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual &&
+	test_grep "A fake Thor" actual
 '
 
 test_expect_success 'replace ref cleanup' '
@@ -468,7 +506,8 @@ test_expect_success GPG 'set up a merge commit with a mergetag' '
 	git checkout main &&
 	git merge -s ours test_tag &&
 	HASH10=$(git rev-parse --verify HEAD) &&
-	git cat-file commit $HASH10 | grep "^mergetag object"
+	git cat-file commit $HASH10 >actual &&
+	test_grep "^mergetag object" actual
 '
 
 test_expect_success GPG '--graft on a commit with a mergetag' '
-- 
2.34.1

