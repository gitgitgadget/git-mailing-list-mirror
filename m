Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B948FC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AFA20747
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhlRofl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFNIsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNIsf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 04:48:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959BC03E969
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 01:48:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i3so11088449ljg.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/CkoqaLUof4Qul4/LOL6sb7geQZ7pFIHthEA6/2llw=;
        b=IhlRofl6YTqEbIAbUN6L6gs3RMGR2ARIE55oojfKi7zMxjYNDjyhf1qQEPtLbRZMAI
         H1ysZPayxU2yZeODnW21InMNniEKdxZGX8aVt4ywraVKlIdp2VF3Kf+yaGFq+wRMGyRd
         kNfYCoMgVe7IaLC5fRkQfNY3rFaxGnhcukfJu3BdF/YwXYYNem5LdF0qeIi79CvtIsIm
         vwyfRfh9Fz1WPHTPeUb/FQCRaB1quT7L54zg10e5XuntviRweQF3ZoyCGOMNfEIvGtdI
         kGM7dHCJx2fk+/NsPm3v6mIJaAH5/IMwLCickiuZf6FOEXSD3Du9vU1GEwCD1QxpX4+2
         i8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/CkoqaLUof4Qul4/LOL6sb7geQZ7pFIHthEA6/2llw=;
        b=rt0BlQfK7bV9GUEDCTsnPjKGaWdOoD7oEN/fxwFXnyrf5u8rmZ+eyXtdJ1AwAxgqfF
         0KkX3CGmInzGQhhcp7xXDUp5yruFUEhtwhSmAWmXHha74dzTOAKxbU8k1PrF8UJ2l4e0
         SsuUJSX1Mn6NneK5FwX8mDCLOQrsdecRajKKa8pHjPr2w0rqn4Ah+aoz6y+EERDgc11l
         iXNHpioegmuclerBwAfzlTX8swOI2pTE3uYml6kk63NwIzzxGCRDy20NnQuoB3bhLg5z
         wS4VY69Nxkbx/YyKUxZ12eExY8fVMUwPZ4ANAkqu/CKI7WtsGJ7pJd8CzY4ei3+jycnP
         hKjQ==
X-Gm-Message-State: AOAM5315/42SrhzLRz/6z3z5DeJHHwhp6nXtUB44KYmeMx4aNgatyHqM
        GbGxcAwttzYw0ol8xfH1d0WC9OSsYd5WDBqr9O5YscKF4Yc=
X-Google-Smtp-Source: ABdhPJxtM3pZm2m++WISfDUAg0QQRy/wiSRPjcPcrpnb/0kXyToFqK+z9qdpHaektD3ZseC0/ntk/KbRs4ZhKQ2PRrg=
X-Received: by 2002:a2e:8903:: with SMTP id d3mr9668908lji.298.1592124512476;
 Sun, 14 Jun 2020 01:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com> <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
 <CAGA3LAcZa76oSovMYS7kKt9YwbYe74YgEscQKKs5qd5_KCneNQ@mail.gmail.com> <CAFZPMoanA6fW5YGO5Jxxd3_py=dBCqNxmU1ikUGuYopXWwofyA@mail.gmail.com>
In-Reply-To: <CAFZPMoanA6fW5YGO5Jxxd3_py=dBCqNxmU1ikUGuYopXWwofyA@mail.gmail.com>
From:   Sergey Lapin <slapinid@gmail.com>
Date:   Sun, 14 Jun 2020 11:48:18 +0300
Message-ID: <CAFZPMoYeT=40grVUjWKeWeGTDsxwqhX9jg2MYFpoSF_Zp45dUg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Don Goodman-Wilson <don@goodman-wilson.com>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And I'm also offended by "main"

On Sun, Jun 14, 2020 at 11:47 AM Sergey Lapin <slapinid@gmail.com> wrote:
>
> Americans' perpetual offendedness with everything is what leads to what w=
as
> written in Fahrenheit 451. Constant obsession with offendedness and const=
ant
> valuing of everyone else about "should I be offended now?" is so much
> American now it became really concerning among all this PC culture.
> Won't you stop your great self-destruction guys?
>
> On Sun, Jun 14, 2020 at 9:36 AM Don Goodman-Wilson
> <don@goodman-wilson.com> wrote:
> >
> > (Sorry, I meant "many (if not most) non-native English speakers DON'T
> > realize just how explosive certain English locutions can be to
> > American native speakers.")
> >
> > On Sun, Jun 14, 2020 at 8:32 AM Don Goodman-Wilson
> > <don@goodman-wilson.com> wrote:
> > >
> > > I am an American living in Europe. Let me offer an analogy. Like all
> > > analogies, this one is imperfect, but I think it will serve to make m=
y
> > > point.
> > >
> > > As an American, I don't understand French humor. It's simply beyond
> > > me. I've had it explained to me numerous times, but of course
> > > explaining a joke can't impart its inherent humor. But none of this
> > > should come as a surprise to anyone, as humor is a deeply cultural
> > > artifact, something that can only truly be understood by those raised
> > > within that culture. Even so, we can all appreciate the concept of
> > > humor generally. More to the point, I certainly don't go around
> > > denying that French humor exists, on the basis that I don't get it.
> > >
> > > In the same way, something I've learned living in Europe is that many
> > > (if not most) non-native English speakers realize just how explosive
> > > certain English locutions can be to American native speakers. That's
> > > totally understanable as, like French humor, you have to have been
> > > raised in the culture to really understand that fact. Like humor, we
> > > all have a sense of what offensiveness means, and like humor, this
> > > explosive content is a deeply cultural artifact, something that can
> > > only truly be understood by those raised within that culture. The
> > > visceral feeling of explosive content will probably always be beyond
> > > grasping, just as French humor will probably never make me laugh.
> > >
> > > But to deny that explosive content on the basis that you don't
> > > personally feel it, that you've never experienced it? To claim that i=
t
> > > is "meaningless", that some people are "perpetually offended"? That's
> > > willful ignorance on your part, a bad-faith effort to engage in
> > > serious intellectual conversation about what is good and right, and
> > > has no place in a discussion about creating an inclusive space for al=
l
> > > developers, let alone trying to bring about a more just world.
> > >
> > > Don Goodman-Wilson
> > >
> > > On Sun, Jun 14, 2020 at 2:50 AM S=C3=A9rgio Augusto Vianna
> > > <sergio.a.vianna@gmail.com> wrote:
> > > >
> > > > Then why create all this disruption by changing the default from ma=
ster
> > > > to "main" if you will offer a feature to set the default on creatio=
n?
> > > > Americans were discussing trump's tiny hands last week and will hav=
e
> > > > moved on to any other meaningless subject the next one. You can
> > > > literally never please the perpetually offended. Taking this kind o=
f
> > > > slacktivism and creating problems for other people is a disgusting =
level
> > > > of entitlement that only americans display. You really care about
> > > > others? Remember there's other countries in the world.
> > > >
