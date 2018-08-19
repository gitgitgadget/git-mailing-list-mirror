Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569941F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHTBKp (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:10:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56238 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeHTBKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 21:10:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so12336830wmc.5
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vxwa/gQGHbfV7H+L0PUyEq44BhtWl9F4V8krXQSyjig=;
        b=dhYHksN17CBjekgxPpF33DS4EpTkOtqf2uHf3k1imjFRHG88IUipTkDCKXV01FnTXn
         wzMpOv1YRRmzUa2zOyA9v4OzzUh6C+JXO+liMS1K+RsPFPeMdBI6oeJjYhZORdR1esjv
         Kso39tMkANsBUg342VZtAsMDWsI+qhU8whs1tD9rOgJ/ZGahcJEkTbju74w+1NHuoawz
         5VWp4UnbKGUb3gy/1ndSBoiv/rxMnqFo6COJGtSut/uVxWsMxf1JMBTKRazoZfq2W4ez
         wWpb17TxL14MNFolwMGYHFKV0qho2kE3F5BjRdnJ9wh3qH8pYEMoa6A0p40Grf7quWfV
         4Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vxwa/gQGHbfV7H+L0PUyEq44BhtWl9F4V8krXQSyjig=;
        b=mDckzEE661/zdFMmPt5F+MJsc4HJhTAjHjseaYDVkV1cNDSjs8wWyAdoiNAjp+ulds
         SElPvRI1I3+2OfqEwNo+JJvYFrraxDqmMBT28UnNXM+dC6NggY/a6c8IOAIEoWAJBv1k
         clzCYXM2P+8JPAOu1BiitmnfKgWedXUZKwwC0/aej5BidAx93MPR3fP1GGdIz2M7z997
         RVW4IHUS587dfxqmii6ZqG+keGszz7VmR1a7/oWfUURycVQjI8H8IrXbsw2Glesnl4hp
         yyregQGCqe8MzuJQkM/JeW5eQnstl4z0E1bZG16E4/qXgktI7n0axy52AvL8z86K2kiJ
         hdqA==
X-Gm-Message-State: AOUpUlEYwPOMA1j3UcMp6YTZP9PKFKwhpNKDg9lK0NE+b+1/oSc8uYQx
        nanmL6WOK0KS4aRjmb1VyQTMGOho
X-Google-Smtp-Source: AA+uWPx91l4S7p9nqagA+NNc7UuBk6pXNdIviA5cgX24JlmmseBKoi+B5unlZNOmbtGzv8KzONK+qQ==
X-Received: by 2002:a1c:92:: with SMTP id 140-v6mr22361752wma.87.1534715864805;
        Sun, 19 Aug 2018 14:57:44 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id x82-v6sm30485975wmd.11.2018.08.19.14.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Aug 2018 14:57:43 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] tests: use 'test_must_be_empty' instead of 'test_cmp /dev/null <out>'
Date:   Sun, 19 Aug 2018 23:57:24 +0200
Message-Id: <20180819215725.29001-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.903.gab616d7dc6
In-Reply-To: <20180819215725.29001-1-szeder.dev@gmail.com>
References: <20180819215725.29001-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using 'test_must_be_empty' is more idiomatic than 'test_cmp /dev/null
out', and its message on error is perhaps a bit more to the point.

This patch was basically created by running:

  sed -i -e 's%test_cmp /dev/null%test_must_be_empty%' t[0-9]*.sh

with the exception of the change in 'should not fail in an empty repo'
in 't7401-submodule-summary.sh', where it was 'test_cmp output
/dev/null'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3210-pack-refs.sh                  | 6 +++---
 t/t3308-notes-merge.sh                | 2 +-
 t/t3310-notes-merge-manual-resolve.sh | 8 ++++----
 t/t4047-diff-dirstat.sh               | 4 ++--
 t/t4116-apply-reverse.sh              | 2 +-
 t/t5509-fetch-push-namespaces.sh      | 2 +-
 t/t5523-push-upstream.sh              | 2 +-
 t/t5541-http-push-smart.sh            | 2 +-
 t/t7401-submodule-summary.sh          | 2 +-
 t/t7810-grep.sh                       | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index afa27ffe2d..112cbb0e62 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -127,7 +127,7 @@ test_expect_success 'explicit pack-refs with dangling packed reference' '
 	git reflog expire --expire=all --all &&
 	git prune --expire=all &&
 	git pack-refs --all 2>result &&
-	test_cmp /dev/null result
+	test_must_be_empty result
 '
 
 test_expect_success 'delete ref with dangling packed version' '
@@ -139,7 +139,7 @@ test_expect_success 'delete ref with dangling packed version' '
 	git reflog expire --expire=all --all &&
 	git prune --expire=all &&
 	git branch -d lamb 2>result &&
-	test_cmp /dev/null result
+	test_must_be_empty result
 '
 
 test_expect_success 'delete ref while another dangling packed ref' '
@@ -150,7 +150,7 @@ test_expect_success 'delete ref while another dangling packed ref' '
 	git reflog expire --expire=all --all &&
 	git prune --expire=all &&
 	git branch -d lamb 2>result &&
