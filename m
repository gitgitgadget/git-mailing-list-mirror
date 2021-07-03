Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFFC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D9561629
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhGCKzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:55:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:40692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhGCKzY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 06:55:24 -0400
Received: (qmail 2479 invoked by uid 109); 3 Jul 2021 10:52:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Jul 2021 10:52:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 535 invoked by uid 111); 3 Jul 2021 10:52:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Jul 2021 06:52:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 3 Jul 2021 06:52:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v4 0/3] bundle.c: remove "ref_list" in favor of
 string-list.c API
Message-ID: <YOBBgfiaz59KdsWS@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 02, 2021 at 11:57:29AM +0200, Ævar Arnfjörð Bjarmason wrote:

> This re-roll of v3 changes the discussion in the 1/3 commit message,
> it incorrectly referred to SANITIZE=leak when I meant valgrind.
> 
> I also changed the bundle_header_init() pattern to use the same
> "memcpy() a blank" as in my parallel series to do that more generally.

Thanks, this looks good to me.

I'd probably word the discussion about die() a bit differently, but you've
already seen my expositions on leak-checking, and it's all tangent here.
So let's move forward with this, and we can let leak-checking
philosophies iron themselves out as we fix more cases. :)

-Peff
