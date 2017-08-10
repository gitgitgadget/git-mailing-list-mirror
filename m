Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D14208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbdHJVKm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:10:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:35266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752816AbdHJVKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:10:41 -0400
Received: (qmail 28741 invoked by uid 109); 10 Aug 2017 21:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 21:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9828 invoked by uid 111); 10 Aug 2017 21:11:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 17:11:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 17:10:39 -0400
Date:   Thu, 10 Aug 2017 17:10:39 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
Message-ID: <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
 <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
 <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:06:40PM +0200, Christian Couder wrote:

> >> Related to this, I wonder if people might want to "normalize" in
> >> different ways later. If that happens, we might regret having called
> >> this option "--normalize" instead of "--one-per-line" for example.
> >
> > What is normal?
> >
> > Maybe --style=[one-line, wrapped:72, rfc, json, xml, ...]
> > then?
> 
> Yeah, we could go there right now (using perhaps "--pretty" or
> "--format" instead of "--style", so that we are more consistent with
> other commands), but on the other hand we don't know yet if the other
> formats will really be needed.

But some of those things are not 1:1 mappings with normalization.  For
instance, --json presumably implies --only-trailers. Or are we proposing
to break the whole commit message down into components and output it all
as json?

-Peff
