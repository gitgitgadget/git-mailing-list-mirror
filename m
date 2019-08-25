Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B4B1F4B7
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfHYJMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39669 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYJMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:13 -0400
Received: by mail-io1-f66.google.com with SMTP id l7so30265026ioj.6
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vug6yjeAZuyiAksHXGUYJQdyN1mxR4NB8c8vpCD97ZA=;
        b=X5FuPb41yae7r0v6/Ati7mV9ba5xdp3wHdEvTei7Anh4fT513mv6j4MEzk3+/RHw8f
         2bITJLumxjaN0M7l01cBUtp356R3icJEqCcvQPdwr477qfwIct4iJeAOEGv0i/nMWFp/
         dq/1mjHQ1TLwrMKV+zjlf16/cg6IQkIQ5jK716D1dDNu6RLCKtWKKyzvf5fmcy/7W+gU
         W/b3WvjEmOx5+jCSwbpF0tPRpQDyrS5+eGjfom3yj1Y28QhwBFlsbq4fR1CnKnsaVMqD
         pk5gzntcG62GMeVtmkqyFHxh9tSAQr6UpewOtWjQOVoKrnxFKHG06UO+4ixbXbHOlPH1
         W4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vug6yjeAZuyiAksHXGUYJQdyN1mxR4NB8c8vpCD97ZA=;
        b=iLFGLHE8rZRXcbM1ToyFtZ0+UgFGd75X6wNhH3Zs2U1g+fDnR65ez09KVYFN3VlrPh
         pT2yPWAXiP2h/MgpQAYcq8a4eYHR01aIiPSDrDQ46v1odkdS6kPAGW8pLFiMUl3NL/zg
         RsYpYqfJTCJgy8ZqhaApCl8TBPILPiRzC/cZYrDwAvRckoGoHwoPZFVlZHDvFdCMyfQO
         raJAzxe761+/nMUwdi0Q08sW2z5GMgySScRuSGsVh7aPBAND65Ak9kTXIO+uCwTY4HZk
         o936q0mZx+6Pr8QsjIA6LbkG3T93EHLzL3cVSaXPbwr3juirjah1qsDw++3WEuOQANwF
         hZAQ==
X-Gm-Message-State: APjAAAUERZ36f72G/xGGDv7xBkkliiqiYu9JyUefTJbAUFdZHUjTo2Ca
        YaPydx+zfoq0oxIT29NRMYw+d61b
X-Google-Smtp-Source: APXvYqyjgQK/bwyGuAN2LYzbcE/X7cccswKJALzrV62yYNnXUt1xa17YVCpXMaHCNu/oFUJzEnyPwQ==
X-Received: by 2002:a05:6602:228e:: with SMTP id d14mr16435975iod.85.1566724332361;
        Sun, 25 Aug 2019 02:12:12 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id w17sm5955537ior.23.2019.08.25.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:12 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:10 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 6/9] rebase: fast-forward --onto in more cases
Message-ID: <becb924232d70520ba19c67efcd6b18a0a3c6b9d.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c               | 27 +++++++++++++++++++--------
 t/t3400-rebase.sh              |  2 +-
 t/t3404-rebase-interactive.sh  |  2 +-
 t/t3432-rebase-fast-forward.sh |  4 ++--
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 22c4f1ff93..bdb1d922a4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1260,8 +1260,8 @@ static int is_linear_history(struct commit *from, struct commit *to)
 	return 1;
 }
 
-static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
-			    struct object_id *merge_base)
+static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
 	struct commit_list *merge_bases = NULL;
@@ -1280,6 +1280,17 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
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
@@ -2028,13 +2039,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 80b23fd326..d7c724bea3 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -295,7 +295,7 @@ test_expect_success 'rebase --am and --show-current-patch' '
 		echo two >>init.t &&
 		git commit -a -m two &&
 		git tag two &&
-		test_must_fail git rebase --onto init HEAD^ &&
+		test_must_fail git rebase -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
 		grep "show.*$(git rev-parse two)" stderr
 	)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 461dd539ff..3cc9052f10 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1058,7 +1058,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
 '
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 02b2516595..d9957e5f1e 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -106,9 +106,9 @@ test_expect_success 'add work same to upstream' '
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
2.23.0.248.g3a9dd8fb08

