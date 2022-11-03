Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B93C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 18:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiKCSjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiKCSjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850A13F5C
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 11:39:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g12so4039018wrs.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pkb37flch6Yj7dBLROfEE3lxovYCmy+RoTq+pzZu54=;
        b=O1a6vc3E+RZDBLr6yjQvjUM2BfApW37UPHhgBRkLXZlvWqcjtHvn9rSiMsuxrI1uhZ
         sBE4UOsgtNHaYon14AHpDezpapv8UnsmDg5yKZkBg5+3FnLX34xEMBGu0rNSazI7VgDB
         S7Q4jGoSg4hzzgQl8T6hf7sbhUn4hSuTIwdSj7XDcvRSvDJHhgUIcCYVlcHh2NEtRjUi
         QfX2iB4htF9rv5FlI7U7hmtpvX72ebkKkY6/mA9QQm3iLDwhlR5VIkLkuI01VOTBq4oc
         nj34RVKEmeYHOD5dME3ZV0t/s8e7JG5bGbOdodFxafNmj7pswUyEb8LCsB2cRPMPvSW/
         vXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pkb37flch6Yj7dBLROfEE3lxovYCmy+RoTq+pzZu54=;
        b=Fct4lCwXRW/9YtPqdxQwztJE6uhMl4tD9fXvt+fjvdDB3v+HAi3FSxp3542NrpMiv7
         PJo4cCj3xf+t6IA5ULnTzX5SnW6dz40PTBvhYsL9jPcz+c5DxPfZa27qvuPW02a8qNao
         nwVLhjh6LQFxEc3wlyjZ6ObhENK1nOnVCJtuPd+dx9vnxZfqWBla9ziLKWHNh3e+2cNC
         JqT5c7fyeMwn1k8amYo7WWod9tivGGZX6T/GhCr/PNLebf4DF3lGGInyu7DUVUzg8HPG
         dLuTNk7+DxryGHeLrs2/tf+RfOtRbLKyU0S1o+3esSORp9Iw6Kqylnhzol+orLSSXIZr
         kbeA==
X-Gm-Message-State: ACrzQf1IFqB5mWx3pT3VgBiHwc3r1SS96smwRTHtIuE04vIiex/i+NmV
        F6y7lPFiC5E41JFq26b+qsuf9IXP0Oo=
X-Google-Smtp-Source: AMsMyM4QuWt9EsihTEfVIffglFE1uo/qFgKqnZ79y1DqQgaHSIGNmO2RMGxgcX5hf2EQYCnvylz6Jw==
X-Received: by 2002:a05:6000:1845:b0:236:90d2:f239 with SMTP id c5-20020a056000184500b0023690d2f239mr20476967wri.711.1667500789624;
        Thu, 03 Nov 2022 11:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4409000000b00236e834f050sm1533478wrq.35.2022.11.03.11.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:39:49 -0700 (PDT)
Message-Id: <pull.1372.v2.git.git.1667500788132.gitgitgadget@gmail.com>
In-Reply-To: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
References: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
From:   "Debra Obondo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 18:39:48 +0000
Subject: [PATCH v2] t7001-mv.sh: modernizing test script using functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Debra Obondo <debraobondo@gmail.com>,
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

Changes since v1

Replacing idiomatic helper functions

'! test_path_is_*'

with

'test_path_is_missing'

This uses values of 'test_path_bar' in place of '! test_path_foo' to
bring in the helpful factor of indicating the failure of tests after the
mv command has been used, that is, it echoes if the feature/test_path
exists.

Signed-off-by: Debra Obondo <debraobondo@gmail.com>
---
    [PATCH v2] [OUTREACHY] t7001-mv.sh : Use test_path_is_* functions in
    test script
    
    Changes since v1:
    
    Replacing idiomatic helper functions
    
    '! test_path_is_*'
    
    with
    
    'test_path_is_missing'
    
    This uses values of 'test_path_bar' in place of '! test_path_foo' to
    bring in the helpful factor of indicating the failure of tests after the
    mv command has been used, that is, it echoes if the feature/test_path
    exists (This was suggested by Martin Ågren).
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1372%2Ffobiasic07%2Ft7001-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1372/fobiasic07/t7001-v2
Pull-Request: https://github.com/git/git/pull/1372

