Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852B21C9E0
	for <git@vger.kernel.org>; Thu,  1 May 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123044; cv=none; b=EwThmgFQvDLaHsXDtkzVfaull+9378BaWoQoyUwPPcyg0jhkl+kTPAL7Hxe8SgoF1L+TXL36U1LCMTA7yBmYObXlS5HXgAbz2eD3fdVqLwRZq5pE8ojSYyrHwDbL0SaPOi4rwAOwIuCBejXYH8M6iuw9PGe5q96y//W2bsf8BBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123044; c=relaxed/simple;
	bh=Cl0+HtmObhenzEXDiXd4/Kr9UZ3sAhp8KkXwSfs9Q5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/iN+KX36S6cLapDRz8Q6h+LnRM7oXJoO5x5v+c3iszPisg4k0cB/5bre6uqYMgKTeLCbY+znMNKD8rXOU91rqsd0Fx4gwdUbVkb72ZcY7KiVbksazwfvIAQjvLMs9NigyXhK7lvJo8ZLJ6sKkSq0ISYEhAm46qdpjYLvrMKsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHRlGfHm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHRlGfHm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso186805866b.3
        for <git@vger.kernel.org>; Thu, 01 May 2025 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746123041; x=1746727841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkSU0IKPLtU24Cv9gWQ7YSVtnaX3qGxbDw6r7N6FIk8=;
        b=PHRlGfHmzXQFDsP2z2s4d4YkMiAWxtdIKwxSeXh8EcuD/5Ka/sXbEjg77AXNETdB4+
         sM11zle+zPognTRF/6/6exlnPRnOXLs8t6mmk1F5Z7WNDhmALHdpHlsptVnQTGaIOHwa
         gyeE/UeatsoCTWXDB8gFOd74Y8GUwXZQu9oiSp3QfrgU9UzvGNb9U/+ytPNuIlWRRk7Y
         RkrQAkHq8kWd2aUoGO68vX6e8L6npBqXTmxWbZO6AL4BKtR1BKvUOb//1+wTfRSWRR08
         HUigdXQGFh4MjFnvOY3QYA0uVbUfSj0/Bc4SR08KjuSvnN4f9ioEJR8oVlPV0bGAJDFX
         3R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123041; x=1746727841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkSU0IKPLtU24Cv9gWQ7YSVtnaX3qGxbDw6r7N6FIk8=;
        b=ZV+U2Nab0WNCMSAzcxz/fJZQO+Qy/wKCXp5Ijf4aAZxzT8PMOpL/d5Y5HQ9mSEeKx9
         qaTNN66zQ8UV4g/4bgPLmtB2XU2ogqvV2/Xn5GTCLWpA6UTQqX3G9MUY4W4JJhmjw1HB
         JnQEtCzpqUinqwIVjAHxeIZdl645PmYTPF33f5uQNUaD4PSo34oy5ZZaPTjdgkOfVTiw
         wOqcp6e0sAjk18fOMsBS5XWL7AcMK4phuoFZ264fs/dkUVYMsdPhkH5yDwNuSY/qP15U
         whFOdR8rQ/SmifreZfA+iSrZyUY4Vt0NgUclX1etwZrH6gmBE3SZzeUQrYdkw18xZ7bb
         yYNw==
X-Forwarded-Encrypted: i=1; AJvYcCXtE86e8H3mXbO70D4wH+htb1uvvT5l8maxWqpYkZmROVdRp9AfElteRnKJGbsDF/Mcdec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yLHc5UBj9eDZq1sA3cftKD+T3oW213rzoMfIS9X6jYCyP6o6
	uw1xzftkfmDrwFvpMxRVbiPpV4i7TBRuRcV8I15kAvCLeb3jydP/BQGL0rZqLTkUcwQEE8ICRR2
	LeH/4B4iu8/lKZZwnkHnltvptEM3lYSxN
X-Gm-Gg: ASbGnctmKYgzYebsZ6nRdTVzJf6Sr76ftpPrwrz70JP5aY3wd24YD3DCA8ZgXqlxAzK
	nILy0KdB7/CAM0kEsXrQC4Dz0JIn+OKPgRWlPEkIH4tbP8e3gwPSfZn/o4HQdsqXhPLRhRDFgjU
	xDm8bC4Jji8IhQneUg0UQxLz5BMvL4uXkRzHvuM7kPTT4OxsdHgy97ljQBkO+Ls7f/des=
