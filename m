Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5B31F404
	for <e@80x24.org>; Mon, 12 Feb 2018 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeBLPPD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 10:15:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:49136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752529AbeBLPPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 10:15:02 -0500
Received: (qmail 18493 invoked by uid 109); 12 Feb 2018 15:15:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Feb 2018 15:15:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8343 invoked by uid 111); 12 Feb 2018 15:15:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Feb 2018 10:15:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2018 10:15:00 -0500
Date:   Mon, 12 Feb 2018 10:15:00 -0500
From:   Jeff King <peff@peff.net>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        martin.agren@gmail.com, bmwill@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Xin Jiang <worldhello.net@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>, pclouds@gmail.com
Subject: Re: [PATCH 1/1] Mark messages for translations
Message-ID: <20180212151500.GA21208@sigill.intra.peff.net>
References: <20180209074404.2902-1-ash@kambanaria.org>
 <20180206073812.GA14133@sigill.intra.peff.net>
 <20180209074404.2902-2-ash@kambanaria.org>
 <xmqqlgg2xbx0.fsf@gitster-ct.c.googlers.com>
 <xmqqwozmvuth.fsf@gitster-ct.c.googlers.com>
 <20180209193039.GA15554@sigill.intra.peff.net>
 <CAP6f5MnjhyP+Ty4zqS3sP2mgYfK3RiKm3=YpFE3LABxx7nUBkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP6f5MnjhyP+Ty4zqS3sP2mgYfK3RiKm3=YpFE3LABxx7nUBkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 04:03:49PM +0100, Alexander Shopov wrote:

> @Jeff:
> > we may want to avoid this anti-pattern
> Current state of these tests is wrong and I should rework them.
> 
> Here is what I intend to do:
> 1. Fix the commit message
> 2. Check whether I can get the tests in t0002-gitfile.sh to the
> standard `test_i18ngrep !` negative (i.e. without using `if`)
> 3. Post and ask for feedback again

See the patch I posted earlier. For (2), "test_i18ngrep !" would be the
wrong thing. I think you should either:

  - keep your patch as-is, and let Junio resolve the conflict when the
    two are merged

  - rebase your patch on top of mine. That's slightly less work for
    Junio, but it means that your topic cannot graduate until mine does
    (though hopefully mine is pretty non-controversial).

I'd probably just do the first in your place, since the conflict is easy
to resolve.

-Peff
