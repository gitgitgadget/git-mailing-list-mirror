Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBBC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbdCXRWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:22:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51105 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdCXRWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:22:50 -0400
Received: (qmail 17394 invoked by uid 109); 24 Mar 2017 17:22:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 17:22:48 +0000
Received: (qmail 14379 invoked by uid 111); 24 Mar 2017 17:23:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 13:23:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 13:22:46 -0400
Date:   Fri, 24 Mar 2017 13:22:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] a few minor buffer cleanups in fast-import
Message-ID: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't think any of these is a triggerable bug. They're just cleanups
to make it more obvious that the code is doing the right thing (and
making it harder to do the wrong thing).

  [1/4]: fast-import: use xsnprintf for writing sha1s
  [2/4]: fast-import: use xsnprintf for formatting headers
  [3/4]: encode_in_pack_object_header: respect output buffer length
  [4/4]: pack.h: define largest possible encoded object size

 builtin/pack-objects.c | 12 ++++++++----
 bulk-checkin.c         |  2 +-
 fast-import.c          | 16 +++++++---------
 pack-write.c           |  5 ++++-
 pack.h                 |  9 ++++++++-
 5 files changed, 28 insertions(+), 16 deletions(-)

-Peff
