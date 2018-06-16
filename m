Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91301F403
	for <e@80x24.org>; Sat, 16 Jun 2018 16:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756854AbeFPQIP (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 12:08:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33023 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756799AbeFPQIO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 12:08:14 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so14243474otj.0
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKJ34EMeAWCCFAt12JH/R9ecVueRr3i0gzj5gMb6MC0=;
        b=BN6WR5vWvV0h632YEmrVRxukmADubDYQKnCK4ZhKey9K2YtKxeCSdyaSpusk53CFOg
         0Ay5QBV42vswsguUS0q5p1+IFIFmJ8q55GPcgsAlOMajz3obZX+ZkneiADS0h8TOQK3F
         8hyon9aQ90fokeVJMLdBhr8uGVFHB7QId2V58X7BSXwtBkyqwlnce45B3II8VzCQI7NO
         2yloAlFTbGH96elGfqlnV1CuJy+W5PbiOj7VO1tdFZKx33zlFnRHeTei1gOvS6rKHj6H
         Nw8bvy4SuMS8pMryDRs7AqIg16e1HkUbIW1iO0Bg/XhCvsEAjY+3edvFhZLXdMCiaGRZ
         d99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wKJ34EMeAWCCFAt12JH/R9ecVueRr3i0gzj5gMb6MC0=;
        b=J9t6fob7h7k4sg/fGujlgZlfmfnmI6kgmj4Y8K0aLTby4PSzSXBCBKVWsV3E8vSI6n
         xWGtozLV/47n3mvui7Ph2acFxZLnqjoigld4NOnkEX55viDKVbe3BrolMdTOvwPAE/9H
         eR0HQPMo1fDnjFY7kGeGq3AmgRaRdSFI1KwnHEmuxbXrh3hk5G7oN50Df0mPPn+jy7bt
         lV3vQ7tAn2Sw+7R9vDKBK87z6X9vGKXblUdXlSgiV/zeDEuAR1FQDvuWus8aEDP/bZ8X
         FhAv2UdymXtDnOsnf68op6wM57ijdVc2FY2FfoXV9x+xMwsVQLXYJGH4zwVa/YMYRTl5
         VBFg==
X-Gm-Message-State: APt69E3eIZvQGNvtjytlz2o16WILtVu4GBPWRS4pz+n7GcKTWIvfWZSo
        qF/Ul5YJ3+LNeNG70Dfxr8Y=
X-Google-Smtp-Source: ADUXVKLYvxj9zToaaXllVMYCK0brjBVi/jXzMHAbyu9K6EGKtlGF21T3SUKUlnjAzLdiFPO9Xw9iTw==
X-Received: by 2002:a9d:734:: with SMTP id 49-v6mr4061232ote.43.1529165293410;
        Sat, 16 Jun 2018 09:08:13 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id k47-v6sm5812622otb.50.2018.06.16.09.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 09:08:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     ch <cr@onlinehome.de>
Cc:     johannes.schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] git-rebase: reword squashes commits in case of merge-conflicts
Date:   Sat, 16 Jun 2018 09:08:04 -0700
Message-Id: <20180616160804.10914-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.3.g7fc0d4cb57
In-Reply-To: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de>
References: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 06:06:11PM +0200, ch wrote:

> During a recent rebase operation on one of my repositories a number of commits
> unexpectedly ended up getting squashed into other commits. After some
> experiments it turned out that the 'reword' instruction seems to squash the
> referenced commit into the preceding commit if there's a merge-conflict.
> 
> Here's a small reproduction recipe to illustrate the behavior:

Indeed I can reproduce.  It bisects back to when we switched to using the
rebase-helper builtin, so this started with git-2.13.0.  I can also slim down
your reproduction testcase a bit; you don't need any additional commits after
the reword, and the only reason to have commits before it is to induce a merge
conflict by dropping them.  The fact that there are lots of fixups floating
around is not necessary.

Anyway, patch below.

-- >8 --
Subject: [PATCH] sequencer: do not squash 'reword' commits when we hit
 conflicts

Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
2017-02-09), when a commit marked as 'reword' in an interactive rebase
has conflicts and fails to apply, when the rebase is resumed that commit
will be squashed into its parent with its commit message taken.

The issue can be understood better by looking at commit 56dc3ab04b
("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
introduced error_with_patch() for the edit command.  For the edit command,
it needs to stop the rebase whether or not the patch applies cleanly.  If
the patch does apply cleanly, then when it resumes it knows it needs to
amend all changes into the previous commit.  If it does not apply cleanly,
then the changes should not be amended.  Thus, it passes !res (success of
applying the 'edit' commit) to error_with_patch() for the to_amend flag.

The problematic line of code actually came from commit 04efc8b57c
("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
Note that to get to this point in the code:
  * !!res (i.e. patch application failed)
  * item->command < TODO_SQUASH
  * item->command != TODO_EDIT
  * !is_fixup(item->command) [i.e. not squash or fixup]
So that means this can only be a failed patch application that is either a
pick, revert, or reword.  For any of those cases we want a new commit, so
we should not set the to_amend flag.

Reported-by: ch <cr@onlinehome.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c              |  2 +-
 t/t3423-rebase-reword.sh | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100755 t/t3423-rebase-reword.sh

diff --git a/sequencer.c b/sequencer.c
index cca968043e..9e6d1ee368 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3217,7 +3217,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			} else if (res && is_rebase_i(opts) && item->commit)
 				return res | error_with_patch(item->commit,
 					item->arg, item->arg_len, opts, res,
-					item->command == TODO_REWORD);
+					0);
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
new file mode 100755
index 0000000000..31c09efd22
--- /dev/null
+++ b/t/t3423-rebase-reword.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='git rebase interactive with rewording'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	test_commit master file-1 test &&
+
+	git checkout -b stuff &&
+
+	test_commit feature_a file-2 aaa &&
+	test_commit feature_b file-2 ddd
+'
+
+test_expect_success 'reword without issues functions as intended' '
+	git checkout stuff^0 &&
+
+	set_fake_editor &&
+	FAKE_LINES="pick 1 reword 2" FAKE_COMMIT_MESSAGE="feature_b_reworded" \
+		git rebase -i -v master &&
+
+	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
+	test $(git rev-list --count HEAD) = 3
+'
+
+test_expect_success 'reword comes after a conflict preserves commit' '
+	git checkout stuff^0 &&
+
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 2" \
+		git rebase -i -v master &&
+
+	git checkout --theirs file-2 &&
+	git add file-2 &&
+	FAKE_COMMIT_MESSAGE="feature_b_reworded" git rebase --continue &&
+
+	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
+	test $(git rev-list --count HEAD) = 2
+'
+
+test_done
-- 
2.18.0.rc2.3.g7fc0d4cb57

