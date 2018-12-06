Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3E4211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 21:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLFVzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 16:55:17 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38409 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLFVzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 16:55:17 -0500
Received: by mail-ed1-f52.google.com with SMTP id h50so2068243ede.5
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 13:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q685RDRqG2GrD7nbdyUNPqeyR93PGT2Ahu9GLxNPRPo=;
        b=G07TTHArfvVUQTGa7mgVTY1C0RgQG+OmiwYE8wV7O4DLg0/ELOFeH6bILo7BMRjhpc
         gi/qBq2U/c2xplDdKdcxNhCLJ3kOw2Rh57IC8uLKDzvhii3fnIPr4Zg3Frqcmkw8gKyc
         i0jFDkrASnfEGaexXFApxBcfVVddf92FFRN2CqQEi+Lf4tSqwrtpc0jlhCG4ILAbGqrY
         dPhBYDeD05g9rtFlqGJ89lgqvIL006s2+iGA3p8L+dlQiW6m16RKSubYie8SQG+sOzVh
         kwE5hilD7rm0V7yeYEVSrGqC4Rkc5yoRNgyRk13E1Z3LeKLZ5TtT+DnYz5A7aFOHA10H
         XucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q685RDRqG2GrD7nbdyUNPqeyR93PGT2Ahu9GLxNPRPo=;
        b=B7O0z3n4y4dGvcVz5IIjasEDIxZ6WdBZHgjpaZ49uoYGL66XLU3Yz2KmyoWZSiwH+L
         XECtK1ddTAJLKUSKhGzlo0K8ygzX/LcNvWy888jKRr49Ir2jn3ZRsAIIN+Sop2Ow9hk8
         +R+QnTVzpPgo/NP30tt3X6atQ7RFL1OQfe2f72VDPUQTDfnUAhm1auhJytkZ5R6QM/Zw
         htnIYYA6KktUgKwuEdPKsYS+YpMasKLqF+v/VaMM3hgITYExGEsi/3vxfldRHi0xux0/
         EJxf/bBPEz16B0q7yAbyLEI17kdYAARVqw0hRhtC6+JOvK14jRokeuRwLNKEN1RfIeo2
         Aw5A==
X-Gm-Message-State: AA+aEWYTqXWCwMYBgCDgpdavxbhnMweIxuTP0LXmyiMutvjOmcqU/x6B
        OYBEqp1pg1isNzCCB9Smw3ani+JWc/Tnn8kYSBv6VA==
X-Google-Smtp-Source: AFSGD/XSACldwzSJbH2pq/vAu6m3+uo6Vr7FzhRFSHQBMUOKXHc+uc+nTdjhwfFLR/ScYbetp5yM+Vm+dBPqkiVFDgA=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr66551ejb.70.1544133314714;
 Thu, 06 Dec 2018 13:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com> <20181206212459.GN4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181206212459.GN4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Dec 2018 13:55:03 -0800
Message-ID: <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
Subject: Re: [wishlist] git submodule update --reset-hard
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 1:25 PM Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
>
> On Thu, 06 Dec 2018, Stefan Beller wrote:
>
> > On Thu, Dec 6, 2018 at 10:02 AM Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> > > Dear Git Gurus,
>
> > > I wondered what would be your take on my wishlist request to add
> > > --reset-hard option, which would be very similar to regular "update" which
> > > checks out necessary commit, but I want it to remain in the branch.
>
> > What if the branch differs from the sha1 recorded in the superproject?
>
> git reset --hard  itself is an operation which should be done with some
> level of competence in doing "the right thing" by calling it.  You
> can hop branches even in current (without any submodules in question)
> repository with it and cause as much chaos as you desire.

Right.

git reset --hard would the branch (as well as the working tree) to the
given sha1, which is confusing as submodules get involved.

The Right Thing as of now is the sha1 as found in the
superprojects gitlink. But as that can be different from any branch
in the submodule, we'd rather detach the HEAD to make it
deterministic.

There was a proposal to "re-attach HEAD" in the submodule, i.e.
if the branch branch points at the same commit, we don't need
a detached HEAD, but could go with the branch instead.

