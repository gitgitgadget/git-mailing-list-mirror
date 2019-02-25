Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD6520248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfBYXRA (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38118 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so11831051wrw.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=if2Z7h4Cgz0FM0VCbl25U48SwouF/m3nX+p4L5ohXHU=;
        b=B2pwgo5gDVJnSB5h9DTf61B/aq1Mh5VaHLPUJkRqO/7Or7r0EI+QDKLOEhG59UELKc
         5Jc0QQjVZ0MUyF2xQF5ce6aYsIM6ltyiYJP1HJnomOdf1ATv2WiDnAM9qIB4SIwVG8JS
         6bB55z9AVWAFnvXMvhCUBIvUwe/JYUoctaRcHc7B907kB6uwG6MngXPzYKp0VYwzWe1I
         0sI7oKMSBO2wVRE8E6j4xtJWwkBP+WKA01/4gMayxoIYNktlMIvzy7hi60izhkkJElYy
         O7ccMZ8tefOP0gj+CGVLMxU7C510BTly4dIsCRVMxc1zU5rjn7V32BlmZ8XroA3tpQNZ
         FVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=if2Z7h4Cgz0FM0VCbl25U48SwouF/m3nX+p4L5ohXHU=;
        b=P647Re/z5nGbXXBmQZBeBiFaio3QaxSJK7IrqTfvTsBGQZaPCkb0biDSk896QcMi0l
         isiVqTqd3rswcztMGGOg4V9xd866duWXvJGjnR1ARJB52jn6bn+xrRPvqBj0r06Uac+2
         ZN0ezcKVuRl9+s6ttBxGFyBCGiEHRJpgy0JhiZqRHql/36qjXWzyGCQzc+qpWg2UM08g
         zzY1TL/icluBvHMPLxNj3BXQv411SrmzPXUR7YhbL/UEfIMwRaOOhpKzKQ17Cl0lbOJn
         cBvIZGKEGNI5g49jGaHR1uEMp08WueXV917jiv5fT7p1m884psnIWGSw6bwvyffkhZj4
         j6CQ==
X-Gm-Message-State: AHQUAuYJQLIY20nc1f3ExBvR+ksPTlGQ5ZmsKLkjJ7XqLfqaREshPuLp
        21jU+NiZrpoPZMxw8JphMskV0ZJA
X-Google-Smtp-Source: AHgI3IZmuKluqQ3eHvkrKPNUCN2qdguBMvSvD/UjrNCNYO4wco/7zTdE2GUF89polxYggwOa9D2nxA==
X-Received: by 2002:a5d:6810:: with SMTP id w16mr13985949wru.62.1551136616247;
        Mon, 25 Feb 2019 15:16:56 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id x24sm13071199wmi.5.2019.02.25.15.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:55 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 06/27] t3903: modernize style
Date:   Mon, 25 Feb 2019 23:16:10 +0000
Message-Id: <20190225231631.30507-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Remove whitespaces after redirection operators and wrap
long lines.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 120 ++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ac55629737..4e83facf23 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -8,22 +8,22 @@ test_description='Test git stash'
 . ./test-lib.sh
 
 test_expect_success 'stash some dirty working directory' '
-	echo 1 > file &&
+	echo 1 >file &&
 	git add file &&
 	echo unrelated >other-file &&
 	git add other-file &&
 	test_tick &&
 	git commit -m initial &&
-	echo 2 > file &&
+	echo 2 >file &&
 	git add file &&
-	echo 3 > file &&
+	echo 3 >file &&
 	test_tick &&
 	git stash &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 diff --git a/file b/file
 index 0cfbf08..00750ed 100644
 --- a/file
@@ -35,7 +35,7 @@ EOF
 
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
-	git diff stash^2..stash > output &&
+	git diff stash^2..stash >output &&
 	test_cmp expect output
 '
 
@@ -74,7 +74,7 @@ test_expect_success 'apply stashed changes' '
 
 test_expect_success 'apply stashed changes (including index)' '
 	git reset --hard HEAD^ &&
-	echo 6 > other-file &&
+	echo 6 >other-file &&
 	git add other-file &&
 	test_tick &&
 	git commit -m other-file &&
@@ -99,12 +99,12 @@ test_expect_success 'stash drop complains of extra options' '
 
 test_expect_success 'drop top stash' '
 	git reset --hard &&
-	git stash list > stashlist1 &&
-	echo 7 > file &&
+	git stash list >expected &&
+	echo 7 >file &&
 	git stash &&
 	git stash drop &&
-	git stash list > stashlist2 &&
-	test_cmp stashlist1 stashlist2 &&
+	git stash list >actual &&
+	test_cmp expected actual &&
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
@@ -113,9 +113,9 @@ test_expect_success 'drop top stash' '
 
 test_expect_success 'drop middle stash' '
 	git reset --hard &&
-	echo 8 > file &&
+	echo 8 >file &&
 	git stash &&
-	echo 9 > file &&
+	echo 9 >file &&
 	git stash &&
 	git stash drop stash@{1} &&
 	test 2 = $(git stash list | wc -l) &&
@@ -160,7 +160,7 @@ test_expect_success 'stash pop' '
 	test 0 = $(git stash list | wc -l)
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 diff --git a/file2 b/file2
 new file mode 100644
 index 0000000..1fe912c
@@ -170,7 +170,7 @@ index 0000000..1fe912c
 +bar2
 EOF
 
-cat > expect1 << EOF
+cat >expect1 <<EOF
 diff --git a/file b/file
 index 257cc56..5716ca5 100644
 --- a/file
