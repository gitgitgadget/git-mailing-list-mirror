Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C78E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJQG3M (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so11537917pgv.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xp7CR/rYHb4Mq635OCKNoGrZIITT1T2jNvHnoW6QWfw=;
        b=cNFqfWQcwVw7YfhrLPeJAkFWf57Y+d8/UDpR15JdE2dAkddgou2jkZUWuzliE8ydJH
         903Vx5A6/PjzoPPj0hZLz7P3lenIYaxGncU4OIb/pnbBcxdrEPvKyqN3exMRnqBWRmnK
         4kJipYfSUs1SLJgNEnWft7e0YAj66Dvcc1b290e2oxn9LP766JjrFK3KGVOsovH1ieOQ
         8/YttfLoMsY7XVsj/llzsx0B4ZLAWw1uzNTgTnwRtCcvVYu44FI3SrXVoSu48KVRqS68
         7GMZegI2UaU7mhnKfgNywc+1pPpTpZr+scXXajG9tbKljJCUGt4blIw/wd9lbcOjyRqs
         aJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xp7CR/rYHb4Mq635OCKNoGrZIITT1T2jNvHnoW6QWfw=;
        b=Jn7qvJmFwuKdJK0lBnWnWOfXhYbRIaeOoiRWM7/d0XdbEvbyxD7hv2uiz89cso8xJ8
         a/O5Jygg+jRD+vxTeXXUnudg7JEzCpIO4vl7oYLwl1WtB3Bw/rWJzAV3eCrzDyaQOKNQ
         00UFRCT9Gee0WS+b7vkF7jJQJJ9gUp5ufrXT10FTqqb1f2968p3c9YzLkfDObMo3mv3Q
         eZZaDrRE2baYGDCCQUNyYAS5dpPxz6sCtgNyC6nckKiaN5/wFGO48HzPK45oHzUsyQ1Q
         Ung9K0n3CmQa2RFRhFO1r8RBnTyZ1EbYJ6EGWFjoYaAzYZb8D27gmNlwFGpBGMvNVQq2
         8LCA==
X-Gm-Message-State: ABuFfoisuvj5UuoZO6Ep+WsKRXOoEHJWRMyQ7rvEzdFBaVPp5yiB3OVn
        KUqowLuYlvODVK+GrrxTWQxoc3pH
X-Google-Smtp-Source: ACcGV60TEHuYxlqtJ0GRSnjnR6tSqr7HpoX9zqyRvmfgKI9kzZRfsVVZS6xMMXKMXwmIcG9jqiVzKw==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr23824952pfk.173.1539729396926;
        Tue, 16 Oct 2018 15:36:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id n80-v6sm24588566pfh.166.2018.10.16.15.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:35 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:35 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:25 GMT
Message-Id: <pull.25.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/7] Use generation numbers for --topo-order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series performs a decently-sized refactoring of the revision-walk
machinery. Well, "refactoring" is probably the wrong word, as I don't
actually remove the old code. Instead, when we see certain options in the
'rev_info' struct, we redirect the commit-walk logic to a new set of methods
that distribute the workload differently. By using generation numbers in the
commit-graph, we can significantly improve 'git log --graph' commands (and
the underlying 'git rev-list --topo-order').

On the Linux repository, I got the following performance results when
comparing to the previous version with or without a commit-graph:

Test: git rev-list --topo-order -100 HEAD
HEAD~1, no commit-graph: 6.80 s
HEAD~1, w/ commit-graph: 0.77 s
  HEAD, w/ commit-graph: 0.02 s

Test: git rev-list --topo-order -100 HEAD -- tools
HEAD~1, no commit-graph: 9.63 s
HEAD~1, w/ commit-graph: 6.06 s
  HEAD, w/ commit-graph: 0.06 s

If you want to read this series but are unfamiliar with the commit-graph and
generation numbers, then I recommend reading 
Documentation/technical/commit-graph.txt or a blob post [1] I wrote on the
subject. In particular, the three-part walk described in "revision.c:
refactor basic topo-order logic" is present (but underexplained) as an
animated PNG [2].

