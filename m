Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA774208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdHJTmy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:42:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:35062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752772AbdHJTmy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:42:54 -0400
Received: (qmail 24596 invoked by uid 109); 10 Aug 2017 19:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8650 invoked by uid 111); 10 Aug 2017 19:43:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 15:43:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 15:42:52 -0400
Date:   Thu, 10 Aug 2017 15:42:52 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
Message-ID: <20170810194251.r76pumddcchlke7c@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
 <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 09:39:21PM +0200, Christian Couder wrote:

> > If you prefer the normalized form (and the input was line-broken in a
> > way that you don't like), then this would convert to your preferred
> > form. I agree that you could potentially want the opposite (folding long
> > lines). Perhaps something like --wrap=72.
> 
> Related to this, I wonder if people might want to "normalize" in
> different ways later. If that happens, we might regret having called
> this option "--normalize" instead of "--one-per-line" for example.

My assumption was that it would be OK to add other normalization later
if it brings us closer to the "key: value" form as a standard, and it
could fall under "--normalize", since that's what callers would want.
And that's why I didn't want to call it something like --one-per-line.

But if you are arguing that there can be many "standards" to normalize
to, I agree that's a possibility. I think we have an out by extending to
"--normalize=whatever-form" in the future.

-Peff
