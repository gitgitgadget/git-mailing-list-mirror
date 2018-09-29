Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9411F453
	for <e@80x24.org>; Sat, 29 Sep 2018 07:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeI2OBv (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:01:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:36086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727502AbeI2OBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:01:51 -0400
Received: (qmail 9225 invoked by uid 109); 29 Sep 2018 07:34:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 07:34:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4452 invoked by uid 111); 29 Sep 2018 07:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 03:34:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 03:34:26 -0400
Date:   Sat, 29 Sep 2018 03:34:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v3 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180929073426.GC2174@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
 <20180928053057.GD25850@sigill.intra.peff.net>
 <20180928220557.GB45367@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928220557.GB45367@syl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 03:05:57PM -0700, Taylor Blau wrote:

> > > For example, to advertise only tags, a caller using
> > > 'core.alternateRefsCommand' would have to do:
> > >
> > >   $ git config core.alternateRefsCommand ' \
> > >       git -C "$1" for-each-ref refs/tags --format="%(objectname)"'
> >
> > This has the same "$@" issue as the previous one, I think (which only
> > makes your point about it being cumbersome more true!).
> 
> Hmm. I'll be curious to how you respond to my other message about the
> same topic. I feel that whatever the outcome there is will affect both
> locations in the same way.

I think they're separate issues, right? I was just confused on the
earlier patch, but the "git config" command you show above is the actual
broken case isn't it?

I'm not overly concerned since this isn't recommending the technique to
end users (and in fact the whole point is to give an alternative), but
it may be worth showing a working command in case anybody runs across
it.

-Peff
