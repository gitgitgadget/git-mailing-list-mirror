Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FD0C636CE
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A773960FED
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhGUKp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:45:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238925AbhGUJj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:39:28 -0400
Received: (qmail 2011 invoked by uid 109); 21 Jul 2021 10:19:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2935 invoked by uid 111); 21 Jul 2021 10:19:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:19:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:19:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 07/24] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YPf0yduzM9ReOYfX@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <1448ca0d2ba265db2dce414a7f7d6b1f4bcb5a08.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1448ca0d2ba265db2dce414a7f7d6b1f4bcb5a08.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:15PM -0400, Taylor Blau wrote:

> When writing a new multi-pack index, write_midx_internal() attempts to
> clean up any auxiliary files (currently just the MIDX's `.rev` file, but
> soon to include a `.bitmap`, too) corresponding to the MIDX it's
> replacing.
> 
> This step should happen after the new MIDX is written into place, since
> doing so beforehand means that the old MIDX could be read without its
> corresponding .rev file.

Good catch. The patch looks obviously correct.

-Peff
