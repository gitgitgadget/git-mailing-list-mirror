Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D814DC77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFASC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFASCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 14:02:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7558123
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 11:02:21 -0700 (PDT)
Received: (qmail 6206 invoked by uid 109); 1 Jun 2023 18:02:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 18:02:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25499 invoked by uid 111); 1 Jun 2023 18:02:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 14:02:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 14:02:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] ci sanitizer cleanups and performance improvements
Message-ID: <20230601180220.GA4167745@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few patches to tweak our CI sanitizer setup. The first one
hopefully increases coverage. The other two just aim to reduce the
amount of CPU we use.

  [1/3]: ci: use clang for ASan/UBSan checks
  [2/3]: ci: run ASan/UBSan in a single job
  [3/3]: ci: drop linux-clang job

 .github/workflows/main.yml | 10 ++--------
 ci/lib.sh                  |  7 ++-----
 2 files changed, 4 insertions(+), 13 deletions(-)

-Peff
