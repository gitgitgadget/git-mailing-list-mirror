Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4217620248
	for <e@80x24.org>; Sun, 21 Apr 2019 08:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDUILb (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 04:11:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42184 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUILa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 04:11:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so4329714pfi.9
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/JpLdHjhw5Ion9B01LEHJOAGwOhB0QrGVWJolHkpps=;
        b=pcspQtZNxdjNUYlwCXqMjzQIYHSlDM+vgw0v7VZ2P3LIO1O7UNcCViHBwBYe7LyW8Y
         kHveygyS87/2Tpw3Vm32+vlQYA2RbgoW4ObCOTy6qRJuZrOUZ0wP+dha3l+FMcswOfUu
         pqYNvsosv8Q8tVInyquhdb9MPjKvVjG7zd4lSf+tEwdxr1oQbgXqYLsB4A+DB7yv8XXY
         XQ2/gbBhCjngXEhaI797GHrFGGzq9x9AdCP8url1X3UlcoWYoD22V5vNH7Mw0xUw7/kA
         /vbYniPObB2mjw2xXW5lk4sMxCvubyopJohTSWhNFZGIbaibfPgI6Wuv5RePfOP4etL7
         v2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/JpLdHjhw5Ion9B01LEHJOAGwOhB0QrGVWJolHkpps=;
        b=K3Xf+vVmwzC+DoUhBIrYaevKovZ06RLQXEld8ALgqLNTdKv3/Y2htPOJraMMA8DG+Z
         D1+I8/AiL5cocx4ePGJos3o4hWU7QlNGn2HSo6oaFs0iVKkcmJqnTNJpWKvi+3d9NUA/
         F9BaIHWgX7lMyyKjrtqkPi1LFz5+4fb0txOEQG2UHGPfLMI6kl0mjMyqa/uBGRdA/iR/
         A+s0hEOaQOqTQ17lysKwaBiD7nFlzOK0qGC6w6tUxnmBfVTllq2ePAq9Rxzgl6CbZ3f0
         Mmji5FDc5MbBQcsZT/+eo6wAj6GOLmHk0vKxcZSxUVYK3tsDFHrsGWUtvi4C+J0di8xY
         bA2A==
X-Gm-Message-State: APjAAAXBHrIXM3LAJ2+lyw1ZHfm7W+ZvVG7Ef2qvlEz4NtwMDMp/dAqp
        WonF03VPqhfGMTI8v3OO241rylmn
X-Google-Smtp-Source: APXvYqzgZRpEdeqORaaLxwSwo/20scffXcXHBzhp1UNAjo1qLr8no30qkSRhB3KrKzSgLTzhLlb8hQ==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr12858972pgm.119.1555834289275;
        Sun, 21 Apr 2019 01:11:29 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:647:4b00:5d::661d])
        by smtp.gmail.com with ESMTPSA id e8sm14839462pfc.47.2019.04.21.01.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 01:11:28 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:11:26 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v7 4/6] rebase: fast-forward --onto in more cases
Message-ID: <27cbcfaeae91b9abe2726995b5f26d23892cb7ec.1555832783.git.liu.denton@gmail.com>
References: <cover.1555523176.git.liu.denton@gmail.com>
 <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when we had the following graph,

	A---B---C (master)
	     \
	      D (side)

running 'git rebase --onto master... master side' would result in D
being always rebased, no matter what. However, the desired behavior is
that rebase should notice that this is fast-forwardable and do that
instead.

Add detection to `can_fast_forward` so that this case can be detected
and a fast-forward will be performed. First of all, rewrite the function
to use gotos which simplifies the logic. Next, since the

	options.upstream &&
	!oidcmp(&options.upstream->object.oid, &options.onto->object.oid)

conditions were removed in `cmd_rebase`, we reintroduce a substitute in
`can_fast_forward`. In particular, checking the merge bases of
`upstream` and `head` fixes a failing case in t3416.

The abbreviated graph for t3416 is as follows:

		    F---G topic
		   /
	  A---B---C---D---E master

and the failing command was

	git rebase --onto master...topic F topic

Before, Git would see that there was one merge base (C), and the merge
and onto were the same so it would incorrectly return 1, indicating that
we could fast-forward. This would cause the rebased graph to be 'ABCFG'
when we were expecting 'ABCG'.

With the additional logic, we detect that upstream and head's merge base
is F. Since onto isn't F, it means we're not rebasing the full set of
commits from master..topic. Since we're excluding some commits, a
fast-forward cannot be performed and so we correctly return 0.

Add '-f' to test cases that failed as a result of this change because
they were not expecting a fast-forward so that a rebase is forced.

While we're at it, remove a trailing whitespace from rebase.c.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c               | 29 ++++++++++++++++++++---------
 t/t3400-rebase.sh              |  2 +-
 t/t3404-rebase-interactive.sh  |  2 +-
 t/t3432-rebase-fast-forward.sh |  4 ++--
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index de10b6f5ad..fdb42eb09f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -895,8 +895,8 @@ static int is_linear_history(struct commit *from, struct commit *to)
 	return 1;
 }
 
-static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
-			    struct object_id *merge_base)
+static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
 	struct commit_list *merge_bases = NULL;
@@ -915,6 +915,17 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
+	if (!upstream)
+		goto done;
+
+	free_commit_list(merge_bases);
+	merge_bases = get_merge_bases(upstream, head);
+	if (!merge_bases || merge_bases->next)
+		goto done;
+
+	if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
+		goto done;
+
 	res = 1;
 
 done:
@@ -1688,13 +1699,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Check if we are already based on onto with linear history,
-	 * but this should be done only when upstream and onto are the same
-	 * and if this is not an interactive rebase.
+	 * in which case we could fast-forward without replacing the commits
+	 * with new commits recreated by replaying their changes. This
+	 * optimization must not be done if this is an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision &&
-	    options.upstream &&
-	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
+		    &merge_base) &&
+	    !is_interactive(&options) && !options.restrict_revision) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
@@ -1788,7 +1799,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH | RESET_ORIG_HEAD | 
+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf))
 		die(_("Could not detach HEAD"));
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 460d0523be..604d624ff8 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -295,7 +295,7 @@ test_expect_success 'rebase--am.sh and --show-current-patch' '
 		echo two >>init.t &&
 		git commit -a -m two &&
 		git tag two &&
-		test_must_fail git rebase --onto init HEAD^ &&
+		test_must_fail git rebase -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
 		grep "show.*$(git rev-parse two)" stderr
 	)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b60b11f9f2..f054186cc7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1066,7 +1066,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
 '
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 4f04d67fd7..d0e5b1f3e6 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -64,9 +64,9 @@ test_expect_success 'add work to upstream' '
 changes='our and their changes'
 test_rebase_same_head success --onto B B
 test_rebase_same_head success --onto B... B
-test_rebase_same_head failure --onto master... master
+test_rebase_same_head success --onto master... master
 test_rebase_same_head failure --fork-point --onto B B
 test_rebase_same_head failure --fork-point --onto B... B
-test_rebase_same_head failure --fork-point --onto master... master
+test_rebase_same_head success --fork-point --onto master... master
 
 test_done
-- 
2.21.0.967.gf85e14fd49

