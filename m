Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4AFC46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjAGNYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjAGNYT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:24:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E957926
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:24:18 -0800 (PST)
Received: (qmail 23411 invoked by uid 109); 7 Jan 2023 13:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23583 invoked by uid 111); 7 Jan 2023 13:24:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:24:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:24:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] some minor starts_with()/skip_prefix() cleanups
Message-ID: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I happened to notice a recently-introduced strncmp() that could have
been a starts_with(). So I grepped and found a few more, and this is the
result.

  [1/2]: convert trivial uses of strncmp() to starts_with()
  [2/2]: convert trivial uses of strncmp() to skip_prefix()

 builtin/remote-ext.c | 6 ++++--
 builtin/remote-fd.c  | 2 +-
 bundle-uri.c         | 2 +-
 ref-filter.c         | 2 +-
 urlmatch.c           | 6 +++---
 ws.c                 | 7 ++++---
 6 files changed, 14 insertions(+), 11 deletions(-)

-Peff
