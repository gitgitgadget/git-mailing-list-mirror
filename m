Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019B71F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEHANS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41265 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEHANS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id d12so4189098wrm.8
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pog+FsMGlxD6uLXhYHSM5BUeX61/18JkR35EB82OXBE=;
        b=pBsDh9pAgnauR8/M27n7Y2Y02uVbZWLYB0aGKMZXK/o8gtEi2IwyJDjRzB8bmDovs5
         K/QtWVtJiYfV19JuXBA4WIcqWSEA6LW47DA/EH/bxPLe70f7+IIJzcQGjRsDfDlwSR32
         GLMpTHs2onnR8aPoXaYx7ajbgTF0zR0rWA6hc8Dx8TnsroAY78bNeFn3YHvh+9VxmoWx
         qjhoXoYwPqljKoDY2nnNIWfXHJTcBBNRuE6h5kppXNoKVVATih06+rPPeQk7kb/iT+im
         Fh+oWMuWIjC02e5P4SUjyFfN/ObMMh8JNAJLeNqxGDNNCuCOS8xzBf8NBdB9MMQGs9ON
         1Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pog+FsMGlxD6uLXhYHSM5BUeX61/18JkR35EB82OXBE=;
        b=B7v0qTsfdxywx5RNyq+G13Ql9GzG2Ttm+wRRgQbdB1qWPPcv8B21mPUzeQU1r4boWa
         /aL5CkO1PFgzaqMrycg+V+umqu9GWG4JJmjJVbpbQHDK52+mMBXJ60lyF71vcJNe5t2S
         5wOrUgVjP4pEErFass0tNbwhIzA7XHMzJAuJV5jnR+UXKFnpSpsXcGnnN9w+T5I6ETtN
         JAmAX77xNjOxcVF8ugxiAfgj6rDXD+5UcMfTljUca1F8mzKmaXTBP6zMX2VZFOZQE0l/
         UCsMLQh11t9T9sCHRkeX9B4ZoPWMeeK/7GoLsEEmlFet5VIUAggLDFDL/owus9JoeTJN
         aD1w==
X-Gm-Message-State: APjAAAWW3DMyOTuJzxfLmisOety08bDsg7tc95PjdJLsQIO/U5GV3Iqk
        wmjQO+5zZbh2ZK7CFyz5itQ+itGrjtA=
X-Google-Smtp-Source: APXvYqywLCDXFGLMqJ1liOm8Fn6RVCSjZb8ilyMMmtpe4rsy3GWbFDac3DptBvJSc0A5YjBHrXzZTw==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr851532wrr.92.1557274394922;
        Tue, 07 May 2019 17:13:14 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC WIP PATCH v8 06/13] rebase: fast-forward --onto in more cases
Date:   Wed,  8 May 2019 02:12:45 +0200
Message-Id: <20190508001252.15752-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c               | 29 ++++++++++++++++++++---------
 t/t3400-rebase.sh              |  2 +-
 t/t3404-rebase-interactive.sh  |  2 +-
 t/t3432-rebase-fast-forward.sh |  4 ++--
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f7008b10af..c1000c159d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -878,8 +878,8 @@ static int is_linear_history(struct commit *from, struct commit *to)
 	return 1;
 }
 
-static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
-			    struct object_id *merge_base)
+static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
 	struct commit_list *merge_bases = NULL;
@@ -898,6 +898,17 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
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
@@ -1664,13 +1675,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
@@ -1764,7 +1775,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH | RESET_ORIG_HEAD | 
+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf))
 		die(_("Could not detach HEAD"));
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 42f147858d..45f1f65c7b 100755
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
index 1723e1a858..c7dbbd16db 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1063,7 +1063,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
 '
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index e20a8ab9c4..59cd437301 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -106,9 +106,9 @@ test_expect_success 'add work same  to upstream' '
 changes='our and their changes'
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
-test_rebase_same_head failure work same success work diff --onto master... master
+test_rebase_same_head success noop same success work diff --onto master... master
 test_rebase_same_head failure work same success work diff --fork-point --onto B B
 test_rebase_same_head failure work same success work diff --fork-point --onto B... B
-test_rebase_same_head failure work same success work diff --fork-point --onto master... master
+test_rebase_same_head success noop same success work diff --fork-point --onto master... master
 
 test_done
-- 
2.21.0.1020.gf2820cf01a

