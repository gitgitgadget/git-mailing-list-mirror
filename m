Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6CB2035A
	for <e@80x24.org>; Thu, 13 Jul 2017 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbdGMP71 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:59:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:39236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751835AbdGMP70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:59:26 -0400
Received: (qmail 26806 invoked by uid 109); 13 Jul 2017 15:59:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:59:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 440 invoked by uid 111); 13 Jul 2017 15:59:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:59:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:59:23 -0400
Date:   Thu, 13 Jul 2017 11:59:23 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
Message-ID: <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net>
References: <20170711233827.23486-1-sbeller@google.com>
 <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
 <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 02:08:35PM -0700, Stefan Beller wrote:

> > I could see somebody arguing that format-patch should respect a project
> > preference, since its primary purpose is to communicate your work to the
> > rest of the project.
> >
> > But then you could make a similar argument for other diff options, too.
> 
> This similar argument would be to have a in-tree configuration for
> --unified=<N> for example?

Yes, that was exactly the option I was thinking of. :)

> This triggers two reactions for me:
> 
> (a) We should totally do that.
>   Different projects have different coding styles (e.g. opening brace
>   in its own new line or at the end of the condition), which very much impacts
>   how useful the context is. So, sure, the project knows best what their
>   preference is.
> 
> (b) It's a rabbit hole to go down.
>   Any config option that format-patch respects can be argued to be useful
>   to be preset by a project. So in the end we'd have a ".gitconfig"
> file offering
>   good defaults for people using that project. This may have security
> implications.
>   And it's a lot of work.
> 
> I see your point for (b), I'll think about it more.

And yes, I had both of those reactions, too. We've had the
"project-level .gitconfig" discussion many times over the years. And it
generally comes back to "you can ship a snippet of config and then give
people a script which adds it to their repo".

-Peff
