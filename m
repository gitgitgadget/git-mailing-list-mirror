Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662281FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 13:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760300AbcLPNjp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 08:39:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:57557 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757712AbcLPNjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 08:39:44 -0500
Received: (qmail 16371 invoked by uid 109); 16 Dec 2016 13:39:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 13:39:43 +0000
Received: (qmail 11652 invoked by uid 111); 16 Dec 2016 13:40:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 08:40:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 08:39:40 -0500
Date:   Fri, 16 Dec 2016 08:39:40 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Message-ID: <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 01:29:47PM -0800, Linus Torvalds wrote:

> On Tue, Oct 11, 2016 at 11:45 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > In some situations you may want to group the commits not by author,
> > but by committer instead.
> >
> > For example, when I just wanted to look up what I'm still missing from
> > linux-next in the current merge window [..]
> 
> It's another merge window later for the kernel, and I just re-applied
> this patch to my git tree because I still want to know teh committer
> information rather than the authorship information, and it still seems
> to be the simplest way to do that.
> 
> Jeff had apparently done something similar as part of a bigger
> patch-series, but I don't see that either. I really don't care very
> much how this is done, but I do find this very useful, I do things
> like

Sorry if I de-railed the earlier conversation. The shortlog
group-by-trailer work didn't seem useful enough for me to make it a
priority.

I'm OK with the approach your patch takes, but I think there were some
unresolved issues:

  - are we OK taking the short "-c" for this, or do we want
    "--group-by=committer" or something like it?

  - no tests; you can steal the general form from my [1]

  - no documentation (can also be stolen from [1], though the syntax is
    quite different)

-Peff

[1] http://public-inbox.org/git/20151229073515.GK8842@sigill.intra.peff.net/
