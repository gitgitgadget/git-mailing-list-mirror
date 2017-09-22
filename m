Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B099E202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 21:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdIVVZ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:25:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:47538 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752071AbdIVVZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:25:27 -0400
Received: (qmail 6273 invoked by uid 109); 22 Sep 2017 21:25:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 21:25:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9107 invoked by uid 111); 22 Sep 2017 21:26:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 17:26:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 17:25:25 -0400
Date:   Fri, 22 Sep 2017 17:25:25 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170922212525.kxldygbjrmjqu7ci@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
 <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
 <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 01:09:32PM -0700, Stefan Beller wrote:

> On Thu, Sep 21, 2017 at 9:25 PM, Jeff King <peff@peff.net> wrote:
> 
> >
> > But imagine that "git status" learns to recurse into submodules and run
> > "git status" inside them. Surely we would want the submodule repos to
> > also avoid taking any unnecessary locks?
> 
> You can teach Git to recurse into submodules already at home,
> just 'git config status.submoduleSummary none'. ;)
> 
> It occurs to me that the config name is badly choosen, as it stores
> an argument for git status --ignore-submodules[=mode]

Ah, thanks. I _thought_ we could already do that but when I went looking
for the standard --recursive option I couldn't find it.

So yes, I would think we would want this option to apply recursively in
that case, even when we cross repository boundaries.

-Peff
