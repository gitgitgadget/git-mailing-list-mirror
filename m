Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB98FC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD523610CF
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhDIW00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:26:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:47234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234602AbhDIW0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:26:25 -0400
Received: (qmail 3302 invoked by uid 109); 9 Apr 2021 22:26:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 22:26:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17381 invoked by uid 111); 9 Apr 2021 22:26:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 18:26:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 18:26:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [RFC/PATCH 0/2] here-doc test bodies
Message-ID: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been wanting to do this for years, but after getting bitten by a
misplaced quote the other day, I finally did. This series allows you to
do:

  test_expect_success <<\EOT
          something 'with single quotes'
  EOT

Thoughts?

The first patch is the implementation. The second one shows it off.

  [1/2]: test-lib: allow test snippets as here-docs
  [2/2]: t1404: convert to here-doc test bodies

 t/README                     |   8 +
 t/t1404-update-ref-errors.sh | 274 +++++++++++++++++------------------
 t/test-lib-functions.sh      |  30 +++-
 3 files changed, 171 insertions(+), 141 deletions(-)

-Peff
