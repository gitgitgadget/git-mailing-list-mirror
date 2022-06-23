Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99689C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiFWIrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFWIrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 04:47:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6749279
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 01:46:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so1035122wml.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Tzao6zVyxYTp6EhmezmxbqD8zoPrsEbvqsiggYyVouQ=;
        b=GzMKRJF6THISq7V5ytSgAZ319qZb2EoNZcPqkThYBnNZ1Gw2RupkTOBk22qk6T6SOx
         xuc1tW4M07KQ6J/UNZJ6bku6lcXRXmhDcqQnXsrdjX05FL9TQOvV97j98UC6Poh+zW2n
         KqPlp0k7GPhXG9Df7J56LTPUJeF5Q4Fbvz1rKXYpe+NMippuK1GMVnCcrJVB22/s5/l1
         uhXoG2xMQ3AAd2RV7lTOXuX1zng7784wX0FEKlMDYFZyRv1Z7WOAoh0F0bKlyJ7oskKP
         H2QJzoF4LdOsEiq+ouaRArPlgi4Ko6wLu9y9JOc8KjEEPFWm1sJ2NEJJkwkn67LCFKvU
         n8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tzao6zVyxYTp6EhmezmxbqD8zoPrsEbvqsiggYyVouQ=;
        b=4SF8LP2USrbzi1TjOINILR2EEsixeUcXeLZ0K1jzjiM4XUop9GGfvXu5xVv63z2A6/
         Cw+V3I/7/wvi2YRqiQKGK9geo17tWeiNvOj8PXBJnbBknS9X0e4GppALOtZtplroAdkj
         eaeONy1BSyPJB89iUE5DiUQ1W3ck4EmDqiSwpsNpJXvKLwl50IBou/QwaxdiZX3ujpuP
         16JNE3Ox3IuKGL+xIwdEfBRm0PDRylEaVXj9FfAgOKOvU16EzG/DesdpI+fkmJaY17uc
         stzWUNBw4RFFVgid1QiqudSDpBIr/H3DMe/EEyJNspX/nKeIKsOzH652Ncc6rnfHvR+1
         yG1g==
X-Gm-Message-State: AJIora/vfKLzI4j768SJOBkOy8PEsD2msg/sOGKU8KT59Fr6AlJJF9PZ
        2fMiIDXLGNYImHjsBFVBxWGF1x9Yz3iZjA==
X-Google-Smtp-Source: AGRyM1uC3j1jdJaMIzD56BGC9+QwtSieWQ0ctv2ayUDTyot0HdDQ2v2EezMywHmBm4bdGschmUE8AA==
X-Received: by 2002:a05:600c:5115:b0:39c:453f:5e06 with SMTP id o21-20020a05600c511500b0039c453f5e06mr2838625wms.123.1655974016853;
        Thu, 23 Jun 2022 01:46:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003974b95d897sm2418539wmb.37.2022.06.23.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 01:46:56 -0700 (PDT)
Message-Id: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jun 2022 08:46:55 +0000
Subject: [PATCH] ls-files: update test style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Li Linchao <lilinchao@oschina.cn>,
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

Update test style in t/t30[*].sh for uniformity, that's to
keep test title the same line with helper function itself.

And update t/README to describe this test style.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    ls-files: update test style
    
    Update test style in t/t30[*].sh for uniformity, that's to keep test
    title the same line with helper function itself.
    
    And update t/README to describe this test style.
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1269%2FCactusinhand%2Fllc%2Ffix-test-title-style-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1269/Cactusinhand/llc/fix-test-title-style-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1269

 t/README                           | 15 ++++++++++++++
 t/t3001-ls-files-others-exclude.sh | 24 +++++++++++-----------
 t/t3002-ls-files-dashpath.sh       | 33 +++++++++++++-----------------
 t/t3020-ls-files-error-unmatch.sh  | 12 +++++------
 t/t3060-ls-files-with-tree.sh      |  6 +++---
 5 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..70205fba41b 100644
--- a/t/README
+++ b/t/README
@@ -560,6 +560,21 @@ Here are the "do's:"
    Even code that isn't a test per se, but merely some setup code
    should be inside a test assertion.
 
+ - Keep test title the same line with test helper function itself,
+   and end the line with a single quote.
+
+   Take test_expect_success helper for example, write it like:
+
+  test_expect_success 'test title to describe this test case' '
+  # test body
+  '
+
+   Instead of:
+
+  test_expect_success \
+  'test title to describe this test case' \
+  '# test body'
+
  - Chain your test assertions
 
    Write test code like this:
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 48cec4e5f88..76361b92336 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -67,26 +67,26 @@ echo '!*.2
 
 allignores='.gitignore one/.gitignore one/two/.gitignore'
 
