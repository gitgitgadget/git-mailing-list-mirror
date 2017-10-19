Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CEB202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbdJSUcw (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:32:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:58230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752743AbdJSUcv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:32:51 -0400
Received: (qmail 3131 invoked by uid 109); 19 Oct 2017 20:32:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:32:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12058 invoked by uid 111); 19 Oct 2017 20:32:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:32:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:32:49 -0400
Date:   Thu, 19 Oct 2017 16:32:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
Message-ID: <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
 <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 08:26:47PM +0200, René Scharfe wrote:

> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 5f2628c8f8..82622e7fbc 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -29,6 +29,9 @@ OPTIONS
>  	These options are _not_ mutually exclusive; when given
>  	both, references stored in refs/heads and refs/tags are
>  	displayed.
> ++
> +*NOTE*: -h without any other parameters shows a short help text instead
> +of any refs.

Yuck. This "we only treat -h as special in certain cases" rule is
sufficiently magical that I don't think we want to advertise and lock
ourselves into it.

-Peff
