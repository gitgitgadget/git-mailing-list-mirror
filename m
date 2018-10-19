Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95921F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJTBC3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:02:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:46538 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727549AbeJTBC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:02:29 -0400
Received: (qmail 25504 invoked by uid 109); 19 Oct 2018 16:55:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 16:55:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12894 invoked by uid 111); 19 Oct 2018 16:54:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 12:54:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 12:55:32 -0400
Date:   Fri, 19 Oct 2018 12:55:32 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on
 the_index
Message-ID: <20181019165532.GA31601@sigill.intra.peff.net>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com>
 <20181019162021.GA14778@sigill.intra.peff.net>
 <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com>
 <20181019164237.GA24740@sigill.intra.peff.net>
 <20181019165301.GA31850@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181019165301.GA31850@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 06:53:01PM +0200, Duy Nguyen wrote:

> > OK, that all makes sense. I need to either drop it or mark it unused to
> > satisfy -Wunused-parameters.
> 
> Aha! I thought you looked deeply into this and was very confused. How
> could you have found the time :D

To be fair, dealing with -Wunused-parameters is its own special time
sink. :)

> > I think I'd lean toward the former, if
> > it's not likely to be used (even if we add "struct repository" later,
> > the separate index parameter would just go away then).
> 
> Or we could fix it now. Something like this? It adds three the_repository
> (two technically are already there) but deletes eight, which makes me
> happy. It's up to you to decide.

Yeah, that's fine by me, if it's not getting in the way of other related
work. The patch you sent looks reasonable.

-Peff
