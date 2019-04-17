Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC0220248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfDQSBe (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45713 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQSBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so12371991plb.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QnvcPpABEYJPvPenuDZVn36suLvAo9oTH2nTnpnPGzA=;
        b=mbytz7JOtAkgHww+o6odya1YwdJ/wZo0g4D1C+viqVZSr3SiIrIphOq3VjjkEg64cl
         OAjbec/rO3IdDtbHH8YWb3l486zF+GFx1u+Xx73Qza4AWzyqZsFpvUCLhjs1PMHKVgjy
         x9biUZD534Wg1UZez1BM9qoVn/4vi2VjODwEh514Bsm17koFIJX9Zxip1VcNpaAarE4l
         lc3NN6LT8ULMBg2X744CQX7FRtp7v6Nz/dkTuJ6WWpTKBjS1JpCEzF/G46KDANZfUlCG
         /Etpr2IMIIwmVQs8uHUWz74jMWsnEvE9sXk3i7g6JxyeAetGUk99Ac13j2ftrMSrHW1h
         75NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QnvcPpABEYJPvPenuDZVn36suLvAo9oTH2nTnpnPGzA=;
        b=g7IYhqJ5mdvFyR7DrYEi4Wmg1GldwXI2LomOVgKVuXbX3r2Ncq99FTDXgDYp0X9crv
         xu+kJ478vCnUGpum9kuObYzByozBMyXEeQM6q9ocLFo87b3B5bjapOeFYKz0KwTtokDs
         TVXOiI2FYQ5gI7h6/NL/eSpP4rHLkKlvMV84xQj8hZF7HggSJYCYdlpoUys4Px1AUAnH
         kjsvahUe35w3svHYMobNpr72Riee6YPkdYsbSVhrq2V3g30S0Zl6QHvE+q/Dw0wpBt+r
         kitB0zCNleJuhbYFmkpj74LBtqxzIwXoG4tME9cUpb6Y6EcjYxc087WmRVQ5eXMEyUN4
         vcGA==
X-Gm-Message-State: APjAAAVFVeh2i72c1fntiMBC3PIeKaxiTgfLabMK7aSJrwM42OXNXaNB
        wWljP0l8WldS6oNtXy/V8N5yBDCmqUs=
X-Google-Smtp-Source: APXvYqwxmOWvS6pQJrOaDyswEH4tD7wGPsumzfptuLgKrhtPNeatq4dTH38HCfO0nNlFe60D6n17OA==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr55882556plb.174.1555524091153;
        Wed, 17 Apr 2019 11:01:31 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id j19sm69072191pfh.41.2019.04.17.11.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:30 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 4/6] rebase: fast-forward --onto in more cases
Message-ID: <2559ab54a2c6e5544595e0d66a431e249bf73ca8.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
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

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c               | 28 +++++++++++++++++++---------
 t/t3400-rebase.sh              |  2 +-
 t/t3404-rebase-interactive.sh  |  2 +-
 t/t3432-rebase-fast-forward.sh |  4 ++--
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index de10b6f5ad..f5aca1eee0 100644
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
@@ -915,6 +915,18 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
+	if (!upstream)
+		goto done;
+
+	free_commit_list(merge_bases);
+	merge_bases = get_merge_bases(upstream, head);
+	if (!merge_bases || merge_bases->next) {
+		goto done;
+	}
+
+	if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
+		goto done;
+
 	res = 1;
 
 done:
@@ -1688,13 +1700,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
+	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
+		    &merge_base) &&
+	    !is_interactive(&options) && !options.restrict_revision) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
@@ -1788,7 +1798,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
2.21.0.944.gce45564dfd

