Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B391F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeJWFf7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:35:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:49726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727557AbeJWFf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:35:59 -0400
Received: (qmail 14358 invoked by uid 109); 22 Oct 2018 21:15:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Oct 2018 21:15:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10506 invoked by uid 111); 22 Oct 2018 21:15:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Oct 2018 17:15:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2018 17:15:45 -0400
Date:   Mon, 22 Oct 2018 17:15:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
Message-ID: <20181022211545.GA15713@sigill.intra.peff.net>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
 <20181018225739.28857-1-avarab@gmail.com>
 <20181019220755.GA31563@sigill.intra.peff.net>
 <87ftx0dg4r.fsf@evledraar.gmail.com>
 <20181020185852.GA6234@sigill.intra.peff.net>
 <87efckctqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efckctqa.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 09:18:21PM +0200, Ævar Arnfjörð Bjarmason wrote:

> We didn't support chained aliases at all before, so I think the odds
> that people will run into this now will increase as they add "!" to
> existing aliases, and I'd like to have git's UI friendly enough to tell
> users what went wrong by default, and not have to resort to the likes of
> GIT_TRACE=1 which really should be left to powerusers.

It's true that non-! aliases couldn't recurse before, but couldn't "!"
ones always do so?

-Peff
