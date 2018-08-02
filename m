Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065921F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeHBUH3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:07:29 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39741 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbeHBUH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:07:29 -0400
Received: by mail-yb0-f193.google.com with SMTP id c4-v6so1584095ybl.6
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=coFltt3daW9eU6hnqTTNvhmPay/XMAXHQzvd1xpJ9B0=;
        b=tPNs0tcNWzJaUqMuL8NSYtlAycGJ54m8RAgfWd2K0KT4MDWNnaWcvUETnIVdp68zJm
         TgiD6wmXtKzdxRJNUrQ8RxDz8+L7QoQz54/BuhVvZhl6guI2p/knO3Gdq8XPfHHaI2SB
         yJKSO6RVVMOYv0zPJ/EfPeo8fRGTET6GUz8soP9527Be/LOngzv9DAxr6LPU1CXaRNM+
         Nv37itzb+IdVJ7glEiaKkbeiwgC24Y3uPjrbCGjlVBAG6SYEiF+dZxpHAfuccPjNPH0z
         wajiIXDiBQHT2z64oVFk1ONHFd8XFCLezbpYKTNcN1s/6LzLxYk99NNaLeBm+Ln5Fzm5
         51dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=coFltt3daW9eU6hnqTTNvhmPay/XMAXHQzvd1xpJ9B0=;
        b=c/tb5oYq2Sj+5WCrXE0CpOrj4NTJHsEmESTNIOQjHhHT7hDiNSS1rcuU4jxMkRLI/8
         /o5+SDlMOCHsc52fGmxYhmbSMusxeYBaYGpacGz2Ldc/WOCaGVkiKJxk5b5kNfsALv+l
         3yoQlzuCYaubh6eDSZfO7jnHBqL3ErWC5fvOJRg5v41Lez2GaOzwd7GVmel6kCW6JA+2
         0ItyB8uYb7aKOD75xFMTr25gh2/f8X4+op0qETVb0O6hLSZY3Xl8dvVeGdS2qi76nYgq
         OXVUvDt44qfx27Ku97wv9vhlygUV94exzBRi6ifle/yNsTTcTXUwFO3psIU5fsB4bqOz
         oYQQ==
X-Gm-Message-State: AOUpUlFTnpFSxaqq6+xdFoh+lGg6Mx/rfmUv0/anxwMSYab0BC9EXA7U
        5etevtVnhcoV+gnrgQxP0PuTb3urBsiROjwRI67SO4LwtvigOw==
X-Google-Smtp-Source: AAOMgpeIDPWrn8nLFy7MFmvMJz82O1gZHfYOijGkB+Qk4orVA5xFzkjQ7IKrDiK/+RDpU/vyco3VTB88Snn7IIoBYE4=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr390389ywa.340.1533233714190;
 Thu, 02 Aug 2018 11:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-4-ao2@ao2.it>
 <20180802164042.28026-1-szeder.dev@gmail.com>
In-Reply-To: <20180802164042.28026-1-szeder.dev@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 11:15:03 -0700
Message-ID: <CAGZ79kYn8hCV3z7wLhG+-nOooie-PwHN7n1SrEJdka8bSHc+3w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/12] t7411: be nicer to future tests and really
 clean things up
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 9:41 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> > Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
> > invalid lines in .gitmodules but then only the second commit is removed=
.
> >
> > This may affect future subsequent tests if they assume that the
> > .gitmodules file has no errors.
> >
> > Since those commits are not needed anymore remove both of them.
> >
> > The modified line is in the last test of the file, so this does not
> > change the current behavior, it only affects future tests.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >
> > Note that test_when_finished is not used here, both to keep the current=
 style
> > and also because it does not work in sub-shells.
>
> That's true, but I think that this:
>
>   test_when_finished git -C super reset --hard HEAD~2
>
> at the very beginning of the test should work.

Yeah that is a better way to do it.
Even better would be to have 2 of these for both tests 5 and 8,
such that each of them could be skipped individually and any following
tests still work fine.

> >  t/t7411-submodule-config.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> > index 0bde5850ac..248da0bc4f 100755
> > --- a/t/t7411-submodule-config.sh
> > +++ b/t/t7411-submodule-config.sh
> > @@ -135,7 +135,9 @@ test_expect_success 'error in history in fetchrecur=
sesubmodule lets continue' '
> >                       HEAD submodule \
> >                               >actual &&
> >               test_cmp expect_error actual  &&
> > -             git reset --hard HEAD^
> > +             # Remove both the commits which add errors to .gitmodules=
,
> > +             # the one from this test and the one from a previous test=
.
> > +             git reset --hard HEAD~2

I am a bit hesitant to removing the commits though, as it is expected to ha=
ve
potentially broken history and submodules still working.

The config --unset already fixes the gitmodules file,
so I think we can rather do

    git commit -a -m 'now the .gitmodules file is fixed at HEAD \
        but has a messy history'

But as I have only read up to here, not knowing what the future tests will
bring this is all speculation at this point.
