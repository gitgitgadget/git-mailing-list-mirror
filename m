Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B341F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeGRUAs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:00:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729221AbeGRUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:00:48 -0400
Received: (qmail 14379 invoked by uid 109); 18 Jul 2018 19:21:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 19:21:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2226 invoked by uid 111); 18 Jul 2018 19:21:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 15:21:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 15:21:28 -0400
Date:   Wed, 18 Jul 2018 15:21:28 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
Message-ID: <20180718192128.GB7778@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <20180716161821.GB18150@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807181420250.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807181420250.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 02:23:11PM +0200, Johannes Schindelin wrote:

> > Yeah, they're out of order in mutt's threaded display. And the
> > back-dating means there's a much higher chance of them getting blocked
> > as spam (e.g., some of the dates are from weeks ago).
> > 
> > git-send-email uses the current time minus an offset, and then
> > monotonically increases for each patch:
> > 
> >   $time = time - scalar $#files;
> >   ...
> >   my $date = format_2822_time($time++);
> > 
> > which seems to work pretty well in practice. It does mean the original
> > dates are lost. The committer date is not interesting at all (there will
> > be a new committer via "git am" anyway). The original author date is
> > potentially of interest, but could be included as an in-body header.
> > AFAIK send-email doesn't have such an option, though, and people are
> > fine with date-of-sending becoming the new author date.
> > 
> > +cc Johannes as the GitGitGadget author
> 
> Thanks for dumping even more work on my shoulders.

Wow. Here's my perspective on what I wrote.

Somebody pointed out an issue in the tool. I tried to add an additional
data point (how other clients react, and that I've seen spam-related
problems). And I tried to point to an existing solution in another tool,
in case that was helpful. I thought cc-ing you would be a favor, since
you obviously have an interest in the tool, and it is easy to miss
discussions buried deep in a thread.

So no, I didn't write the patch for you. But I tried to contribute
positively to the process. And I got yelled at for it. That makes me a
lot less inclined to try to help in the future.

> Next time, I will ask you to jump in, instead of putting the onus on me.
>
> I mean, seriously, what is this? "You can use *any* mail program to work
> with the Git mailing list, *any* mailer. As long as it is mutt. And as
> long as you spend hours and hours on tooling that oh BTW nobody else can
> use."

The irony here is that I actually _did_ look at the GitGitGadget
repository, and thought about making a patch to be helpful. But as it is
written in a language I'm not all that familiar with, using tools that I
don't normally use, I didn't want to spend hours and hours in order to
make what was probably going to be a one-line patch in software that I
don't use myself.

-Peff
