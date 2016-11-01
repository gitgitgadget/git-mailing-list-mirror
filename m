Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C3F20229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbcKAVDT (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:03:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:37209 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752855AbcKAVDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:03:18 -0400
Received: (qmail 25050 invoked by uid 109); 1 Nov 2016 21:03:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 21:03:13 +0000
Received: (qmail 29979 invoked by uid 111); 1 Nov 2016 21:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 17:03:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 17:03:10 -0400
Date:   Tue, 1 Nov 2016 17:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     "Halde, Faiz" <fhalde@paypal.com>, git@vger.kernel.org
Subject: Re: Git issue
Message-ID: <20161101210310.sqrhvviry7iyyjrm@sigill.intra.peff.net>
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
 <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net>
 <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 08:50:23PM -0000, Philip Oakley wrote:

> > From "git help update-index":
> > 
> >      --[no-]assume-unchanged
> >    When this flag is specified, the object names recorded for
> >    the paths are not updated. Instead, this option sets/unsets
> >    the "assume unchanged" bit for the paths. When the "assume
> >    unchanged" bit is on, the user promises not to change the
> >    file and allows Git to assume that the working tree file
> >    matches what is recorded in the index. If you want to change
> >    the working tree file, you need to unset the bit to tell Git.
> >    This is sometimes helpful when working with a big project on
> >    a filesystem that has very slow lstat(2) system call (e.g.
> >    cifs).
> > 
> >    Git will fail (gracefully) in case it needs to modify this
> >    file in the index e.g. when merging in a commit; thus, in
> >    case the assumed-untracked file is changed upstream, you will
> >    need to handle the situation manually.
> > 
> 
> The whole section (including the ones above this quote) are often confused
> between the promises of the user, and the alleged promises of Git. Even in
> the quote above the "Instead" probably shouldn't be there.

I think the "Instead" is "we are not doing the usual update-index thing
of reading the new data from disk; instead, we are _just_ setting the
bit". Perhaps that can be spelled out more clearly, but I think just
dropping "Instead" is a step backwards.

> Given the number of misrepresentations (on the web) of what the bit does,
> and the ongoing misunderstandings of users it does feel like the man page
> article could be refreshed to be more assertive about the users promise, and
> Git's cautions.

I dunno. I know this has long been a source of confusion, but I
specifically dug in the docs to see what we had, and I thought what I
quoted above was pretty clear. That has "only" been around for about 2
years, and is fighting against other mis-advice on the Internet, though.
So I'm not sure if it is badly worded, or if people simply do not see
it.

-Peff
