Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00737C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F0C2084C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgLAK3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:29:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:46966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgLAK3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 05:29:24 -0500
Received: (qmail 25513 invoked by uid 109); 1 Dec 2020 10:28:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 10:28:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24840 invoked by uid 111); 1 Dec 2020 10:28:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 05:28:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 05:28:43 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/6] fixup! reftable: rest of library
Message-ID: <X8Ya24TJd87hRq7H@coredump.intra.peff.net>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 28, 2020 at 06:44:38AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The stack_test hard-codes `/tmp/`. That is a particular problem on
> Windows where the temp directory is never at that location.
> 
> Let's not do that, but instead use `TMPDIR` as we do in similar
> scenarios in the rest of Git's source code.

Yeah, I noticed this, as well. This seems like a good band-aid, but it
would probably be nice if the test tool was able to write into a
specified directory (or even just the current directory). I don't see it
being invoked anywhere, but presumably if we were to add support to our
test suite, we'd have a script which invokes it within a scratch
directory.

-Peff
