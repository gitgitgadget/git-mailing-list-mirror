Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA75C433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACE36196F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC1Ije (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 04:39:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:34576 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhC1Iix (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 04:38:53 -0400
Received: (qmail 2283 invoked by uid 109); 28 Mar 2021 08:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Mar 2021 08:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2224 invoked by uid 111); 28 Mar 2021 08:38:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Mar 2021 04:38:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Mar 2021 04:38:51 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] csum-file: make hashwrite() more readable
Message-ID: <YGBAm9qNdn4elbKF@coredump.intra.peff.net>
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
 <pull.914.v2.git.1616762291574.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.914.v2.git.1616762291574.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 12:38:11PM +0000, Derrick Stolee via GitGitGadget wrote:

> However, during this investigation, I inspected hashwrite() and
> misunderstood it, even after looking closely and trying to make it
> faster. This change simply reorganizes some parts of the loop within
> hashwrite() to make it clear that each batch either uses memcpy() to the
> hashfile's buffer or writes directly from the input buffer. The previous
> code relied on indirection through local variables and essentially
> inlined the implementation of hashflush() to reduce lines of code.

Thanks, I think this nicely argues for the change here (and I agree the
result, especially with the comments, is much easier to understand).

-Peff
