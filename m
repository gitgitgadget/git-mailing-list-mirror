Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04AB1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEOBxe (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:53:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:57794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726174AbfEOBxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:53:33 -0400
Received: (qmail 14178 invoked by uid 109); 15 May 2019 01:53:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 May 2019 01:53:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18551 invoked by uid 111); 15 May 2019 01:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 21:54:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 21:53:31 -0400
Date:   Tue, 14 May 2019 21:53:31 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git.c: show usage for accessing the git(1) help page
Message-ID: <20190515015331.GC13255@sigill.intra.peff.net>
References: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
 <20190514152450.15220-1-philipoakley@iee.org>
 <20190515001717.GA138048@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515001717.GA138048@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 05:17:17PM -0700, Emily Shaffer wrote:

> >  const char git_more_info_string[] =
> >  	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
> >  	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
> > -	   "to read about a specific subcommand or concept.");
> > +	   "to read about a specific subcommand or concept. Or use 'git help git'.");
> 
> I'm not sure the wording makes sense here. It sounds like you're saying,
> "Or use 'git help git' to read about specific subcommands or concepts."
> which isn't really what I think you're trying to say.
> 
> What about, "Or, use 'git help git' for a detailed guide of the Git
> system as a whole."

I had a similar reaction on reading Philip's patch. I think your
suggestion is better. We could even shorten it to just:

  Use 'git help git' for an overview of the system.

Looking at "git help git" I actually think the DESCRIPTION section could
do a better job of being a first entry-point for new readers of the
documentation. But I don't think that needs to be a blocker for what
we're discussing here.

> (I'm still not sure that's quite it - since `git help git` mostly
> details the flags you can pass to git before invoking a subcommand. But
> I'm not sure that `git --help` is the place to say that...)

Yeah, I almost suggested something like:

  Use 'git help git' for options and environment variables that affect
  all subcommands.

I'm not sure if that points people in a useful direction, or if it is
getting too much into the weeds (again, probably the description section
of git(1) could talk about how to find which documentation where.

I also think it should point to git-scm.com for the hyper-linked
documentation, since it's less ugly than the stuff at git.github.io, but
that's really getting off-topic. :)

-Peff
