Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3EE20248
	for <e@80x24.org>; Tue, 26 Feb 2019 21:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfBZVCc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 16:02:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:59132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728303AbfBZVCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 16:02:32 -0500
Received: (qmail 6030 invoked by uid 109); 26 Feb 2019 21:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Feb 2019 21:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32542 invoked by uid 111); 26 Feb 2019 21:02:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Feb 2019 16:02:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2019 16:02:30 -0500
Date:   Tue, 26 Feb 2019 16:02:30 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226210229.GB27914@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226173542.GC19606@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902262055260.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902262055260.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 08:58:43PM +0100, Johannes Schindelin wrote:

> On Tue, 26 Feb 2019, Jeff King wrote:
> 
> > I had a vague notion that there was some reason (portability?) that we
> > preferred to have the wrappers. But as your patch shows, they really are
> > just calling "test" and nothing else.
> 
> Let's also not forget about the fact that `test -f` is actually not all
> that intuitive an interface. Whereas even somebody without training in
> software development (let alone Unix shell scripting) understands the
> meaning of
> 
> 	test_path_is_file this-file.txt
> 
> And even for a trained eye, the trace of `test -f` is sometimes hard to
> read, as you do *not* see the exit code in the trace, so you have to guess
> from circumstantial evidence whether it failed or succeeded.

True. For old-timers, I think "test -f" is idiomatic, but that is not
true for everyone. Sometimes wrappers can cut both ways, making things
harder for people who are used to the idioms. But "test_path_is_file"
should be pretty readable for everyone, old and new alike, I would
think.

-Peff
