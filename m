Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA87C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbjDFRMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjDFRMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 13:12:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99789039
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 10:12:04 -0700 (PDT)
Received: (qmail 17469 invoked by uid 109); 6 Apr 2023 17:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 17:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28220 invoked by uid 111); 6 Apr 2023 17:12:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Apr 2023 13:12:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Apr 2023 13:12:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
Message-ID: <20230406171203.GB2709660@coredump.intra.peff.net>
References: <20230330112133.4437-1-oystwa@gmail.com>
 <20230330112133.4437-3-oystwa@gmail.com>
 <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk>
 <xmqqjzywg7sg.fsf@gitster.g>
 <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2023 at 06:55:52PM +0200, Øystein Walle wrote:

> > It however theoretically can break an existing use case where the
> > user correlates the output with a list of refs they externally
> > prepared (e.g. "for-each-ref --format... a b c" shows "A", "", and
> > "C", and the user knows "b" produced "").  I do not know how likely
> > such users complain, though, and if there is nobody who relies on
> > the current behaviour, surely "unconditionally omit" is a very
> > tempting approach to take.
> >
> > Thanks.
> 
> I actually instinctively expected for-each-ref to suppress empty lines, at
> least by default. I don't see a good reason for them, except for something
> along the lines of what you said.
> 
> We can of course make it a config option along with the flag, then after some
> time flip the default, and perhaps ultimately remove the config option again.
> Perhaps in a v3 if there is enough interest; will send a v2 shortly. But I
> must admit I am not very motivated to follow that up down the line.

It might be enough to flip the default unconditionally (no config), but
I think we may still want "--no-omit-empty-lines" as an escape hatch. I
dunno. Maybe that is somehow choosing the worst of both worlds.

-Peff
