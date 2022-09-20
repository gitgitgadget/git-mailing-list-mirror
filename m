Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABAAC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiITTvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:51:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748E6F557
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:51:15 -0700 (PDT)
Received: (qmail 30896 invoked by uid 109); 20 Sep 2022 19:51:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 19:51:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14353 invoked by uid 111); 20 Sep 2022 19:51:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 15:51:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 15:51:14 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t/Makefile: remove 'test-results' on 'make clean'
Message-ID: <YyoZsjf3FSxLuuKY@coredump.intra.peff.net>
References: <patch-v3-07.15-c7ea6dc013b-20220727T230800Z-avarab@gmail.com>
 <20220920105407.4700-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920105407.4700-1-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 12:54:07PM +0200, SZEDER Gábor wrote:

> The 't/test-results' directory and its contents are by-products of the
> test process, so 'make clean' should remove them, but, alas, this has
> been broken since ee65b194d (t/Makefile: don't remove test-results in
> "clean-except-prove-cache", 2022-07-28).

I don't have that commit. I assume you mean fee65b194d, and what you
have here was a version before it hit 'next'.

> Add that missing cleanup command to 't/Makefile', and all sub-Makefiles
> touched by ee65b194d as well.

Ditto here.

>  contrib/scalar/t/Makefile  | 1 +
>  contrib/subtree/t/Makefile | 1 +
>  t/Makefile                 | 1 +

That patch itself looks sensible to me.

-Peff
