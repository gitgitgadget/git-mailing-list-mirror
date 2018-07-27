Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519FF1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbeG0TLY (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:11:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44103 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbeG0TLX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:11:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so5826670wrt.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbTxXCBl+hVYKnsUwpF1hchV6PC8noH5il9kOEs1Kj0=;
        b=tW9dtGUiccYFrv7lL6rRnYmjLc28SjfA6O3hyD9fKPXEWzwcRC0vZcd0kZy0ssKOVK
         KoOKP0jq8CJR7UvmSNqZ9ncqDU90SIs9jAgr08LlidQ1d89bW0tEQpKiEOdXCquQStqw
         Lm2CmFKlTqzXHOCPrCgS0F19BES1hw1fOz+V21zfXcQl7a+scaxoyOiTjpvNLWbBVcVd
         4TrQKR23+dUKAlz+xHvjnbV//VrnVu1Km6HH8Qaw+fhkW9B3vH9i6A+RQxltCzo9n0dk
         cBR4EmxmoZFQVVWlRQoDYXNWdawi3e8E4jy7IEnIOesh40hHj2zYKjOivMFd3Hv+U4mX
         SRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbTxXCBl+hVYKnsUwpF1hchV6PC8noH5il9kOEs1Kj0=;
        b=r9nq0ISea8ERyWnFf8dfoUBTXRrcHLZ+DgVXXjRsjgmS+A+aqpigJVS1W7p379RUtg
         Suwo3GRom2er9e1/QKDShVdT4rxk8Fqt7fxW74C82E6b7OuWmesjb1eBz2cENRz83eJF
         +RZyoy1mnvePNHaDo3WTbj3c6HIEmMSq8XQ5ZiJxPqJZI/7qee0xMS1eRCz2peJu7dgB
         fPw1UKa+IrHh2g6tumn26BIUFRWfmVrTRFzDTEwGvzoZT2YL7iWeaKcllPqi+rD9wwvu
         v44MH/OiYkPSq1HJWryUNOOAhVhbJj2W/Z3m3ePBJeC2Eoqe4IlI/gV5JNV3Zcutxu77
         qXVg==
X-Gm-Message-State: AOUpUlEkbJBqaa4FTUxQSqmfUwGv6LgmeK/KszENU/HeIQVbFyzn7Vf4
        dGviknxvuZ/xtWtW6wbKL+QAKCwGZQs=
X-Google-Smtp-Source: AAOMgpcAo652DOBaM/mvRORfDqFUvT9adBefXteB/UR/aquW5+FqlmqESbIEk9LjxN98JsblijPygQ==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr6009601wrg.249.1532713701361;
        Fri, 27 Jul 2018 10:48:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j131-v6sm5493708wmb.35.2018.07.27.10.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:48:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: make use of the test_must_be_empty function
Date:   Fri, 27 Jul 2018 17:48:11 +0000
Message-Id: <20180727174811.27360-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180605154501.13502-1-szeder.dev@gmail.com>
References: <20180605154501.13502-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various tests that use an idiom of the form:

    >expect &&
    test_cmp expect actual

To instead use:

    test_must_be_empty actual

The test_must_be_empty() wrapper was introduced in ca8d148daf ("test:
test_must_be_empty helper", 2013-06-09). Many of these tests have been
added after that time. This was mostly found with, and manually pruned
from:

    git grep '^\s+>.*expect.* &&$' t

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As promised in
https://public-inbox.org/git/CACBZZX4yG5h5kk4NFQz_NzAweMa+Nh3H-39OHtcH4XWsA6FGpg@mail.gmail.com/
here's a series to refactor various test_cmp invocations to use
test_must_be_empty.

This patch is on top of "next" since one of the things being fixed up
is a test in my in-flight ab/checkout-default-remote series. It also
applies cleanly to "pu", and the only conflicts with "master" are due
to that series of mine.

 t/t0008-ignores.sh                   |  9 ++----
 t/t0030-stripspace.sh                | 17 +++++-----
 t/t0300-credentials.sh               |  3 +-
 t/t1011-read-tree-sparse-checkout.sh |  3 +-
 t/t1306-xdg-files.sh                 |  6 ++--
 t/t1403-show-ref.sh                  | 46 ++++++++++------------------
 t/t1507-rev-parse-upstream.sh        |  3 +-
 t/t2024-checkout-dwim.sh             |  3 +-
 t/t2025-worktree-add.sh              |  3 +-
 t/t2202-add-addremove.sh             |  3 +-
 t/t3001-ls-files-others-exclude.sh   | 15 +++------
 t/t3070-wildmatch.sh                 |  3 +-
 t/t3201-branch-contains.sh           | 15 +++------
 t/t3700-add.sh                       |  3 +-
 t/t3910-mac-os-precompose.sh         |  3 +-
 t/t4010-diff-pathspec.sh             |  3 +-
 t/t4015-diff-whitespace.sh           | 17 +++++-----
 t/t4039-diff-assume-unchanged.sh     |  3 +-
 t/t4200-rerere.sh                    |  9 ++----
 t/t4202-log.sh                       |  6 ++--
 t/t4210-log-i18n.sh                  |  6 ++--
 t/t5310-pack-bitmaps.sh              |  9 ++----
 t/t5313-pack-bounds-checks.sh        |  3 +-
 t/t5505-remote.sh                    |  6 ++--
 t/t5512-ls-remote.sh                 |  6 ++--
 t/t5514-fetch-multiple.sh            |  3 +-
 t/t5533-push-cas.sh                  |  6 ++--
 t/t5612-clone-refspec.sh             |  9 ++----
 t/t6000-rev-list-misc.sh             |  3 +-
 t/t6009-rev-list-parent.sh           |  6 ++--
 t/t6018-rev-list-glob.sh             | 12 +++-----
 t/t6019-rev-list-ancestry-path.sh    |  3 +-
 t/t6022-merge-rename.sh              |  3 +-
 t/t6060-merge-index.sh               |  3 +-
 t/t6300-for-each-ref.sh              |  3 +-
 t/t7004-tag.sh                       | 22 +++++--------
 t/t7006-pager.sh                     |  3 +-
 t/t7030-verify-tag.sh                |  3 +-
 t/t7063-status-untracked-cache.sh    |  3 +-
 t/t7102-reset.sh                     |  6 ++--
 t/t7106-reset-unborn-branch.sh       |  9 ++----
 t/t7401-submodule-summary.sh         |  3 +-
 t/t7502-commit.sh                    |  3 +-
 t/t7610-mergetool.sh                 |  3 +-
 t/t7810-grep.sh                      |  3 +-
 t/t9001-send-email.sh                |  3 +-
 t/t9300-fast-import.sh               |  7 ++---
 47 files changed, 113 insertions(+), 209 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c03f155a35..1744cee5e9 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -807,10 +807,9 @@ test_expect_success 'trailing whitespace is ignored' '
 	cat >expect <<EOF &&
 whitespace/untracked
 EOF
-	: >err.expect &&
 	git ls-files -o -X ignore whitespace >actual 2>err &&
 	test_cmp expect actual &&
-	test_cmp err.expect err
+	test_must_be_empty err
 '
 
 test_expect_success !MINGW 'quoting allows trailing whitespace' '
@@ -820,10 +819,9 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	>whitespace/untracked &&
 	echo "whitespace/trailing\\ \\ " >ignore &&
 	echo whitespace/untracked >expect &&
-	: >err.expect &&
 	git ls-files -o -X ignore whitespace >actual 2>err &&
 	test_cmp expect actual &&
-	test_cmp err.expect err
+	test_must_be_empty err
 '
 
 test_expect_success !MINGW,!CYGWIN 'correct handling of backslashes' '
@@ -845,10 +843,9 @@ test_expect_success !MINGW,!CYGWIN 'correct handling of backslashes' '
 	whitespace/trailing 6 \\a\\Z
 	EOF
 	echo whitespace/untracked >expect &&
-	>err.expect &&
 	git ls-files -o -X ignore whitespace >actual 2>err &&
 	test_cmp expect actual &&
-	test_cmp err.expect err
+	test_must_be_empty err
 '
 
 test_expect_success 'info/exclude trumps core.excludesfile' '
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index bbf3e39e3d..b77948c618 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -110,31 +110,30 @@ test_expect_success \
 
 test_expect_success \
     'only consecutive blank lines should be completely removed' '
-    > expect &&
 
     printf "\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
-    test_cmp expect actual
+    test_must_be_empty actual
 '
 
 test_expect_success \
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 03bd31e9f2..82eaaea0f4 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -294,8 +294,7 @@ test_expect_success 'helpers can abort the process' '
 		-c credential.helper="!f() { echo quit=1; }; f" \
 		-c credential.helper="verbatim foo bar" \
 		credential fill >stdout &&
-	>expect &&
-	test_cmp expect stdout
+	test_must_be_empty stdout
 '
 
 test_expect_success 'empty helper spec resets helper list' '
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 0c6f48f302..ba71b159ba 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -227,12 +227,11 @@ test_expect_success 'index removal and worktree narrowing at the same time' '
 '
 
 test_expect_success 'read-tree --reset removes outside worktree' '
-	>empty &&
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	git reset --hard removed &&
 	git ls-files sub/added >result &&
-	test_cmp empty result
+	test_must_be_empty result
 '
 
 test_expect_success 'print errors when failed to update worktree' '
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 8b14ab187c..21e139a313 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -114,11 +114,10 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 '
 
 test_expect_success 'Checking XDG ignore file when HOME is unset' '
-	>expected &&
 	(sane_unset HOME &&
 	 git config --unset core.excludesfile &&
 	 git ls-files --exclude-standard --ignored >actual) &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'Checking attributes in the XDG attributes file' '
@@ -132,10 +131,9 @@ test_expect_success 'Checking attributes in the XDG attributes file' '
 '
 
 test_expect_success 'Checking XDG attributes when HOME is unset' '
-	>expected &&
 	(sane_unset HOME &&
 	 git check-attr -a f >actual) &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success '$XDG_CONFIG_HOME overrides $HOME/.config/git/attributes' '
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 30354fd26c..5d955c3bff 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -26,26 +26,22 @@ test_expect_success 'show-ref' '
 	git show-ref refs/tags/A >actual &&
 	test_cmp expect actual &&
 
-	>expect &&
-
 	test_must_fail git show-ref D >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show-ref -q' '
-	>expect &&
-
 	git show-ref -q A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	git show-ref -q tags/A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	git show-ref -q refs/tags/A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref -q D >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show-ref --verify' '
@@ -54,32 +50,28 @@ test_expect_success 'show-ref --verify' '
 	git show-ref --verify refs/tags/A >actual &&
 	test_cmp expect actual &&
 
-	>expect &&
-
 	test_must_fail git show-ref --verify A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify tags/A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify D >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show-ref --verify -q' '
-	>expect &&
-
 	git show-ref --verify -q refs/tags/A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify -q A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify -q tags/A >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify -q D >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show-ref -d' '
@@ -113,19 +105,17 @@ test_expect_success 'show-ref -d' '
 	git show-ref -d --verify refs/heads/master >actual &&
 	test_cmp expect actual &&
 
-	>expect &&
-
 	test_must_fail git show-ref -d --verify master >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref -d --verify heads/master >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify -d A C >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	test_must_fail git show-ref --verify -d tags/A tags/C >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 
 '
 
@@ -178,10 +168,8 @@ test_expect_success 'show-ref --verify HEAD' '
 	git show-ref --verify HEAD >actual &&
 	test_cmp expect actual &&
 
-	>expect &&
-
 	git show-ref --verify -q HEAD >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show-ref --verify with dangling ref' '
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 349f6e10af..fa3e499641 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -138,8 +138,7 @@ test_expect_success 'branch -d other@{u}' '
 	git checkout -t -b other master &&
 	git branch -d @{u} &&
 	git for-each-ref refs/heads/master >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'checkout other@{u}' '
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 26dc3f1fc0..f79dfbbdd6 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -24,9 +24,8 @@ test_branch_upstream () {
 }
 
 status_uno_is_clean () {
-	>status.expect &&
 	git status -uno --porcelain >status.actual &&
-	test_cmp status.expect status.actual
+	test_must_be_empty status.actual
 }
 
 test_expect_success 'setup' '
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index be6e093142..166942c1bd 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -412,9 +412,8 @@ test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 		git fetch repo_upstream2 &&
 		test_must_fail git worktree add ../foo foo &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
-		>status.expect &&
 		git status -uno --porcelain >status.actual &&
-		test_cmp status.expect status.actual
+		test_must_be_empty status.actual
 	) &&
 	(
 		cd foo &&
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 17744e8c57..9ee659098c 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -48,8 +48,7 @@ test_expect_success 'Just "git add" is a no-op' '
 	>will-not-be-added &&
 	git add &&
 	git diff-index --name-status --cached HEAD >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 3fc484e8c3..3b47647ed5 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -210,8 +210,7 @@ test_expect_success 'subdirectory ignore (toplevel)' '
 		cd top &&
 		git ls-files -o --exclude-standard
 	) >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'subdirectory ignore (l1/l2)' '
@@ -219,8 +218,7 @@ test_expect_success 'subdirectory ignore (l1/l2)' '
 		cd top/l1/l2 &&
 		git ls-files -o --exclude-standard
 	) >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'subdirectory ignore (l1)' '
