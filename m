Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AC372B45
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243640; cv=pass; b=TD5uevvh4VBzPH8KShILf4k+LTm0JlfHBHmoRJF0sDWYQv3wTMdQ7QJo1Nid0P7iB/s3DzHdJ8dampMKtAc7Z3cKzL8EZIm8//hYGKXg3+VtPic2MuH5ClMzNBRLwOU7AjHpE8y+luOC9+6Pob37ISQ0SVnSGor1hL7oBkkIxO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243640; c=relaxed/simple;
	bh=aibTTsj7BjrxOo6TSFhZ1UYdIiNVpW2+WQC2DSgHXqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV+9dP5UewZDayS10nWdLGtl28760xImUe0bETF7LLxB3OlLn3rgSBv+Exi4ad/Wj8hCmeW73q8GK7fSpKnKqIi1u/NnGmtIeZOKmZHxk/cgcJ0Keucms8QVyNcAi1Nb1gA/w46tLBKrmnL/Puc3uMh5rAmG0G5xxPfE0JaGGyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0+pLlm6; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0+pLlm6"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a7109f568so23880697b3.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 12:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775243638; cv=none;
        d=google.com; s=arc-20240605;
        b=HcxLa1r6zmto5POoFd/j6DcDFUE8dd3/Zix1uXISVweATj4n4+mkQUtQeyD68YpbWb
         bPJ2DHz9aq3fbhOCGgmZWmuDVh/mdCHLj6q4+gS5PoXaWSC2wsh0qw7pFiGB8XktgD7a
         ecRNA5q8niqzQdtIZqp5JxP7xeIIV6KJaFmdgfUrcwOVJU8e7s1a6D6RHAelSyKRvqZA
         GR8lmHGgDNILd1ihDsmApyJKyfIxRdyjEOhUUWNRWqaJQU3CSdtKB+blnM/RxLbiFNFH
         ZN/0/j9ngtwJuDLB/RuA6mlFI0p4sxRgDnOqNgXz7h9m5Ak2rercjXRLlRKZoud/paFh
         f9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7imA+d3crrBdPKTzzFs9UuEfvWRooGe4SYezp+iJak=;
        fh=AdVXUjm2PWHWG4hU5iXT+fElt/fRSXmRUYYyImMvUNI=;
        b=EQ775dUDc51JbjVA50hJHnjwY+THwMXSVV2paNbebDQhgjKjhgcz8Uq14r4BryUtl9
         oRqTzy8P/imq5tjeFx7xcooYYtopkKYNTE6DCLdmHJzEea3M2Im+hrwKNu+qUwmqqiBl
         OQcN7O2djqGcR6VwQQuQxkh2Uk7tvMwycZgFwzTQCWfBDyapZzl2mjld8+54UHzHG3gX
         kOqNPQKNnfBWvIXHcqEq8SEvAFhQSRn1UiFMX/NqMcSidnxxYUlM9pZnqlZsjb98JXf+
         0Tg2LV/H4cqDwV2O8Vku005uEKxqebsNXW9YGNAugVrsot9gcdcAveceVLgFKF/x1d07
         48UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775243638; x=1775848438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7imA+d3crrBdPKTzzFs9UuEfvWRooGe4SYezp+iJak=;
        b=q0+pLlm63I8AtsXNpH3gU2cPFMhrAO8MCyLkrG7GY6zZptGsDTFpigH191DF7FyMNH
         y7Gi6A6Y08NGR/ciJ4rGCJaDjSVs2UtQJQ2Q9KsI9L5H1g120BYgfZtr36Eo8bZlulmx
         BwRRSTbjJ+fGVkmxNQpVvx2MGdOl91oF2cuc7CGtq7k7PITG6HsQ4hOpBXgBNvSywo3A
         L/+pDVDGcH88+S+vaXKYcHZh5dngr7ffUEGSNIMOjOdUsV3AeKMrT6P66R4newZ/9Gr+
         wmmx0Gcs/q0b5fThYJ/8dEvEhcDG8vkm0Gv6aufY8kl78yo6vWnTp520SroJfpdQX/bc
         RnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775243638; x=1775848438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7imA+d3crrBdPKTzzFs9UuEfvWRooGe4SYezp+iJak=;
        b=VqMZXexHQKvbjbbxW/s5dZy83kMfQPgLWgF8kwJmMTxLJFHMoQXHxqE5aP8NGgpzQh
         2AajNtGhx8VXzf1SEpr5OHz2Eug4Q3LzH0W0tKtRWPOpy7EYrZED/N0H1qzKS+tzALaI
         kJGWYMo9kZ9TC311H0Fawr9bC3Q5VHRoWIk3qR+u0IDHD0kT1rgUtxczxgHPm120SB6M
         AaahQZI6Cz1Wjs6bEvUmcEaN3FP1iduRp5fupyASQkChxonLJ0oggU3haHsulVnTx3nm
         A7z3M69MXf2r6MHidLLlqlyTATmYjLsBI5x/xna6349wZ3DQRsAprE/mOxVpGGHvk5ru
         fmBA==
