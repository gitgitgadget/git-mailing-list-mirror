Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4751C433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 02:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhLYCzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 21:55:22 -0500
Received: from mail-4324.protonmail.ch ([185.70.43.24]:28991 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhLYCzV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 21:55:21 -0500
Date:   Sat, 25 Dec 2021 02:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640400919;
        bh=7IQa0jS8atwhZgCilrggsoBZQczIUjIBk+ZtrwBVurU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=pL8EJ8viviitzzvL+2vo1OaTEdN3oS+7ZFPsJQGa9+6aFcqBL6vb3PYrfKiHM3Jxk
         FZmRVuICAIuxLwtE7yOkDRV/ZI6fcS1ufW8kYV0T4VogVxxRcfBQO76YO+pJCCMlJw
         3pdUMXiwH0AVQjQUoElMxAErxWtvcklLOZLm1ML71EuuLEazxJIpem/4Cnh5sV+4VB
         1MrOvib/CWw4yJhLu/3B8Wwz+DCzHUOmrBCbfjhgKjiTjUNXK/hUM2q5tKCgJXb2QX
         O5V3ffeOENjvpYCfJ3D8ogYCZ130QgYXQJStR/pkM4/bTkyd53pi8VfUaTJ7TePjfw
         2XbWlwbtebwpg==
To:     Philip Oakley <philipoakley@iee.email>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Lemuria <nekadek457@gmail.com>, git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Git internal command line parser
Message-ID: <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com>
In-Reply-To: <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com> <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email> <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com> <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If you are on Windows, it gets even more interesting because all the
> individual sub-commands are just hard links back to the single git.exe
> that then links to those sub-command's code.

That seems undesirable...
I know operating otherwise would be even more complicated and might create =
undue complexity or diminish performance, but I guess that, if it works, do=
n't mess with it.

> And I likely will consider this "front-end to many separate
executable apps" approach for my future large projects.

Lemuria, please consider those points as, sometimes, what is great at perfo=
rmance might not help with scalability and other matters, therefore, as the=
 designer/engineer of a software system, a choice must be made and an evalu=
ation of the properties of each possibility is a necessity.

Do with that what you will.

> I'm also a beginner to C, not quite an expert at it.

Practice programming a lot and never forget two things: [1] you are working=
 with a man made machine, therefore its limitations and capabilities are by=
 design, so you must consider them every step of the way when developing (l=
ike how computers send information, how computers process informations, how=
 machine behaviour can be altered, abused or exploited through alteration o=
f the environment or mechanism and through the use of sleight of hand). [2]=
 Your code always has real life consequences and it is your moral responsib=
ility to consider them and make sure that prejudice isn't codified into the=
m.

Those are my two tid bits about being a responsible and effective programme=
r.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em sexta-feira, 24 de dezembro de 2021 =C3=A0s 15:36, Philip Oakley <philip=
oakley@iee.email> escreveu:

> On 24/12/2021 18:30, Lemuria wrote:
>
> > On 25/12/2021 2:13 am, Philip Oakley wrote:
> >
> > > On 24/12/2021 14:38, Lemuria wrote:
> > >
> > > > #=3D< TLDR: Where's the code for git's internal command line parser=
?
> > > >
> > > > > =3D=3D=3D#
> > > >
> > > > I'm interested in the internals of git, more specifically it's comm=
and
> > > >
> > > > line parser.
> > >
> > > One place to start is https://github.com/git/git/blob/master/git.c
> >
> > Wait, is all of Git just one big executable or are there many
> >
> > executables and `git` is just the front-end for accessing the
> >
> > separate git executables, such as say, the one for processing
> >
> > commits?
>
> Yes, `git` is a front end.
>
> If you are on Windows, it gets even more interesting because all the
>
> individual sub-commands are just hard links back to the single git.exe
>
> that then links to those sub-command's code.
>
> > > > Does Git use a library like getopt for it's command line handling, =
or
> > > >
> > > > does it use a custom parser?
> > > >
> > > > If possible, I would appreciate being redirected to the source code
> > > >
> > > > files that handle this.
> > > >
> > > > Sincerely,
> > > >
> > > > Lemuria
> > >
> > > Philip
