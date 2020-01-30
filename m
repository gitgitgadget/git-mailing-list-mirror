Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E3CC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C1C206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VMVctGcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgA3LKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:10:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:54593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgA3LKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 06:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580382607;
        bh=P2eRr2w8l98hzuTgmaYSfcIiQH3uOCvTiIwV+oJxeyE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VMVctGcw3PmJcyBL0RgCxgPF2y5MmxsvZVkP30Dqf/Zx12BIx23JhqJYkZVHFJrfC
         g/arkA0JcksNQQio1tTWs7ptjXlDh2yXx7QQAkogOMDp6LWEBJ/jIIMvX4maPYHEk0
         i38i4vjxkLu/SoO+jcWf55otJHjZ7n5BbxMHN7EU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1jek9N3ZA3-010cwj; Thu, 30
 Jan 2020 12:10:06 +0100
Date:   Thu, 30 Jan 2020 12:10:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jakub Narebski <jnareb@gmail.com>
cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Converting scripted commands to built-ins, was Re: [GSoC] Exploring
 Previous year Projects
In-Reply-To: <86k15ars55.fsf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet>
References: <20200129171248.6217-1-shouryashukla.oo@gmail.com> <86k15ars55.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1287682756-1580382607=:46"
X-Provags-ID: V03:K1:76v107VBJFf+BZVegKC/Xm2dCSMjQzVn/d3508F9tQqQ1QjMc+f
 1L1Fw0YMdizNozyAgoRItDWwR0GzZNv89EEkzSa8Q0kyV2xVXcfJD9s7yF43PFQuHC9ntD4
 i5sCW6tHjyWUA8hiGwjGViQbKf0ab/UzIcmYTzCD8JXC/247bae3+5kpH2DhiqT8m7ZvJee
 +/2sa5fN70RXsWBgTdA7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OZwCYl0HITo=:HhSmgUzMAYza6MjsD4L00/
 1FYGYzLnVr3RI+rhRFjSKqAUmDqWtF5CYbDp37G47QwxQKi49mNbQhiiF/UmHVN58FTYUD9uV
 8dHhhEzV2aFavwUJKKbffBRmtPq5KHQeWHjnglyaDbvedQFM9RIhOFVJPiBz0Hf8Q+1DG2uEQ
 8IvQC8ZZcA5lhSH2SxqQ4mwIqKiA1hbbkSbseRH8tcqCLdGpyEBX13DnZAJXf3agKL5SM5Rpe
 7BPTUF0uaP8ViflpWA2dyCZsAXdMUajyR5jHlIqGiTBkXXMznxXy+YWHTymmnnWWZaF7TZ/qs
 8+vfExHwGUr4AxgZ+J6+NHQ96yGUc9inzvEItMbZuqsrOflnDgOKtkIgnge2RN0BNn9Zan0Y2
 +QrmZDHsWJyPgN3nqMi5x+aVEv7GLdmeVE4M/zZbJppjuSmop497blgMvFw1KnqgOQPT9/9aG
 AQVmFzQySnHSLuyjk+MssY1K0+aKOMfTTSqbIEKfTF6JeBbh2J0HDt/RLln01qWZ3+C0WKQBN
 833lW4FDVotcAdwE7eHX56L7d7X6UlJmMVczkyqUvsq82BktiR0Kb/PZIeKXpKy5lh02gIgfh
 68m/NMgA/auJzq+eX/wcrg03+z0obEKYWPhi1/TmuL+wywa4C0uTRpSKn3924Ne7ygtTS43xh
 bHkq1fscHDvX0/OaMVGqVxbWYwmNGK9+aQqVt6/nwTn1fxYkkuxfINPFo+JvDV8NiC9/OrZyB
 at98pv/wthWqkV+csvzwxNPJ4U8atYR7WC7vUDAGpMkzPc/jFqkMHOq5evc0hSMNp0f/xHA5k
 lJz72bra9NFrf4G+XXfvFRYMqvO86RD3mhNmrs/HIHhl4+1XNTn0b6xbW7XoMh9XlUUkWt08Q
 4sxQ/9g5Leh9hWbVpz9DqGfXKPZ9/iZmYeOihaVdWK9ZkAoOG99vdV8VopQg5w1p1VLvZHG+n
 V9M8birSvvD5BStyHKLoqdUvd1i4kbtrgrwXAHVrKBSNjBidrfWG0U09vsBw82mS8IB038teA
 aYRwWYpaefxTlM8yXjj78BAxhBmlff1cM7ttV9BCCwRfYZXwOCb2zGRdCYEel/5vk99iP3eRH
 c15ShyJO4Js8Cwm6zwNwX5jMXe6Rd+S0I9byzCguMemkPndWAzMFqq2T1GJorxkvQpYJxCdfM
 9f1ARuRpAgJ5/aPDVgTNbjzyseFqNrirNWIJmHJZ3uRsPbwOu5s0FO5PBzXnteO70L6g/L1wx
 SaL/NSnVNB1QdhClP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1287682756-1580382607=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On Wed, 29 Jan 2020, Jakub Narebski wrote:

> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>
> > Hello,
> >
> > I was looking at the previous year projects[1] and a project intrigued=
 me, namely:
> > "Convert scripts to builtins".
> >
> > Following from Christian's advice[2], I have decided to focus on my pr=
oject proposal.
> > I noticed that various commands such as "git bisect", "git web--browse=
"(it particularly
> > interests me) are still in their "shell" form and will be needed to be=
 converted into
> > their "C" form as per the project description.
> [...]
> > [1]: https://git.github.io/SoC-2019-Ideas/
> > [2]: https://lore.kernel.org/git/CAP8UFD2Fo=3D2suQDLwzLM-Wg3ZzXpqHw-x0=
brPtPV0d4dRsgs9A@mail.gmail.com/
>
> As far as I know, "git bisect" is currently being converted from shell
> to C by Miriam Rubio for Outreachy project [3], so I am not sure if it
> would be feasible as GSoC 2020 project.

Indeed. That one "is already taken".

> I'm not sure if it would be possible and if it would make sense to
> convert "git instaweb" and/or it's helper script "git web--browse" from
> shell to C.

I agree, both of those scripts seem not to benefit all that much from
being converted, while some people would still consider them to be
developed easier as shell scripts.

> I think trying to convert either "git stash" or "git submodule" to C
> would make more sense.

Oh, but `git stash` is already converted. The only two remainining shell
scripts for which I would consider a conversion to C to make sense are
`git submodule` and `git mergetool`.

Large parts of `git submodule` are already implemented in `git
submodule--helper`, so that's a head start (thanks Stephan Beller!).

The `git mergetool` command is a bit trickier, as it consists of three
scripts, really, with the `difftool--helper` depending on
`mergetool--lib`.

Realistically, I think that it would be possible for a GSoC student who is
already very familiar with the code base and with submodules to finish the
conversion of `git submodule` in one season.

The same is probably not true for `git mergetool`: it would require a
couple of seasons to convert, and a good chunk of the first month would be
taken by planning a conversion strategy.

As of the current `master`, the `git-*.sh` scripts are:

# In the process of being converted

git-bisect.sh

# Candidates for being converted

git-difftool--helper.sh
git-mergetool--lib.sh
git-mergetool.sh
git-submodule.sh

# Trivial conversions

git-merge-octopus.sh
git-merge-one-file.sh
git-merge-resolve.sh

# Already deprecated

git-filter-branch.sh
git-legacy-stash.sh
git-rebase--preserve-merges.sh

# Is this even needed anymore?

git-quiltimport.sh

# Probably better to leave them as shell scripts

git-instaweb.sh
git-request-pull.sh
git-web--browse.sh

# Not even Git commands

git-parse-remote.sh
git-sh-i18n.sh
git-sh-setup.sh

The situation of the Perl scripts to be converted is much nicer:

# Already in code review

git-add--interactive.perl

# Too complex/too dependent on the Perl packages

git-send-email.perl
git-svn.perl

# Support for legacy SCMs that are less and less used

git-archimport.perl
git-cvsexportcommit.perl
git-cvsimport.perl
git-cvsserver.perl

So: after `git add -i`, I think we're done with the conversion of the Perl
scripts. Took long enough ;-)

Ciao,
Dscho

>
> [3]: https://public-inbox.org/git/20200128144026.53128-1-mirucam@gmail.c=
om/t/#u
>
> Best,
> --
> Jakub Nar=C4=99bski
>

--8323328-1287682756-1580382607=:46--
