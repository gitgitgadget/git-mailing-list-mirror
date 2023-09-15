Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31847EE6457
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjIOLco (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjIOLcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 07:32:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A851AB
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 04:32:38 -0700 (PDT)
Received: (qmail 10747 invoked by uid 109); 15 Sep 2023 11:32:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Sep 2023 11:32:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1483 invoked by uid 111); 15 Sep 2023 11:32:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Sep 2023 07:32:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Sep 2023 07:32:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] updating curl http/2 header matching (again)
Message-ID: <20230915113237.GA3531328@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to the issue discussed/fixed a few months ago in:

  https://lore.kernel.org/git/20230617051559.GD562686@coredump.intra.peff.net/

but it looks like curl has updated the trace line format again. This
updates our matching code to handle it. It would obviously be nice to
avoid the dependency altogether, but I don't think there is another
option here. I expected the previous update to last longer than it did,
but hopefully things will settle a bit more now. :)

(If anyone wants to confirm the bug or test, the new version of curl
just hit debian unstable).

  [1/2]: http: factor out matching of curl http/2 trace lines
  [2/2]: http: update curl http/2 info matching for curl 8.3.0

 http.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

-Peff
