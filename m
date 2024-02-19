Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0851C2C
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386209; cv=none; b=Sq9Xv5AaB9OJhz32HapQ4JZRuOH5zLnldlM/SMpZIavY7yFqidnmC4RFSXV50frPYpXtYjzZFmA9Xw8wDEd6FjDY4R610iLQ4Kk/9Nwcabt4l9i3ASqPuFyqxKpLNodoitTJxd0Y5MLTvEZrUw1ERtrsvJRH278rTMzzyfMHnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386209; c=relaxed/simple;
	bh=aoBE0sIAqdOmsPj2CIqy1BvprNtCAeT1fY6+pCZM2Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNmfhV6VfDlLwPeENTIV7OoyaDM0QktjWFFGWYScRRmtGbi6W8EoTaTu2RoGPGr8K4Ch30tBjuvbeebtV223U8e/oSxe0uXc/z2CtaT/t/n6T2ITDK1FrVnSuWmuAyZZW1n5Bmxl/EUaUX0B9Qnlj1ix2iIlG3mJdqK5NZWjT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5wwlW40; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5wwlW40"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6085ed1e916so2845977b3.2
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 15:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708386207; x=1708991007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoBE0sIAqdOmsPj2CIqy1BvprNtCAeT1fY6+pCZM2Rc=;
        b=h5wwlW40Si7wQQ0MBZ1gbykIEdi0cGUxEWCvwZmiiTbUuR1/iBuzBtgQ8RHQnE5Xhc
         cZp0ZSt8bTgaTmQ6YuxPNGDKbt+iDmMzgj/JWMcllcgpanMTCEXMt5uraNHyiyPKi1hb
         iSRknHnz1ExajQTibgyLAPDGkBExg4B9MdhLe9XseX745bKijXrThHHZZ6xzy5z8oLTS
         hPFs976631i3+DS4sbq4cKD9FMtjCqdfIAkQ8HCx9vN+yuNgvHTDs0xKqJ9UYR335lx+
         OF4xigtzxBKuKSNf7LLlL1v9JLP7zxd0MvA9uo3fui5fO8oDAOaaYfqBGU6/Pu+tMRST
         0ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708386207; x=1708991007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoBE0sIAqdOmsPj2CIqy1BvprNtCAeT1fY6+pCZM2Rc=;
        b=Cr90qhWm+d0z0OWSHj2nIcBnYXGI/DPFk08L+QbMU2f0GjyJetUVqwit9ncsA0mUZv
         sa05BQa9BqiGX5LRsjdQcvEF7xGT6ttX4AQmeBSv0qwxeZ7LN/5eFgRPZJrdDQOptayc
         YYoolMWeP/DVVcy8HsaddILlcERcVTnbLwAralUNI5w0YPO09yrLZz4Rbl1G7qmXMmjl
         hHLfsH9eQvqGJcPWbuK+r9pOqjbex9JdjK20J/aw6GFNUbJXDXVVgjKCUQ3kCl3pSfVn
         odNTU10GQJXkEbKNowm1BPf2bF7qKHmNWCp3JTHfkNKx2bAiH6t+3Rq3J0lvfjkEcIXQ
         U3hQ==
X-Gm-Message-State: AOJu0YwRFHwSUS7OlrFCh425caqRm34figTJxGjBC2Mv6RcApoSG76X0
	3yN6R/UN32262lGMjMcDv4mIGxRnOm279J88Z8lQZMtJhhmsNh2tZy66xRQ8YKzwiDNKq9enyXI
	4BPXv2BZ6tkLqM1ydAEPbwXxqTS8=
X-Google-Smtp-Source: AGHT+IElZ3DoD5bgDcTLk7zftxKJYubxFIhArz/k5Wp/fRZr+nsNGt95YUvUS1K5fwsEbzfenpwHw7JgmEGxca/vdDU=
X-Received: by 2002:a81:9153:0:b0:607:fab6:ce8 with SMTP id
 i80-20020a819153000000b00607fab60ce8mr12172915ywg.3.1708386206978; Mon, 19
 Feb 2024 15:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJh0PTiN18LcKP6LW0d1u2gkodBD2cOJRBzU_subBaFpzM=CA@mail.gmail.com>
 <CAPig+cR5K=pQjK+7ZUyGn1M50RZ0pRD6kOPQgmp7qez_LNXcAg@mail.gmail.com>
 <CAFJh0PTgjj=1QAYD+tyqc_35TZE78QJJv4WU-W3aiJiFOWHP=w@mail.gmail.com> <CAFJh0PRJkVBr-A=UtmEcAh4cPgC3w_vdTPg6kkjgHVQXHTYRmA@mail.gmail.com>
In-Reply-To: <CAFJh0PRJkVBr-A=UtmEcAh4cPgC3w_vdTPg6kkjgHVQXHTYRmA@mail.gmail.com>
From: eugenio gigante <giganteeugenio2@gmail.com>
Date: Tue, 20 Feb 2024 00:43:16 +0100
Message-ID: <CAFJh0PQPB3DBfxhLhzYgY212yzXOtRt_TtU=7B=SsBOH_iScVQ@mail.gmail.com>
Subject: Re: [GSoC] Use unsigned integral type for collection of bits
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 20:09=E2=80=AFAM eric sunshine
<sunshine@sunshineco.com> wrote:
> The code in question is not being used as a "bag of bits". Rather,
> it's a tristate binary with values "not-set", "true", and "false".
> Whereas a typical binary could be represented by a single bit, this
> one needs the extra bit to handle the "not-set" case. Moreover, it is
> idiomatic in the Git codebase for -1 to represent "not-set", so I
> think this code is fine as-is since its meaning is clear to those
> familiar with the codebase, thus does not need any changes made to it.

Thank you for the clarification and sorry for the misunderstanding.

> So, refresh_index() is correctly expecting an unsigned value for
> `flags` but refresh() in `builtin/add.c` has undesirably declared
> `flags` as signed.

So, an unsigned type is preferable since we are dealing
with 'bags of bits', and probably only bitwise operators operate
on them. Also the mixing is not ideal.
Yes, I'm interested in fixing the one in `builtin/add.c`.


Il giorno mar 20 feb 2024 alle ore 00:39 eugenio gigante
<giganteeugenio2@gmail.com> ha scritto:
>
> On Sun, Feb 18, 2024 at 20:09=E2=80=AFAM eric sunshine
> <sunshine@sunshineco.com> wrote:
> > The code in question is not being used as a "bag of bits". Rather,
> > it's a tristate binary with values "not-set", "true", and "false".
> > Whereas a typical binary could be represented by a single bit, this
> > one needs the extra bit to handle the "not-set" case. Moreover, it is
> > idiomatic in the Git codebase for -1 to represent "not-set", so I
> > think this code is fine as-is since its meaning is clear to those
> > familiar with the codebase, thus does not need any changes made to it.
>
> Thank you for the clarification and sorry for the misunderstanding.
>
> > So, refresh_index() is correctly expecting an unsigned value for
> > `flags` but refresh() in `builtin/add.c` has undesirably declared
> > `flags` as signed.
>
> So, an unsigned type is preferable since we are dealing
> with 'bags of bits', and probably only bitwise operators operate
> on them. Also the mixing is not ideal.
> Yes, I'm interested in fixing the one in `builtin/add.c`.
