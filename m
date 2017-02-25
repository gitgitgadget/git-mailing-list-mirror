Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E9F20279
	for <e@80x24.org>; Sat, 25 Feb 2017 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbdBYIgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 03:36:25 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55167 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbdBYIgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 03:36:25 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v1P8aJ1B000558;
        Sat, 25 Feb 2017 09:36:19 +0100
Date:   Sat, 25 Feb 2017 09:36:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.12.0
Message-ID: <20170225083619.GA550@1wt.eu>
References: <xmqqd1e72xs5.fsf@gitster.mtv.corp.google.com>
 <20170225074057.GA460@1wt.eu>
 <xmqqefymzn6u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefymzn6u.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 12:31:21AM -0800, Junio C Hamano wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > Hi Junio,
> >
> > On Fri, Feb 24, 2017 at 11:28:58AM -0800, Junio C Hamano wrote:
> >>  * Use of an empty string that is used for 'everything matches' is
> >>    still warned and Git asks users to use a more explicit '.' for that
> >>    instead.  The hope is that existing users will not mind this
> >>    change, and eventually the warning can be turned into a hard error,
> >>    upgrading the deprecation into removal of this (mis)feature.  That
> >>    is not scheduled to happen in the upcoming release (yet).
> >
> > FWIW '.' is not equivalent to '' when it comes to grep or such commands,
> 
> I am amused and amazed ;-).  
> 
> The above is not about "grep" but was meant to describe "pathspec".
> We used to take "" as a pathspec element that means "every path
> matches", but recently started deprecating it and ask users to be
> more explicit by using "." (as a directory as a pathspec element
> matches everything inside the directory).  We are not changing the
> pattern matching done by "git grep" or "log --grep".  What is
> changing is that between the two that means the same thing:
> 
> 	cd t/ && git log ""
> 	cd t/ && git log .
> 
> the former is deprecated.

Ah that's fun indeed I never used it like this :-)

> I find it amusing that I have been writing the above in the draft
> release notes without realizing that I failed to say that it is
> about pathspec for quite some time, and without realizing that the
> above can be misinterpreted as if it is talking about grep patterns.
> 
> And I find it amazing that it took this long for somebody to spot
> that misleading vagueness in this description and point it out.
> 
> It should probably be updated to start like so:
> 
> 	Use of an empty string as a pathspec element that is used
> 	for 'everything matches' is ...

Hey it's the usual matter of perspective and context. When you know
what you do it's always obvious when you explain it while for others
something different is obvious :-)

Thanks for your clarification!
Willy
