Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11201F404
	for <e@80x24.org>; Tue, 18 Sep 2018 04:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeIRJjX (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 05:39:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38026 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRJjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 05:39:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so333848pgb.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 21:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lYePnEXXEqkH2WhH1hC+SQE+FTN4GDO8qrhOgGx32q4=;
        b=pik/cE/ga8Exy19tKYGGt1ZARUFDDNYqvr6/X2U0u0Rd/ET/NANITO/XvrJx842tW3
         drie27ooovWpd2FDLG+vzvF/o1WkPF/q9ScEFalp53lVijJh4Lwag/tooSELW3thaYb2
         ZDlvQhnzbKisSr2vV4PETxxzrCAEOtV6ggPdaz9DWd7mWBaWmTzsi+ZPIcx4tvFX91BJ
         Vz23iYsa5Era+pij/hahQKC3Y3AUNMjlIO4DXnS/ofpDgKOA2i7NgzjaQg9pIR7rLCt6
         41MsQoTA/4OWolaeivu88elm+/7j48HVLIJkIDYGjko8xzEsm6PS640KHK16r04LyvSx
         7Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lYePnEXXEqkH2WhH1hC+SQE+FTN4GDO8qrhOgGx32q4=;
        b=txb4xy/k1WosiXQ13elRpsE1yA08WX9pzEbDL+gkEezP7fdJKLkCQBZp+4XumpqpcI
         oX3mVt1Y45wKGlnIdUq2vSu9wpmtW4JxXcz+rty93WJ2ru60rbTKcFvy+Bq/oOdNv/TR
         R+HACBjlrGbg9sD3QDHJlHWh/7XznzNnMToHGE9cpMBisrkoQfx6E2tv0EXD3dqRH/7E
         AKc5rZEBJGUdGKXvnDFxKIW0FMuIkLY4Y4YC9kFuvtN+0LibdlZg7a2EGE+BHhzaO6GE
         4rZRkowKXW18Z87It9rJlol9YenB+eqHx5nZZc4FXkI6bhw1SzpJgrZu78L5wBwCgHyq
         BOug==
X-Gm-Message-State: APzg51AqfO4NrmXog8TVqHpC7BGFfJk8sPj/9XP2VopKCBH3JCvrjwhX
        H/pzWe+9K1cxK8ssPX85j40EicrH
X-Google-Smtp-Source: ANB0VdbjOmTaFNJ9qLVGlEZFJYmfe4WY+z22ht+XNcOfq8url9T7lrNHAYqShmkr7j8RiB3LrII1/g==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr26359558pgt.164.1537243722771;
        Mon, 17 Sep 2018 21:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 1-v6sm28004712pfm.145.2018.09.17.21.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 21:08:41 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:08:41 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Sep 2018 04:08:33 GMT
Message-Id: <pull.25.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/6] Use generation numbers for --topo-order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
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

Derrick Stolee (6):
  prio-queue: add 'peek' operation
  test-reach: add run_three_modes method
  test-reach: add rev-list tests
  revision.c: begin refactoring --topo-order logic
  commit/revisions: bookkeeping before refactoring
  revision.c: refactor basic topo-order logic

 commit.c                   |  11 +-
 commit.h                   |   8 ++
 object.h                   |   4 +-
 prio-queue.c               |   9 ++
 prio-queue.h               |   6 +
 revision.c                 | 232 ++++++++++++++++++++++++++++++++++++-
 revision.h                 |   6 +
 t/helper/test-prio-queue.c |  10 +-
 t/t6600-test-reach.sh      |  98 +++++++++++++++-
 9 files changed, 361 insertions(+), 23 deletions(-)


base-commit: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-25%2Fderrickstolee%2Ftopo-order%2Fprogress-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-25/derrickstolee/topo-order/progress-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/25

Range-diff vs v1:

 1:  5e55669f4d = 1:  cc1ec4c270 prio-queue: add 'peek' operation
 2:  9628396af1 = 2:  404c918608 test-reach: add run_three_modes method
 3:  708b4550a1 = 3:  30dee58c61 test-reach: add rev-list tests
 4:  908442417d ! 4:  a74ae13d4e revision.c: begin refactoring --topo-order logic
     @@ -168,4 +168,4 @@
      +	struct topo_walk_info *topo_walk_info;
       };
       
     - extern int ref_excluded(struct string_list *, const char *path);
     + int ref_excluded(struct string_list *, const char *path);
 5:  a7272f2799 ! 5:  0e64fc144c commit/revisions: bookkeeping before refactoring
     @@ -27,7 +27,7 @@
       define_commit_slab(indegree_slab, int);
       
      -/* record author-date for each commit object */
     --define_commit_slab(author_date_slab, unsigned long);
     +-define_commit_slab(author_date_slab, timestamp_t);
      -
      -static void record_author_date(struct author_date_slab *author_date,
      -			       struct commit *commit)
 6:  73713bcbee ! 6:  3b185ac3b1 revision.c: refactor basic topo-order logic
     @@ -153,11 +153,11 @@
       
       /*
        * object flag allocation:
     -- * revision.h:               0---------10                                26
     -+ * revision.h:               0---------10                                26--28
     -  * fetch-pack.c:             0----5
     +- * revision.h:               0---------10                              2526
     ++ * revision.h:               0---------10                              25----28
     +  * fetch-pack.c:             01
     +  * negotiator/default.c:       2--5
        * walker.c:                 0-2
     -  * upload-pack.c:                4       11-----14  16-----19
      @@
        * builtin/show-branch.c:    0-------------------------------------------26
        * builtin/unpack-objects.c:                                 2021
     @@ -404,11 +404,11 @@
      --- a/revision.h
      +++ b/revision.h
      @@
     - #define PATCHSAME	(1u<<9)
     - #define BOTTOM		(1u<<10)
     + #define USER_GIVEN	(1u<<25) /* given directly by the user */
       #define TRACK_LINEAR	(1u<<26)
     + #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
      +#define TOPO_WALK_EXPLORED (1u<<27)
      +#define TOPO_WALK_INDEGREE (1u<<28)
     - #define ALL_REV_FLAGS	(((1u<<11)-1) | TRACK_LINEAR)
       
       #define DECORATE_SHORT_REFS	1
     + #define DECORATE_FULL_REFS	2

-- 
gitgitgadget
