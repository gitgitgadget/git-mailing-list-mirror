Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849561F453
	for <e@80x24.org>; Sat,  9 Feb 2019 05:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfBIFbH (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 00:31:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39903 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfBIFbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 00:31:07 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so14482132itl.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 21:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MBzqkRYQrbkdJur+R6p7pR8VOksiReLinItjgJPiVNk=;
        b=aS1TPQLBgxzYqu/1TdAMGK1D+VSmnGjT1fC8xXlKhvpkfnIUISsGXP6copvWfvIsFv
         D376K3DfR7b3tuwJiD/wDvkkPdyauLeqzJdncZdS46rOhmZRz4S0KhpYHiImsrgG4R0h
         gkRVYY2SsOoVkdX1tlVqo25hyjTFhR2U2kp7+TlPoK4U2K8/rSlGAqhNtfdrobVkBza6
         43MUEHBZFEg2MYflLIWvM9bvj2/5lwkuELRvMBVmHTGXLwkVRFZC6M2hqZjXV1NmvstJ
         /kHsyHD6EzXnKNPmEUY7NRR0bvTFRRe0aEUu1lFDLAuwQei6sBeHGz34GLguEI4/ucHv
         ZpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MBzqkRYQrbkdJur+R6p7pR8VOksiReLinItjgJPiVNk=;
        b=APu+84Q3fZpJhPTWctvSTxxONC2WdnhCmObHOgpc/FKwEUhxOKaXTYMsfXrN8rs8Kz
         xH/5nXII/UIPIXUjshLuSHxKYoOJHViQIfzsQJyrZNzEWzleEfpf6idbyzWlpnFapIdc
         mwUmZjqfYvOFnRHOQobejDkcwVMb6S9U194ap5nkav+yIED9QyinJmHWKlnApiYLz5pa
         RuNgBYn9+ma9F05C7Z2dUOCKcfDxLoYkViIERHHP9iqaBBlJc4WRDyB93hC9FKvxi3T0
         4GRECZ0sRhjkN4QqwmsPC2Ta4XGySExla+pvPWSVRlEpfGDHXKqr2e6oG31JzNesP+lE
         DaYw==
X-Gm-Message-State: AHQUAuYPiSyPTWD4XqpFU5p6P2O8c98AIL2xFu9UxOhlqPP+hFEYUa6J
        MCSmD644w5o9ppDZZ+rNUGV0AXYt2pvC0gHMyw8f+Q==
X-Google-Smtp-Source: AHgI3IZHq97qH7oYJ8Ow5Bnqj/h3VTqgihnZ1WWApRwf6VaoKAdFiXzY4WUSFr6uxI8Shosq/i4S0st4CsLl8up+YeM=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr11728171iol.236.1549690266088;
 Fri, 08 Feb 2019 21:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190208090401.14793-1-pclouds@gmail.com>
 <20190208090401.14793-19-pclouds@gmail.com> <20190208141915.GX10587@szeder.dev>
In-Reply-To: <20190208141915.GX10587@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Feb 2019 12:30:39 +0700
Message-ID: <CACsJy8Abn7xo6THsOrbt7NJ5ZohgTaWf+hKt+oVCFpHxE0r9KA@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] completion: support switch
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 8, 2019 at 9:19 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Fri, Feb 08, 2019 at 04:04:00PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > Completion support for --guess could be made better. If no --detach is
> > given, we should only provide a list of refs/heads/* and dwim ones,
> > not the entire ref space. But I still can't penetrate that
> > __git_refs() function yet.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  contrib/completion/git-completion.bash | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index 499e56f83d..891abb72d7 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2126,6 +2126,32 @@ _git_status ()
> >       __git_complete_index_file "$complete_opt"
> >  }
> >
> > +_git_switch ()
> > +{
> > +     case "$cur" in
> > +     --conflict=3D*)
> > +             __gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
> > +             ;;
> > +     --*)
> > +             __gitcomp_builtin switch
> > +             ;;
> > +     *)
> > +             # check if ---guess was specified to enable DWIM mode
>
> Nit: s/---/--/
>
> > +             local track_opt=3D only_local_ref=3Dn
> > +             if [ -n "$(__git_find_on_cmdline "-g --guess")" ]; then
> > +                     track_opt=3D'--track'
> > +             elif [ -z "$(__git_find_on_cmdline "-d --detach")" ]; the=
n
> > +                     only_local_ref=3Dy
> > +             fi
>
> Could these two options be used together?  I think they could.

It does not make much sense when dwim is active since you'll be
creating a new branch then detach from it. But yeah when you give a
real branch, no dwim, no new branch created, then "git switch -dg"
should work. Will fix.

> If
> that's the case, then the two conditions shouldn't be chained with
> elif, but should be two separate if statements (even eliminating
> $only_local_ref, while at it?).  If that's not the case, then the two
> __git_find_on_cmdline() calls could be combined into one, and a case
> statement could act according the option found, sparing one of the
> subshells from the two.
>
> > +             if [ $only_local_ref =3D y ]; then
> > +                     __gitcomp_direct "$(__git_heads "" "$cur" " ")"
> > +             else
> > +                     __git_complete_refs $track_opt
> > +             fi
> > +             ;;
> > +     esac
> > +}
> > +
> >  __git_config_get_set_variables ()
> >  {
> >       local prevword word config_file=3D c=3D$cword
> > --
> > 2.20.1.682.gd5861c6d90
> >
--=20
Duy