@@ -228,8 +226,7 @@ test_expect_success 'subdirectory ignore (l1)' '
 		cd top/l1 &&
 		git ls-files -o --exclude-standard
 	) >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show/hide empty ignored directory (setup)' '
@@ -251,8 +248,7 @@ test_expect_success 'hide empty ignored directory with --no-empty-directory' '
 		cd top &&
 		git ls-files -o -i --exclude l1 --directory --no-empty-directory
 	) >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'show/hide empty ignored sub-directory (setup)' '
@@ -277,8 +273,7 @@ test_expect_success 'hide empty ignored sub-directory with --no-empty-directory'
 		cd top &&
 		git ls-files -o -i --exclude l1 --directory --no-empty-directory
 	) >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'pattern matches prefix completely' '
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index dce102130f..46aca0af10 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -101,8 +101,7 @@ match_with_ls_files() {
 
 	match_stdout_stderr_cmp="
 		tr -d '\0' <actual.raw >actual &&
-		>expect.err &&
-		test_cmp expect.err actual.err &&
+		test_must_be_empty actual.err &&
 		test_cmp expect actual"
 
 	if test "$match_expect" = 'E'
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 0ef1b6fdcc..0ea4fc4694 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -48,16 +48,14 @@ test_expect_success 'branch --contains master' '
 test_expect_success 'branch --no-contains=master' '
 
 	git branch --no-contains=master >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 
 '
 
 test_expect_success 'branch --no-contains master' '
 
 	git branch --no-contains master >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 
 '
 
@@ -94,8 +92,7 @@ test_expect_success 'branch --contains with pattern implies --list' '
 test_expect_success 'branch --no-contains with pattern implies --list' '
 
 	git branch --no-contains=master master >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 
 '
 
@@ -123,8 +120,7 @@ test_expect_success 'branch --merged with pattern implies --list' '
 test_expect_success 'side: branch --no-merged' '
 
 	git branch --no-merged >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 
 '
 
@@ -152,8 +148,7 @@ test_expect_success 'master: branch --no-merged' '
 test_expect_success 'branch --no-merged with pattern implies --list' '
 
 	git branch --no-merged=master master >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 
 '
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 618750167a..37729ba258 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -188,9 +188,8 @@ test_expect_success 'git add --refresh with pathspec' '
 	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
 	echo "100644 $H 3	foo" | git update-index --index-info &&
 	test-tool chmtime -60 bar baz &&
-	>expect &&
 	git add --refresh bar >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	git diff-files --name-only >actual &&
 	! grep bar actual&&
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 26dd5b7f78..54ce19e353 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -187,9 +187,8 @@ test_expect_failure 'handle existing decomposed filenames' '
 	echo content >"verbatim.$Adiarnfd" &&
 	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
 	git commit -m "existing decomposed file" &&
-	>expect &&
 	git ls-files --exclude-standard -o "verbatim*" >untracked &&
-	test_cmp expect untracked
+	test_must_be_empty untracked
 '
 
 # Test if the global core.precomposeunicode stops autosensing
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index b7f25071cf..281f8fad0c 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -74,8 +74,7 @@ test_expect_success 'diff-tree pathspec' '
 	tree2=$(git write-tree) &&
 	echo "$tree2" &&
 	git diff-tree -r --name-only $tree $tree2 -- pa path1/a >current &&
-	>expected &&
-	test_cmp expected current
+	test_must_be_empty current
 '
 
 test_expect_success 'diff-tree with wildcard shows dir also matches' '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 41facf7abf..62ed0232d7 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -93,21 +93,20 @@ test_expect_success 'another test, without options' '
 	git diff >out &&
 	test_cmp expect out &&
 
-	>expect &&
 	git diff -w >out &&
-	test_cmp expect out &&
+	test_must_be_empty out &&
 
 	git diff -w -b >out &&
-	test_cmp expect out &&
+	test_must_be_empty out &&
 
 	git diff -w --ignore-space-at-eol >out &&
-	test_cmp expect out &&
+	test_must_be_empty out &&
 
 	git diff -w -b --ignore-space-at-eol >out &&
-	test_cmp expect out &&
+	test_must_be_empty out &&
 
 	git diff -w --ignore-cr-at-eol >out &&
-	test_cmp expect out &&
+	test_must_be_empty out &&
 
 	tr "Q_" "\015 " <<-\EOF >expect &&
 	diff --git a/x b/x
@@ -182,8 +181,7 @@ test_expect_success 'ignore-blank-lines: only new lines' '
 	test_seq 5 | sed "/3/i\\
 " >x &&
 	git diff --ignore-blank-lines >out &&
-	>expect &&
-	test_cmp expect out
+	test_must_be_empty out
 '
 
 test_expect_success 'ignore-blank-lines: only new lines with space' '
@@ -192,8 +190,7 @@ test_expect_success 'ignore-blank-lines: only new lines with space' '
 	test_seq 5 | sed "/3/i\\
  " >x &&
 	git diff -w --ignore-blank-lines >out &&
-	>expect &&
-	test_cmp expect out
+	test_must_be_empty out
 '
 
 test_expect_success 'ignore-blank-lines: after change' '
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 23c0e357a7..53ac44b0f0 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -34,9 +34,8 @@ test_expect_success POSIXPERM 'find-copies-harder is not confused by mode bits'
 	git add exec &&
 	git commit -m exec &&
 	git update-index --assume-unchanged exec &&
-	>expect &&
 	git diff-files --find-copies-harder -- exec >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 8417e5a4b1..65da74c766 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -267,8 +267,7 @@ rerere_gc_custom_expiry_test () {
 		git -c "gc.rerereresolved=$right_now" \
 		    -c "gc.rerereunresolved=$right_now" rerere gc &&
 		find .git/rr-cache -type f | sort >actual &&
-		>expect &&
-		test_cmp expect actual
+		test_must_be_empty actual
 	'
 }
 
@@ -536,9 +535,8 @@ test_expect_success 'multiple identical conflicts' '
 
 	# We resolved file1 and file2
 	git rerere &&
-	>expect &&
 	git rerere remaining >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	# We must have recorded both of them
 	count_pre_post 2 2 &&
@@ -548,9 +546,8 @@ test_expect_success 'multiple identical conflicts' '
 	test_must_fail git merge six.1 &&
 	git rerere &&
 
-	>expect &&
 	git rerere remaining >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	concat_insert short 6.1 6.2 >file1.expect &&
 	concat_insert long 6.1 6.2 >file2.expect &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 25b1f8cc73..0b1cd3408b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -340,10 +340,9 @@ test_expect_success PCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
 '
 
 test_expect_success 'log with grep.patternType configuration' '
-	>expect &&
 	git -c grep.patterntype=fixed \
 	log -1 --pretty=tformat:%s --grep=s.c.nd >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'log with grep.patternType configuration and command line' '
@@ -1625,9 +1624,8 @@ test_expect_success 'log diagnoses bogus HEAD' '
 '
 
 test_expect_success 'log does not default to HEAD when rev input is given' '
-	>expect &&
 	git log --branches=does-not-exist >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'set up --source tests' '
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index e585fe6129..7c519436ef 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -44,15 +44,13 @@ test_expect_success !MINGW 'log --grep searches in log output encoding (latin1)'
 '
 
 test_expect_success !MINGW 'log --grep does not find non-reencoded values (utf8)' '
-	>expect &&
 	git log --encoding=utf8 --format=%s --grep=$latin1_e >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'log --grep does not find non-reencoded values (latin1)' '
-	>expect &&
 	git log --encoding=ISO-8859-1 --format=%s --grep=$utf8_e >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 2d22a17c4a..6ee4d3f2d9 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -309,9 +309,8 @@ test_expect_success 'pack reuse respects --honor-pack-keep' '
 	done &&
 	reusable_pack --honor-pack-keep >empty.pack &&
 	git index-pack empty.pack &&
-	>expect &&
 	git show-index <empty.idx >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'pack reuse respects --local' '
@@ -319,17 +318,15 @@ test_expect_success 'pack reuse respects --local' '
 	test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
 	reusable_pack --local >empty.pack &&
 	git index-pack empty.pack &&
-	>expect &&
 	git show-index <empty.idx >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'pack reuse respects --incremental' '
 	reusable_pack --incremental >empty.pack &&
 	git index-pack empty.pack &&
-	>expect &&
 	git show-index <empty.idx >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'truncated bitmap fails gracefully' '
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 4fe4ad9d61..f1708d415e 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -90,9 +90,8 @@ test_expect_success 'matched bogus object count' '
 
 	# Unlike above, we should notice early that the .idx is totally
 	# bogus, and not even enumerate its contents.
-	>expect &&
 	git cat-file --batch-all-objects --batch-check >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	# But as before, we can do the same object-access checks.
 	test_must_fail git cat-file blob $object &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 11e14a1e0f..6edec8fed7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -74,8 +74,7 @@ test_expect_success 'add another remote' '
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" \
 		    -e "/^refs\/remotes\/second\//d" >actual &&
-		>expect &&
-		test_cmp expect actual
+		test_must_be_empty actual
 	)
 '
 
