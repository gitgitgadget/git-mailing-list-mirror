Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4D71FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 09:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932988AbcLIJLc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 04:11:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:54064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932469AbcLIJLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 04:11:31 -0500
Received: (qmail 13381 invoked by uid 109); 9 Dec 2016 09:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 09:11:29 +0000
Received: (qmail 16665 invoked by uid 111); 9 Dec 2016 09:12:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 04:12:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 04:11:27 -0500
Date:   Fri, 9 Dec 2016 04:11:27 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Subject: Re: Any interest in 'git merge --continue' as a command
Message-ID: <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 08:57:58PM +1300, Chris Packham wrote:

> I hit this at $dayjob recently.
> 
> A developer had got themselves into a confused state when needing to
> resolve a merge conflict.
> 
> They knew about git rebase --continue (and git am and git cherry-pick)
> but they were unsure how to "continue" a merge (it didn't help that
> the advice saying to use 'git commit' was scrolling off the top of the
> terminal). I know that using 'git commit' has been the standard way to
> complete a merge but given other commands have a --continue should
> merge have it as well?

It seems like that would be in line with 35d2fffdb (Provide 'git merge
--abort' as a synonym to 'git reset --merge', 2010-11-09), whose stated
goal was providing consistency with other multi-command operations.

I assume it would _just_ run a vanilla "git commit", and not try to do
any trickery with updating the index (which could be disastrous).

-Peff
