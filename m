Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93F320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 14:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeLKOMn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:12:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:38248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726444AbeLKOMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:12:42 -0500
Received: (qmail 23115 invoked by uid 109); 11 Dec 2018 14:12:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 14:12:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6120 invoked by uid 111); 11 Dec 2018 14:11:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 09:11:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 09:11:59 -0500
Date:   Tue, 11 Dec 2018 09:11:59 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        paul.morelle@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181211141159.GB13731@sigill.intra.peff.net>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
 <CAPig+cT6yo+wBHhkaAFK1REisOdtZsJNWEhoShcspzQsFeiWxQ@mail.gmail.com>
 <20181202033110.GA30004@sigill.intra.peff.net>
 <8736r4nsna.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736r4nsna.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 01:40:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> Are you thinking of the "break" command (not "pause") which Dscho
> >> already added[1]?
> >>
> >> [1]: 71f82465b1 (rebase -i: introduce the 'break' command, 2018-10-12)
> >
> > Yes, thanks (as you can see, I haven't actually used it yet ;) ).
> 
> Related: I got poked about a bug where someone was doing "exec bash" to
> do the same, and would then CD to other repos, and git operations would
> still be executed on the original repo because we set GIT_DIR=* in the
> envioronment (but not for "break").
> 
> Not a big deal, but I wondered if that was a bug in itself, i.e. if we
> need to set GIT_DIR et al in the environment for "exec". Isn't having
> the current directory set to the checkout sufficient?

This behavior is discussed in this sub-thread:

  https://public-inbox.org/git/xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com/

-Peff
