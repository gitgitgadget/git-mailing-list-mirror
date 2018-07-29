Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4D2208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 13:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeG2Onm (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 10:43:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36138 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeG2Onm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 10:43:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so9823438wro.3
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RWH396x/oaQE/cqRcHDQqq7fOfOUjeke70ZlQL7bxFU=;
        b=CI5GXPw4YDA6P8C56DUr7p1J3qrIHj8u478fjm356y90+pOueR37vIgmfGS8pDNMaV
         /LKF8o1jiY+KsYIRbVvGd9EGIOh+6xNaivMEL4HwjkJr25Ss2fJB5TNXIjY+7wtWxDke
         ZLZNFvxeUxHsUkmX/oNrE/Fs+o2j0x/iuYlb+chnGXUB0clabi0wDWkJsNf5QC0y3BbU
         cYy7dzhJseFmJAmc5EJBvgSs4M5bnZLRyNS0v7reyk7nnXL5ZQcNAaKYgqfcHYe7oG29
         r437akrbFzKPazhoO+Y0zxRFsq01ebixw280S8CBdnC5xrfrKyqbWiUJQTX97IGCVfed
         OLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=RWH396x/oaQE/cqRcHDQqq7fOfOUjeke70ZlQL7bxFU=;
        b=K7Dj8qLlsIPsbNNdR2A6C3njEDDd2O3mSZhLyQ5Xuo0mXHg1FfrSjZN65lJliUMfhE
         xB+efEHaaoQqBZ36lVRoMaQ6KqWTeIEHVurVwka05ZTX8JeE90F9ncetfoez5OT5yRG7
         dfC+PF3TIpXY+GhU0A8AVME869sUx6zvFXt0FtmDaunXICt1d62prfCs7QK1PhgFGRia
         HWWpU1trvZde2Qj2cdG+2PNZDyHNIEOHd+0D9JUN9uZrNAdiWDtFn3/zSJm6Tr/sSJdV
         XwaPIyg0BP1w//KGfeXIICLUSFG6cl1I9/hU1/qdOP1rIK9bfnLAtcieaFMipludWYiq
         2iLg==
X-Gm-Message-State: AOUpUlE7nmWvArFvVCM8lysdB5SHXa69PqwG1pPuPlT50RYel1TYG9qs
        lN51O7Kdg3KejvLqzKRKLdCnEI1w
X-Google-Smtp-Source: AAOMgpciVJ+fmtpltW3R5DCopAdzb2GW6qKGHPH9y3JaZdIs4iMTo1hCPGsbpm6Qh8FbhOFwyCxeSg==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr12627539wro.263.1532869994820;
        Sun, 29 Jul 2018 06:13:14 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egi236.neoplus.adsl.tpnet.pl. [83.21.72.236])
        by smtp.gmail.com with ESMTPSA id t11-v6sm15068567wru.52.2018.07.29.06.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 06:13:13 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Clarify commit-graph and grafts/replace/shallow incompatibilities
References: <pull.11.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Jul 2018 15:13:10 +0200
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Wed, 18 Jul 2018 08:15:34 -0700 (PDT)")
Message-ID: <86h8ki89sp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

Sidenote: the GitGitGadget doesn't fold/wrap lines properly in the
cover-letter.  Not that it is much of a problem.

> One unresolved issue with the commit-graph feature is that it can
> cause issues when combined with replace objects, commit grafts, or
> shallow clones. These are not 100% incompatible, as one could be
> reasonably successful writing a commit-graph after replacing some
> objects and not have issues. The problems happen when commits that are
> already in the commit-graph file are replaced, or when git is run with
> the `--no-replace-objects` option; this can cause incorrect parents or
> incorrect generation numbers. Similar things occur with commit grafts
> and shallow clones, especially when running `git fetch --unshallow` in
> a shallow repo.

This means that these features can change the view of the history, and
if the commit-graph was created before the change, it can have stale
incorrect information -- which would lead to incorrect results if the
commit-graph feature is used.

