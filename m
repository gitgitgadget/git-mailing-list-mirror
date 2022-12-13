Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B5C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 16:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiLMQhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 11:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiLMQhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 11:37:19 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318D25E9
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 08:37:18 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c140so18280702ybf.11
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 08:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LdY0+ZTTV8dSCPTe8xjXKLL7p7diaIihFFTjSNV6Ww=;
        b=YbRjVHc4fujJSQDDeYPROa3KnW1RBvd5ppAH2OfI0JhawTktChf+rUzrfBVy2CLVUm
         dcKswr5EIAuOO9cRsgb/oH6jCQiZuUeIiBxMV33rU4dQy3/uU+qm5siFfF6t/GWOvBYD
         x0BX327ueFQ3tWI2E8/OBnlx3vF0nkLRZzBGq1Z3rtVOGjGJatzxSJEj21EG2zGqSzhl
         h6M0JyaJNEbZCqtqAKpLsXs51bItAWCw8JgDJ6jgqVcvIzH0myHOmo1h3Fkla6vNqSCL
         WRjMlU4THzpo/EjPczhFP3UtICpwE9vx+PIw9by3cVqrKdWX74XYbnzx6FTcWMcCFiL2
         xQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LdY0+ZTTV8dSCPTe8xjXKLL7p7diaIihFFTjSNV6Ww=;
        b=AiOQHEQxYLiFRyOhLq38vFEj2ekto3/6T5VzgWf//oyDXqBHkjY3nvCSq1lWU5J/y4
         pb0zCyLQTXCnSy9Atgmt4NtRqqfJbYFt9ieMyE8BjGXMI7oyuV/5HedbhRxF60uZF/lA
         4T5hGovehciMgjjNAdJkOyh7OWE4KFbhXfQQpJJ1ok+1RwKGiCgu/3Wj2TFkkmyLm8gF
         IKLrNMGw85H7qGHeG91WJoeamfYG3fOhCQ22isI8LjhXhTUaTeNXoBBZBuAs6D4PtePo
         Y6FVzeeP/9HiVmKi/GhUJhxr6nZcJNvWksjgpk34O485aje4CSKrLJNxXsV/Od9FsCTr
         akfw==
X-Gm-Message-State: ANoB5pn9QCfqe5ZvjM/2//a42Hc5NrE5/a3rqgw+dsuAgAy37HhURBL+
        Uo4/4HD1aKvrCIz6qduw3xOY1x+MJcUKIxrOlC0=
X-Google-Smtp-Source: AA0mqf5o3Sd9Eguyqwzy+k1FONEL5YCwf6mIVNUhqEz0OaIIKN5WEsqKM2gddiPscfGTK5dvt+j+88Jk+NevaWT3MAU=
X-Received: by 2002:a25:254c:0:b0:707:78b7:5ab with SMTP id
 l73-20020a25254c000000b0070778b705abmr8401434ybl.300.1670949437995; Tue, 13
 Dec 2022 08:37:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com> <95e92f84-5f83-6439-0d02-f8060669a4d3@github.com>
In-Reply-To: <95e92f84-5f83-6439-0d02-f8060669a4d3@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 14 Dec 2022 00:37:06 +0800
Message-ID: <CAOLTT8TBtWAoN+etO_tDezN0e5yP1hSSzKn20SqvfDE-0o3pQQ@mail.gmail.com>
Subject: Re: [PATCH] scalar: use verbose mode in clone
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee <derrickstolee@github.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=88=
9=E6=97=A5=E5=91=A8=E4=BA=94 00:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/7/2022 1:10 PM, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Sometimes when users use scalar to download a monorepo
> > with a long commit history, they want to check the
> > progress bar to know how long they still need to wait
> > during the fetch process, but scalar suppresses this
> > output by default.
>
> I think this is an accurate description of the status quo.
>
> > So add `[--verbose| -v]` to scalar clone, to enable
> > fetch's output.
>
> However, this isn't the only thing we could consider doing.
>
> For instance, we typically use isatty(2) to detect if
> stderr is a terminal to determine if we should carry
> through progress indicators. It seems that maybe run_git()
> is not passing through stderr and thus diminishing the
> progress indicators to the fetch subprocess. It's worth
> looking into to see if there's a different approach that
> would get the same goal without needing a new option. It
> could also make your proposed '--verbose' to be implied
> by isatty(2).
>
> If being verbose becomes the implied default with isatty(2),
> then it might be better to add a --quiet option instead, to
> opt-out of the progress.
>

Good point that we should care about atty.

I guess you mean is to add a parameter to run_git(), which can
control if git commands show stderr/stdout... This solution
may be better. Because git checkout should also have the
same behavior as git fetch: quiet or verbose.

> Also, I'm not sure your implementation is doing the right
> thing.
>
> > -     if ((res =3D run_git("fetch", "--quiet", "origin", NULL))) {
> > +     if ((res =3D run_git("fetch", "origin",
> > +                        verbosity ? NULL : "--quiet",
> > +                        NULL))) {
> >               warning(_("partial clone failed; attempting full clone"))=
;
> >
> >               if (set_config("remote.origin.promisor") ||
> > @@ -508,7 +511,9 @@ static int cmd_clone(int argc, const char **argv)
> >                       goto cleanup;
> >               }
> >
> > -             if ((res =3D run_git("fetch", "--quiet", "origin", NULL))=
)
> > +             if ((res =3D run_git("fetch", "origin",
> > +                                verbosity ? NULL : "--quiet",
> > +                                NULL)))
>
> Specifically, here the "verbosity" being on does not change
> the way we are calling 'git fetch', so I do not expect the
> behavior to change with this calling pattern.
>

Sorry, but I don't understand: I deleted "--quiet", and the progress bar ca=
n
also be displayed. Why do you say "not change the way we are
calling 'git fetch'"=EF=BC=9F

> You might want to add the "--progress" option in the verbose
> case.
>

Good advice.

> As Taylor mentioned, a test might be helpful. Here's an
> example from t7700-repack.sh that sets up the isatty(2)
> configuration correctly, as well as sets the progress
> delay to 0 to be sure some progress indicators are written:
>
> test_expect_success TTY '--quiet disables progress' '
>         test_terminal env GIT_PROGRESS_DELAY=3D0 \
>                 git -C midx repack -ad --quiet --write-midx 2>stderr &&
>         test_must_be_empty stderr
> '
>

Thanks for the reminder, I will pay attention to this "TTY" and
"GIT_PROGRESS_DELAY" when I write tests later.

> Thanks,
> -Stolee

Thanks,
-ZheNing Hu