Since revision.c is an incredibly important (and old) portion of the
codebase -- and because there are so many orthogonal options in 'struct
rev_info' -- I consider this submission to be "RFC quality". That is, I am
not confident that I am not missing anything, or that my solution is the
best it can be. I did merge this branch with ds/commit-graph-with-grafts and
the "DO-NOT-MERGE: write and read commit-graph always" commit that computes
a commit-graph with every 'git commit' command. The test suite passed with
that change, available on GitHub [3]. To ensure that I cover at least the
case I think are interesting, I added tests to t6600-test-reach.sh to verify
the walks report the correct results for the three cases there (no
commit-graph, full commit-graph, and a partial commit-graph so the walk
starts at GENERATION_NUMBER_INFINITY).

One notable case that is not included in this series is the case of a
history comparison such as 'git rev-list --topo-order A..B'. The existing
code in limit_list() has ways to cut the walk short when all pending commits
are UNINTERESTING. Since this code depends on commit_list instead of the
prio_queue we are using here, I chose to leave it untouched for now. We can
revisit it in a separate series later. Since handle_commit() turns on
revs->limited when a commit is UNINTERESTING, we do not hit the new code in
this case. Removing this 'revs->limited = 1;' line yields correct results,
but the performance is worse.

This series was based on ds/reachable, but is now based on 'master' to not
conflict with 182070 "commit: use timestamp_t for author_date_slab". There
is a small conflict with md/filter-trees, because it renamed a flag in
revisions.h in the line before I add new flags. Hopefully this conflict is
not too difficult to resolve.

Changes in V3: I added a new patch that updates the tab-alignment for flags
in revision.h before adding new ones (Thanks, Ævar!). Also, I squashed the
recommended changes to run_three_modes and test_three_modes from Szeder and
Junio. Thanks!

Changes in V4: I'm sending a V4 to respond to the feedback so far. Still
looking forward to more on the really big commit!

 * Removed the whitespace changes to the flags in revision.c that caused
   merge pain. 
   
   
 * The prio-queue peek function is now covered by tests when in "stack"
   mode.
   
   
 * The "add_parents_to_list()" function is now renamed to
   "process_parents()"
   
   
 * Added a new commit that expands test coverage with alternate orders and
   file history (use GIT_TEST_COMMIT_GRAPH to have
   t6012-rev-list-simplify.sh cover the new logic). These tests found a
   problem with author dates (I forgot to record them during the explore
   walk).
   
   
 * Commit message edits.
   
   

Thanks, -Stolee

[1] 
https://blogs.msdn.microsoft.com/devops/2018/07/09/supercharging-the-git-commit-graph-iii-generations/
Supercharging the Git Commit Graph III: Generations and Graph Algorithms

[2] 
https://msdnshared.blob.core.windows.net/media/2018/06/commit-graph-topo-order-b-a.png
Animation showing three-part walk

[3] https://github.com/derrickstolee/git/tree/topo-order/testA branch
containing this series along with commits to compute commit-graph in entire
test suite.

Cc: avarab@gmail.comCc: szeder.dev@gmail.com

Derrick Stolee (7):
  prio-queue: add 'peek' operation
  test-reach: add run_three_modes method
  test-reach: add rev-list tests
  revision.c: begin refactoring --topo-order logic
  commit/revisions: bookkeeping before refactoring
  revision.c: generation-based topo-order algorithm
  t6012: make rev-list tests more interesting

 commit.c                     |  11 +-
 commit.h                     |   8 ++
 object.h                     |   4 +-
 prio-queue.c                 |   9 ++
 prio-queue.h                 |   6 +
 revision.c                   | 245 +++++++++++++++++++++++++++++++++--
 revision.h                   |   6 +
 t/helper/test-prio-queue.c   |  26 ++--
 t/t0009-prio-queue.sh        |  14 ++
 t/t6012-rev-list-simplify.sh |  45 +++++--
 t/t6600-test-reach.sh        |  96 +++++++++++++-
 11 files changed, 430 insertions(+), 40 deletions(-)


base-commit: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-25%2Fderrickstolee%2Ftopo-order%2Fprogress-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-25/derrickstolee/topo-order/progress-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/25

