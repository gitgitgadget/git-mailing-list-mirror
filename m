Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D19220C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbdLHKEP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:04:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:51926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753656AbdLHKCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 05:02:17 -0500
Received: (qmail 32225 invoked by uid 109); 8 Dec 2017 10:02:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 10:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30770 invoked by uid 111); 8 Dec 2017 10:02:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 05:02:38 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 05:02:15 -0500
Date:   Fri, 8 Dec 2017 05:02:15 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup.c: fix comment about order of .git directory
 discovery
Message-ID: <20171208100214.GB1899@sigill.intra.peff.net>
References: <20171207085949.19519-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171207085949.19519-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 09:59:49AM +0100, SZEDER Gábor wrote:

> Since gitfiles were introduced in b44ebb19e (Add platform-independent
> .git "symlink", 2008-02-20) the order of checks during .git directory
> discovery is: gitfile, gitdir, bare repo.  However, that commit did
> only partially update the in-code comment describing this order,
> missing the last line which still puts gitdir before gitfile.

I was confused at first, because your patch only changes to ".git/" to
".git". So there is no ordering change, only a swapping out of one for
the other. But that pushes done the ".git/" into the "etc." which is
below.

So I think this makes sense.

Thanks.

-Peff
