Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26611EB64DA
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 22:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGBWdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 18:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGBWdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 18:33:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACECE4C
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 15:33:43 -0700 (PDT)
Received: (qmail 17720 invoked by uid 109); 2 Jul 2023 22:33:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 22:33:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16657 invoked by uid 111); 2 Jul 2023 22:33:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 18:33:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 18:33:42 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 0/3] a few --points-at optimizations/cleanups
Message-ID: <20230702223342.GA1598765@coredump.intra.peff.net>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
 <20230702220243.GA1534980@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230702220243.GA1534980@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 02, 2023 at 06:02:43PM -0400, Jeff King wrote:

> I'll send some patches in a minute that can be applied on top to
> improve this case, as well as fix the other issues I pointed out in the
> existing code.

Here they are, on top of your patch.

  [1/3]: ref-filter: avoid parsing tagged objects in match_points_at()
  [2/3]: ref-filter: avoid parsing non-tags in match_points_at()
  [3/3]: ref-filter: simplify return type of match_points_at

 ref-filter.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-Peff
