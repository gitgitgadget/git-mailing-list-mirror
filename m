Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67FE2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdKUWNj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:13:39 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:60679 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdKUWNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:13:39 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38948 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHGnS-0002nZ-84; Tue, 21 Nov 2017 17:13:38 -0500
Date:   Tue, 21 Nov 2017 17:12:16 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Kevin Daudt <me@ikke.info>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
In-Reply-To: <20171121220409.GC16418@alpha.vpn.ikke.info>
Message-ID: <alpine.LFD.2.21.1711211711001.28430@localhost.localdomain>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain> <20171121214552.GB16418@alpha.vpn.ikke.info> <alpine.LFD.2.21.1711211646050.26665@localhost.localdomain> <20171121220409.GC16418@alpha.vpn.ikke.info>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Nov 2017, Kevin Daudt wrote:

> On Tue, Nov 21, 2017 at 04:47:42PM -0500, Robert P. J. Day wrote:
> > On Tue, 21 Nov 2017, Kevin Daudt wrote:
> >
> > > On Tue, Nov 21, 2017 at 04:27:59PM -0500, Robert P. J. Day wrote:
> > > > No major changes, just some rewording and showing some variations of
> > > > general Git commands.
> > > >
> > > > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > > >
> > > > ---
> > > >
> > > > diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> > > > index 9f13266a6..d690d1ff0 100644
> > > > --- a/Documentation/gitcli.txt
> > > > +++ b/Documentation/gitcli.txt
> > > > @@ -13,7 +13,7 @@ gitcli
> > > >  DESCRIPTION
> > > >  -----------
> > > >
> > > > -This manual describes the convention used throughout Git CLI.
> > > > +This manual describes the conventions used throughout Git CLI.
> > > >
> > > >  Many commands take revisions (most often "commits", but sometimes
> > > >  "tree-ish", depending on the context and command) and paths as their
> > > > @@ -32,32 +32,35 @@ arguments.  Here are the rules:
> > > >     between the HEAD commit and the work tree as a whole".  You can say
> > > >     `git diff HEAD --` to ask for the latter.
> > > >
> > > > - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> > > > -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> > > > + * Without a disambiguating `--`, Git makes a reasonable guess, but can
> > > > +   error out, asking you to disambiguate when ambiguous.  E.g. if you have a
> > >
> > > 'Can' error out implies that it sometimes would not error out when
> > > there is ambiguity. Are there situation where git does not error out
> > > in that case?
> >
> >   i would say (based on my limited knowledge) that if the heuristic
> > kicks in and works fine, then things will work. i think it's fair to
> > say that git "can" error out if the heuristic fails.
> >
> > rday
>
> In most cases that I'm aware of, you have to be explicit. If for
> example you want to refer to a file that's not in the working tree,
> you have to use '--'.  Even with heuristics, it would still have to
> error out when it's ambiguous what the user meant.
>
> So the way you worded it implies that there are situations where git
> knows there are multiple things the user could have meant, but it
> would not error out in that case.

  all right, i will ponder this ... open to suggestions. i would have
to examine the heuristic itself, wondering if it can make the wrong
decision on occasion.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
