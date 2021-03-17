Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE0C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC8C61584
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhCQTWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:22:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233132AbhCQTVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:21:53 -0400
Received: (qmail 26799 invoked by uid 109); 17 Mar 2021 19:21:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 19:21:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12083 invoked by uid 111); 17 Mar 2021 19:21:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 15:21:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 15:21:51 -0400
From:   Jeff King <peff@peff.net>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH] fetch: show progress for packfile uri downloads
Message-ID: <YFJWz5yIGng+a16k@coredump.intra.peff.net>
References: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 07:03:13PM +0000, Albert Cui via GitGitGadget wrote:

> From: Albert Cui <albertqcui@gmail.com>
> 
> Git appears to hang when downloading packfiles as this part of the
> fetch is silent, causing user confusion. This change implements
> progress for the number of packfiles downloaded; a progress display
> for bytes would involve deeper changes at the http-fetch layer
> instead of fetch-pack, the caller.

I think this is an improvement, but I agree that a real byte display
would be much better. I actually worked on this a long time ago for a
very similar feature that we never quite pushed over the finish line.
See patches 11 and 12 here:

  https://lore.kernel.org/git/20111110074330.GA27925@sigill.intra.peff.net/

(it might need some of the earlier refactoring, too, I'm not sure; and
quite likely will need forward-porting as it has been 10 years).

-Peff
