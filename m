Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88EB2E8B63
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857216; cv=none; b=sj+GrL87UpsuVqmkScT9Ojm6LYmxCEXP/WU0GP4Zx5eZ4RS/DfXB2BMFzGlcY02/k1KpmxB1QYxR+WxoKjIlafFUEzTGMI0DhztAcKrmKuXsjGJq7/5HDf8JVWMDNrCI+GNkGycy9ZhbyNhRqBJ0h1T08oJHKMSXZOEpGiAvFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857216; c=relaxed/simple;
	bh=/Cpe69cUfAM491rp1h9fvSqGFzL0RanqDYoNIxTcMdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3TDZnh7B1eW3wd7iPAZWwvlTzPAaS503uXz5K4lUx3jK2gzMDnCMe0lqvtUu4kMSJkR6aRWXKaCAXb3HosgweY9OKn+0u+Co4tijjbHGUWDs9JOWkFv7f9S2ChjT1olVDMfUvApr1gLElSy5tCGjvgdSP9VSCePf9Jl2eovzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+BRjuh7; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+BRjuh7"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8625f8624d8so92181585a.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759857209; x=1760462009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxBEQwoddGQ3Ohw/1HVe86GwjVdZLUK2Xk5s4m5MIDg=;
        b=A+BRjuh7a0bJv6Xby9IvI14CLhZlVhhp9GtZIa9XkAmHwd5wKCSSn6VGV7G/YWaadj
         5Am/9SAxdnF0f7eV9Xwl/ey/aIOoPudXizjHJNA/IjSZy9erXxDdvPFvicTYU5Ko6RbP
         kXYLDkgh42ujHFfiPHaE2Y3O163FAjh3TwBhP4BBtTEm/obY84d1MZqXlpSAv7Buv8jp
         Gl8dj8yOsYEkAAlTxQtSbXHTmvGbq+smY6ACaurHRksaGP+8CBDyoU+ccdWTXYsEwPVU
         6hk544FEI4TkQvjW/rvbVeQw9ulTi+aZdfeEuBjtkO+3078rEv4eRswFCwPf82wigXOV
         BO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759857209; x=1760462009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxBEQwoddGQ3Ohw/1HVe86GwjVdZLUK2Xk5s4m5MIDg=;
        b=eYe4IMzkkx3TR/1DvQUhZSE0is0g3VkL16cjSX4SazbCBzBjKdbFTAHrsDLS+yPrfX
         yVusqDSFFzmhBrouwqxmxRafHzXYVlYeiVfAmOeKsYUCU5eFd3e07uGnJAwEVEsIF3nb
         iAgAN6p0hqOCEUer2h0yKy+ySEvLQfysAKaVyJZ1dqYOHngrc2PIKqbg+x7J0vNmpVJg
         lEKwYw4jVNBrVijpxSNeFiYVCAiOnoclHUq1ZG7wxDW457yI8WAnP44FSeH3zkIxoli6
         +z786iTlEGDz+xXmgH5kI9CR+xttIlvDzutHYvQc1BJv7f6tz2bWCVCEG/xXAs8Z09kV
         MCJQ==
X-Gm-Message-State: AOJu0Yw6Xd9bcN90hwW7oepETcByLpqJAxEbdSkpsqz62JnA8CooSQXB
	p20My2a7hQTMVcIi99v3cNm24Fhe4ZtFyJVD5oyclngXktEbWmt3JPtt8cRIwDU5krSH/iXqyAH
	XL164QUO0FiBspqpP3BX/cZhrHg3T/UI=
X-Gm-Gg: ASbGncshQed6iSHtx0lwEqA/6lIekYfKC6icrFbowFfWK3PEYWv6QMGYq85P9Atdcc+
	Tf117XRVcCVpwenlhDjjDVFE5vB6GerEjU/5luJPdPpDgF8JVEuCP7IG1zKkbMYo+aFoQJ8iOr1
	AHoyAZ/XQFBN3UqD+PKuWrv0vCD84QIB0J+YRTcOLeeIr9y3NZufDpiBmb0sQWQMGzvTfvCk1b7
	vgrKtA2XNc32N42dWFgAbW9qXi97o0Bm8kYVHXH8jnkhB9g2oN6nAf9AjvGAvbo
X-Google-Smtp-Source: AGHT+IHmPG173C/7yaT2AVb/twkAAdmNz37KLe0tFhVQQRcLehzlqMtY9i3o7tA3TY1EDNf+2p9GNNfVEzYo6BAYZrY=
X-Received: by 2002:a05:6214:d61:b0:795:c55c:87de with SMTP id
 6a1803df08f44-87b2ef7fa91mr1686896d6.5.1759857209402; Tue, 07 Oct 2025
 10:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im> <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Tue, 7 Oct 2025 13:13:18 -0400
X-Gm-Features: AS18NWDDrG4eI33kTulModfXI5pI73yW9n1it_OWDlpt--v8BPuXrFoagHrLaIw
Message-ID: <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Introduce a CI check that verifies that our Rust code is well-formatted.
> This check uses rustfmt(1), which is the de-facto standard in the Rust
> world.
>
> The rustfmt(1) tool allows to tweak the final format in theory. In
> practice though, the Rust ecosystem has aligned on style "editions".
> These editions only exist to ensure that any potential changes to the
> style don't cause reformats to existing code bases. Other than that,
> most Rust projects out there accept this default style of a specific
> edition.
>
> Let's do the same and use that default style. It may not be anyone's
> favorite, but it is consistent and by making it part of our CI we also
> enforce it right from the start.

In a different thread, I wrote[1]:

    There are more than a few developers on this project (including
    myself) who still use 80-column editors and terminals. As a
    general style guideline, this project does recommend wrapping code
    to fit within 80 columns (except in cases when doing so would
    severely hurt readability). I imagine that the same sort of
    guideline would be appreciated in Rust code, as well, by those who
    still stick with 80 columns.

    I bring this up because, although it hasn't been such a big deal
    with the existing C code, assuming that developers run `rustfmt`
    on the code before sending a patch series, then this may become an
    issue if different developers have `rustfmt` configured to enforce
    different maximum column width, especially since `rustfmt` is
    likely to reformat the entire file rather than just the region
    that has just been edited.  So, if this code gets checked in as-is
    with these very wide lines, and then someone else, who has
    `rustfmt` configured for 80-columns edits the file, then it
    becomes a problem.

    As such, can we also add a project-wide `rustfmt.toml` which, at
    minimum, sets the maximum line width to 80? For instance:

        max_width =3D 80

Later in the same thread, I wrote[2]:

    Project guidelines have long suggested 80 columns as a desirable
    maximum not only for C code, but for pretty much all other
    resources, including shell code, Perl code, and documentation
    files. This suggested maximum works well for adherents of
    80-columns and (presumably) hasn't been too onerous for developers
    who use wider windows; at least we haven't heard people clamoring
    to increase the suggested maximum column limit. As such, it does
    not seem far-fetched to expect that the project guidelines
    should/could/would also apply to Rust code.

Unfortunately, what little discussion there was petered out quickly
without resolution, but it seems that it would be a good idea to make
some sort of decision earlier (while there is still very little Rust
code committed to the project) rather than later.

[1]: https://lore.kernel.org/git/CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mff=
joXZ4eqcw@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cTdJAjuekz6YXDkxTjTRxsPEzSUxhoD8nK9k=
7uA4s=3DrHQ@mail.gmail.com/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
