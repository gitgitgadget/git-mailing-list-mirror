Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51F81F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeJaNTl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:19:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:33738 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728663AbeJaNTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:19:40 -0400
Received: (qmail 7417 invoked by uid 109); 31 Oct 2018 04:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 04:23:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7037 invoked by uid 111); 31 Oct 2018 04:22:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 00:22:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 00:23:18 -0400
Date:   Wed, 31 Oct 2018 00:23:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jon Simons <jon@jonsimons.org>
Subject: [PATCH 0/2] ls-remote and v2 ref prefixes
Message-ID: <20181031042318.GA5347@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a bug where ls-remote sends a ref-advertisement prefix
when it shouldn't, and then optimizes a spot where it doesn't send one
but could.

  [1/2]: ls-remote: do not send ref prefixes for patterns
  [2/2]: ls-remote: pass heads/tags prefixes to transport

 builtin/ls-remote.c  | 13 +++++--------
 t/t5512-ls-remote.sh | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

-Peff
