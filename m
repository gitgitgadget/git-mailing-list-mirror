Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16117C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 11:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjDRLE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDRLE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 07:04:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14C2D40
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 04:04:25 -0700 (PDT)
Received: (qmail 5207 invoked by uid 109); 18 Apr 2023 11:04:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 11:04:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1332 invoked by uid 111); 18 Apr 2023 11:04:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 07:04:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 07:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] gc: enable cruft packs by default
Message-ID: <20230418110424.GD516715@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:54:11PM -0400, Taylor Blau wrote:

> The series is structured as follows:
> 
>   - The first two patches are cleanup.
>   - The third patches fixes an oversight where the code for `git gc`'s
>     `--keep-largest-pack` option would incorrectly consider cruft packs.
>   - The next five patches are test preparation.
>   - Then the substantive patch, to actually graduate `gc.cruftPacks` and
>     enable it by default.
>   - The final patch is some cleanup that can only take place towards the
>     end of the series.

Thanks, this was a pleasant read. Besides Junio's small fixup in the
docs, everything I pointed out was minor enough that it wouldn't be a
big deal to go in as-is.

> Cruft packs have been a success for us at GitHub, and I am really
> excited to get it in the hands of more users by default.

Me too. :)

-Peff
