Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B3F1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeDEWME (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:55108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752469AbeDEWME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:12:04 -0400
Received: (qmail 9081 invoked by uid 109); 5 Apr 2018 22:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 22:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19802 invoked by uid 111); 5 Apr 2018 22:13:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 18:13:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 18:12:02 -0400
Date:   Thu, 5 Apr 2018 18:12:02 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180405221201.GA29929@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
 <20180405020238.GD8879@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405020238.GD8879@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 07:02:38PM -0700, Taylor Blau wrote:

> +test_expect_success '--no-type unsets type specifiers' '
> +	echo "10" > expect &&
> +	git config --type=bool --no-type core.number >actual &&
> +	test_cmp expect actual
> +'

Actually, one minor nit (not worth a re-roll, but Junio may want to mark
it up): drop the space in "> expect".

-Peff
