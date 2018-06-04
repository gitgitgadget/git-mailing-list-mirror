Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B621F403
	for <e@80x24.org>; Mon,  4 Jun 2018 12:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFDMJU (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 08:09:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:33170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750868AbeFDMJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 08:09:19 -0400
Received: (qmail 19001 invoked by uid 109); 4 Jun 2018 12:09:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 12:09:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13289 invoked by uid 111); 4 Jun 2018 12:09:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 08:09:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 08:09:17 -0400
Date:   Mon, 4 Jun 2018 08:09:17 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
Message-ID: <20180604120917.GA22371@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
 <20180601210731.GA20974@sigill.intra.peff.net>
 <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain>
 <20180603103510.21020-1-szeder.dev@gmail.com>
 <alpine.LFD.2.21.1806030634200.8966@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1806030634200.8966@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 06:35:44AM -0400, Robert P. J. Day wrote:

> > >   if (for some weird reason) i wanted to define a multi-level
> > > subsection,
> >
> > You can't, there are no multi-level subsections, see above.
> 
>   no, i *get* that, what i was asking was if i wanted to simulate or
> emulate such a thing ... or is that just getting too weird and there
> is no compelling reason to want to go down that road? (which i am
> totally prepared to accept.)

You can do whatever you like with the subsection; its contents are
generally dependent on the semantics of the key. E.g.,
remote.<remotename>.*, branch.<branchname>.*. That's why Git tries to be
permissive with the syntax.

So you are free to consider "foo.a.b.c.key" as some kind of multi-level
hierarchy if that's useful to you. But you won't get any tool support
from Git, and I don't think there is any compelling reason to use "."
versus some other syntax (except that it perhaps looks better to the
user).

-Peff
