Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73358C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259BF6141D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhDUARq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhDUARo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:17:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FEC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:17:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g17so46544854edm.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6859qnfNsB5QmnDYnF1Do40+Yhw+/qhnLAk9/XXbHtw=;
        b=2jVWiN+NDYMcxI6QPsTkOUmw7DGnfqXwEj7DafnSYMMEUT/ea2f4C4tR5xTWnHVzZo
         zgYWj1VFQg0vSB2nR9uHm5Gu6GkScValrxTsPVOJXsYzKCYPV+3DOqen7w+r/2xZz0Tl
         L9Xj825ZivVKP3TBeyjv+Ek3XQqfxjERWeDLPf42QmZMfINlkNAwk9LtD98DCoRxumnr
         hqM3ocFSou5PoCBOX8hg+LWeUIiQbYMal1qLsOqL9eBQtCD/Uh7isaEEagbLTzDsg0ig
         UisXHXzpO6DZHT4NzctPcQQ9vSCwtAoE69mxuEtj7SfLrRsL/6BT4TgcQIi7C6x13cTp
         cRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6859qnfNsB5QmnDYnF1Do40+Yhw+/qhnLAk9/XXbHtw=;
        b=XKPXYUpRMYKQ/Ot0JDzXHVPZgrOcy5fesDEi+vgmOX55tXVLiZxOsfIDMxz+tzoEG1
         AoqqRGtN2FGA5vjTXyfnaW0dkawolJF6bXYYh6qvNExbQw1kaGZXELN+fqyQOEW8mc3o
         kKOoGFzI7FYrKqfZ+b1iAumd5gLZCSNt5GWx6HlyY+CdJYbaMPNC8DWaiT3DBwOucHNn
         3HdxFJsQVVu3U+zxAr0QuDwn2vbppS79EhG7cAPWiJ1hX1SvXci5rYgrEAbXP5EfKBzh
         VduhL/iyvMiLd7a88lGb/xiRmZQ5PNKZ1sQDhG2wunmT0TaNqBOfzB5I1COCPD/tdjk/
         I1Pw==
X-Gm-Message-State: AOAM530TsG6/30sNdpoMHzMbHhp23CmCPMoRIQaYWbA3Ow1QhWC0v7ru
        fEbCt12pzz4XJNVXvEy4XdVwBPwW0+dje2Tit3qv3IZq5WQDHuIR
X-Google-Smtp-Source: ABdhPJzTjAnsoLf2DQXuazjsPkxhhmQdhXBuTETQhE/LExEyY5BgWmmc/rDHsk08oqmPHFycMkZEkt/KgqyjuQFvFHs=
X-Received: by 2002:a05:6402:368:: with SMTP id s8mr29799485edw.183.1618964229975;
 Tue, 20 Apr 2021 17:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210417001525.19960-1-jerry@skydio.com> <xmqqzgxxivrb.fsf@gitster.g>
 <CAMKO5Cutas2BM_CTHTJs_O9NSp2Vyn-bK0jV0K758eq5M6-Oag@mail.gmail.com> <xmqqczutiddk.fsf@gitster.g>
