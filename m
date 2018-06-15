Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051A21F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965834AbeFOSqh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:46:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:46130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936114AbeFOSqh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:46:37 -0400
Received: (qmail 25175 invoked by uid 109); 15 Jun 2018 18:46:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 18:46:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23963 invoked by uid 111); 15 Jun 2018 18:46:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 14:46:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 14:46:35 -0400
Date:   Fri, 15 Jun 2018 14:46:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] ewah: drop ewah_serialize_native function
Message-ID: <20180615184634.GA18633@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033228.GC20390@sigill.intra.peff.net>
 <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
 <ab6378a8-3728-7fa8-da08-b58ec768dbfe@gmail.com>
 <20180615175111.GD3067@sigill.intra.peff.net>
 <xmqq602j293p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq602j293p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 11:33:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One thing that gave me pause on ripping out more code is that I have
> > some bitmap-related patches on my send-to-upstream list, and I wasn't
> > sure if they used any of this code. But I checked against your patches,
> > and no, this can all go (which makes sense -- my patches are about using
> > .bitmap files in more places, so they build at a higher level).
> >
> > So your patches look good to me, modulo the declarations that Ramsay
> > noticed should be removed, too.
> 
> I'll queue your 1/3 and 4/3 (without 2&3/3) for now and let Derrick
> and you handle the removal of unused stuff separately on top, so
> that the fix-proper can graduate earlier than the rest.

Thanks, that sounds good. 2/3 is sort-of-related in that it has an
integer overflow bug like the one in 1/3. But the fact that it is not
used at all makes it very low priority. ;)

-Peff