@@ -180,7 +180,7 @@ index 257cc56..5716ca5 100644
 +bar
 EOF
 
-cat > expect2 << EOF
+cat >expect2 <<EOF
 diff --git a/file b/file
 index 7601807..5716ca5 100644
 --- a/file
@@ -198,79 +198,79 @@ index 0000000..1fe912c
 EOF
 
 test_expect_success 'stash branch' '
-	echo foo > file &&
+	echo foo >file &&
 	git commit file -m first &&
-	echo bar > file &&
-	echo bar2 > file2 &&
+	echo bar >file &&
+	echo bar2 >file2 &&
 	git add file2 &&
 	git stash &&
-	echo baz > file &&
+	echo baz >file &&
 	git commit file -m second &&
 	git stash branch stashbranch &&
 	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
 	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
-	git diff --cached > output &&
+	git diff --cached >output &&
 	test_cmp expect output &&
-	git diff > output &&
+	git diff >output &&
 	test_cmp expect1 output &&
 	git add file &&
 	git commit -m alternate\ second &&
-	git diff master..stashbranch > output &&
+	git diff master..stashbranch >output &&
 	test_cmp output expect2 &&
 	test 0 = $(git stash list | wc -l)
 '
 
 test_expect_success 'apply -q is quiet' '
-	echo foo > file &&
+	echo foo >file &&
 	git stash &&
-	git stash apply -q > output.out 2>&1 &&
+	git stash apply -q >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'save -q is quiet' '
-	git stash save --quiet > output.out 2>&1 &&
+	git stash save --quiet >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'pop -q is quiet' '
-	git stash pop -q > output.out 2>&1 &&
+	git stash pop -q >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'pop -q --index works and is quiet' '
-	echo foo > file &&
+	echo foo >file &&
 	git add file &&
 	git stash save --quiet &&
-	git stash pop -q --index > output.out 2>&1 &&
+	git stash pop -q --index >output.out 2>&1 &&
 	test foo = "$(git show :file)" &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'drop -q is quiet' '
 	git stash &&
-	git stash drop -q > output.out 2>&1 &&
+	git stash drop -q >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
 test_expect_success 'stash -k' '
-	echo bar3 > file &&
-	echo bar4 > file2 &&
+	echo bar3 >file &&
+	echo bar4 >file2 &&
 	git add file2 &&
 	git stash -k &&
 	test bar,bar4 = $(cat file),$(cat file2)
 '
 
 test_expect_success 'stash --no-keep-index' '
-	echo bar33 > file &&
-	echo bar44 > file2 &&
+	echo bar33 >file &&
+	echo bar44 >file2 &&
 	git add file2 &&
 	git stash --no-keep-index &&
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
 test_expect_success 'stash --invalid-option' '
-	echo bar5 > file &&
-	echo bar6 > file2 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
 	git add file2 &&
 	test_must_fail git stash --invalid-option &&
 	test_must_fail git stash save --invalid-option &&
@@ -486,11 +486,12 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test_when_finished "git reset --hard HEAD && git checkout master &&
+	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
@@ -498,14 +499,15 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
-	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test_when_finished "git reset --hard HEAD && git checkout master &&
+	git branch -D stash-branch" &&
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
@@ -518,10 +520,10 @@ test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
@@ -536,10 +538,10 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	echo "1	0	file" >expected &&
@@ -551,10 +553,10 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
-	echo bar >> file &&
+	echo bar >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
@@ -574,7 +576,7 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	echo "1	0	file" >expected &&
@@ -586,7 +588,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-	echo foo >> file &&
+	echo foo >>file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
 	cat >expected <<-EOF &&
@@ -606,9 +608,9 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
-	echo foo > file &&
+	echo foo >file &&
 	git stash &&
-	echo bar > file &&
+	echo bar >file &&
 	git stash &&
 	test_must_fail git stash drop $(git rev-parse stash@{0}) &&
 	git stash pop &&
@@ -620,9 +622,9 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
-	echo foo > file &&
+	echo foo >file &&
 	git stash &&
-	echo bar > file &&
+	echo bar >file &&
 	git stash &&
 	test_must_fail git stash pop $(git rev-parse stash@{0}) &&
 	git stash pop &&
@@ -632,8 +634,8 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 
 test_expect_success 'ref with non-existent reflog' '
 	git stash clear &&
-	echo bar5 > file &&
-	echo bar6 > file2 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
 	git add file2 &&
 	git stash &&
 	test_must_fail git rev-parse --quiet --verify does-not-exist &&
@@ -653,8 +655,8 @@ test_expect_success 'ref with non-existent reflog' '
 test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash clear &&
 	test_must_fail git stash drop stash@{0} &&
-	echo bar5 > file &&
-	echo bar6 > file2 &&
+	echo bar5 >file &&
+	echo bar6 >file2 &&
 	git add file2 &&
 	git stash &&
 	test_must_fail git stash drop stash@{1} &&
@@ -724,7 +726,7 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
 	test_i18ncmp expect actual
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 diff --git a/HEAD b/HEAD
 new file mode 100644
 index 0000000..fe0cbee
@@ -737,14 +739,14 @@ EOF
 test_expect_success 'stash where working directory contains "HEAD" file' '
 	git stash clear &&
 	git reset --hard &&
-	echo file-not-a-ref > HEAD &&
+	echo file-not-a-ref >HEAD &&
 	git add HEAD &&
 	test_tick &&
 	git stash &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD &&
 	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
-	git diff stash^..stash > output &&
+	git diff stash^..stash >output &&
 	test_cmp expect output
 '
 
-- 
2.21.0.rc2.291.g17236886c5

