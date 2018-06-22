Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3E01F516
	for <e@80x24.org>; Fri, 22 Jun 2018 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933662AbeFVW0Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 18:26:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:52532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932076AbeFVW0P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 18:26:15 -0400
Received: (qmail 4205 invoked by uid 109); 22 Jun 2018 22:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 22:26:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23342 invoked by uid 111); 22 Jun 2018 22:26:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 18:26:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 18:26:13 -0400
Date:   Fri, 22 Jun 2018 18:26:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180622222613.GA4305@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
 <20180621115302.GB15293@sigill.intra.peff.net>
 <20180621120159.GC15293@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806222344280.11870@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806222344280.11870@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 11:45:09PM +0200, Johannes Schindelin wrote:

> > This might be a candidate for another "weather balloon" patch to see if
> > anybody complains, though. The last time time we dealt with this in a
> > major way was over 7 years ago in 28bd70d811 (unbreak and eliminate
> > NO_C99_FORMAT, 2011-03-16).
> > 
> > I know Johannes switched out some "%lu" for PRIuMAX as recently as last
> > August[1], but I think that is more about the Windows size_t not matching
> > "unsigned long", and the decision to use PRIuMAX was to match the
> > existing codebase. AFAIK %zu is available on Windows.
> 
> Nope, it's not available:
> 
> git.c: In function 'cmd_main':
> git.c:733:10: error: unknown conversion type character 'z' in format [-Werror=format=]
>  die("x: %z", (void *)(intptr_t)0x123456789a);

Well, that resolve that, then. :)

Thanks for letting us know before we went down a dead-end.

-Peff
