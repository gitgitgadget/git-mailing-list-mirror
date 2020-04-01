Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0955DC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43C220772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 09:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDAJ4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:56:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:58024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726335AbgDAJ4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 05:56:36 -0400
Received: (qmail 1081 invoked by uid 109); 1 Apr 2020 09:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 09:56:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6523 invoked by uid 111); 1 Apr 2020 10:06:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 06:06:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 05:56:35 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (March 31, 2020)
Message-ID: <20200401095635.GB60227@coredump.intra.peff.net>
References: <e7e15fd8-01fa-61df-830d-04e4882adc38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e15fd8-01fa-61df-830d-04e4882adc38@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 09:58:17PM -0400, Derrick Stolee wrote:

> Uncovered code in 'jch' not in 'next'
> --------------------------------------------------------
> [...]
> Jeff King	16ddcd40 sha1_array: let callbacks interrupt iteration
> oid-array.c
> 16ddcd40 76) return ret;

Hmm, that commit is from 2016. I guess it was triggered now because I
renamed sha1-array.c to oid-array.c recently. I'm not sure what the
right thing is here. Following the movement via blames a long-ago commit
(I just happen to be the author of both in this case). But not following
the movement means that my rename would get blamed for code that isn't
actually new.

-Peff
