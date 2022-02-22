Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22DC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiBVOjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiBVOjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 09:39:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F14ECC7
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645540718;
        bh=DIrT10e0kw31gSXKrMPXaVK4JkUkh+iNiPwoQdz1fMo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LIdLML7IHx2Gm371hY7tcUcwNBvTI2Ep3Pq3c9n0OCq21qx8r8K4Caw9NJ8mENaAR
         BIlDCOklUlm2LkF164tuQoQzRzba0p+w9cJdIq8QE4otmS8/sFbaNY+gT4LjRSwas7
         3+UsPnV0M+KT8YS+QGJRM82j3zPYbz7Rc6sWPE+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1nn5ZP1qZV-00QnPt; Tue, 22
 Feb 2022 15:38:38 +0100
Date:   Tue, 22 Feb 2022 15:38:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH 01/11] bisect run: fix the error message
In-Reply-To: <CABPp-BGk7-yRZddOWBq6FpZDr=nOKSbL7eyMJQnOycP9CFtRng@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221537520.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <93d19d85ee38f50019d5f05605ce7b5eca76cbd6.1643328752.git.gitgitgadget@gmail.com> <CABPp-BGk7-yRZddOWBq6FpZDr=nOKSbL7eyMJQnOycP9CFtRng@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w6EiSffrYTP6QXxQHuix2RadVd5D6Fdn9ckqxhLtXzZElaehSiN
 c/Aeo4wj1nC7+kCaYPsMeQypsiq5MGgBAlNFMG18g/tcVFCvEHG5aY47xalBFKlTzmnHRs6
 +85a9wNNh85ayG9wJ6uA1PiYeHkRYgYZHNdZpjfaziveNFdxqdj+2RG3UWI8hjd+lcwsI/H
 a3g69uP+ps15CQFn2jn1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tPvsQxXY6ZM=:ex15jrLOFZEs0WfpRa/3sc
 X7djdhQjQpE94gPP6peaLtFa3gz99X9Jw0UYjDkWCKXWgBVIX5N49HaSvFmZR6BzWS11B5Udu
 e9Nb3HNYru5GP7pJgTuPPhPgJ4y2vvh8xgi6rMxmpQ0pdCabX9uNftTyUr7h1VfzWDCoKB6pJ
 pMVu6Lx7ePdIqDPwsZMgxhKShNMmcKff9hL+1ZyHgDvQHe3wAlBWijtj2a4qJF3bdBH0UC6aw
 8BDvGSlvreawE8KJCOkmdyitVZ4kx6zAy5sKiv9vmcrR5eoOv9m2HonSFVNa8kO50AfQLwYnw
 yP5S+qZdmArFNw7ioJKqI/MvSPnmxhFll0HKSvs1VlY8wPBvBSda9KcDCAgpohCqw3ndc0ouF
 Im+GKVKC/gJ+AZKj//wOpkwvmUEkX/dbb6CMbPoedxOn+kjuY+Qa+ybeeP4k3CjIYozb4ij6B
 R9q/Ugb4ceFr7HndDD3qXfAtPqu36exeHytU+5Plavjvjf77X78cPTAD40CV0d9eNuQSMcrwF
 QpJT3M6U6yUykw4UHADpote4FXJ5KdOIW9KsiLGa6HnWIjAmcFUsmHz7WLrerQumICBf70Rby
 urQPITGErnzHUfqR5TcOZ9HIbn/sm4EmtHPbmn+LWcskNnvfAJ5LZy2CuY2YiuIa9sFKh7dHM
 IxodxF3C/s3P4Rl+hXcqVgHE9sRNObPJSz9quggiGLZTHH3isA10OvKzodsZ7WmPR7STHAg4q
 zJ6SnoRwabcvbpxWBGC88evA0z8UlxcQxW8plDfXPUn/zu6z9cIawdHBas9rAdy3dwezTRRW8
 nS1ZXtbYyVOM3ZVkc0KuKQeDj/+HaxPZP5Sqzf7HzwDmd/wR89dz/6E5M61lZTzssSwS5gq9d
 B3dtoKo+4Qr7z4ZiPBuVS+G9bV72lKWj5qCms/YtoPN1byMcGlRMc0LGRHSAQBMIWHmxB52ZZ
 VrNTdZXGlPoYGUaZzi2mmUoD/uFTgHsgXczva3ZUyXbyKKGqRloMYn2vK1JqyYnHVc37U8Okv
 ELcWwwARsBA++SiR9HKozW44wI5mOsH6Xp1AcYTlvCr89iaes8SpE0gHx6gh16vnaHmz5nD3x
 tThYNYB3PiO+2U=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 8 Feb 2022, Elijah Newren wrote:

