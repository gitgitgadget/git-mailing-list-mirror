Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5669C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DA964EF6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhCQRmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:42:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:39642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232037AbhCQRmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:42:24 -0400
Received: (qmail 26134 invoked by uid 109); 17 Mar 2021 17:42:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 17:42:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9893 invoked by uid 111); 17 Mar 2021 17:42:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 13:42:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 13:42:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH] t5606: run clone branch name test with protocol v2
Message-ID: <YFI/fxqUoBeCINgv@coredump.intra.peff.net>
References: <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
 <20210317154200.2656837-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317154200.2656837-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 08:42:00AM -0700, Jonathan Tan wrote:

> 4f37d45706 ("clone: respect remote unborn HEAD", 2021-02-05) introduces
> a new feature (if the remote has an unborn HEAD, e.g. when the remote
> repository is empty, use it as the name of the branch) that only works
> in protocol v2, but did not ensure that one of its tests always uses
> protocol v2, and thus that test would fail if
> GIT_TEST_PROTOCOL_VERSION=0 (or 1) is used. Therefore, add "-c
> protocol.version=2" to the appropriate test.
> 
> (The rest of the tests from that commit have "-c protocol.version=2"
> already added.)

Thanks, this looks like the obvious and correct fix (and clearly makes
the test pass ;) ).

-Peff
