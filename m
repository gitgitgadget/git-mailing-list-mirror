Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15E6C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7A32068E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK0Lcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:32:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:33736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726204AbfK0Lcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 06:32:45 -0500
Received: (qmail 10529 invoked by uid 109); 27 Nov 2019 11:32:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 11:32:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9192 invoked by uid 111); 27 Nov 2019 11:36:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 06:36:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 06:32:44 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Doc: explain submodule.alternateErrorStrategy
Message-ID: <20191127113244.GC22221@sigill.intra.peff.net>
References: <cover.1574731649.git.jonathantanmy@google.com>
 <a8125b946227d918865fde0dcbec516474b42386.1574731649.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8125b946227d918865fde0dcbec516474b42386.1574731649.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 05:30:59PM -0800, Jonathan Tan wrote:

> Commit 31224cbdc7 ("clone: recursive and reference option triggers
> submodule alternates", 2016-08-17) taught Git to support the
> configuration options "submodule.alternateLocation" and
> "submodule.alternateErrorStrategy" on a superproject.
> 
> If "submodule.alternateLocation" is configured to "superproject" on a
> superproject, whenever a submodule of that superproject is cloned, it
> instead computes the analogous alternate path for that submodule from
> $GIT_DIR/objects/info/alternates of the superproject, and references it.
> 
> The "submodule.alternateErrorStrategy" option determines what happens
> if that alternate cannot be referenced. However, it is not clear that
> the clone proceeds as if no alternate was specified when that option is
> not set to "die" (as can be seen in the tests in 31224cbdc7). Therefore,
> document it accordingly.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> When I said "not clear" above, I mean that it is not clear *to me*, and
> I assume that others will feel the same way. Feel free to drop this from
> the patch set if the existing documentation is clear to most people.

FWIW, I learned about these options for the first time from your email,
and I think the suggested change makes the behavior much more clear.

-Peff
