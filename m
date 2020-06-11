Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC43C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4156F2065C
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LS4Daiza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFKOdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:33:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:42189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgFKOdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 10:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591886016;
        bh=N9gbBb7WL8iDTBLNioudrW4tSPUoMcDReIMRFR4QW1g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LS4DaizaNWmSIOq80+qvDGV0M2zu3yovqZ1KoN6DUvzgb9J1KX4lNfxG4u12f9CYC
         /+a4SYo5oq959RxPPSG+jDkjOz9wm9DKNKB+BtuAhE0lJTeZf1ajmO2Lholj5Cnc/M
         hfVbgkd0gTHNyp3SNsGzSJSf07HAi6rWfyQHwNvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.212.132]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1jkUjc28vc-001Bnm; Thu, 11
 Jun 2020 16:33:36 +0200
Date:   Thu, 11 Jun 2020 16:33:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <20200611010720.GA21728@syl.local>
Message-ID: <nycvar.QRO.7.76.6.2006111610000.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <20200611010720.GA21728@syl.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gHpYW1kTFzfibWH1LYj0RnUvtPCbyLxupcEBmiYAt4FUgV3HYHx
 PFxKXqqPiGDeLAQ8ndz/MgyeeE2gKucQ5hzFDNb3ceH/xT/SftL4kuZjMHp44rCZsQ3pzVI
 Herg2+iJ4+6IdnnPaxvAiOiY1X9J4n0Nh5rq4w3okeHfouaZDOjpuXGfdUGhvn2hYzM+LWR
 AF2aAic/88eeKdzfiaOUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:peyqswBWhFA=:MZUQTt0oiq5Iv6rWL5+DsQ
 gBmhun5NbFF90b5Zzva2YNWlBGwfrrv9ynFZbUESPJjRmq+xpGIm5EPs/vlstMTr0h41cERGs
 uqE0RrBi2B/C2J4G2G0dBzAQkIvFpwhMGQuxknoOehJok1/uFUE4TkwI0YBwtYDJLaLaxxbbY
 iklRk1WmOQNwTjb/pJEDFBwu878iyI8pfzvRs+SnKk6vZSYtOZvybUlTn1idMHyVph0TGN8tV
 +50lQL0YuC0AAi6nPl8gniaNrahos0BJabrYd90ZH1sqIJ/pWsmW0GS0xSoJt7fb59dL/xgCn
 g8SKz/fKfZE1cf0W80K38PvPWcphqIoRNVjS03Dbpw35NFwTR6GHeKdB+L+DnYM9x2kgDxj0w
 vR5vYvJKoc7LdHqKBGLffS2YKWsojKhb5zU0mh5IAdgy0u8Y0u2FQDbrBZjgb7Hw1+swzk+0d
 rPjrhCF9CCPE9mBLTjgr/piFd+calzbz6o90tGwKaJLNHjM6Mzabd7dDX/P4ktG3Py7HV4jlZ
 iDG6GzTa7Ot5olrvvUichUhl7m1hOGxwJiEJKYS2mh9qt2Qvg15HxywpVblD0zzJMXoNjclaV
 4jqNFbUWE/wOL2sihwtiKItmG02RbJsGwEhFpaNkQVV+iPz3XYor8MSg/If8Gzr4R+KmS5riP
 ZJ9V8j8nSjpBD2Zby+DrnraiV3z5yJRJMZZzvnpF/trrHSS377Gybj+tltTqcyrcn0mnxha6M
 /HP6vYocXDQK9ctrcQMuwnLMK9G4C4XvmNPLW3MuExIKln15EnF8XziZC3V2zpdZF3idi7DOk
 j8rVASniPu6OAWyvTLUKsuZ6BYxhMte1LMZy7+u0ubcQ7aQ9GzEFsrqn7m/b7vOl31/3oXj4p
 LC0wZAWNv464ywL3I+VzAvb7eOwALPkBXnKIm4OV44Si//tc/Wr+91MJqzoFlVF2zsP2ZErim
 m+Z/NFeUdIEwLZPmtM+h9f91mvBDSBVejHKUKAenTjOMLffZMvdIxrygTupMGuQ3lqcc9wETr
 8hVl4YnsGNZRn7aXFIaI8OfkksH2V6NbxWOcQPBXj3+b4r5SE4BSK3i+hQJayCFJPpyEB0ESM
 LeFUSxRR1v57bhlh+vAJYVmwT6chHwzJkQyMR5BzmO3X/TDKCeBQz7Jd8F03XYY/Qg8GM76pQ
 e/lA2RNGVFqWyms7PW2frjSrjBj/WIdyHj3VBBoplk4NXOpF03yjzr6m+xy1ejaCid4WnjQPH
 0hXL8zITv6vYYMiPm
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 10 Jun 2020, Taylor Blau wrote:

