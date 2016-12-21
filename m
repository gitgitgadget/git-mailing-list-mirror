Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E221FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 22:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762057AbcLUWnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 17:43:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:59472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762029AbcLUWm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 17:42:26 -0500
Received: (qmail 32187 invoked by uid 109); 21 Dec 2016 22:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 22:42:26 +0000
Received: (qmail 14655 invoked by uid 111); 21 Dec 2016 22:43:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 17:43:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2016 17:42:22 -0500
Date:   Wed, 21 Dec 2016 17:42:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/2] t5615-alternate-env: double-quotes in file names do
 not work on Windows
Message-ID: <20161221224222.6fn6irefmd6li6oa@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
 <00b6235d-c1bc-30c2-6539-6c78c4ce9eb0@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00b6235d-c1bc-30c2-6539-6c78c4ce9eb0@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 10:33:43PM +0100, Johannes Sixt wrote:

> Protect a recently added test case with !MINGW.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I don't remember why I did not notice this failure sooner.
>  Perhaps I did, but then ran out of time to debug it...
> 
>  The patch should go on top of jk/quote-env-path-list-component.
> [...]
> -test_expect_success 'broken quoting falls back to interpreting raw' '
> +test_expect_success !MINGW 'broken quoting falls back to interpreting raw' '
>  	mv one.git \"one.git &&
>  	check_obj \"one.git/objects <<-EOF
>  	$one blob

Hmph. I explicitly avoided a colon in the filename so that it would run
on MINGW. Is a double-quote also not allowed?

-Peff
