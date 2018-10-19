Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22761F453
	for <e@80x24.org>; Fri, 19 Oct 2018 19:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeJTDLj (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 23:11:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:46828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727526AbeJTDLj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 23:11:39 -0400
Received: (qmail 31169 invoked by uid 109); 19 Oct 2018 19:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 19:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14271 invoked by uid 111); 19 Oct 2018 19:03:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 15:03:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 15:04:16 -0400
Date:   Fri, 19 Oct 2018 15:04:16 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: unused parameters in merge-recursive.c
Message-ID: <20181019190416.GB24418@sigill.intra.peff.net>
References: <20181019171827.GA21091@sigill.intra.peff.net>
 <CABPp-BHobf8wbBsXF97scNQCzkxQukziODRXq6JOOWq61cAd9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHobf8wbBsXF97scNQCzkxQukziODRXq6JOOWq61cAd9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 10:58:19AM -0700, Elijah Newren wrote:

> > In most cases I've been trying to determine the "bug versus cruft" thing
> > myself, but I fear that merge-recursive exceeds my abilities here. ;)
> 
> These ones all look like cruft to me.  I dug through them and tried
> looking through history and old submissions for my guesses and how
> they ended up here; details below.

Good, that makes things easier. :)

> >  static int handle_rename_via_dir(struct merge_options *o,
> >                                  struct diff_filepair *pair,
> > -                                const char *rename_branch,
> > -                                const char *other_branch)
> > +                                const char *rename_branch)
> 
> Given the similarity in function signature to handle_rename_delete(),
> it's possible I copied the function and then started editing.  Whether
> I was lazily doing that, or if I really added that parameter because I
> thought I was going to add an informational message to the user that
> used it, or something else, I don't know.  But I agree, it's just not
> needed and could be added back later if someone did find a use for it.

Yeah, this was the one I was most worried about.

Thanks for confirming. I'm preparing a bunch of similar cleanups, so
I'll roll this into that series.

-Peff
