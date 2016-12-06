Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60EF1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 19:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbcLFTc1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 14:32:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:52682 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbcLFTc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 14:32:26 -0500
Received: (qmail 8962 invoked by uid 109); 6 Dec 2016 19:31:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 19:31:56 +0000
Received: (qmail 16451 invoked by uid 111); 6 Dec 2016 19:32:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 14:32:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 14:31:54 -0500
Date:   Tue, 6 Dec 2016 14:31:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Patey <matthew.patey2167@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
Message-ID: <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net>
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
 <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
 <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
 <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
 <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
 <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 11:20:18AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> If you run:
> >> 
> >>   git -c diff.renames=false stash
> >> 
> >> then it works.
> >
> > And here's a patch to fix it.
> 
> Yuck.  This obviously has easier to bite more people since we
> enabled the renames by default.  Thanks for a quick fix.
> 
> I wonder why we are using "git diff" here, not the plumbing,
> though.

I don't think there's a plumbing command which works for diffing the
working tree directly to a git tree. In the long run, it might be a good
idea to remedy that.

Though I'm not sure that "git add -u" would not accomplish the same
thing as these several commands.

-Peff
