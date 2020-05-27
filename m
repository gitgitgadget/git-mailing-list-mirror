Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591AC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E1D2075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391890AbgE0SI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:08:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:57804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391703AbgE0SI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:08:27 -0400
Received: (qmail 23262 invoked by uid 109); 27 May 2020 18:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 18:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6238 invoked by uid 111); 27 May 2020 18:08:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 14:08:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 14:08:25 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 04/12] upload-pack: move filter_capability_requested to
 upload_pack_data
Message-ID: <20200527180825.GC4020820@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200527164742.23067-5-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527164742.23067-5-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 06:47:34PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move the filter_capability_requested
> static variable into this struct.
> 
> It is only used by protocol v0 code since protocol v2 assumes
> certain baseline capabilities, but rolling it into
> upload_pack_data and just letting v2 code ignore it as it does
> now is more coherent and cleaner.

Looks good, though this is another candidate for grouping/commenting in
the struct that it's v0-only.

-Peff
