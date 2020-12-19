Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86354C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 15:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DB8233FC
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 15:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLSPCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 10:02:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:41569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgLSPCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 10:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608390028;
        bh=jizKfMf+k7cRl9p3iklJDQVrl01HQGe7Dyg3XCWFjcs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h/i3Hd/LEwdxDPei66YACD58G8O55MBiO0f3L9rrYnhgAzNdJaW/mChIm9C+RECWy
         6khkOVMhHBltcYv3mq+7hKGyx7aw01asG9QHaSHa9EEGt3WN9l8ufKFciQAuO77utf
         7bEas6a82yyTea7ZnFlHOChtDPwagc0olbXj+rd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([89.1.213.150]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MirjS-1kC3e3472S-00eqsD; Sat, 19
 Dec 2020 16:00:28 +0100
Date:   Sat, 19 Dec 2020 16:00:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Vojt=C4=9Bch_Knyttl?= <vojtech@knyt.tl>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] rebase -i: do leave commit message intact in fixup!
 chains
In-Reply-To: <CAN0heSpEnZGN9DBCabYg8JPWdSzRGh5YQ6CdrN4ubLqG-JkN8A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012191559180.56@tvgsbejvaqbjf.bet>
References: <pull.818.git.1608337339246.gitgitgadget@gmail.com> <CAN0heSpEnZGN9DBCabYg8JPWdSzRGh5YQ6CdrN4ubLqG-JkN8A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1675503112-1608390028=:56"
X-Provags-ID: V03:K1:O7vK+P6JNC3fyluMxFuudoRElD79Dl9QLih4AI3y05YJDr+XwX/
 bVTo0GL6Z5kVlo7xi8ro3aqzNdUckenQrPd2+vDJZUCJ2X2pB6tOCRLt/iyufrNskGMZpcW
 aEfV0KBBrUnX9y5O4xZ5thThqPrVx7mXyX9sr1BRG4DAc31wAbtG4JrSZ4AJLXliZmUI870
 puOFK0dDEYOOh6/iC/djw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XqmTSYIFYIw=:x2/Mfkr2ZaL0psy0tiPdUx
 HZgiWdO1mCJSQScRjvmwksLbSwMdWrGOUDbCVYyg3L/SwdCs+rWFFHFuZUnWO92o8QRrD9iU0
 KHIWI3835ovMfi42s4pIpPZwESmB26ZzPN316m6zxC/0Zn8DyCwd/vUaytbfnJXBOG0YQVF0M
 8+51zpIMW9lvOB/q4VlKfLaiFIF2oCG9rg1c4rWMbbNFEx4+MyjSF7JT9QxNuI7fVI98lSApT
 Hj/u85zqFm1r7SjzFjnCcxflmvdI1yna1vj44sH4kvMi4TEDC/oYBJECkK2qDcqWFoxykeeiv
 1teNL5Z6Ufv95b/Is3maaOpKKrRfaqCwXW7EOwvZkC/PRj04Bjrnli8/QGSJleMIU9n2d5YHH
 8q5VsEZOFR+fNrxRep+xT++05zM3doSOfNRkz4gRJRI3leWVUHqpQAT0/haAREeDq3P1nHcM/
 b5Fpu4FS3WglEHEaZKrLcAFfl6nBhAOfaTwhnYx7d28lJ+NSWSCc68leFCKblqFkBjzVcTu0z
 4LxMgxYuypkNTAP4Y+1t2G3SkC7xgBQtYc6rjrrQqUInXjBj1qJ6q0xDp1xKR9QzdZZCLaUlt
 Md34s9uvsLJZ3dwQZrTjT0/zZnqfDe2K6n9AT8/wg+VJ1U5dzUCdJJnQ992I0roZb8oIkt9Xm
 c3ppnT3sdmJ2SRG30/+7LknMYm2zo1OJsS6K5O5mjI0wR5AjiJcLA7Hg5nDQRZOwkkfIlOjB9
 bFwxKslxyew3XdW4KttcWrusJprtjQJROehDrpfpbrzz8O9fFeod+fDH/lB3SP+kvlGxGJRzf
 7/iR1vL7Y5v1kYELnSwbL3+mayJSIElQa1AayHtihvE3DZFz4Pizv8FEvrnVApVnkjpBI1Zp7
 Zntea6jsz2JbFvye+etUja7W0Tc7LYfQtSfChyDy0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1675503112-1608390028=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sat, 19 Dec 2020, Martin =C3=85gren wrote:

> On Sat, 19 Dec 2020 at 01:25, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
> > 'squash' commands, 2017-01-02), this developer introduced a change of
> > behavior by mistake: when encountering a `fixup!` commit (or multiple
> > `fixup!` commits) without any `squash!` commit thrown in, the final `g=
it
> > commit` was invoked with `--cleanup=3Dstrip`. Prior to that commit, th=
e
> > commit command had been called without that `--cleanup` option.
> >
> > Since we explicitly read the original commit message from a file in th=
at
> > case, there is really no sense in forcing that clean-up.
>
> >                 if (!final_fixup)
> >                         msg_file =3D rebase_path_squash_msg();
> > -               else if (file_exists(rebase_path_fixup_msg())) {
> > -                       flags |=3D CLEANUP_MSG;
> > +               else if (file_exists(rebase_path_fixup_msg()))
> >                         msg_file =3D rebase_path_fixup_msg();
> > -               } else {
> > +               else {
>
> I see. The bug survived your 789b3effec ("sequencer: make commit
> options more extensible", 2017-03-23). Which isn't surprising for such a
> mechanical change.
>
> Nit: The "else" still needs braces, so if we follow the coding
> guidelines, the "else if" should also use them. And even the "if",
> FWIW. So it would arguably be more in line with CodingGuidelines to have
> this diff just drop a single line, no additions needed.
>
> So what this does in the end is, it stops adding `--cleanup=3Dstrip` and
> it doesn't do anything instead, i.e., not even `--cleanup=3Dwhitespace`.
> OK, we want to use the exact original message. But what if
> `commit.cleanup` happens to be "strip"?
>
> > +test_expect_success 'fixup does not clean up commit message' '
> > +       oneline=3D"#818" &&
> > +       git commit --allow-empty -m "$oneline" &&
> > +       git commit --fixup HEAD --allow-empty &&
> > +       git rebase -ki --autosquash HEAD~2 &&
> > +       test "$oneline" =3D "$(git show -s --format=3D%s)"
> > +'
>
> I changed your test to use
>
>   git -c commit.cleanup=3Dstrip rebase ...
>
> and it started failing. Maybe `run_git_command()` in sequencer.c could
> learn to pass `--cleanup=3Dverbatim` or in some other way make sure to
> override any user configuration here? I couldn't figure out how to get
> this to actually work, though...
>
> Looking around for `CLEANUP_MSG`, I spotted the logic added by
> 15ef69314d ("rebase --skip: clean up commit message after a failed
> fixup/squash", 2018-04-27). It seems like it has the same problem, but
> that this proposed patch misses it. I did some testing that seemed to
> confirm it:
>
> Adding a commit with some "#message", then adding a fixup and then
> adding a fixup that will conflict, then running the rebase and skipping
> the conflicting fixup, I end up with a commit with the empty log
> message. That's both before and after this proposed patch.

Thank you so much for this detailed feedback. I will take care of it next
year, after taking a semi-vacation interrupted only by releasing -rc1
(check), -rc2 (TBD) and v2.30.0 final (TBD).

Ciao,
Dscho

--8323328-1675503112-1608390028=:56--
