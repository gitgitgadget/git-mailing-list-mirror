Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DC2D77E5
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537770; cv=none; b=EOy01RKaOwTojBtifN4hO8SwcOcnMahja+LPBsbW2F/mkGCAOAGFcUVYh07RLIXwr2NrcqzrB7TOBrzqPFGsSzkCoDOmOVzSBVNnQWUssQMl9VFYyB8lHGmNva3Y71hRkWx98A+oZIo+4FuFFBiXe2ATUUqucFbKJjJfp8s+zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537770; c=relaxed/simple;
	bh=8BMwEdiPzZ7KMbR6/Xj0pyQUy5D/sN1ODkhr+pBc1PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0IFMk3wOy8AmE6TEe+lHU+EF/57qUdvAxaT5FALPbL/qenniqZsUGRYA0maFXpE/gHk2pv960db+G1T0xJOAR57Mox+7TnzDYQTF5XSsGxUZLYBTVLoun//pLrWdX4bnK73AN+G7fyBYWKgT62dhBd3aBbIDi7givC9GgpX9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2e2500517so81691585a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537767; x=1764142567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBKNKE4MGlf1LUqJYBoCsettbdk6MjR7oGarzB5mdc4=;
        b=N1RIQyekuc8m6NLK0NKdOOR4enOO+i0Ovtc4IcCzfXc0xGIvI/af54Jv7iMyhsj56N
         hoFR+F8x4UES0f2bGsqfkpzhMuiJSiwvDytTjTElGFK2uoK1xvC5sybZ5qc7Cw7oa3vd
         qnv7BYc0x32cYN6fVratUR7RuX4ucdF69wX+/dLJf2ZC75TORQgxvzS7KlxTBlxNQJ0E
         LPsCVqFu6SqqWXJSKCEP1lReuSpl4TdihQ2cvQzRCGkNK76GM731BHO/Ab6Qz5TgLGWp
         gsRwcEvUVQcgjQv3aNAmw3ha+ShTwzF1EqZgrEojZh8RRkqB94BEA7VMtlVG+nhxNMN3
         UHvA==
X-Forwarded-Encrypted: i=1; AJvYcCWEkZbqMR4iyhO9wNz/rkN0ooWFlqVCBAQOl7LYZuW6j1OIHhi7J/NZ3Geat9EW61V0Dyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EB6rg4cwo/BBYGy3kZo4hoi0luYv/12fzDNDvVWJI0S/ejIH
	I2XWdlHw7N90isKzndU+w10Mvf5784eJ5w00NLzT+WVRqdWmTTVBHvh9fhKsHeQ4N3GVhp/USmu
	DdlPoYHmjbyMVetPZZoOtv4TEuTzWmH4=
X-Gm-Gg: ASbGncutzO7NSQoa9QjvHXIHWA+cjX3frxdiFNfl60skDznTeASR/67kkTsK59eVt3g
	MuCYOxiFJVvCUZ4W9fP4mpIcfnz3Mv+Sb0eSpfS3wDGrc8CxTpLx2QKkfWe8R1zOe9lwa6ZdSaA
	I2jLLdKvsbbj0yox/ZefmGuWGR5uRsFSxoiiATtpN/ajBb0IpGewAXGrC//t1l1anYckuIjpd4c
	jVjmDIMFo01K86pWsKw6yIKixgy6iuqwm3s2o6Iplc6EfQisoe0o6jL53EayceqljmHGYJv3Dfr
	1N9eDhlusvEmC0Nz6GRgaSajo24=
X-Google-Smtp-Source: AGHT+IG0u9VzzmBzjbcUtmyVYBBF7QcWiz/7IeQMX3IfYKrRGwG+CM4kMm6ncCMePt0PDi/TBvHQMYFp9U4rCUL2KmM=
X-Received: by 2002:a05:6214:e41:b0:880:5222:358 with SMTP id
 6a1803df08f44-88453a39a31mr54281096d6.0.1763537767544; Tue, 18 Nov 2025
 23:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251118204929.43597-1-lucasseikioshiro@gmail.com> <xmqq4iqrdnyx.fsf@gitster.g>
In-Reply-To: <xmqq4iqrdnyx.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 02:35:56 -0500
X-Gm-Features: AWmQ_blpLOKt1ptQvdxXucyEQzNAVd0OXXxf9A1ZoLEswvEVJ9aXNo1vEfwO7Zw
Message-ID: <CAPig+cRG3qR0osmFk=F93mf4di+i4WHWemu=_WDUeD0Vz9pO9A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] repo: add --all to git-repo-info
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> > This v5 addresses the issues pointed by Junio in the previous versions.=
 They
> > are two small changes:
> >
> > - `print_all_fields` now has the same signature `print_fields`
> >
> > - now it uses `size_t` instead of `unsigned long` in a `for` loop
>
> Looking good.  Will replace.
>
> Shall we mark the topic for 'next' now?

I think all my review comments have been addressed.
