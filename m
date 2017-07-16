Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADCF2027C
	for <e@80x24.org>; Sun, 16 Jul 2017 16:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdGPQDQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 12:03:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:42162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751216AbdGPQDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 12:03:16 -0400
Received: (qmail 10524 invoked by uid 109); 16 Jul 2017 16:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 16:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26214 invoked by uid 111); 16 Jul 2017 16:03:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 12:03:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 12:03:13 -0400
Date:   Sun, 16 Jul 2017 12:03:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] dir: support platforms that require aligned reads
Message-ID: <20170716160313.2crnw6exyqpvp7ue@sigill.intra.peff.net>
References: <d3db2984-f238-7166-affa-f1f7df566404@web.de>
 <20170716140409.3ywepgvo5c6ognsy@sigill.intra.peff.net>
 <84b4d5aa-956f-932b-4e95-f181243215bc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84b4d5aa-956f-932b-4e95-f181243215bc@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 05:18:27PM +0200, René Scharfe wrote:

> > it looks like assumptions about struct layout are pervasive and part of
> > the on-disk format. Yuck. :(
> 
> Assuming that there is no padding probably even works for the platforms
> the code currently supports (basically x86), but I don't know about
> others.  We'd need to change the writing side as well to match, though.
> Which is probably a good idea, but I tried to keep the patch small and
> its impact low.  Cross-machine usability is currently explicitly not
> supported -- not sure why, though.

Yeah, I think your patch is a good first step, and we don't have to go
further for now.

-Peff
