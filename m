Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC42ECEB9
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204770; cv=pass; b=TANvcPZ+bHrewLRhiI9tskSC53LmMT76weSgrSA8/q8WKHlOhuqLPjPjuFNrmpNu+TtqmaTIC4C+aZT/8a3I8fUkVCxTvdmHNHuKX3TFi3sfkHjkkSsaqKTpWv3os++KDkkw/1kWzve/+CrW4dKDteMLZuzsReLmY1dUBOXGfHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204770; c=relaxed/simple;
	bh=t7eCLU90+wGSZQ7oaRVkQx7s1yBN82ditfQuyO87tGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+MLtD2WoQ/CcuReAmtotoKa7Uk3jsmPK2N7kBTl9MbSbfbtd5Q6+4glIKXs5q43xg0RkcAuPj0q5gQajL9Xb8G0y4EfP8gaL56WZ+o/O/rAkBpOlFdb772tQtiVE/QrF3m6D8eWfSgErqPLmdGjxip/MyzbWznON/AjVfxzgZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA4V60tQ; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA4V60tQ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ab5fd969aso17948407b3.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 01:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775204769; cv=none;
        d=google.com; s=arc-20240605;
        b=OrqdFa3TM5gnf1SnIxixqekdbHt4ONSTtO2Sr9wSoI8sL0+NyvQVHvshploVgZrbLJ
         XI9TlyGKoDTdoNtit0GtgIAUDToa1kIYc3DR2eu1imfiksD9SSpNwyxQxn/9Dr0GbgHC
         bky5GydDzIZcYweDuXEncQdNW84flTwEOgF3Rte4FcrnJX0txuMxy/mLULbCJfZTsu5B
         3AJpQ+LXxHsBxCK9FHajYCQGd/tSfiN3BH9POXlV0V8fzuxY9AiheZ9nJnlQOXzbIGv7
         yyCiJRdajzcPyK1PuQmVZeADfPln3FkB17ghZC8lfq5+YsEJ3k/xZNezRZGk5jpr9qEj
         z3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qhVJOM+cN9/VoRg8T9suoYYdUPZ2IW71DlZJdRiCKk4=;
        fh=hdYj/kDeiNxc0CV9ANV1htcOog43EMyhQ9sUUeD7EVE=;
        b=JsamAjtwJ4pLiVlKcLDrRXYtpeK4r+vlHc1aFzYVCLKtAtHEd98s+98O3h2ZXJ3MQr
         PcoO7OtlIniw+mf8AFp1rxr8f/GPqjRcUITlJBm1rjA5QxJ/iyMNIBA3foMbwh9uGPpD
         4vzlhv3A4yrMgwlHohmE1CZsVmqdzd8YV/1ydM4ET04ND/edrWN46aDZuHVV8o+zvrO/
         EgL7QSZU2PZUqxmZiE6Raze43sQzyciR/UJeSlgCNuBF7fjSHvZbg46dTO9YKiqFdPIA
         j+Ipw75OAAXkiD8xGKBL3Yb8GEF7j2vxuJHhrRL71Oz2A0w7oW7JZSV34XJv+fDZoGfy
         HSMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775204769; x=1775809569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhVJOM+cN9/VoRg8T9suoYYdUPZ2IW71DlZJdRiCKk4=;
        b=gA4V60tQWd6U8uOrDVipgrZIV3hTGEE4tKQzhrS43qYxhN6n7b9hb21G2d0fBHslXw
         MDFUu9Jt1vTzKS2Oaz4V2nZ0fbYeKGfEroR7uUBlX3x0eZBjmPcsTqnaDQMulc4dwlr1
         wFrikXpa/mkmCY22TAXG0cC3OhEgRgdmwCj3NXXA1z+43fyr2KoVUEEp70pJmc63wCW/
         oD0I9nQu2F9yl2zWE4/oLO6X2YcfyHz6vn7wTZ3SmUMauOkuyDp6CL0nWJyGZxKr0gSK
         ZhO7wnrQuTewVMVAAkCB4RndXAhd57v3sy7JMQzTJYW57+MVJZjcEHkTTY7JdF3nv88i
         TAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775204769; x=1775809569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhVJOM+cN9/VoRg8T9suoYYdUPZ2IW71DlZJdRiCKk4=;
        b=FLYPI1gwfOSuTVob9JBmvTGVakorp64QuRHPrjCsVbE5WZBF0hKPaA7now1hPqpFkV
         sxER1+fBEp1QcrIygqQ3JCFEoAQNonPV5D6a/KyuZHRtdMrcmG5wNdcHlKJ34LwjgSko
         Dwk1lCWxedjgmSMFN1U6hyD97ywqvMUZDNXGi2ff3800PnV+xdYK6dPCWvoAbd5154qB
         BrZpK/JKQUms43fuNtBXkWoaFBFfwDa+Bm8hkA3lDm9bGW0UEmuUWZ6CKozmg2UdGHnI
         DSa6VBcQDRmv31pjbJPeGnpoCG0EWDJ6sg4TcBJvA5pLquUNEYa12uJuhX0Mxdvsi8Ji
         iG8w==