-test_expect_success \
-    'git ls-files --others with various exclude options.' \
-    'git ls-files --others \
+test_expect_success 'git ls-files --others with various exclude options.' '
+	git ls-files --others \
        --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     test_cmp expect output'
+     test_cmp expect output
+'
 
 # Test \r\n (MSDOS-like systems)
 printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
 
-test_expect_success \
-    'git ls-files --others with \r\n line endings.' \
-    'git ls-files --others \
+test_expect_success 'git ls-files --others with \r\n line endings.' '
+	git ls-files --others \
        --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     test_cmp expect output'
+     test_cmp expect output
+'
 
 test_expect_success 'setup skip-worktree gitignore' '
 	git add $allignores &&
@@ -94,14 +94,14 @@ test_expect_success 'setup skip-worktree gitignore' '
 	rm $allignores
 '
 
-test_expect_success \
-    'git ls-files --others with various exclude options.' \
-    'git ls-files --others \
+test_expect_success 'git ls-files --others with various exclude options.' '
+	git ls-files --others \
        --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     test_cmp expect output'
+     test_cmp expect output
+'
 
 test_expect_success !SANITIZE_LEAK 'restore gitignore' '
 	git checkout --ignore-skip-worktree-bits $allignores &&
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 54d22a45dfb..adbe96fa2df 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -16,15 +16,14 @@ filesystem.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success \
-	setup \
-	'echo frotz >path0 &&
+test_expect_success 'setup' '
+    echo frotz >path0 &&
 	echo frotz >./-foo &&
-	echo frotz >./--'
+	echo frotz >./--
+'
 
-test_expect_success \
-    'git ls-files without path restriction.' \
-    'git ls-files --others >output &&
+test_expect_success 'git ls-files without path restriction.' '
+    git ls-files --others >output &&
      test_cmp output - <<EOF
 --
 -foo
@@ -33,33 +32,29 @@ path0
 EOF
 '
 
-test_expect_success \
-    'git ls-files with path restriction.' \
-    'git ls-files --others path0 >output &&
+test_expect_success 'git ls-files with path restriction.' '
+    git ls-files --others path0 >output &&
 	test_cmp output - <<EOF
 path0
 EOF
 '
 
-test_expect_success \
-    'git ls-files with path restriction with --.' \
-    'git ls-files --others -- path0 >output &&
+test_expect_success 'git ls-files with path restriction with --.' '
+    git ls-files --others -- path0 >output &&
 	test_cmp output - <<EOF
 path0
 EOF
 '
 
-test_expect_success \
-    'git ls-files with path restriction with -- --.' \
-    'git ls-files --others -- -- >output &&
+test_expect_success 'git ls-files with path restriction with -- --.' '
+    git ls-files --others -- -- >output &&
 	test_cmp output - <<EOF
 --
 EOF
 '
 
-test_expect_success \
-    'git ls-files with no path restriction.' \
-    'git ls-files --others -- >output &&
+test_expect_success 'git ls-files with no path restriction.' '
+    git ls-files --others -- >output &&
 	test_cmp output - <<EOF
 --
 -foo
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index 2cbcbc0721b..8dd520bb331 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -19,12 +19,12 @@ test_expect_success 'setup' '
 	git commit -m "add foo bar"
 '
 
-test_expect_success \
-    'git ls-files --error-unmatch should fail with unmatched path.' \
-    'test_must_fail git ls-files --error-unmatch foo bar-does-not-match'
+test_expect_success 'git ls-files --error-unmatch should fail with unmatched path.' '
+    test_must_fail git ls-files --error-unmatch foo bar-does-not-match
+'
 
-test_expect_success \
-    'git ls-files --error-unmatch should succeed with matched paths.' \
-    'git ls-files --error-unmatch foo bar'
+test_expect_success 'git ls-files --error-unmatch should succeed with matched paths.' '
+    git ls-files --error-unmatch foo bar
+'
 
 test_done
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index b257c792a46..c350b4641f3 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -62,9 +62,9 @@ test_expect_success 'git ls-files --with-tree should succeed from subdir' '
 	)
 '
 
-test_expect_success \
-    'git ls-files --with-tree should add entries from named tree.' \
-    'test_cmp expected output'
+test_expect_success 'git ls-files --with-tree should add entries from named tree.' '
+	test_cmp expected output
+'
 
 test_expect_success 'no duplicates in --with-tree output' '
 	git ls-files --with-tree=HEAD >actual &&

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
