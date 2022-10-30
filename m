Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93102C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 17:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ3RUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ3RUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 13:20:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B435F5F
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 10:20:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bs21so13023682wrb.4
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SImqz4u+QUihmYGK4siuKzhJ0G/oj17eiBF2Z5pQW+Q=;
        b=jW6B3DnAJT/0JzZ6GdvnAeJ/DwJtZhwUTcGUfKVjW1BBxPwc0pWk+Cdi4uFtXtkK6V
         mEhZ8+Yy3FW13rTxWjXZXn5eNhIlNz7YxMj3TeJLHYUXCceVca33hJjS3wPeoNIeWunn
         xKPxJSAaKZ2YUXyHwYk4LCcRjgRwMFdszaq4U5ScON0ihxHQVA6wVoRG05eelOB154dv
         Dp4H3rXk+H99AMgGP5cLAyWy12GwC4ZCRoLv2A6XOHPokm89nzBBipmhozkMa3tsIG+n
         7XB5oYqO/A7Lqjw5w3SQkQm/CDercaVLHisNmgjWJd6Ado6mAK0jl1yn6bUVr15R8X60
         UAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SImqz4u+QUihmYGK4siuKzhJ0G/oj17eiBF2Z5pQW+Q=;
        b=j/ge1iJuQxhfkP34nUT4YuSC6dkH9vBHUFUGptgcxS9bqXpimNrhkxIVvq0AjPD0YM
         EbpBA9tqfqQ+NSwtrbrzSM2mmvsPp35xXbOf50gDimThnp0XlMLIjYeHgL+nB1m4rjz6
         CVOqO/7tEOOzaus9jfRjmIgNCuBqJWxOoJtWHwaIOiFOetd5se95J0JNUnAiRVP4T57d
         qyDcAACjEuaDdA0q1Tb7mM5yELlMLHoq/bAe+So46meLtV6/PAgkWt+KGW8GyU1AyiZJ
         xoN7wu5/rJq+vF1CsPEXrbDJIQU9bdHro3bUFT19AHGEAKxA/y9GFssbFVSoTYK6tIMy
         Z0mA==
X-Gm-Message-State: ACrzQf0MJmCeYF5nT3NdcLKwsJxBY9MygY+Q8X9MMbrH7n2LwYWUHhaX
        7yvhfdMkQ3HN43q6Q1m90KCv3ycEhsE=
X-Google-Smtp-Source: AMsMyM5IRvjAaNxsBUWAW65t++TT/Tq2puz5CSgGMgjBhgQgI1yjzRL0EqnNVvZ/6esJUphoggl26w==
X-Received: by 2002:a05:6000:79c:b0:236:6f2e:301e with SMTP id bu28-20020a056000079c00b002366f2e301emr5493153wrb.458.1667150443023;
        Sun, 30 Oct 2022 10:20:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003c6edc05159sm5012200wms.1.2022.10.30.10.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:20:42 -0700 (PDT)
Message-Id: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
From:   "Debra Obondo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Oct 2022 17:20:41 +0000
Subject: [PATCH] t7001-mv.sh:modernizing test script using function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Debra Obondo <debraobondo@gmail.com>,
        Debra Obondo <debraobondo@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Debra Obondo <debraobondo@gmail.com>

Test script to verify the presence/absence of files, paths, directories,
symlinks and other features in 'git mv' command are using the command
format:

'test (-e|f|d|h|...)'

Replace them with helper functions of format:

'test_path_is_*'

Signed-off-by: Debra Obondo <debraobondo@gmail.com>
---
    [PATCH] [OUTREACHY] t7001-mv.sh : Use test_path_is_* functions in test
    script
    
    Older test scripts use the command 'test -' to verify the presence or
    absence of features such as files, directories and symbolic links. This
    however requires slightly complicated uses, such as 'test ! -f '. The
    helper functions 'test_path_is_' located in t/test-lib-functions.sh have
    taken into account all scenarios of the 'test -*' to reduce errors. This
    was a microproject to replace them with the helper functions.
    
    Test script to verify the presence/absence of files, paths,
    directories,symboliclinks and many other features in mv command are
    using the command format
    
    'test -(e|f|s|h|...).
    
    Replace them with helper functions of format
    
    'test_path_is_*'
    
    Signed-off-by: Debra Obondo debraobondo@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1372%2Ffobiasic07%2Ft7001-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1372/fobiasic07/t7001-v1
Pull-Request: https://github.com/git/git/pull/1372

 t/t7001-mv.sh | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 8c37bceb336..aa97a2f8e1c 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -60,8 +60,8 @@ test_expect_success 'checking the commit' '
 
 test_expect_success 'mv --dry-run does not move file' '
 	git mv -n path0/COPYING MOVED &&
