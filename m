Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A64DC5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 09:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjAFJKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 04:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAFJKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 04:10:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8021C436
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 01:10:41 -0800 (PST)
Received: (qmail 12886 invoked by uid 109); 6 Jan 2023 09:10:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 09:10:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12730 invoked by uid 111); 6 Jan 2023 09:10:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 04:10:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 04:10:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
Message-ID: <Y7flkC6BXdvYJxve@coredump.intra.peff.net>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
 <20220915160659.126441-4-gitster@pobox.com>
 <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de>
 <Y7Ury+2n77XBzNl+@coredump.intra.peff.net>
 <07b8e696-2736-142e-1937-7e60636de5f4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07b8e696-2736-142e-1937-7e60636de5f4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 04, 2023 at 05:36:11PM +0100, René Scharfe wrote:

> But this leaves the possibility that someone sets GIT_FLUSH=absolutely,
> loses data due to lack of flushing and is dissatisfied with the lack of
> parse errors.

I'd worry much more about GIT_FLUSH=ture.

As you noted, we are not currently diagnosing problems here, so your
patch is certainly not making anything worse. But maybe it's an
opportunity for us to improve things. ;)

-Peff