@@ -112,8 +111,7 @@ test_expect_success C_LOCALE_OUTPUT 'remove remote' '
 		check_remote_track origin master side &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" >actual &&
-		>expect &&
-		test_cmp expect actual
+		test_must_be_empty actual
 	)
 '
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ea020040e8..bc5703ff9b 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -155,14 +155,12 @@ test_expect_success 'die with non-2 for wrong repository even with --exit-code'
 
 test_expect_success 'Report success even when nothing matches' '
 	git ls-remote other.git "refs/nsn/*" >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'Report no-match with --exit-code' '
 	test_expect_code 2 git ls-remote --exit-code other.git "refs/nsn/*" >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'Report match with --exit-code' '
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 4b4b6673b8..0030c92e1a 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -152,7 +152,6 @@ test_expect_success 'git fetch --multiple (ignoring skipFetchAll)' '
 '
 
 test_expect_success 'git fetch --all --no-tags' '
-	>expect &&
 	git clone one test5 &&
 	git clone test5 test6 &&
 	(cd test5 && git tag test-tag) &&
@@ -161,7 +160,7 @@ test_expect_success 'git fetch --all --no-tags' '
 		git fetch --all --no-tags &&
 		git tag >output
 	) &&
-	test_cmp expect test6/output
+	test_must_be_empty test6/output
 '
 
 test_expect_success 'git fetch --all --tags' '
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index d38ecee217..0b0eb1d025 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -142,9 +142,8 @@ test_expect_success 'push to delete (protected, forced)' '
 		cd dst &&
 		git push --force --force-with-lease=master:master^ origin :master
 	) &&
