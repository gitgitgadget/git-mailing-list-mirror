Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E809A20986
	for <e@80x24.org>; Thu, 29 Sep 2016 09:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbcI2J0B (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 05:26:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49823 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932451AbcI2J0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 05:26:00 -0400
Received: (qmail 13407 invoked by uid 109); 29 Sep 2016 09:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 09:25:58 +0000
Received: (qmail 32387 invoked by uid 111); 29 Sep 2016 09:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 05:26:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 05:25:56 -0400
Date:   Thu, 29 Sep 2016 05:25:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160929092556.3kkmdd6uprss76zx@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-5-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160928233047.14313-5-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 04:30:47PM -0700, Junio C Hamano wrote:

> As Peff said, responding in a thread started by Linus's suggestion
> to raise the default abbreviation to 12 hexdigits:
> 
>     I actually think "12" might be sane for a long time. That's 48 bits of
>     sha1, so we'd expect a 50% change of a _single_ collision at 2^24, or 16
>     million.  The biggest repository I know about (in number of objects) is
>     the one holding all of the objects for all of the forks of
>     torvalds/linux on GitHub. It's at about 15 million objects.
> 
>     Which _seems_ close, but remember that's the size where we expect to see
>     a single collision. They don't become common until much later (I didn't
>     compute an exact number, but Linus's 16x sounds about right). I know
>     that the growth of the kernel isn't really linear, but I think the need
>     to bump to "13" might not just be decades, but possibly a century or
>     more.
> 
>     So 12 seems reasonable, and the only downside for it (or for "13", for
>     that matter) is a few extra bytes. I dunno, maybe people will really
>     hate that, but I have a feeling these are mostly cut-and-pasted anyway.

I am not sure my quote is a good rationale for this bump. It was meant
to be a rationale that "12" is big enough, but the "I dunno" at the end
kind of glosses over the downsides.

-Peff
