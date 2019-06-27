Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FB91F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0NMt (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:12:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45772 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0NMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:12:49 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so4529617ioc.12
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=woHe8hLOgc3AZIQfUFjPb4En7JyPGWGgbA5az012YaY=;
        b=gAp9OG37Jr1TNMzMhwaHELCvxxrraGfkWFif3pIeXdgnNUNcJ9Qv+aCZ+BF/I9DKd5
         PtYlNWME6QZkv3sE98Fv1knhyw684LfS8JCJcHRyf/k1qB60O3b9yZBJzgpzsjNjsq8c
         C6XbOTeUsM0ifwN2YIdXyFoFkZLcmNht9rYzhCZksEAQ6JMxa+PmHexVLgFki7eD9BZC
         3DBUC4S+Q1E05V6NJ8zMppjn5+AuvT0M3W+0XhFlCAuPvAiekLgUxgs3Y2INGrJd7Zqq
         E3wog95ue3+zuqChVtyrASNYvCMThH1/Zmf9icaJpq5g3CvsqEjJK1WXzqbEDzmujhJ6
         eIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=woHe8hLOgc3AZIQfUFjPb4En7JyPGWGgbA5az012YaY=;
        b=MM7AWSNBcKjB/ZtS3nCKwfvXLyPeRxzoHU3maz0I7/9vVks9pte0W8PgANVEDN0566
         x7SzhMC+8/mpCXDtp4b3I+zYRBUYZ1TSFt8ZMFUqEdcFgYLKU21c0Lezwz29oZWBCH9O
         4ecLSTf39IqlXxLspfiXmr5/pG7FydYZvynLZGjsnx1O7vdr4uB+vVmjQVEfDipXfP00
         XyhTXiLxfkAk0BTbdEAe1C0rio+0pLc78XcjDLjxIbd24XDPxjql/TGinBkBVXbpxmq8
         J/HoXpoVvDvBSzhFLVJGtaDtWNQKnoHRfcqBlaLpDRxNrt6GysjcuXjC4umvY9GjIBIH
         rDpg==
X-Gm-Message-State: APjAAAVCD8XDcv8IPvYzJzbIuk90stsNzFDtMGkWf0pLJmHkc5OzwVe3
        tkG7nf0Be7SUGWDWOKMJLn069oVNw32SuVtAhQ0=
X-Google-Smtp-Source: APXvYqx6abkEp1pN06md6QAeE7KdQ6naqWEPtpE2lVQAZToGylcm3zjmQS5BAkPHORs9ld0SqbZw3SMoWR0dgza3feg=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr4425751ioh.40.1561641168672;
 Thu, 27 Jun 2019 06:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190624095533.22162-1-pclouds@gmail.com> <20190624095533.22162-2-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1906271448290.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906271448290.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 20:12:22 +0700
Message-ID: <CACsJy8Avw0hh61Rr-xAWpOT_J8GKwFq=e4BYtFOfXHvpfpR0rw@mail.gmail.com>
Subject: Re: [PATCH 1/6] sha1-file.c: remove the_repo from read_object_with_reference()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 7:54 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Mon, 24 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 580fd38f41..85da7ee542 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -458,7 +458,8 @@ static int grep_submodule(struct grep_opt *opt,
> >               object =3D parse_object_or_die(oid, oid_to_hex(oid));
> >
> >               grep_read_lock();
> > -             data =3D read_object_with_reference(&object->oid, tree_ty=
pe,
> > +             data =3D read_object_with_reference(opt->repo,
> > +                                               &object->oid, tree_type=
,
>
> Junio's hunch was absolutely spot on. This conversion is incorrect. If yo=
u
> replace this `opt->repo` and...
>
> >                                                 &size, NULL);
> >               grep_read_unlock();
> >
> > @@ -623,7 +624,8 @@ static int grep_object(struct grep_opt *opt, const =
struct pathspec *pathspec,
> >               int hit, len;
> >
> >               grep_read_lock();
> > -             data =3D read_object_with_reference(&obj->oid, tree_type,
> > +             data =3D read_object_with_reference(opt->repo,
>
> ... this one with `the_repository`, t7814 starts passing again.
>
> It makes me very wary of this patch series that this bug has only been
> caught by a CI build. You probably did not run the test suite before
> sending this patch series.

I did. After Junio reported, I've ran a lot more and had the same
pass/fail-sometimes behavior.

> I also wonder what the rationale was to deviate from the strategy used in
> the remainder of the call sites, where no attempt was made to use an
> already-available repository pointer that might, or might not, be the
> correct one.

My strategy has always been "use the right repo if available, fall
back to the_repo otherwise". This code path has struct repo, my
mistake was not realize soon enough that there are two repos, not once
(Ironically I made the conversion to add subrepo here).

> It strikes me as a pretty important goal of this patch series to _not_
> change any behavior, and this bug makes me dubious that all diligence has
> been done to assure that.

Sooner or later all the_repo must be converted, what makes _this_
series different from other conversion series? Yes I slipped, I should
have been more careful to the parts related to submodule.
--=20
Duy
