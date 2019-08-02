Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9079A1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 18:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406825AbfHBSim (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 14:38:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:60722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2405915AbfHBSim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 14:38:42 -0400
Received: (qmail 10793 invoked by uid 109); 2 Aug 2019 18:38:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Aug 2019 18:38:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9194 invoked by uid 111); 2 Aug 2019 18:40:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Aug 2019 14:40:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Aug 2019 14:38:41 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/early-config-with-onbranch, was Re: What's cooking in git.git
 (Aug 2019, #01; Thu, 1)
Message-ID: <20190802183840.GB26918@sigill.intra.peff.net>
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
 <20190801214247.GB30522@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1908021410540.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908021410540.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 02:12:34PM +0200, Johannes Schindelin wrote:

> > > * js/early-config-with-onbranch (2019-07-31) 1 commit
> > >   (merged to 'next' on 2019-08-01 at 26b713c824)
> > >  + config: work around bug with includeif:onbranch and early config
> > >
> > >  The recently added [includeif "onbranch:branch"] feature does not
> > >  work well with an early config mechanism, as it attempts to find
> > >  out what branch we are on before we even haven't located the git
> > >  repository.  The inclusion during early config scan is ignored to
> > >  work around this issue.
> > >
> > >  Will merge to 'master'.
> >
> > I had some open comments here on how the "do we have a repo" check is
> > done, but I think what is committed here is functionally equivalent. I
> > can pursue the NULL the_repository cleanups separately.
> 
> Right, I read that as "maybe later" comments, as that project is so
> different from trying to fix the `onbranch` feature with regards to the
> early config machinery.
> 
> Or did I misread and you want me to do anything about it before v2.23.0?

I think when I wrote my original replies in the thread that I wasn't
sure _what_ I wanted. :) I had originally hoped to convince you to
switch to have_git_dir() now, but I do agree after investigating that it
would require an extra patch to common-main.

Mostly I was just trying to clarify here that my comments were not
blockers for merging this; I couldn't find any case where your patch
as-is would behave incorrectly.

-Peff
