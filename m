Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8147EC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FB361554
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhC2Nlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:41:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:52095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhC2Nlo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617025302;
        bh=u0j1yIPNwkr82uh3XPsDo1aH21pjWNW6Zk3meyX+VkA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U6Zay+5nfM8XynmAePqvUWx2LX8554P+wNirM9fg4eqeudVesuxPjlk6CPmd2Nurq
         dVwJiMZvR5wd24vseCBugoi9r8w93kCVjdCI73a0J8k564IevCYQzVEldiyvlbXY3P
         04mrfVNHSr2w6S6MAXBBoowammpn6U44IrmE/eeo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.207.193] ([89.1.213.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1l0AEO3aG9-00QjDT; Mon, 29
 Mar 2021 15:41:41 +0200
Date:   Mon, 29 Mar 2021 15:41:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] SECURITY: describe how to report vulnerabilities
In-Reply-To: <4f715120-3cd3-9f14-a291-0eb6e83a940e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103291537290.53@tvgsbejvaqbjf.bet>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com> <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com> <4f715120-3cd3-9f14-a291-0eb6e83a940e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FzpH1tAfXn2BfrdEGctjwui+pQ/ycWrgR2T2pOdP1BLaR9VlIUR
 sDZeiY2Q0Q3vNtpUtZ00TY6FpsmzAvGO7TCS+R7lq67OeBgpE5mznKeZ1eiifBAiQS6jg4T
 xbc19RIkoTA7W9HfzRKEmzgJebwV0qU70Vnxcu/yGtcXhVSie0sfiUmObne5dfb03s+PyaY
 GZIHdgnukUI5rZ9CGksUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ahGVeV5+z/Q=:1pGMMKkA52ZK3hqXonYM/Y
 Serrn5qKMP+eZtNKjib5XUEdW3Y5V60ayqykmweDeHP4Da5nY+Q1vlWiy3FqLJKVTsj31gNub
 ov+lCv5Kllwmj3zYUGbBMQaK6huRXUZO8/0jhEps9C26C1aWz9K4N11X5GigTM+EK0m+t+69g
 Aft/9NXfnLcyEXEZaJF3yARPr/P0cyiSfjZKBKmOsS+ZzXCC/lP9kDkEGdwQyCikuEa33PAAp
 XlpSwp2043uOhYZOQnZvXnuOp02dV6wrrLvqvEnB8t7FW1pg8i56ppWTIdjkzZjZhD9NzEgUb
 3uD0YC3m5fWWN8ucvzZ6jD7cdWcYPleBL9CAzZhFH78pDRDs+pnTTeEvvAhfgaAeMl6k9pZv+
 OnRuZmtCZxuoC+ncwdv1jvsn5vMaqsBoSY5VDrTsto/XaSheKO6H/bTEkBHY0LixWg4t1c7Qf
 4qERm8bvdvtV7mD495YeeTXswNetxBGFtMvv1YYiJTkPYbUQtTa9x3NpjAubA/h1fA3VHNsgu
 0aixVi6WtmyH0TKEo0NDDS1BhHi16/D7pfklKQhLRM/YSEjtdLokGYbUXbqJw7Xgiwe2ciRK9
 TIFTI6qWQqVjn2Vdg1d4F9TBaexDJLjyG06ctYqU600V9uMfqBYAKs82buLFmOTqp1O7Basjy
 PyMDobrtOKrLqh3gDDdpVV7+mZGybn2+XDItSSKAi/NobpmK6HTbTKlNDflZxh2ijd1O6HSqE
 Rzh2XIqSUYIHk1bR8IajU57Lg5yVT+ec6rNH4QOJ1kC26pofxhTukU1RAnQIl58ry6gXXrBc/
 TwCTD526rb99cA/nzdlWr+rlksNrCyGTWWgh4GWlrbKlJPn+pvyZitk4i03QbIBAkqsuYeetE
 P30xu8dPxw0qWfQHVfQJwP37zfgk52MT5fZ5zKkUISkUWp7RRDXR9NFrQGXFVjsHn9rl0akSC
 PrIGmA0eKF4xctJt+nAfnGDjybwODTLsH3/Lg7/8KYoUZMOvr0wqEZtEjZ55qF+BTZ3y6zpJG
 UxB1HvXH3YOmXbw8Pbxf5eq0U2twGbGYTfFul5h4hqRKO7KkMOzO/fHJMVRCaXi+L49rJgvYr
 9OXMoA7ZdgbQbQArWB6NwRpCXWfNGh/LVWXe5YdLyYIq0YUjL/KXJgYjVRhO4LzGRdA6Tf9o8
 OZGnz9IqbUoVg2vqhIII9BgBP07yP+xUbyzzzzuXelfd/hl1HvadQi+gSEaNTL5CBKP7NjjPq
 /anjphMfOa7iKh/ZB
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Sat, 27 Mar 2021, Bagas Sanjaya wrote:

> On 27/03/21 05.12, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the same document, describe that Git does not have Long Term Suppor=
t
> > (LTS) release trains, although security fixes are always applied to a
> > few of the most recent release trains.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   SECURITY.md | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> >   create mode 100644 SECURITY.md
> >
> > diff --git a/SECURITY.md b/SECURITY.md
> > new file mode 100644
> > index 000000000000..282790164e78
> > --- /dev/null
> > +++ b/SECURITY.md
> > @@ -0,0 +1,51 @@
> > +# Security Policy
> > +
> > +## Reporting a vulnerability
> > +
> > +Please send a detailed mail to git-security@googlegroups.com to
> > +report vulnerabilities in Git.
> > +
> > +Even when unsure whether the bug in question is an exploitable
> > +vulnerability, it is recommended to send the report to
> > +git-security@googlegroups.com (and obviously not to discuss the
> > +issue anywhere else).
>
> What about using reference word (`... it is recommended to send the
> report to that mailing list`)?

I would really like to repeat the email address here, to make really
certain that the reader uses the correct one.

> > +Vulnerabilities are expected to be discussed _only_ on that
> > +list, and not in public, until the official announcement on the
> > +Git mailing list on the release date.
> > +
> > +Examples for details to include:
> > +
> > +- Ideally a short description (or a script) to demonstrate an
> > +  exploit.
> > +- The affected platforms and scenarios (the vulnerability might
> > +  only affect setups with case-sensitiv file systems, for
> > +  example).
>
> Oops, s/case-sensitiv/case-sensitive/

Yes, thanks, it will be fixed in v2.

> > +- The name and affiliation of the security researchers who are
> > +  involved in the discovery, if any.
> > +- Whether the vulnerability has already been disclosed.
> > +- How long an embargo would be required to be safe.
> > +
> > +## Supported Versions
>
> The header should be `Supported Versions and How Maintenance
> Releases are Made`.

Not really. The maintenance is described in
Documentation/howto/maintain-git.txt. It is not the purpose of
`SECURITY.md` to document that, it just so happens that we hint a bit at
it while talking about which branches get security updates.

> > +
> > +There are no official "Long Term Support" versions in Git.
> > +Instead, the maintenance track (i.e. the versions based on the
> > +most recently published feature release, also known as ".0"
> > +version) sees occasional updates with bug fixes.
> > +
> > +Fixes to vulnerabilities are made for the maintenance track for
> > +the latest feature release and merged up to the in-development
> > +branches. The Git project makes no formal guarantee for any
> > +older maintenance tracks to receive updates. In practice,
> > +though, critical vulnerability fixes are applied not only to the
> > +most recent track, but to at least a couple more maintenance
> > +tracks.
> > +
> > +This is typically done by making the fix on the oldest and still
> > +relevant maintenance track, and merging it upwards to newer and
> > +newer maintenance tracks.
>
> AFAIK, maint branch are based on latest feature release (say v2.24),
> and any bugfixes there are cherry-picked to relevant older releases,
> but does it mean resetting maint branch to that older release, and
> then resetting back to before that? Or how tagged maintenance release
> are made without resetting maint?

There are `maint-<maintenance-track>` branches, e.g. `maint-2.30`,
`maint-2.29`, etc.

But it really is not even interesting in the context of security updates
how those maintenance branches are called, it is only interesting which
versions will receive updates (and the updates come in the form of a
newly-tagged version, not in the form of an updated `maint-<track>`
branch; The latter just _happens_ to also happen, for maintenance
reasons).

> > +For example, v2.24.1 was released to address a couple of
> > +[CVEs](https://cve.mitre.org/), and at the same time v2.14.6,
> > +v2.15.4, v2.16.6, v2.17.3, v2.18.2, v2.19.3, v2.20.2, v2.21.1,
> > +v2.22.2 and v2.23.1 were released.

Thank you for your review!
Johannes