X-Forwarded-Encrypted: i=1; AJvYcCVx4pt5+kIrL2YSEPM9J3SUTRpXyU+8RYAAF0xFJg+vbM9cpUH95NTvyk6bF7/O1N5xy3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfMo8vbbP0oNMM9Joi2gb8WXIPzzlPuW/E0sva2nnjBTuj6+F
	PynIVl2viiMmJxHAKxo4H21TlgyA8ZcMWDg/XSPLtI0rLVCbhECncVJ3G3tRpsSw+uRNnfZUVvU
	dAdnK9Pjx3pxsBJ7c6QHKD53y1sLSy8FxDCQLGOuKyg==
X-Gm-Gg: AeBDieu7DCMn8pCLFoQEa1UgmStykaTiUKnE5gqOqD/m9NOENLM2zXZWY753kyyJfSs
	alH2VEbLgjnOT7XK3kHocMMyYLbSeSDYGd6apMJIr6JJqhAvT5ilFUax0alniTON7hBqNM+nB1M
	GNSbjD6DgAbQzGEIOIZl7Tda6G9cm/RVSo/IJ6uRfLjhP3rK33BOWtaQisq3ukoT4sGDggaXytR
	6/Hp7SydDlPO/pXQP44sE8Voq1zQ/qRu8Om4ptLozSkwya/AZi1emq2YeUyQmciu+6Blk/CJaKq
	OZhdY2JffSX1NNHrSM7jX9bx7wGcZQs5YHOSo4El1UILIcxb3Ur2UzS0eWICPzgUoiGkGysUwvG
	yIuFtEQSxgDA7vBYTP0eQ6g==
X-Received: by 2002:a05:690c:6e85:b0:7a2:f14d:5a1 with SMTP id
 00721157ae682-7a4d5f563d7mr41567987b3.49.1775243637945; Fri, 03 Apr 2026
 12:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com> <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
 <CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
 <xmqqikaawrpx.fsf@gitster.g> <dc134cdb-cdc3-4c54-a97e-993a26900d0d@gmail.com>
In-Reply-To: <dc134cdb-cdc3-4c54-a97e-993a26900d0d@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 3 Apr 2026 21:13:45 +0200
X-Gm-Features: AQROBzDCFdlAym3BqqzAgCXi-c_bFYHbHcbxdSiLNP31wRjmFnUe3R2cjBUt050
Message-ID: <CAN5EUNQbdoymmJcqzqzUy2aEKg-qUBqe_7bSmWwboJ4PoCfFJQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, christian.couder@gmail.com, 
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com, 
	szeder.dev@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 3 abr 2026 a las 20:56, Tian Yuchen (<a3205153416@gmail.com>) escri=
bi=C3=B3:
>
>
> I have some reservations about this idea, although I know little about
> the graph engine. ;)
>
> In terms of user conventions, in --graph, '/' and '\' represent
> branching and merging respectively. Here, however, the '/' used to break
> up between different root commits is merely a placeholder and has no
> specific meaning. I feel that this not only goes against user intuition
> but also creates visual confusion: (I just drew this off the cuff, but I
> reckon it should look something like this?)
>
> > * (main) commit 4
> > | * (feature) commit 4
> > | | * (doc1) commit
> > | | * (doc1) root
> > | |   * (main) commit 3
> > | |  /|
> > | * | (feature) commit 3
> > | |/
> > | * (doc2) root
> > |   * (main) commit 2
> > |  /
> > * (feature) commit 2
> > | * (main) commit 1
>
> I don=E2=80=99t know about you, but I find this rather difficult to grasp=
. At
> the very least, I can=E2=80=99t tell at a glance where the actual merges =
and
> branches are. I don=E2=80=99t think a good solution should involve shifti=
ng left
> or right. Perhaps it would be better to use a special symbol in the root
> commit (such as the =E2=96=A0 symbol, which resembles a full stop? People=
 would
> instinctively recognise it as a terminator):
>
> |* (main) commit 2
> | * (feature) commit 2
> | =E2=96=A0 (doc1) ROOT COMMIT
> * | (main) commit 1
>
> (I wonder if there might be any character compatibility issues. Anyway,
> I like square characters. Square things are all rather cute.)
>
> Regards, Yuchen

Hi Yuchen,
even tho we have diverged a little, this thread is for a new option to
limit the graph horizontally, see the cover letter.
It's currently being held, waiting for a RFC about column
rearrangements. But I'm attempting the root commits issue before.

But what Junio mentioned is actually interesting and it's being
discussed currently in a new thread, to avoid having two different
topics here.
at :
  https://lore.kernel.org/git/20260402211717.3604688-1-pabloosabaterr@gmail=
.com/

This seems to have been attempted multiple times and the idea to have
a new symbol was thought of already.
at:
  https://lore.kernel.org/git/191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us/
from the same thread, but remarkable (part of the review from junio in
the new thread):
  https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

I already have some feedback and I'll send a v2 later today or maybe
tomorrow, BUT testing and thoughts about it are very welcome, so feel
free.
Pablo.
