Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B411F453
	for <e@80x24.org>; Mon, 22 Oct 2018 14:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeJVWom (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 18:44:42 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36256 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeJVWom (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 18:44:42 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so12708962itd.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/+MwIS3hUELGRa1RYGE7iFLa91h0oz3U0ny6TmVk5I=;
        b=NB1qE7/Evx/WdyVAZBm4icGvUbwqdzuDX0gQ39mPi4X4emm2Fh5L+3vADdZo/MSsR8
         yiocwAjg6mhqMHM0b4YsYD/8xrHMrflPAQduJcYOZWhRtUlqJ+CJMvekiXrcmPa1u3aq
         jQ9Q0eb6eEAzq9zBONBTTf/GArGSvLY3J+yQsDS68O1uVCE0+iZRfY9zG3hel10h1+yE
         AwUplu8gi1eRrDvhw4e3JQ/Fl2gqRYoJP6J6X726yexbJnwtC875Zwx5MA/DLwSA8OFa
         VVssBvL1RO1nIiUHfoDZrEdMjBHxgGxUKfkhCijKQIohz9qBz8l9k+eeXyv2T9PG/L3Z
         eXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/+MwIS3hUELGRa1RYGE7iFLa91h0oz3U0ny6TmVk5I=;
        b=OA0pinMyC4rQpTpU9r999P/i1bTNmf2g0edCDU/1+/Ze6mh6pXR5hWnPncznQ1CnP1
         KcixeGLO41eaZCoCK78Hj6sT1eY0Tr+3IWDO/BUbLu0uPxsTJixWX/5dU4ATYU1+Iv6b
         Yc2vU0JeGHgyQrbNAzVoK9IJz9bF82Vf3NZ87x0b3eFbE+OkFr71nV1jrqrmMN/9TS9n
         bPCpDJF9A0b2yFb3eCSd8uV7bs4G98oYctWXlAthTFJcp6WcwtS0yECeg5WCdhjLeqFn
         QJm5qGp/H58gKLFLo557mSx8uuATPPnBjpgWb/lWsiqV6+F3kYMOvBwD41Mb16VT2g7X
         KV7g==
X-Gm-Message-State: ABuFfojeaurxN2edMbbjDSKczWJkTxMcgx6G+kkmTPlIrfnBI6dNxrXG
        iHlJDhSqj9gFlQi3SjlOKwweJqYFGfCSYwTst90=
X-Google-Smtp-Source: ACcGV61yzFk+LAKnkRgm+ioppUaBx0rnyHjASSOGbofNVNOuVX12zM8qB81lwK61L/Th9FJhMCG32J+J+9Y9EfpCllE=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr10090416itg.70.1540218354104;
 Mon, 22 Oct 2018 07:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181021084102.8318-1-pclouds@gmail.com> <20181022101719.GE30222@szeder.dev>
In-Reply-To: <20181022101719.GE30222@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 16:25:27 +0200
Message-ID: <CACsJy8DUrVJu0HN7kuCeo4iV5aimWbYtr+E-7kenPVDx90DpGw@mail.gmail.com>
Subject: Re: [PATCH] completion: use __gitcomp_builtin for format-patch
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 12:17 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Sun, Oct 21, 2018 at 10:41:02AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > This helps format-patch gain completion for a couple new options,
> > notably --range-diff.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  Of course it will be even better if I could complete the ref for
> >  --range-diff=3D, but maybe another day.
> >
> >  contrib/completion/git-completion.bash | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index c8fdcf8644..065b922777 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1533,12 +1533,8 @@ _git_fetch ()
> >  }
> >
> >  __git_format_patch_options=3D"
> > -     --stdout --attach --no-attach --thread --thread=3D --no-thread
> > -     --numbered --start-number --numbered-files --keep-subject --signo=
ff
> > -     --signature --no-signature --in-reply-to=3D --cc=3D --full-index =
--binary
> > -     --not --all --cover-letter --no-prefix --src-prefix=3D --dst-pref=
ix=3D
> > -     --inline --suffix=3D --ignore-if-in-upstream --subject-prefix=3D
> > -     --output-directory --reroll-count --to=3D --quiet --notes
> > +     --full-index --not --all --no-prefix --src-prefix=3D
> > +     --dst-prefix=3D --notes
> >  "
>
> $__git_format_patch_options is also used when completing 'git
> send-email's options, thus removing all these options will badly
> affect that, and in fact makes 't9902-completion.sh' fail with:

Oops. I guess I was excited about the other fix and forgot to test
this patch. Junio please kick it out of 'pu'.

I'll need to think if I could somehow make send-email work without
hardcoding a bunch of options in it.,,
--=20
Duy
