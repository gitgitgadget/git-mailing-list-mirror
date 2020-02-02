Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8BCC35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 21:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350F520679
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBBVmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:42:45 -0500
Received: from ikke.info ([178.21.113.177]:57784 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBVmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 16:42:45 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 00F5D4400DC; Sun,  2 Feb 2020 22:42:43 +0100 (CET)
Date:   Sun, 2 Feb 2020 22:42:43 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Subject: Re: git log FILE vs git log --follow FILE missing commits
Message-ID: <20200202214243.GA1090206@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
References: <CAFOYHZAx-MM26AuJmscK=kGgukQ62vkyqAqU49U-5WRaTp4mGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFOYHZAx-MM26AuJmscK=kGgukQ62vkyqAqU49U-5WRaTp4mGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 10:27:52AM +1300, Chris Packham wrote:
> Hi,
> 
> I've just hit a problem where git log doesn't want to tell me about a
> commit that touches a specific file.
> 
> I wanted to point someone at a particular change that I knew was made
> to a file so I fired up 'git log FILE' and to my surprise it wasn't
> listed. I wondered if I had remembered wrong so went grepping to
> confirm the change was in the file I thought it was, sure enough it
> was there.
> 
> Poking around a bit I found that git log --follow FILE shows the
> intended commit but git log FILE doesn't (it does show other commits
> that touch the file, most of which have tags if that's significant).
> The file hasn't been renamed so I didn't really expect --follow to
> change any behavior.
> 
> The version of git I'm using is 2.25.0 from
> http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main. I also tried
> 2.24.1 and 2.23.1 with the same problem.
> 
> Any suggestions for tracking this down?
> 
> Thanks,
> Chris

Hey Chris,

Try `git log --full-history FILE`. When passing a path to `git log` will
enable history simplification, which might explain why certain commits
are not shown.

Kind regards, Kevin.