> On Fri, Jan 28, 2022 at 3:27 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell functio=
n
> > in C, 2021-09-13), we ported the `bisect run` subcommand to C, includi=
ng
> > the part that prints out an error message when the implicit `git bisec=
t
> > bad` or `git bisect good` failed.
> >
> > However, the error message was supposed to print out whether the state
> > was "good" or "bad", but used a bogus (because non-populated) `args`
> > variable for it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/bisect--helper.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 28a2e6a5750..4208206af07 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -1093,7 +1093,6 @@ static int bisect_run(struct bisect_terms *terms=
, const char **argv, int argc)
> >  {
> >         int res =3D BISECT_OK;
> >         struct strbuf command =3D STRBUF_INIT;
> > -       struct strvec args =3D STRVEC_INIT;
> >         struct strvec run_args =3D STRVEC_INIT;
> >         const char *new_state;
> >         int temporary_stdout_fd, saved_stdout;
> > @@ -1111,8 +1110,6 @@ static int bisect_run(struct bisect_terms *terms=
, const char **argv, int argc)
> >         strvec_push(&run_args, command.buf);
> >
> >         while (1) {
> > -               strvec_clear(&args);
> > -
> >                 printf(_("running %s\n"), command.buf);
> >                 res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL)=
;
> >
> > @@ -1157,14 +1154,13 @@ static int bisect_run(struct bisect_terms *ter=
ms, const char **argv, int argc)
> >                         printf(_("bisect found first bad commit"));
> >                         res =3D BISECT_OK;
> >                 } else if (res) {
> > -                       error(_("bisect run failed: 'git bisect--helpe=
r --bisect-state"
> > -                       " %s' exited with error code %d"), args.v[0], =
res);
> > +                       error(_("bisect run failed: 'git bisect"
> > +                       " %s' exited with error code %d"), new_state, =
res);
> >                 } else {
> >                         continue;
> >                 }
> >
> >                 strbuf_release(&command);
> > -               strvec_clear(&args);
> >                 strvec_clear(&run_args);
> >                 return res;
> >         }
> > --
> > gitgitgadget
>
> Good catch.  Looks like this printed "(null)" on glibc, and probably
> crashed elsewhere.  Perhaps it'd help to add a test that would have
> caught this with something like (I'm hoping gmail doesn't corrupt
> this):
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 1be85d064e..28b54ba41b 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -980,4 +980,15 @@ test_expect_success 'bisect visualize with a
> filename with dash and space' '
>         git bisect visualize -p -- "-hello 2"
>  '
>
> +test_expect_success 'testing' '
> +       git bisect reset &&
> +       git bisect start $HASH4 $HASH1 &&
> +       write_script test_script.sh <<-\EOF &&
> +       rm .git/BISECT*
> +       EOF
> +       test_must_fail git bisect run ./test_script.sh 2>error &&
> +       cat error &&
> +       grep git.bisect.good..exited.with.error.code error
> +'
> +
>  test_done

Excellent, thank you!

> Also, as a side note, it appears that another error message in this
> same function has a suboptimal error message, which could be fixed
> with
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a575..6187d9fbcb 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1118,7 +1118,7 @@ static int bisect_run(struct bisect_terms
> *terms, const char **argv, int argc)
>
>                 if (res < 0 || 128 <=3D res) {
>                         error(_("bisect run failed: exit code %d from"
> -                               " '%s' is < 0 or >=3D 128"), res, comman=
d.buf);
> +                               " %s is < 0 or >=3D 128"), res, command.=
buf);
>                         strbuf_release(&command);
>                         return res;
>                 }
>
> In particular, the line of code just above here:
>       sq_quote_argv(&command, argv);
> means that we get double single quotes without this fix, which looks
> ugly.  Of course, this doesn't need to be included in your series, but
> since you're cleaning up other error messages anyway, I thought I'd at
> least mention it.

Sure, and I think it is not _too_ much out of scope to fix it in the same
patch series, too.

Thank you!
Dscho
