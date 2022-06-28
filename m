Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC88C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 09:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbiF1JOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245172AbiF1JOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 05:14:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132911C1D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:14:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so16701732wrd.8
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xRfXwG+yA6CYFzTKwdX1TPAugowehfDUXl3z3VzycpA=;
        b=jGRngQlDnpAiQ8P2va78D/T6644YqTEXJ3f/a1jAFnurZma3otreQOoxGjc9QEEe5n
         j0Iywik7Uf5NHmbyPbdwyiOgGy5ynhv1P9+TUGeKdIex1I17ziE8trL2p2HkFuFB3fHC
         OXPIktqJdSPNSg2vyYg56e/PcR1hhr7h4FN7RVjFXjnelB9Oj5xTrLOYU5kFYYZvMAV2
         WWTaX72kP7sNrVZTn3LOCx8ZYwUYQuQay1Z1kaGLZr9gLv0JTJMJAuBfvPnQCAks94Im
         52yc2U7ERQ6IA2ZS1otFbID0PoihtI9cnQ0sERidcd0V2TbHU9ZGl8hqiBiCQ4MihIc5
         1YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xRfXwG+yA6CYFzTKwdX1TPAugowehfDUXl3z3VzycpA=;
        b=oWHcEYBiLpiq9UhASZ+JmuLKoHqa/lT6cTEumzzEpPXqtEeRW1S4BAl67SjzrwGTLm
         Gr9Cl9VZ0KLMNjAMkr17bG1mc3+Z2lJCIwx79RvNkN5/6Oh5PO8Bxec0zWQ+U6O9okob
         ULXIJsh6/TOfRG/ZVUDHu22ZYv9qO1nTKjTLU/cLU5ajQhOzUrwTmPFWrFQmDYKiZ1qw
         1p3l4Yzajy6LQdVN/ekjIjxHCpoLAjf62jgepv/HHV05fivCIC/2on6APTtzc2dPT5FP
         kX5sOZzDAmZY47e+mzGXQpIGr+nkNR8Ean4GOrIOjy6dmBiRi9OmMd1AHfabSXFneOZx
         5faQ==
X-Gm-Message-State: AJIora8v55dxF93HdwAR4SNgIU6yVp9kT5qgpwPIDmZUWJipjUznaU6o
        +yRcvVRg6HzPKso3Om1Ko96lzMDAwMjWOw==
X-Google-Smtp-Source: AGRyM1vra73KAxbiJUGut4kTaJFbgMwjIYXqt/efifuDV/zOiaLktyKoNXYI0s88SHdnDPRr2nQ4/g==
X-Received: by 2002:a05:6000:154c:b0:21c:65c8:2ef with SMTP id 12-20020a056000154c00b0021c65c802efmr8940137wry.473.1656407666317;
        Tue, 28 Jun 2022 02:14:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a056000018500b0021bbe0f3c88sm9438398wrx.55.2022.06.28.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:14:25 -0700 (PDT)
Message-Id: <pull.1269.v2.git.1656407664694.gitgitgadget@gmail.com>
In-Reply-To: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>
References: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 09:14:24 +0000
Subject: [PATCH v2] ls-files: update test style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1269%2FCactusinhand%2Fllc%2Ffix-test-title-style-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1269/Cactusinhand/llc/fix-test-title-style-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1269