X-Gm-Message-State: AOJu0YwodzeZEUWqd7l3U7hlJs7F1jMIBLwJuGptebpN7nlrYa9JvajT
	j+0q76hPHwV0Nz7mEr+FmD31RwBT85148jJb2wGvA2I8ZQowIH2q9C8mERPI9nv6zagPnFPGYt5
	onbBihOPXtW9N/WY/nrwlMca0RHMq8hQ=
X-Gm-Gg: AeBDieu4/XvT7iic3gQvxkDiOgFo5+XtcPx/PZuk9ETvssS1ZAW7wwsd0jxCeXktwB8
	Ra+Oc8kFaXPG79VbYQHbSdRSSknIrSHhuIR0HY/KpWmcpFGkIgNjrNHfsbzeeMB8NS+qCEQ6llf
	UfdJunCn23Q3wh3CJ9h5rw8pEMsUYAKDZmWSkvne7VzlnM/MqFunXBbKLzIbvojU2m5i2fpEiUA
	nteFIs2dANVu4bW8xMAOzbiKqLSzLXSj7e16p81sqTBRm0fftk9ztnADy9M+UGkHzyx+rNG63lr
	OE+qTIb9v8KRLvlBlz8eMUZI3ENsxKdmqKcsjG/WjOjwv8c5/NxTpfIEWhXe+xwR6VE4XSoZM/+
	jazX73aUvurX6eZhHXPOifg==
X-Received: by 2002:a05:690c:6e85:b0:7a2:f14d:5a1 with SMTP id
 00721157ae682-7a4d5f563d7mr22698547b3.49.1775204768509; Fri, 03 Apr 2026
 01:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com> <xmqqpl4gocrj.fsf@gitster.g>
In-Reply-To: <xmqqpl4gocrj.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 3 Apr 2026 10:25:57 +0200
X-Gm-Features: AQROBzCLtMtc__nujbnxDfmTL5HgWCxzdVh_ip0-QqrY4Y9vsvTfYqxoZIfVryg
Message-ID: <CAN5EUNQZLHDSyLB=Z6RarfD1re3d=+tsUHCrL6QrjjU7eObRSQ@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 3 abr 2026 a las 7:04, Junio C Hamano (<gitster@pobox.com>) escribi=
=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > This issue was reported by Junio at:
> >   https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/
>
> You are giving me too much credit.  I just knew about previous
> attempts and the gotchas.

Should I mention that thread instead ?

>
> One thing that we may want to make sure your solution gets right is
> the issue depicated in two graphs in the footnote of this message:
>
>   https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
>
>     Stepping back a bit, I think concentrating too much on "is it
>     root?" is a wrong way to think about the problem.  Suppose you
>     have two histories, e.g. (time flows from left to right; A and X
>     are roots)
>
>             A---B
>                  \
>           X---Y---Z
>
>     and doing "git log --graph --oneline Z" would show A, B, X, Y
>     and Z.
>
>     But in a slightly modified graph:
>
>           C
>          /
>         O---A---B
>                  \
>           X---Y---Z
>
>     if you do "git log --graph --oneline C..Z", you should see the
>     same commits listed as above (A, B, X, Y and Z), and most likely
>     in the same order.

I can't find the issue with the graph above, it would be shown:

            A---B
                 \
          X---Y---Z

but we shouldn't want indentation here tho

  *   Z
  |\
  | * B
  | * A
  * Y
  * X

B is the parent of A and there is no commit on a third branch that
could try to get below A.

But I do find the issue with focusing on: is a root ? for example with
this graph:

  O---A

  X---Y

If we O..A Y, it shows A, Y, X but because I only look for roots it
ends up looking like:

  * A <- not a root but O is excluded
  * Y <- no indentation
  * X

Then it's more something like 'seems_root' rather than 'is_root', and
it should look like

  * A
    * Y
   /
  * X

This would make on your last graph to have indentation at the right of
Y, below A, even if not needed, it would protect A's spot the row
below, which I think is desirable and what you meant with the
examples.

>
> The way we draw A and make sure one raw below A in the same lane is
> vacant (to avoid something that is not an ancestor of A steals that
> spot) is applicable to both graphs.  The reason why we try to keep
> one row below A vacant is not because it is a root, but because in
> the graph being drawn, none of A's parent will appear.  Obviously if
> A is root, none of A's parent will appear in the graph, but in the
> latter topology where we are drawing C..Z, none of A's parent will
> appear not because A is root, but because all the parents of A is
> excluded.
>

Thanks for the feedback
Pablo
