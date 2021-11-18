Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B025C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D43161361
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhKRPpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:45:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:33890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhKRPpy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 10:45:54 -0500
Received: (qmail 30201 invoked by uid 109); 18 Nov 2021 15:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Nov 2021 15:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30271 invoked by uid 111); 18 Nov 2021 15:42:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Nov 2021 10:42:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Nov 2021 10:42:51 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Message-ID: <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
 <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
 <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 04:35:48PM +0100, Johannes Schindelin wrote:

> I think the really important thing to point out is that
> `xdl_classify_record()` ensures that the `ha` attribute is different for
> different text. AFAIR it even "linearizes" the `ha` values, i.e. they
> won't be all over the place but start at 0 (or 1).
> 
> So no, I'm not worried about collisions. That would be a bug in
> `xdl_classify_record()` and I think we would have caught this bug by now.

Ah, thanks for that explanation. That addresses my collision concern from
earlier in the thread completely.

-Peff
