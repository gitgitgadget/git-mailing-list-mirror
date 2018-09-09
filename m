Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8536F1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 02:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeIIHV3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 03:21:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:43990 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726152AbeIIHV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 03:21:29 -0400
Received: (qmail 16195 invoked by uid 109); 9 Sep 2018 02:33:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Sep 2018 02:33:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31909 invoked by uid 111); 9 Sep 2018 02:33:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 22:33:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 22:33:33 -0400
Date:   Sat, 8 Sep 2018 22:33:33 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180909023332.GA14762@sigill.intra.peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
 <20180908211436.GA31560@sigill.intra.peff.net>
 <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 11:10:44PM +0100, Ramsay Jones wrote:

> > Probably:
> > 
> >   [include]
> >   warnOnMissing = false
> >   path = ...
> 
> I was going to suggest, inspired by Makefile syntax, that
> [-include] would not complain if the file was missing ...
> except, of course, it's too late for that! ;-)
> 
> I suppose [+include] could complain if the file is missing
> instead, ... dunno.

I think that's syntactically invalid. At any rate, there are clearly
three options for setting a bit:

  1. In the section header (+include, or Ævar's includeIf suggestion).

  2. In another key (which looks pretty clean, but does introduce
     ordering constraints).

  3. In the key name (maybePath or similar).

I don't have a huge preference between them.

-Peff