> On Wed, Jun 10, 2020 at 09:19:21PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > A growing number of open source projects aims to avoid the branch name
> > master due to its negative connotation. See [1] for an existing discus=
sion
> > on this. The links [2], [3], and [4] describe community-driven ways fo=
r
> > users to rename their default branches or use template edits to set a =
new
> > default branch name.
> >
> > [1]
> > https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeD=
V=3D=3DapdWDg@mail.gmail.com/
> >
> > [2] https://twitter.com/mislav/status/1270388510684598272
> >
> > [3]
> > https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMas=
terToMain.aspx
> >
> > [4] https://github.com/ethomson/retarget_prs
> >
> > By necessity, existing repositories require a lot of manual work to mo=
ve
> > away from that branch name, but it should be much easier for new
> > repositories.
>
> This is (somewhat) orthogonal to the topic here, but I wonder if we
> could be doing anything to make this easier for users.
>
> Could servers remember that a branch has ``moved'' and alert users as
> such when they pull? Even better, it would be nice if this alert from
> the server could allow clients to automatically rename their refs
> appropriately so that this transition is as easy as possible, even for
> existing repositories.

I would _love_ to have `git fetch origin master` work, spitting out a
message `the main branch name changed to [...] please update your
configuration`.

And then maybe an easy way to update the configuration (`git remote
set-main-branch <nick> <refname>` might make sense).

As you say, it is orthogonal to this here patch series, but definitely
related in spirit because we _want_ to make it easier for users to move
away from the current main branch name.

> > This patch series allows overriding the branch name being used for new
> > repositories' main branch. The main way to do this is the new
> > core.defaultBranchName config option. This first patch was contributed=
 by
> > newcomer Dan Goodman-Wilson. Thanks for the contribution!
>
> Welcome, Dan! This is a fantastic first contribution, and I would be
> honored to help and move this forward in anyway that I can.

Sorry, my typo: it's Don, not Dan ;-)

> I should note that I am technically "out of office" (which normally
> wouldn't mean much, but this time means that I am on a road-trip, and so
> am only at my computer infrequently). I am catching up on just a few
> emails here, but I'll be able to help out more (and would be honored to
> do so) once I am really back next Monday.

Well, go back enjoying your road trip! :-P See you on Monday.

> > The other patches follow other places where "master" is hard-coded and=
 use
> > the new git_default_branch_name() method to consume the config option =
before
> > falling back to "master".
> >
> > The last patch updates documentation only after the config option is r=
eady
> > to apply to all of these scenarios.
> >
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
> Provided that the eventual plan is to seriously evaluate a name other
> than "master", I think that this is a good way forward that clears the
> way for us to make this change easily, without forcing us to come to a
> conclusion on what name will replace "master" today.

That is exactly the intention of this patch series.

I _do_ want to put my weight behind changing the default. Obviously, this
will take quite a bit of time (but maybe less than I originally thought,
as we are only talking about changing the default for _new_ repositories).

Even if this endeavor fails, though, this here patch series will be good
to have.

> For what it's worth, I am completely in favor of abandoning this term.
> My colleagues at GitHub (as has been mentioned previously on the list)
> are in favor of this as well, and it is my understanding that other
> providers feel similarly.

=46rom what I read at https://gitlab.com/gitlab-org/gitlab/-/issues/221164=
,
GitLab is on board, too.

> I would be in favor of any non-offensive name that we can reach
> consensus on. "trunk" sounds nice to me, but I think that it may cause
> problems for non-native English speakers, so perhaps "main" or
> "default" would suffice (maybe "main" is better, since it retains muscle
> memory for the first two characters without being offensive--at least,
> as far as I can tell. If I am wrong, please correct me and we should
> consider something else).

My personal preference was "default" on Monday, and "main" ever since.

> All of that said, I can't emphasize enough how little I care about
> *what* name we replace "master" with, so long as it is (1) replaced with
> a non-offensive term, (2) that that change is done uniformly throughout
> the "Git Ecosystem" and (3) that the community can reach consensus on
> the new term in a respectful, appropriate, and considerate way. I only
> provided a few suggestions to get the conversation flowing, although I
> suspect that my help isn't needed there.

Indeed. I laid out the patch series in such a way that we should be able
to pick a different default main branch name than "main", even if it is my
current working hypothesis that this will prevail.

As I said, my preference was "default", and that's how my big patch series
looked like, so I know how much work it is to change to a different name
(because I changed it to "main"). It is quite a bit of work, but
manageable.

Ciao,
Dscho
