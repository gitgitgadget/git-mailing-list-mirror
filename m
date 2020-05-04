Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4627AC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232A8206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEDQKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:10:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:35958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725941AbgEDQKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:10:49 -0400
Received: (qmail 31732 invoked by uid 109); 4 May 2020 16:10:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 16:10:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18310 invoked by uid 111); 4 May 2020 16:10:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 12:10:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 12:10:48 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200504161048.GC12842@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200503065826.GB1829906@coredump.intra.peff.net>
 <20200504074520.GB86805@Carlos-MBP>
 <20200504144436.GA9893@coredump.intra.peff.net>
 <20200504153957.GC86805@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504153957.GC86805@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 08:39:57AM -0700, Carlo Marcelo Arenas Belón wrote:

> On Mon, May 04, 2020 at 10:44:36AM -0400, Jeff King wrote:
> > On Mon, May 04, 2020 at 12:45:20AM -0700, Carlo Marcelo Arenas Belón wrote:
> > > 
> > > * the meaning of "exactly" for matching protocol and hostname in the URL
> > >   since 06 are both case insensitive per RFC3986 and we have been
> > >   ambiguous on that, leading to some helpers assuming case or encoding.
> > 
> > Yeah, IIRC we discussed case-sensitivity at the time and went with the
> > stricter behavior in the name of safety over convenience. And I don't
> > think anybody has complained since then. So I'm not really _opposed_ to
> > loosening it to match the URL, but perhaps a maintenance release is not
> > the best time to do so.
> 
> agree, but I was talking not in the context of a feature, but on how we
> are to define the interaction with helpers (which was meant to be part of
> this maintenance release).
> 
> currently (since it is undefined) a naive helper could do a caseless match
> by assuming we really meant url as defined by RFC3986, and therefore affect
> the wrong credential by the operation.

Right, I understand. But if helpers are doing case-insensitive matches,
I don't think that's a big deal security-wise. And if we're not for our
helpers, that's erring on the conservative side, but if nobody is
complaining about it, I don't think it's urgent.

-Peff