-	test -f path0/COPYING &&
-	test ! -f MOVED
+	test_path_is_file path0/COPYING &&
+	! test_path_is_file MOVED
 '
 
 test_expect_success 'checking -k on non-existing file' '
@@ -71,25 +71,25 @@ test_expect_success 'checking -k on non-existing file' '
 test_expect_success 'checking -k on untracked file' '
 	>untracked1 &&
 	git mv -k untracked1 path0 &&
-	test -f untracked1 &&
-	test ! -f path0/untracked1
+	test_path_is_file untracked1 &&
+	! test_path_is_file path0/untracked1
 '
 
 test_expect_success 'checking -k on multiple untracked files' '
 	>untracked2 &&
 	git mv -k untracked1 untracked2 path0 &&
-	test -f untracked1 &&
-	test -f untracked2 &&
-	test ! -f path0/untracked1 &&
-	test ! -f path0/untracked2
+	test_path_is_file untracked1 &&
+	test_path_is_file untracked2 &&
+	! test_path_is_file path0/untracked1 &&
+	! test_path_is_file path0/untracked2
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
 	>path0/untracked1 &&
 	test_must_fail git mv -f untracked1 path0 &&
-	test ! -f .git/index.lock &&
-	test -f untracked1 &&
-	test -f path0/untracked1
+	! test_path_is_file .git/index.lock &&
+	test_path_is_file untracked1 &&
+	test_path_is_file path0/untracked1
 '
 
 # clean up the mess in case bad things happen
@@ -215,8 +215,8 @@ test_expect_success 'absolute pathname' '
 		git add sub/file &&
 
 		git mv sub "$(pwd)/in" &&
-		! test -d sub &&
-		test -d in &&
+		! test_path_is_dir sub &&
+		test_path_is_dir in &&
 		git ls-files --error-unmatch in/file
 	)
 '
@@ -234,8 +234,8 @@ test_expect_success 'absolute pathname outside should fail' '
 		git add sub/file &&
 
 		test_must_fail git mv sub "$out/out" &&
-		test -d sub &&
-		! test -d ../in &&
+		test_path_is_dir sub &&
+		! test_path_is_dir ../in &&
 		git ls-files --error-unmatch sub/file
 	)
 '
@@ -295,8 +295,8 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	git add moved &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
-	! test -e moved &&
-	test -f symlink &&
+	! test_path_exists moved &&
+	test_path_is_file symlink &&
 	test "$(cat symlink)" = 1 &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -312,13 +312,13 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	git add moved &&
 	test_must_fail git mv symlink moved &&
 	git mv -f symlink moved &&
-	! test -e symlink &&
+	! test_path_exists symlink &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
 
 test_expect_success SYMLINKS 'check moved symlink' '
-	test -h moved
+	test_path_is_symlink moved
 '
 
 rm -f moved symlink
@@ -352,7 +352,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	) &&
 	mkdir mod &&
 	git mv sub mod/sub &&
-	! test -e sub &&
+	! test_path_exists sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -372,7 +372,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	) &&
 	mkdir mod &&
 	git mv sub mod/sub &&
-	! test -e sub &&
+	! test_path_exists sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
@@ -389,7 +389,7 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
-	! test -e sub &&
+	! test_path_exists sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
@@ -408,7 +408,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -e sub &&
+	! test_path_exists sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -423,13 +423,13 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
 	test_must_fail git mv sub mod/sub 2>actual.err &&
-	test -s actual.err &&
-	test -e sub &&
+	test_file_not_empty actual.err &&
+	test_path_exists sub &&
 	git diff-files --quiet -- sub &&
 	git add .gitmodules &&
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -e sub &&
+	! test_path_exists sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -447,7 +447,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_cmp expect.err actual.err &&
-	! test -e sub &&
+	! test_path_exists sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -460,7 +460,7 @@ test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
 	git submodule update &&
 	mkdir mod &&
 	git mv -n sub mod/sub 2>actual.err &&
-	test -f sub/.git &&
+	test_path_is_file sub/.git &&
 	git diff-index --exit-code HEAD &&
 	git update-index --refresh &&
 	git diff-files --quiet -- sub .gitmodules
@@ -474,10 +474,10 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
 	git status -s sub2 >actual &&
 	echo "?? sub2/" >expected &&
 	test_cmp expected actual &&
-	! test -f sub/.git &&
-	test -f sub2/.git &&
+	! test_path_is_file sub/.git &&
+	test_path_is_file sub2/.git &&
 	git submodule update &&
-	test -f sub/.git &&
+	test_path_is_file sub/.git &&
 	rm -rf sub2 &&
 	git diff-index --exit-code HEAD &&
 	git update-index --refresh &&

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
