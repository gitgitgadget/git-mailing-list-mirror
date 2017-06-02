Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F322027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdFBWvv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:51:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:34165 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBWvv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:51:51 -0400
Received: (qmail 9085 invoked by uid 109); 2 Jun 2017 22:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 22:51:50 +0000
Received: (qmail 435 invoked by uid 111); 2 Jun 2017 22:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:52:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 18:51:48 -0400
Date:   Fri, 2 Jun 2017 18:51:48 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Mueller <ulm@gentoo.org>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
Message-ID: <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
References: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 03, 2017 at 12:47:59AM +0200, Ulrich Mueller wrote:

> >>>>> On Fri, 2 Jun 2017, Jeff King wrote:
> 
> > The remaining question is whether we want to care about preserving the
> > system %Z for the local-timezone case.
> 
> No strong preference here. Maybe go for consistency, and have %Z
> always return the same format (either empty, or same as %z). That
> would at least prevent surprises when users switch from format-local
> to format.

It also a lot easier to implement, which is nice.

I agree on the least surprise thing, but the flipside of this is that
Git's use of strftime will behave differently than other programs on the
system (e.g., "date +%Z").

-Peff
