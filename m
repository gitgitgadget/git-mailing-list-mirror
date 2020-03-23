Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E6C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8012072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lBItNKzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCWQ6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:58:25 -0400
Received: from mout.web.de ([212.227.17.12]:37439 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgCWQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 12:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584982702;
        bh=LK9S+gClRJqt7kFY0ovJAUwEzDnLEzBalftQMnE65bs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lBItNKzH1HhUXbHyY2omTmDHkq3wEoQ5iEPJ5+JdyFQJp+hZ8nNNVF+A8Qp13ocZA
         uAEjRY+45pHYHW/zMPeX9cAgFs5QtJUsMGJ7E7bxqpuRgTHGNu0Xjpmbodi3WnpbIj
         Xl5nvMcoSCbgVaBDi9ZAbc8hkePI/sCk8RrHFTEo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1jS3Ak3jgJ-00yR3C; Mon, 23
 Mar 2020 17:58:21 +0100
Date:   Mon, 23 Mar 2020 17:58:21 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Andr=E1s?= Kucsma <andras.kucsma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
Message-ID: <20200323165821.xk2kdw6tw5e3yqsy@tb-raspi4>
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
 <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
 <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:cM7j2GShsz0Stapk/4DShMCgpG553AOwaUCNRfZQoJqM9wPDYXW
 +WaLRFooZrhaUScKiEHKL65oV22Wv4+j+1Tte4eR8pfYmCh7ZCZchAirwiDlFSv29UpLdLN
 3g7l75fjlVI9Qq5UXW4PTm3z+BlldFxmBx3ZOH1pkoVB4HuGZCw+M9UO0brPo/Fls++4tVk
 5dUZuEK4iR0BQr34zFf9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:++S7mG1HvEg=:sV8cmbR734UG5VTOZWDptV
 c9A2hllfPY5aHJEsKxOxvm38rbcSNl+uDUpDzNmG83JyhQ1pDSFZ1xUxPfsG4m5ZbxXmhWgtG
 DFgwvQ2QJuJd3ammOUx7YdxvepXHd+Z0ODIXKOMXNbbp/NVryxmt3Pz9qJTkWTYEBdA/JLwDt
 QaXHuE8cN8i3QsnYAXors+TbbR0Ab2otMY8MvQ8wRJj8Z+eHnlnASSQ03gmZvolkGB/Pfa8ek
 pWhLhNp4/ic/6AUdiYkPWG2jxDHj7QSl/7xnIsXFNJ2SOgzaypXEj5ZFytnT2v2KP/Craj+fp
 alwANyvkBTV/l3ZoymBUj2YOsL3NhI7I+ikq7uEbqAIbct14WgMkwlfQ/kUb5FBEQJQ4gMpdX
 a8JyGfyF3gjkIMAtYL9SFae9Xxzj1RdQZpOnSmfvfCLC6FH4zwXppeVUnfMHgW+X7zfa+5e/M
 OTqEFmVYCKlfSk48NjKcMHAx4syHbD7kvM9w3ceYHRGiM/Xn53bXRYDIPEYzKqA7a+guae42P
 QToRveWnjqhJU9mMO2DVDdm2Pbo5/DpLFUCvqh2dvm1JIBVuAO8kpRNTD+P16d0hIZeMVqj/o
 Bmz8a8bI2W7Dg5KDNK5saCnRT/AD1+7fu93hvSRfEC3OLDHzEmxE31SRDeINMZTAvFf5O1nuH
 NBBq96YFON4DUWki6f+EhAiGT7+OOtp49OUGimlCWPwKihgdyDfE0pPNCHVesFbm5AL/PIwo7
 YMCAPLywx9Wyx/ArhTXlXszD6wd23H/Fktpn9euNxytMXnysZOwVnoCnSGm/Uvih6C5f4w5vl
 mdWDqc34rynnwC0pAgbt9K5EPxIPL3m4B2gYgwRcugDYntxjb63SdgEH2vgFtbGDEJLOA3MFg
 gAzUZLED9I+mNdETbBp8lxPRDh21+MVO3C8D5/4SKCxSD4oPf8UC0Z54L5uwUlrZGTmYJGYm/
 hC97caj5pcEKuPCh3gbu4M5FAasvOJCXJMDPCwGRu6tEBgvxJau+FSiQYMoXDmknX5+cOOLPH
 ZpzOOwR6lMfFOtJpZVegqf1OQzcImosyNZbDj+4LtfNJ95AjC8QeoDNQyEOwO0PmcwDqrg2z4
 I2Di569Rwfn53KjUvrTbGvr6slTAXFephoSDF7/ygBjX660LEtIC2D/Y7QQ2n3lI1QXbUYuUD
 uF2EOjvI71tJq0IhttYn0glLqNEitoOCPpxUBIG3DtO8/cjDV7rfmUkd3jcYT2GkW42CWSDke
 d+1WR26XhVy9oiTrR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 12:44:33PM +0100, Andr=E1s Kucsma wrote:
> On Sun, Mar 22, 2020 at 8:31 AM Torsten B=F6gershausen <tboegi@web.de> w=
rote:
> >
> > On Sat, Mar 21, 2020 at 12:42:50PM +0100, Andr=E1s Kucsma wrote:
> > > Hi All,
> > >
> > > I believe to have found an issue regarding properly executing the
> > > GIT_ASKPASS binary. I'm using Windows Server 2019, with git 2.21.0
> > > installed using cygwin.
> > >
> > > ## To reproduce:
> > >
> > > Assume you have the askpass binary at C:\askpass.bat. In CMD the
> > > following commands reproduce the issue:
> > >
> > > C:\> set GIT_ASKPASS=3DC:\askpass.bat
> > > C:\> git clone https://<private_repository>.git
> > > Cloning into '<private_repository>'...
> > > error: cannot run C:\askpass.bat: No such file or directory
> > > [... proceeds to interactively ask for username and password ...]
> > >
> > > On the other hand, if we change the GIT_ASKPASS environment variable
> > > slightly, so that there is a forward slash (/) instead of a backslas=
h
> > > (\), things work as expected:
> > >
> > > C:\> set GIT_ASKPASS=3DC:/askpass.bat
> > > C:\> git clone https://<private_repository>.git
> > > Cloning into '<private_repository>'...
> > > [... success ...]
> > >
> > > ## Some context:
> > >
> > > The source of the problem, is that if git doesn't find a forward sla=
sh
> > > anywhere in the path, it assumes it is not a real path and has to lo=
ok
> > > for the binary using the PATH environment variable. See in
> > > prepare_cmd():
> > > https://github.com/git/git/blob/98cedd0233e/run-command.c#L429-L439
> > >
> > > You can see that the "cannot run" error message is printed here, jus=
t
> > > after prepare_cmd() returned -1:
> > > https://github.com/git/git/blob/98cedd0233e/run-command.c#L749-L753
> > >
> > > I believe this was introduced in late 2018 around git v2.19.2,
> > > although I did not actually bisect the issue:
> > > https://github.com/git/git/commit/321fd823897#diff-7577a5178f8cdc0f7=
19e580577889f04R401-R415
> > >
> > >
> > > I hope I'm sharing this bug at the right forum. Please direct me to
> > > the proper place if not.
> >
> > Yes, you came to the rigth place.
> > Thanks for the report and the detailed analysis.
> >
> > A quick fix, and a begin of a patch, could be to use
> > has_dos_drive_prefix() which will look for C: and will therefore even =
work
> > with C:\
> >
> >         /*
> >          * If there are no '/' characters in the command then perform =
a path
> >          * lookup and use the resolved path as the command to exec.  I=
f there
> >          * are '/' characters, we have exec attempt to invoke the comm=
and
> >          * directly.
> >          */
> >         if ((!strchr(out->argv[1], '/')) ||
> >             (has_dos_drive_prefix(out->argv[1]))) {
> >                 char *program =3D locate_in_PATH(out->argv[1]);
> > []
> >
> > If you want to play around with the code a little bit, and send us a "=
git diff",
> > we can convert that into a patch.
> >
> > Wellcome to the Git community.
> >
> > >
> > > Thank you,
> > > Andras
>
> Thanks Torsten!
>
> I believe it is not enough to test only for the drive specifier, as
> GIT_ASKPASS has to work with relative paths as well:
> C:\SomeDirectory> set GIT_ASKPASS=3D.\SomeOtherDirectory\askpass.bat
> C:\SomeDirectory> git clone https://<some_private_repository>.git
>
> My proposal patch is to take advantage of find_last_dir_sep function's
> OS specific directory separator knowledge.
> I posted the diff below, which is also available on github here:
> https://github.com/git/git/compare/maint...r0mai:fix-prepare_cmd-windows=
-maint
>
> diff --git a/run-command.c b/run-command.c
> index f5e1149f9b..9fcc12ebf9 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out,
> const struct child_process *cmd)
>      }
>
>      /*
> -     * If there are no '/' characters in the command then perform a pat=
h
> -     * lookup and use the resolved path as the command to exec.  If the=
re
> -     * are '/' characters, we have exec attempt to invoke the command
> -     * directly.
> +     * If there are no dir separator characters in the command then per=
form
> +     * a path lookup and use the resolved path as the command to exec. =
If
> +     * there are dir separator characters, we have exec attempt to invo=
ke
> +     * the command directly.
>       */
> -    if (!strchr(out->argv[1], '/')) {
> +    if (find_last_dir_sep(out->argv[1]) =3D=3D NULL) {
>          char *program =3D locate_in_PATH(out->argv[1]);
>          if (program) {
>              free((char *)out->argv[1]);

Andr=E1s,
The patch looks good to me.
If you want, you can submit it here to the list,
either with git send-mail

or may be

https://gitgitgadget.github.io/

And please don't forget to sign-off the patch
