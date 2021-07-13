Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFCC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CD66128B
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbhGMVUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:48288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235772AbhGMVUg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:20:36 -0400
Received: (qmail 12116 invoked by uid 109); 13 Jul 2021 21:17:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 21:17:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14154 invoked by uid 111); 13 Jul 2021 21:17:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 17:17:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 17:17:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] add missing __attribute__((format))
Message-ID: <YO4C+dq3KjxInyp6@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 10:05:15AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Adds missing add missing __attribute__((format)) in various places,
> which improves compile-time checking.
> 
> v2: Let's drop the whole bending over backwards to do mostly/entirely
> useless strftime() checking. That's gone, I added a patch at the end
> with a comment for strbuf_addftime() to say why it's not there, and
> also split up the advise_if_enabled() change into its own commit.
> 
> I also removed the other cases of adding attribute checking to
> compat/*. I can't easily test those, and I don't know if there's
> potential bad interactions with git-compat-util.h.

Thanks. Modulo a whitespace typo in the final patch, these all look good
to me.

I could take or leave the final patch, as I never wondered about
strftime format-checking in the first place. :) But I don't mind it
either way (the alternative is that the v1 discussion in the list could
serve the purpose).

-Peff
