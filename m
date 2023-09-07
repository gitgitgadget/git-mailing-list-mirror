Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD59DEC8750
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjIGTHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIGTHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:07:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C792
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:07:08 -0700 (PDT)
Received: (qmail 27109 invoked by uid 109); 7 Sep 2023 08:00:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 08:00:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24400 invoked by uid 111); 7 Sep 2023 08:00:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 04:00:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 04:00:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/8] builtin/repack.c: extract redundant pack cleanup for
 --geometric
Message-ID: <20230907080026.GC1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <5c25ef87c1430e012a2e48b738b3b5aa760b4b0f.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c25ef87c1430e012a2e48b738b3b5aa760b4b0f.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:46PM -0400, Taylor Blau wrote:

> To reduce the complexity of the already quite-long `cmd_repack()`
> implementation, extract out the parts responsible for deleting redundant
> packs from a geometric repack out into its own sub-routine.

Makes sense. Again, I'm happy to see some of these large functional
pieces of cmd_repack() moved into sub-functions. Even if we never call
them twice, IMHO it is a readability improvement to give them meaningful
names.

-Peff
