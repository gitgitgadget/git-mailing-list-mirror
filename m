Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7476820248
	for <e@80x24.org>; Wed,  6 Mar 2019 09:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfCFJZz (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 04:25:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40352 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfCFJZz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 04:25:55 -0500
Received: by mail-it1-f193.google.com with SMTP id l139so9112448ita.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 01:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mx1zl0Bu9j5Q9nUe4tinfMXt0yuMPuDrEN4SHeOGzoY=;
        b=IamF9nAYwTF97cypsrEFqRG9nGzIBqV2DuFrZZ/gyJrQbk+jZzJzQCjUyG6vVgAokN
         8pRNdfgx1/nlSy8q+NXB1Ic3MLJyfp4eWvU+fhGm4dvXxiA/4/mg5g7+VF+2QHhyqObQ
         obpaJEHnU2/Q8cKs3dcf8RsG/xcOyuCvt2qpw0JAZN+bKiVrmCc78LjxDdN8iyvIyMa9
         g8sVKBBBYEQZmnkM67u9chWDSRoUl/zafIuO0oDKFmNX/sfMq3WGlArlI6Rsu43yw7W/
         89Iw1KO8ZCeV5VTijxwDi5CK9Cz7xLir940K+yBdco4Glcl5L/ex9puw3672Xr3DJeiG
         jXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mx1zl0Bu9j5Q9nUe4tinfMXt0yuMPuDrEN4SHeOGzoY=;
        b=qv02BwOVdD70q4Ck7f+SxC+9+kGmFN3ZoapLzexZZThtKDq9PB442DxrRgS+jWAiD3
         Viyx85wmroxa0uaLPz28jYvFc7MpOXNDnpCOGBV6GMPDuJAIT3BpQrW/XCgoriF5ME/L
         EdFoo083NlValVAfNj42eqkWu1zsIe13KGp9PHFb0iWpSPHqYBprqS7Bofbg1eTV7qiP
         0UB6753q5flKFoci1IKD5IW0lZWY6vOa2oNH+M2vm5ppTO/rclq1uKAZmpBYyLkTMOcB
         BJM7hpmEAZZ2khL6iEviKWDs1Do1UgYcPYo/Gts8yTD+jfbZiOrUupLnjlWbWn4dYTQC
         27lg==
X-Gm-Message-State: APjAAAV/5/2IS81PFSfq8fteiLwB2ttnYJHfmS91U6/I5hSOs8OOHUf/
        ALM10bTp26wroC7D0wNtiPpNZ5zn0Pj8SaWf+PJvCA==
X-Google-Smtp-Source: APXvYqyBEOveq6FxvxvaczXMjhPfyrD4oWTLNifNsoFxqsR/PsNMQ+8qmX3Ne1zdFC1upaEgH3G+vNGvC7vJvqyDCPk=
X-Received: by 2002:a02:7e87:: with SMTP id g7mr3573628jae.92.1551864354086;
 Wed, 06 Mar 2019 01:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20190305123026.7266-1-pclouds@gmail.com> <20190305123026.7266-17-pclouds@gmail.com>
 <CAPig+cR-efk5esa9=5j+Fu0eWxAkFnohkSL4eabrP44K_AkdCg@mail.gmail.com>
In-Reply-To: <CAPig+cR-efk5esa9=5j+Fu0eWxAkFnohkSL4eabrP44K_AkdCg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Mar 2019 16:25:28 +0700
Message-ID: <CACsJy8CtewTfFUwJwRK4BzF+kBq1OvmDwgsWEzf8Y8o=_0_nZw@mail.gmail.com>
Subject: Re: [PATCH 16/20] diff-parseopt: convert --quiet
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 10:42 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Tue, Mar 5, 2019 at 7:32 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> > diff --git a/diff.c b/diff.c
> > @@ -5299,6 +5299,8 @@ static void prep_parse_options(struct diff_option=
s *options)
> > +               OPT_BOOL(0, "quiet", &options->flags.quick,
> > +                        N_("disable all output of the program")),
>
> As a reviewer, I was wondering why you didn't use OPT__QUIET() here, but.=
..

It probably just didn't occur to me. After doing a couple conversions,
you kinda get in a routine and forget to question if your choice is
the right one.

> > @@ -5348,9 +5350,7 @@ int diff_opt_parse(struct diff_options *options,
> > -       } else if (!strcmp(arg, "--quiet"))
> > -               options->flags.quick =3D 1;
> > -       else if (!strcmp(arg, "--ext-diff"))
>
> I guess the reason is that flags.quick isn't necessarily about
> verbosity/quietness.

Also OPT__QUIET() adds the short option -q. Adding that, even if
helpful, should be done separately.
--=20
Duy
