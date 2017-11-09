Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469FB1F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbdKIAKQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 19:10:16 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:33871 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdKIAKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 19:10:14 -0500
Received: by mail-it0-f42.google.com with SMTP id 143so242004itf.1
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOLWDuvWyO65deWUjnX6mCUA1W4zcEOcF28aY81XPd4=;
        b=j0rZYLRg9HNxVoRWyh5PS5el0kENgvZfDBN7x3OQfXMP1MraKd/mVi2RHiQGts98K1
         OZ6i7xt7QOzL6H50ni42z++KPZu3lV21xaPzWJZjqt8ixxbVOH6HtgHoKyd0Badu+XT1
         ZcKBIE0BcHOgM21YLtknRr3a79YxCiwXpLCqTGkvzizsGporIpK6G5tcGX8cpBdJtqzP
         Qyg/C+9bJ/T+3XKuQiF675+QPfitGVV9ZSiAlhrYrImj59tgvrOcheW3JHRZSyrGCn8P
         mOTFN3P66RBtCSlE3uOO7fmIYJ1ZbY+hOs08NIxJ9tjPoYIkRnqD9YscmRFP3FRBqq4X
         OnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOLWDuvWyO65deWUjnX6mCUA1W4zcEOcF28aY81XPd4=;
        b=UMkApy2cep7U8x+tA2Hi6GcqJl6tqpn7Dtx+ih6cM5xbSB62grnV1RK+DVgPb2vDMN
         qGmWgTpOoKYBrwFYklm2yU7rO+DNBPkbUvoj8Cj1/i42UEOScwna9dcqkoXSNj7F1j0n
         rji27V99lJsw/hQ/ImfozwNm9tlsmiwpt/i2iQb4KaS06kY1nrLSJbAF+jx3PJ3wcE66
         cBLmaLv/ZN0a9ogQQhqw1mt5xOVGcXlEKaTD4UAWSmtXggw5QfQ5jbI/QiwjJ4Gm0esH
         tWHM+hdLdxQX+zers5j8N9PmuT0u+70nCGM+t6MxoAieqn0BT/HMMXjLDnqs+Ej/P4OT
         sC1g==
X-Gm-Message-State: AJaThX7ALbx8Vq3I6S8WnLlbVVY8DqCG7jVARek6xWG0VSzFvC0G88LS
        csb4F2e6ERLzvJH8TDkZi9n4Hg==
X-Google-Smtp-Source: ABhQp+T5yL0KAQmBE65x3H/J3cUkmjX2QrKxRGKcsIqLIRg5kC709WpoWSy3EvJL+pEN6virLychNw==
X-Received: by 10.36.130.131 with SMTP id t125mr3120227itd.104.1510186213505;
        Wed, 08 Nov 2017 16:10:13 -0800 (PST)
Received: from localhost ([2620:0:100e:422:30e2:d684:62f:c68e])
        by smtp.gmail.com with ESMTPSA id g6sm2424055ioc.11.2017.11.08.16.10.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 16:10:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFD] Long term plan with submodule refs?
Date:   Wed,  8 Nov 2017 16:10:07 -0800
Message-Id: <20171109001007.11894-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171108143646.2e1870a82360072557094e01@google.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The relationship is indeed currently useful, but if the long term plan
> is to strongly discourage detached submodule HEAD, then I would think
> that these patches are in the wrong direction. (If the long term plan is
> to end up supporting both detached and linked submodule HEAD, then these
> patches are fine, of course.) So I think that the plan referenced in
> Junio's email (that you linked above) still needs to be discussed.

This email presents different approaches.

Objective
=========
This document should summarize the current situation of Git submodules
and start a discussion of where it can be headed long term.
Show different ways in which submodule refs could evolve.

Background
==========
Submodules in Git are considered as an independet repository currently.
This is okay for current workflows, such as utilizing a library that is
rarely updated. Other workflows that require a tighter integration between
submodule and superproject are possible, but cumbersome as there is an
additional step that has to be performed, which is the update of the gitlink
pointer in the superproject.

Other discussions of the past:
"Re-attach HEAD?"
  https://public-inbox.org/git/20170501180058.8063-1-sbeller@google.com/
"Semantics of checkout --recursive for submodules on a branch"
  https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/
"A new type of symref?"
  https://public-inbox.org/git/xmqqvamqg2fy.fsf@gitster.mtv.corp.google.com/

Workflows
=========
* Obtaining a copy of the Superproject tightly coupled with submodules
  solved via git clone --recurse-submodules=<pathspec>
* Changing the submodule selection
  solved via submodule.active flags
* Changing the remote / Interacting with a different remote for all submodules
  -> need to be solved, not core issue of this discussion
* Syncing to the latest upstream
  solved via git pull --recurse  
* Working on a local feature in one submodule
  -> How do refs work spanning superproject/submodule?
* Working on a feature spanning multiple submodules
  -> How do refs work spanning multiple repos?
* Working on a bug fix (Changing the feature that you currently work on, branches)
  -> How does switching branches in the superproject affect submodules

This discussion should resolve around refs are handled in submodules in
relation to a superproject.

Possible data models and workflow implications
==============================================
In the following different data models are presented, which aid a submodule
heavy workflow each giving pros and cons.

