Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757EE20372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbdJLUig (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:38:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752767AbdJLUif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:38:35 -0400
Received: (qmail 1796 invoked by uid 109); 12 Oct 2017 20:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 20:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19924 invoked by uid 111); 12 Oct 2017 20:38:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 16:38:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 16:38:32 -0400
Date:   Thu, 12 Oct 2017 16:38:32 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: undefined reference to `pcre_jit_exec'
Message-ID: <20171012203832.ui52j7cdrztc6vhs@sigill.intra.peff.net>
References: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com>
 <20171012201023.wrfbs7p7lups5glz@sigill.intra.peff.net>
 <CAH8yC8nHpdA+fX3pcaLRzEYwTCmoxF3NKSh6SUkORZuEvg0JGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH8yC8nHpdA+fX3pcaLRzEYwTCmoxF3NKSh6SUkORZuEvg0JGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 04:34:38PM -0400, Jeffrey Walton wrote:

> > It looks like autoconf turns on USE_LIBPCRE1, but isn't smart enough to
> > test NO_LIBPCRE1_JIT.
> 
> If Git wants Jit, then I am inclined to configure PCRE to provide it.

It does make things faster. OTOH, we lived for many years without it, so
certainly it's not the end of the world to build without it.

There are some numbers in the commit message of fbaceaac47 (grep: add
support for the PCRE v1 JIT API, 2017-05-25).

> A quick question if you happen to know... Does PCRE Jit cause a loss
> of NX-stacks? If it causes a loss of NX-stacks, then I think I prefer
> to disable it.

I don't know. Ævar (cc'd) might.

-Peff
