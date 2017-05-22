Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B97520282
	for <e@80x24.org>; Mon, 22 May 2017 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbdEVLTY (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:19:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:55825 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbdEVLTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:19:23 -0400
Received: (qmail 18298 invoked by uid 109); 22 May 2017 11:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 11:19:22 +0000
Received: (qmail 18114 invoked by uid 111); 22 May 2017 11:19:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 07:19:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 May 2017 07:19:21 -0400
Date:   Mon, 22 May 2017 07:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
Message-ID: <20170522111920.244yup7wol55mtdm@sigill.intra.peff.net>
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 11:25:39PM +0100, Ramsay Jones wrote:

> Commit d8193743e0 ("usage.c: add BUG() function", 12-05-2017) added the
> BUG() functions and macros as a replacement for calls to die("BUG: ..").
> The use of NORETURN on the declarations (in git-compat-util.h) and the
> lack of NORETURN on the function definitions, however, leads sparse to
> complain thus:
> 
>       SP usage.c
>   usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type
>   (originally declared at git-compat-util.h:1074) - different modifiers
> 
> In order to suppress the sparse error, add the NORETURN to the function
> definitions.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Thanks, I never ended up re-rolling the original, but from our previous
discussion this is obviously fine by me.

-Peff
