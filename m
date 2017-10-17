Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EDD1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965718AbdJQTLM (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 15:11:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:55810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965584AbdJQTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 15:11:11 -0400
Received: (qmail 9666 invoked by uid 109); 17 Oct 2017 19:11:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 19:11:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26328 invoked by uid 111); 17 Oct 2017 19:11:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 15:11:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Oct 2017 15:11:08 -0400
Date:   Tue, 17 Oct 2017 15:11:08 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
Message-ID: <20171017191108.6tcmpbuasbgrb4sk@sigill.intra.peff.net>
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
 <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
 <87d15lu48o.fsf@linux-m68k.org>
 <20171017163828.igmlsbdynpe6m37w@sigill.intra.peff.net>
 <878tg9u1o7.fsf@linux-m68k.org>
 <20171017172930.var7jsodxtgzoz5t@sigill.intra.peff.net>
 <874lqxu0fw.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lqxu0fw.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 07:52:03PM +0200, Andreas Schwab wrote:

> > Yes, it's in that step, but xmlto is just driving the xslt
> > transformation done by docbook. So the interesting version is probably
> > docbook. I have docbook-xsl 1.79.1+dfsg-2 (from Debian unstable).
> 
> docbook-xsl-stylesheets-1.78.1+svn9743

Hmm. That could be it, though I was unable to bisect on the docbook repo
since I couldn't get their build to work reliably.

One other thing to try:

  rm git-branch.1
  make NO_MAN_BOLD_LITERAL=1 git-branch.1

It's possible our snippet to add in the bolding causes problems.

-Peff
