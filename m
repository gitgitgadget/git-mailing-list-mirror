Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2610C207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 01:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbdFXBLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 21:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:51482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754175AbdFXBLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 21:11:33 -0400
Received: (qmail 32707 invoked by uid 109); 24 Jun 2017 01:11:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 01:11:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20498 invoked by uid 111); 24 Jun 2017 01:11:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 21:11:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 21:11:31 -0400
Date:   Fri, 23 Jun 2017 21:11:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Create a reference backend for packed refs
Message-ID: <20170624011131.5kgmzgpb4vtwikk5@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net>
 <20170623200024.amgced62hue2iffj@sigill.intra.peff.net>
 <xmqqefuacr6y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefuacr6y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 02:47:01PM -0700, Junio C Hamano wrote:

> > Speculating on my own question. I guess it would prepare us for a day
> > when a possible ref store is to use a packed-refs _without_ loose refs.
> > IOW, the property is defined on packed-refs today, but a possible future
> > direction would be to use it by itself. But maybe I'm just making things
> > up.
> 
> OK.  In other words, it's not a packed-refs's characteristics that
> cruft are allowed.  It's that a ref storage that is implemented as
> an overlay of one storage (which happens to be the loose one) on top
> of another (which happens to be the packed refs file) allows the
> latter one to have cruft if (and only if) that broken one is covered
> by the former one.

Thanks, that's a much better way of saying what I was trying to get at.
I don't know if that's Michael's argument or not, but it's certainly one
I find reasonable. :)

-Peff
