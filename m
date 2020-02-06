Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B4C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E4220720
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 08:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kneZUZJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgBFI6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:58:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:47895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgBFI6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 03:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580979473;
        bh=/Q9VEagtcfIp2YdoROzvH5+ggAfvAgGS0z+LB92FUa4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kneZUZJiq/7Kbn4g68OlUW3T2Uam6Hk3Hog5HAXJWkeJPxap8r5juzsSbnOyoOqEj
         xn+N9LPzxxyKshK1CVbazWuAAU1Fucdm5aDQgvOOr6LZYElpmpjnJHN7/o9FaZHmh7
         yr+DBfXUhKct8XO1U5CLYMAdELav9jTf0H5ZalL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1jpfff2qbC-00rcJS; Thu, 06
 Feb 2020 09:57:53 +0100
Date:   Thu, 6 Feb 2020 09:57:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200206002754.GM10482@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2002060930210.3718@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev> <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
 <20200124120240.GG6837@szeder.dev> <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet> <xmqqeev8694x.fsf@gitster-ct.c.googlers.com> <20200206002754.GM10482@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-273090226-1580979473=:3718"
X-Provags-ID: V03:K1:iZguUrLVeS4GrcET2vxU9M4W2dooj6nEx3q6cT5a2J+qBv/fo9B
 leMqr28nMzb0fWY7w6AZy1dO2U2FzMs2uGKHBn4wg5ugx9xfZD29dwiyuDi4epWy4VJGQ5F
 kBjjorRaV2S8NR6xe857fRMlrYecYtlGuVZwdqA9xc/dxjHSWVV4o+k3+iE4oYBbJND2FTE
 62IvABnV+wQ1AfR72Qa4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jo/NKFojCPc=:HlQn1vp/iMtJXmat2iVW/1
 Oh6oYdJN1+Z2Gcrmq7xhLNm4w4Mvsuc7orxDs6K0MMFqF77vjNJbbEXqXniiCF98Gn19fMfxP
 WhKZ1XySzhN0uTqx/7KyDg9ZTpXcF+4MHJhrrgmtZGw35hleT5T/ai3/EZtDH83VFMADVKM2a
 jOE+ojfG0gsk0IHrV8UrfyoSxAIo53sJzmc7hNH54sMN2L5vGwgI9BkJGGC3fufZxFZ+c60GR
 QBGLwwDWOma69yzfxStgAWvMs0115zudm+pg5ZEcX3XcKwaAVwlrbMoGrHyHgjqLR1YM+C6TC
 tFEq5LDChFnF5SCr4oF3/9KqznSVN8XmWxI6V5Pz/pn4YW7JtbyFSxmmbTb2S68N/8PqSz6hG
 J84ZqIJjdMlDKKDPbcGhocSwo5UlIBdOeu0uPPB3pN8i5zHcfGlFyl5vQUfT12Q99tCLdQzl/
 p8Jxz4jz2SU1sY547j+YrNH4Eapu6X3Bt35Wtf8hhlnxjc20sENo5MGdCDHCZnXpU9UfqhgXY
 dqL4WIh4sJphB6kl/7FcYTmBQc3iKpBkkbjhdNhF1EStH18QiwP051oTUFw7oaOtdGO+zWSWu
 lwnEL1cL+Bjn9VLZ1422aGK9Xy35YARoqvViqmPokr0ZbggwzFCEcJln3usHzHlvh7yjvTwDr
 VDjIQ4aYxWe66j9QYoMKTVVYZa99psM2JYb0bmSgt/xHbIxetbIAXgdBUHvzaRajQWsCNDLAg
 qtZUNva69CkgklETwNb2l/CqpQ+uJ7RENw2oVNOSRDU5Wwbdpu56nEQvECF2Deubu8Wu1CURK
 nTKK8IarcZq0imZFNwTR8I2Yer3rl3+udBN2wCiqcq3xOcSoCImOenq3tHu08w/6duJqrzLkc
 g0S70GnIX4ehUD58TUYJgM2Ex3j1wsCgQUKG2S5XGv+NvlxK5l/ynHfLB74Iu3MvWmyuawkxI
 /sLu6E4Vj+fUlRHeDKVZHzcW3dXb6DdNMWM5gFLDAtDdpUWYS/flE71h3wmmxm86Ui59D5XuP
 G0U/Aj9uS3w2bjuSnc6hKEDxFikdqAVouUfiNnDicmgeMcAenWii7KSsLcg+GmZi82GKpvbHt
 OVCEMNUaiXhMs/f0H2U2kHLk91hta8ZOQG6LTkEFREjjpJeSHpohwbjY8QWr+56xmOvEKivHM
 W/lv4og26VRpyumdYUUsvqFJYYnZ9v2Np+5HTRhNyhkCcX2utUZLJSla7QZ8P57cPLd8crRCI
 +OBC/IyH+pG41rqGJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-273090226-1580979473=:3718
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Thu, 6 Feb 2020, SZEDER G=C3=A1bor wrote:

