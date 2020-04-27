Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1058FC54EEB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F336F2070B
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD0UMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:12:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:41326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725919AbgD0UMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 16:12:30 -0400
Received: (qmail 15681 invoked by uid 109); 27 Apr 2020 20:12:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 20:12:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27184 invoked by uid 111); 27 Apr 2020 20:23:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 16:23:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 16:12:28 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200427201228.GD1728884@coredump.intra.peff.net>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427200852.GC1728884@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 04:08:52PM -0400, Jeff King wrote:

> Skimming the patches, I do wish I didn't see so much repetition with the
> existing Makefile. I know that some of the logic will just have to be
> ported manually, but surely we could be pulling things like the list of
> libgit_SOURCES from the Makefile as the single source of truth?

Thinking I surely couldn't be the only one to think of this, I dug
further into some of the sub-threads. And indeed, it seems like you are
on the same page here.

IMHO it is worth making the cmake file depend as much as possible on
what's in the Makefile.

-Peff
