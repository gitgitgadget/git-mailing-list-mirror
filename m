Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A6FC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4920715
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 10:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUKyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:54:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:56890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726014AbfKUKyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 05:54:15 -0500
Received: (qmail 11976 invoked by uid 109); 21 Nov 2019 10:54:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Nov 2019 10:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10062 invoked by uid 111); 21 Nov 2019 10:58:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2019 05:58:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Nov 2019 05:54:14 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
Message-ID: <20191121105414.GA16238@sigill.intra.peff.net>
References: <20191109020037.GB60198@google.com>
 <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
 <20191113011020.GB20431@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
 <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 07:37:57PM +0100, Johannes Schindelin wrote:

> Yeah, it wasn't easy. But then, who does not like a little challenge,
> especially the challenge to test things outside of production? So here
> is a PR: https://github.com/gitgitgadget/gitgitgadget/pull/148
> 
> I trust everybody with even rudimentary Javascript skills to be able to
> provide useful feedback on that PR.

Wow, thanks for working on this! I don't know that I'd call my
javascript skills even rudimentary, but I did give it a look. The real
challenge to me is not the individual lines of code, but understanding
how the Azure Pipelines and GitHub App systems fit together. So I didn't
see anything wrong, but I also know very little about those systems.

Likewise, the explanations in your comments and commit messages all made
sense to me. But that may also be a false sense of security. You nicely
led me through reading the patches, but the likely bug would probably be
one you did not even anticipate. ;)

> To build some confidence in my patches (as you probably know, I do not
> trust reviews as much as I trust real-life testing, although I do prefer
> to have both) I "kind of" activated it on my fork, limited to act only
> on comments _I_ made on PRs (and sending only to me instead of the
> list), and it seems to work all right, so far. I cannot say for sure
> whether it handles the PR labels correctly, but I guess time will tell,
> and I will fix bugs as quickly as I can.

Yeah, that makes sense to me. Going from one repo to three is not much
worse than going to two, so it's good to have a testing area, too.

Do you want any third-party testing there (e.g., a user who isn't you
making a PR against dscho/git)?

> Question is: should I turn this thing on? I.e. install that
> GitGitGadget-Git App on https://github.com/git/git? This would allow
> GitHub users to `/submit` directly from PRs opened in that repository. I
> am sure that there are a few kinks to work out, but I do think that it
> should not take long to stabilize.

I'd say "yes". The status quo is probably worse than a system with a few
bugs. The worst case if it's disastrously wasting submitter's time is
that we turn it back off, but I have faith that you'd just fix the bugs
before then anyway.

Is the existing Pipelines integration enough for you to turn it on for
git/git, or do I need to tweak any settings?

-Peff
