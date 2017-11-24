Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7375D20954
	for <e@80x24.org>; Fri, 24 Nov 2017 10:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdKXKkq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 05:40:46 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:40086 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdKXKkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 05:40:45 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:33462 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eIBPY-0005J0-Dm; Fri, 24 Nov 2017 05:40:44 -0500
Date:   Fri, 24 Nov 2017 05:39:14 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] doc: tweak "man gitcli" for clarity
In-Reply-To: <xmqqd148p8v4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711240536390.4054@DESKTOP-1GPMCEJ>
References: <alpine.LFD.2.21.1711220701070.12544@DESKTOP-1GPMCEJ> <xmqqd148p8v4.fsf@gitster.mtv.corp.google.com>
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

On Fri, 24 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > -This manual describes the convention used throughout Git CLI.
> > +This manual describes the conventions used throughout Git CLI.
>
> OK.
>
> >  Many commands take revisions (most often "commits", but sometimes
> >  "tree-ish", depending on the context and command) and paths as their
> > @@ -32,32 +32,35 @@ arguments.  Here are the rules:
> >     between the HEAD commit and the work tree as a whole".  You can say
> >     `git diff HEAD --` to ask for the latter.
> >
> > - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> > -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> > -   file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
> > + * In cases where a Git command is truly ambiguous, Git will error out
> > +   and ask you to disambiguate the command.  E.g. if you have a file
> > +   called HEAD in your work tree, `git diff HEAD` is ambiguous, and
> >     you have to say either `git diff HEAD --` or `git diff -- HEAD` to
> >     disambiguate.
> >  +
> >  When writing a script that is expected to handle random user-input, it is
> >  a good practice to make it explicit which arguments are which by placing
> > -disambiguating `--` at appropriate places.
> > +a disambiguating `--` at appropriate places.
>
> The above "truly" is misleading by giving the information the other
> way around.  We ask to disambiguate when we cannot readily say the
> command line is *not* unambiguous.  That is different from asking
> when we know it is truly ambiguous.
>
> Also see <xmqq7eugqykq.fsf@gitster.mtv.corp.google.com> if you want
> to know more.

  ... snip ...

  at this point, i would throw out *all* of this and, rather than try
to cram disambiguation into the bullet lists currently in that man
page, just break it out into its own section, where it can be
explained properly and comprehensively.

  the reason this has gotten so chaotic is that we're trying to
preserve the structure that is in that man page, when it should just
be tossed and rewritten to give "--" and disambiguation the section it
deserves.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
