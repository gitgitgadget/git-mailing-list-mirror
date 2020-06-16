Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DAC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F6220882
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgFPOOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:14:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgFPOOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:14:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0889DB0E6;
        Tue, 16 Jun 2020 14:14:47 +0000 (UTC)
Date:   Tue, 16 Jun 2020 16:14:41 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     John Turner <whinis@gmail.com>
Cc:     konstantin@linuxfoundation.org, Whinis@whinis.com,
        alexsmith@gmail.com, don@goodman-wilson.com, git@vger.kernel.org,
        gitster@pobox.com, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616141441.GH21462@kitsune.suse.cz>
References: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <834b0165-61c7-1313-6bc9-387d8a31ef76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834b0165-61c7-1313-6bc9-387d8a31ef76@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 09:55:29AM -0400, John Turner wrote:

> > 2. Branch naming is entirely the choice of individual repository
> >     maintainers. Some prefer not to have a "master" branch, and it's not
> >     simply because of "political correctness" reasons as everyone
> >     insists:
> >     - they may prefer to have "stable" and "development" branches
> >     - they may want to use localized names for all their naming
> >       conventions (using Cyrillic, Hanzi, Kana, whatever)
> >     - they may be goofing off (there's a furry-related repository on
> >       GitHub with the main branch called "yiffed")
> My understanding is you can already delete the master branch and force-push
> that. So back to this topic why does anything need to change?
And people indeed do that as this thread point out. Git can do better
supporting this use case. If people are willing to spend time on that
it's their call.
> 
> > 3. In your example, "millions and billions" of scripts are already wrong
> >     if they assume that there is always a "master" branch. However, it
> >     doesn't matter, because unless someone actively renames a branch in
> >     an existing repo that they work with, they will continue working just
> >     fine. Nobody is talking about banning the use of the word "master"
> >     for any existing branches. I am 100% certain that Linux mainline will
> >     continue to happen in refs/heads/master, because the fallout of
> >     renaming that would be terrible.
> They may be wrong but being while Git is not a central service is is used in
> millions of organizations and by millions of organizations through central
> services such as Github. Through this distributed use some things are
> assumed whenever creating new repositories and yes the master branch is one
> of these. Nearly every tutorial on Git or using get will reference the
> master branch and its is how many people learn. Its already been shown in
> the patch how these changes might break on existing repos due to assumption
> of the main/master/primary/<insert word here> branch is no longer what it
> used to be leading to a need to fix all configs on all repos. Also it has
> been pointed out how disconnects between configs between two different
> clones could lead to issues.
> 
> Requiring every organization or individual who uses Git to entirely retool
> due to changes in a base assumption is the exact opposite you want of any
> stable software. The claim that this only affects new repositories so its
> immaterial is an odd foot to stand on being that almost all of these scripts
> assume something about new repositories that will now be different.

Have you even read what the proposed change is?

It allows changing the name of the branch that is created by git init
using a configuration variable. Nothing else.

It is also proposed to change the default for this variable in a future
release of git that is expected to have far more disruptive changes,
such as different hash used for commit IDs.

Thanks

Michal
