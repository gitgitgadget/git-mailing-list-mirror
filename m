Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2B5C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 18:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiKQSwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiKQSvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 13:51:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9A5917F
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:51:52 -0800 (PST)
Received: (qmail 26086 invoked by uid 109); 17 Nov 2022 18:51:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 18:51:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14724 invoked by uid 111); 17 Nov 2022 18:51:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 13:51:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 13:51:51 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Subject: Re: The enduring popularity of git-credential-store
Message-ID: <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net>
 <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 09:17:53AM -0800, Matthew John Cheetham wrote:

> > In the ideal world, we'd ship an encrypted store that people could use,
> > but then we have to deal with export regulations and sanctions and
> > nobody wants to do that.  We'd also have to deal with multiple
> > cryptographic libraries for portability and license reasons and nobody
> > wants to do that, either.
> 
> One option rather than shipping (or including in contrib/) any of these
> credential helpers, could we not reference several other popular helpers
> in the docs, and let users make their own choice (but at least some are
> then possibly more discoverable)?

I don't have any problem with documenting the options better. The main
reason we have store/cache at all, even though they kind of suck, was to
act as least-common-denominators and pave the way for people making
better helpers. That happened, but nobody ever went back to adjust the
docs.

I do think having the docs say "you should go use X" means that X will
have an advantage over other projects which may compete with it. So I
think we need to be careful to be inclusive of what we'll mention, and
to word it so that we're not endorsing any one project.

-Peff