Range-diff vs v1:

 1:  e18a6172cff ! 1:  775c17499d5 ls-files: update test style
     @@ Commit message
          Signed-off-by: Li Linchao <lilinchao@oschina.cn>
      
       ## t/README ##
     -@@ t/README: Here are the "do's:"
     -    Even code that isn't a test per se, but merely some setup code
     -    should be inside a test assertion.
     +@@ t/README: This test harness library does the following things:
     +    consistently when command line arguments --verbose (or -v),
     +    --debug (or -d), and --immediate (or -i) is given.
       
     -+ - Keep test title the same line with test helper function itself,
     -+   and end the line with a single quote.
     ++Recommended style
     ++-----------------
     ++Here are some recommented style that you should follow when you write some test cases.
     ++
     ++ - Keep test title the same line with test helper function itself.
      +
      +   Take test_expect_success helper for example, write it like:
      +
     -+  test_expect_success 'test title to describe this test case' '
     -+  # test body
     ++  test_expect_success 'test title' '
     ++  ... test body ...
      +  '
      +
      +   Instead of:
      +
      +  test_expect_success \
     -+  'test title to describe this test case' \
     -+  '# test body'
     ++  'test title' \
     ++  '... test body ...'
     ++
     ++
     ++ - End the line with a single quote.
     ++
     ++ - Indent the body of here-document, and cut off prefix TAB by using
     ++ "<<-":
      +
     -  - Chain your test assertions
     ++  test_expect_success 'test something' '
     ++      cat >expect <<-\EOF &&
     ++      one
     ++      two
     ++      three
     ++      EOF
     ++      test_something > actual &&
     ++      test_cmp expect actual
     ++  '
     ++
     ++   Instead of:
     ++
     ++  test_expect_success 'test something' '
     ++      cat >expect <<\EOF &&
     ++  one
     ++  two
     ++  three
     ++  EOF
     ++      test_something > actual &&
     ++      test_cmp expect actual
     ++  '
     ++
     ++
     + Do's & don'ts
     + -------------
       
     -    Write test code like this:
      
       ## t/t3001-ls-files-others-exclude.sh ##
      @@ t/t3001-ls-files-others-exclude.sh: echo '!*.2
     @@ t/t3001-ls-files-others-exclude.sh: echo '!*.2
              --exclude=\*.6 \
              --exclude-per-directory=.gitignore \
              --exclude-from=.git/ignore \
     -        >output &&
     +-       >output &&
      -     test_cmp expect output'
     -+     test_cmp expect output
     ++	>output &&
     ++	test_cmp expect output
      +'
       
       # Test \r\n (MSDOS-like systems)
     @@ t/t3001-ls-files-others-exclude.sh: echo '!*.2
              --exclude=\*.6 \
              --exclude-per-directory=.gitignore \
              --exclude-from=.git/ignore \
     -        >output &&
     +-       >output &&
      -     test_cmp expect output'
     -+     test_cmp expect output
     ++	>output &&
     ++	test_cmp expect output
      +'
       
       test_expect_success 'setup skip-worktree gitignore' '
     @@ t/t3001-ls-files-others-exclude.sh: test_expect_success 'setup skip-worktree git
              --exclude=\*.6 \
              --exclude-per-directory=.gitignore \
              --exclude-from=.git/ignore \
     -        >output &&
     +-       >output &&
      -     test_cmp expect output'
     -+     test_cmp expect output
     ++	>output &&
     ++	test_cmp expect output
      +'
       
       test_expect_success !SANITIZE_LEAK 'restore gitignore' '
       	git checkout --ignore-skip-worktree-bits $allignores &&
     +@@ t/t3001-ls-files-others-exclude.sh: test_expect_success 'pattern matches prefix completely' '
     + '
     + 
     + test_expect_success 'ls-files with "**" patterns' '
     +-	cat <<\EOF >expect &&
     +-a.1
     +-one/a.1
     +-one/two/a.1
     +-three/a.1
     +-EOF
     ++	cat <<-\EOF >expect &&
     ++	a.1
     ++	one/a.1
     ++	one/two/a.1
     ++	three/a.1
     ++	EOF
     + 	git ls-files -o -i --exclude "**/a.1" >actual &&
     + 	test_cmp expect actual
     + '
      
       ## t/t3002-ls-files-dashpath.sh ##
      @@ t/t3002-ls-files-dashpath.sh: filesystem.
     @@ t/t3002-ls-files-dashpath.sh: filesystem.
      -	setup \
      -	'echo frotz >path0 &&
      +test_expect_success 'setup' '
     -+    echo frotz >path0 &&
     ++	echo frotz >path0 &&
       	echo frotz >./-foo &&
      -	echo frotz >./--'
      +	echo frotz >./--
     @@ t/t3002-ls-files-dashpath.sh: filesystem.
      -test_expect_success \
      -    'git ls-files without path restriction.' \
      -    'git ls-files --others >output &&
     +-     test_cmp output - <<EOF
     +---
     +--foo
     +-output
     +-path0
     +-EOF
      +test_expect_success 'git ls-files without path restriction.' '
     -+    git ls-files --others >output &&
     -      test_cmp output - <<EOF
     - --
     - -foo
     -@@ t/t3002-ls-files-dashpath.sh: path0
     - EOF
     ++	test_when_finished "rm -f expect" &&
     ++	git ls-files --others >output &&
     ++	cat >expect <<-\EOF &&
     ++	--
     ++	-foo
     ++	output
     ++	path0
     ++	EOF
     ++	test_cmp output expect
       '
       
      -test_expect_success \
      -    'git ls-files with path restriction.' \
      -    'git ls-files --others path0 >output &&
     +-	test_cmp output - <<EOF
     +-path0
     +-EOF
      +test_expect_success 'git ls-files with path restriction.' '
     -+    git ls-files --others path0 >output &&
     - 	test_cmp output - <<EOF
     - path0
     - EOF
     ++	test_when_finished "rm -f expect" &&
     ++	git ls-files --others path0 >output &&
     ++	cat >expect <<-\EOF &&
     ++	path0
     ++	EOF
     ++	test_cmp output expect
       '
       
      -test_expect_success \
      -    'git ls-files with path restriction with --.' \
      -    'git ls-files --others -- path0 >output &&
     +-	test_cmp output - <<EOF
     +-path0
     +-EOF
      +test_expect_success 'git ls-files with path restriction with --.' '
     -+    git ls-files --others -- path0 >output &&
     - 	test_cmp output - <<EOF
     - path0
     - EOF
     ++	test_when_finished "rm -f expect" &&
     ++	git ls-files --others -- path0 >output &&
     ++	cat >expect <<-\EOF &&
     ++	path0
     ++	EOF
     ++	test_cmp output expect
       '
       
      -test_expect_success \
      -    'git ls-files with path restriction with -- --.' \
      -    'git ls-files --others -- -- >output &&
     +-	test_cmp output - <<EOF
     +---
     +-EOF
      +test_expect_success 'git ls-files with path restriction with -- --.' '
     -+    git ls-files --others -- -- >output &&
     - 	test_cmp output - <<EOF
     - --
     - EOF
     ++	test_when_finished "rm -f expect" &&
     ++	git ls-files --others -- -- >output &&
     ++	cat >expect <<-\EOF &&
     ++	--
     ++	EOF
     ++	test_cmp output expect
       '
       
      -test_expect_success \
      -    'git ls-files with no path restriction.' \
      -    'git ls-files --others -- >output &&
     +-	test_cmp output - <<EOF
     +---
     +--foo
     +-output
     +-path0
     +-EOF
      +test_expect_success 'git ls-files with no path restriction.' '
     -+    git ls-files --others -- >output &&
     - 	test_cmp output - <<EOF
     - --
     - -foo
     ++	test_when_finished "rm -f expect" &&
     ++	git ls-files --others -- >output &&
     ++	cat >expect <<-\EOF &&
     ++	--
     ++	-foo
     ++	output
     ++	path0
     ++	EOF
     ++	test_cmp output expect
     ++
     + '
     + 
     + test_done
     +
     + ## t/t3007-ls-files-recurse-submodules.sh ##
     +@@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success '--recurse-submodules does not support --error-unmatch' '
     + 
     + test_incompatible_with_recurse_submodules () {
     + 	test_expect_success "--recurse-submodules and $1 are incompatible" "
     +-		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
     +-		test_i18ngrep 'unsupported mode' actual
     ++	test_must_fail git ls-files --recurse-submodules $1 2>actual &&
     ++	test_i18ngrep 'unsupported mode' actual
     + 	"
     + }
     + 
      
       ## t/t3020-ls-files-error-unmatch.sh ##
      @@ t/t3020-ls-files-error-unmatch.sh: test_expect_success 'setup' '
     @@ t/t3020-ls-files-error-unmatch.sh: test_expect_success 'setup' '
      -    'git ls-files --error-unmatch should fail with unmatched path.' \
      -    'test_must_fail git ls-files --error-unmatch foo bar-does-not-match'
      +test_expect_success 'git ls-files --error-unmatch should fail with unmatched path.' '
     -+    test_must_fail git ls-files --error-unmatch foo bar-does-not-match
     ++	test_must_fail git ls-files --error-unmatch foo bar-does-not-match
      +'
       
      -test_expect_success \
      -    'git ls-files --error-unmatch should succeed with matched paths.' \
      -    'git ls-files --error-unmatch foo bar'
      +test_expect_success 'git ls-files --error-unmatch should succeed with matched paths.' '
     -+    git ls-files --error-unmatch foo bar
     ++	git ls-files --error-unmatch foo bar
      +'
       
       test_done
      
       ## t/t3060-ls-files-with-tree.sh ##
     +@@ t/t3060-ls-files-with-tree.sh: a scenario known to trigger a crash with some versions of git.
     + '
     + . ./test-lib.sh
     + 
     +-test_expect_success setup '
     ++test_expect_success 'setup' '
     + 
     + 	# The bug we are exercising requires a fair number of entries
     + 	# in a sub-directory so that add_index_entry will trigger a
      @@ t/t3060-ls-files-with-tree.sh: test_expect_success 'git ls-files --with-tree should succeed from subdir' '
       	)
       '


 t/README                               | 47 ++++++++++++++
 t/t3001-ls-files-others-exclude.sh     | 42 ++++++-------
 t/t3002-ls-files-dashpath.sh           | 86 ++++++++++++++------------
 t/t3007-ls-files-recurse-submodules.sh |  4 +-
 t/t3020-ls-files-error-unmatch.sh      | 12 ++--
 t/t3060-ls-files-with-tree.sh          |  8 +--
 6 files changed, 126 insertions(+), 73 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..845af1883c3 100644
