Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C64E208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbdHJRdb (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:33:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:34644 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752597AbdHJRda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:33:30 -0400
Received: (qmail 18491 invoked by uid 109); 10 Aug 2017 17:33:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 17:33:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6276 invoked by uid 111); 10 Aug 2017 17:33:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 13:33:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 13:33:28 -0400
Date:   Thu, 10 Aug 2017 13:33:28 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
Message-ID: <20170810173328.xfrswan6tijwkaex@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
 <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
 <20170810073239.ny64rqmwb3yqbpb6@sigill.intra.peff.net>
 <CAGZ79kYHPhaZLSsBq2vM=D+_QMP9MY=xYjRwfG5q36neFyNH3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYHPhaZLSsBq2vM=D+_QMP9MY=xYjRwfG5q36neFyNH3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 10:27:19AM -0700, Stefan Beller wrote:

> > I'm not fond of that, as it's vague about which exact trailers we're
> > talking about. I also thought of something like --verbatim, but I'd
> > worry that would seem to conflict with --normalize.
> >
> > I dunno. All of the names seem not quite descriptive enough to me.
> 
> I meant 'exact' as in 'exactly from the patch/commit, no external
> influence such as config', so maybe '--from-patch' or '--from-commit'
> (which says the same as --no-config just the other way round.
> Having --no- in config options as the standard is a UX disaster
> IMHO as then we have to forbid the --no-no-X or reintroduce X
> and flip the default)

Yes, that was definitely the other reason I didn't want to call it
"--no-config".  :)

It's not always from a patch or commit. The most accurate along those
lines is "--from-input". 

> Maybe --genuine ?

But in the greater context I think that's vague again; we don't know
which part of the command's operation is "genuine".

Perhaps "--exact-input" hits all of those. Or maybe "--only-input" to
match the other "--only".

I think I like that last one the best. It makes it clear that we are
looking just at the input, and not anything else. Which is exactly what
the feature does.

-Peff
