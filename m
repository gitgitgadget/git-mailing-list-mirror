Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFFA1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfH0FiD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:38:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43843 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0FiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:38:03 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so43373445ioe.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKpr0B4lGqCkK8lyinz/Ie8SCfFlUMbtdzYEIkvqLM0=;
        b=GtIgBL43KCQH+xf/qxyL8UUKMHOiJyJ3HoA2PEzXZmgT3dz9Yd6KO0U+yPxdZt5yhR
         DLSJTaCHfvEegwmxeT7YVXP3JZN9coVw023HD7oNWXVAyrqtJqvcZfdL+o1u9p5CDWU6
         IucVZh5MY2zkaPPcCcvvasZgdp+84wF0+uyTgy/7wtr1s6b8S9W9byg60V6yhlw8KMxc
         Gji8FOUqKQ9pefykYKvQsyP+iR1mbL/ndJIuoXjX7r8HLfHewdVKdk62Cj6teAjcEjq3
         Xih9hkQTPAGbD2EbDIDVmtFqgqOEER+81XKwym1OLcOrg08Fsxg7+Xi5FosEunzOleU7
         H7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKpr0B4lGqCkK8lyinz/Ie8SCfFlUMbtdzYEIkvqLM0=;
        b=Td+0AHKegajmnLtjTD23W3s5HpTGVXuIM4VqPj/1S3aXuARv1iWD4QBMKIqE3WtYye
         mIGQ1fSWzmQT0f9Ziihj+6Q6CWvmvwPwD8pCZqnxsffJujzlzJTM+D9sCnILzF+ana/E
         /VMKcvltkODi/6ADBRl/ZpXJ94zdYaWHpju2STgkDN9VhQKQtgfDfvsofYUzfOiVzjA7
         0BDzaeGCe+jm6YGNw9+RWWpBm1MJpWUD4KerAuuIusteMsYxClwYQluWbUgeCNBiL6oO
         wFWMx5pcxGtwac4OcUtImUp+8WWhTjV+YgZnFx0WqohlizQKIdBsIVntxtt5qH0D/QvI
         7L9g==
X-Gm-Message-State: APjAAAUnFg3Lw8R+MxhMDo/zDmF5O9JeltiQN/9cU5a5X/1Daq3WFaZF
        AE87B64KoYLG/+w3bayV3zNSTivc
X-Google-Smtp-Source: APXvYqxNSCaGhPdoQVgvxAbzO4UQGLxetvBYZ6xvxFDP7tuLIHn9dtLBW05CPupuhAClPflJz43ooA==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr5087089iom.213.1566884281807;
        Mon, 26 Aug 2019 22:38:01 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id n21sm11572958iom.69.2019.08.26.22.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:38:01 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:59 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 6/9] rebase: fast-forward --onto in more cases
Message-ID: <3f208421d672215e1f65097f87e823edfca78886.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
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
index 1ddad46126..1e1406c8ba 100644
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
@@ -2027,13 +2038,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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

