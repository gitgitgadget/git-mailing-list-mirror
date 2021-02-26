Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B8C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 08:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C3964EE1
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 08:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZIAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 03:00:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:45694 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhBZIAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 03:00:41 -0500
Received: (qmail 12542 invoked by uid 109); 26 Feb 2021 07:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:59:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17205 invoked by uid 111); 26 Feb 2021 07:59:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:59:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:59:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/12] Simple IPC Mechanism
Message-ID: <YDiqeaNX/BeROFGf@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <xmqq8s7cuebo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8s7cuebo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 11:39:39AM -0800, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Here is V4 of my "Simple IPC" series. It addresses Gábor's comment WRT
> > shutting down the server to make unit tests more predictable on CI servers.
> > (https://lore.kernel.org/git/20210213093052.GJ1015009@szeder.dev)
> >
> > Jeff
> >
> > cc: Ævar Arnfjörð Bjarmason avarab@gmail.com cc: Jeff Hostetler
> > git@jeffhostetler.com cc: Jeff King peff@peff.net cc: Chris Torek
> > chris.torek@gmail.com
> 
> It seems that the discussions around the topic has mostly done
> during the v2 review, and has quieted down since then.
> 
> Let's merge it down to 'next'?

Sorry, I hadn't gotten around to looking at the latest version. I left
another round of comments. Some of them are arguably bikeshedding, but
there's at least one I think we'd want to address (the big stack buffer
in patch 1).

I also haven't carefully looked at the simple-ipc design at all; my
focus has just been on the details of socket and pktline code being
touched. Since there are no simple-ipc users yet, and since it's
internal and would be easy to change later, I'm mostly content for Jeff
to proceed as he sees fit and iterate on it as necessary.

-Peff
