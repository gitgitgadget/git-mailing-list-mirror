Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEE1C77B7E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 11:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDVLOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLOf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 07:14:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32451703
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 04:14:34 -0700 (PDT)
Received: (qmail 10855 invoked by uid 109); 22 Apr 2023 11:14:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 11:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27663 invoked by uid 111); 22 Apr 2023 11:14:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 07:14:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 07:14:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] string-list: introduce `string_list_setlen()`
Message-ID: <20230422111433.GC2969939@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <2a20ad8bc5513aae912c53a294092ee5087e1873.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a20ad8bc5513aae912c53a294092ee5087e1873.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 03:18:46PM -0400, Taylor Blau wrote:

> This allows `string_list_split_in_place()` to overwrite any existing
> entries without needing to free and re-allocate them.
> 
> However, setting `list->nr` manually is not safe in all instances. There
> are a couple of cases worth worrying about:
> [...]

Thanks for adding this patch. Your explanation very nicely covers why
this is a reasonable pattern, and what pitfalls we're worried about by
doing it inline.

> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>

Acking my forged sign-off. :)

-Peff
