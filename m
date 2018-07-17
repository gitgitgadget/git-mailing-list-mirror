Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94901F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeGQSCP (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:02:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37590 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQSCP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:02:15 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so1675788ioh.4
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fuyb2jeCdd/U+xJJHmeKcNg6TYywCF0PCnKYFdRs0f8=;
        b=i8KXbEmueUrnJ/7D3kKO07s8vYyVJfu/g1yYptybJfG5Dl5qA3dImDV6bE4MPj0X0C
         XAq9o09EvECQ87Td4UFtybPsW2KgF2M8ph3zywCzZPT/QIbXQf8H7hqx8+bM8ru3BZf4
         +GN+hMTcehnxYR8cN2OihIbFD7B/q+kWvl8Sd2sNZqftqgDAKU/WrnxXnYdrKBQHitYW
         82SUnp2pCQf/hSFjmF0B6eEDj88U11KTLvkkpVMpfIgNkJbEnU4UMeSN5WMJvdWD9FKc
         z6udacarp+7zFKQl0+83I0BDLwRDoEklL+OsyiNJXe3PT5pZsQkFlsZyuqah1tf6GEsU
         rgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fuyb2jeCdd/U+xJJHmeKcNg6TYywCF0PCnKYFdRs0f8=;
        b=K6PNYy6WCXQj6r4+2gDSQ49YR4zFwcZDmlHNk5ZVF4aMElOjby3n1FV0zYF2e0Xk0d
         XzIdovaZRSDmTTXxd9NNcsHJHFDSrgzgYBpJKlEsBj6O2gxbBCHw1GXtAiZoLBI6Rt9S
         0nGbbHHt7UzBQvyFQ1SqF51WR6XIOBR2jngSODpFTS08bCiaPU1N4etsHYUsguD+7qDC
         QCeD625e3Dww8b5myHG9roZs74t8hQHtvqyWUX7Q4nETl1CxBndBaruy+AHMD5tyaoAB
         wztfVcmqgppCgx77dVHXp2hXXVeKN3qkVKVeA5bDoacGorEtoQnpgNLXYsLQvW0oRxBC
         NOgg==
X-Gm-Message-State: AOUpUlExnlwouSxbmemVFruazEBoA3+N0z0pido4qOVdzaM6gQjtHeIK
        XZmlv73MTl051TRcpbM/xvIcwYFSNjr0GemTZkipuw==
X-Google-Smtp-Source: AA+uWPy4Ui5/CuRGY0+kiS2IaRVCx5xJMymxAF+/gbxNQdJYrwqAsO8fU4J5pWIQd4aA/GHYswfOQrIywhbneFijaBI=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr2053156ioe.282.1531848514109;
 Tue, 17 Jul 2018 10:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
 <20180716173636.GA18636@sigill.intra.peff.net>
In-Reply-To: <20180716173636.GA18636@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 17 Jul 2018 19:28:07 +0200
Message-ID: <CACsJy8BV3ii3MkYf6UObsX_JdDbT9ovY_K9dCCeYvQ3FWqnRUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 7:38 PM Jeff King <peff@peff.net> wrote:
> in a user-visible way. And that's really my question: is pruning here
> going to bite people unexpectedly (not rhetorical -- I really don't
> know)?

If shallow points are no longer reachable, removing them should not
bite anybody, I think.

> For instance, at GitHub we do not ever run "git gc", but have our
> maintenance regimen that builds around "git repack". I don't think this
> patch will matter to us either way, because we would never have a
> shallow repository in the first place. But I'm wondering if people in a
> similar situation might.
>
> I'm also not entirely sure if people _care_ if their shallow list is
> pruned. Maybe it's not a big deal, and should just be quietly cleaned
> up.
>
> And I know that you're probably coming at it from the opposite angle.
> Somebody isn't running git-gc but doing a "repack -adl" and they _do_
> want these shallow files cleaned up (because their repo is broken after
> dropping the objects). I just want to make sure we don't regress some
> other case.
>
> > > I.e., it seems unexpected that "git repack" is going to tweak your
> > > shallow lists. If we were designing from scratch, the sane behavior
> > > seems to me to be:
> > >
> > >   1. Shallow pruning should be its own separate command (distinct from
> > >      either repacking or loose object pruning), and should be triggered
> > >      as part of a normal git-gc.
> >
> > I fail to see the value in a separate command.
>
> The value of a separate command is that you can run those other commands
> without triggering this behavior. I actually think "git prune" does too
> much already (e.g., imagine that I do not ever want to prune objects,
> but I _do_ want to get rid of tmp_pack and tmp_obj cruft; what command
> do I run?). But that is definitely not a new problem. And I'm OK with
> not fixing it for now. My main concern is that we are using the presence
> of that mistake to justify making it again.
>
> > And: `git gc` already calls `git prune`, which *does* prune the shallow
> > list.
>
> Right, I was trying to propose that each individual cleanup step which
> _could_ be done independently should be done so, but that "gc" should
> continue to do them all.
>
> I think in the case of git-prune and prune_shallow(), it's a little
> tricky, though. It looks like prune_shallow() relies on somebody having
> marked the SEEN flag, which implies doing a full reachability walk.

Sorry, my bad for hiding this SEEN flag deep in library code like this
in eab3296c7e (prune: clean .git/shallow after pruning objects -
2013-12-05) But in my defense I didn't realize the horror of sharing
object flags a year later and added the "object flag allocation" in
object.h

> So it's really amortizing the work already being done by prune.
>
> Speaking of which, I don't see how your patch can work as-is. The repack
> command does not do such a walk, so it has no idea which commits are
> SEEN or not, and will delete all of them! Try this:
>
>   [shallow of clone of git.git (or any repo)]
>   $ git clone --no-local --depth=1 /path/to/git tmp
>   ...
>   $ cd tmp
>
>   [we have a commit]
>   $ git log --oneline -1
>   de46fca (grafted, HEAD) repack -ad: prune the list of shallow commits
>
>   [repacking with existing git is fine]
>   $ git repack -adl
>   ...
>   $ git log --oneline -1
>   de46fca (grafted, HEAD) repack -ad: prune the list of shallow commits
>
>   [repacking with your patch empties the shallow file, which
>    makes the repository look corrupt]
>   $ /path/to/git repack -adl
>   $ git log --oneline -1
>   error: Could not read a2df50675979af639cf9490f7fc9b86fa18fd907
>   fatal: Failed to traverse parents of commit de46fca5b43f47f3c5c6f9232a17490d39fc80b1
>
> So either we have to do a reachability walk (which is expensive), or we
> have to rely on some other command (like prune) that is doing a
> reachability walk and reuse that work.

Since "git prune" took care of loose objects, if we're going to delete
some redundant packs, we can perform a reasonably cheap "reachability"
test in repack, I think. We have the list of new packs from
pack-objects which should contain all reachable objects (and even some
unreachable ones). If we traverse all of their idx files and mark as
SEEN, then whatever shallow points that are not marked SEEN _and_ not
loose objects could be safely removed.

> > >   2b. It's OK for shallow objects to be missing, and the shallow code
> > >       should be more resilient to missing objects. Neither repack nor
> > >       prune needs to know or care.
> >
> > That would be possible. Kind of like saying: we do have this list of
> > shallow commits, but oh, BTW, it is likely incorrect, so we painstakingly
> > verify for every entry during every fetch and push that those commits
> > objects are still there.
>
> Obviously verifying reachability on each fetch is a bad idea. But my
> understanding of the shallow list is that it says "this is a graft point
> where we do not have any of the parents". If we find that we do not have
> such an object, would it be OK to quietly ignore that? We used to claim
> "we do not have the parents of X", but now we know "well, we do not have
> X anymore either".
>
> Again, I may be showing my ignorance of the shallow code here.

I don't see any problem with this either, but then I've not worked on
shallow code for quite some time. The only potential problem is where
we do this check. If we check (and drop) shallow points when we read
.git/info/shallow, then when we write it down some time in the future
we accidentally prune them. Which might be ok but I feel safer when we
only prune at one place (prune/gc/repack) where we can be more careful
and can do more testing.

If we read the shallow list as-is, then just not send "shallow" lines
in fetch-pack for shallow points that do not exist, I don't see a
problem, but it may be a bit more work and we could get to some
confusing state where upload-pack gives us the same shallow point that
we have but ignore because we don't have objects behind it. Hm...
actually I might see a problem :)
-- 
Duy