-	>expect &&
 	git ls-remote src refs/heads/master >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'push to delete (allowed)' '
@@ -154,9 +153,8 @@ test_expect_success 'push to delete (allowed)' '
 		git push --force-with-lease=master origin :master 2>err &&
 		grep deleted err
 	) &&
-	>expect &&
 	git ls-remote src refs/heads/master >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'cover everything with default force-with-lease (protected)' '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index fac5a73851..5582b3d5fd 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -97,8 +97,7 @@ test_expect_success 'clone with --no-tags' '
 		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success '--single-branch while HEAD pointing at master' '
@@ -140,8 +139,7 @@ test_expect_success '--single-branch while HEAD pointing at master and --no-tags
 		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
-	>expect &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	test_line_count = 0 actual &&
 	# get tags with --tags overrides tagOpt
 	(
@@ -230,8 +228,7 @@ test_expect_success '--single-branch with detached' '
 		    -e "s|/remotes/origin/|/heads/|" >../actual
 	) &&
 	# nothing
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 969e4e9e52..fb4d295aa0 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -58,8 +58,7 @@ test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
 
 test_expect_success 'propagate uninteresting flag down correctly' '
 	git rev-list --objects ^HEAD^{tree} HEAD^{tree} >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'symleft flag bit is propagated down from tag' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 20e3e2554a..916d9692bc 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -31,8 +31,7 @@ test_expect_success setup '
 test_expect_success 'one is ancestor of others and should not be shown' '
 
 	git rev-list one --not four >result &&
