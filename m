Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7F620248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfCUJ2b (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:28:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727903AbfCUJ2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:28:31 -0400
Received: (qmail 10265 invoked by uid 109); 21 Mar 2019 09:28:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 09:28:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8254 invoked by uid 111); 21 Mar 2019 09:28:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 05:28:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 05:28:29 -0400
Date:   Thu, 21 Mar 2019 05:28:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] refs/files-backend: fix two subtle error-handling bugs
Message-ID: <20190321092829.GA2648@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes two bugs around the error-handling of writing
packed-refs during ref deletion. The first one came from a real-world
case.  The second is impossible to trigger (currently), but since I
noticed it while hunting the first one, I figured it was worth fixing.

  [1/2]: refs/files-backend: handle packed transaction prepare failure
  [2/2]: refs/files-backend: don't look at an aborted transaction

 refs/files-backend.c         | 16 +++++++++++++++-
 t/t1404-update-ref-errors.sh | 16 ++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-Peff
