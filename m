Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7747D20248
	for <e@80x24.org>; Mon, 15 Apr 2019 22:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfDOW32 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 18:29:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40875 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:29:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so9272563pgl.7
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mnq02rHN96XPVyG4a6LI5g3kEAAFBh9i22dZzmktRso=;
        b=qs64WU60OK/4zuBA490VskCdM3WvsE9ULTbvBv+0XtNq5v4llxnQH3aJM/pIpBL1EY
         3v2XSsc5rdyc++B4NCDL1fVq8sNvuGEn+DubRjas/JzxXt692p1Qm0F8hasMAfI6+H/4
         /uJ2o4tM4KYXB6qU5csM/ruQry4+VTyTvQx3ESWiKgPcL95O+im7zVGeRd+b4kU0FdHH
         D58ucDujxv88Ff+NfPoSwaUwWJOupyR/ttdVxcIUHpRY8DIl2HSslSqVxK0B1RhqNvFK
         gyniVaP19/G2+VQNIgYsgGzT1jmgTJi5GU29zg2W7NT5e2g+Yp9xuNFjvOhQ0k05RGc0
         cPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mnq02rHN96XPVyG4a6LI5g3kEAAFBh9i22dZzmktRso=;
        b=NIvDh77KqVuFFNDEyOQDHFwVATFhiue3o0Ntsv4fNqztZTzNCMW4b/7v3tQZOwY4XY
         NcjN1FDFGmMc+Nuk9ZG8hYMf2VZ+RDRav+QRKCBY1ZKeVJnjx1ePsUoO5ww90PSbncZ1
         Qvvyq3ITA+rgBv6L97eFkz5/9BTrXMVVURVTMeuJrZ0Gxbwb3RRCnkdRhob30glYn41N
         Z3Sb/Axj7eys60S5RpHdt/4UrUrXdJOtvb44RYhiPEjJQJ9rGjGELl6U8W0aEbfBeucJ
         SxTeUKW6NiS7mdn+JvRlGURYwrHSgsrbiajLtiE/lMm0x/jIvYc3GU3vMnfod70Yqpds
         OFjQ==
X-Gm-Message-State: APjAAAXkwGAJQieVLyFocy6BshyNnz7OUE5FHIl7DB9nUh50KthRoNvQ
        D94l8kZmvIgZds3KhiYTsTkrUjvP
X-Google-Smtp-Source: APXvYqzxSQxl0DfkA+bQDlLNzyS+6eRm9fx2ldUxzubiIQbOnKNbivDOoAZo+ytWvRgH0dvAyQuc4A==
X-Received: by 2002:a62:e304:: with SMTP id g4mr72841333pfh.71.1555367365747;
        Mon, 15 Apr 2019 15:29:25 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k6sm58245642pfj.173.2019.04.15.15.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:29:25 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:29:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 3/5] rebase: fast-forward --onto in more cases
Message-ID: <ec55da07191e7f0a1d31342053c1496405ba7d3a.1555366891.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555366891.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555366891.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c               | 40 +++++++++++++++++++++++-----------
 t/t3400-rebase.sh              |  2 +-
 t/t3404-rebase-interactive.sh  |  2 +-
 t/t3432-rebase-fast-forward.sh |  4 ++--
 4 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..7aa6a090d4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -895,12 +895,12 @@ static int is_linear_history(struct commit *from, struct commit *to)
 	return 1;
 }
 
-static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
-			    struct object_id *merge_base)
+static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
-	struct commit_list *merge_bases;
-	int res;
+	struct commit_list *merge_bases = NULL;
+	int res = 0;
 
 	if (!head)
 		return 0;
@@ -908,12 +908,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 	merge_bases = get_merge_bases(onto, head);
 	if (merge_bases && !merge_bases->next) {
 		oidcpy(merge_base, &merge_bases->item->object.oid);
-		res = oideq(merge_base, &onto->object.oid);
+		if (!oideq(merge_base, &onto->object.oid))
+			goto done;
 	} else {
 		oidcpy(merge_base, &null_oid);
-		res = 0;
+		goto done;
 	}
+
+	if (!upstream)
+		goto done;
+
 	free_commit_list(merge_bases);
+	merge_bases = get_merge_bases(upstream, head);
+	if (merge_bases && !merge_bases->next) {
+		if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
+			goto done;
+	} else
+		goto done;
+
+	res = 1;
+
+done:
+	if (merge_bases)
+		free_commit_list(merge_bases);
 	return res && is_linear_history(onto, head);
 }
 
@@ -1682,13 +1699,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Check if we are already based on onto with linear history,
-	 * but this should be done only when upstream and onto are the same
-	 * and if this is not an interactive rebase.
+	 * but this should be done if this is not an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision &&
-	    options.upstream &&
-	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+	if (can_fast_forward(options.onto, options.upstream, &options.orig_head, &merge_base) &&
+	    !is_interactive(&options) && !options.restrict_revision) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
@@ -1782,7 +1796,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
2.21.0.921.gb27c68c4e9