Range-diff vs v1:

 1:  b977c4ad26a ! 1:  c6640ebff66 t7001-mv.sh:modernizing test script using function
     @@ Metadata
      Author: Debra Obondo <debraobondo@gmail.com>
      
       ## Commit message ##
     -    t7001-mv.sh:modernizing test script using function
     +    t7001-mv.sh: modernizing test script using functions
      
          Test script to verify the presence/absence of files, paths, directories,
          symlinks and other features in 'git mv' command are using the command
     @@ Commit message
      
          'test_path_is_*'
      
     +    Changes since v1
     +
     +    Replacing idiomatic helper functions
     +
     +    '! test_path_is_*'
     +
     +    with
     +
     +    'test_path_is_missing'
     +
     +    This uses values of 'test_path_bar' in place of '! test_path_foo' to
     +    bring in the helpful factor of indicating the failure of tests after the
     +    mv command has been used, that is, it echoes if the feature/test_path
     +    exists.
     +
          Signed-off-by: Debra Obondo <debraobondo@gmail.com>
      
       ## t/t7001-mv.sh ##
     @@ t/t7001-mv.sh: test_expect_success 'checking the commit' '
      -	test -f path0/COPYING &&
      -	test ! -f MOVED
      +	test_path_is_file path0/COPYING &&
     -+	! test_path_is_file MOVED
     ++	test_path_is_missing MOVED
       '
       
       test_expect_success 'checking -k on non-existing file' '
     @@ t/t7001-mv.sh: test_expect_success 'checking -k on non-existing file' '
      -	test -f untracked1 &&
      -	test ! -f path0/untracked1
      +	test_path_is_file untracked1 &&
     -+	! test_path_is_file path0/untracked1
     ++	test_path_is_missing path0/untracked1
       '
       
       test_expect_success 'checking -k on multiple untracked files' '
     @@ t/t7001-mv.sh: test_expect_success 'checking -k on non-existing file' '
      -	test ! -f path0/untracked2
      +	test_path_is_file untracked1 &&
      +	test_path_is_file untracked2 &&
     -+	! test_path_is_file path0/untracked1 &&
     -+	! test_path_is_file path0/untracked2
     ++	test_path_is_missing path0/untracked1 &&
     ++	test_path_is_missing path0/untracked2
       '
       
       test_expect_success 'checking -f on untracked file with existing target' '
     @@ t/t7001-mv.sh: test_expect_success 'checking -k on non-existing file' '
      -	test ! -f .git/index.lock &&
      -	test -f untracked1 &&
      -	test -f path0/untracked1
     -+	! test_path_is_file .git/index.lock &&
     ++	test_path_is_missing .git/index.lock &&
      +	test_path_is_file untracked1 &&
      +	test_path_is_file path0/untracked1
       '
     @@ t/t7001-mv.sh: test_expect_success 'absolute pathname' '
       		git mv sub "$(pwd)/in" &&
      -		! test -d sub &&
      -		test -d in &&
     -+		! test_path_is_dir sub &&
     ++		test_path_is_missing sub &&
      +		test_path_is_dir in &&
       		git ls-files --error-unmatch in/file
       	)
     @@ t/t7001-mv.sh: test_expect_success 'absolute pathname outside should fail' '
      -		test -d sub &&
      -		! test -d ../in &&
      +		test_path_is_dir sub &&
     -+		! test_path_is_dir ../in &&
     ++		test_path_is_missing ../in &&
       		git ls-files --error-unmatch sub/file
       	)
       '
     @@ t/t7001-mv.sh: test_expect_success 'git mv should overwrite symlink to a file' '
       	git mv -f moved symlink &&
      -	! test -e moved &&
      -	test -f symlink &&
     -+	! test_path_exists moved &&
     ++	test_path_is_missing moved &&
      +	test_path_is_file symlink &&
       	test "$(cat symlink)" = 1 &&
       	git update-index --refresh &&
     @@ t/t7001-mv.sh: test_expect_success 'git mv should overwrite file with a symlink'
       	test_must_fail git mv symlink moved &&
       	git mv -f symlink moved &&
      -	! test -e symlink &&
     -+	! test_path_exists symlink &&
     ++	test_path_is_missing symlink &&
       	git update-index --refresh &&
       	git diff-files --quiet
       '
     @@ t/t7001-mv.sh: test_expect_success 'git mv moves a submodule with a .git directo
       	mkdir mod &&
       	git mv sub mod/sub &&
      -	! test -e sub &&
     -+	! test_path_exists sub &&
     ++	test_path_is_missing sub &&
       	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
       	git -C mod/sub status &&
       	git update-index --refresh &&
     @@ t/t7001-mv.sh: test_expect_success 'git mv moves a submodule with a .git directo
       	mkdir mod &&
       	git mv sub mod/sub &&
      -	! test -e sub &&
     -+	! test_path_exists sub &&
     ++	test_path_is_missing sub &&
       	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
       	git -C mod/sub status &&
       	echo mod/sub >expected &&
     @@ t/t7001-mv.sh: test_expect_success 'git mv moves a submodule with gitfile' '
       	mkdir mod &&
       	git -C mod mv ../sub/ . &&
      -	! test -e sub &&
     -+	! test_path_exists sub &&
     ++	test_path_is_missing sub &&
       	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
       	git -C mod/sub status &&
       	echo mod/sub >expected &&
     @@ t/t7001-mv.sh: test_expect_success 'mv does not complain when no .gitmodules fil
       	git mv sub mod/sub 2>actual.err &&
       	test_must_be_empty actual.err &&
      -	! test -e sub &&
     -+	! test_path_exists sub &&
     ++	test_path_is_missing sub &&
       	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
       	git -C mod/sub status &&
       	git update-index --refresh &&
     @@ t/t7001-mv.sh: test_expect_success 'mv will error out on a modified .gitmodules
       	git mv sub mod/sub 2>actual.err &&
       	test_must_be_empty actual.err &&
      -	! test -e sub &&
     -+	! test_path_exists sub &&
     ++	test_path_is_missing sub &&
       	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
       	git -C mod/sub status &&
       	git update-index --refresh &&
     @@ t/t7001-mv.sh: test_expect_success 'mv issues a warning when section is not foun
       	git mv sub mod/sub 2>actual.err &&
       	test_cmp expect.err actual.err &&
      -	! test -e sub &&
     -+	! test_path_exists sub &&
     ++	test_path_is_missing sub &&
       	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
       	git -C mod/sub status &&
       	git update-index --refresh &&
     @@ t/t7001-mv.sh: test_expect_success 'checking out a commit before submodule moved
       	test_cmp expected actual &&
      -	! test -f sub/.git &&
      -	test -f sub2/.git &&
     -+	! test_path_is_file sub/.git &&
     ++	test_path_is_missing sub/.git &&
      +	test_path_is_file sub2/.git &&
       	git submodule update &&
      -	test -f sub/.git &&


 t/t7001-mv.sh | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 8c37bceb336..d72cef88264 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -60,8 +60,8 @@ test_expect_success 'checking the commit' '
 
 test_expect_success 'mv --dry-run does not move file' '
 	git mv -n path0/COPYING MOVED &&
