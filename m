Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F277CC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4EE2223C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKMUkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:40:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:57838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMUkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:40:32 -0500
Received: (qmail 27129 invoked by uid 109); 13 Nov 2020 20:40:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 20:40:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16277 invoked by uid 111); 13 Nov 2020 20:40:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 15:40:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 15:40:31 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 1/4] t1400: avoid touching refs on filesystem
Message-ID: <20201113204031.GA780435@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
 <617d48b00a13c8ef82749f0b610997625f6cf222.1605254957.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <617d48b00a13c8ef82749f0b610997625f6cf222.1605254957.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 09:12:31AM +0100, Patrick Steinhardt wrote:

> The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> many tests directly read and write references via the filesystem,
> assuming that we always use loose and/or packed references. While this
> is true now, it'll change with the introduction of the reftable backend.
> 
> Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> possible. Furthermore, two tests are converted to not delete HEAD
> anymore, as this results in a broken repository. They've instead been
> updated to create a non-mandatory symybolic reference and delete that
> one instead.

s/symybolic/symbolic/

Other than, this whole series looks good to me. Thanks for taking the
time to do the extra cleanup (which ended up being way more complicated
than the original goal :) ).

-Peff
