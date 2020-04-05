Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC818C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B485220659
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDESoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 14:44:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:33778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726771AbgDESoo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 14:44:44 -0400
Received: (qmail 16008 invoked by uid 109); 5 Apr 2020 18:44:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 05 Apr 2020 18:44:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5209 invoked by uid 111); 5 Apr 2020 18:55:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Apr 2020 14:55:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 5 Apr 2020 14:44:41 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: avoid running curl-config unnecessarily
Message-ID: <20200405184441.GA1309425@coredump.intra.peff.net>
References: <20200326080540.GA2200522@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet>
 <20200404145829.GB679473@coredump.intra.peff.net>
 <CAPig+cR_ViZ2GWSs=grT=5bzQq44w+AAbXFsZaM_-CVMCELXQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cR_ViZ2GWSs=grT=5bzQq44w+AAbXFsZaM_-CVMCELXQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 04, 2020 at 09:33:51PM -0400, Eric Sunshine wrote:

> On Sat, Apr 4, 2020 at 10:58 AM Jeff King <peff@peff.net> wrote:
> > This is our first use of eval in the Makefile, but that goes back to GNU
> > make v3.80, which is from 2002. I think that should be OK.
> 
> Upon reading this, I was worried that it might trip up Mac OS which
> has (often very) old versions of tools, but it's alright in this case,
> as Apple ships GNU 'make' 3.81 from 2006.

They're certainly good at keeping old versions of things around. :) I
wonder if it's due to a switch from GPLv2 to v3. My understanding is
that's why they'll keep bash 3 around forever, and the GPLv3 was
published in 2007, between GNU make 3.81 and 3.82.

Anyway, I think we're good, but thanks for double-checking.

-Peff
