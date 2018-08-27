Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06CCD1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeH1A3g (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:29:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44885 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1A3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:29:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so108915pff.11
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jw1xoFAe0zEGm+qiyKcIEg2KpdiXM+IigKq1qaCCd+A=;
        b=eyhkJG6IqL7qIGManFxri3ZqfB4/5rSE07WreEHZXYfO8y2mN3VBKmqGF1OBgKBfzG
         BV8Ms1gZC/PBeLpYr1/Z8ooVhi/xXgNu8dmIwVMbtZynG1RNFWdVq4xNTHe68mfiAK/U
         EDJvnyMeQAumUFJ0EmK8eZUT4egKdYUiAHIKvp0RdTuogzYow339UwlAEUyIddFpgrzv
         ZxaJc7o1nk/mw/YNbUNYXlS6fweOMQrQGHlgeggpy51NtOq5FejUjs8fUSQ37825iEev
         tGdDTwb6E2Dm2Tzy2CbKodY48g729YNAbbwNO0DVAg8eI5+RB+uqoWeQImc9CW4LtdR7
         r7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jw1xoFAe0zEGm+qiyKcIEg2KpdiXM+IigKq1qaCCd+A=;
        b=fr3665DVzl4A6+z6mnxYKGEti01GjxgYBC8puWacAvBH2893P6Hd14CThMrZhTGf6s
         P1YgbGARtMOR25O240HYC3l4WjyPe/7BeoGzF8vxKZ9enJ7fmPkLziclh9Y7nR+4UYti
         8NR65p5HFsQ+Y691lmoJ42o3rbzeKwE3bD9yxruuhkZKZxCkKYToNECZnfwXldx4Taqu
         xY1b+0Q36BLb8YVHG+e6e1EpwCZOOi1032RebwXWP7X6/JcQP4ohuDjJ5Flf2v9HevZc
         ODDiV5Ud/XV+n7s/a+nVBQ0D9w4B+6Lg5X7oOOND7Pd6wWiFODT5I5fbxnHnft/00lEb
         voaQ==
X-Gm-Message-State: APzg51DoYO3vQd2XV7Bf+q83Gt2WIQZUR8Sx/9rPmp/WOXyyg7ro2Sme
        tjGvma+Yl6ZgwHY/sdP2xnxKVxC0
X-Google-Smtp-Source: ANB0VdaaFozzInVKvI0f0h84O9aHgjWZm/wRrpRIXnFjaPJrzYNGhdhLLFB4DV6/bsxApEIuGV08fg==
X-Received: by 2002:a62:990f:: with SMTP id d15-v6mr15889991pfe.162.1535402482430;
        Mon, 27 Aug 2018 13:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r85-v6sm197593pfd.144.2018.08.27.13.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:41:21 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:41:21 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 20:41:13 GMT
Message-Id: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/6] Use generation numbers for --topo-order
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

This series is based on ds/reachable.

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


base-commit: 6cc017431c1c48f80d1c6512fdcc9866cf4b7f55
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-25%2Fderrickstolee%2Ftopo-order%2Fprogress-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-25/derrickstolee/topo-order/progress-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/25
-- 
gitgitgadget
