Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B216ACD37B5
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 07:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjIPH3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIPH3T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 03:29:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0069B5
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 00:29:13 -0700 (PDT)
Received: (qmail 4230 invoked by uid 109); 16 Sep 2023 07:29:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 07:29:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9781 invoked by uid 111); 16 Sep 2023 07:29:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 03:29:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 03:29:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] merge-ort: lowercase a few error messages
Message-ID: <20230916072909.GA992098@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
 <20230916060059.GA498798@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230916060059.GA498798@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2023 at 02:01:00AM -0400, Jeff King wrote:

> Here's one more clean-up on top. I hesitated on this for the initial
> send just because I didn't know if we might want to switch these error
> messages to path_msg(), which does capitalize sometimes. But Elijah's
> response convinced me that we should just leave them in place, in which
> case it makes sense to do a minimal style fixup.
> 
> Junio, this is on top of what you've queued in
> jk/ort-unused-parameter-cleanups.
> 
> -- >8 --
> Subject: [PATCH] merge-ort: lowercase a few error messages
> 
> As noted in CodingGuidelines, error messages should not be capitalized.
> Fix up a few of these that were copied verbatim from merge-recursive to
> match our modern style.

<sigh> This fails CI because with GIT_TEST_MERGE_ALGORITHM=recursive, we
run the old merge-recursive code, which uses the capitalized version.

I'm inclined to just drop this minor cleanup for now, and we can worry
about it later once merge-recursive goes the way of the dodo.

-Peff
