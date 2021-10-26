Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F19C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C670860F6F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhJZVU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:20:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:47430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhJZVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:20:58 -0400
Received: (qmail 10642 invoked by uid 109); 26 Oct 2021 21:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 21:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13968 invoked by uid 111); 26 Oct 2021 21:18:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 17:18:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 17:18:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Message-ID: <YXhwqVUNaoSZpdex@coredump.intra.peff.net>
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
 <211026.86fsso14m1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211026.86fsso14m1.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 12:05:40PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I'll try to do something about the $(QUIET*) as a follow-up, I was
> trying to find the right balance between over-verbosity & "tracing".

Yeah, I wondered if it would end up super-verbose. But I tried it out
and IMHO it looks just fine to print mkdir lines. In the initial build,
"make" realizes we only need to run each rule once, and in subsequent
builds it doesn't run them at all.

-Peff