> On Wed, Feb 05, 2020 at 01:01:50PM -0800, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> Do they have to shout that loudly in the name?
> > >>
> > >> We could rename these jobs to e.g. 'linux-clang-py2' and the like, =
but
> > >> I think it would bring little benefit, if any.  In our Travis CI
> > >> builds these Linux/OSX Clang/GCC jobs come from the build matrix,
> > >> therefore the jobname is not visible on the Travis CI web interface=
 or
> > >> API, only in the build logs.  There are some pages on Azure Pipelin=
es
> > >> that do show the jobname (and some that could, but hide it instead)=
,
> > >> but it's just too convoluted (or sometimes even impossible, well, f=
or
> > >> me anyway) to get there.
> > >>
> > >> And if the requested Python binary can't be found, which will
> > >> eventually happen with 'python2', then the non-zero exit code of
> > >> 'which' will abort the build, no matter how the job is called.
> > >
> > > I am mostly worried about contributors whose PRs break for "magic"
> > > reasons. If it is not clear where the difference between `linux-gcc`=
 and
> > > `linux-clang` lies, that can cause unintended frustration, and I do =
not
> > > want to cause that.
>
> I'm not worried about that.  If a contributor doesn't touch any of our
> Python scripts, then I don't see why using a different Python version
> in the build would cause any issues.  And if they do modify one of the
> Python scripts, then they should make sure that their modifications
> work both with Python 2 and 3 in the first place.

If the frequent problems with downloading the Perforce binariers taught me
anything, it is that the most likely explanation for failures in the
linux-gcc job is that Perforce, once again, updated their binaries,
uploaded them _to the exact same URL as before_, and that there is nothing
wrong in the PR or the patches.

That _is_ the most likely explanation, given our record.

So what are contributors supposed to do with that? Nothing in the name
`linux-gcc` cries out loud: Hey, this is a Homebrew problem, there is most
likely already a PR up to fix it, and the job needs to be re-run once that
PR is merged, that's all, please ignore for a day.

Now, with the log that we currently have, it is still somewhat easy to
figure out what is going wrong. Somewhere along the lines it spits out an
error that talks about some sort of package and about some sort of
checksum. Most developers deduce from that message that it's not their
fault and move on.

So this is _already_ an annoying problem, but it gets worse: every once in
a while, a build is "green" _except_ in linux-gcc. The contributor runs
the test locally, it passes, so they conclude that the test must be flaky
or at least that it is not their fault.

How on this dear planet should they know to run the test again, but this
time with `GIT_TEST_SPLIT_INDEX=3Dyes GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue
GIT_TEST_OE_SIZE=3D10 GIT_TEST_OE_DELTA_SIZE=3D5 GIT_TEST_COMMIT_GRAPH=3D1
GIT_TEST_MULTI_PACK_INDEX=3D1 GIT_TEST_ADD_I_USE_BUILTIN=3D1`?

You know that they should do that. I know that they should do that. They
don't. And why don't they know that? Because _we make it hard for them to
know that_.

I agree that your changes make sense, from a lot of points of view. Except
one. The one where a contributor has to spend an unnecessarily long time
to figure out how to proceed given a test failure in `linux-clang` and
`osx-clang` that they never saw in their development (e.g. because they
only run with a non-EOL-ed Python).

