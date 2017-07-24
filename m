Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021DC203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 18:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbdGXSF4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 14:05:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:47308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754127AbdGXSFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 14:05:32 -0400
Received: (qmail 8693 invoked by uid 109); 24 Jul 2017 18:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 18:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11584 invoked by uid 111); 24 Jul 2017 18:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 14:05:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 14:05:30 -0400
Date:   Mon, 24 Jul 2017 14:05:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] objects: scope count variable to loop
Message-ID: <20170724180530.smcjifvwytc5wcwa@sigill.intra.peff.net>
References: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com>
 <20170719181956.15845-1-sbeller@google.com>
 <20170719182342.GA158344@google.com>
 <20170724170813.scceigybl5d3fvdd@sigill.intra.peff.net>
 <CAGZ79kZafHBJOVwZzw_ii3T6_X24Uci4vUudp45r8-GTn0a4Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZafHBJOVwZzw_ii3T6_X24Uci4vUudp45r8-GTn0a4Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 10:12:59AM -0700, Stefan Beller wrote:

> > Interestingly I have no problems compiling it here. I wonder if Stefan's
> > config.mak is supplying -std=c89 or some other restrictive flag. Or if
> > his compiler is a different version (though I tried with gcc-6, gcc-4.9,
> > and clang-3.8).
> 
> Before this patch, I only had
>   CFLAGS += -g -O0
> in config.mak (as I switched working directories recently), I'll throw in
>   DEVELOPER=1
> 
> My compiler version is ancient (gcc 4.8.4-2ubuntu1~14.04.3)
> apparently (why did I never check in this environment?)

Ah, indeed, it's the compiler version. And I actually screwed up my
gcc-4.9 test. It complains, too. It looks like the default for gcc
bumped from gnu90 to gnu11 in gcc 5.

-Peff
