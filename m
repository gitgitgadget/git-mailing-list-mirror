Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BABB1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKKJDe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:03:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:44336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726768AbfKKJDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:03:34 -0500
Received: (qmail 18232 invoked by uid 109); 11 Nov 2019 09:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 09:03:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4172 invoked by uid 111); 11 Nov 2019 09:07:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 04:07:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 04:03:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] getting rid of sha1_to_hex()
Message-ID: <20191111090332.GA2275@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I happened to be looking at the oid_to_hex() family of functions today,
and noticed that we can drop some of the sha1-specific ones.

It's a minor cleanup in terms of text, but it feels like a nice
milestone. :)

  [1/2]: hex: drop sha1_to_hex_r()
  [2/2]: hex: drop sha1_to_hex()

 cache.h                            |  4 +---
 contrib/coccinelle/object_id.cocci | 32 ------------------------------
 hex.c                              | 10 ----------
 sha1dc_git.c                       |  2 +-
 4 files changed, 2 insertions(+), 46 deletions(-)

-Peff
