Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0354AC433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3F020775
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgF3TTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:19:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:46470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgF3TTn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:19:43 -0400
Received: (qmail 14297 invoked by uid 109); 30 Jun 2020 19:19:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2020 19:19:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26043 invoked by uid 111); 30 Jun 2020 19:19:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2020 15:19:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jun 2020 15:19:41 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] t4216: fix broken '&&'-chain
Message-ID: <20200630191941.GD1888406@coredump.intra.peff.net>
References: <cover.1593536481.git.me@ttaylorr.com>
 <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
 <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
 <20200630183928.GB26550@syl.lan>
 <20200630190325.GB1888406@coredump.intra.peff.net>
 <20200630191231.GA30767@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630191231.GA30767@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 03:12:31PM -0400, Taylor Blau wrote:

> > I think so, but my argument would be more along the lines of:
> >
> >   - without "-f", "rm" will complain about a missing file, which is
> >     distracting noise in the test log
> >
> >   - once "-f" is added in to suppress that, we might as well add the
> >     command to the &&-chain. That's our normal style, so readers don't
> >     have to wonder if it's important or not. Plus it would help avoid a
> >     broken chain if more commands are added at the beginning of the
> >     function.
> 
> I made the change for basically these reasons, but mostly to bring this
> function into good style as with the rest of our test suite (there are a
> handful of other minor nits that we could look at, such as some odd
> spacing, etc.).
> 
> Whether or not all of this needs to go into the commit message... I
> don't know. On the one hand, I think that your explanation here is
> clearer than what I wrote in the commit message, but on the other hand,
> I think that amending it again may be belaboring an otherwise simple
> change.
> 
> If you feel strongly, though, I'm happy to send a revised patch.

I agree it's a pretty trivial patch, but I think if it's worth applying
at all, then it's worth justifying it appropriately.

-Peff