Keep everything as is, superproject and submodule have their own refs
---------------------------------------------------------------------
In this alternative we'd just make existing commands nicer, e.g.
git-status, git-log would give information about the superprojects
gitlink similar as they give information about a remote branch.

We might want to introduce an option that triggers adding the submodule
to the superproject once a commit is done in the submodule.

Pros:
 * easiest to implement
 * easy to understand when having a git background already
 
Cons:
 * Current tools that manage multiple repositories (e.g. repo, git-slave)
   have "branches in parallel", i.e. each repo has a branch of the same
   name, instead of using a superproject to manage the state of all repos
   involved. So users of such tools may be confused by submodules.
 * when using a detached HEAD in the submodule, we may run into git-gc issues.
 

Use replicate refs in submodules
--------------------------------
This approach will replicate the superproject refs into the submodule
ref namespace, e.g. git-branch learns about --recurse-submodules, which
creates a branch of a given name in all submodules. These (topic) branches
should be kept in sync with the superproject

Pros:
 * This seemed intuitive to Gerrit users
 * 'quick' to implement, most of the commands are already there,
   just git-branch is needed to have the workflows mentioned above complete.
Cons:
 * What does "git checkout -b A B" mean? (special case: B == HEAD)
   Is the branch name replicated as a string into the submodule operation,
   or do we dereference the superprojects gitlink and walk from there?
   When taking the superprojects gitlink, then why do we have the branches
   in the submodule in the first place? When taking the string as-is,
   then it might confuse users.
 * non-atomic of refs between superproject and submodule by design;
   This relies on superproject and submodule to stay in sync via hope.

No submodule refstore at all
----------------------------
Use refs and commits in the superproject to stitch submodule changes
together. Disallow branches in the submodule. This is only restricted
to the working tree inside the superproject, such that the output of git-branch
changes depending whether the working tree is in- or outside the superproject
working tree.

The messages of git-status inside the superproject working tree are changed
as "detached HEAD"s are common in submodule and sound scary.  Maybe
"following the superproject"

Pros:
 * solves the atomicity issue from the prior proposal
Cons:
 * In a submodule one must use a worktree outside the superproject
   to do upstream work.
 * As the detached HEAD is not referenced, we have git-gc issues.


New type of symbolic refs
=========================
A symbolic ref can currently only point at a ref or another symbolic ref.
This proposal showcases different scenarios on how this could change in the
future.

HEAD pointing at the superprojects index
----------------------------------------
Introduce a new symbolic ref that points at the superprojects
index of the gitlink. The format is

  "repo:" <superprojects gitdir> '\0' <gitlink-path> '\0'

Just like existing symrefs, the content of the ref will be read and followed.
On reading "repo:", the sha1 will be obtained equivalent to:

    git -C <superproject> ls-files -s <gitlink-path> | awk '{ print $2}'

Ref write operations driven by the submodule, affecting symrefs
  e.g. git checkout <other branch> (in the submodule)

In this scenario only the HEAD is optionally attached to the superproject,
so we can rewrite the HEAD to be anything else, such as a branch just fine.
Once the HEAD is not pointing at the superproject any more, we'll leave the
submodule alone in operations driven by the superproject.
To get back on the superproject branch, we’d need to invent new UX, such as
   git checkout --attach-superproject
as that is similar to --detach

Ref write operations driven by the submodule, affecting target ref
  e.g. git commit, reset --hard, update-ref (in the submodule)

The HEAD stays the same, pointing at the superproject.
The gitlink is changed to the target sha1, using

  git -C <superproject> update-index --add \
      --cacheinfo 160000,$SHA1,<gitlink-path>

This will affect the superprojects index, such that then a commit in
the superproject is needed.

Ref write operations driven by the superproject, changing the gitlink
  e.g. git checkout <tree-ish>, git reset --hard (in the superproject)

This will change the gitlink in the superprojects index, such that the HEAD
in the submodule changes, which would trigger an update of the
submodules working tree.

Superproject operations spanning index and worktree
  E.g. git reset --mixed
As the submodules HEAD is defined in the index, we would reset it to the
version in the last commit. As --mixed promises to not touch the working tree,
the submodules worktree would not be touched. git reset --mixed in the
superproject is the same as --soft in the submodule.

Consistency considerations (gc)
  e.g. git gc --aggressive --prune=now

The repacking logic is already aware of a detached HEAD, such that
using this new symref mechanism would not generate problems as long as
we keep the HEAD attached to the superproject. However when commits/objects
are created while the HEAD is attached to the superproject and then HEAD
switches to a local branch, there are problems with the created objects
as they seem unreachable now.

This problem is not new as a superproject may record submodule objects
that are not reachable from any of the submodule branches. Such objects
fall prey to overzealous packing in the submodule.

This proposal however exposes this problem a lot more, as the submodule
has fewer needs for branches.

Pros
 * easy to tell if a submodule is attached to the superproject,
 * no atomicity issues
 * once enough commands implement this behavior, it may be easier to understand
   than previous alternatives and feel more intuitive
Cons:
 * gc issues for now
 * lots of work as it revamps submodules alot.
 
 This last proposal might be differentiated further, e.g. the submodule HEAD
 pointing at the superprojects gitlink in the index, in its HEAD or other
 branch.

Any feedback welcome!
Stefan








