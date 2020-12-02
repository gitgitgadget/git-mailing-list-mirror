Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E9C64E7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FC021D7E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgLBBvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:51:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:48190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgLBBvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 20:51:31 -0500
Received: (qmail 29752 invoked by uid 109); 2 Dec 2020 01:50:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 01:50:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2732 invoked by uid 111); 2 Dec 2020 01:50:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 20:50:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 20:50:50 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 6/6] fixup! reftable: rest of library
Message-ID: <X8by+j24ccvt0F04@coredump.intra.peff.net>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com>
 <X8Ya24TJd87hRq7H@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2012011519340.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2012011519340.54@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 03:24:01PM +0100, Johannes Schindelin wrote:

> > I don't see it being invoked anywhere,
> 
> It is invoked in `t/t0032-reftable-unittest.sh`:
> https://github.com/dscho/git/blob/reftable-on-windows/t/t0032-reftable-unittest.sh

Ah, thank you. I was looking at what Junio has queued in hn/reftable.

> > but presumably if we were to add support to our test suite, we'd have a
> > script which invokes it within a scratch directory.
> 
> I agree that it would make most sense for t0032 to prefix the call to
> `test-tool` with `TMPDIR=$PWD`.

Yep, that would be fine.

I'm not sure if the long-term goal is to have this opaque unit-test
program or not. If it is, I was likewise going to suggest that its
ad-hoc output be replaced with TAP. But it looks like on your branch
that "test-tool reftable" does not produce output at all. So I may be a
bit behind on what the current state and forward plans are...

-Peff
