Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E338DF2
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404495; cv=none; b=Q2YGryvSG4MbHsYSHX92c9H8hXs1bzhHmaIQxlfj4uLVbPEmU5gkPjBZJJtpP6rRTI0ohFq85ZgyIh6AglVaAuii1tzVchUi9Qgmp4LW8R+ZagS0Q56D0sm6ATv7vEVUrGtPAwmMtcxsj7h5pMaPkLqGu+EW9+fSvF/yOGcy7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404495; c=relaxed/simple;
	bh=ZjL+NnSs+/H4AA0xiJVhh7iREzKi4hxkt4164LivxG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVvmBfvQFLnlXKC/Lul7vwapv5m+hWT1QIvepfAQosJMOfSZOG9Fkz/ScjNFEQvkMkv4G59xJN/M/HPiTxChLoxEl6DNl0KWHRzeKQ1M2W5gXI6NlL5gj+98fwvlxtZShdFqSq9/h2Sa10UK5nFoqbE5kiwyiHA4z1VZmK8DlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVEndunA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVEndunA"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so8568350a12.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728404492; x=1729009292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzghPiIdJ3OMTR1sbcykZgjJaY4OKTA4vEy2kV89SDE=;
        b=BVEndunAM7ha40LsEKarnkBF5EDuWwn+2gBQ5jVGakh6ROd+CEgsZSot5FV/aJNjiD
         xMsqR38wCB7SnXJjiNopZlPRWgOMKmE0kMDSxG1U/jRmM3/miNhZA0rL2H/ylPRseEkg
         pOA3GFOGm4RO2i+CEf0noWAhL9sk8Mq4LAyZvywwz0z+DuLE7J4qUgFcSMVfxRrq1LNM
         xHAIo1uDjojA9aKR7W945SchBipR+OInQKiQgDf52k+LQL2+L/QHEBWvh2d8C2E3PNIe
         UtPH4Zay+bjMZrBPYRNdqJNvmk/xtlchTaL/twpB1Ra+a0JHXen9ONGbrEtCG1mcIni/
         il0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728404492; x=1729009292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzghPiIdJ3OMTR1sbcykZgjJaY4OKTA4vEy2kV89SDE=;
        b=TV4N+KXVwPM7pzfhXmfSnaVXd6zagEe/WdCI9JUmclJ3SoiFZpOyl/xaj/yzzNHQrL
         DhcC9tYPfABMmr+znRfjTnAbw4uGPO83hbe8ByECtWYBYHyBqMj2omTRa7H/KYPwxlCc
         Vkn5Vd3jpYzBF7LIsrOQ3qarOLlg+lvGM0qyEeO5G3lGdOtts3QEe0uKy/mypzRL9rMd
         PxpGrnTU0U6KQhx7rKbozwf+fU8/oJS+jQG2kxDxFTq64KkU/QNRCaiTOVOkQlVde+vv
         ZxVrka1b6vyZWYBCTtlmH/FiR+4ziHTJTouPMOLMSw0cGiM/dD5Wt9IqtsL+c0689y1q
         iahA==
X-Gm-Message-State: AOJu0YyqmEtAYliEEat1NOaq+nTVp0X1Bh0S/5wb88KhETPs5DB+HbRO
	jnVYgzjJ9YXYos5p1RuGmG8rbtECQ6Q2XxGA8Hp9AoV+BxoZAyakDO5rk1D/+JM=
X-Google-Smtp-Source: AGHT+IEDSHRhF2q8mJPmEIgA56MoY4VOwSLIt03yCiSjn8Z8m9ZwRyulkhuMTVEva9ZFxLSZRrE4gA==
X-Received: by 2002:a05:6402:51c9:b0:5c7:1911:f134 with SMTP id 4fb4d7f45d1cf-5c8d2e0ff86mr11792756a12.9.1728404491123;
        Tue, 08 Oct 2024 09:21:31 -0700 (PDT)
Received: from zihco-Latitude-7390-2-in-1.. ([197.210.35.67])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05ad8cfsm4482877a12.37.2024.10.08.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:21:30 -0700 (PDT)
From: chizobajames21@gmail.com
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,
	ps@pks.im,
	Chizoba ODINAKA <chizobajames21@gmail.com>
Subject: [Outreachy][PATCH] t6050: avoid pipes in git related commands
Date: Tue,  8 Oct 2024 17:21:17 +0100
Message-Id: <20241008162117.6452-1-chizobajames21@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chizoba ODINAKA <chizobajames21@gmail.com>

