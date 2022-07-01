Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355AAC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 11:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiGALED (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGALEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 07:04:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7039165
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 04:03:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so2710316wrc.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y93AsWJw/a2ZQoMZ+T8ZT9EOdckqZxBlmFS9YsKkhHs=;
        b=oF4XL/FusoJQAn42iu2UAYnQS2Q445PDo6fFUMxvu19XKv/TnyOotcwkAC0LCw2p7/
         4hvbGukz31Wxp7ixtjI9ZPkZy63Q7DNTCOMu4TY1x74X5Q392iHApLUoTYrZs/d69FLy
         n/iLL9YpEZN9uT9dKcLaZ1R8ZEKZkqzwaZJtpg7QN+hIcfM+nrBLh7/7Hdy+juI8Aw53
         27qwU7W4AxGfrq5JgIeZ0MffqwRKcaK/5MFlWqM4gK5ZG+lRc/OvyWJvXk2fK5ovlNnI
         PbR6Nqk3ZRah6+Yzz13rSWvOCmO7cn8/CD36qaelwPtcrjIjAQfxZuiYcQYP6RlFAupX
         vCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y93AsWJw/a2ZQoMZ+T8ZT9EOdckqZxBlmFS9YsKkhHs=;
        b=ftnp0YCU6crIDSpBlD+voHiIrkGUB3bb6NVEiCnfHrvebRl8X5eVwLqGB7yOTesRC6
         cohEh/de7gr6hRHaokOPOr83vdJ98+XAg8BPVkw4sDOL5XD8GLJ5l4HGwEaWVG/KfOtL
         gHJ8SSchvT+Bm2cCTOH1b7txw8LwdSKmlvDAdJ494OizjXM9s2nJ0012x64VN8wTfLAU
         IqGlrJ6VLA81SitsWMlNzH5FREuknBIXLM4S1Cjfcjd0/5rsRdLwZd52VmM62CPZ5S8+
         ojsMAayF60KyAQr7YzX2Hk7UIiPQssQlO+GVISdmYxXyjMIobhv6+sLwkCcvtMT9MCho
         0wJA==
X-Gm-Message-State: AJIora+lcEGlRNKKfjnQh5xWJUahJ4LetRJEKV4/HaesVUc8+09pwN3k
        enf7F79OG7emmfeGzVKcwbqaJ8MIagE=
X-Google-Smtp-Source: AGRyM1upzAFNnwzz7534vz3i9zFfhI7rAXL+c7pHaLDE38uj1LoOxcrIAemqf4hD6FGZMh6TMHREhQ==
X-Received: by 2002:a5d:4cc7:0:b0:21b:9cfd:ee18 with SMTP id c7-20020a5d4cc7000000b0021b9cfdee18mr13934530wrt.355.1656673436754;
        Fri, 01 Jul 2022 04:03:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c144900b0039ee51fda45sm10013682wmi.2.2022.07.01.04.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 04:03:56 -0700 (PDT)
Message-Id: <pull.1269.v5.git.1656673435357.gitgitgadget@gmail.com>
In-Reply-To: <pull.1269.v4.git.1656568797328.gitgitgadget@gmail.com>
References: <pull.1269.v4.git.1656568797328.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 11:03:55 +0000
Subject: [PATCH v5] ls-files: update test style
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1269%2FCactusinhand%2Fllc%2Ffix-test-title-style-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1269/Cactusinhand/llc/fix-test-title-style-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1269

Range-diff vs v4:

 1:  d0ee9836f23 ! 1:  6cbb4e5fd49 ls-files: update test style
     @@ t/README: This test harness library does the following things:
      +      test_cmp expect actual
      +  '
      +
     ++ - Quote or escape the EOF at the head of a here document when
     ++   there is no variable interpolation in it:
     ++
     ++  cmd <<-"EOF"
     ++  literal here-doc text
     ++  EOF
     ++
     ++  Or:
     ++
     ++  cmd <<-\EOF
     ++  literal here-doc text
     ++  EOF
     ++
      +
       Do's & don'ts
       -------------


 t/README                           | 60 +++++++++++++++++++++
 t/t3001-ls-files-others-exclude.sh | 42 +++++++--------
 t/t3002-ls-files-dashpath.sh       | 86 ++++++++++++++++--------------
 t/t3020-ls-files-error-unmatch.sh  | 12 ++---
 t/t3060-ls-files-with-tree.sh      |  8 +--
 5 files changed, 137 insertions(+), 71 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..7d63697fb52 100644
--- a/t/README
+++ b/t/README
@@ -547,6 +547,66 @@ This test harness library does the following things:
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
+      ... test body ...
+  '
+
+   Instead of:
+
+  test_expect_success \
+      'test title' \
+      '... test body ...'
+
+
+ - End the line with a single quote.
+
+ - Indent the body of here-document, and use "<<-" instead of "<<"
+   to strip leading TABs used for indentation:
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
+ - Quote or escape the EOF at the head of a here document when
+   there is no variable interpolation in it:
+
+  cmd <<-"EOF"
+  literal here-doc text
+  EOF
+
+  Or:
+
+  cmd <<-\EOF
+  literal here-doc text
+  EOF
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
