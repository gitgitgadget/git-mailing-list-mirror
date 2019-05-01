Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3B11F453
	for <e@80x24.org>; Wed,  1 May 2019 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEAS4g (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:56:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:46156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726019AbfEAS4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:56:36 -0400
Received: (qmail 23802 invoked by uid 109); 1 May 2019 18:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:56:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21266 invoked by uid 111); 1 May 2019 18:57:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:57:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:56:34 -0400
Date:   Wed, 1 May 2019 14:56:34 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190501185633.GI4109@sigill.intra.peff.net>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501100108.GA8954@archbookpro.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 06:01:08AM -0400, Denton Liu wrote:

> > I guess we could also simply declare that *all* Coccinelle patches should
> > leave `compat/` alone, on the basis that those files are likely coming
> > from some sort of upstream. But then, `compat/mingw.c` and `compat/win32/`
> > seem not to fall into that category...
> 
> Deciding whether this is a good idea is above my paygrade ;)

FWIW, this seems like a good idea to me.

It's _possible_ there may be some cocci changes that we want to apply
even to compat/ (e.g., if we're mechanically fixing up a construct with
security implications). But whoever is doing that conversion should
probably apply that manually (and we don't typically change imported
stuff in the first place, so there's little need to subsequently run the
cocci patches).

> -- >8 --
> Subject: [PATCH] Makefile: filter out compat/ from coccicheck
> [...]

The patch itself looks OK to me.

-Peff
