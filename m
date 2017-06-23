Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879FD20282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754934AbdFWTkK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:40:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754885AbdFWTkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:40:09 -0400
Received: (qmail 13332 invoked by uid 109); 23 Jun 2017 19:40:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:40:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18333 invoked by uid 111); 23 Jun 2017 19:40:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:40:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:40:07 -0400
Date:   Fri, 23 Jun 2017 15:40:07 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 20/29] packed_ref_store: make class into a subclass of
 `ref_store`
Message-ID: <20170623194006.6qrg6obxgbbmhwd3@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <041f714d6ab872c113cde7a9c97eae03a06ae04d.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <041f714d6ab872c113cde7a9c97eae03a06ae04d.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:38AM +0200, Michael Haggerty wrote:

> Add the infrastructure to make `packed_ref_store` implement
> `ref_store`, at least formally (few of the methods are actually
> implemented yet). Change the functions in its interface to take
> `ref_store *` arguments. Change `files_ref_store` to store a pointer
> to `ref_store *` and to call functions via the virtual `ref_store`
> interface where possible. This also means that a few
> `packed_ref_store` functions can become static.

By itself this looks correct (as do the patches leading up to it). But I
think some of the "big picture" is lost. Why do we want it to look like
a ref store?

I suspect the answer is too big to go into this individual commit
message. But I went back and re-read the cover letter, and I don't think
it's really explained there, either.

So I'm not really sure where it ought to be covered (or if I simply
missed it somewhere, or if it's coming up; I'm reading the patches
linearly).

-Peff
