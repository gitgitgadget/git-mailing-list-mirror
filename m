Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7551F404
	for <e@80x24.org>; Fri,  6 Apr 2018 14:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbeDFOzV (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 10:55:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:55922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755371AbeDFOzU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 10:55:20 -0400
Received: (qmail 14821 invoked by uid 109); 6 Apr 2018 14:55:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 14:55:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26171 invoked by uid 111); 6 Apr 2018 14:56:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 10:56:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 10:55:18 -0400
Date:   Fri, 6 Apr 2018 10:55:18 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180406145517.GB25041@sigill.intra.peff.net>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522992443.git.me@ttaylorr.com>
 <20180406052907.GD60769@syl.local>
 <CAPig+cSYuWReTFfnN8Wg2VGKcOk5SPHHWpTdW6yks67mkOjY0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSYuWReTFfnN8Wg2VGKcOk5SPHHWpTdW6yks67mkOjY0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 02:14:34AM -0400, Eric Sunshine wrote:

> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -9,13 +9,13 @@ git-config - Get and set repository or global options
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
> > +'git config' [<file-option>] [--type] [--show-origin] [-z|--null] name [value [value_regex]]
> 
> It's pretty confusing to see bare "--type" like this which makes it
> seem as if it doesn't take an argument at all. Better would be
> "[--type=<type>]".

In the interest of brevity, I actually think it could remain "[type]".
IMHO the synopsis should be giving a summary and does not have to
mention every detail (as long as it is not _inaccurate_, which I agree
that "--type" is bordering on).

-Peff
