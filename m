Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E281F462
	for <e@80x24.org>; Fri, 14 Jun 2019 18:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFNSm3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 14:42:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:42419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfFNSm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 14:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560537741;
        bh=rEOyYWDLC4C+Jutm8hFGRjW/g8ZwxeCdUQM1euImdG8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BWdqte0Crj3/p29kEd6YoWmOxVJ8AN38UwDFgjuoFaw5zgSj/bR0clBgT5h+WEq0X
         BXDPSZ99+02Zk5j3yLnWAz8scJ2rtiVqADv6eaRi8MzTUYEJg9uBpjpobiUg7FYcTI
         CISRjvGhGArT1ES/dZgBnUOlGv5baeisw3FU1Ym4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFu0Y-1hpag63Dba-00Eqzo; Fri, 14
 Jun 2019 20:42:20 +0200
Date:   Fri, 14 Jun 2019 20:42:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
In-Reply-To: <20190612194106.GJ4012@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet>
References: <20190430142556.20921-1-szeder.dev@gmail.com> <20190611130320.18499-1-szeder.dev@gmail.com> <20190611130320.18499-4-szeder.dev@gmail.com> <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com> <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva> <20190612194106.GJ4012@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1674472957-1560514992=:44"
Content-ID: <nycvar.QRO.7.76.6.1906141958510.44@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:elpE3fp7FU+7eTT4UZsGq/BwmEcpC5LBc7XBuP5Up0L0CyHGMd7
 jMDSkJQLwqCokk43RNJWharKXmzM65AW3ffPaP5VBTcFXkXfxIyY2SR+gBkh2+6iAqQ/mJL
 Jp0VjlAYmbzqd04Amv7OTIJu+Vg+SmIiqot49AIWUxyMH8zFAYn9ntB72ICSzXixCldzcKy
 JP0f6vpKhAnjM/RZ2/CsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KoDwzEosv6c=:EU0RH3Yh6zOdDPS26QxU2i
 E9BaVlx9YiOSQPG/MaUO0cYCGCaJfLi7whT1AH/7vQ5xG5jVBkzZUBsMSVanbJZJxQH5iZncH
 U0hoydwCYx1V0yPZsXJevrFh06LZ37uT3e3mYGAsP6mJEozDXViAhPV5sYayOu1XQhjv0Aqkw
 RcQMFIgWtNNwLFPXJm3yYMjR12rpFZ7OOq3bHfM6znCKTeKuTNZsm6nhhzUQwBoKUryZuOV7a
 pDPY5JDm8dAMpTxn0q5gfDWjVOVsAaybu19l9sOQYdtuL9aXPPI8YRH/oBrpOD6b/+f7FwcVS
 +fIInPTTMf7ZB6PqEKep72OUfPSBeOsT/6unA17egGMlRea/+RRORXICUap7YGw3JZyvol/nq
 cK9A1qTjHv55t38UuEmyiFUPsqoISqkh+xnnrcJ1Buo88m4MLi6yRQQ0giam0xsmtrJmUldm7
 d3hOdhNkxZHGLexkRM0Wjy7+ZsOsSjXYd2tOlQpvThXdFsxS6cuwxNuzywF55CDkkm9aMDxQJ
 qwe0CeymO5wTQCTSNcHxQCqCYhm0ZAMMlN0tTgnp8kCLCTaVSKqCPVK5oXHkWWTmkRoc/Ql43
 XBSItw91OSWGnJpEz2vpa/X2qVGmIpHu4XcXcKuPKLcNykPlSh2vHaBUzs9SnWzSSjlj2+xzg
 WKhFpmNmVSUljOw8Y+z0M03iKvfAAl2zJKylxltPEPeNPU2sJJwO5j5vYehLJLM0AjdK2mxQ9
 ulI+e/ALyEsDE3R+0p3GjEQ0BdqGqkLZg2nfwNLLzb7mJFzvmzX/x4AxMYfqAGSOOJaCi3yNu
 rhH/hsb87o4cn7dLvv0q93yet9gA9FRfPCBFGZOZJksUXwpL6XmH136rmd89VuUJMHjLvjSNr
 DynPGwp6awN98NNPzoxtdvklBFH2UALXZzFvoY8+UyVO4FgzU1D2eHbVAAxtXjzUxdrld5V4x
 Et9oGKkXLyIpYmaGldO/IRozwkcDm8bU4Y4QRweijjHrfnmb/xJwC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1674472957-1560514992=:44
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1906141958511.44@tvgsbejvaqbjf.bet>

Hi,

On Wed, 12 Jun 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
>
> > On Tue, 11 Jun 2019, SZEDER G=C3=A1bor wrote:
> >
> > > On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
> > > > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> > > >
> > > > > -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuc=
cessfully rebased and updated refs/heads/missing-commit.
> > > > > +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ  =
                                                                          =
    QSuccessfully rebased and updated refs/heads/missing-commit.
