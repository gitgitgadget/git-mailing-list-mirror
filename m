Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7771CC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjAKMDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 07:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbjAKMCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 07:02:10 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C355A1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 03:59:44 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 194so12497293ybf.8
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 03:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2Dgrp5TFdaEp/7OGGprGpNt5GVd8WT+IvGIdSj4Erg=;
        b=E1u2zMBYW7eYqse4RPHTmWoMU5LkVwe3eSWcBxcghjbwp2f7M2kA8tNxMNY31SbtEh
         D2Ps33TrxYJ4rggl8lr0cCT1ifGDrR/meuLS0LWACSSJuPxiv/+HgeN2TbCG5lJE3Fo4
         Uf23lIS4+C3qwAUPesEn1/XHknvg3cdBdKjtVjasLpFVBZVF3+zIqkp44afQY5oJ37Bl
         MmZWAfD6P0iKuDcBeyXWlPPhr1I0KQWrc775fIJ0y7y25AxboNMH46gtpgzN07XYnGcT
         a6SCOWW/dJug+Qyg8Bm5CLvvY2xQ+bz4EZ2tBTgWm5/HBXyH2stsvjhBW7Pe/o1gS+pZ
         DgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2Dgrp5TFdaEp/7OGGprGpNt5GVd8WT+IvGIdSj4Erg=;
        b=dY1BihYOEUqDp6YWcUsz/RuiavDwau1uegEcwtImsCXD7gd3Xr07w0/wyC6UdtD8CX
         a9+CjmGtZjoWXdrFoVVLxwZ/FSVUaoikQD4cRSSI2BtVHKugxYc0KiBij8Va6kRusdzf
         7yTe5KH4u/GWGy6tYQq8hS1IO1AEW+QekMZwkLiTrWl3hfAvYJidM3YekMEf37lIjyr0
         mo5besubohR75/To3+WgL/HQ2p7rcVYpYcEU8dSibBc9qRUMoN9ZEJgczFLUNiD8zZ09
         uJ5qemFkudGhybYSKkM6+tVlUyHMUt8NgsqGskMIEbxhsGYP5vMoQQ6f5TPyD01eXBD6
         lnnQ==
X-Gm-Message-State: AFqh2kpunuMHQ2hmfRtSCkRMqlApXf2wRnWYSNyAW4qaE3Kxbupwbpqc
        0QxmRMjjtE4vu0V7pBqCDpLwpq1LwJu7pNod8WQ=
X-Google-Smtp-Source: AMrXdXvcbiVdluYrCfc/z1BySSqZoGxN3u0CZsT3o3AXN/KHLnYqRbxFFEyiZOH6lwKTe1TzNyzYl373SRX0OMOjbHI=
X-Received: by 2002:a25:5189:0:b0:7bf:d201:60cb with SMTP id
 f131-20020a255189000000b007bfd20160cbmr659988ybb.365.1673438383293; Wed, 11
 Jan 2023 03:59:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
 <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com> <1f8493b0-3f96-c616-1e4e-98b6ed33e8c4@github.com>
In-Reply-To: <1f8493b0-3f96-c616-1e4e-98b6ed33e8c4@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 11 Jan 2023 19:59:31 +0800
Message-ID: <CAOLTT8Q6sOkDLm7pnkJ6e7mi4MDu6PYKD6vSd0NZbO9qAWkFmw@mail.gmail.com>
Subject: Re: [PATCH v2] scalar: show progress if stderr refer to a terminal
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=BA=94 03:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/25/22 8:29 AM, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
>
> Sorry for the long wait in getting back to reviewing.
>

Ah, It's okay.

> > Sometimes when users use scalar to download a monorepo
> > with a long commit history, they want to check the
> > progress bar to know how long they still need to wait
> > during the fetch process, but scalar suppresses this
> > output by default.
> >
> > So let's check whether scalar stderr refer to a terminal,
> > if so, show progress, otherwise disable it.
>
> Thanks for updating to this strategy. I think it's an
> easier change to swallow. We can consider options like
> --progress, --verbose, or --quiet later while this
> change does the good work of showing terminal users
> helpful progress.
>

Yes, but I think something like `--quiet` is difficult to implement.
We cannot just add `--no-progress` or `--quiet` to the git checkout
for suppressing the progress. Because git checkout will not use it
to suppress the fetch progress, but only the checkout's progress.

> > +     int full_clone =3D 0, single_branch =3D 0, show_progress =3D isat=
ty(2);
>
> > -     if ((res =3D run_git("fetch", "--quiet", "origin", NULL))) {
> > +     if ((res =3D run_git("fetch", "--quiet",
> > +                             show_progress ? "--progress" : "--no-prog=
ress",
> > +                             "origin", NULL))) {
> >               warning(_("partial clone failed; attempting full clone"))=
;
> >
> >               if (set_config("remote.origin.promisor") ||
> > @@ -508,7 +510,9 @@ static int cmd_clone(int argc, const char **argv)
> >                       goto cleanup;
> >               }
> >
> > -             if ((res =3D run_git("fetch", "--quiet", "origin", NULL))=
)
> > +             if ((res =3D run_git("fetch", "--quiet",
> > +                                     show_progress ? "--progress" : "-=
-no-progress",
> > +                                     "origin", NULL)))
> Implementation looks correct.
>
> > +test_expect_success TTY 'progress with tty' '
> > +     enlistment=3Dprogress1 &&
> > +
> > +     test_config -C to-clone uploadpack.allowfilter true &&
> > +     test_config -C to-clone uploadpack.allowanysha1inwant true &&
> > +
> > +     test_terminal env GIT_PROGRESS_DELAY=3D0 \
> > +             scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>std=
err &&
>
> Thank you for creating this test!
>
> > +     grep --count "Enumerating objects" stderr >actual &&
> > +     echo 2 >expected &&
> > +     test_cmp expected actual &&
>
> I think you could use "test_line_count =3D 2 actual" here.
>

Oh, good suggestion. I should also use grep without `--count` too.

> > +     cleanup_clone $enlistment
> > +'
> > +
> > +test_expect_success 'progress without tty' '
> > +     enlistment=3Dprogress2 &&
> > +
> > +     test_config -C to-clone uploadpack.allowfilter true &&
> > +     test_config -C to-clone uploadpack.allowanysha1inwant true &&
> > +
> > +     scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
> > +     ! grep "Enumerating objects" stderr &&
> > +     ! grep "Updating files" stderr &&
>
> Here, it would be good to still have the GIT_PROGRESS_DELAY=3D0
> environment variable on the 'scalar clone' command to be sure
> we are not getting these lines because progress is turned off
> and not because it's running too quickly.
>

OK, that makes sense.

> > +     cleanup_clone $enlistment
> > +'
> >  test_done
>
> A nit: there should be an empty line between the end quote of
> the last test and "test_done".
>
> Thanks,
> -Stolee

Thanks,
-ZheNing Hu
