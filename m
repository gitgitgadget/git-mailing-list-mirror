Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E729C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFAE6128A
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhEVJ6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 05:58:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:34346 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhEVJ6V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 05:58:21 -0400
Received: (qmail 9922 invoked by uid 109); 22 May 2021 09:56:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 May 2021 09:56:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17723 invoked by uid 111); 22 May 2021 09:56:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 May 2021 05:56:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 May 2021 05:56:55 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] help: colorize man pages
Message-ID: <YKjVZ28fxqGq7Baq@coredump.intra.peff.net>
References: <20210522011718.541986-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210522011718.541986-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 08:17:18PM -0500, Felipe Contreras wrote:

> +	/* Add red to bold, blue to underline, and magenta to standout */
> +	/* No visual information is lost */
> +	setenv("LESS", "Dd+r$Du+b$Ds+m", 0);

Unlike the LESS_TERMCAP_* strategy, this completely breaks "git help"
on my system:

  $ ./git help git
  There is no -D option ("less --help" for help)

  $ man less | grep -A1 '^ *-D'
         -Dxcolor or --color=xcolor
                [MS-DOS only] Sets the color of the text displayed.  x is a single

This is less 551-2 on Debian unstable.

-Peff
