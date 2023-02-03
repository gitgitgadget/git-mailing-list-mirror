Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8AC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjBCQsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjBCQsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 11:48:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D81555D
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 08:48:09 -0800 (PST)
Received: (qmail 26235 invoked by uid 109); 3 Feb 2023 16:48:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 16:48:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10053 invoked by uid 111); 3 Feb 2023 16:48:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 11:48:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 11:48:08 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] add: remove Perl version of "git add -[pi]"
Message-ID: <Y906yEGFEIglRyVb@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2023 at 05:30:01PM +0100, Ævar Arnfjörð Bjarmason wrote:

> After it was made the default we had a next-release regression fix[1],
> but haven't had any issues since then. Any outstanding bugs in it are
> something we'd fix in the C code, not something where users are likely
> to want an escape hatch to scramble back to the Perl implementation.

I'm in favor of dropping the perl version, but note that this paragraph
isn't quite accurate. There was at least one more regression after that,
solved by fb094cb583 (Merge branch 'js/add-p-diff-parsing-fix',
2022-09-09).

I'd probably leave the final decision on its status to Johannes. This is
(I think) the last time we discussed it:

  https://lore.kernel.org/git/rsrn5988-37n4-7q45-s1o9-6n40rropp120@tzk.qr/

That was 6 months ago, so maybe it's time now.

-Peff