--- a/t/README
+++ b/t/README
@@ -547,6 +547,53 @@ This test harness library does the following things:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
+Recommended style
+-----------------
+Here are some recommented style that you should follow when you write some test cases.
+
+ - Keep test title the same line with test helper function itself.
+
+   Take test_expect_success helper for example, write it like:
+
+  test_expect_success 'test title' '
+  ... test body ...
+  '
+
+   Instead of:
+
+  test_expect_success \
+  'test title' \
+  '... test body ...'
+
+
+ - End the line with a single quote.
+
+ - Indent the body of here-document, and cut off prefix TAB by using
+ "<<-":
+
+  test_expect_success 'test something' '
+      cat >expect <<-\EOF &&
+      one
+      two
+      three
+      EOF
+      test_something > actual &&
+      test_cmp expect actual
+  '
+
+   Instead of:
+
+  test_expect_success 'test something' '
+      cat >expect <<\EOF &&
+  one
+  two
+  three
+  EOF
+      test_something > actual &&
+      test_cmp expect actual
+  '
+
+
 Do's & don'ts
 -------------
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 48cec4e5f88..e07ac6c6dce 100755
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
-       >output &&
-     test_cmp expect output'
+	>output &&
+	test_cmp expect output
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
-       >output &&
-     test_cmp expect output'
+	>output &&
+	test_cmp expect output
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
-       >output &&
-     test_cmp expect output'
+	>output &&
+	test_cmp expect output
+'
 
 test_expect_success !SANITIZE_LEAK 'restore gitignore' '
 	git checkout --ignore-skip-worktree-bits $allignores &&
