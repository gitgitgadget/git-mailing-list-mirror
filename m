Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F4C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8682078D
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgHSNvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:51:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:35312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbgHSNvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 09:51:11 -0400
Received: (qmail 24140 invoked by uid 109); 19 Aug 2020 13:51:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Aug 2020 13:51:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6137 invoked by uid 111); 19 Aug 2020 13:51:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Aug 2020 09:51:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 Aug 2020 09:51:09 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] Clean up some memory leaks in and around dir.c
Message-ID: <20200819135109.GA2498279@coredump.intra.peff.net>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <pull.831.v2.git.git.1597791506.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.831.v2.git.git.1597791506.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 10:58:24PM +0000, Elijah Newren via GitGitGadget wrote:

> Some memory leaks in dir.c were making it hard for me to find my own leaks
> in merge-ort. I followed a few threads and tried to both clean up the leaks
> and make the API less prone to incorrect use.
> 
> Changes since v1:
> 
>  * dropped the first patch, since Peff submitted an identical patch a day
>    before me
>  * implemented Peff's suggestions to rename dir_free() to dir_clear() and
>    have it call dir_init() at the end so that folks can re-use the struct
>    after dir_clear() if they so choose.

Thanks, both patches look good to me.

-Peff
