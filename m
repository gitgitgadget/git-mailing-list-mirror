Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF55C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCA5221FE
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgLBMtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:49:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:48704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLBMtI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 07:49:08 -0500
Received: (qmail 32521 invoked by uid 109); 2 Dec 2020 12:48:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 12:48:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7098 invoked by uid 111); 2 Dec 2020 12:48:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Dec 2020 07:48:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Dec 2020 07:48:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitignore: remove entry for git serve
Message-ID: <X8eNGzay6yWSEoJH@coredump.intra.peff.net>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-3-felipe.contreras@gmail.com>
 <xmqqczztqszv.fsf@gitster.c.googlers.com>
 <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
 <4e30fa82-fe24-1783-6f9a-13e1dd6f4ca9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e30fa82-fe24-1783-6f9a-13e1dd6f4ca9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 02, 2020 at 12:46:01PM +0100, René Scharfe wrote:

> b7ce24d095 (Turn `git serve` into a test helper, 2019-04-18) demoted git
> serve from a builtin command to a test helper.  As a result the
> git-serve binary is no longer built and thus doesn't have to be ignored
> anymore.

Good catch. This shows a weakness in my detection script: I had a stale
git-serve sitting around from building old versions of Git. :)

I repeated the script in a "clean" directory that was a fresh clone +
make, and diffed the results. git-serve was the only interesting
difference I saw. So this is probably the last of the low-hanging fruit.

-Peff
