Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8C91F404
	for <e@80x24.org>; Sat, 11 Aug 2018 00:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeHKDFc (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 23:05:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:50818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726747AbeHKDFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 23:05:32 -0400
Received: (qmail 30980 invoked by uid 109); 11 Aug 2018 00:33:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 00:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25513 invoked by uid 111); 11 Aug 2018 00:33:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 20:33:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 20:33:19 -0400
Date:   Fri, 10 Aug 2018 20:33:19 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/7] for_each_*_object: store flag definitions in a
 single location
Message-ID: <20180811003319.GA29490@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <20180810230906.GA19875@sigill.intra.peff.net>
 <CAGZ79kYStPNCodJBqZ-ELh2oEhEyQFFjr0SVn0Bn+gtAspbZiA@mail.gmail.com>
 <20180810233133.GA30076@sigill.intra.peff.net>
 <20180810233347.GA30479@sigill.intra.peff.net>
 <CAGZ79kZ0eN5eaBM8HjLVFpW8-ph3g0ym=-4ONTA7pgV=k3oz-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ0eN5eaBM8HjLVFpW8-ph3g0ym=-4ONTA7pgV=k3oz-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 04:39:14PM -0700, Stefan Beller wrote:

> > IMHO the whole for_each_*_object() interface should go in there (it even
> > has packed_git defined there already!). I think I'd still just as soon
> > do it on top of this series, but it might not be too bad to do as part
> > of a re-roll.
> 
> Yeah, I realize that I distracted myself and ranted about a different thing
> other than the quality of this patch. (We had a couple of internal discussions
> about project velocity and contributor happiness and I personally think this
> derailing is some sort of anti pattern as fixing things like these is easy
> as compared to user visible things such as file formats or configs.
> Sorry for that.)

It's a tough line to draw sometimes. This kind of ancillary discussion
is often what spurs further work, so I think the discussions are good to
have. And sometimes the right answer is "yeah, while we're here, let's
clean this up, too". This may even be one of those cases.

But sometimes the right answer is to push back a little and say "you're
right, but let's deal with it later". And maybe later never even
happens, but in that case maybe it wasn't that important in the first
place. :) Or maybe it takes the same point coming up a few times to
decide it's worth pursuing.

I wish I had a good guideline for when to start such a discussion and
when to push back. I mostly just follow my instincts, and my answer (on
either side of that conversation) might change from day to day.  I think
the most important guideline is for everybody to be accepting of both
sides of the conversation (i.e., it's OK to prod a little about
ancillary issues as long as "yes, but not right now" is an acceptable
answer).

And then sometimes you catch me in a philosophical mood...

-Peff
