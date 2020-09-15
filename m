Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E93C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFF82080C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgIPAjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:39:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:57018 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIONGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 09:06:12 -0400
Received: (qmail 12238 invoked by uid 109); 15 Sep 2020 13:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Sep 2020 13:06:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17791 invoked by uid 111); 15 Sep 2020 13:06:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Sep 2020 09:06:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Sep 2020 09:06:06 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Pass --ipv4 and --ipv6 options to sub-fetches when
 fetching multiple remotes and submodules
Message-ID: <20200915130606.GB2839276@coredump.intra.peff.net>
References: <20200915115025.GA18984@pflmari>
 <20200915115407.GA31786@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915115407.GA31786@pflmari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 01:54:07PM +0200, Alex Riesen wrote:

> The options indicate user intent for the whole fetch operation, and
> ignoring them in sub-fetches is quite unexpected when, for instance,
> it is intended to limit all of the communication to a specific transport
> protocol for some reason.
> 
> Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> ---

Regardless of whether we move forward with the parse-options flag or
config discussed in the other thread, I think this is an obvious
improvement that we should take in the meantime.

-Peff