Range-diff vs v3:

 1:  cc1ec4c270 ! 1:  2358cfd5ed prio-queue: add 'peek' operation
     @@ -8,7 +8,9 @@
          add it as prio_queue_peek().
      
          Add a reference-level comparison in t/helper/test-prio-queue.c
     -    so this method is exercised by t0009-prio-queue.sh.
     +    so this method is exercised by t0009-prio-queue.sh. Further, add
     +    a test that checks the behavior when the compare function is NULL
     +    (i.e. the queue becomes a stack).
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -56,6 +58,11 @@
      -		if (!strcmp(*argv, "get"))
      -			show(prio_queue_get(&pq));
      -		else if (!strcmp(*argv, "dump")) {
     +-			int *v;
     +-			while ((v = prio_queue_get(&pq)))
     +-			       show(v);
     +-		}
     +-		else {
      +		if (!strcmp(*argv, "get")) {
      +			void *peek = prio_queue_peek(&pq);
      +			void *get = prio_queue_get(&pq);
     @@ -63,6 +70,40 @@
      +				BUG("peek and get results do not match");
      +			show(get);
      +		} else if (!strcmp(*argv, "dump")) {
     - 			int *v;
     - 			while ((v = prio_queue_get(&pq)))
     - 			       show(v);
     ++			void *peek;
     ++			void *get;
     ++			while ((peek = prio_queue_peek(&pq))) {
     ++				get = prio_queue_get(&pq);
     ++				if (peek != get)
     ++					BUG("peek and get results do not match");
     ++				show(get);
     ++			}
     ++		} else if (!strcmp(*argv, "stack")) {
     ++			pq.compare = NULL;
     ++		} else {
     + 			int *v = malloc(sizeof(*v));
     + 			*v = atoi(*argv);
     + 			prio_queue_put(&pq, v);
     +
     +diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
     +--- a/t/t0009-prio-queue.sh
     ++++ b/t/t0009-prio-queue.sh
     +@@
     + 	test_cmp expect actual
     + '
     + 
     ++cat >expect <<'EOF'
     ++3
     ++2
     ++6
     ++4
     ++5
     ++1
     ++8
     ++EOF
     ++test_expect_success 'stack order' '
     ++	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_done
 2:  b2a1ade148 = 2:  3a4b68e479 test-reach: add run_three_modes method
 3:  b0ceb96076 = 3:  12a3f6d367 test-reach: add rev-list tests
 4:  fd1a0ab7cd = 4:  cd9eef9688 revision.c: begin refactoring --topo-order logic
 5:  e86f304082 ! 5:  f3e291665d commit/revisions: bookkeeping before refactoring
     @@ -16,7 +16,11 @@
             around the UNINTERESTING flag and other special cases depending
             on the struct rev_info. Allow this method to ignore a NULL 'list'
             parameter, as we will not be populating the list for our walk.
     +       Also rename the method to the slightly more generic name
     +       process_parents() to make clear that this method does more than
     +       add to a list (and no list is required anymore).
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
      diff --git a/commit.c b/commit.c
     @@ -28,7 +32,8 @@
       
      -/* record author-date for each commit object */
      -define_commit_slab(author_date_slab, timestamp_t);
     --
     ++implement_shared_commit_slab(author_date_slab, timestamp_t);
     + 
      -static void record_author_date(struct author_date_slab *author_date,
      -			       struct commit *commit)
      +void record_author_date(struct author_date_slab *author_date,
     @@ -64,7 +69,7 @@
       extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
       
      +/* record author-date for each commit object */
     -+define_commit_slab(author_date_slab, timestamp_t);
     ++define_shared_commit_slab(author_date_slab, timestamp_t);
      +
      +void record_author_date(struct author_date_slab *author_date,
      +			struct commit *commit);
     @@ -77,6 +82,17 @@
      diff --git a/revision.c b/revision.c
      --- a/revision.c
      +++ b/revision.c
     +@@
     + 		*cache = new_entry;
     + }
     + 
     +-static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
     +-		    struct commit_list **list, struct commit_list **cache_ptr)
     ++static int process_parents(struct rev_info *revs, struct commit *commit,
     ++			   struct commit_list **list, struct commit_list **cache_ptr)
     + {
     + 	struct commit_list *parent = commit->parents;
     + 	unsigned left_flag;
      @@
       			if (p->object.flags & SEEN)
       				continue;
     @@ -97,3 +113,39 @@
       		}
       		if (revs->first_parent_only)
       			break;
     +@@
     + 
     + 		if (revs->max_age != -1 && (commit->date < revs->max_age))
     + 			obj->flags |= UNINTERESTING;
     +-		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
     ++		if (process_parents(revs, commit, &list, NULL) < 0)
     + 			return -1;
     + 		if (obj->flags & UNINTERESTING) {
     + 			mark_parents_uninteresting(commit);
     +@@
     + 
     + static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
     + {
     +-	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
     ++	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
     + 		if (!revs->ignore_missing_links)
     + 			die("Failed to traverse parents of commit %s",
     + 			    oid_to_hex(&commit->object.oid));
     +@@
     + 	for (;;) {
     + 		struct commit *p = *pp;
     + 		if (!revs->limited)
     +-			if (add_parents_to_list(revs, p, &revs->commits, &cache) < 0)
     ++			if (process_parents(revs, p, &revs->commits, &cache) < 0)
     + 				return rewrite_one_error;
     + 		if (p->object.flags & UNINTERESTING)
     + 			return rewrite_one_ok;
     +@@
     + 				try_to_simplify_commit(revs, commit);
     + 			else if (revs->topo_walk_info)
     + 				expand_topo_walk(revs, commit);
     +-			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
     ++			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
     + 				if (!revs->ignore_missing_links)
     + 					die("Failed to traverse parents of commit %s",
     + 						oid_to_hex(&commit->object.oid));
 6:  fa6d5ef152 < -:  ---------- revision.h: add whitespace in flag definitions
 7:  020b2f50c5 ! 6:  aa0bb2221d revision.c: refactor basic topo-order logic
     @@ -1,6 +1,15 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    revision.c: refactor basic topo-order logic
     +    revision.c: generation-based topo-order algorithm
     +
     +    The current --topo-order algorithm requires walking all
     +    reachable commits up front, topo-sorting them, all before
     +    outputting the first value. This patch introduces a new
     +    algorithm which uses stored generation numbers to
     +    incrementally walk in topo-order, outputting commits as
     +    we go. This can dramatically reduce the computation time
     +    to write a fixed number of commits, such as when limiting
     +    with "-n <N>" or filling the first page of a pager.
      
          When running a command like 'git rev-list --topo-order HEAD',
          Git performed the following steps:
     @@ -139,11 +148,12 @@
          frequently, including by merge commits. A less-frequently-changed
          path (such as 'README') has similar end-to-end time since we need
          to walk the same number of commits (before determining we do not
     -    have 100 hits). However, get get the benefit that the output is
     +    have 100 hits). However, get the benefit that the output is
          presented to the user as it is discovered, much the same as a
          normal 'git log' command (no '--topo-order'). This is an improved
          user experience, even if the command has the same runtime.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
      diff --git a/object.h b/object.h
     @@ -216,10 +226,13 @@
      +	if (parse_commit_gently(c, 1) < 0)
      +		return;
      +
     ++	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
     ++		record_author_date(&info->author_date, c);
     ++
      +	if (revs->max_age != -1 && (c->date < revs->max_age))
      +		c->object.flags |= UNINTERESTING;
      +
     -+	if (add_parents_to_list(revs, c, NULL, NULL) < 0)
     ++	if (process_parents(revs, c, NULL, NULL) < 0)
      +		return;
      +
      +	if (c->object.flags & UNINTERESTING)
     @@ -366,10 +379,10 @@
       
       static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
       {
     --	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
     +-	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
      +	struct commit_list *p;
      +	struct topo_walk_info *info = revs->topo_walk_info;
     -+	if (add_parents_to_list(revs, commit, NULL, NULL) < 0) {
     ++	if (process_parents(revs, commit, NULL, NULL) < 0) {
       		if (!revs->ignore_missing_links)
       			die("Failed to traverse parents of commit %s",
      -			    oid_to_hex(&commit->object.oid));
     @@ -404,9 +417,9 @@
      --- a/revision.h
      +++ b/revision.h
      @@
     - #define USER_GIVEN		(1u<<25) /* given directly by the user */
     - #define TRACK_LINEAR		(1u<<26)
     - #define ALL_REV_FLAGS		(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
     + #define USER_GIVEN	(1u<<25) /* given directly by the user */
     + #define TRACK_LINEAR	(1u<<26)
     + #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
      +#define TOPO_WALK_EXPLORED	(1u<<27)
      +#define TOPO_WALK_INDEGREE	(1u<<28)
       
 -:  ---------- > 7:  a21febe112 t6012: make rev-list tests more interesting

-- 
gitgitgadget
