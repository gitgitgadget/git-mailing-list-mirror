Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C29C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbiF1Jvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiF1Jv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 05:51:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E82B25B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:51:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so6390789wmp.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gb2M7eNZYq8PEaFm6RFIfzfdRvkGyr9qoHr89F8gUgg=;
        b=DmMGU1gjX9wnk/o7yqP3GSmykrn60iLN4IHW4313UhPa7M/o1o/jToWZUUJzWBrTan
         VsWXZAsAlm76TIP6eXdyc1Rksp5F9KK0S488GTxMb3puw+bW4HnkGaw+LCET5LGY6W5s
         i4pY5kxO7qx243qmqaOo8OWF4SKOdvgS74xIQh5b4wiWQtPoX/Lh2HbwMq8UMprMdADW
         bECPp4JJ2Xqu41VEFIrWOaxbez2vw6PzBE+5ULsD2L9t8Vr1bpAUGlPSBaUrxEDkP7Hn
         FfWPg27DIhXhhmnakaZZIi+m4ONHhG8LJJdbcqNNZa+mIi8GSnUs2z8ssGW6x3MQyyF8
         I6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gb2M7eNZYq8PEaFm6RFIfzfdRvkGyr9qoHr89F8gUgg=;
        b=HiAiLnGqPR1HTY6dSDQQvaF5Vgq/9MyZVdw3+u+TE6Sk74QdQ5gG2RLe0LPpxWk4Q+
         LgvFWCmPEzorGr1mYno6Qjz1CoeXG4UOwKzME29vMtAmmsTGbRfFD2jOefG6eLTr+V/k
         EBtmApJwgcJYBTtm2DNv7H2do6Hz+ZPTzXY/CFVQx5zzxL/GNFCpXTyYS0d5jXHWc++E
         qUucgZa2kqnRqy11OtaJT3gieDBnvFlEbQG8dlwFiBT8cqxI5kkP+eRFUNMZQwJB1aSd
         Ryk95zxF+BWjnYuyqMEZAqOp53W+cd3UOWiHAgHSlIVSFd1nT/MPXb+klQLcG7FQLjyM
         cSPg==
X-Gm-Message-State: AJIora+tVCpQpz4VHzySTXIUXmwFtLMMxlVQSCpF7er9dRqhs2WCH0gd
        dg5dfWYDpzCB/BwBlqeplmGkesFXgiW2Bw==
X-Google-Smtp-Source: AGRyM1vu2+05UfmVFh+/TR9iGqVdTLCfsNtvFYOSje9MO2QqJi9x/afAMYAOKDu1rBdf8tsFeVxhcw==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr24914994wmz.27.1656409885248;
        Tue, 28 Jun 2022 02:51:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d6343000000b0021a36955493sm12908636wrw.74.2022.06.28.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:51:24 -0700 (PDT)
Message-Id: <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com>
In-Reply-To: <pull.1269.v2.git.1656407664694.gitgitgadget@gmail.com>
References: <pull.1269.v2.git.1656407664694.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 09:51:23 +0000
Subject: [PATCH v3] ls-files: update test style
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
keep test title the same line with helper function itself,
and fix some indentions.

Add a new section "recommended style" in t/README to
encourage people to use more modern style in test.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    ls-files: update test style
    
    Update test style in t/t30[*].sh for uniformity, that's to keep test
    title the same line with helper function itself.
    
    And update t/README to describe this test style.
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1269%2FCactusinhand%2Fllc%2Ffix-test-title-style-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1269/Cactusinhand/llc/fix-test-title-style-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1269

Range-diff vs v2:

 1:  775c17499d5 ! 1:  b3d80bd9cd5 ls-files: update test style
     @@ Commit message
          ls-files: update test style
      
          Update test style in t/t30[*].sh for uniformity, that's to
     -    keep test title the same line with helper function itself.
     +    keep test title the same line with helper function itself,
     +    and fix some indentions.
      
     -    And update t/README to describe this test style.
     +    Add a new section "recommended style" in t/README to
     +    encourage people to use more modern style in test.
      
          Signed-off-by: Li Linchao <lilinchao@oschina.cn>
      
     @@ t/README: This test harness library does the following things:
       
      +Recommended style
      +-----------------
     -+Here are some recommented style that you should follow when you write some test cases.
     ++Here are some recommented styles when writing test case.
      +
      + - Keep test title the same line with test helper function itself.
      +
     @@ t/README: This test harness library does the following things:
      +
      + - End the line with a single quote.
      +
     -+ - Indent the body of here-document, and cut off prefix TAB by using
     -+ "<<-":
     ++ - Indent the body of here-document, and use "<< -" instead of "<<" to strip prefix TAB:
      +
      +  test_expect_success 'test something' '
      +      cat >expect <<-\EOF &&
     @@ t/t3002-ls-files-dashpath.sh: filesystem.
       
       test_done
      
     - ## t/t3007-ls-files-recurse-submodules.sh ##
     -@@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success '--recurse-submodules does not support --error-unmatch' '
     - 
     - test_incompatible_with_recurse_submodules () {
     - 	test_expect_success "--recurse-submodules and $1 are incompatible" "
     --		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
     --		test_i18ngrep 'unsupported mode' actual
     -+	test_must_fail git ls-files --recurse-submodules $1 2>actual &&
     -+	test_i18ngrep 'unsupported mode' actual
     - 	"
     - }
     - 
     -
       ## t/t3020-ls-files-error-unmatch.sh ##
      @@ t/t3020-ls-files-error-unmatch.sh: test_expect_success 'setup' '
       	git commit -m "add foo bar"


 t/README                           | 46 ++++++++++++++++
 t/t3001-ls-files-others-exclude.sh | 42 +++++++--------
 t/t3002-ls-files-dashpath.sh       | 86 ++++++++++++++++--------------
 t/t3020-ls-files-error-unmatch.sh  | 12 ++---
 t/t3060-ls-files-with-tree.sh      |  8 +--
 5 files changed, 123 insertions(+), 71 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..5e0539412b4 100644
--- a/t/README
+++ b/t/README
@@ -547,6 +547,52 @@ This test harness library does the following things:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
+Recommended style
+-----------------
+Here are some recommented styles when writing test case.
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
+ - Indent the body of here-document, and use "<< -" instead of "<<" to strip prefix TAB:
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
