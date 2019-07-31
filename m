Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643F21F731
	for <e@80x24.org>; Wed, 31 Jul 2019 05:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfGaF6e (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 01:58:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:56590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726514AbfGaF6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 01:58:34 -0400
Received: (qmail 11820 invoked by uid 109); 31 Jul 2019 05:58:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 05:58:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14161 invoked by uid 111); 31 Jul 2019 06:00:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 02:00:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 01:58:33 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
Subject: Re: `@` alias for `HEAD` not working in `git push -u origin @`
Message-ID: <20190731055832.GA18039@sigill.intra.peff.net>
References: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com>
 <20190710233937.GG9224@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190710233937.GG9224@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 10, 2019 at 11:39:37PM +0000, brian m. carlson wrote:

> This is a bug. If the destination side of a refspec is omitted, and the
> source side resolves to a ref starting with "refs/heads/" or
> "refs/tags/" (which I expect it does here), then that ref is used as the
> destination.
> 
> I submitted a patch at [0], but it was decided not to pick it up. If
> Junio and the list decide that it's wanted, I'm happy to resend or
> revise and resend.
> 
> [0] https://public-inbox.org/git/20180729192803.1047050-1-sandals@crustytoothpaste.net/

I see I was cc'd on that original, but I don't remember ever reading it.
It seems like a sane enough idea to me.

Although I did notice that you mentioned there:

> I probably type "git push upstream HEAD" from five to thirty times a
> day

I find I do that rarely, because I have:

  [push]
  default = current

and in a triangular workflow, I have:

  [remote]
  pushDefault = upstream

So "git push" without arguments typically does the same thing for me.

Not an argument against your patch, but just something you might find
useful.

-Peff