-	>expect &&
-	test_cmp expect result
+	test_must_be_empty result
 
 '
 
@@ -144,8 +143,7 @@ test_expect_success 'ancestors with the same commit time' '
 		test_commit t$i
 	done &&
 	git rev-list t1^! --not t$i >result &&
-	>expect &&
-	test_cmp expect result
+	test_must_be_empty result
 '
 
 test_done
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index d3453c583c..02936c2f24 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -256,31 +256,27 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
 '
 
 test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
-	>expect &&
 	git rev-list --stdin <expect >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'rev-list should succeed with empty output with all refs excluded' '
-	>expect &&
 	git rev-list --exclude=* --all >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'rev-list should succeed with empty output with empty --all' '
 	(
 		test_create_repo empty &&
 		cd empty &&
-		>expect &&
 		git rev-list --all >actual &&
-		test_cmp expect actual
+		test_must_be_empty actual
 	)
 '
 
 test_expect_success 'rev-list should succeed with empty output with empty glob' '
-	>expect &&
 	git rev-list --glob=does-not-match-anything >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index dabebaee0b..beadaf6cca 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -95,10 +95,9 @@ test_expect_success 'rev-list --ancestry-path F...I' '
 
 # G.t is dropped in an "-s ours" merge
 test_expect_success 'rev-list G..M -- G.t' '
