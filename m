Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E0E202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936642AbdKQWDD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:03:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:32966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936637AbdKQWDC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:03:02 -0500
Received: (qmail 8957 invoked by uid 109); 17 Nov 2017 22:03:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:03:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28871 invoked by uid 111); 17 Nov 2017 22:03:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:03:17 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:03:00 -0500
Date:   Fri, 17 Nov 2017 17:03:00 -0500
From:   Jeff King <peff@peff.net>
To:     Luke Diamand <luke@diamand.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Users <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
Message-ID: <20171117220300.5zvyjwxgi2425m7z@sigill.intra.peff.net>
References: <CAE5ih78nLL6UhKPObvFEA9xQZUtc1XpPvGJNaYTH9fJ0RyFRvA@mail.gmail.com>
 <CAE5ih7_uuVVrze9gNr3JMg5HNH8eAcH_wM4wrc2kH6u=Hw0JOg@mail.gmail.com>
 <CAGZ79kZrZckX=xTgTH4cMper6BPAQ-_LT_x721SBEBB+Ks06jw@mail.gmail.com>
 <CAE5ih79TojvBv4OZnHejm3Huypg=6KVmDqJURGN+uk+izkH0xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE5ih79TojvBv4OZnHejm3Huypg=6KVmDqJURGN+uk+izkH0xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 09:38:26PM +0000, Luke Diamand wrote:

> >> Quite a few of the worktrees have expired - their head revision has
> >> been GC'd and no longer points to anything sensible
> >> (gc.worktreePruneExpire). The function other_head_refs() in worktree.c
> >> bails out if there's an error, which I think is the problem. I wonder
> >> if it should instead just report something and then keep going.
> >
> > Also see
> > https://public-inbox.org/git/CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com/
> 
> So is this a bug or user error on my part?

It's a bug. You didn't do anything wrong, but the worktree feature
corrupted your repository.

-Peff