> If desired though, a number of prevention mechanisms could be in place (but
> would require option(s) to overcome) to allow submodule to be reset --hard'ed
> only when some conditions met (e.g. only to the commit which is among parent
> commits path of the current branch).  This way wild hops would be prevented,
> although you might still end up in some feature branch.  But since "reset
> --hard" itself doesn't have any safe-guards, I do not really think they should
> be implemented here either.

So are you looking for
a) "stay on submodule branch (i.e. HEAD still points at $branch), and
reset --hard"
    such that the submodule has a clean index and at that $branch or
b) "stay on submodule branch (i.e. HEAD still points at $branch), but $branch is
   set to the gitlink from the superproject, and then a reset --hard
will have the worktree
   set to it as well.

(a) is what the referenced submodule.repoLike option implements.

I'd understand the desire for (b) as well, as it is a "real" hard reset on
the superproject level, without detaching branches.

> >   git reset --hard --recurse-submodules HEAD

> it does indeed some trick(s) but not all seems to be the ones I desire:
>
> 1. Seems to migrate submodule's .git directories into the top level
> .git/modules

Ah yes, that happens too. This will help once you want to git-rm
a submodule and checkout states before and after.

> > undesirable in the sense of still having local changes (that is what
> > the above reset with `--recurse` would fix) or changed the branch
> > state? (i.e. is detached but was on a branch before?)
>
> right -- I meant the local changes and indeed reset --recurse-submodules
> indeed seems to recurse nicely.  Then the undesired effect remaining only
> the detached HEAD

For that we may want to revive discussions in
https://public-inbox.org/git/20170501180058.8063-5-sbeller@google.com/


> > >   git submodule update --recursive
>
> > > I would end up in the detached HEADs within submodules.
>
> > > What I want is to retain current branch they are at (or may be possible
> > > "were in"? reflog records might have that information)
>
> > So something like
>
> >   git submodule foreach --recursive git reset --hard
>
> > ?
>
> not quite  -- this would just kill all local changes within each submodule, not
> to reset it to the desired state, which wouldn't be specified in such
> invocation, and is only known to the repo containing it

With this answer it sounds like you'd want (b) from above.

> > You may be interested in
> > https://public-inbox.org/git/20180927221603.148025-1-sbeller@google.com/
> > which introduces a switch `submodule.repoLike [ = true]`, which
> > when set would not detach HEAD in submodules.
>
> Thanks! looks interesting -- was there more discussion/activity beyond those 5
> posts in the thread?

Unfortunately there was not.

> This feature might indeed come handy but if I got it right, it is somewhat
> complimentary to just having submodule update --reset-hard .  E.g.  submodules
> might be in different branches (if I am not tracking based on branch names), so
> I would not want a recursive checkout with -b|-B.  But we would indeed benefit
> from such functionality, since this difficulty of managing branches of
> submodules I think would be elevated with it! (e.g. in one use case we probably
> will end up with a few thousands of submodules, and at least 3 branches in each
> which would need to be in sync, and typically you wouldn't want different
> branches to be checked out in different submodules)
>
> > Can you say more about the first question above:
> > Would you typically have situations where the
> > submodule branch is out of sync with the superproject
> > and how do you deal with that?
>
> typically I do not have anything out of sync.  My primary use-case is to
> "cancel" recent changes in the entire tree of repositories.  I guess for
> my use case, instead of needing two commands
>
>    git reset --hard PREVIOUSPOINT
>    git submodule update --reset--hard --recursive
>
> I wish there was just one
>
>    git reset --hard --recursive PREVIOUSPOINT

Maybe this could learn options like

  git reset --hard --recursive=hard,keep-branch PREVIOUSPOINT

which then could be put into options like

  git config reset.recurseSubmodules  hard,keep-branch &&
  # maybe not needed, depending on the exact meaning
  # of reset.recurseSubmodules:
  git config submodule.recurse

and then

  git reset --hard PREVIOUS

would do what you'd desire.

> but I felt that   submodule update   might be a better starting point
> since it already  provides different modes for update.  If I was even greedier,
> I would have asked for
>
>    git revert --recursive <commit>...
>    git rebase --recursive [-i] ...
>
> which I also frequently desire (could elaborate on the use cases etc).

These would be nice to have. It would be nice if you'd elaborate on the
use cases for future reference in the mailing list archive. :-)

>
> NB or --recurse-submodules to avoid confusion with recursive merge
> strategy?

... and sometimes recursing in the file system, c.f. `ls-tree -r`.