>
> Instead of trying (and probably failing) to make these features work
> together, default to making the commit-graph feature unavailable in
> these situations. Create a new method 'commit_graph_compatible(r)'
> that checks if the repository 'r' has any of these features enabled.

Yes, the alternative would be trying to keep the commit-graph file
up-to-date with the current view of history.  But there are problems
with this approach.


With grafts (which is a deprecated feature), there is no automated entry
point.  Best what one could do is to store some kind of fingerprint of
graft file, and invalidate / recreate commit-graft file if it does not
match what is in graft file at the time of running git command that may
use commit-graft feature.

With replace objects we have two separate entry points: the git-replace
command and fetching references in refs/replace/* namespace (and
equivalent).  While the first should be not difficult to do, the second
one seems to be harder.  Additionally, there is '--no-replace-objects'
option to turn off the feature (fetch and push ignore replacement
objects automatically); so we might want to have two versions of
commit-graph: one with replacement objects feature and one without (or
something like that).

The shallow clone seems easiest, with only one automated entry points
for changing the view of history this way, and no option to disable this
feature -- but it is also the least interesting, as the intent of
shallow clone is to have less history, so the commit-graph is less
necessary, as you wrote.


We might want to revisit it later, but I agree that starting from this
simple approach would be best.

One thing I would like to see added is for the user to know when
commit-graph is not available (in manpages), and maybe even a way to see
if it is on (e.g. with 'git commit-graph verify' and/or maybe in
'git status' output).  But this is a separate issue.

>
> I will send a follow-up patch that shows how I tested these
> interactions by computing the commit-graph on every 'git commit'.

Wouldn't it be enough to create commit-graph file, change the view of
the history (via grafts, via replace objects, via shallow clone), and
check that you still get correct results?

[cut]
>
> This approach is very different from the previous RFC on the subject [1].

The previous RFC was in my opinion needlessly complicated.  This one is
much simpler, and better.

[...]
> Thanks,
> -Stolee
>
> [1] https://public-inbox.org/git/20180531174024.124488-1-dstolee@microsoft.com/
>      [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo
>
> [2] https://public-inbox.org/git/20180717224935.96397-1-sbeller@google.com/T/#t
>     [PATCH 0/2] RFC ref store to repository migration
>
> [3] https://public-inbox.org/git/20180717224935.96397-1-sbeller@google.com/T/#m966eac85fd58c66523654ddaf0bec72877d3295a
>     [PATCH] TO-SQUASH: replace the_repository with arbitrary r
>
> Based-On: jt/commit-graph-per-object-store
> Cc: jonathantanmy@google.com
> Cc: sbeller@google.com
>
> Derrick Stolee (6):
>   commit-graph: update design document
>   test-repository: properly init repo
>   commit-graph: not compatible with replace objects
>   commit-graph: not compatible with grafts
>   commit-graph: not compatible with uninitialized repo
>   commit-graph: close_commit_graph before shallow walk
>
> Stefan Beller (2):
>   refs.c: migrate internal ref iteration to pass thru repository
>     argument
>   refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
>
>  Documentation/technical/commit-graph.txt | 18 ++++++--
>  builtin/replace.c                        |  8 ++--
>  commit-graph.c                           | 34 ++++++++++++--
>  commit-graph.h                           |  1 +
>  commit.c                                 |  2 +-
>  commit.h                                 |  1 +
>  refs.c                                   | 48 +++++++++++++++++---
>  refs.h                                   | 12 ++++-
>  refs/iterator.c                          |  6 +--
>  refs/refs-internal.h                     |  5 +-
>  replace-object.c                         |  7 +--
>  replace-object.h                         |  2 +
>  t/helper/test-repository.c               | 10 +++-
>  t/t5318-commit-graph.sh                  | 58 ++++++++++++++++++++++++
>  upload-pack.c                            |  2 +
>  15 files changed, 184 insertions(+), 30 deletions(-)
>
>
> base-commit: dade47c06cf849b0ca180a8e6383b55ea6f75812
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-11%2Fderrickstolee%2Fshallow%2Fupstream-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-11/derrickstolee/shallow/upstream-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/11
