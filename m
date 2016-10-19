Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3009D20986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbcJSWhK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:37:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:59751 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbcJSWhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:37:09 -0400
Received: (qmail 24327 invoked by uid 109); 19 Oct 2016 22:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 22:37:09 +0000
Received: (qmail 18674 invoked by uid 111); 19 Oct 2016 22:37:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 18:37:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 18:37:06 -0400
Date:   Wed, 19 Oct 2016 18:37:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jan Keromnes <janx@linux.com>, git@vger.kernel.org
Subject: Re: [regression] `make profile-install` fails in 2.10.1
Message-ID: <20161019223706.re6a5m7n43vjfyzh@sigill.intra.peff.net>
References: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
 <20161019210519.ubk5q54rrvbafch7@sigill.intra.peff.net>
 <xmqqh988j7oo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh988j7oo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 03:27:35PM -0700, Junio C Hamano wrote:

> Ouch.  Thanks for a reminder.  How about doing this for now?
> [...]
>  test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
> +	rm -f foo3 xfoo3 &&
>  	echo foo >foo3 &&

Yeah, this makes sense. It does make me feel like the test should simply
be using xfoo27, or some name that is not otherwise used in the rest of
the script, but I don't mind doing the minimal thing.

-Peff
