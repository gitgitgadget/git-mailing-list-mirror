Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A741F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161588AbeBNSDZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:03:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:52252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161541AbeBNSDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:03:24 -0500
Received: (qmail 29072 invoked by uid 109); 14 Feb 2018 18:03:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:03:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30938 invoked by uid 111); 14 Feb 2018 18:04:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:04:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:03:22 -0500
Date:   Wed, 14 Feb 2018 13:03:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] minor test-hashmap fixes
Message-ID: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series started with me fixing the sizeof() mismatch discussed in

  https://public-inbox.org/git/20180214164628.GA907@sigill.intra.peff.net/

but I found a number of minor irritations. Most of them are cosmetic in
practice, but I think it's important for test-helper code like this to
model best practices, since people are likely to use it as a reference.

  [1/6]: test-hashmap: use ALLOC_ARRAY rather than bare malloc
  [2/6]: test-hashmap: check allocation computation for overflow
  [3/6]: test-hashmap: use xsnprintf rather than snprintf
  [4/6]: test-hashmap: use strbuf_getline rather than fgets
  [5/6]: test-hashmap: simplify alloc_test_entry
  [6/6]: test-hashmap: use "unsigned int" for hash storage

 t/helper/test-hashmap.c | 53 +++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

-Peff
