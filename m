Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D04202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 08:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbdCJIcn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 03:32:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:41867 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755228AbdCJIcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 03:32:42 -0500
Received: (qmail 14366 invoked by uid 109); 10 Mar 2017 08:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 08:32:41 +0000
Received: (qmail 7768 invoked by uid 111); 10 Mar 2017 08:32:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 03:32:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 03:32:39 -0500
Date:   Fri, 10 Mar 2017 03:32:39 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: move blame_entry duplication to add_blame_entry()
Message-ID: <20170310083238.hjfnkmcgufi3oehq@sigill.intra.peff.net>
References: <11b8ad3a-cd3d-2fd6-4b06-b442099c2709@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11b8ad3a-cd3d-2fd6-4b06-b442099c2709@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 01:12:59AM +0100, René Scharfe wrote:

> All callers of add_blame_entry() allocate and copy the second argument.
> Let the function do it for them, reducing code duplication.

I assume you found this due to the DUPLICATE() discussion elsewhere.
Regardless of the results of that discussion, I think this is a nice
simplification.

-Peff
