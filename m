Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC7A20282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbdFWTvs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:51:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754814AbdFWTvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:51:47 -0400
Received: (qmail 14288 invoked by uid 109); 23 Jun 2017 19:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18582 invoked by uid 111); 23 Jun 2017 19:51:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:51:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:51:45 -0400
Date:   Fri, 23 Jun 2017 15:51:45 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 27/29] commit_packed_refs(): remove call to
 `packed_refs_unlock()`
Message-ID: <20170623195144.jsha7bdm4r2d6rrg@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <35e859b7a4776bf5818cfbf12016c61fa2be04b8.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35e859b7a4776bf5818cfbf12016c61fa2be04b8.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:45AM +0200, Michael Haggerty wrote:

> Instead, change the callers of `commit_packed_refs()` to call
> `packed_refs_unlock()`.

Why? I can guess that the reason is probably "because we're going to add
a new caller that doesn't want to do that", but it's nice to hear even
that. Those kinds of clues help make a more coherent narrative when
you're reading through 29 refactoring patches. ;)

-Peff
