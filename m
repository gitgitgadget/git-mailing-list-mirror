Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161171F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 15:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfJKPpc (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 11:45:32 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36709 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJKPpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 11:45:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id v19so6541862vsv.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0GQoECExD/RluVYFD43usyAxUAgD/Eh76QpvEjO0MCI=;
        b=J9dSgTAmNjjMQRxllM8ulsRROdSyXAbqVGegimtbE2AiYTOPhQffRqd/IsmVkskREK
         oKyCzklFCtX1/ohkBGIP+hOUJH6dXYtt+4TeHY7/6zaUHu+t86lKWn/e1SW5nr75Bkcy
         gvx46gGsiFQPpCYEkPQUIkz5WMPhbiXsxmOYeWN3heoW5Be/MaDXVGetPkZfz02zXS3w
         s6JK5LJz8gT6yWJ4Lu9QU4XnyB5FXzvClEFOI5X+64lFm9xkhBitJjMroKVsLAZGJKYm
         jY/506vH1aaerXHnBrAH7WAlyM1qb5xBy5Rj3GSEjyL0utaDO/0cxt0KzbOThPOttZps
         UCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0GQoECExD/RluVYFD43usyAxUAgD/Eh76QpvEjO0MCI=;
        b=AVMLiPJcz0G+Y9mlwHMxChLQznC3+niAfGIgGTnL8wjX19SPpGNJKeNnBNGj5zGd2n
         P0voSWakztSxSFlivwvP0TevNvO4vm06UQDasAcbGygFiG6tPwDIax24w2FoOmvVXxQi
         DyUzoBDBIX7lFAq4u+ZJjhCXCbyAkYEF44qr5reMW5gmdWsZsVyYEpnRFNlZTLisQdGF
         NcEokxhWqx6ZDQvvgrNo0zuyqcanYphhrZ6ffOpiWXIAeSz/BZYguA/BSzgYmkrijX0K
         eNPwqe9e9QKaXV+ESwcmH/r3RHN7bYx9mwKZIB/qa4j7UO9G2ZIKLVuDZU+gQP4oIHzL
         q4PQ==
X-Gm-Message-State: APjAAAWerhRe6X/dzPJiVw0EZ/XHW/6yUEEPB004eepdyui66+A821VW
        5+LCxvtYkK2IcvEVrLxIoN+gOUTof8CO5VvVUf2cjw==
X-Google-Smtp-Source: APXvYqzqa6FjKndpQJNYL/32Y5OoOjN8PsSahABGNcXZEKh8XLxkj39pxwC2OH7DPbnKGmtF+ovUymvf0J3zvl6CSuI=
X-Received: by 2002:a67:ec04:: with SMTP id d4mr8884681vso.63.1570808729680;
 Fri, 11 Oct 2019 08:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
 <20191011144650.GM29845@szeder.dev>
In-Reply-To: <20191011144650.GM29845@szeder.dev>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 11 Oct 2019 17:45:18 +0200
Message-ID: <CAKPyHN0s8Rc8Sbp7ubyJ5cTDC5oh4Re+wqyTUWUo+3HgpKfECg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] format-patch: create leading components of output directory
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 4:46 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Oct 11, 2019 at 10:36:41AM +0200, Bert Wesarg wrote:
> > Changes in v4:
> >  * based on dl/format-patch-doc-test-cleanup and adopt it
>
> Thanks...  but here I am nitpicking again, sorry :)
>
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 72b09896cf..9facc3a79e 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -1606,6 +1606,29 @@ test_expect_success 'From line has expected form=
at' '
> >       test_cmp from filtered
> >  '
> >
> > +test_expect_success 'format-patch -o with no leading directories' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches master..side &&
> > +     count=3D$(git rev-list --count master..side) &&
> > +     ls patches >list &&
> > +     test_line_count =3D $count list
> > +'
> > +
> > +test_expect_success 'format-patch -o with leading existing directories=
' '
> > +     git format-patch -o patches/side master..side &&
>
> The previous test case creates the 'patches' directory and leaves it
> behind, and this test implicitly relies on that directory to check
> that 'format-patch -o' can deal with already existing directories.  So
> if the previous test case were to fail early or were not run at all
> (e.g. './t4014-format-patch.sh -r 1,137'), then that directory
> wouldn't exist, and, consequently, this test case would not check what
> it was supposed to.
>
> I think it would be better to be more explicit and self-contained
> about it, and create a leading directory in this test case:
>
>    mkdir existing-dir &&
>    git format-patch -o existing-dir/side master..size &&
>    ls existing-dir/side >list &&
>

thanks. Your nitpicking is always appreciated.

Bert

> > +     count=3D$(git rev-list --count master..side) &&
> > +     ls patches/side >list &&
> > +     test_line_count =3D $count list
> > +'
> > +
> > +test_expect_success 'format-patch -o with leading non-existing directo=
ries' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches/side master..side &&
> > +     count=3D$(git rev-list --count master..side) &&
> > +     ls patches/side >list &&
> > +     test_line_count =3D $count list
> > +'
> > +
> >  test_expect_success 'format-patch format.outputDirectory option' '
> >       test_config format.outputDirectory patches &&
> >       rm -fr patches &&
> > --
> > 2.23.0.13.g28bc381d7c
> >
