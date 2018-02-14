Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696EB1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030462AbeBNNzz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 08:55:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:52004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1030299AbeBNNzy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 08:55:54 -0500
Received: (qmail 16506 invoked by uid 109); 14 Feb 2018 13:55:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 13:55:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28759 invoked by uid 111); 14 Feb 2018 13:56:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 08:56:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 08:55:52 -0500
Date:   Wed, 14 Feb 2018 08:55:52 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Dominic =?utf-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: Regression in memory consumption of git fsck
Message-ID: <20180214135551.GA27513@sigill.intra.peff.net>
References: <b1a4d7ed-79b6-1f6b-1f0f-85536e943cef@gmx.de>
 <20180214124828.27845-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214124828.27845-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 01:48:28PM +0100, SZEDER Gábor wrote:

> > If I revert that commit (on top of current master) the memory
> > consumption goes down to 2GB again. The change looks relatively harmless
> > to me, so does anyone know what's going on here?
> 
> I could reproduce the increased memory usage even for much smaller
> repositories.  The patch below seems to fix it for me.
> 
> 
>  -- >8 --
> 
> Subject: [PATCH] fsck: plug tree buffer leak

I think this is fixed already in ba3a08ca0e (fsck: fix leak when
traversing trees, 2018-01-20), which is in 'next' (and marked for "will
merge to master in yesterday's "what's cooking").

-Peff