In-Reply-To: <xmqqczutiddk.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 20 Apr 2021 17:16:59 -0700
Message-ID: <CAMKO5Cu68cnUu6UEuwQSHoFQ31g9g4TtYgy5vpe35cr90cETXw@mail.gmail.com>
Subject: Re: [PATCH] git-rev-list: add --exclude-path-first-parent flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 12:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > On Fri, Apr 16, 2021 at 5:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Jerry Zhang <jerry@skydio.com> writes:
> >>
> >> > Add the --exclude-path-first-parent flag,
> >> > which works similarly to --first-parent,
> >> > but affects only the graph traversal for
> >> > the set of commits being excluded.
> >> >
> >> >    -A-------E-HEAD
> >> >      \     /
> >> >       B-C-D
> >> >
> >> > In this example, the goal is to return the
> >> > set {B, C, D} which represents a working
> >> > branch that has been merged into main branch
> >> > E. `git rev-list D ^E` will end up returning
> >> > no commits since the exclude path eliminates
> >> > D and its ancestors.
> >> > `git rev-list --exclude-path-first-parent D ^E`
> >> > however will return {B, C, D} as desired.
> >>
> >> It is not clera why you want to have this, instead of doing a more
> >> obvious "D..E^".  Even better is "E^..E", which is often what you
> >> want when viewing a history like my 'seen' that is a straight-line
> >> into which tips of branches are merged.
> > My motivation is to find the point at which a release branch forked off from
> > a main branch, even though the release branch could have been merged
> > into the main branch multiple times since it was forked off.
> >
> > If we add another merge from release to main, it will be more clear
> > that those give different results:
> >
> >         -A-----E-F-main
> >           \   / /
> >            B-C-D-release
> >
> > `git rev-list --exclude-path-first-parent release ^main` returns {B, C, D}.
> > I've added commit F to show that we don't necessarily have info on E,
> > there could be many commits between it and the tip of main.
>
> OK, you meant to deal with repeated merges into integration branch.
>
> So the idea is to just name the end point merge, say F (you also
> could name D as the starting point, but see below), and
>
>  - initially mark its first parent as UNINTERESTING (i.e. E), and
>    other parents as INTERESTING (i.e. D).
>
>  - run the revision traversal machinery, but when propagating the
>    UNINTERESTING bit, give it only to the first parent.  The second
>    and later parents won't become UNINTERESTING.
>
>  - stop after we exhaust INTERESTING commits.
>
> It would probably work for your idealized topology, but I do not
> know what happens when there are criss-cross merges.  In the revised
> picture, you are merging down from the B-C-D chain into the
> mainline, but once the B-C-D chain becomes longer and diverges too
> much from the mainline, it becomes tempting to break the "merge only
> in one direction" discipline and merge back from the mainline, to
> "catch up", and such a merge will have the history of B-C-D line of
> development as its first parent.  Would that screw up the selection
> of which line of development is uninteresting?
Yeah this flag (as well as the --first-parent flag) is mainly only useful
because "git merge" will always put the "branch you're on" as parent 1
and the "branch being merged in" as parent 2. It is possible to break
this assumption with either commit-tree or by merging while on one
branch and pushing to another, but then the user should understand
the consequences of doing so. In our case this isn't possible because
a server handles all merges into the main branches.
>
> >> > Add the --exclude-path-first-parent flag,
> >> > which works similarly to --first-parent,
> >> > but affects only the graph traversal for
> >> > the set of commits being excluded.
> >> >
> >> >    -A-------E-HEAD
> >> >      \     /
> >> >       B-C-D
>
> In any case, it was totally unclear from the proposed log messsage,
> and the overlong option name that does not say much did not help me
> guess what you wanted to do with it.  Specifically, it is not clear
> what "exclude" means (we do not usually use the word in the context
Exclude appears in the first paragraph of the man for git rev-list:
"      List commits that are reachable by following the parent
       links from the given commit(s), but exclude commits that
       are reachable from the one(s) given with a ^ in front of
       them. The output is given in reverse chronological order
       by default."
It appears 5+ more times in the man page with the same meaning.
> of revision traversal), and when we talk about "path" in the context
> of revision traversal, we almost always mean the paths to the files,
> i.e. pathspec that limits and simplifies the shape of the history.
"path" is used in the same man page for the flag "--ancestry-path".
I agree that it could be ambiguous though, so perhaps "chain" would
be better.
> Also, it claims that it works similarly to --first-parent, but what
> you are doing is to propagate UNINTERESTING bit on the first-parent
> chain, which ends up showing the side branch (i.e. B-C-D chain),
> without showing the commits on the first-parent chain (A and E).
>
> What are the words that convey the idea behind this operation
> clearly at the conceptual level?  Let's think aloud to see if we can
> come up with a better name.
>
>  * first parents are unintertesting
>
>  * show commits on side branch(es)
>
>  * follow side branch.
>
> I think that is closer to the problem you are solving, if I
> understand what you wrote above correctly.
>
> Perhaps --show-side-branch or --follow-side-branch?  I dunno.
For my particular use-case I am using it in combination with
--first-parent and a single include and exclude commit to show the
commits on the "side-branch" of the include commit. But if you specify
multiple commits for either or don't use --first-parent, the behavior is
different and I don't think "--side-branch" describes it well in those cases.

Since I don't believe I can predict all use-cases for the flag,
I'd rather name it by what it "does" rather than what it is "for".
If we're concerned about length, maybe "first-parent-not" could
get the meaning across:
- for "rev-list --first-parent A --not B" only first parents are visited
along A's ancestry
- for "rev-list --first-parent-not A --not B" it might be reasonable
that since B is a "not" commit, only first parents are visited along
B's ancestry.

Overall I don't think we can make a name so clear that the user
can avoid the man page anyway.
