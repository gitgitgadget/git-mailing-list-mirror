Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7760C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3B861100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbhIHTdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:33:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:42374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350652AbhIHTdW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:33:22 -0400
Received: (qmail 26050 invoked by uid 109); 8 Sep 2021 19:32:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 19:32:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32662 invoked by uid 111); 8 Sep 2021 19:32:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 15:32:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 15:32:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/5] post-v2.33 "drop support for ancient curl" follow-up
Message-ID: <YTkPvSzWKqEIVRDU@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 05:31:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is a follow-up to the already-integrated topic for dropping
> support for older curl versions submitted before the v2.33 release[1].
> 
> No verions become unsupported in this topic, this is a mere clean-up.
> 
> There were a couple of cases where we either already dropped support
> for something, but got the curl version wrong in a macro comparison,
> or just got the version wrong. That's now corrected.
> 
> But more importantly this introduces a git-curl-compat.h header which
> centarlizes all our curl version dependencies, and any compatability
> shims we've got to deal with those versions. This makes the code much
> easier to read and maintain than inline LIBCURL_VERSION_NUM version
> comparisons, and will make any future dropping of supported curl
> versions in the future easier to perform & review.

These all seem fine to me. I left a few comments that are mostly
thinking out loud, not really asking for any changes.

-Peff