-	>expect &&
 	git rev-list --format=%s G..M -- G.t |
 	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b760c223c6..53cc9b2ffb 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -893,8 +893,7 @@ test_expect_success 'do not follow renames for empty files' '
 	git mv empty1 empty2 &&
 	git commit -m rename &&
 	test_must_fail git merge empty-base &&
-	>expect &&
-	test_cmp expect empty2
+	test_must_be_empty empty2
 '
 
 test_done
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index debadbd299..ddf34f0115 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -44,8 +44,7 @@ test_expect_success 'read-tree does not resolve content merge' '
 test_expect_success 'git merge-index git-merge-one-file resolves' '
 	git merge-index git-merge-one-file -a &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
-	>expect &&
-	test_cmp expect unmerged &&
+	test_must_be_empty unmerged &&
 	test_cmp expect-merged file &&
 	git cat-file blob :file >file-index &&
 	test_cmp expect-merged file-index
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e0496da812..024f8c06f7 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -796,9 +796,8 @@ test_expect_success ':remotename and :remoteref' '
 '
 
 test_expect_success 'for-each-ref --ignore-case ignores case' '
-	>expect &&
 	git for-each-ref --format="%(refname)" refs/heads/MASTER >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	echo refs/heads/master >expect &&
 	git for-each-ref --format="%(refname)" --ignore-case \
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d7b319e919..93a6694f0e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -693,9 +693,8 @@ test_expect_success \
 '
 
 test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