-	test -f path0/COPYING &&
-	test ! -f MOVED
+	test_path_is_file path0/COPYING &&
+	test_path_is_missing MOVED
 '
 
 test_expect_success 'checking -k on non-existing file' '
@@ -71,25 +71,25 @@ test_expect_success 'checking -k on non-existing file' '
 test_expect_success 'checking -k on untracked file' '
 	>untracked1 &&
 	git mv -k untracked1 path0 &&
-	test -f untracked1 &&
-	test ! -f path0/untracked1
+	test_path_is_file untracked1 &&
+	test_path_is_missing path0/untracked1
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
+	test_path_is_missing path0/untracked1 &&
+	test_path_is_missing path0/untracked2
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
 	>path0/untracked1 &&
 	test_must_fail git mv -f untracked1 path0 &&
-	test ! -f .git/index.lock &&
-	test -f untracked1 &&
-	test -f path0/untracked1
+	test_path_is_missing .git/index.lock &&
+	test_path_is_file untracked1 &&
+	test_path_is_file path0/untracked1
 '
 
 # clean up the mess in case bad things happen
@@ -215,8 +215,8 @@ test_expect_success 'absolute pathname' '
 		git add sub/file &&
 
 		git mv sub "$(pwd)/in" &&
-		! test -d sub &&
-		test -d in &&
+		test_path_is_missing sub &&
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
+		test_path_is_missing ../in &&
 		git ls-files --error-unmatch sub/file
 	)
 '
@@ -295,8 +295,8 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	git add moved &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
-	! test -e moved &&
-	test -f symlink &&
+	test_path_is_missing moved &&
+	test_path_is_file symlink &&
 	test "$(cat symlink)" = 1 &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -312,13 +312,13 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	git add moved &&
 	test_must_fail git mv symlink moved &&
 	git mv -f symlink moved &&
-	! test -e symlink &&
+	test_path_is_missing symlink &&
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
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -372,7 +372,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	) &&
 	mkdir mod &&
 	git mv sub mod/sub &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
@@ -389,7 +389,7 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
@@ -408,7 +408,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -e sub &&
+	test_path_is_missing sub &&
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
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -447,7 +447,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_cmp expect.err actual.err &&
-	! test -e sub &&
+	test_path_is_missing sub &&
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
+	test_path_is_missing sub/.git &&
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
