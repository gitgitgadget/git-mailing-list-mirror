Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC2A1FF30
	for <e@80x24.org>; Tue, 23 May 2017 11:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763648AbdEWLjg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 07:39:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56639 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763599AbdEWLjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 07:39:35 -0400
Received: (qmail 1385 invoked by uid 109); 23 May 2017 11:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 11:39:32 +0000
Received: (qmail 31068 invoked by uid 111); 23 May 2017 11:40:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 07:40:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 07:39:30 -0400
Date:   Tue, 23 May 2017 07:39:30 -0400
From:   Jeff King <peff@peff.net>
To:     "Holst, Henrik" <henrik.holst@frostbite.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git --merge and option parsing
Message-ID: <20170523113930.tqg4te7dfqr3f7s2@sigill.intra.peff.net>
References: <BLUPR0701MB75463EE0B8ADC559BBE02A282F90@BLUPR0701MB754.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BLUPR0701MB75463EE0B8ADC559BBE02A282F90@BLUPR0701MB754.namprd07.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 10:17:18AM +0000, Holst, Henrik wrote:

> I am not sure if this is a bug but it was surprising to me so I
> thought I'd report it here.
> 
> I added `ui.column=auto` to my gitconfig and that does not work so
> well with pipes so I want to use `--no-column` option. I was a bit
> surprised that this does not work? It seems that `--merged` picks up
> `--no-column` as a commit reference instead it being parsed as an
> option.

That's behaving as expected. The --merged option has an optional
argument, which defaults to "HEAD". If you provide another argument
(even if it looks like an option to you), then it gets attached to
--merged.

As you saw, "git branch --no-column --merged" works, but so would "git
branch --merged HEAD --no-column".

-Peff
