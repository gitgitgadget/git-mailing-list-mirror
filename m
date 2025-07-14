Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305B1FE461
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489274; cv=none; b=e5Volfa5Iur59JyM0k8AVHir4FoIcDZDpieUb5GGm2tuKKe0vNGxsWmlTgYlIB0RpfyOBp+kamM6OKKpF3JSrTG90EKwD3OYkkMhAroeJIOESFErYo9F2UULMfTADNWMoNFhFNMwgLrnrNPxE1SxzRnrh4DWejUL6K9KcKvkYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489274; c=relaxed/simple;
	bh=2khAHQYF5P3AH78dEjNARLjzEYoayKWQobpCocGp7qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB43G2HniGCUoUs0bxBviRRBct9uklNkz0jyB0ZWcMU5v7jMJvSv0Wl2tPHua76o4DanEnUmkIjyI8luEjhNh0no9EOnePRZFR9zJpkyku5yEn2aJZSevKx7lnEwCPGiReUnPbxamY+75WnOUoD4tjV7dAflIPDrkmLfYK2d+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2hNm2YP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2hNm2YP"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adfb562266cso720721366b.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752489271; x=1753094071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks+eGyJq1pRFZO0foSWPe5BKWE0nRPJULpk9FRg6+eo=;
        b=Z2hNm2YPzqSlDVtxiFIkMBI1HJveCrO8eJSnY3m2MAec364XsEAooWw7gLHVxnyF6M
         dLh4doZaJPmxTwLl70Ti5dbT3JhIBmYDRVbrxfZcMVBokBr1SGX5+8cJyi+RKsnFfMfU
         E9FuxfFMPyV+E8Oxk3X7y/RCLl+z4NPBYIbPKUGZ5xUXu3gySu2iaFN0a8lQjb3ArOke
         GPOIxVjD67NHtCRq/Z2h0QQLnSY9Pzza1H4r7wP9tmz8bRMhqiYM/XimMsx6Iir/P6iZ
         fc4NUEn4wR0HR/8UgF8rAxcs7s1Q2lgzqb5zRBM6RGg2WWcXTEnVr9MCz1HghBQoguWJ
         gMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489271; x=1753094071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks+eGyJq1pRFZO0foSWPe5BKWE0nRPJULpk9FRg6+eo=;
        b=hXCgZw6IiUHgZagWyYj8xT75a423Z//FOY0J5biw/G7ZS9OLHjoV+vrlLuBffPwTiI
         kmHA1AZ+iwy48rzXj+zBwTvoCdM/8QxzYKzB7IJaerD6VMm83ikp2nXfn/foX45lbwf+
         8xImxRoeHUrubm5vfEzzHo8rFgO0kVpO3+Mnsxg/ZLJ6fGg2rCrQ99QdKeSEThx+cfRO
         BM6nxpOMaumCilf23xhdeTCgd3gkQyM4jputYJj4fnAHR5aHD7Gayi8XKJSAx4oFD/WT
         uqeSYdxyDnKO9qyO3LbwIjY01AGpPE9cCB3nnyMfJLic+l3F3Mz1OJgxYJEnavjyAwMv
         wFCA==
X-Gm-Message-State: AOJu0YxHOoBkDXjgm32Qnq657X/SL3bTj61dwrYgiLwK/L5c9i8AKT28
	HI8wnW1l8OFzReumH7lapDB9nCWRfhbrbTtni7nf78wU3JTXMl+ANAnnIkBQT8o2mYdZjgiSfXA
	0ixmdBMSstFj60dYLPbC1ouOHbeT/gx8=
X-Gm-Gg: ASbGncsPyVqRn3B/fx4E7w+1a1fhd9gpxG95TJNaWbbnMT0j6HVx7jJoEaB85/tQDpk
	aZOTd16BczHwb3zGQbzQMn84iQubRafSILg2d0EbLUm9GlBl0p1cVw0f3Jh4MqrYXhcaZUBU5t3
	xIdiirE77mtzCgjc7b3F6tFxV0t7NlRUBZIs+M5Cy7a4B5UD3X83vakNuSFfRycCiKXBvwQUCSA
	0m/ewIYvcIyqRtE2fbyGjqp7rrC0tquXU+tRQ==
X-Google-Smtp-Source: AGHT+IHSt+f3u7Z8N8j74UuzXB982YNANlJicfM+xnG0riwqrnbzykl7mBIIJlCztkS8lK7vjhidZiyI8+Jzv3+PSWQ=
X-Received: by 2002:a17:906:c104:b0:ad8:9a3b:b274 with SMTP id
 a640c23a62f3a-ae6fc1259cbmr1234126066b.52.1752489270263; Mon, 14 Jul 2025
 03:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
 <20250711-306-git-for-each-ref-pagination-v4-3-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-3-ed3303ad5b89@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 14 Jul 2025 12:34:17 +0200
X-Gm-Features: Ac12FXxqUL0OKZDzuqtRO47TmCLJ720Ah1VOgReOpMzIjGkQ29Fckikh-HKaG3M
Message-ID: <CAP8UFD06KKF0A0WjBSw77A7fKp_pGJGVyw-OPd8-X92h=RSF+w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] refs: selectively set prefix in the seek functions
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:20=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 03f5df04d5..90de7837f8 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -353,11 +353,12 @@ void base_ref_iterator_init(struct ref_iterator *it=
er,
>  typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
>
>  /*
> - * Seek the iterator to the first reference matching the given prefix. S=
hould
> - * behave the same as if a new iterator was created with the same prefix=
.
> + * Seek the iterator to the first matching reference. If set_prefix is s=
et,

s/If set_prefix is set/If the REF_ITERATOR_SEEK_SET_PREFIX flag is set/

> + * it would behave the same as if a new iterator was created with the sa=
me
> + * prefix.

Maybe: s/with the same prefix/at the same reference/

>   */
>  typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
> -                                const char *prefix);
> +                                const char *refname, unsigned int flags)=
;
