Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98AB820986
	for <e@80x24.org>; Fri,  7 Oct 2016 12:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbcJGMmH (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 08:42:07 -0400
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:48416 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbcJGMmG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 08:42:06 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bsUTP-0001kI-Rg; Fri, 07 Oct 2016 14:41:59 +0200
Date:   Fri, 7 Oct 2016 14:41:58 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv3 1/2] push: change submodule default to check when
 submodules exist
Message-ID: <20161007124157.GA61543@book.hvoigt.net>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
 <20161004210359.15266-1-sbeller@google.com>
 <20161005135325.GC30930@book.hvoigt.net>
 <20161006092332.GB38550@book.hvoigt.net>
 <CAGZ79ka=bVX51wrSiz4u7xOy+54t+v7a-iU5dHtQoNnB7-NAkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka=bVX51wrSiz4u7xOy+54t+v7a-iU5dHtQoNnB7-NAkw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 10:20:16AM -0700, Stefan Beller wrote:
> On Thu, Oct 6, 2016 at 2:23 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Wed, Oct 05, 2016 at 03:53:25PM +0200, Heiko Voigt wrote:
> >> On Tue, Oct 04, 2016 at 02:03:58PM -0700, Stefan Beller wrote:
> >> > Jeff,
> >> > thanks for the suggestions, both git_path(..) as well as checking the config,
> >> > this seems quite readable to me:
> >>
> >> When reading the discussion I thought the same: What about the
> >> "old-style" repositories. I like this one. Checking both locations
> >> is nice.
> >
> > BTW, since it seems we all agree on the direction. Should we add some
> > tests?
> >
> 
> Good call. What do we want to test for?
> * Correctness in case of submodules? (just push and get rejected)
>   I think that is easy to do.
> * Performance with [no, lots of] submodules? That seems harder to me.
> 
> I'll add a test for the correctness part and resend.

Well I though about the following tests:

 * Without submodules: Make sure submodule processing is disabled by
   default
 * With new-style submodules: Make sure submodules are processed by
   default
 * With old-style submodules: Make sure submodules are processed by
   default

But I have to admit that I did not think about the "how can we do that".
But performance seems to be the only thing that is exposing the
processing when we have no submodules, so it seems we can only easily do
the tests with submodules.

Cheers Heiko
