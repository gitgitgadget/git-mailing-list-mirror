Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16C18D63B
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153407; cv=none; b=o+FzMnTPCTzFwWHGbCNzubRPb4ZSo8zlihJJwju5Or13awCtbgIAzQtbGa6trCCdRyYaUdfDSX2KiCtkfQyfX9tG/w1cgERwhpD8exDiaownswbHULzOIIO3FmAjviNu6K2maIbcK5GZF6xK52VSQcpC/pbKGl6+84GjzTQ9tOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153407; c=relaxed/simple;
	bh=AjuVo/e83VWh+EW0wm0lU+eiq7TgxR/90MoT/6ZroiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoNJ4TTmSUbGnZfxazfUr4lkAuxhWVE6hh1u3J9kCqEyj+e9d7McG3oZQDus4geklhp6avUJ08BgaPeFmlva/kMT1w8HZoFpy1qpxfGNsrSQhbVKca3paEJMW4qspoghBc37g9TibaQEKBJ2HSUc+QJOY30u6Lya0KlgTKFLWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuT2MFZv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuT2MFZv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86464934e3so106237966b.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724153404; x=1724758204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFsSxXVwHe2ce9hV47ZE4mKuwTs7DU9dSmJDHLb3zfo=;
        b=KuT2MFZvtBqbc7E3aP6gtbZSOSHpBtv1zsPtLdWoZ0/Lpp886mKtrBQ/MGN5D8nPqw
         tWGRZSXy8DWw3oXyvF9PPXlfGJxDXBsp2l+BYyhQvWiOrYRvP04VcsuriqPXEplxo9aD
         wVf7bByKkKPRiKBr50Hu8algZe+Izy55OsM5RHLW6P0dwv1ATNuHEu3xry/FWeCbxu+B
         VThE+D1xAWb1ijORht0RgEQLuQ08VfdNYXzyVdqqKkq6dTLF6Fixm/2s2cK/mDMaARvl
         aQs90HWW79pp+XFxJGwqAAc0Yi129HM/ccHpLXu0CGf//RjLi8ICTVMNXgySJ8kbN1en
         ulyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153404; x=1724758204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFsSxXVwHe2ce9hV47ZE4mKuwTs7DU9dSmJDHLb3zfo=;
        b=cCg6pnegGq3t6kj6/oH9qoW3R1VWk1x8EUBKJgtl/RAqGcW4O59LjYiuIPN2XqgxRj
         Hp6dtHTgLlKfWsOsOaBL6aBs0yTm6Qb4uS04DDvM7CTQzJqACZgfJM4/jH9Ae5Sv+M96
         OyBpvaJ7t4cwsyZNvUH9O/t7UOpqYFK4IxqpZZ+iX7H1SlJu3XExZHius1b4uWbG55EV
         TpqUHn7evWcWQMyRjZQBylS5WUbcLTHyvMWp9O6NUVv7Hxi6jetZF3U8gSek0fz7ASJN
         rmG2Od3nTVKNJjaHiOSK03RwEjC6YAb+iHlr2LAAPOT6GY5S93LEuoe0JqhMGaojHWjA
         41eQ==
X-Gm-Message-State: AOJu0YxlJ+SE5p8E+ey9v5IxSaI9cnOSpxMPcfVnzOSX1HfrNIhS/t3B
	LOePiX9PZJ1ZcR7/dwGG5cjr1AtXHsHaq2c4MC9tuaXmcLU0INlL2MSqsNW63Dq8UtaqevS5Mj/
	Hn+TFA05pOCnIlT1sPwnE+KTeHIs=
X-Google-Smtp-Source: AGHT+IE6RFmDO1kyV3jGglE6gHiD7skRMkyphLo/fUaxCvmnT+FMazzsVF2eKF05fV+IhTvXhFrWrgnGt41Ow2YGh5A=
X-Received: by 2002:a17:907:f1e8:b0:a6f:e47d:a965 with SMTP id
 a640c23a62f3a-a8392941bd2mr987131766b.41.1724153403364; Tue, 20 Aug 2024
 04:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-3-christian.couder@gmail.com> <xmqqle1h5v37.fsf@gitster.g>
In-Reply-To: <xmqqle1h5v37.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 Aug 2024 13:29:51 +0200
Message-ID: <CAP8UFD1akB_0xL8icMT6vxgKu10KEefXM_K6s5bT=gWt5uVHqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] strbuf: refactor strbuf_trim_trailing_ch()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > We often have to split strings at some specified terminator character.
> > The strbuf_split*() functions, that we can use for this purpose,
> > return substrings that include the terminator character, so we often
> > need to remove that character.
> >
> > When it is a whitespace, newline or directory separator, the
> > terminator character can easily be removed using an existing triming
> > function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
> > strbuf_trim_trailing_dir_sep(). There is no function to remove that
> > character when it's not one of those characters though.
>
> OK.
>
> > Let's introduce a new strbuf_trim_trailing_ch() function that can be
> > used to remove any trailing character, and let's refactor existing code
> > that manually removed trailing characters using this new function.
>
> It is disappointing that this new one is not adequate to rewrite any
> of the existing strbuf_trim* functions in terms of it, but that's
> probably OK.

Yeah, I took a look at that but thought it wasn't worth trying to
unify the trim functions as they each have quite specific code and
requirements.


> At least this one we have two existing callers, but
> makes me wonder if these callers are doing sensible things in the
> first place.  After trimming trailing commas, there may be trailing
> newlines to be trimmed, and then again whitespaces around the whole
> thing may need to be trimmed---what kind of input is that?  The
> value has to be " junk \n\n,,,", but " junk, \n\n, " will only
> become "junk, \n\n," without further cleaned up, and it is very
> dubious how that is useful.
>
> But that is not an issue this patch introduces ;-)
