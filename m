Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FB8211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 21:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeLZVax (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 16:30:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41403 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeLZVax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 16:30:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so14919235otk.8
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 13:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fSQr6gUWkOqolIRnHR0DrdktC0K5SNTy/ZFNNQ0j/nc=;
        b=Iu4YbGL4HEuXyxzHkjwGtHyGE/atZnaj19uEANPX0zFDChVQWD2rbE0XADhnftuEGz
         FaZKQume8exB73yETNkThNRR+feA1E/ftA8GDre1uSiG/9vSIl7x8S881OGG7nKPkWQv
         mDE4osMiSFZpUbMqG5SBCRxY1530Pq2OQWhxh+svzO89gXrc0WjaRGHiF0zb3aI5DIEm
         oayui42eNevsj/+0f2gQyQIgxNm8gnxbQgESLn8+l33E0xPpvHH3B8FjT8h/Wm+F2inI
         lmnCAj8eeEJX13uMvbvw+H5dMIJFPFKQDhddhRHQ8nLALBZl7QFc+c9ES0cnsZevn4aR
         KkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fSQr6gUWkOqolIRnHR0DrdktC0K5SNTy/ZFNNQ0j/nc=;
        b=i/zt2A3Bdoi6qZg/81vliY9puEgtPt4EIY1f0kjmXpsi3E5nZAJvW2BjGc8mFRNr0O
         mQVBj9fUq/P7H7HsZ9+9AY+4dfRRvW4S8oy0ueDzqVSLpPa5+2VdV7aFphEAlnE0l/FJ
         59SSRlUVWzWBcFV26gT9b8Y+OcOHBdSxLH3sDuJEYVdXaoA72eJ93/XSAitp+fGoAsUT
         GJPTAojKygvhpUR6BNZTZyPIUQn5hBFrOXjEdDK1Lq6h/fonJaHG2nlshhPU30Q1TcQ9
         HNV1VAMuMGFPBvJMG61DhSC8nG+m2PbZ4Gx8UqoJUcelR/z2UVYYF2FWNYcz0twU9AJZ
         5XnA==
X-Gm-Message-State: AJcUuken3g2OsVH77teC+Hj0fZBw2MeRqCRdkoK30ZyENlzoDfZ36PaN
        7VMIZNEh+VSVQ3UDjEkRjaduBrfWBvUpZxjvJfk=
X-Google-Smtp-Source: ALg8bN7+k3Lu3egctJlacu3oEw762Let3X7XygmL8LqKgt4x+vEY0bGf2KYyVEnxoJpzRwmmKHPf7TyO8/9xKVucpsY=
X-Received: by 2002:a05:6830:1283:: with SMTP id z3mr13729483otp.92.1545859852680;
 Wed, 26 Dec 2018 13:30:52 -0800 (PST)
MIME-Version: 1.0
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
 <CAP8UFD1ErRo7NQmCrAJLaELzV-1rKowyPsNCi3ecTqGN1qWxKQ@mail.gmail.com>
 <CAFW+GMB4KW34qaOWNwShWM_ERSJtnvp86V_mFAse1biO=T-srw@mail.gmail.com> <CAP8UFD2A1tX9qPZXr8ibPhy0B1zc5OtsWzP_XHoRJJF6hmkxRQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2A1tX9qPZXr8ibPhy0B1zc5OtsWzP_XHoRJJF6hmkxRQ@mail.gmail.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Wed, 26 Dec 2018 13:30:36 -0800
Message-ID: <CAFW+GMCP4_gce32Mhwn2Zf8DbH2YrJG4HhnLwV73+LcpQGWBPg@mail.gmail.com>
Subject: Re: Parsing trailers
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yeah, but you can perhaps check that the input doesn't contain '|'
> before doing the above. If it does contain '|' then you can probably
> find another char that it doesn't contain and use that char instead of
> '|'.

This sounds true in the usual case, though of course there are
pathological cases of commit messages that use the entire character
set. But it is starting to sound more complicated than the
slightly-tricky whitespace indexing logic from my original message.

> Another solution would be to develop a trailer.outputseparator config
> option, which should not be very difficult.

Yes, something like this would be a nice addition for future versions of
Git. Perhaps simpler would be to add a `-z` option to interpret-trailers
that would change the output format to <tok>NUL<val>NUL or similar.
Maybe I=E2=80=99ll send out a patch if I find some free time. :-)

Best,
WC

On Tue, Dec 25, 2018 at 8:33 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi William,
>
> On Mon, Dec 24, 2018 at 7:52 PM William Chargin <wchargin@gmail.com> wrot=
e:
> >
> > Hi Christian: thanks for your reply.
> >
> > > Changing the default separator as shown above, should make it easier
> > > to parse the result.
> >
> > But this actually also changes which lines are considered trailers,
> > right?
>
> Yes.
>
> > If the commit message ends with
> >
> >     Signed-off-by: one
> >     Signed-off-by| two
> >
> > and the user=E2=80=99s `trailer.separators` is set to `:`, then the cor=
rect
> > result should be only `Signed-off-by: one`. But when adding `|` as a
> > separator, we also see `Signed-off-by: two` in the result.
>
> Yeah, but you can perhaps check that the input doesn't contain '|'
> before doing the above. If it does contain '|' then you can probably
> find another char that it doesn't contain and use that char instead of
> '|'.
>
> Another solution would be to develop a trailer.outputseparator config
> option, which should not be very difficult.
>
> Best,
> Christian.
