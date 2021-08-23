Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91182C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CA8613D2
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhHWQIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:08:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:56650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhHWQIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:08:44 -0400
Received: (qmail 11891 invoked by uid 109); 23 Aug 2021 16:08:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 16:08:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30028 invoked by uid 111); 23 Aug 2021 16:08:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 12:08:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 12:08:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: set packet_trace_identity(<name>)
Message-ID: <YSPH4PoRG78Ybv0J@coredump.intra.peff.net>
References: <patch-1.1-5d3a2b96500-20210823T131533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-5d3a2b96500-20210823T131533Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 03:17:49PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Set packet_trace_identity() for ls-remote. This replaces the generic
> "git" identity in GIT_TRACE_PACKET=<file> traces to "ls-remote", e.g.:
> 
>     [...] packet:  upload-pack> version 2
>     [...] packet:  upload-pack> agent=git/2.32.0-dev
>     [...] packet:    ls-remote< version 2
>     [...] packet:    ls-remote< agent=git/2.32.0-dev
> 
> Where in an "git ls-remote file://<path>" dialog ">" is the sender (or
> "to the server") and "<" is the recipient (or "received by the
> client").

Thanks, this looks like an obvious improvement. I'm a little surprised
it wasn't there already, but I guess I just missed it way back in
bbc30f9963 (add packet tracing debug code, 2011-02-24).

-Peff
