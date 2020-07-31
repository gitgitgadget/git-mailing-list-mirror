Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A101C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F822087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGaTsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:48:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGaTsM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 15:48:12 -0400
Received: (qmail 24245 invoked by uid 109); 31 Jul 2020 19:48:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 19:48:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30191 invoked by uid 111); 31 Jul 2020 19:48:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 15:48:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 15:48:10 -0400
From:   Jeff King <peff@peff.net>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Diff --stat for files that differ only in whitespace
Message-ID: <20200731194810.GA849395@coredump.intra.peff.net>
References: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
 <20200731174149.GB843002@coredump.intra.peff.net>
 <CAOjrSZskJRj+TVV35fEp-Mhd+proVV72rh3vAcVFnNfhRy2ayA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOjrSZskJRj+TVV35fEp-Mhd+proVV72rh3vAcVFnNfhRy2ayA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 03:26:16PM -0400, Matt Rogers wrote:

> > This seemed familiar, so I dug up some prior discussion here:
> >
> >   https://lore.kernel.org/git/1484704915.2096.16.camel@mattmccutchen.net/
> >
> > We didn't come to a resolution there, but there is a patch to play with,
> > and I think nobody was opposed to the notion that with the right
> > code change we could be suppressing these whitespace-only stat lines
> >
> > -Peff
> 
> 
> I think for now I'm going to feed --numstat into a script like Junio suggested.
> Out of curiosity what would it take to get that patch into git? Is it just a
> matter of someone just verifying it and submitting it?

Yeah, I think it would require making an argument that the patch covers
the correct set of cases (or fixing it if it doesn't), and probably
adding some tests.

-Peff
