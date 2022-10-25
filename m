Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F481C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJYBDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJYBCu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7707B7A0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 17:00:20 -0700 (PDT)
Received: (qmail 4621 invoked by uid 109); 25 Oct 2022 00:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Oct 2022 00:00:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12647 invoked by uid 111); 25 Oct 2022 00:00:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 20:00:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 20:00:19 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised
 attributes
Message-ID: <Y1cnE5cyN1NBdmCv@coredump.intra.peff.net>
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
 <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 07:59:22PM -0400, Jeff King wrote:

> We did discuss patches a long time ago that would let Git carry
> arbitrary keys between helpers, even if Git itself didn't understand it.
> One of the intended uses was to let helpers talk to each other about
> TTLs. So if you had say:
> 
>   [credential]
>   helper = generate-some-token
>   helper = cache
> 
> where the first helper generates a token, and the second caches it, the
> first one could shove a "ttl" or "expiration" key into the protocol,
> which the cache could then learn to respect.

In case anyone is morbidly curious, it was in this thread:

  https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.net/

-Peff
