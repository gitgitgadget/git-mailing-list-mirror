Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08834C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF84A20780
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394852AbgJZWxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:53:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:38004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394848AbgJZWxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 18:53:01 -0400
Received: (qmail 10775 invoked by uid 109); 26 Oct 2020 22:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Oct 2020 22:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12579 invoked by uid 111); 26 Oct 2020 22:53:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Oct 2020 18:53:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Oct 2020 18:53:00 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
Message-ID: <20201026225300.GA23128@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
 <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
 <20201023081711.GB4012156@coredump.intra.peff.net>
 <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 10:18:18PM +0000, Philip Oakley wrote:

> > +NOTES
> > +-----
> > +
> > +Note that Git does not allow the `.gitmodules` file within a working
> > +tree to be a symbolic link, and will refuse to check out such a tree
> > +entry. This keeps behavior consistent when the file is accessed from the
> > +index or a tree versus from the filesystem, and helps Git reliably
> > +enforce security checks of the file contents.
> >  
> >  EXAMPLES
> >  --------
> The text looks good to me, with security point explicitly mentioned just
> for .gitmodules file.
> 
> However, is placing the Note so far down appropriate (.gitattributes and
> .gitignore), given that there is within the descriptions a discussion of
> the priority order for finding those files?

Definitely a "NOTES" section should go in that spot, but possibly the
text should be in the "DESCRIPTION" section. I was worried about
cluttering that early part with a detail that most people wouldn't care
too much about.

Looks like my patch is in 'next'; do you want to propose a patch moving
it around on top?

-Peff
