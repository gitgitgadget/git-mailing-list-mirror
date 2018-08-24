Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B50B1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 23:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeHYDBt (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 23:01:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726770AbeHYDBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 23:01:49 -0400
Received: (qmail 18413 invoked by uid 109); 24 Aug 2018 23:25:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 23:25:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 402 invoked by uid 111); 24 Aug 2018 23:25:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 Aug 2018 19:25:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2018 19:25:02 -0400
Date:   Fri, 24 Aug 2018 19:25:02 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention
 doc-diff
Message-ID: <20180824232502.GA21265@sigill.intra.peff.net>
References: <20180821192321.GA720@sigill.intra.peff.net>
 <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
 <20180821204341.GA24431@sigill.intra.peff.net>
 <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
 <CACsJy8BxxyRxqCj5ZoOmPaiwmFRKHU72yTxyC_eHXS+cEa94zw@mail.gmail.com>
 <CAPig+cQNkMEUj=6e=6czbkWeozJQ-Go09C6bZwVJUTpM3JJiiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQNkMEUj=6e=6czbkWeozJQ-Go09C6bZwVJUTpM3JJiiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 06:55:24PM -0400, Eric Sunshine wrote:

> On Fri, Aug 24, 2018 at 10:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Aug 23, 2018 at 8:21 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > Peff wrote:
> > > > Yes, but then what's the next step for my script? I can't "remove" since
> > > > the worktree isn't there. I can't blow away any directory that I know
> > > > about, since there isn't one.
> > >
> > > I was thinking that "worktree add" could start respecting the --force
> > > option as an escape hatch.
> > >
> > > > What about refusing by default, but forcing an overwrite with "-f"?
> > >
> > > My thought, also.
> >
> > Sounds good. Eric are you going to implement this? Just checking so
> > that I can (hopefully) cross this off my backlog ;-)
> 
> It wasn't something I was planning on working on (at least not
> immediately) since it's still a bit fuzzy for me whether this is
> enough to help Peff's use-case (and because I have several other
> things in my queue, already).

I'm pretty sure it would just be a one-liner to "worktree add -f" in the
doc-diff script. So I think it does solve the problem.

> However, before even considering implementing it, there's at least one
> question (and possibly others) needing answering. For instance, how
> should "add --force" interact with a locked (not-present) worktree?
> Should it blast it despite the lock? Or would that need --force
> specified twice ("git worktree add -f -f foo")?

Yes, I think that should probably be two forces.

> As for the actual implementation, I haven't yet looked at how much
> surgery will be needed to make 'add' respect --force.

Me either. I may take a look this weekend. I got sucked into an asm and
coccinelle rabbit hole the last few days.

-Peff
