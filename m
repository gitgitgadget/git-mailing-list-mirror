Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C048EC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9C60F8F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhHIWqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:46:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:42846 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235844AbhHIWqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:46:06 -0400
Received: (qmail 3801 invoked by uid 109); 9 Aug 2021 22:45:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 22:45:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2919 invoked by uid 111); 9 Aug 2021 22:45:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 18:45:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 18:45:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] some small range-diff read_patches() fixes
Message-ID: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amidst all the talk of clang4 in another thread, I noticed that Debian
unstable recently shipped a clang-14 package. So I tried it out, and it
does find one small cleanup. And then looking at the surrounding code
helped me find 2 more. :)

  [1/3]: range-diff: drop useless "offset" variable from read_patches()
  [2/3]: range-diff: handle unterminated lines in read_patches()
  [3/3]: range-diff: use ssize_t for parsed "len" in read_patches()

 range-diff.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

-Peff
