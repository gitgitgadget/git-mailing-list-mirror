Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12901C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD7C61544
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhKSOfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:35:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:34850 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235496AbhKSOfc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:35:32 -0500
Received: (qmail 8243 invoked by uid 109); 19 Nov 2021 14:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:32:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13004 invoked by uid 111); 19 Nov 2021 14:32:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:32:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:32:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] xdiff/xmacros.h: remove unused XDL_PTRFREE
Message-ID: <YZe1fcGztalCRnb4@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
 <patch-1.6-32bb8ad4de0-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.6-32bb8ad4de0-20211119T124420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 01:46:21PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This macro was added in 3443546f6ef (Use a *real* built-in diff
> generator, 2006-03-24), but none of the xdiff code uses it, it uses
> xdl_free() directly.

Makes sense. Even if we wanted to use it, it is equivalent to our own
FREE_AND_NULL() anyway (since xdl_free() is really just an alias for
free()).

-Peff
