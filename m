Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48DE1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeFOGjk (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:39:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:45498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755853AbeFOGjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:39:39 -0400
Received: (qmail 25733 invoked by uid 109); 15 Jun 2018 06:39:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 06:39:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19457 invoked by uid 111); 15 Jun 2018 06:39:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 02:39:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 02:39:38 -0400
Date:   Fri, 15 Jun 2018 02:39:38 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
Message-ID: <20180615063937.GA10802@sigill.intra.peff.net>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
 <20180615042023.GA31294@sigill.intra.peff.net>
 <CAPig+cTSirqhayBDJFZhn2HL4EMr36GHuCOYAMaCeptqFtoR=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTSirqhayBDJFZhn2HL4EMr36GHuCOYAMaCeptqFtoR=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 02:30:43AM -0400, Eric Sunshine wrote:

> On Fri, Jun 15, 2018 at 12:20 AM Jeff King <peff@peff.net> wrote:
> > We have OLD_ICONV, too, which should probably do nothing if NO_ICONV is
> > set. I think that works OK. We end up setting -DOLD_ICONV on the command
> > line, but that's only consider inside "#ifndef NO_ICONV" within the
> > code.
> 
> Right, that was my conclusion, as well. Since it works as is, I'm not
> sure suppressing -DOLD_ICONV in Makefile is worth the extra patch
> noise. I can re-roll with that change too, if someone thinks it's
> worthwhile, though.

Nah, I was just thinking out loud. I don't think it's worth changing the
Makefile (and I wouldn't be surprised if there are other "dependent"
cases like this that work just fine because of the #ifdefs in the code).

-Peff
