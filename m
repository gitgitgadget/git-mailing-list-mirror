Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45ACC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A139D206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgGaTPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:15:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:44108 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGaTPd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 15:15:33 -0400
Received: (qmail 24072 invoked by uid 109); 31 Jul 2020 19:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 19:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29940 invoked by uid 111); 31 Jul 2020 19:15:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 15:15:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 15:15:32 -0400
From:   Jeff King <peff@peff.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] t6300: fix issues related to %(contents:size)
Message-ID: <20200731191532.GB848793@coredump.intra.peff.net>
References: <20200731174509.9199-1-alban.gruin@gmail.com>
 <20200731182607.15532-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731182607.15532-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 08:26:07PM +0200, Alban Gruin wrote:

> b6839fda68 (ref-filter: add support for %(contents:size), 2020-07-16)
> added a new format for ref-filter, and added a function to generate
> tests for this new feature in t6300.  Unfortunately, it tries to run
> `test_expect_sucess' instead of `test_expect_success', and writes
> $expect to `expected', but tries to read `expect'.  Those two issues
> were probably unnoticed because the script only printed errors, but did
> not crash.  This fixes these issues.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  t/t6300-for-each-ref.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good. Good eyes for spotting this, and thanks for the quick fix.

-Peff