-	test_cmp /dev/null result
+	test_must_be_empty result
 '
 
 test_expect_success 'pack ref directly below refs/' '
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index ab946a5153..d60588ec8f 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -183,7 +183,7 @@ test_expect_success 'merge empty notes ref (z => y)' '
 	git notes add -m "foo" &&
 	git notes remove &&
 	git notes >output_notes_z &&
-	test_cmp /dev/null output_notes_z &&
+	test_must_be_empty output_notes_z &&
 	# Do the merge (z => y)
 	git config core.notesRef refs/notes/y &&
 	git notes merge z &&
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 9c1bf6eb3d..a1cf4ec385 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -337,7 +337,7 @@ EOF
 	git notes merge --commit &&
 	# No .git/NOTES_MERGE_* files left
 	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_cmp /dev/null output &&
+	test_must_be_empty output &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
 	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
@@ -399,7 +399,7 @@ test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
 	# No .git/NOTES_MERGE_* files left
 	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_cmp /dev/null output &&
+	test_must_be_empty output &&
 	# m has not moved (still == y)
 	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
@@ -466,7 +466,7 @@ EOF
 	git notes merge --commit &&
 	# No .git/NOTES_MERGE_* files left
 	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_cmp /dev/null output &&
+	test_must_be_empty output &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
 	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
@@ -555,7 +555,7 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
 	# No .git/NOTES_MERGE_* files left
 	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_cmp /dev/null output &&
+	test_must_be_empty output &&
 	# m has not moved (still == w)
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 447a8ffa3a..7fec2cb9cd 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -940,7 +940,7 @@ test_expect_success 'diff.dirstat=0,lines' '
 test_expect_success '--dirstat=future_param,lines,0 should fail loudly' '
 	test_must_fail git diff --dirstat=future_param,lines,0 HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
-	test_cmp /dev/null actual_diff_dirstat &&
+	test_must_be_empty actual_diff_dirstat &&
 	test_i18ngrep -q "future_param" actual_error &&
 	test_i18ngrep -q "\--dirstat" actual_error
 '
@@ -948,7 +948,7 @@ test_expect_success '--dirstat=future_param,lines,0 should fail loudly' '
 test_expect_success '--dirstat=dummy1,cumulative,2dummy should report both unrecognized parameters' '
 	test_must_fail git diff --dirstat=dummy1,cumulative,2dummy HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
-	test_cmp /dev/null actual_diff_dirstat &&
+	test_must_be_empty actual_diff_dirstat &&
 	test_i18ngrep -q "dummy1" actual_error &&
 	test_i18ngrep -q "2dummy" actual_error &&
 	test_i18ngrep -q "\--dirstat" actual_error
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index ce8567f496..b99e65c086 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -42,7 +42,7 @@ test_expect_success 'apply in reverse' '
 	git reset --hard second &&
 	git apply --reverse --binary --index patch &&
 	git diff >diff &&
-	test_cmp /dev/null diff
+	test_must_be_empty diff
 
 '
 
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 75c570adca..c88df78c0b 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -44,7 +44,7 @@ test_expect_success 'pushing into a repository using a ref namespace' '
 		test_cmp expected actual &&
 		# Try a namespace with no content
 		git ls-remote "ext::git --namespace=garbage %s ../pushee" >actual &&
-		test_cmp /dev/null actual &&
+		test_must_be_empty actual &&
 		git ls-remote pushee-unnamespaced >actual &&
 		sed -e "s|refs/|refs/namespaces/namespace/refs/|" expected >expected.unnamespaced &&
 		test_cmp expected.unnamespaced actual
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index d6981ba304..c0df81a014 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -113,7 +113,7 @@ test_expect_success TTY 'quiet push' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push --quiet --no-progress upstream master 2>&1 | tee output &&
-	test_cmp /dev/null output
+	test_must_be_empty output
 '
 
 test_done
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index a2af693068..4319ef6ec7 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -226,7 +226,7 @@ test_expect_success TTY 'push --quiet silences status and progress' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit quiet &&
 	test_terminal git push --quiet >output 2>&1 &&
-	test_cmp /dev/null output
+	test_must_be_empty output
 '
 
 test_expect_success TTY 'push --no-progress silences progress but not status' '
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 1cd12b38c5..9bc841d085 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -300,7 +300,7 @@ test_expect_success 'should not fail in an empty repo' "
 	git init xyzzy &&
 	cd xyzzy &&
 	git submodule summary >output 2>&1 &&
-	test_cmp output /dev/null
+	test_must_be_empty output
 "
 
 test_done
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 825da1404a..42d5354c2a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -483,7 +483,7 @@ test_expect_success 'grep -L -C' '
 
 test_expect_success 'grep --files-without-match --quiet' '
 	git grep --files-without-match --quiet nonexistent_string >actual &&
-	test_cmp /dev/null actual
+	test_must_be_empty actual
 '
 
 cat >expected <<EOF
-- 
2.18.0.903.gab616d7dc6