What we need, therefore, is a way to let the users know _precisely_ what
is going on and even more importantly _what they should do now_.

Simply tacking on the Python3 stuff onto -clang (or -gcc? I forgot which
one, see, it even confuses _me_) is not going to do that.

Granted, this is not at all a new problem, it is related to that "let's
pile another test run with all kinds of `GIT_TEST_*` knobs turned to the
non-default settings onto, well, let's see, how about `linux-gcc`?"
problem.

In this light, I kind of agree that it is not the responsibility of the
py2 vs py3 changes you proposed to fix this. But they make the problem
even worse.

Ideally, I would prefer a new job into which the second half of
`linux-gcc` is moved, just like I proposed many moons ago. This would also
help the problem where flaky tests require a re-run of that insanely
long-running job.

Of course, you might find a clever way to enhance the failed test's log su=
ch
that it makes it obvious that this was run with special options (similar i=
n
spirit to ffe1afe67c0 (tests: show the test name and number at the start o=
f
verbose output, 2019-08-05)), and then tacking on the py3 thing onto -clan=
g
(or was it -gcc? I am _still_ confused about that) would still be okay.

But then, I would contend that we should do the same for
`GIT_TEST_SPLIT_INDEX=3Dyes GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue
GIT_TEST_OE_SIZE=3D10 GIT_TEST_OE_DELTA_SIZE=3D5 GIT_TEST_COMMIT_GRAPH=3D1
GIT_TEST_MULTI_PACK_INDEX=3D1 GIT_TEST_ADD_I_USE_BUILTIN=3D1`. Only use th=
em in
`-clang` (or was it `-gcc`? I still cannot remember), and run the other wi=
th
default settings only.

> > So, what, if any, decision have we reached?
> >
> > If linux-gcc and linux-clang labels are not visible, linux-clang-py2
> > and osx-py3 would not be, either, so...
>
> The 'linux-gcc' and 'linux-clang' labels are not visible on Travis CI,
> because those jobs as part of the build matrix, and, consequently, we
> can't set the a 'jobname' environment variable for them in
> '.travis.yml'.  If we were to include additional jobs for the Python
> scripts, then for those we can (and should!) set
> 'jobname=3Dlinux-python' or something, and that would be visible on the
> Travis CI web interface, just like e.g. 'jobname=3DStaticAnalysis'.

I think we can see that jobname very well, though. If you direct your web
browser to
https://travis-ci.org/git/git/builds/646646192?utm_source=3Dgithub_status&=
utm_medium=3Dnotification
you will see something like this:

    Build jobs		View config

! 5281.1 AMD64		Compiler: clang Xcode: xcode10.1 C	no environment variable=
s set	8 min 20 sec
! 5281.2 AMD64		Compiler: gcc Xcode: xcode10.1 C	no environment variables =
set	8 min 23 sec
X 5281.3 AMD64		Compiler: clang Xcode: xcode10.1 C	no environment variable=
s set	1 min 57 sec
X 5281.4 AMD64		Compiler: gcc Xcode: xcode10.1 C	no environment variables =
set	2 min 41 sec
! 5281.5 AMD64		Xcode: xcode10.1 C			jobname=3DGIT_TEST_GETTEXT_POISON	5 m=
in 14 sec
X 5281.6 AMD64		Xcode: xcode10.1 C			jobname=3Dlinux-gcc-4.8		1 min 13 sec
! 5281.7 AMD64		Xcode: xcode10.1 C			jobname=3DLinux32			6 min 50 sec
=E2=9C=93 5281.8 AMD64		Xcode: xcode10.1 C			jobname=3DStaticAnalysis		10 =
min 56 sec
=E2=9C=93 5281.9 AMD64		Xcode: xcode10.1 C			jobname=3DDocumentation		6 mi=
n 15 sec

Never mind that it is somewhat dubious to see that the Linux32 job is run =
with
Xcode... but you definitely see the jobname, loud and clear.

Ciao,
Dscho

--8323328-273090226-1580979473=:3718--
