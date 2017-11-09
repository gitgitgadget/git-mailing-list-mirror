Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BA41F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 01:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbdKIB3t (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 20:29:49 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:47562 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdKIB3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 20:29:48 -0500
Received: by mail-it0-f44.google.com with SMTP id p138so9261392itp.2
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 17:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPfMLO6FjoQfafxSQj4wQe1MHmtXvRigfpAtj3PMQUI=;
        b=it8xwx975ly4HeTcGjD5cxbenFD1JLBQFGuC7EIIUEVXSnDICCPQXSKOJpIN0S7aDf
         QpDTpRTQvBUAudsz2mQ5aiGK2WcZrcInLPIlW7DxSAoaPiNjZ8RlZ+CiwY3JxxfKyD9j
         EqwSF+69Aa9TYpOOBY+iQQMkFvlKZcYzGsGKjnkccVc+3nMdHYHV227i7ppdbEEQcFjV
         3Hq3ONv9YlTtq8pXT6PViq0SnXxm5JxUQ36eXLXWRyYqiTnizPp6rh/hKi/C1Voj9LTW
         3/UHiMKtGDmnMFVH8ZEUPDum0HtMu+mhHk5dTUC7X+tR85Wq+q5BVxzq+kJ8bRApgZwJ
         5Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPfMLO6FjoQfafxSQj4wQe1MHmtXvRigfpAtj3PMQUI=;
        b=fVUmdj11RC06+VQVU1BBTxO+savrqDA+7KkK3ZCbbImM/TBHhJNq/Pqwatx8C4t95A
         8ICCc8IP7QrU0DAxTODc/lE3GCJ38ovlFBnYLEMCRlINuLODMkuyGEodx/fNnIqcpLol
         4Dan9x1XZrB+1aPT0GDl4Gmlrz+lXQjj43zt4fIi6Ra+Xq8cdghtelEb5l5UdhRfA/AN
         nmzluzSA0Hrq8ucNpK22s4Zj86JM3L1oDOJa73HR+B+1OdHR5enNxy9jOCvXY8wl8vCZ
         PoNMUzBpXBO/m1i24AuI5YdnDB6I9oX9fIvGYLCBZRtyWuc/RmsaaUePxwbnXCdR26zS
         k3SA==
X-Gm-Message-State: AJaThX6cPkoUZ0vTHNorPh7pdNYdrv511lfsgHzvEtcGKZrv2aBCubA/
        RV6TqedUHk3LKdvnZmaYP1Nm/w==
X-Google-Smtp-Source: ABhQp+RywENq15BYMEPFDO9d1wcbUaxm9y3mKe4+XfoMQsord/+paev3hpk0hZJ1pm+Tek2Bd2CNfA==
X-Received: by 10.36.20.81 with SMTP id 78mr3180450itg.127.1510190987108;
        Wed, 08 Nov 2017 17:29:47 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:bced:7a7c:ec6:df4])
        by smtp.gmail.com with ESMTPSA id 78sm2571636ioo.37.2017.11.08.17.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 17:29:46 -0800 (PST)
Date:   Wed, 8 Nov 2017 17:29:45 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFD] Long term plan with submodule refs?
Message-Id: <20171108172945.33c42a0e91b4ac494217b788@google.com>
In-Reply-To: <20171109001007.11894-1-sbeller@google.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
        <20171109001007.11894-1-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  8 Nov 2017 16:10:07 -0800
Stefan Beller <sbeller@google.com> wrote:

I thought of a possible alternative and how it would work.

> Possible data models and workflow implications
> ==============================================
> In the following different data models are presented, which aid a submodule
> heavy workflow each giving pros and cons.

What if, in the submodule, we have a new ref backend that mirrors the
superproject? When initializing the submodule, its original refs are not
cloned at all, but instead virtual refs are used.

Creation of brand-new refs is forbidden in the submodule.

When reading a ref in the submodule, if that ref is the current branch
in the superproject, read the corresponding gitlink entry in the index
(which may be dirty); otherwise read the gitlink in the tree of the tip
commit.

When updating a ref in the submodule, if that ref is the current branch
in the superproject, update the index; otherwise, create a commit on top
of the tip and update the ref to point to the new tip.

No synchronicity is enforced between superproject and submodule in terms
of HEAD, though: If a submodule is currently checked out to a branch,
and the gitlink for that branch is updated through whatever means, that
is equivalent to a "git reset --soft" in the submodule.

