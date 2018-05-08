Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336F4200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeEHDsS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:48:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:59860 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753971AbeEHDsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:48:17 -0400
Received: (qmail 10399 invoked by uid 109); 8 May 2018 03:48:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 03:48:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1245 invoked by uid 111); 8 May 2018 03:48:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 23:48:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 23:48:15 -0400
Date:   Mon, 7 May 2018 23:48:15 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180508034815.GB7242@sigill.intra.peff.net>
References: <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
 <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
 <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
 <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
 <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
 <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
 <20180508034429.GA7242@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508034429.GA7242@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 11:44:29PM -0400, Jeff King wrote:

> On Mon, May 07, 2018 at 03:24:59PM -0700, Stefan Beller wrote:
> 
> > Hence I propose "git range-diff", similar to topic-diff, that
> > was proposed earlier.
> > 
> > * it "diffs ranges" of commits.
> > * it can also deal with out-of-git things like patch series,
> >   but that is a mere by product and may not be desired.
> >   Just like git-diff can also compare two files outside a git
> >   repo, that would not be a good use case.
> >   Keep the name Git-centric!
> > * it autocompletes well.
> 
> FWIW, I like this by far of all of the suggested names.

I hit "send" before I had a chance to expound. ;)

The thing that I really like about it is that it names the _concept_.
If I were writing a manual page describing what this output is, I would
call it a "range diff". And naturally, the command to generate range
diffs is "git range-diff".

I think "git diff --range" would also be OK, but IMHO it's useful to
keep the "git diff" family as always comparing end-points.

-Peff
