Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057E41F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBHW2y (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:28:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:46008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751786AbeBHW2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:28:53 -0500
Received: (qmail 9825 invoked by uid 109); 8 Feb 2018 22:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 22:28:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16175 invoked by uid 111); 8 Feb 2018 22:29:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 17:29:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 17:28:51 -0500
Date:   Thu, 8 Feb 2018 17:28:51 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] color.h: document and modernize header
Message-ID: <20180208222851.GA8850@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com>
 <20180208204309.GA4541@sigill.intra.peff.net>
 <CAPig+cTZuf5rMNN6aSztX-jKrJkuRpVcJj+xmrSsO6ngrHhU6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTZuf5rMNN6aSztX-jKrJkuRpVcJj+xmrSsO6ngrHhU6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 05:26:33PM -0500, Eric Sunshine wrote:

> > I think the point is that "var" is a quad-state variable (yes, no, auto,
> > or "unknown") and we are converting to a boolean. This would probably be
> > a lot more clear if GIT_COLOR_* were all enum values and not #defines,
> > and this function took the matching enum type.
> >
> > So I think that's what you were trying to name with "constants as
> > returned by...", but it definitely took me some thinking to parse it.
> 
> Rather than talking about plural "constants" (which makes it more
> confusing), it would likely be helpful for it to say (explicitly) that
> the caller passes in the result of git_config_colorbool() as 'var'.
> 
> Or something like that.

That's not quite it, though. "var" is really the current program's idea
of whether color has been requested. So it's git_config_colorbool(), as
modified by things like "--color".

I think the best explanation is that it resolves an "enum color_bool"
into a single 0/1 boolean. Except that "enum color_bool" doesn't exist,
so we have no name for it.

-Peff
