Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B6C1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391729AbeKWCq5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:46:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:48622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729773AbeKWCq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:46:57 -0500
Received: (qmail 22889 invoked by uid 109); 22 Nov 2018 16:06:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:06:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23288 invoked by uid 111); 22 Nov 2018 16:06:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:06:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:06:56 -0500
Date:   Thu, 22 Nov 2018 11:06:56 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        mhagger@alum.mit.edu, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dnj@google.com,
        prohaska@zib.de, john@keeping.me.uk, stanhu@gmail.com,
        richardc@unixbeard.net, Joey Hess <id@joeyh.name>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like
 "git-init"
Message-ID: <20181122160656.GB28192@sigill.intra.peff.net>
References: <87efkkdwcv.fsf@evledraar.gmail.com>
 <20181102223743.4331-1-avarab@gmail.com>
 <87k1ld1f51.fsf@evledraar.gmail.com>
 <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com>
 <87in0w25gc.fsf@evledraar.gmail.com>
 <20181117063940.GA31057@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811221344360.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811221344360.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 01:48:53PM +0100, Johannes Schindelin wrote:

> > So it's maybe do-able, but not quite as trivial as one might hope.
> 
> A trivial alternative would be to recommend adding a man page for
> 3rd-party git-<tool>s.
> 
> In other words, as soon as `git-sizer` is accompanied by `git-sizer.1` in
> one of the appropriate locations, it is set.

Yes, it would be nice if everything did ship with a manpage.
Unfortunately that complicates installation, where the installation for
many such tools is "save this file to your $PATH".

Tools like git-sizer may be getting big and popular enough to merit the
extra infrastructure, but I think there are many smaller scripts which
don't.

> FWIW I do have a couple of scripts I use that I install into
> `$HOME/bin/git-<tool>`. Although, granted, I essentially switched to
> aliases for most of them, where the aliases still call a script that is
> checked out in some folder in my home directory. The reason: this works in
> more circumstances, as I do not have to add `$HOME/bin` to the `PATH`,
> say, in PowerShell.
> 
> So YMMV with git-<tool>s. My rule of thumb is: if I want to use this
> myself only, I'll make it an alias. If I want to ship it (e.g. with Git
> for Windows), I'll make it a git-<tool>.

I have a handful of personal git-* scripts: mostly ones that are big
enough to be unwieldy as an alias. But then, $PATH management is pretty
straightforward on my platforms, so it's easier to drop a script there
than to point an alias to a non-git-* script.

-Peff
