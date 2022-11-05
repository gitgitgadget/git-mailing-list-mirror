Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392FC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKEMzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:55:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635827CCD
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:55:05 -0700 (PDT)
Received: (qmail 24700 invoked by uid 109); 5 Nov 2022 12:55:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Nov 2022 12:55:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7333 invoked by uid 111); 5 Nov 2022 12:55:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Nov 2022 08:55:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 5 Nov 2022 08:55:04 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/3] revision: add new parameter to specify all
 visible refs
Message-ID: <Y2ZdKL9QG+fNw3ME@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
 <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 03:37:32PM +0100, Patrick Steinhardt wrote:

> diff --git a/t/t6021-rev-list-visible-refs.sh b/t/t6021-rev-list-visible-refs.sh
> new file mode 100755
> index 0000000000..9e12384dcf

Oh, I forgot to mention in my earlier response: these tests mostly look
good to me, but it may be worth having a few that cover the namespaces
feature. I _think_ your code is doing the right thing (because it calls
strip_namespace() as appropriate), but I have to admit I am generally
confused about how the namespace feature works in the first place. So
it's probably good to figure out how it is supposed to interact here and
make sure it is covered by tests.

-Peff
