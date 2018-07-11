Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BFB1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbeGKOke (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 10:40:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388075AbeGKOke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 10:40:34 -0400
Received: (qmail 10825 invoked by uid 109); 11 Jul 2018 14:35:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 14:35:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7442 invoked by uid 111); 11 Jul 2018 14:35:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 10:35:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 10:35:54 -0400
Date:   Wed, 11 Jul 2018 10:35:54 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180711143554.GG23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
 <20180710170901.GH23624@sigill.intra.peff.net>
 <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
 <20180711125109.GC23835@sigill.intra.peff.net>
 <20180711154019.202e75c5@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711154019.202e75c5@md1pvb1c.ad001.siemens.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 03:40:19PM +0200, Henning Schild wrote:

> > So it may be simplest to just run most of the tests twice, once with
> > gpg and once with gpgsm. I kind of wonder if all of t7510 could just
> > be bumped into a function. Or even into a sourced file and run from
> > two different scripts. See the way that t8001 and t8002 use
> > annotate-tests.sh for an example.
> 
> I do not agree and would like to leave the tests as they are. Instead
> of introducing a whole lot of very similar copies, i added just a few.

I'm not sure I understand why you added the ones you did, though. For
instance, "--no-show-signature overrides --show-signature x509" seems
like it has nothing to do with the gpg/gpgsm distinction.

So I'd have expected that to be _outside_ of the shared battery of
tests.

> The original ones are even very similar between each other.
> We are again talking about two problems. 1. we need test cases for
> gpgsm if we want to merge gpgsm 2. the testsuite is very repetitive
> 
> While addressing 1 make 2 obvious and worse, addressing 2 is a whole
> different story and should probably be discussed outside of this
> thread. And i would not like to inherit responsibility for 2. In
> fact the whole discussion emphasizes that it was a good idea to make
> GPGSM depend on GPG, because it allows to somewhat reuse existing tests.

IMHO there is a big difference between inheriting responsibility for
something, and not making it worse. But I'm not all that interested in
fighting about it.

-Peff
