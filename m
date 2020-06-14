Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91360C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A4F2068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="leS0Ib9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgFOK7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:59:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:38111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbgFOK73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592218758;
        bh=sfWNVsMp1FidrwSxZUfr3APKOBWQCd5aLuvvuECLUws=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=leS0Ib9qeHnt17Wovv3OIM9h59rB6hJS0xcn+WrAOZkz2Uh6Mb1j16qGlIsbcg/uI
         H0NRQOdHawOx8VgqVztfkEvYn5vmfsjcqx1WzeEtoroiUkt478it9dBp0YODtyareR
         eWvTob/ViGOu6hbSnzcfTMqtlyoTRzGSMtwzjMCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([213.196.213.210]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1j8Aq83gXl-00qBE7; Mon, 15
 Jun 2020 12:59:17 +0200
Date:   Mon, 15 Jun 2020 00:26:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.2006150011360.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RQLNxVJhRf83hML95v/pv3bJ+xBKDp5w0n3yzBYBJ69Y44sz1Dv
 baEqwTyTrfRLBS4jYZYtaSdkwzOzvQpLYuDEkN6RI+TTdhd5NN3nJDm0P7eimshYz+lV9Ak
 l3VCexeGwyeEmmEupIbXu0AX0gnfos67NC4d5MMApL8JWcJnqK4gYm7YJhXqoTKgnClc68C
 hWbh/h0Y+uY63VD2ybDhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kx6H0/ln0/8=:RCR9UpCHrIcAJqSx7B0P/L
 3SrpuH+ghyDuhBoQeanCc2ZtOIJ/6DKwKkf1JC2JLKPEv5sgeRVKwUgrvB308mYeqRHIfKaMy
 qVLEyZyh2CFTTb7JD2/eTkZSMRkQ8iGkSKRBGlcHn0JdwBwQggG9kJFku4qvlANJx3GH+SX2H
 f2nrL33fXpEJarbkkiAk2+m9eBIbAyaHwJYF2i7+pmqh10m4v9KPtPov2fnJWVCgFF3VHofGZ
 tY84r9E1yCJh8NGrZT8Ywq5k7yV0iX21n/ijJKNArjU868HaNMZCP8GLmo9fvJPMcQENq4BNa
 n4dlSUbLTyv6BcXDitbSfsuNjsP+NNOJvFs7ohbB4mVMG0S5xeeVHvAOll4lNM8AN9vBC50Hr
 VXyNUl+6tjb/yrhzNtSuYmzHAq/IQvS/HDFQ22cJ6uD9IRnwSRK+psmMieSrs10G9NsN7uZzf
 vmHJAvIqYDoELFfh9H+OsDja4ZrE7+Fb3zfIhWMUT2/2+GeKGA68ZkYFyC6djPHYTtmNzhbAz
 U00L0dSQnwP3vnCJQqGPj2tppllCgoGEInfW6VOjAnCiynE5O/7PDPWgf4jagiI6Zd2JfV9fj
 LPngSpOjqWY5TzbHS3Gb7dSrWV+gY/EjjhndipbSTnO+aoTe2OUTqYSNwv/5a3BDTzWlCiHXF
 3TnWE3fneErKk4QAHAYeTovJQ2Nh6dlTrvqFnMZU0iwQap84N6VFhSlqYOJhtvk6m0UY7j9x9
 qI1kDE8dF+FRIc2Fya+OP9rbbdj9j4xGmi7LPMsVcWHjxXeh5gYnE1Djb/mZMhJxp8l7fbGqt
 Plr0ddyAD0MdJSWC2ZIYgmRI24Wqj+2P3dL+q6GxqI7VY4fOcVeYcdc1SGlEwIaSG0MvSgEI8
 CcqAuAFxrVVWdjOgCfHHm/do0PI3f3pgUWOeBw0JJibWi0ll2X6Jp2pFt1tkirVEHlauR6j4T
 4yWXIxVUNTCBWoFmzrnr0ATjpsqQM6rpt1vLIQgW3Njsg3Wb/aw6j8hvLKBiIL7q25gmKLTC9
 jzHV4Wx6kK3mLoyYSNFsnMtLJMR6U/hnnuHWadiWi/SRO5ReDdtBWf750y8/RkKk7C1B8EC5G
 HpnyTEve6Eau+nrdsE7ciDT1gB7+7ffWsf6Z7/uQWi1AIXTckX4CcECjzaUMaUCmvMUA7y+yG
 stVxTGx5PMBibHhq4pyQZnPoupOhaPFCxviB17vYI+Kpa9FhTbtS0dbDqTW7ULEO6/y51vOxp
 vggxwC8MIQMKX/viq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Mon, 15 Jun 2020, Pratyush Yadav wrote:

> On 10/06/20 09:19PM, Johannes Schindelin via GitGitGadget wrote:
>
> > This series DOES NOT change the default automatically, but only provid=
es an
> > opt-in mechanism for interested users. It also presents a way forward =
for
> > such a transition, if and when we decide to do so. Specifically, the n=
ew
> > GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to upd=
ate
> > test scripts on an individual basis instead of all-at-once.
>
> Many people have expressed reservations against this change.

=46rom what you wrote below, I take it that you are not talking about this
patch series, nor the follow-up one(s) to change the default main branch
name for new repositories.

> One argument from those in favor of this change is that it doesn't
> affect you if you don't care about the default branch name. You can just
> go on using 'master' for all _your_ repos. I'd like to highlight the
> "your" here. Sure, I can keep on using 'master' if I so prefer, but I
> don't just use my repos. I also pull repos from other people, and I have
> no control over what they call their main/primary/master branch (I'll
> use "main" for the rest of the email). The cost here is that people now
> need to update their scripts and workflow to account for other people's
> naming preferences.

This talks about the scenario where a project you use decides to change
their main branch name.

While this is a scenario that my patch series tries to support (by
introducing the concept of `core.mainBranch`), it is not something my
patch series _causes_.

All _this_ patch series does is to _allow_ changing the main branch name
(manually) in an existing repository, and to change the default main
branch name to use in new repositories.

Even the follow-up patch series I plan on contributing that changes the
hard-coded default for the default main branch name to use in new
repositories won't affect any existing repository.

So I think this example...

> For example, my vim plugins are submodules in the '~/.vim/bundle'
> directory. When I want to update them, I run:
>
>   git submodule foreach 'git remote update && git reset --hard origin/ma=
ster'
>
> With this change hitting a Git release, more and more people would call
> their main branch different names they like. So what is the recommended
> way to do something like this now? How do I checkout the tip of the main
> branch? How do I push to the main branch? How do I pull from the main
> branch? And so on...

... has less to do with a new Git release, but more with the decision of
an existing project to change their main branch name.

That's something users already had to deal with, of course. For example,
projects switching to the Git Flow model will start to use the main branch
name `development`.

GitHub Desktop changed their main branch name to `development`, and it did
not require any new Git release.

GitHub CLI changed their main branch name to `trunk`.

Chrome and node.js stated their intention to change their main branch name
to `main`.

And https://github.com/microsoft/git uses `vfs-<version>` where
`<version>` corresponds to the Git (for Windows) version on which it is
based, therefore the main branch name changes whenever there is a new Git
version.

These challenges have existed for every project that chooses to change
their main branch name, for whatever reason.

In other words, I think you are talking about a challenge that is
orthogonal (if related, on a high level) to the subject this patch series
tries to address.

Ciao,
Johannes
