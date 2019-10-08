Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2031F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 09:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJHJGU (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 05:06:20 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33494 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfJHJGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 05:06:20 -0400
Received: by mail-vk1-f195.google.com with SMTP id q186so3615109vkb.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wsDDKxgFfTkBl9f6lokIxN07mvEKGAG5lmMKpBBDMs4=;
        b=MeLRt+Uz4SBoVt4/uF4Y++pkozMr3P85qNImcaMMwzZps8twBsCgW/fGkdIC2XAEu1
         K4o3FozidyB/a6+1sXyXv3tb3I8HsHuy+bFqXZOeIZYcDMpfr7oOZEdKa49+NLhA7v4C
         xBe/4UJYF+WUplZpF+T+qW+DyOAl3OZ6qsMCljAPuZSaJ04Ic3gU5QvNMsAEDSSdzqyQ
         +C2XFMVGA0DX6UHdkO4zPPc0A8sh+M0An5GjOWn7Bqj7YRoRYC+04ZroILHQGWvo3sJY
         zIJ1WBDLIlNMl9TbmC1x/DqQ2ShknS3SJw21quM0mPBBZJgIRF9+h2562VY/Znh2I0FM
         djdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wsDDKxgFfTkBl9f6lokIxN07mvEKGAG5lmMKpBBDMs4=;
        b=QLlAKbfU9e1n+/goMWT4ZzBmBy2uj7esgerYYaDKq2qrz096RXHagxXJjL97A//vcF
         wL7Yztw4nq4B6BuoEgsTuajw3J5UIBjBAH7KUXQOWmTpIA0KCysaZ8c/sbXD/C79uCLB
         LWMddWvTQZ5wCNIX2CeSJoeNKOrDp5ILFwSv4WXpot3l3wX1zX4IKTMPOH+BF2GEGOPc
         XP14+8KqyrfO9ePvYJnsWEcdTCnU3mH2hpnuedA/z6jz3DTaa67JvA2lDoqELkm85ddx
         tBKwR1Ivcjgb5H2f9S5axqN9mF4NbGtjuEcGO00Jc95oPT/9zdU9oN9VGaF7QGy7Laxy
         4B7g==
X-Gm-Message-State: APjAAAWj3PBIdC9H80DPAIm+SPMCnHnj1/ATHLpgCulcZdDmUa+tzrjq
        dgYqIBBWkSfAYCriQ+geh3/zTKAmAYrtEE2iikhDfQ==
X-Google-Smtp-Source: APXvYqyKWchudCPk3UXFjqvJ2RFCoskBtjNfSI1hGG0yyYfZaKB9QSp4km7y6+YoOVVCaHS+ikZa4VNOhvqJKyqXDfw=
X-Received: by 2002:a1f:5cd4:: with SMTP id q203mr10351097vkb.53.1570525578903;
 Tue, 08 Oct 2019 02:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
 <20191007210306.GF11529@szeder.dev>
In-Reply-To: <20191007210306.GF11529@szeder.dev>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 8 Oct 2019 11:06:07 +0200
Message-ID: <CAKPyHN2pX+QnktdWZh7huwnj_6eZ=s06A8mfWhUDKOc+Yn8qZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] format-patch: create leading components of output directory
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 11:03 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sat, Oct 05, 2019 at 10:43:51AM +0200, Bert Wesarg wrote:
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 83f52614d3..2f2cd6fea6 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -1606,6 +1606,26 @@ test_expect_success 'From line has expected form=
at' '
> >       test_cmp from filtered
> >  '
> >
> > +test_expect_success 'format-patch -o with no leading directories' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches master..side &&
> > +     git rev-list master..side >list &&
> > +     test_line_count =3D $(ls patches | wc -l) list
>
> This is sort of a nit...
>
> So, these tests check that 'git rev-list ...' lists as many commits as
> the number of files created by 'git format-patch'.  While it doesn't
> affect the tests' correctness, this is subtly different from checking
> that 'git format-patch' created as many files as the number of commits
> listed by 'git rev-list'.
>
> Consider how the tests' output would look like on failure:
> 'test_line_count' shows an error message that includes the content of
> the file to be checked, which in this case would consist of a bunch of
> commit object ids:
>
>   test_line_count: line count for list !=3D 3
>   f7af51d27933a90554b6e9212a7e5d4ad1c74569
>   bd89fce9f5096eb5cad67c342b40818b7e3ce9e4
>
> On one hand, these object ids won't mean much to anyone who might have
> to debug such a test failure in the future, and on the other these
> tests are about 'git format-patch', not about 'git rev-list'.  If the
> check were written like this:
>
>   count=3D$(git rev-list --count master..side) &&
>   ls patches >list &&
>   test_line_count =3D $count list
>
> then the error message on failure would look something like this:
>
>   test_line_count: line count for list !=3D 3
>   0001-first.patch
>   0002-second.patch
>
> which, I think, would be more useful.

thanks for this detail. As I copied an existing test with this
pattern, I will add a new pre-patch to this serires which applies your
idea to the existing test first, before I add new tests for this
patch.

Bert

>
>
> > +'
> > +
> > +test_expect_success 'format-patch -o with leading existing directories=
' '
> > +     git format-patch -o patches/side master..side &&
> > +     git rev-list master..side >list &&
> > +     test_line_count =3D $(ls patches/side | wc -l) list
> > +'
> > +
> > +test_expect_success 'format-patch -o with leading non-existing directo=
ries' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches/side master..side &&
> > +     git rev-list master..side >list &&
> > +     test_line_count =3D $(ls patches/side | wc -l) list
> > +'
> > +
> >  test_expect_success 'format-patch format.outputDirectory option' '
> >       test_config format.outputDirectory patches &&
> >       rm -fr patches &&
> > --
> > 2.23.0.11.g242cf7f110
> >
