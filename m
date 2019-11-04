Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB031F454
	for <e@80x24.org>; Mon,  4 Nov 2019 13:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfKDN4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 08:56:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37617 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfKDN4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 08:56:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id g50so24015149qtb.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 05:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y5JdLEzhx8e/4Y6tFX3w1msKZ2ylf4baTmS3osadcRM=;
        b=srGRCzvOkK8EQeIZ/DAhuHS/MTqFTIOAb+eUUfL4H3XpuD5xYnTWeJq0nDUEiDHvC9
         /5Gww3aKH7uW2UP8p9EIwBCoKDS0WAE5Zno9GQaIso0hO4p5/Ueqv4LvOKVGSP3D5Ar3
         cOshm9wHychOTQnACHgzZPNzw5hBgpPG7yT5yRUzINLC7QMWsCbhWHcB2SBZMnANJERt
         86pI5n1P24ExYSjAxnUkJ2/Ozb19hj6MYhs5muKNRG8klkA9kR8F3QSaIVoV2mXy+HrT
         20MdLX0w9xZoF7/JWBuv6E8/7AgRSQ9DkFQA1tck8A3jjLOFrDcydBtn3QoK3BLBFL1R
         UePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y5JdLEzhx8e/4Y6tFX3w1msKZ2ylf4baTmS3osadcRM=;
        b=P/XxzuuFo+ozJ3rBrXc+F96UgiQLeKcyyimbavYsNyqrPhZmdJtWdCWR+esj3kp4Qr
         oPhfW0QbA9c4hDYeD+bzdioPiGBRy0OxsTUIykP06DPvWnHewoQIMHmbX17Ko7PcEobd
         LJPgnFzGb8FtooEZWhKH2C8pOxxbm1+VBpYo7fcHJKvxGwX7V2zF2tUMsoCU7o2l6TQP
         h1evJh9jo4AIupPTnwImkii09/IlXgNmICydKsMlrMJK62tHf8iy+BwiR6mSGcaDvATl
         pxXEDFeLoVBYtDfiPNh9aa+sYSMwgKu10zQYZU/iOJpJ7XxzT7Eh70pm4rnl8l5lR4o4
         8EaQ==
X-Gm-Message-State: APjAAAVvmx3HkDtyekr43W5EEiqvpv+Eg7qiHLVZOuPI7A+l3WbmZxZu
        1LRJfyTv2y5GKS1vaLYjm6uVbIPaezA8PXzo8WdH1lcQg9AA2g==
X-Google-Smtp-Source: APXvYqweDIx8MCnIfgu8hP8IuleqWNyVrZtmoEYqUENVXJD6cqdgYT+hhIwpzEOFFOQUuJ5vivpaUC4uBdGzL8DzUFY=
X-Received: by 2002:ac8:110d:: with SMTP id c13mr12589684qtj.249.1572875759212;
 Mon, 04 Nov 2019 05:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20191104095923.116086-1-gitter.spiros@gmail.com> <20191104102612.GE4348@szeder.dev>
In-Reply-To: <20191104102612.GE4348@szeder.dev>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon, 4 Nov 2019 14:55:47 +0100
Message-ID: <CA+EOSBncQa0h1of+R2BBSw=tSNFmSASi2V5EJPaRNEO_ctvbkw@mail.gmail.com>
Subject: Re: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse of
 the '=' operator
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno lun 4 nov 2019 alle ore 11:26 SZEDER G=C3=A1bor
<szeder.dev@gmail.com> ha scritto:
>
> On Mon, Nov 04, 2019 at 09:59:21AM +0000, Elia Pinto wrote:
> > Fix the LGTM warning of the rule that finds uses of the assignment
>
> What is an "LGTM warning"?
>
> I think including the actual compiler warning in the commit message
> would be great.
Yes indeed. I thought I did it, do you think i can do better? Thanks

https://lgtm.com/rules/2158670641/
>
> > operator =3D in places where the equality operator =3D=3D would
> > make more sense.
> >
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> >  ident.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/ident.c b/ident.c
> > index e666ee4e59..07f2f03b0a 100644
> > --- a/ident.c
> > +++ b/ident.c
> > @@ -172,12 +172,15 @@ const char *ident_default_email(void)
> >                       strbuf_addstr(&git_default_email, email);
> >                       committer_ident_explicitly_given |=3D IDENT_MAIL_=
GIVEN;
> >                       author_ident_explicitly_given |=3D IDENT_MAIL_GIV=
EN;
> > -             } else if ((email =3D query_user_email()) && email[0]) {
> > -                     strbuf_addstr(&git_default_email, email);
> > -                     free((char *)email);
> > -             } else
> > -                     copy_email(xgetpwuid_self(&default_email_is_bogus=
),
> > +             } else {
> > +                     email =3D query_user_email();
> > +                     if (email && email[0]) {
> > +                             strbuf_addstr(&git_default_email, email);
> > +                             free((char *)email);
> > +                     } else
> > +                             copy_email(xgetpwuid_self(&default_email_=
is_bogus),
> >                                  &git_default_email, &default_email_is_=
bogus);
> > +             }
> >               strbuf_trim(&git_default_email);
> >       }
> >       return git_default_email.buf;
> > --
> > 2.24.0.rc0.467.g566ccdd3e4.dirty
> >