In pipes, the exit code of a chain of commands is determined by
the downstream command. For more accurate info on exit code tests,
write output of upstreams into a file.

Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
---
 t/t6050-replace.sh | 86 +++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d7702fc756..6b9811ed67 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -98,30 +98,30 @@ test_expect_success 'set up buggy branch' '
 '
 
 test_expect_success 'replace the author' '
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $R | grep "author O Thor" &&
+	git cat-file commit $HASH2 >actual && grep "author A U Thor" actual &&
+	R=$(git cat-file commit $HASH2 >actual && sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $R >actual && grep "author O Thor" actual &&
 	git update-ref refs/replace/$HASH2 $R &&
-	git show HEAD~5 | grep "O Thor" &&
-	git show $HASH2 | grep "O Thor"
+	git show HEAD~5 >actual && grep "O Thor" actual &&
+	git show $HASH2 >actual && grep "O Thor" actual
 '
 
 test_expect_success 'test --no-replace-objects option' '
-	git cat-file commit $HASH2 | grep "author O Thor" &&
-	git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
-	git show $HASH2 | grep "O Thor" &&
-	git --no-replace-objects show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 >actual && grep "author O Thor" actual &&
+	git --no-replace-objects cat-file commit $HASH2 >actual && grep "author A U Thor" actual &&
+	git show $HASH2 >actual && grep "O Thor" actual &&
+	git --no-replace-objects show $HASH2 >actual && grep "A U Thor" actual
 '
 
 test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
-	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
-	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
+	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 >actual && grep "author A U Thor"  actual &&
+	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 >actual && grep "A U Thor" actual
 '
 
 test_expect_success 'test core.usereplacerefs config option' '
 	test_config core.usereplacerefs false &&
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	git show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 >actual && grep "author A U Thor" actual &&
+	git show $HASH2 >actual && grep "A U Thor" actual
 '
 
 cat >tag.sig <<EOF
@@ -148,14 +148,14 @@ test_expect_success 'repack, clone and fetch work' '
 	git clone --no-hardlinks . clone_dir &&
 	(
 		cd clone_dir &&
-		git show HEAD~5 | grep "A U Thor" &&
-		git show $HASH2 | grep "A U Thor" &&
+		git show HEAD~5 >actual && grep "A U Thor" actual &&
+		git show $HASH2 >actual && grep "A U Thor" actual &&
 		git cat-file commit $R &&
 		git repack -a -d &&
 		test_must_fail git cat-file commit $R &&
 		git fetch ../ "refs/replace/*:refs/replace/*" &&
-		git show HEAD~5 | grep "O Thor" &&
-		git show $HASH2 | grep "O Thor" &&
+		git show HEAD~5 >actual && grep "O Thor" actual &&
+		git show $HASH2 >actual && grep "O Thor" actual &&
 		git cat-file commit $R
 	)
 '
@@ -169,13 +169,13 @@ test_expect_success '"git replace" listing and deleting' '
 	test_must_fail git replace --delete &&
 	test_must_fail git replace -l -d $HASH2 &&
 	git replace -d $HASH2 &&
-	git show $HASH2 | grep "A U Thor" &&
+	git show $HASH2 >actual && grep "A U Thor" actual &&
 	test -z "$(git replace -l)"
 '
 
 test_expect_success '"git replace" replacing' '
 	git replace $HASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual && grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace -f &&
@@ -186,7 +186,7 @@ test_expect_success '"git replace" resolves sha1' '
 	SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
 	git replace -d $SHORTHASH2 &&
 	git replace $SHORTHASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual && grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace --force &&
@@ -209,10 +209,10 @@ test_expect_success '"git replace" resolves sha1' '
 #
 test_expect_success 'create parallel branch without the bug' '
 	git replace -d $HASH2 &&
-	git show $HASH2 | grep "A U Thor" &&
+	git show $HASH2 >actual && grep "A U Thor" actual &&
 	git checkout $HASH1 &&
 	git cherry-pick $HASH2 &&
-	git show $HASH5 | git apply &&
+	git show $HASH5 >actual && git apply actual &&
 	git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
 	PARA2=$(git rev-parse --verify HEAD) &&
 	git cherry-pick $HASH3 &&
@@ -225,7 +225,7 @@ test_expect_success 'create parallel branch without the bug' '
 	git checkout main &&
 	cur=$(git rev-parse --verify HEAD) &&
 	test "$cur" = "$HASH7" &&
-	git log --pretty=oneline | grep $PARA2 &&
+	git log --pretty=oneline >actual && grep $PARA2 actual &&
 	git remote add cloned ./clone_dir
 '
 
@@ -234,23 +234,23 @@ test_expect_success 'push to cloned repo' '
 	(
 		cd clone_dir &&
 		git checkout parallel &&
-		git log --pretty=oneline | grep $PARA2
+		git log --pretty=oneline >actual && grep $PARA2 actual
 	)
 '
 
 test_expect_success 'push branch with replacement' '
-	git cat-file commit $PARA3 | grep "author A U Thor" &&
-	S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $S | grep "author O Thor" &&
+	git cat-file commit $PARA3 >actual && grep "author A U Thor" actual &&
+	S=$(git cat-file commit $PARA3 >actual && sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $S >actual && grep "author O Thor" actual &&
 	git replace $PARA3 $S &&
-	git show $HASH6~2 | grep "O Thor" &&
-	git show $PARA3 | grep "O Thor" &&
+	git show $HASH6~2 >actual && grep "O Thor" actual &&
+	git show $PARA3 >actual && grep "O Thor" actual &&
 	git push cloned $HASH6^:refs/heads/parallel2 &&
 	(
 		cd clone_dir &&
 		git checkout parallel2 &&
-		git log --pretty=oneline | grep $PARA3 &&
-		git show $PARA3 | grep "A U Thor"
+		git log --pretty=oneline >actual && grep $PARA3 actual &&
+		git show $PARA3 >actual && grep "A U Thor" actual
 	)
 '
 
@@ -284,8 +284,8 @@ test_expect_success 'bisect and replacements' '
 '
 
 test_expect_success 'index-pack and replacements' '
-	git --no-replace-objects rev-list --objects HEAD |
-	git --no-replace-objects pack-objects test- &&
+	git --no-replace-objects rev-list --objects HEAD >actual &&
+	git --no-replace-objects pack-objects test- <actual &&
 	git index-pack test-*.pack
 '
 
@@ -319,7 +319,7 @@ test_expect_success '-f option bypasses the type check' '
 '
 
 test_expect_success 'git cat-file --batch works on replace objects' '
-	git replace | grep $PARA3 &&
+	git replace >actual && grep $PARA3 actual &&
 	echo $PARA3 | git cat-file --batch
 '
 
@@ -344,7 +344,7 @@ test_expect_success 'test --format medium' '
 		echo "$PARA3 -> $S" &&
 		echo "$MYTAG -> $HASH1"
 	} | sort >expected &&
-	git replace -l --format medium | sort >actual &&
+	git replace -l --format medium >actual && sort actual &&
 	test_cmp expected actual
 '
 
@@ -356,7 +356,7 @@ test_expect_success 'test --format long' '
 		echo "$PARA3 (commit) -> $S (commit)" &&
 		echo "$MYTAG (tag) -> $HASH1 (commit)"
 	} | sort >expected &&
