Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B247E1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1Pjp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:39:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726400AbfH1Pjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:39:45 -0400
Received: (qmail 13995 invoked by uid 109); 28 Aug 2019 15:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Aug 2019 15:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12105 invoked by uid 111); 28 Aug 2019 15:41:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2019 11:41:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Aug 2019 11:39:44 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190828153944.GA29715@sigill.intra.peff.net>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828145412.GB14432@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 10:54:12AM -0400, Jeff King wrote:

> > Unfortunately, however, while running './t5516-fetch-push.sh -r 1,79
> > --stress' to try to reproduce a failure caused by those mingled
> > messages, the same check only failed for a different reason so far
> > (both on Linux and macOS (on Travis CI)):
> 
> There's some hand-waving argument that this should be race-free in
> 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> 2019-04-13), but I am not too surprised if there is a flaw in that
> logic.

By the way, I've not been able to reproduce this locally after ~10
minutes of running "./t5516-fetch-push.sh -r 1,79 --stress" on my Linux
box. I wonder what's different.

Are you running the tip of master?

-Peff
