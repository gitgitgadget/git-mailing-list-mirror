Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1D91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfBLAof (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:44:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:40990 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727317AbfBLAof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:44:35 -0500
Received: (qmail 20472 invoked by uid 109); 12 Feb 2019 00:44:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:44:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19748 invoked by uid 111); 12 Feb 2019 00:44:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:44:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:44:33 -0500
Date:   Mon, 11 Feb 2019 19:44:33 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190212004433.GJ13301@sigill.intra.peff.net>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190209140605.GE10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190209140605.GE10587@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 09, 2019 at 03:06:05PM +0100, SZEDER Gábor wrote:

> On Thu, Feb 07, 2019 at 10:17:44PM -0500, Todd Zullinger wrote:
> > Looking through the build logs for the fedora git packages, I noticed it
> > was missing the GPGSM prereq.
> 
> Just curious: how did you noticed the missing GPGSM prereq?
> 
> I'm asking because I use a patch for a good couple of months now that
> collects the prereqs missed by test cases and prints them at the end
> of 'make test'.  Its output looks like this:
> 
>   https://travis-ci.org/szeder/git/jobs/490944032#L2358
> 
> Since you seem to be interested in that sort of thing as well, perhaps
> it would be worth to have something like this in git.git?  It's just
> that I have been too wary of potentially annoying other contributors
> by adding (what might be perceived as) clutter to their 'make test'
> output :)

At first I thought your script found tests which _should_ have been
marked with a particular prereq but weren't. And I scratched my head
about how you would find that automatically. If we could, that would be
amazing. ;)

But it looks from the output like it just mentions every prereq that
wasn't satisfied. I don't think that's particularly useful to show for
all users, since most of them are platform things that cannot be changed
(and you'd never get the list to zero, since some of them are mutually
exclusive).

-Peff
