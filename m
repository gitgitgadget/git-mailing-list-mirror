Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440171F859
	for <e@80x24.org>; Mon, 22 Aug 2016 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbcHVTV5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 15:21:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:59191 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755876AbcHVTV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 15:21:57 -0400
Received: (qmail 20117 invoked by uid 109); 22 Aug 2016 19:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 19:21:55 +0000
Received: (qmail 15898 invoked by uid 111); 22 Aug 2016 19:21:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 15:21:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 15:21:52 -0400
Date:   Mon, 22 Aug 2016 15:21:52 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160822192152.tghb5eyi74hrr6e4@sigill.intra.peff.net>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox>
 <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 09:55:54AM -0700, Stefan Beller wrote:

> It was not my intend to start this discussion again with my initial email.
> I rather wanted to point out how I make progress in doing my own
> tooling.
> 
> I mean if email works well for Junio (both as a maintainer as
> well as a contributor) and Jeff as a contributor, then I can adapt
> my workflow to that, because these two have brought in
> 8300 of 33000 non merge patches. (i.e. they had 25% of the
> patches over the life time of the project and are with the project
> longer than others IIUC). So why would I demand they change
> their style just to accommodate one newcomer like me?

Even though I do really like the mail-based workflow, I think this is a
dangerous line of reasoning. If the project were just me and Junio,
working as efficiently as two people possibly can, then sure, asking us
to change from what works for us would be silly.

But it's not. We have to make sure that the project community thrives.
That includes catering to some degree to occasional contributors, and
doing things to attract new members to the community as old ones drift
away.

You'll notice that I hand-waved away "to some degree" there. There is
definitely a balance to be found in managing the time of the maintainer
and the reviewers, versus making things easier for new contributors. As
a reductio ad absurdum, the simplest thing for contributors would be to
make a vague bug report and have the maintainer produce a polished
patch. That obviously does not scale. :)

Likewise, it is not just a matter of time spent, but workflows impact
_who_ will join[1]. Contributing to git is very friendly to a certain
niche of Unix die-hards, and that impacts who bothers to do so, and
consequently, what contributions we see (both to code and to
discussion). There's value in diversity of opinions[2], and we should be
wary of becoming an obsolete and out-of-touch mono-culture.

So I say "dangerous" because that is one way that open source projects
can die: the number of contributors dwindles, development slows, there
are no new ideas in the community, etc.

I don't think git would ever die off completely; there are too many
users. But there have been projects that seem to ossify for many years,
and are rejuvenated only when they shake up some elements of the
community or workflow (e.g., mutt is recently seeing such a resurgence;
sometimes it even takes the form of a follow-on project, like CVS->SVN,
with new people).

I don't think we're at that point with git. But it is something to be
mindful of. It's not clear to me if mutt-loving luddites like myself are
the last of a dying breed, or if there will always be enough of us to
churn out contributions to projects like git.

-Peff

[1] I think Dscho feels this much more acutely on Git for Windows than
    we do on the regular git mailing list, because the "who" audience
    for GfW is much different than the Unix world.

[2] I also think there's such as a thing as "too many opinions" in a
    project. If we started rewriting bits of git in Haskell (just to
    pick on a random pretty-far-from-C language), things would get very
    complex very quickly. So again, it's about finding a balance.
