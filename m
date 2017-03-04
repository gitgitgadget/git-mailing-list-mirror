Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704F52013E
	for <e@80x24.org>; Sat,  4 Mar 2017 07:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdCDHlz (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 02:41:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:38539 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdCDHly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 02:41:54 -0500
Received: (qmail 21656 invoked by uid 109); 4 Mar 2017 07:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 07:41:43 +0000
Received: (qmail 4595 invoked by uid 111); 4 Mar 2017 07:41:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 02:41:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Mar 2017 02:41:40 -0500
Date:   Sat, 4 Mar 2017 02:41:40 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH] http: inform about alternates-as-redirects behavior
Message-ID: <20170304074140.mzgs27jp2jer4mlv@sigill.intra.peff.net>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
 <20170304065548.GA20734@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304065548.GA20734@whir>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2017 at 06:55:48AM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > The warning itself:
> > 
> > > +		warning("alternate disabled by http.followRedirects!=true: %s",
> > 
> > feels like it could use some whitespace around the "!=", but maybe
> > that's just me.
> 
> Yeah, I kinda wanted to emulate the command-line syntax.
> 
> Maybe rewording it a bit and showing how to enable it will
> make more sense:
> 
> 		warning("alternate: %s", url);
> 		warning(" may be enabled by -c http.followRedirects=true");

I kind of hoped people would look at the documentation for
followRedirects before blindly enabling it. Though I guess the
documentation doesn't really explain the possible security implications,
so maybe it doesn't matter (and they're pretty subtle anyway).

-Peff
