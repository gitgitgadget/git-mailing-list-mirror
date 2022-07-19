Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E44FC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiGSRV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiGSRVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:21:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E32820F49
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:21:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e69so4842121iof.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LDZBeAeuVjpOKxE8xbv3GKGFfm1Y0CcqgdL+JmKAAK0=;
        b=HTjLVpuG8ZYZJ7u8pLS2t5Xk7vXJpCACbukrGNcmY+W5PNC7NvRs2k47S449Ondw2q
         inxekoAZWUlrsGTp0yC5AJ1XeBbY/qi+yXy0Y/M2JD5COecCxgfaiYH4RUPdBMtzIayH
         OQ/uzfxB8QrrwPVv2uVYASu61iIx3Y69yaXdLTfChvKefBUmRUtNEE0YItb3Ksqr7b9q
         jv6QQxLMSSTDKagFgLPQ1BrE8YFUDSfvOvX4dPwrYDko40IXnJ8ljgsMiJ9fyWoCvg3J
         nj2NqCnHdXAGQWxUqHggV5lb8xlzfFn6PTBoBkNjYwh30CzJVNp26l9/h5ydG5AQ66Om
         fK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LDZBeAeuVjpOKxE8xbv3GKGFfm1Y0CcqgdL+JmKAAK0=;
        b=WwITOvwdEwsSt+KdXKyEDvKjY3+6hzOrU85dd5nZSU6+SHFtJx5adY3fBDIJp2BsMj
         a3xDs23RNAy8Q61trNTllCoMC3LsnA9lf25rNJOM3+eLwdW+tbp3I4j4rBKn+WhVGrSY
         0skef8jF0vaHIQUPWe/DKiu72RnqapCY8Yt/+H5PCNl0IsIWAGRNh26I+tQ38As4bDXy
         P+ClSTNUfk8Zr9SkGVWt5dc4y/XM7qhippvM9wf9Jvm0kb99SoeBh/MbWmCphEx8kV1B
         zfXPZ/nUP9iZdA0aIFFUW6teTNgxJ90EAlJ5TtCC2cLnmN+gyTQ0oJoRN4wuG0EtsutS
         Knfw==
X-Gm-Message-State: AJIora/yDHi3UmgRtvf03UPlW7aLFh+m7EVHtDENmBP3NUx3C5Lj3zgk
        Mhqi2ZB5gYDh5slCtzUqhKrhqA4ZvzL/bERx0ec=
X-Google-Smtp-Source: AGRyM1vpNu3GTVuKqiObEie065JJsgzQQrLuPhSdOiEQYpXQqv2NJGVSvCT6FbrWwt0gD3ycngld/UVUF85e41sNQwc=
X-Received: by 2002:a05:6602:15c6:b0:67a:33d1:6c73 with SMTP id
 f6-20020a05660215c600b0067a33d16c73mr16360213iow.156.1658251310935; Tue, 19
 Jul 2022 10:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com>
 <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com> <220718.86pmi2ygbt.gmgdl@evledraar.gmail.com>
 <CAOLTT8R_=hmwDab1Tq+qy1vXUZ4C1z6+9xTyR8WSzQ=JOBnhjg@mail.gmail.com> <xmqqh73daw1z.fsf@gitster.g>
In-Reply-To: <xmqqh73daw1z.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 20 Jul 2022 01:21:39 +0800
Message-ID: <CAOLTT8SW4RNjGoKGi=FPoDmPVvie_tADeex+NXE3M7a_j6V4qA@mail.gmail.com>
Subject: Re: [PATCH v7] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=B8=89 00:47=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=
=E5=B9=B47=E6=9C=8818=E6=97=A5=E5=91=A8=E4=B8=80 16:29=E5=86=99=E9=81=93=EF=
=BC=9A
> >>
> >>
> >> On Wed, Jul 13 2022, ZheNing Hu via GitGitGadget wrote:
> >>
> >> > +test_expect_success 'setup' '
> >> > +     printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
> >> > +     printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
> >> > +     printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
> >>
> >> If you want to do this sort of thing in general this pattern is better=
:
> >>
> >>         x=3D"a b c" &&
> >>         printf "%s\n" $x
> >>         printf "%s\r\n" $x
> >>
> >
> > Let see what's these cmd output:
> >
> > x=3D"a b c" &&
> > printf "%s\n" $x &&
> > printf "%s\r\n" $x
> >
> > a b c
> > a b c
>
> The above makes it look as if your shell is broken or you have an
> unusual IFS that does not have space in it.  Are you sure you did
> not place anything around $x on the second and the third line, which
> is given to printf after its contents split into words at $IFS?

Ok... That's zsh's strange feature.... I turn to use bash, it's find.
