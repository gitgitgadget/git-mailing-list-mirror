Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E97DC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 21:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiK3VG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 16:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiK3VGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 16:06:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B2862E5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 13:06:54 -0800 (PST)
Received: (qmail 19149 invoked by uid 109); 30 Nov 2022 21:06:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Nov 2022 21:06:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8329 invoked by uid 111); 30 Nov 2022 21:06:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Nov 2022 16:06:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Nov 2022 16:06:53 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] Don't lazy-fetch commits when parsing them
Message-ID: <Y4fF7e+PquFgq7VF@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 12:30:45PM -0800, Jonathan Tan wrote:

> This is a follow-up from my previous email about the possibility of not
> fetching when we know that we're fetching a commit [1]. I had to refactor a few
> things mostly due to replace objects, so the number of patches might be larger
> than you would expect. I tried to keep each patch small and easy to understand,
> though.
> 
> Patches 1-3 contain some forward-compatibility and refactoring changes, and
> patch 4 contains the actual logic change.

These look pretty good to me. I raised a minor nit in patch 2; if you
agree it should be a trivial re-roll.

I left some thoughts on the approach in patch 4, but I think given that
this is a strict improvement over the status quo, it's a good step
forward, even if it won't catch all such cases.

-Peff
