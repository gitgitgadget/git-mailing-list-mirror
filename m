Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11E6C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB67610A2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbhIBJqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:46:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241297AbhIBJp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:45:59 -0400
Received: (qmail 21911 invoked by uid 109); 2 Sep 2021 09:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:45:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23257 invoked by uid 111); 2 Sep 2021 09:45:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:45:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:45:00 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <YTCdHHRW/i3HVN0h@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 04:51:33PM -0400, Taylor Blau wrote:

> This series resolves that discussion by leaving everything as-is, and only
> changing the following:
> 
>   - `git multi-pack-index` will not run when outside of a Git
>     repository.
> 
>   - The `--object-dir` argument will only recognize object directories
>     belonging to an alternate of the current repository.
> 
>   - Using `--object-dir` to point to a repository which uses a
>     different hash than the repository in the current working directory
>     will continue to not work (as was the case before this series).
> 
> And because this incorporates [1], we will also not accidentally clean `.rev`
> files from the wrong object directory.

Thanks. I read over the new patches, and all looks good to me (using the
revised patch 11 you already sent, and which I commented on separately).

-Peff
