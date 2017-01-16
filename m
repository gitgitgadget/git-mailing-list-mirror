Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173A420A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdAPVpk (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:45:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:39884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdAPVpi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:45:38 -0500
Received: (qmail 21529 invoked by uid 109); 16 Jan 2017 21:44:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:44:14 +0000
Received: (qmail 12490 invoked by uid 111); 16 Jan 2017 21:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:45:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:44:11 -0500
Date:   Mon, 16 Jan 2017 16:44:11 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
Message-ID: <20170116214411.a6wnp66vxydmpmgw@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <677a335f-889c-2924-b7bd-93c2b6663175@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <677a335f-889c-2924-b7bd-93c2b6663175@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 09:33:07PM +0100, Johannes Sixt wrote:

> However, Jeff's patch is intended to catch exactly these cases (not for the
> cases where this happens accidentally, but when they happen with malicious
> intent).
> 
> We are talking about user-provided data that is reproduced by die() or
> error(). I daresay that we do not have a single case where it is intended
> that this data is intentionally multi-lined, like a commit message. It can
> only be an accident or malicious when it spans across lines.
> 
> I know we allow CR and LF in file names, but in all cases where such a name
> appears in an error message, it is *not important* that the data is
> reproduced exactly. On the contrary, it is usually more helpful to know that
> something strange is going on. The question marks are a strong indication to
> the user for this.

Yes, exactly. Thanks for explaining this better than I obviously was
doing. :)

> > If you absolutely insist, I will spend time to find a plausible example
> > and use that in the regression test.
> 
> I don't want to see you on an endeavor with dubious results. I'd prefer to
> wait until the first case of "incorrectly munged data" is reported because,
> as I said, I have a gut feeling that there is none.

Agreed.

-Peff
