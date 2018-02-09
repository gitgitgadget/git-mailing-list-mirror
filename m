Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319C41F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbeBITvz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:51:55 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:50357 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBITvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:51:54 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:47380 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ekEi9-0001Qw-KK; Fri, 09 Feb 2018 14:51:53 -0500
Date:   Fri, 9 Feb 2018 14:51:51 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: totally confused as to what "git bisect skip" is supposed to
 do
In-Reply-To: <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1802091447540.14489@localhost.localdomain>
References: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain> <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com>
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

On Fri, 9 Feb 2018, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   i'm confused ... why, after skipping a good chunk in the
> > interval [v4.13,v4.14], do i still have exactly 7300 revisions to
> > bisect? what am i so hopelessly misunderstanding here?
>
> Are you really "skipping" a chunk in the interval?

  i don't know ... am i? how should i interpret the man page?

> I thought that "git bisect skip" is a way for you to respond, when
> "git bisect" gave you a commit to test, saying "sorry, I cannot test
> that exact version, please offer me something else to test".  And
> each time you say that, you are not narrowing the search space in
> any way, so it is understandable that the number of candidate bad
> commits will not decrease.

  i caught that part of the man page, but i'm trying to understand
what i'm reading here:

https://blog.smart.ly/2015/02/03/git-bisect-debugging-with-feature-branches/

  particularly this suggestion:

  $ git bisect start master 75369f4a4c026772242368d870872562a3b693cb

  $ for rev in $(git rev-list
    75369f4a4c026772242368d870872562a3b693cb..master --merges
    --first-parent); do
    >   git rev-list $rev^2 --not $rev^
    > done | xargs git bisect skip

my interpretation of that page is how, after starting a bisection, one
can use "git bisect skip" to explicitly disqualify a sizable number of
commits from consideration, speeding up the subsequent bisection.

  if that's not what that web page is describing, then what *is* it
talking about?

rday