These rules seem straightforward to me (although I have been working
with Git for a while, so perhaps I'm not the best judge), and I think
leads to a good workflow, as discussed below.

> Workflows
> =========
> * Obtaining a copy of the Superproject tightly coupled with submodules
>   solved via git clone --recurse-submodules=<pathspec>
> * Changing the submodule selection
>   solved via submodule.active flags
> * Changing the remote / Interacting with a different remote for all submodules
>   -> need to be solved, not core issue of this discussion
> * Syncing to the latest upstream
>   solved via git pull --recurse  

(skipping the above, since they are either solved or not a core issue)

> * Working on a local feature in one submodule
>   -> How do refs work spanning superproject/submodule?

This is perhaps one weak point of my proposal - you can't work on a
submodule as if it were independent. You can checkout a branch and make
commits, but (i) they will automatically affect the superproject, and
(ii) the "origin/foo" etc. branches are those of the superproject. (But
if you checkout a detached HEAD, everything should still work.)

> * Working on a feature spanning multiple submodules
>   -> How do refs work spanning multiple repos?

The above rules allow the following workflow:
 - "checkout --recurse-submodules" the branch you want on the
   superproject
 - make whatever changes you want in each submodule
 - commit each individual submodule (which updates the index of the
   superproject), then commit the superproject (we can introduce a
   commit --recurse-submodules to make this more convenient)
 - a "push --recurse-submodules" can be implemented to push the
   superproject and its submodules independently (and the same refspec
   can be legitimately used both when pushing the superproject and when
   pushing a submodule, since the ref names are the same, and not by
   coincidence)

If the user insists on making changes on a non-current branch (i.e. by
creating commits in submodules then using "git update-ref" or
equivalent), possibly multiple commits would be created in the
superproject, but the user can still squash them later if desired.

> * Working on a bug fix (Changing the feature that you currently work on, branches)
>   -> How does switching branches in the superproject affect submodules

You will have to stash or commit your changes. (Which reminds me...GC in
the subproject will need to consult the revlog of the superproject too.)

> New type of symbolic refs
> =========================
> A symbolic ref can currently only point at a ref or another symbolic ref.
> This proposal showcases different scenarios on how this could change in the
> future.
> 
> HEAD pointing at the superprojects index
> ----------------------------------------

Assuming we don't need synchronicity, the existing HEAD format can be
retained. To clarify what happens during ref writes, I'll reuse the
scenarios Stefan described:

> Ref write operations driven by the submodule, affecting target ref
>   e.g. git commit, reset --hard, update-ref (in the submodule)
> 
> The HEAD stays the same, pointing at the superproject.
> The gitlink is changed to the target sha1, using
> 
>   git -C <superproject> update-index --add \
>       --cacheinfo 160000,$SHA1,<gitlink-path>
> 
> This will affect the superprojects index, such that then a commit in
> the superproject is needed.

In this proposal, the HEAD also stays the same (pointing at the branch).

Either the index is updated or a commit is needed. If a commit is
needed, it is automatically performed.

> Ref write operations driven by the superproject, changing the gitlink
>   e.g. git checkout <tree-ish>, git reset --hard (in the superproject)
> 
> This will change the gitlink in the superprojects index, such that the HEAD
> in the submodule changes, which would trigger an update of the
> submodules working tree.

The HEAD in the submodule is unchanged. If the value of a ref has
changed "from underneath", this is as if a "git reset --soft" was done.

> Superproject operations spanning index and worktree
>   E.g. git reset --mixed
> As the submodules HEAD is defined in the index, we would reset it to the
> version in the last commit. As --mixed promises to not touch the working tree,
> the submodules worktree would not be touched. git reset --mixed in the
> superproject is the same as --soft in the submodule.

Same.

> Consistency considerations (gc)
>   e.g. git gc --aggressive --prune=now
> 
> The repacking logic is already aware of a detached HEAD, such that
> using this new symref mechanism would not generate problems as long as
> we keep the HEAD attached to the superproject. However when commits/objects
> are created while the HEAD is attached to the superproject and then HEAD
> switches to a local branch, there are problems with the created objects
> as they seem unreachable now.
> 
> This problem is not new as a superproject may record submodule objects
> that are not reachable from any of the submodule branches. Such objects
> fall prey to overzealous packing in the submodule.

The scenario Stefan describes will work OK - if a commit is created
while the HEAD is pointing to a branch, then either the superproject's
index will be updated or commits will be created in the superproject.
When GC reads the list of refs in the submodule, the new submodule
commit will be included. (Remember that if the superproject's current
branch is "foo", "refs/heads/foo" in the submodule reflects the
superproject's index, so any changes to the index, though uncommitted,
will appear as a ref.)

The problem still exists (e.g. stashes in the superproject) but is
reduced, I think.
