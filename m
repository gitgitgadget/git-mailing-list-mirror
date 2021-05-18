Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B6AC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4375B611BD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbhERG5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:57:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:57396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235627AbhERG5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:57:14 -0400
Received: (qmail 10947 invoked by uid 109); 18 May 2021 06:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 06:55:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5213 invoked by uid 111); 18 May 2021 06:55:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 02:55:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 02:55:55 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Message-ID: <YKNk+5k3hKW/xPBZ@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
 <60a34a7616cda_14d1bc20818@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a34a7616cda_14d1bc20818@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 12:02:46AM -0500, Felipe Contreras wrote:

> > Why would people need to use "git remote set-head" most of the time? The
> > symlink is set up properly by git-clone, and has been for many years.
> 
> First instructions from GitHub:
> 
>   echo "# test" >> README.md
>   git init
>   git add README.md
>   git commit -m "first commit"
>   git branch -M main
>   git remote add origin git@github.com:felipec/test.git
>   git push -u origin main
> 
> Second instructions from GitHub:
> 
>   git remote add origin git@github.com:felipec/test.git
>   git branch -M main
>   git push -u origin main
> 
> None of these use `git clone`.

So? Here are some other instructions from GitHub[0]:

  Type git clone, and then paste the URL you copied earlier.

    $ git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY

[0] https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository

Not to mention that every single repository page mentions cloning under
the "Code" button (including the command-line "gh repo clone" if you are
using their recommended tool).

People clone a lot more than they create new repositories.

> Of 31 repositories I work on and have quickly at hand only 8 have
> origin/HEAD.

And of 141 repositories I have on my workstation, 137 have origin/HEAD
(and of the 4 without, one does not even have a remote at all, and one
is a git-svn repository).

I don't think that proves anything except that your workflow is
different than mine. But I contend that most people get repositories by
cloning them.

> And even *if* origin/HEAD did work on most repositories (hardly the
> case), most people are not going to train their fingers to type `git cmd
> $x` when the only $x where the command works is "origin"; they would
> rather train their fingers to do $x/master which works on many more
> repositories.

I guess I'm not most people, because I sure have enjoyed typing the
shorter thing all these years.

Look, I get that you didn't know or care about the "origin/HEAD" feature
until recently. But it's been part of Git for over 15 years, and has
been used as the documentation examples for revision ranges in both
git-rev-list(1) and gitrevisions(7), as well as the user-manual.

I'm perfectly happy to use placeholder ref names in the glossary
documentation, but it's not like the use of "origin" as a name is some
obscure secret.

-Peff
