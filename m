Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43950C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBBNxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBBNxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:53:09 -0500
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD2233C3
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675345882; bh=6V8D3qtco2Brg3E5VK09NkbhOdlT1eZQm5E+pcWVbJU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dZ7ElB9GECEcq0rfv22HIfnzYSzLDQjp+ql4HnFz8yNDGN1NIZ1UbqqAQrLPfUq/8
         i0tLAqpS4cagkhuR2fFNs2rmCeIoUUguG45yK5++NXeeFFNmJunuwYsBRwvWsHCKbn
         KNCiBdWqFcNDYsw6Er/0Fs7kHtpfVr8TpeJD73EqcISlBxyxncNix++cK7I1JqIBBK
         2hbaQ1W7YcPooGwrVWf+0NHTbg6zuqDMA4DAS4DpqOQCMzA8O1rYjjjgLl7vYRKayr
         m08b/082Oe6o5eYFbhkPLZLZ4O7TWTSKpVuDAkuTskQXL1SZXRJO1XcKR7qlaPuHYq
         qwDCsv+1TVG9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([89.1.215.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1ovtck1rem-00lXbr; Thu, 02
 Feb 2023 14:51:22 +0100
Date:   Thu, 2 Feb 2023 14:51:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
In-Reply-To: <230202.86edr8pax5.gmgdl@evledraar.gmail.com>
Message-ID: <60c3f1d0-2858-8811-7eb0-d6f586bf2ab8@gmx.de>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>        <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>        <xmqqwn5bg695.fsf@gitster.g>        <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
        <xmqqfsbxcmdd.fsf@gitster.g>        <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de> <230202.86edr8pax5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1301753600-1675345882=:10350"
X-Provags-ID: V03:K1:jl+imL03N3EmoMPYF9dKYffXudGjAmYr9oX18TML4ed199AeKRS
 YgiTTquHtL/e153RjFoOL1V2MnS0gtyuZPRi3wROkwTK6d5nFgBFPoDuLvEBAd4ffXq4O2I
 be1oGcH/KPz97g3pqkZI8FWHYfv12wwUXiw4rZlMQheM89OpRiUhuEm+hHgRfBIX8XLd2H/
 lr5g8e8gEvWf818IGPe0Q==
UI-OutboundReport: junk:10;M01:P0:yk4tlhB6N2M=;bneoMdgdghg9hI7i/0cX+m8xnS7SX
 c29fqMMpDLeNrPBO6KCWrSvDjyiuM2Hhoa2SVZtD+fKiW0xtp10maiPA3GZToJhVjtR8pxOYx
 OEuZFUyPd4US4107xqYiNNOFlCXcg4PxAD/GPMYLIoMCASqp+KZPbj6mmYH0FWc9UF95NFVSq
 yszrobujkizYVzsQKFJT4R9m4cLumitfXLI8rHeCi0iBvJ7fbbcTF7k5eQHreEJI8FVuO2m/Z
 5HDyVoLBOlTTQ7NMvmUbtTxJj1r3yuFZcJtQJJmU5ozz+l9danShNxM9A7POIlAyjHkeD/Lt1
 xvYgVlEUG7XrCzV1R6a8GXbA6AkAMifY9k+tfEluZOjapinC8FRUVOejQtzluJoAdL5ZMe8JT
 ywNn28MLmc5N1JgXNxy43Muc1A33SirYoLyrW2XNtIWnXlMaCNhx18F8BssaySmGt16FZO8aU
 TIfXkZa0o6EFMPRn83j/eL5P77l+Vb7z4pPh9xywPVsclVaibjLjfEnKecP9PQ/nwOlPI3gHK
 6fw4AnZOoSEHtnbZzE/ogq9ZQJylauz5a9LSkbovBmxuolp5C4s4ysNke3Glcap262T6QT7Pp
 8eH5dHjICSSymJnGswiTByF51huaZhjSBTbwgEHdg6kbzZC0u0QeYnx2r6n0cjn4Djk5eqto3
 8OCsGhh4Xn1V+bPU5rmicC52OjQBhGx7djMtOjjmDJa5TCbgDs/9mG0xINK8U/OPbxo95HUQV
 8/PcYP1CzsUoyAmSIaktIPp0mb1/DkwfT0JHkcBn6HythXstqHvKkQntu875ElOXINj4FJ1Yj
 ercBfqzkJUNwoIDoVsTyEoE0bupr5v0EWfKN80X5bFpuNNmwZCDWo9AsYgTW08FZ2HrqKzC+r
 dGHCzX4BCDsDKVI4rwu/w1DrqWPoKIdfgiW7T2zwGNQl3xLTQp4aHLaCSvNbkGcxW4NczUGvo
 n9c1IwlSajmZX/fgaVq7rmjTQDmxKOyfvEFq+PYWsaLJLPClgsZX2IAXLRCve27NuNaw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1301753600-1675345882=:10350
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 2 Feb 2023, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Feb 02 2023, Johannes Schindelin wrote:
>
> > On Thu, 26 Jan 2023, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >>
> >> >> Thanks, both.  Let's merge it down.
> >> >
> >> > Sorry, I'm a bit late to the party, but I left some comments just n=
ow
> >> > (this topic had been on my review backlog for ages, but I never qui=
te
> >> > got to it).
> >> >
> >> > Many of my comments were small bits that could be fixed on top (tin=
y
> >> > leaks, etc). But some of my comments were of the form "no, do it to=
tally
> >> > differently". It may simply be too late for those ones, but let's s=
ee if
> >> > Matthew finds anything compelling in them.
> >>
> >> I do not mind reverting the merge to 'next' to have an improved
> >> version.  Your "do we really want to add a custom server based on
> >> questionable codebase whose quality as a test-bed for real world
> >> usage is dubious?" is a valid concern.
> >
> > Except.
> >
> > Except that this code base would have made for a fine base to potentia=
lly
> > implement an HTTPS-based replacement for the aging and insecure
> > git-daemon.
> >
> > That code base (which is hardly as questionable codebase as you make i=
t
> > sound because it has been in use for years in a slightly different for=
m)
> > would have had the opportunity to mature in a relatively safe environm=
ent:
> > our test suite. And eventually, once robust enough, it could have been
> > extended to allow for easy and painless yet secure ad-hoc serving of G=
it
> > repositories, addressing the security concerns around git-daemon.
> >
> > And now that we're throwing out that code we don't have that opportuni=
ty,
> > making the goal to deprecate the git-daemon and replace it by somethin=
g
> > that is as easy to set up but talks HTTPS instead much, much harder to
> > reach.
>
> There's many reasons for why you almost never see a git:// URL in the
> wild anymore.

I am unwilling to accept that statement without any source to back it up.
Thin air is no substitute for reliable evidence.

> But if "easy and painless" was synonymous with "built with git" or
> "ships with git" as you seem to be using it, surely it would be more
> common than doing the same with http or https, which requires an
> external server?

Oh whoa... "requires an external server"?

My entire point was to suggest a way forward for an _internal_ server that
speaks https:// instead of git://.

So I am not suggesting what you seem to have understood me to suggest.

Ciao,
Johannes

--8323328-1301753600-1675345882=:10350--
