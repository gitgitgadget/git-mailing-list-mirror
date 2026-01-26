Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2C25B1DA
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453866; cv=pass; b=s8Y9P1GO5JjqYsS4hECBadtxhm1UcWCjwpDvzfSDUw8U2U4q9DF0ji4wxSTK5aBVkoFq/okQKO07D/dudVwqjNsFspbK/AoklF4LlkPYxR+JpS8yv5/wLlvvS7odcRjRCX705XZ3zzjwLvjNU6DFPDLC9+a9lDRc63lQ7fZnhhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453866; c=relaxed/simple;
	bh=tt7qURMnDRucmNZTdYuUnWoAfjwslh5DIaRyPLPJY70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xsq7uf19xpMN49fFFP3ppmLBg4FJ1d91ex2CxNgAG5oFpK34HS0ZJL/CCGx/Us0DvrXPiCeiu5mOYcPtayomxlZzPSFuUQBIc6WwFwZdqKf+BvJbn4iYU0eZ4uC5CxrC52gHTk83UbNIkD2dxem8/YcYgZfVO2SDSgmbNKCBf18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz2CjI89; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz2CjI89"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78f89501423so52655757b3.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769453864; cv=none;
        d=google.com; s=arc-20240605;
        b=h8GOicKdNBciFTSY3HtRbdOua0SL3tPRkGvXoo5sOwblhAzMn+K/6xMTRByBvOy5N5
         CWk1UZ/TvB+zkPx1/DltR3GOyD4nPxBVPu1YOddX/sSXrFJGmfYDtowXO1osSQBQpQdS
         7eK3i905U1tJ5vapYeMHsfrl2pMjBKmYVCqwq3rqIk5Y0daAGjwuF62XQSHAmymAmG06
         smy0ysdIlXfVjqlzYIA5td6Q32bKMHy1cIvh3hRNx0W/uJrtC7PKSLiotm4mPfsLEW+X
         li4OgJfd7rDRNq1euQC8d9z2Cl4CNuunxOFyfnTDMsjirkwfapjFsVNO5Vm3o+RKE3b+
         YI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TNuu5oegIDNKJEWeKB9exI9gwf9IITCH+IhXOtbQrDQ=;
        fh=KB/KfCkpzK+iRdMEI5qQ4XuHo+HR/JifYdePdXFr46g=;
        b=W/sEQptXShVDeczYdyhK1BhMGuvcCkEVyE4louQePcx4rqeSu8jOl4UWcawbOITDiB
         +Isc5yG5HhvOEtrNeUjkRQynaVxllXaK7JQW4cd5VYjcr4HKQTkS+X7nijWMGtqCsQqr
         8gu0qUjIhhEyurCRfxC77bJxXyasJT/ewqJVwhPa1Nb0q49wl2K0Ui0vNQVoG+Vtasgm
         CEFmflF5X/AJ/EMxbNtoEP9SyolazcLmYPZpMrcNGsFuyS+Pcz16sQ/FvOET3+rA5uIe
         z1ep/93tVQn7kUEjUZOWYjxYfWHUnvRFRUAYBNOAozsGb5CEeGCLyUNtr7a1xaSSJWUd
         UG+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769453864; x=1770058664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TNuu5oegIDNKJEWeKB9exI9gwf9IITCH+IhXOtbQrDQ=;
        b=kz2CjI89kNICQwLuPbQ8jzn/GRYEWcv/v2hSWxWUd4dpOg92CLWtKTKnhWIuswmWqK
         OWKKfRvuE5A+vDwbwUB91HHmgi3FM8WlwgWLVPsb638gwvEHGPJx1UqwIBS8v+DI9l+D
         8GiuOyui/sT2OOv0ArSPcGodIB+S3blhqwnJa7uAkwFwm9Y2lV3Ynnub40c15vrtmQ1K
         wpBuCh7Q+MBjxATY4UlaZsCumgjnTk8XPCanAgZYAYsHC52gOxnKzJ4v8VUMPJnt/cwp
         f/CGRd8L1eoK5KlJGUWR9DAX6O9BJPRRipG3ox4zp+78Pbiw3mtQNUUNeTKTOKJ+lk5X
         nHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453864; x=1770058664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNuu5oegIDNKJEWeKB9exI9gwf9IITCH+IhXOtbQrDQ=;
        b=quLZTArI0iVY330xSL02Y/UJzYInLUqnjvW8ZbEZQknkMtBzOGImSlOALehjN9NnME
         eAa9htojfpd/LnJCXS1btShqnvbwfEz+bwjNnynp7krvNet1CKthmvWT512lDszvzVum
         p3W55aR/91N7gBa/ccEjmaOcHDDlG4Pf+4Gpb0fIbkbn2fu0i0fz0i9jCoUFUXtNfUhj
         lwb56daUWHsaEiluogH5YNZYuCDQSBDRYdEeh/efjZV/DV8pQMWnEocsuvItf9Am20Gq
         y26xxI4MRZuS5+S/JR2gOHRf/YWmn6XdxsSF1bXKBNeLYtf58wIl9feDxejKnWJ+g9Hh
         682w==
