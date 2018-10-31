Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE291F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeKAFBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:01:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34323 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeKAFBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:01:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so8144805pfe.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aQgSRdpkk9qZuY6lC8zXJHJvK5Iv6NUGr/52fhO5Bgc=;
        b=h+7uHVS4YBQMdZxFmzY+6ZAuww/wFFxOzmgEHKMNsjChukXK3vU697Tgdxhtf3GFQb
         9kXWutP9v3HIBsfLyWP82TE9QUjOUqFO4Q+22azb+ppxVjqPHuW0FOWsKBlncEYAbmEE
         O9luUGW5uUZvRI2ExTTvIoCSS+PVYoa28txZJUpCbPdjjDtLMYyahMHGDnX2bBDuh2HZ
         8oyAK/YAt9zJjiI+Cd+eg3TDDL5vQV2KDN9Vw0BpXuEZ2/BC9OO7gjlNoong9QeThIfx
         WVGWj2hJMfmvFrhjvoFZzuOFZ4TmLbmId9SblU6wrnKRR55vpI+jn0/NmFlvdKwnT+PO
         S5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aQgSRdpkk9qZuY6lC8zXJHJvK5Iv6NUGr/52fhO5Bgc=;
        b=B4QAhjScX1Bp0AZ+csZe1gum2IrQpDnoPAg8f29U9ux2qu37Fnh5sgPQnqXviH3ySK
         +znyc3csAp5wxGxza8ugls+5sfgp2L0Nsnf4UO8t3jDQ5Xjfty2/P2gzxkxcoW7K/VuC
         Vc5btQHStKj9aNTlxIoUhQ9e3or3wN0gdfIPL1KgXpRUU84dfZOxoOybxVV5DbsxRS7O
         CKpb8UC8ZddaoJDz6HwDuJ8N45AFta0kK7igmLlMu07u0jlUfzDGGF1LFN9OS0xqdDfw
         xiTur/S8qynWiaido9bWjuLaH8m7CL4SDhjUX3h2Agfp6mZ0wm6znYJbDjXBwj5naIsE
         2yEA==
X-Gm-Message-State: AGRZ1gJuZFwe6eNsnRm5qXJL3V8bPrbPooUnGHnS/0ZSMI7Yr9Rhp8rv
        VH9XUi6XITWZTlAFIT54ADUM4a98
X-Google-Smtp-Source: AJdET5cvXJ7Oym4Ji5qJS2xxHIG84ei0Toi2BVS2RrSo/WsN6kVArN4KH7cOetktAnC2bTabxPhoSw==
X-Received: by 2002:a63:4a08:: with SMTP id x8-v6mr4408087pga.34.1541016119974;
        Wed, 31 Oct 2018 13:01:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 68-v6sm34048234pfg.136.2018.10.31.13.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:01:59 -0700 (PDT)
Date:   Wed, 31 Oct 2018 13:01:59 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 20:01:52 GMT
Message-Id: <02e1de43eb0f51d272422177db378d1d4b6bad1e.1541016114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.63.git.gitgitgadget@gmail.com>
References: <pull.63.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] t3404: decouple some test cases from outcomes of previous
 test cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Originally, the `--preserve-merges` option of the `git rebase` command
piggy-backed on top of the `--interactive` feature. For that reason, the
early test cases were added to the very same test script that contains
the `git rebase -i` tests: `t3404-rebase-interactive.sh`.

However, since c42abfe7857 (rebase: introduce a dedicated backend for
--preserve-merges, 2018-05-28), the `--preserve-merges` feature got its
own backend, in preparation for converting the rest of the
`--interactive` code to built-in code, written in C rather than shell.

The reason why the `--preserve-merges` feature was not converted at the
same time is that we have something much better now: `--rebase-merges`.
That option intends to supersede `--preserve-merges`, and we will
probably deprecate the latter soon.

Once `--preserve-merges` has been deprecated for a good amount of time,
it will be time to remove it, and along with it, its tests.

In preparation for that, let's make the rest of the test cases in
`t3404-rebase-interactive.sh` independent of the test cases dedicated to
`--preserve-merges`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff89b6341a..99d1fb79a8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -387,6 +387,7 @@ test_expect_success 'edit ancestor with -p' '
 '
 
 test_expect_success '--continue tries to commit' '
+	git reset --hard D &&
 	test_tick &&
 	set_fake_editor &&
 	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
@@ -426,7 +427,7 @@ test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' '
 		git rebase -i $base &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 0 = $(git show | grep NEVER | wc -l) &&
-	git checkout to-be-rebased &&
+	git checkout @{-1} &&
 	git branch -D multi-fixup
 '
 
@@ -441,7 +442,7 @@ test_expect_success 'commit message used after conflict' '
 		git rebase --continue &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l) &&
-	git checkout to-be-rebased &&
+	git checkout @{-1} &&
 	git branch -D conflict-fixup
 '
 
@@ -456,7 +457,7 @@ test_expect_success 'commit message retained after conflict' '
 		git rebase --continue &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 2 = $(git show | grep TWICE | wc -l) &&
-	git checkout to-be-rebased &&
+	git checkout @{-1} &&
 	git branch -D conflict-squash
 '
 
@@ -481,7 +482,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 		grep "^# This is a combination of 3 commits\."  &&
 	git cat-file commit HEAD@{3} |
 		grep "^# This is a combination of 2 commits\."  &&
-	git checkout to-be-rebased &&
+	git checkout @{-1} &&
 	git branch -D squash-fixup
 '
 
@@ -494,7 +495,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
 		git rebase -i $base &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l) &&
-	git checkout to-be-rebased &&
+	git checkout @{-1} &&
 	git branch -D skip-comments
 '
 
@@ -507,7 +508,7 @@ test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
 		git rebase -i $base &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l) &&
-	git checkout to-be-rebased &&
+	git checkout @{-1} &&
 	git branch -D skip-blank-lines
 '
 
@@ -648,7 +649,7 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
 	) &&
 
 	set_fake_editor &&
-	FAKE_LINES="1 squash 2" git rebase -i to-be-rebased &&
+	FAKE_LINES="1 squash 2" git rebase -i @{-1} &&
 	test "$(git show -s --pretty=format:%an)" = "Squashed Away"
 
 '
-- 
gitgitgadget

