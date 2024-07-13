Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE333C0
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837987; cv=none; b=S0AIFwQ7Q/XBy8GDyzqjHEIWmh8ryEysgf3WKl2S3gFDrztqZ47U6dZCguGji6lT+4d25vYhz0g1Qb1owPQkwqlJX4Ji+e0toSbLR9KqTF/NsfYIYb8TjZdzl6QxJxoCs/30450MoCm7+jYC+Jyh2/VUwZZ+mWGsOexvF7LfDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837987; c=relaxed/simple;
	bh=RHNFpb0y2ifZv8Y6BlS0mo5zbrKXkZIUHCpl3xSHOfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU16X/f+2xq+4EqWwl4XkZUpzIk0VtdeVijDy2sQmaHa+x7Rkx3gyaROvSORhlNtHtmrctdguMG5lJVB9uqK43mUsvuW8W8J51Gk2wK7A+WSfRq3NHZ5H1G0LjwBvtn7zpCGHQLisa9bEz6UiwNj6PH6bgBUkDQd6JPhYU+aubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOztXw/t; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOztXw/t"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso2504911276.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720837985; x=1721442785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll0L9BTm9aDWMMf5ErVz944x0xvfVLs/MHB473SbFl8=;
        b=GOztXw/tulXn7QdNHdeLtFEkNvTIzqz0LZc8HPbe1VMjVqebJzaagauHE9AV2gpdsI
         7IFRyAbEuyWmrmbkDt8PozgA6uUgzy2JJmsVcOwCWEoIu7mv41pgUFcihhFrQR09pTyt
         2Bb2Wy9f67C18ZnZPXiFtYVFGjViVDUDP9w/rUndoiGxA+H6yP7GgNlmWozO8/4PCcGV
         kWFAFk+r/V+ekBUEpJC9tTFP3C7YjW9lnrdXTVlChxllFjFdVQ2q/ni3qdTkATP1dqhr
         scd9LkGT2imyyIQmKrsXRaj2KBFvpS3/YC2/EhAE/r4AVvRBahEk+nJ2L4UUrQAqWh/T
         +o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720837985; x=1721442785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ll0L9BTm9aDWMMf5ErVz944x0xvfVLs/MHB473SbFl8=;
        b=pltPdIW1yPIQ7aZjKjdNPFr7g0rDbRrS2dvkkRFGoJhQOIEsYgY8wsLwMdOP1Vh7Nw
         HXyyv44IlVybDnmwxKoom2wg8tQxs0NjbCmV4U4kt/x9AOBlMGfD0mU1Qr3AMfAYjnbX
         3kJ495Bw/TlD2qIzkKig876Rum1IFUGx31UGBuMpw5FbrNazMvedPOxKXEEmUeAybpvU
         W47kcyyEml/ATzZIe9OGaVzkaphIpq2lDfVBaEBsXCl3zSyWmj9fs1OIdWcSAXcTD19Z
         htXdmEEkwSzgcNRXT0NnlRp3It4PTTvE3E6XamgP3GDuLytD1j1lzEpkR+CjMOG53Ap3
         3C+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZKl1QNzanNtcc3rBvtqmTiwKdoEPkQGzitNHDk6iB1HnfJ30635HlBNjrgsvcxf++lU73FM5JiKMgkU+c+YJp0Vo
X-Gm-Message-State: AOJu0YzK188+EoYx9OSByDjMjYniJ4du8hwdSlFWYD7Yh3pfV66/WmMv
	8hzGGWHy9uxLBm11SV8s/lZeeynmQuegCaOK1RSpLH4juHWW3GwI6QeBF38tZiAnirke6frgMhV
	l284o3kDX1lxLDm5GbF63ZyK0xHE=
X-Google-Smtp-Source: AGHT+IFcDslR3AFiK5p3xWERdMqi8mxKATTOUl8koqv/1lqBOQwblVvbLxVe6tM5LlLZdJ59jcBJoliepjPJOku7IwI=
X-Received: by 2002:a05:690c:881:b0:652:453a:bb1e with SMTP id
 00721157ae682-658f02f4a50mr178899957b3.41.1720837985270; Fri, 12 Jul 2024
 19:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-5-eric.peijian@gmail.com> <87ikxfqbm9.fsf@iotcl.com> <xmqqttgyfrnb.fsf@gitster.g>
In-Reply-To: <xmqqttgyfrnb.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 12 Jul 2024 22:32:54 -0400
Message-ID: <CAN2LT1AXfY6efX7kzR4A6kUefZx-KtmL3oDQ3OUine7jbc5haA@mail.gmail.com>
Subject: Re: [PATCH 4/6] transport: add client support for object-info
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Toon claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Toon claes <toon@iotcl.com> writes:
>
> >> +                    temp_ref->old_oid =3D *(transport->smart_options-=
>object_info_oids->oid + i);
> >
> > Any reason why you're not using the subscript operator (square brackets=
)
> > like this:
> >
> > +                     temp_ref->old_oid =3D transport->smart_options->o=
bject_info_oids->oid[i];
>
> Much nicer, but fold such overly long lines, please,
>
>                         temp_ref->old_oid =3D transport->smart_options->
>                                 object_info_oids->oid[i];
>
> to make them readable.
>
>

Thank you, sir. I will follow the folding format in V2.

>
> > ...
> > To be honest, I'm not sure it works, because fetch_object_info() always
> > seem to return a non-zero value. I'm not sure this is due to missing
> > code coverage, or a bug. I guess it's worth looking into.