X-Forwarded-Encrypted: i=1; AJvYcCUu8scRQTfU/T/CldoW0mz8Xj64knWivv3cpgIlDshfIKjtOASg+iXwk1ykMmL3jJCGJGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVvtY2e/dB80EY+P9FIUoaIL8EHtvG6YCDt39xlcQS/BdyKVm
	UE0Aaa4+gjRL4aDawxfwM8Bce/YCO+/TljVWTyEUgJEbIHwf2VRS8djCivmQCn00XRNAlVpNF+J
	QiS42i0yUltukwoCebdlLYARlOWeNwwCWWRk2
X-Gm-Gg: AZuq6aJqUXGDKq0A0r1VXF/C07pYHo2BZPsKR/phiiFow1+nY4j7B9Wb6U1Ne+xO02s
	dEURiujVhoZgI+w9N9h61RoCmZakpIT8hbIi03ASVfe0eY7pCYKlbdvhzJLz/0oprOxijufTHmN
	5gNkCd8fEYqj7cYUDxbZnYIf3nq0cVBO74FOdcH9GIpsVY4tajrJheDeVCMBi0z7auBV+KIH1v3
	x807DCbBqMlWmWwAr+NO+XJKFlL87LZ7oqkNHaQfI6FlzbPGkj0uhF4UeevBEnPcE2sM8niDFrE
	fZFr0klVCKSj9MQskhUpLZTRZOrR
X-Received: by 2002:a05:690e:1487:b0:644:4eec:22a with SMTP id
 956f58d0204a3-64971349996mr4038853d50.2.1769453864325; Mon, 26 Jan 2026
 10:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122171523.94234-1-amishhhaaaa@gmail.com> <20260125201500.63904-1-amishhhaaaa@gmail.com>
 <xmqqpl6wkftw.fsf@gitster.g>
In-Reply-To: <xmqqpl6wkftw.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Tue, 27 Jan 2026 00:27:33 +0530
X-Gm-Features: AZwV_QjOSBYlWatpJ-Mot0m_BipZloa3p2xOujiWfKvBZxKVCd_CKJxB48oEN80
Message-ID: <CAPvEtrcLrrRhOi2OCaQzD6xNSHbyv38cr5-WLRPg_HGW5UKzAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] u-string-list: add unit tests for string-list methods
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Jan 2026 at 12:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
>
> > Unit tests in u-string-list.c does not cover several methods
> > in string-list, this gap in coverage makes it difficult to
> > ensure no regressions are introduced in future changes.
> >
> > Add unit tests for the following methods to enhance coverage:
> > string_list_remove_empty_items()
> > unsorted_string_list_has_string()
> > unsorted_string_list_delete_item()
> > string_list_has_string()
> > string_list_insert()
> > string_list_sort()
> > string_list_remove()
> >
> > Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> > ---
> >  t/unit-tests/u-string-list.c | 197 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 197 insertions(+)
> >
> > diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> > index a2457d7b1e..6b4b858330 100644
> > --- a/t/unit-tests/u-string-list.c
> > +++ b/t/unit-tests/u-string-list.c
> > @@ -243,6 +243,133 @@ void test_string_list__filter(void)
> > ...
> > +static void t_string_list_insert(struct string_list *expected_strings, ...)
> > +{
> > +     struct string_list strings_to_insert = STRING_LIST_INIT_DUP;
> > +     struct string_list list = STRING_LIST_INIT_DUP;
> > +     va_list ap;
> > +
> > +     va_start(ap, expected_strings);
> > +     t_vcreate_string_list_dup(&strings_to_insert, 0, ap);
> > +     va_end(ap);
> > +
> > +     for (int i = 0; i < strings_to_insert.nr; i++) {
>
> As strings_to_insert.nr is of type size_t, even though int is plenty
> large enough in practice, the compiler will complain.
>
> > +             string_list_insert(&list, strings_to_insert.items[i].string);
> > +     }
>
> Also, lose the {} around a single statement block.

Done, Thanks for the review.
