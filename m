Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D945A20401
	for <e@80x24.org>; Wed, 21 Jun 2017 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdFUNvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 09:51:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751042AbdFUNvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 09:51:32 -0400
Received: (qmail 20706 invoked by uid 109); 21 Jun 2017 13:51:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 13:51:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22618 invoked by uid 111); 21 Jun 2017 13:51:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 09:51:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 09:51:30 -0400
Date:   Wed, 21 Jun 2017 09:51:30 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs: update 64-bit core.packedGitLimit default
Message-ID: <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com>
 <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 05:02:55PM -0400, Jeff King wrote:

> >  git-compat-util.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This probably needs an update to the core.packedGitLimit section of
> Documentation/config.txt.

Looks like we never did that part. Here it is (Junio, this goes on top
of dt/raise-core-packed-git-limit).

-- >8 --
Subject: [PATCH] docs: update 64-bit core.packedGitLimit default

We bumped the default in be4ca2905 (Increase
core.packedGitLimit, 2017-04-20) but never adjusted the
documentation to match.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6278a5ae..fc2cf1fe1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -683,7 +683,8 @@ core.packedGitLimit::
 	bytes at once to complete an operation it will unmap existing
 	regions to reclaim virtual address space within the process.
 +
-Default is 256 MiB on 32 bit platforms and 8 GiB on 64 bit platforms.
+Default is 256 MiB on 32 bit platforms and 32 TiB (effectively
+unlimited) on 64 bit platforms.
 This should be reasonable for all users/operating systems, except on
 the largest projects.  You probably do not need to adjust this value.
 +
-- 
2.13.1.792.g159074dab

