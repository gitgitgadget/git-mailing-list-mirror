Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7391F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfBLAfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:35:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:40956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfBLAfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:35:42 -0500
Received: (qmail 20016 invoked by uid 109); 12 Feb 2019 00:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19675 invoked by uid 111); 12 Feb 2019 00:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:35:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:35:40 -0500
Date:   Mon, 11 Feb 2019 19:35:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of
 0 on NonStop in one case
Message-ID: <20190212003540.GG13301@sigill.intra.peff.net>
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
 <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
 <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
 <20190212002705.GD13301@sigill.intra.peff.net>
 <xmqqpnrxg823.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnrxg823.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 04:32:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. We care to _some_ degree, since that's the condition we set up for
> > making sure that update-ref cannot take the lock. But it would probably
> > be fine to just confirm that we failed to take the lock. And there,
> > checking for just "Unable to create $Q.*packed-refs.lock" would be
> > sufficient.
> 
> Yeah, that was what I was getting at.  On top, we could also see
> "test -e" after noticing the failure but that probably does not help
> us prove anything.

Yeah, I don't think there is any point in "test -e". We were the ones
who created the file in the first place, so it would be very surprising
if it weren't there. ;)

-Peff
