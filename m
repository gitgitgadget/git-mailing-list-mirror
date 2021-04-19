Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED78EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 02:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD8760E08
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 02:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhDSC7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 22:59:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54596 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237323AbhDSC7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 22:59:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DE7C01F934;
        Mon, 19 Apr 2021 02:58:42 +0000 (UTC)
Date:   Mon, 19 Apr 2021 02:58:42 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org, patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210419025842.GA15976@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fszn48lh.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Sun, Apr 18 2021, Sebastian Schuberth wrote:
> 
> > On 2021-04-14 08:13, Jonathan Nieder wrote:
> >
> >> Those four are important in my everyday life.  Questions:
> >
> > Thanks for bringing up these questions in a dedicated format. I'll
> > take this as an opportunity to share my thoughts on this topic, which
> > have accompanied me for quite a while.
> 
> And thank you for participating in the discussion. I think it's
> especially valuable to get a viewpoint like yours, i.e. someone who (per
> this E-Mail below) gave up in frustration with the current development
> flow.

Agreed

> The below isn't meant as a retort, but to hopefully clarify things a
> bit.

Some further clarifications on my part below.

<snip some of Ævar's excellent clarifications>

> > Sure, I get that that the contribution workflow to Git core has
> > historically grown, but what concerns me is that the efforts to
> > "bridge" the contribution workflow to the "modern world" seem to go
> > into the wrong direction: Tools like submitgit [1], gitgitgadget [2]
> > and now patchwork [3] were created / are considered for use to allow
> > the legacy email path workflow to remain, but also allow more "GUI
> > minded" people to contribute. While this has worked quite well for
> > some time, and esp. gitgitgadget [2] seems to haven gotten popular, I
> > wonder whether it's now the time to "swap the default", and make a
> > patch / contribution tool with a GUI the standard, and bridge the
> > legacy workflow by using / creating tooling that makes it convenient
> > to use those modern tools from the CLI, instead of the opposite.
> 
> I think characterizing E-Mail as a "legacy" workflow isn't accurate. All
> of these proposed alternatives involve moving away from something that's
> a distributed system today (E-Mail infrastructure, local clients), to
> what's essentially some website run by a centralized entity, in some
> cases proprietary.
> 
> Even in cases where the tool itself isn't proprietary (e.g. GitLab
> instead of GitHub) using GitHub/GitLab/Gerrit/Atlassian Bitbucket
> etc. means having some centralized infrastructure somewhere holding a
> bunch of data only the operator of that infrastructure can realistically
> access.

Thanks all for bringing this up.  I should add the mail archives
at lore.kernel.org are backed by public-inbox, thus all mail and
code are completely reproducible by anyone.  It even targets
old, slow, legacy hardware and tries to minimize bandwidth to
benefit the economically-disadvantaged.

Forking is the checks-and-balances system of free software to
prevent any central entity from becoming too powerful (remember:
power corrupts).  DVCS (e.g. git) makes forking easier,
public-inbox uses git to make text communications history
reproducible (and therefore, forkable).  My end goal is
completely forkable communities without any central arbiters.

Email has problems, of course.  Big players are constantly
introducing more complexity to squeeze out smaller players.
And most mail servers require DNS through ICANN, an organization
that tried to extort .org users and hence likely to attempt
further abuses of power in the future.  Again, power corrupts.

> So really basic things that are comparatively trivial with E-Mail
> (e.g. "I think the search sucks, try another client") run up against a
> brick wall with those tools.

I'm working on some local tooling based on public-inbox ;)
(of course, totally optional)

And public-inbox will support JMAP in coming months, so it'll
be a standardized API and hopefully compatible with a wider
variety of clients and frontends.  This should help users who
prefer other other layouts.


Anyways, I do what I can to keep hardware and bandwidth
requirements low for folks who:
a) can't afford to keep up with Moore's law
b) won't accept mystery firmware blobs in modern HW
I got into free software because HW was constantly obsoleted by
proprietary software; and I'm sad so much "modern" free software
has followed that path...

The modern web is largely unusable with HW I first tried git
with in 2005.  Despite being technically free software, the size
of "modern" browsers makes it impractical for people on slow
HW/connections to actually exercise software freedom.  IMHO, any
HW that worked well in 2005 when git started ought to work well
for git and anything associated with it today.
