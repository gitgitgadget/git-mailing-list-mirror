Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A0120248
	for <e@80x24.org>; Sat, 23 Feb 2019 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfBWNXm (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:23:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:55476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726269AbfBWNXm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:23:42 -0500
Received: (qmail 22531 invoked by uid 109); 23 Feb 2019 13:23:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Feb 2019 13:23:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4040 invoked by uid 111); 23 Feb 2019 13:23:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Feb 2019 08:23:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2019 08:23:40 -0500
Date:   Sat, 23 Feb 2019 08:23:40 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2 2/6] Makefile: move "strip" assignment down from flags
Message-ID: <20190223132340.GB22403@sigill.intra.peff.net>
References: <20190222105658.26831-1-avarab@gmail.com>
 <20190222144127.32248-3-avarab@gmail.com>
 <20190222151834.GA21524@sigill.intra.peff.net>
 <4821a31a-f5ee-39ef-5302-8b71430815fe@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4821a31a-f5ee-39ef-5302-8b71430815fe@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 09:58:14PM +0000, Ramsay Jones wrote:

> > This might annoy somebody expecting $STRIP in the environment to have
> > precedence. But I agree that consistency is probably our best strategy
> > here, and I don't see any reason the same argument would not apply to
> > $SPATCH, or $CC for that matter.
> > 
> > (So I could see an argument for moving them all to "?=", but that can
> > create its own confusion as environment variables accidentally start
> > taking effect).
> 
> $STRIP and $SPATCH will work OK, but you would be disappointed
> with $CC (or any other variable from make's built-in database). ;-)

Oof. That's confusing. All the more reason not to go in the direction of
"?=". Thanks for an interesting tidbit.

-Peff
