Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DB11F453
	for <e@80x24.org>; Sun, 27 Jan 2019 07:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfA0HOa (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 02:14:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38750 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfA0HOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 02:14:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so11605041lja.5
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 23:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rh22rL5NS+fMK6ycQWz06TZUWK1mE+nx/ju6kPzyy24=;
        b=r8vdKPUbRZyupCECevnQO/kuI5RtpWq6sArF3/MOo//+ijyNbbVpzWnNBr2jAjiNAD
         foIrK1nGvvKaf/o/Yh7zY6Vl5IIXqu6LcL8+74Ro5FP4eGQ67W7zO/0IZAr8MEe0fR0W
         0IWo0H52tLAt7VIIu2o9x9d9vAxjnF4zQjSd0PDDhD8K1BqUCwelFeW4HY1bJGh/PEaG
         nnNA/397cHWiQp6Pc9brr7RitmenKhXCDljvR1lbdKazY8f7DGbFQd9rKJUNSQnwMeem
         EDZvCrHNkVvuB06KhxoJd62OKRievQqMR6isD/Jl8LYTyh2Rc86FQMpwZp3heUvJwqid
         xU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rh22rL5NS+fMK6ycQWz06TZUWK1mE+nx/ju6kPzyy24=;
        b=g5lJJ7HPADeQXMf9qvIPfE8JNdXZ1iZvL0nWYkjSuXGlZ3eXC5zEBMxyiQXcesZAQ7
         tVQ79Fnt43TJ4UiKyqeIKr5j9r80anZoioT4ipknKTQaOxjxP4/ah/ggmWPRaIgjpMMy
         G2UmqY+SU6hKltPwVB7yEPulQEZ8PyxF3OBOiXBCMARca5CPQHFSOan4qBSZmG3v0hWe
         jLXaKyGaKlICIO7YeabF1VP8Ph0R6RUEP53gtVHmbekC2Gr274gpnnUBWND62eE6qS+B
         KiUl6z4H1obrpciJX/L6lcoejengh7myvtw4GtJKQQqgvZULEcC3E5D82WaGmnLjJcCM
         BKlQ==
X-Gm-Message-State: AJcUukc4iFjqbOUFCgmQSGoA9JIvgQr4sFLb4nd1Yx7FnUnatF+qxMVn
        aOLis5jb+Oe4dPmjWZdEXlNESg2/LJVlu8rydv8=
X-Google-Smtp-Source: ALg8bN6JkOs6U2iAqe1faYqndqa9itXKmzvpLmwht+UvYwiV89CjMChvwtbbXGI88g+hGcjjYqIuhdpCx889aqvop/8=
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr12430571ljg.138.1548573268027;
 Sat, 26 Jan 2019 23:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20190126204951.42455-1-koraktor@gmail.com> <CACsJy8A6hF+Sxitpt3J9EmDEXjGb2e+AeMtJDaE7Y32fg4NEKA@mail.gmail.com>
In-Reply-To: <CACsJy8A6hF+Sxitpt3J9EmDEXjGb2e+AeMtJDaE7Y32fg4NEKA@mail.gmail.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sun, 27 Jan 2019 08:13:51 +0100
Message-ID: <CA+xP2SbLwmeWpqmjCiqojra5Mwrbok7sjvUsvCsaAo6XsWBbtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Add tests for describe with --work-tree
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am So., 27. Jan. 2019 um 01:07 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
>
> On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wro=
te:
> >
> > The dirty ones are already passing, but just because describe is compar=
ing
> > with the wrong working tree.
> >
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  t/t6120-describe.sh | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > index d639d94696..9a6bd1541f 100755
> > --- a/t/t6120-describe.sh
> > +++ b/t/t6120-describe.sh
> > @@ -28,6 +28,24 @@ check_describe () {
> >         '
> >  }
> >
> > +check_describe_worktree () {
> > +  cd "$TEST_DIRECTORY"
>
> Strange alignment. We normally do it in a subshell...

Sure, will fix this.

>
> > +       expect=3D"$1"
> > +       shift
> > +       R=3D$(git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH=
_DIRECTORY" describe "$@" 2>err.actual)
>
> These commands should be executed inside test_expect_success, not
> outside. And you need to chain commands with && to make sure if
> something breaks, then the whole test will fai.
>
> If it's too ugly to generate test_expect_success with a shell
> function, then just write a shell function that "describe" and compare
> (i.e. the test body). Then you can write something like this later
>
> test_expect_sucesss 'describe with --worktree foo' '
>         check_describe_worktree foo
> '
>
> and check_describe_worktree can now do
>
> ( cd "$TEST_DIRECTORY" && .... )
>
>

My function is a modified version of check_describe(). Which does the
same thing. I=E2=80=98m not really experienced in Shell programming, so I d=
idn=E2=80=98t
see a cleaner way.
But having the cd commands in the && chain looks broken as it would
break the following tests when one test fails and the code was executed
in the wrong directory afterwards.


>
> > +       S=3D$?
> > +       cat err.actual >&3
> > +       test_expect_success "describe with --work-tree $*" '
> > +       test $S =3D 0 &&
> > +       case "$R" in
> > +       $expect)        echo happy ;;
> > +       *)      echo "Oops - $R is not $expect";
> > +               false ;;
> > +       esac
> > +       '
> > +  cd "$TRASH_DIRECTORY"
> > +}
> > +
> >  test_expect_success setup '
> >
> >         test_tick &&
> > @@ -145,14 +163,20 @@ check_describe A-* HEAD
> >
> >  check_describe "A-*[0-9a-f]" --dirty
> >
> > +check_describe_worktree "A-*[0-9a-f]" --dirty
> > +
> >  test_expect_success 'set-up dirty work tree' '
> >         echo >>file
> >  '
> >
> >  check_describe "A-*[0-9a-f]-dirty" --dirty
> >
> > +check_describe_worktree "A-*[0-9a-f]-dirty" --dirty
> > +
> >  check_describe "A-*[0-9a-f].mod" --dirty=3D.mod
> >
> > +check_describe_worktree "A-*[0-9a-f].mod" --dirty=3D.mod
> > +
> >  test_expect_success 'describe --dirty HEAD' '
> >         test_must_fail git describe --dirty HEAD
> >  '
> > --
> > 2.20.1
> >
>
>
> --
> Duy
