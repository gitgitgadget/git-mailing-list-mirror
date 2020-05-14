Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E118C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4932065D
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgENSM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:12:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:46684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726075AbgENSM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 14:12:27 -0400
Received: (qmail 16590 invoked by uid 109); 14 May 2020 18:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 May 2020 18:12:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3290 invoked by uid 111); 14 May 2020 18:12:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2020 14:12:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 May 2020 14:12:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 0/8] commit-graph: drop CHECK_OIDS, peel in callers
Message-ID: <20200514181226.GD2430834@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 03:59:25PM -0600, Taylor Blau wrote:

> Here is a tiny reroll to my series to drop the commit-graph's behavior
> of complaining about non-commit OIDs on input with '--stdin-commits'. I
> promised this reroll after Peff's review beginning in [1].
> 
> Not a great deal has changed, but I mostly took every suggestion that
> Peff put forward (in the sub-thread beginning at [1]). The "big deals"
> since last time are:

Thanks. With the exception of the decl-after-statement (and the tiny
if() nit which we could take or leave), this looks good to me.

The fix for the decl-after-statement should be easy, but you might want
to double check your build setup ("make DEVELOPER=1" does complain about
it, and I think that means our CI should, too; if it doesn't, we should
fix that).

-Peff
