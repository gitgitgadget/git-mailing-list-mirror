Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1507C20248
	for <e@80x24.org>; Fri,  5 Apr 2019 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDEVkJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 17:40:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43358 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVkH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 17:40:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so3685792plt.10
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YirZ6kFa6CRXi2d4lqIUiHnBT8Dwb6MHcO44Y6kQOrc=;
        b=kJWMBWdCd3MdgxMMWOgttAbLZo57I9aNXQt37OT6ShEn3N5sto3ZuQZWdyhnETU+Sx
         efhwFqB/+mAeikjb/kns5DCgBQ+BOGT/VWtL9ud7GPbr6JSFhetK+CU27FHZEFkxpCxN
         0HrY+NdbfQ9xTEJHv3n4YpwI5gaIXQSBhvhph8gp28QPutpA0mDase0QvbnLISX4gF/b
         9h4v2I1HIZGRvc63Vt2O93w57yOfpVSVEId2UPgbz+uqlY5WOdn4v0LvBz1wDcqT4zui
         IfaZSVLFQ40G5pty1SAQuFsqT1RP+68DUwDlY6+p5wF6bb8TmFinenT9YY5S5hfHGmYb
         Fu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YirZ6kFa6CRXi2d4lqIUiHnBT8Dwb6MHcO44Y6kQOrc=;
        b=JUmBOs/bZvLu2pu7MK8k1IcBgrf9oQucI6/IZ1/Y9YdVQZh/LcFi0hNs2cHMpKwBJH
         4UnbvVDJUpY6h4U2eme5sPsVdGLS3WURnC7EklH2UCUPpPvycl7LDnWaYUviqG+Lz8KR
         rnW+KP2ILrtP2yvnn33yDj63tvvu3fJzSxGdHrshf6YE/6IgcKwezUkp+rcsXcPdOMvL
         u9cz5pCvOIWsEd5FWZx2RRgLdA49UAfj5GywYaS0sb48NPGXEwUJLMh0MTPWMwCALmwM
         9F06pfhtGsYX3YrW62yS5VNgRrcf/M+Jyo8U1kaBGNCyvkXOL4raSrZQaWm7lB90W6Sf
         IaRg==
X-Gm-Message-State: APjAAAUGEsA7qE1OGeDuuvWzDgPfgTGP2qzwUsLm/hkc0+tj7k+cT3jt
        2YvT9RA9yJYQyIU4/EWnxmSElPmb
X-Google-Smtp-Source: APXvYqy8XMoGP2rFMm40M2kenODwaJAvSCPMVu0cb5xsfMdumN6D1t/4jWf7QGXApouRtSQmQ/2m0g==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr14886960pls.73.1554500406663;
        Fri, 05 Apr 2019 14:40:06 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id d15sm33673240pfo.34.2019.04.05.14.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:40:05 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:40:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 3/4] rebase: fast-forward --onto in more cases
Message-ID: <338a4b6b3a40d64d3eac37cc4d19ebe55ec02282.1554500051.git.liu.denton@gmail.com>
References: <cover.1554151449.git.liu.denton@gmail.com>
 <cover.1554500051.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554500051.git.liu.denton@gmail.com>
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
 t/t3432-rebase-fast-forward.sh |  2 +-
 4 files changed, 30 insertions(+), 16 deletions(-)

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
index b7c9af17c3..357cf17bdd 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -54,6 +54,6 @@ test_expect_success 'add work to upstream' '
 changes='our and their changes'
 test_rebase_same_head success --onto B B
 test_rebase_same_head success --onto B... B
-test_rebase_same_head failure --onto master... master
+test_rebase_same_head success --onto master... master
 
 test_done
-- 
2.21.0.843.gd0ae0373aa

