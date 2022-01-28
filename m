Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E80DC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiA1M7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:59:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:37277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbiA1M7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643374738;
        bh=i5pmY8X3m9jUTV+QQGy1SV6IULxcMQ/6q1NLgWK3q78=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DVuDXa/6wXJClphb06saYkIeyVQLXyC+TgKlB+wFMk8OaQNbdu/aqHFSbpTPB01Tt
         4NfiaR96SZgGy8VBkdsydRoZsBDD+nhlZReYqUupxPuWR7kzwjzFl3O7KPGmINJ1e0
         fi55LoIhtdYMGuPXMG9AL4bDt1v1P4oBNbvpu0uc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1mNG7w3mwH-00sNqE; Fri, 28
 Jan 2022 13:58:58 +0100
Date:   Fri, 28 Jan 2022 13:58:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side
 merges")
In-Reply-To: <CAP8UFD2qFmZ2Adk71SQw9xtq5keZ=d2hcMwF=fs9OtW4==0ZYg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281343360.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com> <nycvar.QRO.7.76.6.2201261250380.6842@tvgsbejvaqbjf.bet> <CAP8UFD2qFmZ2Adk71SQw9xtq5keZ=d2hcMwF=fs9OtW4==0ZYg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QkjFrHM7JCE5OY1j38jkxIisxYWN/uIfbo/bYJX2A1om4SFx3yr
 AcrJxqcK7QMiQhQCU23Z4seHx6lz8ql+uYtC986KM4k0LQrmJ6lkD6IOgmhR4J3b/BA5AUr
 uKpqeA4fnb4UA103YD3UN9PgPwD2keXBnUqnmswf5LKHR9+YvaWOvgG7aX5100dnFZsBFNd
 lq/Zqutf44AqoWUOyZW1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VdVFt0o0pFk=:0v03HBFPp5a/68t9q+neyG
 sNszn9Ke28yIiX9zBHzjMsiW9w/uGHSjSeqcHdpECLLu7IgHKv2JocIvbp4rDox6RCIeVPeAx
 9wjejRAKMqaZh+CQXuYwA0z9e6LcGz+zWvH4X+0WQaS3SZcHGSpM0HKKaePXE/qRRwnv2F7C+
 cE86tgCXcmPYvpj8lENj42IHJ6sibrQo+iS2ItoyOahj6ZEfn4bLHcmFHdKg6oDKPX5AAy+YB
 +jWh4VGa/UGcLpprd3oB/UGDced7B/e8DD4fn9bEeuH7/o/Ez/VZleEXRptwzvQssDqEsSSr3
 KbutinQVmd4EcrwCP/QxcpI8QIRehaA564RYJps5x3B48M62GDLAQYYY07aJQL6R0ZVxxUFMn
 zq1ecGmOaaFcTl1ntD+yPvMQ4fOLmk8qQ/ASN0KeHhVVgHAUaMtF+HxMFpJBJJYMU3DBE3/rP
 8qWDtcrAKgNc99OEL0Jyt98yXRl1Tw0YZZOUTJI3qc4sgR9u+RIo3ghgy7NnQD7pHsHBhhPMW
 gE6pjKjzvtujBKCrqm3Vle3DUjYFOi2k5ZnYXV/xurV4fj1a5M7TKTpUu3uj0n+qjIlRyNsF5
 JBNzl6BD8/inpWCFfAgg7cQOdkJU4f6oxKw8WUpTc9iBTp9VdAvnVwO7G56omEPqHnW0XpiuC
 dpAzYTTvAzF/VfTgbU/PJOSTqufNyDBfxFTQXNMc9o/1740iTgY7/zOcIuBLraOXxJk4X+IfN
 ZJVYCG3dECGUo81L5yMa32kbD+P+hxZxjMKTmj0TcF+/hcH5k81+IEnVSh4859r8+PScgm7+A
 /UqS6RqilFD1RirH5ZpOOlUJhDjas0YyotuBeLDEVIrYTqh1h+l6wVRacjjxRSQOf379VidKc
 3A7qjNLEbljdOpAVa/rx78ttKy4KVBgJX6mpd4xaTkHnuEC3JjE93znXXacriiXQSnTo6xjqZ
 rGeUptW5JCYTi3rF471vC5QJwNDPqHiOSRDCCydVf2qQEnhE/W2Hl+I2UJF5s6c8gdDaiCnR1
 J74jYGXSivtAeQFOmy+sRVfc4unXKCpS2C3bpEtYH2zbB3HijfLfHCqQyznpLaHSx/UuoVS7d
 TeHMBBBquwPV30=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, 26 Jan 2022, Christian Couder wrote:

> On Wed, Jan 26, 2022 at 1:03 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 26 Jan 2022, Christian Couder wrote:
> >
> > > The reason is that I think in many cases when there are conflicts,
> > > the conflicts will be small and the user will want to see them. So
> > > it would be simpler to just have an option to show any conflict
> > > right away, rather than have the user launch another command (a
> > > diff-tree against which tree and with which options?).
> >
> > That assumes that server-side merge UIs will present merge conflicts i=
n
> > the form of diffs containing merge conflict markers. Which I don't thi=
nk
> > will happen, like, ever.
>
> Please take a look at:
>
> https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#re=
solve-conflicts-in-the-inline-editor
>
> As you can see in the image there are conflict markers in the file
> displayed by the server UI.

Please note the difference between what I wrote above (present merge
conflicts in the form of diffs containing merge conflict markers) and what
is shown in the document you linked to (present a file annotated with
merge conflict markers).

There is no diff in that page.

What's more: there are not only conflict markers in the editor, there is
clearly a visual marker next to the line number that indicates that the
editor has a fundamental understanding where the conflict markers are.
Which means that the conflict markers must have been generated
independently of Git rather than parsed in some random diff that was
produced by Git.

In other words: you are making my case for me that `git merge-tree` should
not generate diff output because it would not even be used.

> > In short: I completely disagree that we should introduce a new command=
,
> > and I also completely disagree that the `merge-tree` command should ou=
tput
> > any diffs.
> >
> > I do agree that we need to be mindful of what we actually need, and in
> > that regard, I reiterate that we need to let concrete use cases guide =
us.
> > As part of GitLab, you might be in an excellent position to look at
> > GitLab's concrete server-side needs when it comes to use `git merge-tr=
ee`
> > to perform merges.
>
> I hope I provided a concrete use case with the link above.

Sorry, I apparently was a bit unclear.

In the context of discussing `git merge-tree`, a low-level Git command,
when I talk about a user, I do not mean a human being, but a program that
calls that command and parses its output.

Corollary: by "use case" I refer to a concrete implementation of a
server-side merge operation, I refer to backend code that currently calls
into libgit2 to perform the merge, and would benefit from calling `git
merge-tree` instead. Such a use case informs us about the type and amount
of information that is required of the code that is currently being
discussed in this mail thread. And I highly doubt that you will find such
a use case that wants libgit2 (and later, `git merge-tree`) to generate
diffs. Because _diffs_ are certainly _not_ what is consumed by the inline
editor you referenced.

Of course, I am still left guessing what the server-side needs concretely,
because that is not at all obvious from the user-facing web site to which
you sent me. What is needed is a good, hard look at the actual _code_, the
code that calls into libgit2 to perform a merge, and that could instead
spawn a `git merge-tree` process to accomplish the same thing.

We need to get away from hypothetical scenarios. They're not helping.

Ciao,
Johannes
