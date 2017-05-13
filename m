Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681E4201A4
	for <e@80x24.org>; Sat, 13 May 2017 09:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdEMJaA (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 05:30:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:50790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdEMJ37 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 05:29:59 -0400
Received: (qmail 29944 invoked by uid 109); 13 May 2017 09:29:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 09:29:54 +0000
Received: (qmail 30738 invoked by uid 111); 13 May 2017 09:30:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 05:30:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 05:29:52 -0400
Date:   Sat, 13 May 2017 05:29:52 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, spearce@spearce.org
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170513092952.53h2l4nb727y5f7g@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
 <20170511100553.ptyazchujgdfxotl@sigill.intra.peff.net>
 <20170511170050.GA83655@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511170050.GA83655@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:00:50AM -0700, Brandon Williams wrote:

> > None of this is your problem now either way; the advertisement-limiting
> > extension is still vaporware, albeit one we've discussed a lot. I just
> > wanted to make sure we weren't painting ourselves into any corners. And
> > I think this case could probably be handled.
> 
> I can't remember, is there any reason why it is still vaporware? As in
> what is holding us back from doing the advertisement-limiting (or doing
> away with the initial ref  advertisement)?

The tricky part is handling the compatibility issues. The client has no
way to speak first in the current protocol, so we have to break protocol
to tell the server our refspecs before the advertisement.

I actually put together patches last fall for this, got derailed by a
small snag while polishing them, and just haven't picked them up again.
If you're interested, they're at the jk/early-caps-wip branch of
https://github.com/peff/git.

I got as far as breaking it all up into patches, but the commit messages
still need to be written. Some of them are pretty obvious to me still
after 6 months, but a few are a bit inscrutable.

-Peff