> > > > >  EOF
> > > >
> > > > Yuck,
> > >
> > > Oh yeah...
> > >
> > > >... but I do not see how else/better this test can be written
> > > > myself, which makes it a double-yuck X-<
> > >
> > > Perhaps hiding those spaces behind a helper variable e.g.
> > > 'dump_term_clear_line=3DQ<80-spaces>Q' and embedding that in the her=
e
> > > docs specifying the expected output in these three tests could make =
it
> > > ever so slightly less yuck...
> > >
> > > > Are we forcing out test to operate under dumb terminal mode and wi=
th
> > > > a known number of columns?
> > >
> > > 'test-lib.sh' sets TERM=3Ddumb relatively early on, and in these tes=
ts
> > > we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
> > > term_columns() defaults to 80.
> > >
> > > However, if the terminal were smart, then we would have to deal with
> > > ANSI escape suddenly popping up...
> >
> > And I fear that is *exactly* what makes
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10539&=
view=3Dms.vss-test-web.build-test-results-tab
> > fail...
>
> Isn't it a sign of a problem in that Windows test environment that
> it mistakenly believes that the terminal is smart, even though it has
> been explicitly set to dumb?

I investigated this today.

Mind you, I still think that it is totally inappropriate for a test case
with the title 'rebase -i respects rebase.missingCommitsCheck =3D warn' to
validate the expected progress output, in particular since it verifies the
progress on non-sophisticated terminals, i.e. the totally least
interesting and least common scenario.

In short: I stand by my suggestion to fix these tests (i.e. ignore the
progress altogether) in a preparatory patch in your patch series.

The investigation why the test fails on Windows (due to the progress being
displayed for TERM=3Dcygwin instead of TERM=3Ddumb) took quite a bit longe=
r
than I had originally anticipated, essentially because I did not expect to
uncover a bug that I introduced into Git for Windows v2.x apparently from
day one of the v2.x era.

In case you are interested in the details, please read on, otherwise just
mark this mail as read and move on.

Still with me? Well, here you go, enjoy the ride.

There are quite a few interesting bits about this bug, and I have to start
by stating that in DOS, there was no difference between empty values of
environment variables and unset environment variables. In other words,
there was no way to distinguish between the equivalent of `export x=3D` an=
d
`unset x`. Back in the days, this was obviously perceived as reasonable,
and I kind of agree given my own difficulty to describe the problem
clearly.

Now, in the Win32 API there is a relatively easy way to distinguish
between those values: if the return value of `GetEnvironmentVariableW()`
(which indicates the length of the value) is 0 *and* `GetLastError()`
returns `ERROR_ENVVAR_NOT_FOUND`, then the environment variable is unset,
if it instead returns `ERROR_SUCCESS`, then it is set, and the value is
the empty string.

Side note: if you want to rely on this behavior, you will most likely want
to call `SetLastError(ERROR_SUCCESS)` before querying the environment, as
there seem to be conditions where the last error is not re-set to that
value even if the call succeeded.

Since Cygwin started really, really early in the history of Windows (even
supporting Windows 95 at some stage), it emulates the DOS behavior, not
the Win32 API behavior, and simply skips environment variables with empty
values when spawning non-Cygwin programs. In other words, it pretends that
they are unset instead.

Git for Windows' Bash (which runs the test suite) is an MSYS2 program, and
since MSYS2 is based on Cygwin, inherits this behavior, and since
`git.exe` is a non-MSYS2 program, there would be no way for the test suite
to set environment variables to the empty value and have Git respect that.

This broke t/t3301-notes.sh (because it sets GIT_NOTES_REF=3D and
GIT_NOTES_DISPLAY_REF=3D to override the configured settings), and therefo=
re
I came up with this fix in February 2015:

https://github.com/git-for-windows/msys2-runtime/commit/c19199cc14ee

It tells the MSYS2 runtime to *keep* environment variables with empty
values.

Note: this fix was really made in order to let Git for Windows' test suite
pass, for no other reason. And it was not accepted by the MSYS2 project,
so this really only affects Git for Windows.

That fix seemed to work at the time (and maybe it really, really did), and
it seemed to work, still, until my investigation that took the better part
of today revealed that my fix was buggy. Under certain circumstances
(which I believe have to do with the environment variable referring to a
Unix-y path at some point, which is the case for `SHELL`), the subsequent
`getwinenv()` call mishandles empty values. It tries to convert them from
a Unix-y path (that looks like an absolute Unix path, but it really is
rooted in MSYS2's top-level directory, identified as the second-level
parent directory of `msys-2.0.dll`) to a Windows path, and failing that,
it replaces the `SHELL=3D` by a NUL character.

The `SHELL` thing here is important, as t/t3404-rebase-interactive.sh sets
this to the empty value explicitly:

https://github.com/git/git/blob/v2.22.0/t/t3404-rebase-interactive.sh#L63-=
L68

So instead of a `SHELL=3D\0` in the middle of the environment block, Git f=
or
Windows' MSYS2 runtime inserts a `\0\0`. That, however, is the marker for
the end of the environment block, and as the environment has been sorted
before being converted in order to launch a non-MSYS2 program (in this
case, `git.exe`), the `TERM=3Ddumb` setting is lost.

Even worse, for unrelated reasons, `git.exe` defaults to setting
`TERM=3Dcygwin` if `TERM` is unset.

I hope you, dear reader, can appreciate the number of circumstances that
had to come together to trigger this bug.

The fix with which I came up can be adored here:

https://github.com/git-for-windows/msys2-runtime/commit/c10b4185a35f

I tested this locally and will re-test as soon as a new MSYS2 runtime has
been deployed into Git for Windows' SDK.

Ciao,
Dscho

--8323328-1674472957-1560514992=:44--
