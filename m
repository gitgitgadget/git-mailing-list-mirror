Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E81920248
	for <e@80x24.org>; Wed,  6 Mar 2019 21:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfCFVyV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 16:54:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:41534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725790AbfCFVyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 16:54:21 -0500
Received: (qmail 1083 invoked by uid 109); 6 Mar 2019 21:54:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 21:54:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17925 invoked by uid 111); 6 Mar 2019 21:54:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 16:54:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 16:54:19 -0500
Date:   Wed, 6 Mar 2019 16:54:19 -0500
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Fabio Aiuto <polinice83@libero.it>, git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190306215419.GB32630@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
 <20190304204007.GA32691@sigill.intra.peff.net>
 <20190305191519.GA12791@sigill.intra.peff.net>
 <1551902320.1727.1.camel@libero.it>
 <20190306200356.GB23315@sigill.intra.peff.net>
 <1551903598.1727.3.camel@libero.it>
 <20190306203910.xr2bwpqb3zrxnm63@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306203910.xr2bwpqb3zrxnm63@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 03:39:11PM -0500, Santiago Torres wrote:

> I still find it somewhat astounding that it compiles with a modern
> toolchain after 15+ years. Many projects fail to do so (it's an
> understandably high bar to have).

I think the key thing is that Git has very few external dependencies.
You'll note that I had to turn off OpenSSL support to get it to compile.
The only other library from back then is libz, which is extremely
stable.

Other than, it just depends on a reasonable C compiler and a POSIX libc,
both of which have been standardized for decades.

I suspect that today's Git will also compile pretty well in 15 years,
but you'll probably to say NO_GETTEXT and turn a few other knobs.
Libcurl might eventually be a problem, though I've been pretty impressed
with its stability and backwards-compatibility so far (and of course
it's optional if disabling http support is OK).

-Peff
