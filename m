Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8DCC76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 11:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCaLAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjCaK77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 06:59:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909365FFC
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 03:57:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r187so26904050ybr.6
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PdW5ik7+YqtMoKTyQ7qoOj39zaTFKQw0omVCqI+3k4=;
        b=PyahuqiUP7Dps8A4Lb6bq6ldC7ZscktT9ajMSFjs+EjqodXaOZQYLRWzwycMOxnzTz
         GebWzmeWTv8057pB4F7zRgnRu33eB0o5F0BypCAMuE9cffV+9AhXyik5yj0txHPQcMr8
         6MaOXyn9UVFYoHotSMp9OUlY3pAyqnX0uaadI185OhNVXzO9xNWqz2bmJPh3zJ8C8qjy
         Q6KDfD+rX0vvKDcc6mAP2RHaDl1s57xRow3LzjmiGyiwMKO2oge4tVksH80Vs90xqXo/
         q6IEyzL23PG71acI5SDIcj2vC7yVsuFeIRWAVJNjzg9TMzItN+rojZGLiEBP+j9JMJ3p
         c4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PdW5ik7+YqtMoKTyQ7qoOj39zaTFKQw0omVCqI+3k4=;
        b=AHjgqSkK3B7Pf5ByH7BDbCvbimUaNki6GA57yMoCctY84bU01RiRVSexykxu8dBgb9
         +Fnbn+ocxD7K6XhMq7ms/p7CINvKRoMBKqJG+W2gU7ea/RV/xFW3lVbP7vOgho4bHuMc
         I92/SwWGZLju0/m+IYMjkSZ6SNIxN1dya5DZxQ2dDahNfhGXNna+GmHSMGMkxTH4oyYG
         pnvAiBE/a+w+3v2JuBi8nFKgEm4APMZXSwSAG2HrJswxwmeDPHoJ/lWy49hDrpx/vjiA
         35mfK4bCWQDPwCAdcFn3GJFgh/P2Clhn1j9hADwTfV22JvshJsQ+ZFdj+nZPi2BN8ii7
         csFw==
X-Gm-Message-State: AAQBX9fe1MSaz1Kcc0HvBgSXHo9U0QSNbvSxWBqXrqcqnEYFPcD+BKwt
        mdSanYsPt/URK58l7nH4fie+Xl2mzK7o2zKVMHE=
X-Google-Smtp-Source: AKy350b8QsWVV9pm35bC9tRFFKl0ynLk9yZqfnctOhOnDjura9yMx7F5DLPnAQc8dHfG7FenVB4ZBSc/h/9pT+IuS9c=
X-Received: by 2002:a05:6902:1204:b0:b3b:fb47:8534 with SMTP id
 s4-20020a056902120400b00b3bfb478534mr14647991ybu.5.1680260272232; Fri, 31 Mar
 2023 03:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqjzyy2rdl.fsf@gitster.g> <20230331103708.18945-1-oystwa@gmail.com>
In-Reply-To: <20230331103708.18945-1-oystwa@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 31 Mar 2023 18:57:42 +0800
Message-ID: <CAOLTT8SAo7rJ2NP4wTsSSJ18-qBV42ZhFHF6pRwRqHwhKaQUvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: remove unused ref_format member
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=BA=94 18:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 30 Mar 2023 at 17:25, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > =C3=98ystein Walle <oystwa@gmail.com> writes:
> > >
> > >> use_rest was added in b9dee075eb (ref-filter: add %(rest) atom,
> > >> 2021-07-26) but was never used. As far as I can tell it was used in =
a
> > >> later patch that was submitted to the mailing list but never applied=
.
> > >>
> > >> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> > >> ---
> > >> Would be nice to have a link to the email thread here, but I don't k=
now
> > >> how.
> > >
> > >
> > > Here is a link to the patch that led to that commit you cited:
> > >
> > > https://lore.kernel.org/git/207cc5129649e767036d8467ea7c884c3f664cc7.=
1627270010.git.gitgitgadget@gmail.com/
> > >
> > > It indeed is cumbersome to add, as the Message-Ids for patches from
> > > GitGitGadget tend to be ultra long.
> > >
> > > But b9dee075eb was the last one in the 5-patch series; I do
> > > not see any "later patch there in the thread.
> >
> > I think there was a follow-up RFC series that was written to use the
> > value of the member, cf.
> >
> > https://lore.kernel.org/git/9c5fddf6885875ccd3ce3f047bb938c77d9bbca2.16=
28842990.git.gitgitgadget@gmail.com/
> >
> > but it seems there was no review on the series.
>
> The follow-up series you link to seems to be a superset of the first seri=
es,
> which is what confused me. This is why I thought perhaps a subset of the =
latter
> series was accepted. But I see now that the dates match that of the first
> series, and you even applied it very soon after. Strange choice to includ=
e the
> first five patches in the follow-up series, then...
>
> Looked through the git.git log and see that it's not uncommon to referenc=
e
> patches from lore.kernel.org, so I can do the same. Perhaps in the "footn=
ote
> style" to make it easier to digest. That is, if we want to apply this in =
the
> first place... It is a very minor cleanup of something that does no harm.=
 On
> the other hand this particlar line of development seems abandoned.
>

Yes. Originally, I hoped to make all the atoms of cat-file --format compati=
ble
with ref-filter, and then make cat-file --format able to use the
interface of ref-filter
But due to some performance issues, this route is now deprecated. This litt=
le
%(rest) is no longer useful.

> =C3=98sse

ZheNing
