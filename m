Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F95220986
	for <e@80x24.org>; Sun,  9 Oct 2016 06:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbcJIGvQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 02:51:16 -0400
Received: from ikke.info ([178.21.113.177]:39636 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbcJIGvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 02:51:15 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 1FD8A4401D4; Sun,  9 Oct 2016 08:50:46 +0200 (CEST)
Date:   Sun, 9 Oct 2016 08:50:46 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Michael Tutty <mtutty@gforgegroup.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug? git worktree fails with master on bare repo
Message-ID: <20161009065046.GD25613@ikke.info>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 08, 2016 at 07:30:36PM -0500, Michael Tutty wrote:
> Hey all,
> I'm working on some server-side software to do a merge. By using git
> worktree it's possible to check out a given branch for a bare repo and
> merge another branch into it. It's very fast, even with large
> repositories.
> 
> The only exception seems to be merging to master. When I do git
> worktree add /tmp/path/to/worktree master I get an error:
> 
> [fatal: 'master' is already checked out at '/path/to/bare/repo']
> 
> But this is clearly not true, git worktree list gives:
> 
> [/path/to/bare/repo (bare)]
> 
> ...and of course, there is no work tree at that path, just the bare
> repo files you'd expect.

A bare repo still has a HEAD, which by default points to
refs/heads/master. That's what's it complaining about.

So the question is, should there be an exception for the branch 'checked
out' on a bare reposity.
