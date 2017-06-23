Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863A020282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbdFWTtp (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:49:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:51092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754814AbdFWTto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:49:44 -0400
Received: (qmail 14108 invoked by uid 109); 23 Jun 2017 19:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:49:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18503 invoked by uid 111); 23 Jun 2017 19:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:49:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:49:42 -0400
Date:   Fri, 23 Jun 2017 15:49:42 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 26/29] clear_packed_ref_cache(): don't protest if the
 lock is held
Message-ID: <20170623194942.brzsuesttj4jqy2j@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <585946fc1191c540768206cdf59c0c6101583691.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <585946fc1191c540768206cdf59c0c6101583691.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:44AM +0200, Michael Haggerty wrote:

> The existing callers already check that the lock isn't held just
> before calling `clear_packed_ref_cache()`, and in the near future we
> want to be able to call this function when the lock is held.

OK. It's not immediately obvious that this is true, because some of the
relationships are a bit buried, but I double-checked and I think it is
the case.

-Peff
