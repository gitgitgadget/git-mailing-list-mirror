Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E448EC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C072C61166
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 16:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhFPQZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:25:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:57736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234810AbhFPQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 12:25:47 -0400
Received: (qmail 13534 invoked by uid 109); 16 Jun 2021 16:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 16:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28344 invoked by uid 111); 16 Jun 2021 16:23:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 12:23:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 12:23:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>
Subject: Re: [PATCH 0/5] serve: add "configure" callback
Message-ID: <YMoljEd/0Nv19dl7@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 04:16:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is a refactoring of what a callback in serve.c needs to do to
> aquire config. Currently two of them want that, and grab it in ad-hoc
> ways themselves, now they can insted configure a "configure" callback
> along with the existing "advertise" and "command", by the time they're
> called their config will already be read with their callback.
> 
> I split this prep work off from an upcoming series where I wanted to
> add a new capability, but I think this stands nicely on its own, and
> simplifies the existing code.

The first four seem like obviously-good cleanups. I'm not so sure
about the last one, though. I left some comments there.

-Peff
