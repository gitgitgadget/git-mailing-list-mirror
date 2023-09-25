Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0631FCE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjIYMMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:12:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C1DF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:11:58 -0700 (PDT)
Received: (qmail 4979 invoked by uid 109); 25 Sep 2023 12:11:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 12:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12664 invoked by uid 111); 25 Sep 2023 12:11:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 08:11:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 08:11:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
Message-ID: <20230925121157.GB1623701@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
 <20230923070019.GD1469941@coredump.intra.peff.net>
 <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 01:52:47PM +0200, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Sat, 23 Sep 2023, Jeff King wrote:
> 
> > On Fri, Sep 22, 2023 at 10:42:00AM +0000, Johannes Schindelin via GitGitGadget wrote:
> >
> > > +# By default, the builds are submitted to the Coverity project `git`. To override this,
> > > +# set the repository variable `COVERITY_PROJECT`.
> >
> > This may not matter all that much, because I don't expect most people to
> > set this up for their forks
> 
> Except, of course, Git for Windows. And that has been the entire
> motivation for me to work on this here patch series in the first place, so
> it would be rather pointless if I could not override this in the
> git-for-windows/git fork.

I didn't at all mean that it should not be possible to override it. It
was obvious to me you would want to do so for git-for-windows. I meant
that the default should be $user/$fork from the Actions environment,
rather than just "git". That would be a more appropriate default for
people who wanted to run this out of their forks (but again, the part
you quoted above is basically "I'm not sure anybody even wants to do
that").

> Of course, I could address this differently. I could add a commit on top
> and rebase that all the time. I'd just as well avoid that though. There is
> already too much stuff in the Git for Windows fork that I have to rebase
> so often.
> 
> Based on your response, I was on my way to enhance the commit message
> accordingly, but then I saw this already being there:
> 
> 	The Git for Windows project would like to use this workflow, too,
> 	though, and needs the builds to be submitted to the
> 	`git-for-windows` Coverity project.
> 
> Would you have any suggestion how that could make the motivation and
> intention of this patch clearer?

I understood your intention. I think you misunderstood mine. :) The
commit message is fine as-is, I think.

-Peff
