Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598A1C29
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8FnD8Zq"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC7B4
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 05:38:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so4966365a12.1
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698496680; x=1699101480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzJ0ez5bxkwel9IN3khYrwuMAFzdJSnTO/Z8JUzKM3M=;
        b=W8FnD8ZqQ11W/60fmsSkuM3uaQZBgHQ4UAlMy9adIo0q9E8dZB03ClkpHO7dd9CT3l
         fF/85kgoxTp4d0JhVwT8FDvoD/Tt2zWRbsZz3fBnqEbuEBIpaZd9UvgJ7adD1rKQIPA6
         7anWwf0lcN45sXhgXi+Um16ykuHbp9u2mivFgXUb4dA5K6Fb10FqhesdHLw3pfl96Uae
         HIl+fz7SVkEwZrJi/J4VVAy/6hTnenEaHOHJwF7JcsFVo64f5Yoe2CQdLrfL9kIzGssS
         OSI+LCTbpi826vTDQSDcj6jqTBc6Li/Yn6sXxV8niNhigsfL7C/4HYHcBMg382rfgBYQ
         i8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698496680; x=1699101480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzJ0ez5bxkwel9IN3khYrwuMAFzdJSnTO/Z8JUzKM3M=;
        b=WlAa5UPFZ03mvpghSITmJIg98pSHPow0nxCNytBPmO2HDEkbi5rddOduAbTyu9jRem
         kmzEuU0GPYvb3z6wHN4qGUpfYj8n8Ku64IREF8FWo6pxgfwFQoiv6+bHLg77KNy3cUCP
         IhNSfys4Z7sn6w14itmjAC+tceCtNR8/cibozRoekshW1SE+M1UC5ueoMAwbq87sG6sa
         VukzxeFmWTi+9qhSuA51OxEUqLLb1RPyVQ0tvLRl127jE3aewrCjFnjtEOaeyZk7Ntct
         bl+mhJWX0S7x7bNF7mYtYCiKxsXe/m4yglNFzNx1ms9IuRwGS4DRXrYw4h1NEA6HTYob
         sN2w==
X-Gm-Message-State: AOJu0YwK+bMuNMxwRBizPOVWLNg6397d7oR2YGH4o8eoXsT7KX0T4Q1k
	eplKSHtWDJoZ444F94lRO92qkTTU5s5QkQEF1zEGGEVQLTo=
X-Google-Smtp-Source: AGHT+IH2oVQ2iP11+qBS0wgqcyPQSmTgVg5xHu5E+4Xsilr/zP1EaBlL1NwXydiFIhjMz+Rwld7Rf+3Vf9NWd+LHV2w=
X-Received: by 2002:a50:9b5d:0:b0:53d:f4a2:5140 with SMTP id
 a29-20020a509b5d000000b0053df4a25140mr4252800edj.33.1698496679640; Sat, 28
 Oct 2023 05:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSXNUvQ@mail.gmail.com>
 <CAP8UFD22EpdBU8HJqFM+=75EBABOTf5a0q+KsbzLK+XTEGSkPw@mail.gmail.com>
 <CAJHH8bH0gp9tbDJ4DYk3jkNPD5_dZ9s62D9ae3q33aBP0ZL9Lg@mail.gmail.com>
 <CAP8UFD16OAPiRFJfjZN=soAe3WzDBteyvzv-b3CD67jz6Haqyg@mail.gmail.com> <CAJHH8bGK28Fc+VG3uxgC5sGgFEAw6_6AEtusgmw7c4Vz0iGF_g@mail.gmail.com>
In-Reply-To: <CAJHH8bGK28Fc+VG3uxgC5sGgFEAw6_6AEtusgmw7c4Vz0iGF_g@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 28 Oct 2023 14:37:47 +0200
Message-ID: <CAP8UFD1+aWGymjssk5CotPjEmhu5sMcTy-b7eJc4fw-UA41Qig@mail.gmail.com>
Subject: Re: [RFC][Outreachy] Seeking Git Community Feedback on My Application
To: Isoken Ibizugbe <isokenjune@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 12:41=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail.=
com> wrote:
>
> On Sat, Oct 28, 2023 at 9:07=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > > #define DIGIT "0123456789"
> > >
> > > static void t_digit_type(void)
> > > {
> > >     int i;
> > >     const char *digits =3D DIGIT;
> > >     for (i =3D 0; digits[i]; i++)
> > >    {
> > >          check_int(isdigit(digits[i]), =3D=3D, 0);
> > >    }
> >
> > This tests that isdigit() returns 0 for each of the characters in
> > "0123456789", but first I think isdigit() should return 1, not 0 for
> > those characters.
>
> yes, that is true. should I send a re-roll?

Yes, please.
