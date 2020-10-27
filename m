Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E11C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B558722264
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507640AbgJ0H0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:26:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:38298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507638AbgJ0H0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:26:49 -0400
Received: (qmail 14354 invoked by uid 109); 27 Oct 2020 07:26:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:26:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15106 invoked by uid 111); 27 Oct 2020 07:26:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:26:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:26:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
Message-ID: <20201027072648.GG3005508@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
 <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
 <20201023081711.GB4012156@coredump.intra.peff.net>
 <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
 <20201026225300.GA23128@coredump.intra.peff.net>
 <xmqqo8kod0ms.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8kod0ms.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 04:32:27PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Definitely a "NOTES" section should go in that spot, but possibly the
> > text should be in the "DESCRIPTION" section. I was worried about
> > cluttering that early part with a detail that most people wouldn't care
> > too much about.
> >
> > Looks like my patch is in 'next'; do you want to propose a patch moving
> > it around on top?
> 
> It probably is possible to tweak the introductory text this way
> without being unnecessarily loud and keep the NOTES section where it
> is.
> [...]
>  DESCRIPTION
>  -----------
>  
> -A `gitattributes` file is a simple text file that gives
> -`attributes` to pathnames.
> +A `gitattributes` file is a simple text file (it cannot be a
> +symbolic link to anything) that gives `attributes` to pathnames.

I worried that even a short mention like this would be distracting. Not
because it's so long, but because it's right there in the very first
sentence, and I really think this is a corner case that most people
would not even think about.

So it is helpful if you are looking for info on symlinks and these
files, but probably clutter if you are looking for something else.

I have to admit I don't feel all that strongly either way, though.

-Peff
