Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3741F45F
	for <e@80x24.org>; Wed,  8 May 2019 23:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfEHXWT (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 19:22:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727469AbfEHXWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 19:22:19 -0400
Received: (qmail 6051 invoked by uid 109); 8 May 2019 23:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 May 2019 23:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29180 invoked by uid 111); 8 May 2019 23:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 May 2019 19:22:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 May 2019 19:22:17 -0400
Date:   Wed, 8 May 2019 19:22:17 -0400
From:   Jeff King <peff@peff.net>
To:     opal hart <opal@wowana.me>
Cc:     git@vger.kernel.org
Subject: Re: Cannot access git-scm.com with Tor
Message-ID: <20190508232216.GD19990@sigill.intra.peff.net>
References: <20190507070028.54c291af@clamav.local>
 <20190507073322.GD28060@sigill.intra.peff.net>
 <20190508083917.50f2cf59@clamav.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508083917.50f2cf59@clamav.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 08:39:17AM +0000, opal hart wrote:

> On Tue, 7 May 2019 03:33:22 -0400
> Jeff King <peff@peff.net> wrote:
> 
> > The "security settings" toggle for the site on Cloudflare is already set
> > to "low", and there are no other restrictions. Is it actually blocking?
> > Or is it asking for a CAPTCHA?
> 
> Sorry, it is indeed asking for a CAPTCHA. Google reCAPTCHA does not do
> a great job at accomodating Tor users; it effectively blocks us with an
> endless barrage of puzzles unless we log in to a Google account.

Yeah, even though it at least provides _a_ way to get to the content,
I'd just as soon not inconvenience people for no reason (and in fact,
avoiding CAPTCHAs is why I had initially lowered it from the default).

I dropped the setting in Cloudflare to "essentially off". Using
torbrowser I didn't get a CAPTCHA either before or after the setting, so
I have no idea if it actually changed anything. But hopefully it is
better for you now.

I also checked the settings for git-scm.org (same content, different
domain), which had accidentally been left at "medium". Those are now at
off, too.

-Peff
