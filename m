Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578EC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A29160C3D
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 04:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhDLEGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 00:06:35 -0400
Received: from mout.web.de ([212.227.17.11]:55053 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhDLEGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 00:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618200375;
        bh=dVrzkerOWF4uNtHHqw49qAbTFGXzTbzwlALBp43TIEY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=nMBxg8c5/BNWs8eYZWVwoZjrdbFPGTcfk11LDvlR0IwRdv0FBrHfH+/2z1xSCP6Hg
         moxzG5M/iaC/ZnQMuCgEArSR8fhA+4zR6RG/QDpXK7ycAp/XycQH0h0S1h+rwjup2A
         kbUsRvGmJtHOa7Bv5HVHOl5+G1KGfao+Yarz9DOY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEVhF-1lKaUA1wxF-00FiWe; Mon, 12
 Apr 2021 06:06:15 +0200
Date:   Mon, 12 Apr 2021 06:06:14 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-p4 crashes on non UTF-8 output from p4
Message-ID: <20210412040614.gqiot5qcsfpiae3a@tb-raspi4>
References: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
 <20210409153815.7joohvmlnh6itczc@tb-raspi4>
 <CAKu1iLX1AyTCSGxDVgiR1cr4=4ODD-gn8jHAinhp7OhDChAf1A@mail.gmail.com>
 <20210411093746.ymqofe2uawclwu5i@tb-raspi4>
 <CAKu1iLUNooP+FDMJKekH4b2Cq5BhFZwAb=d28iPv55C5+cQbCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKu1iLUNooP+FDMJKekH4b2Cq5BhFZwAb=d28iPv55C5+cQbCg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:jhiqTveiD4N6XIRzi9IIaoAd7pZLVJLpxtNbrMPwIOhvd+xaNZb
 7AYvMttJ76sUYv3+9llDV+caQr5FHX3C41BEAOdZTVKh2VWFEJfMM/8YkI72agnmfgtSlma
 z2ey6he2dbJoLz/haQhoy1U3t2+TwjO6ei9/U9RpjVf3ppPN6NOfAYGKgVJJbVCTijDiSj8
 MjQaLHQunTSqoyoF8wDEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8IBV/YCa70k=:R7+LaG8nJzvVOOicPQwqw6
 sv5c8hKfSVBUWxvSWgFF7viK2qTEUNMBKNRJT6K+oWdtStCHIPxXcgpa0eFK5llEoG5k+QGRZ
 6AlEREyyRitHWrC4ssbW3xYVPzkxAnyElJI+OrMJMKuNqfRhkhVDpDY6t9cLAoh1A1qZVD82g
 xZejD2lHARO9Ud1jSar65fay6ed5qZkB0BW3j0ZL8dZDo/WjpY/N2MqGD9LrwaPluz0g3TZ0x
 APjbwAO0NhP9QRPr2qU3wZUgdIcx2PAtxLYZNHr3cHzVySQb4n53xRhEHm2/sRmrxqF+eOp6G
 SrUi6celCq6FWAyE1zwmilzcLp8nzE/KEvYEQcfDa+1teIhq0sgFvnNaJ0Lj6cgFqE/Tzc5jS
 ryQKG49uNGKwhNmInsE1ra1u6vKPCCMCvaH0w4OpDOzJ1n/lJFflQRkzPIYxSZzGibV8yHM1m
 45NVYgu5caU8RBhIrB+0t0hWIZDrodrsLJXild8bna7j4IQ26RB6r574WHum27SWqDXr9NdkQ
 PdyjGbgrFV7FsOjCa2XPWmRsYvsWqnPWsNgc1lktqtYn5Cm3IOfeU0chqT5gYd8NXEsn86QQq
 4uMdwzPfmYNEBZDT9OTacbUz5chmCDsJR1KLMViVsjx9Umqm1afIAvvNii21oVXwBEkIxLn4E
 FMUWi4uMTu2vg+8n13QyajyvnVytvEIysNJPYOU4tsc/i1bi+Es00bv6t2BlDF8QiswBPjq7+
 7XOe5hhzCZZBaIlis98fFOhmEbmf/eBEXhHbvyJty5x5iDdRj2ZzE7wGogVYZsXnCpBtN6oBc
 mBwQSOxZ7R7fDmn4EpG9MTVWUiG0dP9z259/ISx/myNPnMGXXY/V23sN6zkTaH7zIccXzOa06
 WPT3G4Oh5C8uFu8OSU95A0eIJILGLF3ZVeqSwrM6yhJ9xBIsA39hbZr3PvE9TCsCyL8/jaXjh
 kkiWTURRdXbj1XzYowX3ZK5yibHUwKFTq9H7epKdbcH00/NC23AN4tVng5lwoSOMcWW6DK0+Z
 nzbO9Fj2MGcAU/UujZ1SuLH50O2Vm5/zblrn7reRc34FMbVku9YBzLH/WYkD93kMdbV/YJig0
 xA6ZBdIIc3S19vzugIPWA+498szBce8WEVFlIMPPlwz8g6HDjPP4da5GhiXnPj05SyQ90JcER
 BqmxTbfQ7XeFw2gTwDmtQTSHDV0gPAjY/UMILWBC4yIOzbP+bFajbcuXcgALqznlKI6xc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hej Tzadik,

Let's start with a side note:
This mailing list doesn't use top-posting, everything new is at the end,
so I moved everything there.

And removed some of the old stuff.

> On Sun, Apr 11, 2021 at 2:37 AM Torsten B=F6gershausen <tboegi@web.de> w=
rote:
> >
> > On Sun, Apr 11, 2021 at 12:16:25AM -0700, Tzadik Vanderhoof wrote:
> > > Here is the pull request:
> >
> > Thanks for the work. Some comments inline.
> >
> > >
> > > From 8d234af842223dceae76ce0affd3bbb3f17bb6d9 Mon Sep 17 00:00:00 20=
01
> > > From: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
> > > Date: Sat, 10 Apr 2021 22:41:39 -0700
> >
> >
> > The subject should be one short line, highlighting what this is all ab=
out,
> > followed by a blank line and a longer description about the problem an=
d
> > the solution. The original description was good, see below.
> >
> > > Subject: [PATCH] add git-p4.fallbackEncoding config variable, to pre=
vent
> > >  git-p4 from crashing on non UTF-8 changeset descriptions
> >
> > In that sense I make a first trial here, subject for improvements:
> >
> >
> > Subject: [PATCH] Add git-p4.fallbackEncoding config variable
> >
> > When git-p4 reads the output from a p4 command, it assumes it will be
> > 100% UTF-8. If even one character in the output of one p4 command is
> > not UTF-8, git-p4 crashes e.g. with:
> >
> > File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
> >     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
> > decode byte Ox93 in position 42: invalid start byte
> >
> > Allow to try another encoding (eg cp1252) and/or use the
> > Unicode replacement character  to prevent the whole program from crash=
ing
> > on such a "minor" problem.
> >
> > This is especially a problem on the "git p4 clone" command with @all,
> > where git-p4 needs to read thousands of changeset descriptions, one of
> > which may have a stray smart quote, causing the whole clone operation
> > to fail.
> >
> > Introduce "git-p4.fallbackEncoding" to handle non UTF-8 encodings, if =
needed.
> >
> > >
> > > ---
> > >  Documentation/git-p4.txt | 10 ++++++++++
> > >  git-p4.py                | 11 ++++++++++-
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> > > index f89e68b..71f3487 100644
> > > --- a/Documentation/git-p4.txt
> > > +++ b/Documentation/git-p4.txt
> > > @@ -638,6 +638,16 @@ git-p4.pathEncoding::
> > >   to transcode the paths to UTF-8. As an example, Perforce on Window=
s
> > >   often uses "cp1252" to encode path names.
> > >
> > > +git-p4.fallbackEncoding::
> > > +    Perforce changeset descriptions can be in a mixture of encoding=
s. Git-p4
> > > +    first tries to interpret each description as UTF-8. If that fai=
ls, this
> > > +    config allows another encoding to be tried.  The default is "cp=
1252".  You
> >
> > I know that cp1252 is attractive to be used, especially for Windows in=
stallations that
> > use Latin-based "characters".
> > But: If we introduce a new config-variable into Git, the default tends=
 to be
> > "if not set to anything, behave as the old Git".
> >
> > > +    can set it to another encoding, for example, "iso-8859-5". If i=
nstead of
> > ISO-8859-5 may be more portable on the different i18 implementations
> > than the lower-case spelling.
> >
> > > +    an encoding, you specify "replace", UTF-8 will be used, with in=
valid UTF-8
> > > +    characters replaced by the Unicode replacement character. If yo=
u specify
> > > +    "none", there is no fallback, and any non UTF-8 character will =
cause
> > > +    git-p4 to immediately fail.
> >
> > As said, before, many people may expect Git to fail, so that the defau=
lt should be
> > none to avoid surprises.
> > When a "non-UTF-8-clean" repo is handled, they want to know it.
> >
> > > +
> > >  git-p4.largeFileSystem::
> > >   Specify the system that is used for large (binary) files. Please n=
ote
> > >   that large file systems do not support the 'git p4 submit' command=
.
> > > diff --git a/git-p4.py b/git-p4.py
> > > index 09c9e93..18d02b4 100755
> > > --- a/git-p4.py
> > > +++ b/git-p4.py
> > > @@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'=
w+b',
> > > cb=3DNone, skip_info=3DFalse,
> > >                  for key, value in entry.items():
> > >                      key =3D key.decode()
> > >                      if isinstance(value, bytes) and not (key in
> > > ('data', 'path', 'clientFile') or key.startswith('depotFile')):
> > > -                        value =3D value.decode()
> > > +                        try:
> > > +                            value =3D value.decode()
> > > +                        except:
> > > +                            fallbackEncoding =3D
> > > gitConfig("git-p4.fallbackEncoding").lower() or 'cp1252'
> > > +                            if fallbackEncoding =3D=3D 'none':
> > > +                                raise
> >
> > Would it make sense to tell the user about the new config value here?
> >  raise Exception("Non UTF-8 detected. See git-p4.fallbackEncoding"
> > Or somewhat in that style ?
> >
> > > +                            elif fallbackEncoding =3D=3D 'replace':
> > > +                                value =3D value.decode(errors=3D're=
place')
> > > +                            else:
> > > +                                value =3D value.decode(encoding=3Df=
allbackEncoding)
> > >                      decoded_entry[key] =3D value
> > >                  # Parse out data if it's an error response
> > >                  if decoded_entry.get('code') =3D=3D 'error' and 'da=
ta' in
> > > decoded_entry:
> >
> >
> > Did I miss the Signed-off-by here?
> >
> > Please have a look here:
> > https://git-scm.com/docs/SubmittingPatches
> >
> > (or look at Documentation/SubmittingPatches in your git source code)
> >
> > And finally: Thanks for the contribution.
> > Is there any chance to add test-cases, to make sure that this feature
> > is well-tested now and in the future ?
> >
[snip]


On Sun, Apr 11, 2021 at 01:21:47PM -0700, Tzadik Vanderhoof wrote:
> Thank you for your excellent and friendly feedback!
>
> I understand everything you said, but I have a question about the unit
> test you requested.  The git-p4.py script currently does not have
> tests and is not written in a way that would be testable.  (The Python
> function I modified calls into the shell and requires a valid Perforce
> installation.)

I am not really sure about that (there are no test cases).
A valid Perforce installation is needed, yes. Otherwise the p4 tests are s=
kipped.
There are a lot of p4 tests under t/t98..p4....sh

git show a8b05162e894b88aeb7d5064dab

Tells me e.g. that both git-p4.py and, in this very commit,
t/t9822-git-p4-path-encoding.sh have been changed.

All the test are t98xx-git-p4-something.sh (fiund under t),
and you new testcase may be named something like

t9835-git-p4-fallbackEncoding.sh

>
> Would you prefer I  a) refactor the code to be testable and then write
> tests  or b) skip the unit testing (not sure if there are any further
> options)?
>
> (For option a) I would break out the part of the function I modified
> into another function and then call my new function for my testing.
> (I guess it would be better to break the refactoring and my changes
> into 2 separate commits.)
>

Probably not. Typically we can construct a test case first,
and see that ot fails (in you local test-running).
After updating git-p4.py with your improvments the new test should pass.
And of course all the other p4 tests.

There is a whole bunch of "CI tests", run on Linux, MacOs, Windows.
One example of a test run is here, and the "regular (linux-clang,...)
is running the p4 tests:

https://github.com/git/git/runs/2309995044?check_suite_focus=3Dtrue
