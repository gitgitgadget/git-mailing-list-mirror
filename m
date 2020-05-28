Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64886C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4D7207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405159AbgE1Qwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 12:52:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405105AbgE1Qwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 12:52:46 -0400
Received: (qmail 30673 invoked by uid 109); 28 May 2020 16:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 16:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15476 invoked by uid 111); 28 May 2020 16:52:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 12:52:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 12:52:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
Message-ID: <20200528165245.GA1223396@coredump.intra.peff.net>
References: <20200528083745.15273-1-carenas@gmail.com>
 <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
 <20200528154349.GA1215380@coredump.intra.peff.net>
 <xmqqh7w03vnq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7w03vnq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 08:51:21AM -0700, Junio C Hamano wrote:

> > I think it may be a good policy to stick to the
> > simplest machine-readable formats for trailers. Likewise I'd suggest
> > using the full sha1-hex for future-proofing in this context.
> 
> Yes, or just roll it into prose like we often do.  Anybody can spot
> many examples from "git log --no-merges" ;-)

Yeah, I was sort of working under the assumption that people found
utility in putting that data in a trailer (in which case I'd really
suggest doing both; a prose one with subject meant for readers, and a
machine-readable annotation).

But I haven't really found a use for "Fixes" in machine-readable format.
I don't _mind_ people doing it if they do have a use (and I'd even
consider doing it myself if I were shown that it was useful). In the
meantime, I don't know if we want to state a project preference against
it.

-Peff
