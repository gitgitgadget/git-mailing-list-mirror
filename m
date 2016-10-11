Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A2E1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbcJKTCw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:02:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:55970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbcJKTBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:01:31 -0400
Received: (qmail 31246 invoked by uid 109); 11 Oct 2016 18:34:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 18:34:50 +0000
Received: (qmail 11477 invoked by uid 111); 11 Oct 2016 18:35:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 14:35:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 14:34:49 -0400
Date:   Tue, 11 Oct 2016 14:34:49 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Support `git reset --stdin`
Message-ID: <20161011183448.yasglfjelo4kgrq4@sigill.intra.peff.net>
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1476202100.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 06:08:56PM +0200, Johannes Schindelin wrote:

> This feature was missing, and made it cumbersome for third-party
> tools to reset a lot of paths in one go.
> 
> Support for --stdin has been added, following builtin/checkout-index.c's
> example.

Is git-reset the right layer to add scripting features? I thought we
usually pushed people doing mass index manipulation to use update-index
or read-tree. Is there something that reset makes easy that is hard with
those tools (I could imagine "--hard", but I see it is not supported
with your patch).

Not that I'm necessarily opposed to the patch, I was just surprised.

-Peff
