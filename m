Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0490C1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 02:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeIIHST (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 03:18:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:43978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726152AbeIIHST (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 03:18:19 -0400
Received: (qmail 16050 invoked by uid 109); 9 Sep 2018 02:30:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Sep 2018 02:30:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31882 invoked by uid 111); 9 Sep 2018 02:30:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 22:30:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 22:30:23 -0400
Date:   Sat, 8 Sep 2018 22:30:23 -0400
From:   Jeff King <peff@peff.net>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180909023023.GB13485@sigill.intra.peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <20180908212256.GB31560@sigill.intra.peff.net>
 <7f7e20fd-069d-f227-ce13-811398b52425@stason.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f7e20fd-069d-f227-ce13-811398b52425@stason.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 03:49:01PM -0700, Stas Bekman wrote:

> On 2018-09-08 02:22 PM, Jeff King wrote:
> [...]
> >> The original problem cropped up due to using:
> >>
> >>  git config --local include.path '../.gitconfig'
> >>
> >> which on linux stripped the single quotes, but on some windows git bash
> >> emulation it kept them.
> > 
> > That sounds like a bug in git bash, if it is not treating single quotes
> > in the usual shell way. But I'd also expect such a bug to cause loads of
> > problems in all of the shell scripts. Are you sure it wasn't cmd.exe or
> > some other interpreter?
> 
> I don't know, Jeff. I think the user said it was first anaconda shell.
> And then the user tried gitforwindows with same results. I don't know
> MSwindows at all.
> 
> But it doesn't matter at the end of the day, since we can't cover all
> possible unix shell emulations out there. What matters is that there is
> a way to flag the misconfiguration, either by default, or through a
> special check - some ideas I suggested in my previous email, but surely
> you have a much better insight of how to deal with that.

Yes, I agree this is pretty orthogonal to the config discussion. I was
just wondering if there was a separate bug to look into. I'm willing to
shrug and say "it was probably user error" until we see more definite
details. Thanks.

-Peff
