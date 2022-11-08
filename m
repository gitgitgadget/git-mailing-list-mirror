Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E05C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiKHOq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiKHOoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:44:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D26F1B7A2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:44:20 -0800 (PST)
Received: (qmail 7815 invoked by uid 109); 8 Nov 2022 14:44:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 14:44:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4946 invoked by uid 111); 8 Nov 2022 14:44:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 09:44:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 09:44:18 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 5/6] revparse: add `--exclude-hidden=` option
Message-ID: <Y2prQqR2Ka3nHdWP@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <68a5e563045f1b3e6db7304206d95ebebcacbe6f.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68a5e563045f1b3e6db7304206d95ebebcacbe6f.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 01:16:39PM +0100, Patrick Steinhardt wrote:

> Add a new `--exclude-hidden=` option that is similar to the one we just
> added to git-rev-list(1). Given a seciton name `transfer`, `uploadpack`
> or `receive` as argument, it causes us to exclude all references that
> would be hidden by the respective `$seciton.hideRefs` configuration.

Thanks for adding this one in. I feel like rev-parse isn't used all that
much these days, and in a sense, we could just let it fall behind what
rev-list could do and probably nobody would care. But since it's only a
few lines, keeping parity with rev-list is nice to have.

-Peff
