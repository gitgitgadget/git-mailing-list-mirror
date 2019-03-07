Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A7920248
	for <e@80x24.org>; Thu,  7 Mar 2019 02:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCGC5H (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 21:57:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:41816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726597AbfCGC5H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 21:57:07 -0500
Received: (qmail 9386 invoked by uid 109); 7 Mar 2019 02:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 02:57:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19701 invoked by uid 111); 7 Mar 2019 02:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 21:57:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 21:57:03 -0500
Date:   Wed, 6 Mar 2019 21:57:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <20190307025703.GA25656@sigill.intra.peff.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
 <20190303174214.GF23811@sigill.intra.peff.net>
 <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
 <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
 <20190305042050.GE19800@sigill.intra.peff.net>
 <xmqqbm2no6by.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm2no6by.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 07, 2019 at 09:50:57AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Mostly I was just surprised by the new behavior. Perhaps the right
> > solution is not a patch to the code, but to the documentation. Something
> > like:
> 
> Let me forge your sign-off and commit this to prevent us from
> forgetting.
> 
> Thanks, all.

Thanks for tying this up. One minor nit:

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 1bfe9f56a7..611a32445c 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -240,7 +240,9 @@ Valid `<type>`'s include:
>  	output.  The optional `default` parameter is used instead, if
>  	there is no color configured for `name`.
>  +
> -`--type=color [--default=<default>]` is preferred over `--get-color`.
> +`--type=color [--default=<default>]` is preferred over `--get-color`
> +(but note that `--get-color` will omit the trailing newline printed by
> +--type=color).

That final line probably should have literal quotes, like:

  `--type=color`).

-Peff