@@ -283,12 +283,12 @@ test_expect_success 'pattern matches prefix completely' '
 '
 
 test_expect_success 'ls-files with "**" patterns' '
-	cat <<\EOF >expect &&
-a.1
-one/a.1
-one/two/a.1
-three/a.1
-EOF
+	cat <<-\EOF >expect &&
+	a.1
+	one/a.1
+	one/two/a.1
+	three/a.1
+	EOF
 	git ls-files -o -i --exclude "**/a.1" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 54d22a45dfb..4dd24550eba 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -16,56 +16,62 @@ filesystem.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success \
-	setup \
-	'echo frotz >path0 &&
+test_expect_success 'setup' '
+	echo frotz >path0 &&
 	echo frotz >./-foo &&
-	echo frotz >./--'
+	echo frotz >./--
+'
 
-test_expect_success \
-    'git ls-files without path restriction.' \
-    'git ls-files --others >output &&
-     test_cmp output - <<EOF
---
--foo
-output
-path0
-EOF
+test_expect_success 'git ls-files without path restriction.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others >output &&
+	cat >expect <<-\EOF &&
+	--
+	-foo
+	output
+	path0
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with path restriction.' \
-    'git ls-files --others path0 >output &&
-	test_cmp output - <<EOF
-path0
-EOF
+test_expect_success 'git ls-files with path restriction.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others path0 >output &&
+	cat >expect <<-\EOF &&
+	path0
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with path restriction with --.' \
-    'git ls-files --others -- path0 >output &&
-	test_cmp output - <<EOF
-path0
-EOF
+test_expect_success 'git ls-files with path restriction with --.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others -- path0 >output &&
+	cat >expect <<-\EOF &&
+	path0
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with path restriction with -- --.' \
-    'git ls-files --others -- -- >output &&
-	test_cmp output - <<EOF
---
-EOF
+test_expect_success 'git ls-files with path restriction with -- --.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others -- -- >output &&
+	cat >expect <<-\EOF &&
+	--
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with no path restriction.' \
-    'git ls-files --others -- >output &&
-	test_cmp output - <<EOF
---
--foo
-output
-path0
-EOF
+test_expect_success 'git ls-files with no path restriction.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others -- >output &&
+	cat >expect <<-\EOF &&
+	--
+	-foo
+	output
+	path0
+	EOF
+	test_cmp output expect
+
 '
 
 test_done
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index dd7770e85de..2a057e987fe 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -301,8 +301,8 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
 
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
-		test_i18ngrep 'unsupported mode' actual
+	test_must_fail git ls-files --recurse-submodules $1 2>actual &&
+	test_i18ngrep 'unsupported mode' actual
 	"
 }
 
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index 2cbcbc0721b..133593d23c0 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -19,12 +19,12 @@ test_expect_success 'setup' '
 	git commit -m "add foo bar"
 '
 
-test_expect_success \
-    'git ls-files --error-unmatch should fail with unmatched path.' \
-    'test_must_fail git ls-files --error-unmatch foo bar-does-not-match'
+test_expect_success 'git ls-files --error-unmatch should fail with unmatched path.' '
+	test_must_fail git ls-files --error-unmatch foo bar-does-not-match
+'
 
-test_expect_success \
-    'git ls-files --error-unmatch should succeed with matched paths.' \
-    'git ls-files --error-unmatch foo bar'
+test_expect_success 'git ls-files --error-unmatch should succeed with matched paths.' '
+	git ls-files --error-unmatch foo bar
+'
 
 test_done
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index b257c792a46..52f76f7b57f 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -10,7 +10,7 @@ a scenario known to trigger a crash with some versions of git.
 '
 . ./test-lib.sh
 
-test_expect_success setup '
+test_expect_success 'setup' '
 
 	# The bug we are exercising requires a fair number of entries
 	# in a sub-directory so that add_index_entry will trigger a
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

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
