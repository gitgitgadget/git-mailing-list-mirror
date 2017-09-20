Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4413520A29
	for <e@80x24.org>; Wed, 20 Sep 2017 18:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdITS51 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:57:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:44964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751361AbdITS51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:57:27 -0400
Received: (qmail 8146 invoked by uid 109); 20 Sep 2017 18:57:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 18:57:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15264 invoked by uid 111); 20 Sep 2017 18:58:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 14:58:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 14:57:25 -0400
Date:   Wed, 20 Sep 2017 14:57:25 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/21] Read `packed-refs` using mmap()
Message-ID: <20170920185724.ix7isdxfrsecxkjj@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 08:22:08AM +0200, Michael Haggerty wrote:

> This branch is also available from my fork on GitHub as branch
> `mmap-packed-refs`.
> 
> My main uncertainties are:
> 
> 1. Does this code actually work on Windows?
> 
> 2. Did I implement the new compile-time option correctly? (I just
>    cargo-culted some existing options.) Is there some existing option
>    that I could piggy-back off of instead of adding a new one?
> 
> 3. Is a compile-time option sufficient, or would the `mmap()` option
>    need to be configurable at runtime, or even tested at repository
>    create time as is done for some other filesystem properties in
>    `create_default_files()`?

I can't really answer (1) due to lack of knowledge. For (2), I think
it's mostly good, though I raised a small nit. For (3), I think this is
really an OS restriction and not a filesystem one, so probably
build-time is OK (though of course Windows people may be able to correct
me).

I left a few comments, but overall it looks quite good to me.

-Peff
