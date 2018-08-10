Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871781F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHKBbO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:31:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726774AbeHKBbN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:31:13 -0400
Received: (qmail 27530 invoked by uid 109); 10 Aug 2018 22:59:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 22:59:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24333 invoked by uid 111); 10 Aug 2018 22:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 18:59:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 18:59:18 -0400
Date:   Fri, 10 Aug 2018 18:59:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] packfile: iterate packed objects in pack order
Message-ID: <20180810225918.GA18913@sigill.intra.peff.net>
References: <20180808231210.242120-1-jonathantanmy@google.com>
 <20180808232515.GC21882@sigill.intra.peff.net>
 <CAGf8dgK_yMEtyh+_chQ+9i2d1Uc9oAXr7Q_8ES5OPF8qF87EHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGf8dgK_yMEtyh+_chQ+9i2d1Uc9oAXr7Q_8ES5OPF8qF87EHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 03:03:24PM -0700, Jonathan Tan wrote:

> On Wed, Aug 8, 2018 at 4:25 PM, Jeff King <peff@peff.net> wrote:
> > Even if you just use the oid to do a separate lookup in the object
> > database, there's still a benefit in accessing the objects in pack
> > order.
> 
> You're probably right, but I don't immediately see what the benefit is.
> 
> On a not completely unrelated note, I just realized that in my patch,
> i should be pack_nr (ordinal in pack order) and pack_nr should be
> index_nr (ordinal in index order, i.e. alphabetical order). If you run
> with this, feel free to write your own patch and maybe I'll learn how
> accessing objects in pack order benefits looking up the object
> database through the commit message.

It probably would have been more apparent if when I said "like in the
patch below" I actually remembered to paste in the patch. ;)

> > I can try to pick this up and carry the cat-file bits to completion if
> > you want, but probably not until tomorrow or Friday.
> 
> Thanks - feel free to do this.

I've got a series which I'll post momentarily which hopefully explains
what's going on, along with various timings.

-Peff
