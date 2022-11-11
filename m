Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7937C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiKKPU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiKKPUV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:20:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0287BE50
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:20:10 -0800 (PST)
Received: (qmail 384 invoked by uid 109); 11 Nov 2022 15:20:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Nov 2022 15:20:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5965 invoked by uid 111); 11 Nov 2022 15:20:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Nov 2022 10:20:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Nov 2022 10:20:09 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t: run t5551 tests with both HTTP and HTTP/2
Message-ID: <Y25oKeLGxh2S2eyU@coredump.intra.peff.net>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
 <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
 <Y25hDr7aHvKnxso3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y25hDr7aHvKnxso3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 09:49:50AM -0500, Jeff King wrote:

>   - As discussed in b66c77a64e, the http2 module isn't compatible with
>     the "prefork" mpm, so we need to pick something else. I chose
>     "event" here, which works on my Debian system, but it's possible
>     there are platforms which would prefer something else. We can adjust
>     that later if somebody finds such a platform.

By the way, I confirmed that t5559 runs in CI (I checked linux-gcc, but
all of the ubuntu-based builds should run it, as they all install
apache).

-Peff
