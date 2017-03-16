Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6144F20323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdCPTlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:41:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:45330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdCPTlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:41:18 -0400
Received: (qmail 25094 invoked by uid 109); 16 Mar 2017 19:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 19:41:14 +0000
Received: (qmail 31092 invoked by uid 111); 16 Mar 2017 19:41:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 15:41:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 15:41:10 -0400
Date:   Thu, 16 Mar 2017 15:41:10 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: USE_SHA1DC is broken in pu
Message-ID: <20170316194110.756ipu7xud2s3w2m@sigill.intra.peff.net>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 12:22:00PM -0700, Linus Torvalds wrote:

> I think there's a semantic merge error and it clashes with
> f18f816cb158 ("hash.h: move SHA-1 implementation selection into a
> header file").
> 
> Suggested possible merge resolution attached.

Yeah, your resolution makes sense.

Potentially we should just eject sha1dc from "pu" for the moment. It
needs re-rolled with the most recent version of the collision library
(and I see Marc just posted that they hit a stable point, which is
perhaps why you're looking at it).

I'd planned to work on that in the next few days, but if you want to do
so, be my guest.

-Peff
