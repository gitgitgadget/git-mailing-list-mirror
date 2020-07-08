Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4436C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E213221EE
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 08:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGHIlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:41:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:52074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGHIlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 04:41:37 -0400
Received: (qmail 27928 invoked by uid 109); 8 Jul 2020 08:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2020 08:41:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7246 invoked by uid 111); 8 Jul 2020 08:41:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jul 2020 04:41:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jul 2020 04:41:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 0/4] upload-pack: custom allowed object filters
Message-ID: <20200708084136.GA2324177@coredump.intra.peff.net>
References: <cover.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593720075.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 04:06:14PM -0400, Taylor Blau wrote:

>   [uploadpack]
>   	allowAnySHA1InWant = true
>   	allowFilter = true
>   [uploadpack "filter"]
>   	allow = false
>   [uploadpack "filter.blob:limit"]
>   	allow = true
>   [uploadpack "filter.blob:none"]
>   	allow = true
>   [uploadpack "filter.tree"]
>   	allow = true
>   	maxDepth = 0

I thought the previous discussion landed on:

  uploadpackfilter.blob:none.allow

etc, to avoid the confusing appearance of four-level keys (and the weird
case sensitivity implications that would cause).

-Peff
