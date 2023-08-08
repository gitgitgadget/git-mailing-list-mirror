Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC9C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHHV2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHHV2z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:28:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494F91
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 14:28:54 -0700 (PDT)
Received: (qmail 12999 invoked by uid 109); 8 Aug 2023 21:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 21:28:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24534 invoked by uid 111); 8 Aug 2023 21:28:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 17:28:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 17:28:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230808212852.GA760815@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808212720.GA760752@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 05:27:21PM -0400, Jeff King wrote:

> So before I sent a patch (either to switch to using opt->value, or to
> add an UNUSED annotation), I wanted to see what you (or others) thought
> between the two. I.e., should we have a rule of "try not to operate on
> global data via option callbacks" or is that just being too pedantic for
> one-off callbacks like this?

Oh, and btw, the same situation exists for the "pack-objects --no-quiet"
earlier in this thread (which is why I was trying to establish the
general approach).

-Peff
