Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7579CC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGGGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLGGGt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:06:49 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AEA53EE5
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:06:48 -0800 (PST)
Received: (qmail 17765 invoked by uid 109); 7 Dec 2022 06:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 06:06:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30608 invoked by uid 111); 7 Dec 2022 06:06:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 01:06:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 01:06:47 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y5AtdwGdWrDQxuuJ@coredump.intra.peff.net>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <xmqqedtdpfoe.fsf@gitster.g>
 <Y46M4oksPQkqwmTC@nand.local>
 <221206.86r0xdcm2u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.86r0xdcm2u.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 03:12:08AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I'm not saying you *should*, but now that we use C99 macros we *could*
> also make the "1" an optional argument. I.e. these would be the same
> thing:
> 
> 	CALLOC(x)
> 	CALLOC(x, 1)
> 
> And you could also do:
> 
> 	CALLOC(x, 123)
> 
> Whether that makes the interface even nastier is another matter.

Like the INIT proposal you mentioned, I tend to think this is clever but
not really a good idea in the long run. I don't mind magic if it's
giving us a big benefit, but I don't think that's the case here. :)

-Peff
