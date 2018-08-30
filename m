Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629D01F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeH3Szw (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:55:52 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41756 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeH3Szw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:55:52 -0400
Received: by mail-lj1-f181.google.com with SMTP id y17-v6so7517006ljy.8
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Wh2RBnEIvl/M0Edw9QJUXr3ejrLESDeu5gcUvS4J5hM=;
        b=XythUfWqb2pWDLqvcxhw0k009CQdHt0Zl1kcpC1VJfsA8oDyIB/rBU4AQ2AIHgdJAt
         5z4x/dmy9J4DSmyUwmMTTv1lyUEhCsHcJ8qbnpMaZvytv0bSdbzYjaAeOsSSddP9+dSY
         HLNoI1BWUh2Il5KdaTbN73KzCpnipx1gW8HlTl7i0W82+pRa/GS8OXpivAhGZrX7xkxq
         vGGVIAKxegbPA4JpeqFwaDRY2sUJ1+OtCxxi94nvLdkUMoMwPosH7Zfh69FfCzSkPfHs
         afnFS9jMzCZH+ExhZUeWzAmG18dVnseywIiWbGw7xEqCoDryVg8RKgrTQM4djHGSEbZh
         n6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Wh2RBnEIvl/M0Edw9QJUXr3ejrLESDeu5gcUvS4J5hM=;
        b=Va6SzlGxEgl8KuCeR/iVQ2eYYyhPXmQ9zyMElfCqAOwCBIx/Bjh6Up0cfOerJAD0yU
         c2No9UcsXyGlsVUNiM7ABnxTZ6cjQMh0Flo/T8ZeKQLo2s/xk4FEGO7PI3UfIdc6BsIj
         vpW8TYwfQkNUQtTV0rvX0dQA6QSjgVeaqAoGPRkWKgguCKXRIPQt0omLImo/XlydVqB7
         j5bwQWTpu/agkfaiHI5QIJUxiSxJe+r/o15ajI5cplrd/9AmbKA/SVM3MpcAKkZGo1hD
         McGNXF37Ey4GOLoWuazCtiAF9anEQKX7YzQcEkLGisCqDvlYeX3TdU6yCFoI0WAt6mJn
         TfxQ==
X-Gm-Message-State: APzg51DTSvxhZCKydTGT58U5eHQO1q+F4+/ukR+SB9bLMtsXnF4VrVGF
        LB+FyrCWAXp9nBR9V9lbfuM1P/XGU/bpa9Zhv2g=
X-Google-Smtp-Source: ANB0VdaH0MIHCQaJliSY2ykcvsAb2zQyOeHLIEtO8OARJfYP7Ell4vhPSBv1JjAA6Fr0PjSa4WHOi3F6JgqKN6Zjo44=
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr7344318ljb.91.1535640798880;
 Thu, 30 Aug 2018 07:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180827153524.GA18025@tor.lan> <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
 <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
In-Reply-To: <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 30 Aug 2018 09:53:07 -0500
X-Google-Sender-Auth: z2LDQQqdsYHuMRl70biFusgrJxA
Message-ID: <CAHd499AgNygMLiaLj=KSXDZJ8f3fAM60E9Pj=ADnc0POfrtKew@mail.gmail.com>
Subject: Re: Automatic core.autocrlf?
To:     rybak.a.v@gmail.com
Cc:     pclouds@gmail.com, tboegi@web.de, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 12:32 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> On 2018-08-27 17:52, Duy Nguyen wrote:
> > On Mon, Aug 27, 2018 at 5:37 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> >>> In those cases, when it falls back to
> >>> configuration for line ending management, I want it to be
> >>> automatically configured based on the host platform.
> >>
> >
> > An alternative is supporting conditional config includes based on
> > platform or host name, but I don't know if there are more use cases
> > like this to justify it.
> >
>
> How about just using unconditional includes?
>
> global.gitconfig (synced across machines):
>
>   [include]
>       path =3D platform-specific.gitconfig
>
> And two version of file named "platform-specific.gitconfig", which
> are not synced, and include only code.autocrlf setting.

I think I tried this some years back, but ended up ditching it because
when you modify settings via `git config --global`, it doesn't put
values in the right files. This is probably the best answer so far
though. It would still be great to have a mechanism that works within
1 file and is friendly to the git config command.