-	>expect &&
 	git tag -n 100 >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	git tag -m "A msg" 100 &&
 	echo "100             A msg" >expect &&
@@ -974,9 +973,8 @@ test_expect_success GPG 'verifying a proper tag with --format pass and format ac
 '
 
 test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
-	>expect &&
 	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 # blank and empty messages for signed tags:
@@ -1382,9 +1380,8 @@ test_expect_success 'message in editor has initial comment: first line' '
 test_expect_success \
 	'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
-	>rest.expect &&
 	sed -e 1d -e "/^#/d" <actual >rest.actual &&
-	test_cmp rest.expect rest.actual
+	test_must_be_empty rest.actual
 '
 
 get_tag_header reuse $commit commit $time >expect
@@ -1466,19 +1463,18 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 
 # All the --contains tests above, but with --no-contains
 test_expect_success 'checking that first commit is not listed in any tag with --no-contains  (hash)' "
-	>expected &&
 	git tag -l --no-contains $hash1 v* >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 "
 
 test_expect_success 'checking that first commit is in all tags (tag)' "
 	git tag -l --no-contains v1.0 v* >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 "
 
 test_expect_success 'checking that first commit is in all tags (relative)' "
 	git tag -l --no-contains HEAD~2 v* >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 "
 
 cat > expected <<EOF
@@ -1606,9 +1602,8 @@ test_expect_success 'checking that --contains can be used in non-list mode' '
 '
 
 test_expect_success 'checking that initial commit is in all tags with --no-contains' "
-	>expected &&
 	git tag -l --no-contains $hash1 v* >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 "
 
 # mixing modes and options:
@@ -1905,7 +1900,6 @@ test_expect_success 'version sort with very long prerelease suffix' '
 '
 
 test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a deep repo' '
-	>expect &&
 	i=1 &&
 	while test $i -lt 8000
 	do
@@ -1920,7 +1914,7 @@ EOF"
 	git checkout master &&
 	git tag far-far-away HEAD^ &&
 	run_with_limited_stack git tag --contains HEAD >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	run_with_limited_stack git tag --no-contains HEAD >actual &&
 	test_line_count "-gt" 10 actual
 '
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 7541ba5edb..00e09a375c 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -626,12 +626,11 @@ test_expect_success TTY 'sub-commands of externals use their own pager' '
 
 test_expect_success TTY 'external command pagers override sub-commands' '
 	sane_unset PAGER GIT_PAGER &&
-	>expect &&
 	>actual &&
 	test_config pager.external false &&
 	test_config pager.log "sed s/^/log:/ >actual" &&
 	test_terminal git --exec-path=. external log --format=%s -1 &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'command with underscores does not complain' '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 291a1e2b07..1f068714c5 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -134,9 +134,8 @@ test_expect_success GPG 'verifying tag with --format' '
 '
 
 test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
-	>expect &&
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
-	test_cmp expect actual-forged
+	test_must_be_empty actual-forged
 '
 
 test_done
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index c61e304e97..6d8256a424 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -26,9 +26,8 @@ avoid_racy() {
 }
 
 status_is_clean() {
-	>../status.expect &&
 	git status --porcelain >../status.actual &&
-	test_cmp ../status.expect ../status.actual
+	test_must_be_empty ../status.actual
 }
 
 test_lazy_prereq UNTRACKED_CACHE '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 95653a08ca..97be0d968d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -549,8 +549,7 @@ test_expect_success 'reset -N keeps removed files as intent-to-add' '
 
 	tree=$(git write-tree) &&
 	git ls-tree $tree new-file >actual &&
