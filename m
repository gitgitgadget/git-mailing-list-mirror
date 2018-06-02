Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202941F491
	for <e@80x24.org>; Sat,  2 Jun 2018 09:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeFBJ0H (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 05:26:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:60050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750821AbeFBJ0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 05:26:07 -0400
Received: (qmail 4529 invoked by uid 109); 2 Jun 2018 09:26:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Jun 2018 09:26:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31181 invoked by uid 111); 2 Jun 2018 09:26:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 02 Jun 2018 05:26:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2018 05:26:05 -0400
Date:   Sat, 2 Jun 2018 05:26:05 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
Message-ID: <20180602092604.GC3200@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
 <20180601210731.GA20974@sigill.intra.peff.net>
 <alpine.LFD.2.21.1806020448030.24235@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1806020448030.24235@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 02, 2018 at 04:50:57AM -0400, Robert P. J. Day wrote:

> On Fri, 1 Jun 2018, Jeff King wrote:
> 
> > On Fri, Jun 01, 2018 at 04:14:12PM -0400, Robert P. J. Day wrote:
> >
> > >   $ git config --global a.b.c.d.e rday
> > >
> > > huh ... seemed to work fine, and added this to my ~/.gitconfig:
> > >
> > >   [a "b.c.d"]
> > >           e = rday
> > >
> > > as i see it, the first component is intgerpreted as the section
> > > name, the last component is the variable/key(?) name, and
> > > everything in between is treated as subsection(s), which is not at
> > > all obvious from that Doc file, or from "man git-config".
> >
> > Yep, your understanding is correct.
> 
>   just to be precise regarding terminology, in my example above, is
> "b.c.d" a single subsection, or does it refer to three subsections?
> i'm guessing it refers to a single subsection, which is fine with me,
> as long as it's very clearly explained that way in the docs.

It's a single subsection. Each config key at most one subsection.

-Peff