-	git replace --format=long | sort >actual &&
+	git replace --format=long >actual && sort actual &&
 	test_cmp expected actual
 '
 
@@ -374,12 +374,12 @@ test_expect_success 'setup fake editors' '
 test_expect_success '--edit with and without already replaced object' '
 	test_must_fail env GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --force --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor" &&
+	git replace -l >actual && grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual && grep "A fake Thor" actual &&
 	git replace -d "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor"
+	git replace -l >actual && grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual && grep "A fake Thor" actual
 '
 
 test_expect_success '--edit and change nothing or command failed' '
@@ -387,8 +387,8 @@ test_expect_success '--edit and change nothing or command failed' '
 	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
 	test_must_fail env GIT_EDITOR="./failingfakeeditor" git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor"
+	git replace -l >actual && grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual && grep "A fake Thor" actual
 '
 
 test_expect_success 'replace ref cleanup' '
@@ -468,7 +468,7 @@ test_expect_success GPG 'set up a merge commit with a mergetag' '
 	git checkout main &&
 	git merge -s ours test_tag &&
 	HASH10=$(git rev-parse --verify HEAD) &&
-	git cat-file commit $HASH10 | grep "^mergetag object"
+	git cat-file commit $HASH10 >actual && grep "^mergetag object" actual
 '
 
 test_expect_success GPG '--graft on a commit with a mergetag' '
-- 
2.34.1

