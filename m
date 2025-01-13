Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992982451D6
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760677; cv=none; b=Xm5AcOgRqYeIiL5J9VvH0I/cMy6G02IeosTLeS7V7Z4DGxmCamfvrqZqvMygZQaWlMJ38A5xWiQPzXONw1Jvm8QkJIb/YTaJVN1OPMCg+bMWbIyPU6fqN9mt28IUmVCeJDc5V29qIGKbK5UOm0XMmLmswbteoSPUTSvU8mAUmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760677; c=relaxed/simple;
	bh=koiF4JCr5asCt4hoB0AAJ7kZ+bom2zgCiYMRXxt/x94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3Aizvb0+CZdYv7Wwnwx79NdHtHC5eXhS/XYWYEZbSm4SnL0ngbZzrJJuBXO71eGhLnb4dn7VPWknN7JgGitHy6y8hrFCnz0BHJ3HHw6kgRh0gyXCrDMcFQfyc/78+KY8lpkubFS374matLTbu0+rxY1JoOmrbyUXYnJOuPDeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHmN8sj4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHmN8sj4"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so37505901fa.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736760674; x=1737365474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koiF4JCr5asCt4hoB0AAJ7kZ+bom2zgCiYMRXxt/x94=;
        b=kHmN8sj4FDmTMi3O4mhoQqr7EbI2j4oAeXw1kLF8T+oELJY0Zer30+hoZHNnpo+pRz
         AN5FrUS+UuXaTYg+27y1ScRm+/UZ8afJy8TK9XRsu52bDSx38Zvq8SxCa/FVkVn7xIk3
         UDL5QGljCqyNDW+pig530H4qy6y4WWoTlgAxTmU/9iKpxL+4UReEzdmXrjAfns2JLDCo
         hoZtY+LBzpNFngcOO/4NMmeg35XHrOkjUcsgkGy7poa4kJhGi+Z7C2QZPrf8TfaoTb5/
         Kr0KQnStYFYNiekXQSkrtTeWxfnmcSbDMgdBefBM9pt0THoh7Inh6dx38nk7BHShJge2
         +qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760674; x=1737365474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koiF4JCr5asCt4hoB0AAJ7kZ+bom2zgCiYMRXxt/x94=;
        b=xLc0NRtO2j/4ELYrxF4MsMVeqDV5ko8cKhDO+MVQyA6nG0ZFqf6PpoHuXNJX7vlp3i
         Phl69OfKIAAzva9YwOMff/f16Pfj9vbCVf5WD/5OVY14n2OVb9bNiUuNqHs6TqqwO8Ka
         TDO/eENAQB1aZdc2be0lt7zI7ZzWKOuW8+ToB6Vn8zES3YddWVq+o1z34NeRD4Kpf0Mv
         LEINFhWGLrZjwS0rBG6v9DXrB6pPTfdfsgWXpc2Hd+STvcLnGXYWIv9uYu4JtlHn4qVi
         nwbKPcN4wrlZP+kX7P6JOrT/1caHQUWHyrdnltxBOQS/PRUUP1iFr/w4pni30xEOLJmp
         IrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRY4By0Fa5WnKewK/4HKCzpMp+RuocJ2b1AHhmvv1MYT5qRhUsy9LC8Z+hNKjsjOd2X5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdwDOMcR+uDthSW6RWpq6zQm9FkxabtglNsbFeTBT8sjOUxBCl
	rVdOamb1/vF8q3jPQQkpJpi8U7yGlEUqVrUmbAO+R61umdd7DpKqMpF6Ld2ClsTBxEJU7ivAHMl
	/lQFewm4qFk+EckWr+4zperEgR8M=
X-Gm-Gg: ASbGncsgU4f16bXZyr1RuPWIGHvBmySqqUwvCieWexRBHcZ+m1lXDxy8lCvnNlEsEld
	tGHTVKUXXW9TNgTx4LJoOoOAWKJGA58I7VtSmyKFCDzIC0evkOVJBBSYOzdzy9rhXXldOlg==
X-Google-Smtp-Source: AGHT+IGvwezW5IkBHL321RhMKy45G6CpgpABHbh/dWdciugiGMRWdpkd4J7BM43epb8RD8gUmt5zO1aHqqgZoqshIpI=
X-Received: by 2002:a05:651c:b0f:b0:302:4115:18b with SMTP id
 38308e7fff4ca-305f4525446mr59474131fa.1.1736760673442; Mon, 13 Jan 2025
 01:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
 <pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com> <20250113054355.GB767856@coredump.intra.peff.net>
In-Reply-To: <20250113054355.GB767856@coredump.intra.peff.net>
From: Scott Chacon <schacon@gmail.com>
Date: Mon, 13 Jan 2025 10:31:02 +0100
X-Gm-Features: AbW1kvZJxD_NryxjQCbXAmEfnfcROnonKyHJa5HYJkcm6WP2-loRdSqSoiDsdYA
Message-ID: <CAP2yMa+Upc0i688H5+no3sYbz5X-Ma=KBuaVALpPBdNDHuG8QA@mail.gmail.com>
Subject: Re: [PATCH v3] help: interpret boolean string values for help.autocorrect
To: Jeff King <peff@peff.net>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yongmin <yewon@revi.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 6:43=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jan 11, 2025 at 11:27:19AM +0000, Scott Chacon via GitGitGadget w=
rote:
>
> > Interpret the value of help.autocorrect as either one of the accepted l=
ist
> > of special values ("never", "immediate", ...), a boolean or an integer.=
 If
> > the value is 1, it is no longer interpreted as a decisecond value of 0.=
1s
> > but as a true boolean, the equivalent of "immediate". If the value is 2=
 or
> > more, continue treating it as a decisecond wait time.
>
> This mostly looks good to me, though this part gave me a little pause:
>
> > False boolean string values ("off", "false", "no") are now equivalent t=
o
> > "never", meaning that guessed values are still shown but nothing is
> > executed. True boolean string values are interpreted as "immediate".
>
> I think false boolean values end up as "never", which shows _nothing_.
> As opposed to "0", which continues to be "show but do not execute" (and
> which we can't change if we want to retain historical compatibility).
>
> That's probably OK, though it is a little unlike other bools in that "0"
> is usually a strict synonym for "false". So we could go the other way,
> with "0, false, off, no" meaning "show but don't run" and leaving
> "never" by itself to mean "do nothing".

Yeah, the first patch I sent that interpreted booleans actually did do
0 rather than "never", but Junio continued to suggest that this
returns "never" so I did it this way in this latest patch.

I looked for a hot second into how to do this, but the problem is that
`parse_autocorrect` can't return 0 because that's the failure mode, so
then we would need another constant or some other way to return
something that means "don't run, but also show the matches", which
right now is only this special value 0.

Honestly, I think "never" is a fine option if someone is actually
explicitly setting this to a false string, even if it's _slightly_
inconsistent with the 0 value.

> OK, so parse_autocorrect() handles all of the non-numeric values. And
> then we fall back on the integer values. Makes sense.
>
> So assuming we are OK with the "0" vs "false" split, the whole patch
> looks good to me, modulo the nit about folding the "immediate" line in
> the documentation.

OK, sending v4 now with just the docs change.

Thanks,
Scott