X-Google-Smtp-Source: AGHT+IFQ6NwkNp1aSbeyWJp5hExhp80jXDvpxtaGo45RXkyk0EVfwOsqulMHlM+awxzeanCEu7pAJ6GRgco8TrtIzjQ=
X-Received: by 2002:a17:907:f496:b0:aca:b72b:4576 with SMTP id
 a640c23a62f3a-ad17adc1dbcmr22550766b.33.1746123040524; Thu, 01 May 2025
 11:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fb842b0e-3666-4b78-bf00-c7d11a42dd25@uni-jena.de>
 <057e8f72-ea67-432b-a687-2b5af08fba05@app.fastmail.com> <xmqqcyct1mtq.fsf@gitster.g>
In-Reply-To: <xmqqcyct1mtq.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 1 May 2025 14:10:28 -0400
X-Gm-Features: ATxdqUEnR8IsJtMI_7yMZXJJZYH2mbDnBztpLTdZl3OIFupGX2FSjPk6YHf6AUw
Message-ID: <CALnO6CBjd=-9OZfQ_Mhq7r0Y=gXKcb5WNOT+-qPAs_LNsayi0Q@mail.gmail.com>
Subject: Re: doc: git-clone: Improve discoverability of --no-single-branch flag
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Lino Haupt <linojossfidel.haupt@uni-jena.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 3:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > Many options are documented as `--[no-]`.
> >
> >     git grep --fixed-string -- '--[no-]' Documentation/ ':(exclude)Docu=
mentation/RelNotes/'
> >
> > This is explained in gitcli(7), =E2=80=9CEnhanced Option Parser=E2=80=
=9D (for some
> > commands), =E2=80=9CNegating options=E2=80=9D:
> >
> >        Options with long option names can be negated by prefixing
> >        --no-. For example, git branch has the option --track which is o=
n
> >        by default. You can use --no-track to override that
> >        behaviour. The same goes for --color and --no-color.
> >
> > A concern might be that changing `--single-branch` in this way would be
> > inconsistent with the overall style.
>
> A pair of quick counts:
>
>     $ git grep -E -e '^`?--no-' Documentation/ | wc -l
>     189
>     $ git grep -E -e '^`?--\[no-\]' Documentation/ | wc -l
>     80
>
> I think we should try to unify to the following style:
>
>     `--frotz=3D<string>`::
>     `--no-frotz`::
>         When `--frotz` is given, the command does THIS using the
>         given argument <string> IN THIS WAY.  The default is not to
>         to THIS, unless SUCH AND SUCH CONDITION, in which case THAT
>         is used implicitly as <string>.  To disable THIS even when
>         SUCH AND SUCH CONDITION is met, use `--no-frotz`.
>
> That is:
>
>  * Both positive and negative form are given separately as a
>    headline item, so that "grep" would work well;
>
>  * The description should be unified, so that it is clear to readers
>    what happens when the positive form is given, when the negative
>    form is given, and when neither is given.
>
>  * Mark-up the text that the users MUST input literally inside a
>    pair of backquotes.
>
> Which means that existing "--[no-]opt::" heading should become two
> lines, "`--opt`::" and "`--no-opt`::".
>
> Thanks.
>

See also https://lore.kernel.org/git/xmqqjzanzy8k.fsf@gitster.g/,
where I had some similar questions (and got similar answers). We also
merged 4ad47d2de3 (gitcli: document that command line trumps config
and env, 2025-01-16) as a result.

If I'm reading right, this suggestion differs from the previous
conversation that it's worth splitting --[no-]opt into --opt/--no-opt,
which might be valuable for searches of the kind Lino described.

I did eventually push beeabf89 (vim: try harder to find long options,
2025-01-19) [1] to my Dotfiles to work around the current
documentation patterns. I press either `-x` or `_XXX` when searching
for an option (short x, long XXX) in a manual page with those Vim
keybindings, but hopefully the patterns are useful to other people.
For long options, that's

/^\C\v\s*(-[^,]*,\s*)?--(\[no-\])?

[1]: https://github.com/benknoble/Dotfiles/commit/beeabf89

--=20
D. Ben Knoble
