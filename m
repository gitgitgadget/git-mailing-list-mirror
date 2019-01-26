Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30C81F453
	for <e@80x24.org>; Sat, 26 Jan 2019 23:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAZX5w (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 18:57:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33134 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfAZX5w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 18:57:52 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so10679291ioi.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 15:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VILsZEQuhSAYwTzqXwhj/+17/tSlG5hhOSTPZmzJpsE=;
        b=HG/Mm/oaocDWIZENPySuZLDFFglgRqN+yHajXGGI9Rjy5Tvx/J52lTIBTsiHUA6IZ+
         9eOgp8iN57WhHRHrVRrSemsKPHPuVKBFlt9LKvDwZnWZDR27AYXxmtXsWo4AkJNyHp/+
         NlAhct3bIN0J7EI+m3j96EDXllBf2XaO3GobzE9N7O8H0BOShtvrL/R7eGc0txom954E
         /JKzWCjgB1OElZycQV4JMVxRaqnrgRSqzkH8uhcZg55X9jvUuQ83XQBHBoUXYKDWUEIT
         kgVqDoISL87jkDnIYRsvpoEzVzBfo62J7E3VlxVH9hO10QPzFpFaKMm+anZexaH9UrVx
         w5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VILsZEQuhSAYwTzqXwhj/+17/tSlG5hhOSTPZmzJpsE=;
        b=MuZnc1CaDE/Z0Du+xeJf7VotoUgHIhxfn69UxAQZXKiwKYna2q7O3lYzo//TgBoPd3
         tfJM3PQzHjlnLK0JyuOU77F+K+acZG+fYifEx21sJTnr93ku58myf4JEqKpyCScqfOl/
         HFIfaXYcGyKomopW7UERDKVvE7BBFOTC1LLpBWP2paMefJM64hEi+YdFaWxsWenEODkg
         QNhAOQcfW6tuqYEdvGu6wWjPf1+JfB8FqicRxdxgR1a2L7fXOCheL0QHfPdndDeOOvw0
         ShiHyrTiAVKqY/Ix6JbsZ45QzJ9MtnB9Fz3gXcDUxeAPZKnTfoXlS2EdV1vlVC7q+dKu
         eZCg==
X-Gm-Message-State: AHQUAubV3Chn+5wiDkid9hARy3t/ihMeQPGDyKBCaV9SxsFl/1sfnd6v
        FmAdKKw16MK9ULiNQ9cHb5Zeh9h1S6t2vOjNteM=
X-Google-Smtp-Source: AHgI3Ia93/40+UgJYrapfD+R/+1EO3QRNlNBpfRBey9zeVLwtz35yX9E3qUJk/YdH5LdpG93pe7edMfJWw6rkg61XYE=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr8180817ior.282.1548547071217;
 Sat, 26 Jan 2019 15:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20190125095122.28719-1-pclouds@gmail.com> <xmqqef90fmi6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef90fmi6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 27 Jan 2019 06:57:24 +0700
Message-ID: <CACsJy8CzKoq41o09vNsQ=56mAtND_EaHxYN1VgVeLVTo=U2TUA@mail.gmail.com>
Subject: Re: [PATCH] fetch: prefer suffix substitution in compact fetch.output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 26, 2019 at 4:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > I have a remote named "jch" and it has a branch with the same name. And
> > fetch.output is set to "compact". Fetching this remote looks like this
> >
> >  From https://github.com/gitster/git
> >   + eb7fd39f6b...835363af2f jch                -> */jch  (forced update=
)
> >     6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
> >   * [new branch]            nd/diff-parseopt   -> jch/*
> >   * [new branch]            nd/the-index-final -> jch/*
> >
> > Notice that the local side of branch jch starts with "*" instead of
> > ending with it like the rest. It's not exactly wrong. It just looks
> > weird.
> >
> > This patch changes the find-and-replace code a bit to try finding prefi=
x
> > first before falling back to strstr() which finds a substring from left
> > to right. Now we have something less OCD
> >
> >  From https://github.com/gitster/git
> >   + eb7fd39f6b...835363af2f jch                -> jch/*  (forced update=
)
> >     6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
> >   * [new branch]            nd/diff-parseopt   -> jch/*
> >   * [new branch]            nd/the-index-final -> jch/*
>
> Sounds good.  I do not think strstr() would ever be correct in this
> application in the first place.  In what situation would it produce
> a reasonable result, I wonder?

I think it's useful for github pull requests. The remote side is
usually pull/<id>/head but when mapping to a local ref I think we
often don't want a ref ending with "head", just pull/<id>. In this
case, strstr() can pick the middle part and substitute it with "*".
--=20
Duy
