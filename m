Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004EC1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968948AbdAGBLm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:11:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:36280 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936656AbdAGBLk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:11:40 -0500
Received: (qmail 29217 invoked by uid 109); 7 Jan 2017 01:11:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:11:40 +0000
Received: (qmail 21836 invoked by uid 111); 7 Jan 2017 01:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:12:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:11:38 -0500
Date:   Fri, 6 Jan 2017 20:11:38 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
Message-ID: <20170107011138.uuy6ob234kyy3y4e@sigill.intra.peff.net>
References: <20170106045623.21118-1-kyle@kyleam.com>
 <alpine.DEB.2.20.1701061438300.3469@virtualbox>
 <87inprllpv.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87inprllpv.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 08:09:32PM -0500, Kyle Meyer wrote:

> > $ git grep -c HEAD^{} junio/pu -- t/
> > junio/pu:t/t3200-branch.sh:3
> >
> > Maybe use HEAD^0 just for consistency?
> 
> Yes, thanks for pointing that out.

The other option is just "git checkout --detach", which is also used in
the test suite. I tend to prefer it because it's a little more obvious
to a reader.

-Peff
