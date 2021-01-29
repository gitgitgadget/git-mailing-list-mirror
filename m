Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEFDC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23EA64DFD
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhA2Abi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:31:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:42686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhA2Abh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:31:37 -0500
Received: (qmail 20416 invoked by uid 109); 29 Jan 2021 00:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 00:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4095 invoked by uid 111); 29 Jan 2021 00:30:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 19:30:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 19:30:56 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 06/10] Documentation/config/pack.txt: advertise
 'pack.writeReverseIndex'
Message-ID: <YBNXQDlmdZVeMsA8@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <7e29f2d3a08c42b1e8368c4a2f52a11cc47ee959.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e29f2d3a08c42b1e8368c4a2f52a11cc47ee959.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:34PM -0500, Taylor Blau wrote:

> +pack.writeReverseIndex::
> +	When true, git will write a corresponding .rev file (see:
> +	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
> +	for each new packfile that it writes in all places except for
> +	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
> +	Defaults to false.

We may want to teach fast-import about this, too, but I think it's OK to
draw the line here for now (it's already reasonably well known that the
generated packs aren't amazing and benefit from repacking).

-Peff
