Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B31EEF9
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932467; cv=none; b=RmYqGo2CB6PFnwc62Vw+iNpfCvmFyYdav2O7YOiR6Of2zjgK62khGnypGYwBAyY/TE6c0uzxqsdNL5Uao9LXCa0q4i46XEFO2cRrXRr++KwvmYPYDhiPvgC8JCNjwoMud9RnJll1C9B0SWHr7GH0X8U7V+BKMqp063+zGHVVFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932467; c=relaxed/simple;
	bh=dGYC30xmAGJKRhnwIxcoa60yUe5qUnFxVDkUFTHt7gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YMRwRsKbQBwuV9eCl5BHlcDM6V3TrvxN3zkFkEJR1W0Op3zR7kwiSLYNZ40H1mwWlXk9jnS76280EVOtMexNcM8AASuYkhkxeOGmd8n/cTzlhRgbZOVCYX8YrqE/Cgac1WM9CiblAYZsaSwrdAxNRajZIh7V3E/ZTmXlkdoHULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb22ac1a11so573086d6.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 22:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932464; x=1728537264;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+o+4tAuSutL1l1WY/usSPpE97/UC7MMFpUihYCPwes=;
        b=NC5winJEXaEJOnt9cDqk4Ewq1EGq/mS25cB0s+JwZKXhNP6vFZHTG9k1t5OahuwtZL
         I2hKfebUIhpDiC5A7ipruHjj9bXo7aHWJrJQ4BbG31MmhskhGDItRG/RhxaHfh5WQRF3
         uPiy12I26xTok1urRghrIV4RBFM94GxzSKzbIbxXAGs+k6RDKbtB1lMTK1DRpkQmMSvZ
         kuaBhzgVXMkwhIeRs8L72nKFGGetEOyKdwfkwfKeIJqSO+F3uX8bKfv/D/Gq0YHF9t1a
         dO0O8YByr6ueKpQ6+Q/6C1X4AXldO6bsZmQST+LL2i3IxGdCesrskD6FvA2ebPDIb0dQ
         xNTg==
X-Forwarded-Encrypted: i=1; AJvYcCXMstKVP/bmglkQrogkJYcwGaH8xsUJhhK77U+fyNfUSedpDANGjaEmxFPuifFItIzD02M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P5xk+YPEROIA0NxwKv1nmqZzOXWplKF2ViZWIRRGCyjeX5ip
	ReOuK8U+NTX02oohUkEIXyEFU1OI19SoJyHKj5qNEG0dNtXsRWxBsrbMNxAT3SMsF1P+yZM46mL
	5KuEPFOby4/ZZzupDxs6DMY99ZURvQl6n
X-Google-Smtp-Source: AGHT+IHscr16KRhdNf4Ncl3PnNLpdc8rNerUOMRBYYYQpsBi2OAuRjz+uevCY2rtnYq7dv5u5EHkcjZt0pcPj7JvQxk=
X-Received: by 2002:a05:6214:29cc:b0:6c5:3338:2502 with SMTP id
 6a1803df08f44-6cb81bb30f3mr32848126d6.10.1727932464429; Wed, 02 Oct 2024
 22:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net> <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net> <CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
 <Zv3IHd0c4_0NPjOK@tapette.crustytoothpaste.net>
In-Reply-To: <Zv3IHd0c4_0NPjOK@tapette.crustytoothpaste.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 3 Oct 2024 01:14:11 -0400
Message-ID: <CAPig+cQjk5_VJ-LNc9Hx3Q4n6H5bgg5cAztWhFpuweG8wFTjMw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Emily Shaffer <nasamuffin@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:24=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2024-10-02 at 22:16:00, Eric Sunshine wrote:
> > I'm not sure I understand your response to Phillip's observation.
> > Idiomatic error handling in Go:
> >
> >     if oid, err :=3D repo_get_oid(r, "HEAD"); err !=3D nil {
> >         return err;
> >     }
> >
> > seems much closer to Phillip's more succinct example than to the more
> > verbose example using GIT_ERROR_SUCCESS().
>
> I don't think that approach works if you want to use `oid`, since it
> scopes just to the `if` statement (and any relevant `else`).  If `oid`
> were already defined, then you would need to omit the colon in `:=3D`, or
> the compiler would complain about "no new variables".
>
> That's why I usually see this:
>
>   oid, err :=3D repo_get_oid(r, "HEAD")
>   if err !=3D nil {
>       return err
>   }
>
> which is much more like what Phillip's more verbose example shows.

Yes, you often see that in Go, as well as:

    var oid oid_type
    var err error
    if oid, err =3D repo_get_oid(r, "HEAD"); err !=3D nil {
        return err;
    }

which is very much in line with Phillip's succinct C example. But
isn't this all beside the point?

Your proposal uses Rust as a model to justify the API choice in this
RFC, but Phillip's point was that -- despite being perfectly suitable
in Rust -- it is _not_ ergonomic in C. Rather than explaining how the
proposed non-ergonomic API is superior to the ergonomic API in
Phillip's example, you instead responded by saying that people in some
other programming language (Go, in this case) have to deal with
non-ergonomic error handling on a daily basis, therefore, a
non-ergonomic API is good enough for Git's C programmers. But that is
not a very convincing argument for choosing a non-ergonomic API for
*this* project which is written in C, especially considering that a
more ergonomic API has been presented (and is already in use in parts
of the codebase).

That's why I said in my original response that I didn't understand
your response to Phillip. You seem to be using a non-justification
("other programmers suffer, so Git programmers can suffer too") as a
justification for a non-ergonomic design.