-	>expect &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 
 	git diff --name-only >actual &&
 	echo new-file >expect &&
@@ -563,9 +562,8 @@ test_expect_success 'reset --mixed sets up work tree' '
 		cd mixed_worktree &&
 		test_commit dummy
 	) &&
-	: >expect &&
 	git --git-dir=mixed_worktree/.git --work-tree=mixed_worktree reset >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index 0f95f00477..ecb85c3b82 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -12,9 +12,8 @@ test_expect_success 'reset' '
 	git add a b &&
 	git reset &&
 
-	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'reset HEAD' '
@@ -39,9 +38,8 @@ test_expect_success PERL 'reset -p' '
 	echo y >yes &&
 	git reset -p <yes >output &&
 
-	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	test_i18ngrep "Unstage" output
 '
 
@@ -61,9 +59,8 @@ test_expect_success 'reset --hard' '
 	test_when_finished "echo a >a" &&
 	git reset --hard &&
 
-	>expect &&
 	git ls-files >actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	test_path_is_missing a
 '
 
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 4e4c455502..1cd12b38c5 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -64,8 +64,7 @@ test_expect_success 'added submodule (subdirectory only)' "
 		cd sub &&
 		git submodule summary . >../actual
 	) &&
-	>expected &&
-	test_cmp expected actual
+	test_must_be_empty actual
 "
 
 test_expect_success 'added submodule (subdirectory with explicit path)' "
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index d33a3cb331..ca4a740da0 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -393,7 +393,6 @@ EOF
 
 test_expect_success !AUTOIDENT 'do not fire editor when committer is bogus' '
 	>.git/result &&
-	>expect &&
 
 	echo >>negative &&
 	(
@@ -403,7 +402,7 @@ test_expect_success !AUTOIDENT 'do not fire editor when committer is bogus' '
 		export GIT_EDITOR &&
 		test_must_fail git commit -e -m sample -a
 	) &&
-	test_cmp expect .git/result
+	test_must_be_empty .git/result
 '
 
 test_expect_success 'do not fire editor if -m <msg> was given' '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 047156e9d5..b18503de81 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -620,8 +620,7 @@ test_expect_success 'file with no base' '
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
-	>expected &&
-	test_cmp expected both
+	test_must_be_empty both
 '
 
 test_expect_success 'custom commands override built-ins' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index dcaab1557b..d826e24b45 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -691,8 +691,7 @@ test_expect_success 'log grep (5)' '
 
 test_expect_success 'log grep (6)' '
 	git log --author=-0700  --pretty=tformat:%s >actual &&
-	>expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'log grep (7)' '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b8e919e25d..1ef1a19003 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -253,10 +253,9 @@ test_suppress_self () {
 
 	mv msgtxt1 msgtxt1-$3 &&
 	sed -e '/^$/q' msgtxt1-$3 >"msghdr1-$3" &&
-	>"expected-no-cc-$3" &&
 
 	(grep '^Cc:' msghdr1-$3 >"actual-no-cc-$3";
-	 test_cmp expected-no-cc-$3 actual-no-cc-$3)
+	 test_must_be_empty actual-no-cc-$3)
 }
 
 test_suppress_self_unquoted () {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 9e7f96223d..f8f869e26a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2191,12 +2191,11 @@ test_expect_success 'R: --import-marks-if-exists' '
 
 test_expect_success 'R: feature import-marks-if-exists' '
 	rm -f io.marks &&
-	>expect &&
 
 	git fast-import --export-marks=io.marks <<-\EOF &&
 	feature import-marks-if-exists=not_io.marks
 	EOF
-	test_cmp expect io.marks &&
+	test_must_be_empty io.marks &&
 
 	blob=$(echo hi | git hash-object --stdin) &&
 
@@ -2227,13 +2226,11 @@ test_expect_success 'R: feature import-marks-if-exists' '
 	EOF
 	test_cmp expect io.marks &&
 
-	>expect &&
-
 	git fast-import --import-marks-if-exists=not_io.marks \
 			--export-marks=io.marks <<-\EOF &&
 	feature import-marks-if-exists=io.marks
 	EOF
-	test_cmp expect io.marks
+	test_must_be_empty io.marks
 '
 
 test_expect_success 'R: import to output marks works without any content' '
-- 
2.18.0.345.g5c9ce644c3

