Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42C01F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbcHXSHf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:07:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754965AbcHXSHd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:07:33 -0400
Received: (qmail 14984 invoked by uid 109); 24 Aug 2016 18:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 18:07:33 +0000
Received: (qmail 5312 invoked by uid 111); 24 Aug 2016 18:07:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 14:07:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 14:07:30 -0400
Date:   Wed, 24 Aug 2016 14:07:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing
 refs
Message-ID: <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
References: <20160822173528.755-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160822173528.755-1-oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 07:35:28PM +0200, Øystein Walle wrote:

> git branch -vv will show "gone" next to a remote tracking branch if it
> does not exist. for-each-ref is suitable for parsing but had no way of
> showing this information.
> 
> This introduces "%(upstream:gone)" to display "gone" in the formatted
> output if the ref does not exist or an empty string otherwise, analogous
> to git branch -vv.
> 
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> I took the liberty of sending in a v2 on my own. Removed the last argument to
> stat_tracking_info() and used test_config instead of test_when_finished.

Whoops, your v2 spurred me to review, but I accidentally read and
responded to v1.

I think test_config may not be the right thing here, though; see my
other comments.

-Peff
