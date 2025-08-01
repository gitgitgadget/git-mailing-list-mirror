Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7C4A04
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076007; cv=none; b=e6NUn/FTTNA5AaqoaT7yJRvLun/eOtxX1IYZTPfISwh+MdaZ/jq3NHl98F5O4l8ZRp2queY3BDN/FErbGxDgusvTLkrUsnoo2QsEbukfZLqEB2QcZuV0TQNTG8qRFD/u8dEfAg5A7qdTnB70gyi2rn3zMkcUEjGeReqbIlLboyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076007; c=relaxed/simple;
	bh=IPDvA99wgvkhAkrSVGQH0Uk4VPyzt5UTQl08gFkypgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvv6OUTzAE40XORmyFHGhOaGg+825FTcezSLajtbC6/CJBK44jzgbJ1qScDrrZm3j09JHPkkwCESRRhxasS9AUOxKQfo0HCEfUPrztDnMGHicYY8WiUd++Bd0l05efi+kgP5jwwQ5MnaIn8c9OWNJZEKXT6LddV1fTuQQDH70os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70744042873so2376956d6.3
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 12:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076004; x=1754680804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPDvA99wgvkhAkrSVGQH0Uk4VPyzt5UTQl08gFkypgs=;
        b=EKZUdNtkRlJZEU7Qeqop6yQruLaMWrWu0KCnwTzii0BphJ3fWmhi0Oc7fDTVsGmKb1
         CVi7lckp3ttXgZSxsjvJ5toaQr7SeZQFKV50An/zw2t14Qz8ca/Q3TkLnEFag9chOmd1
         5vd45rFDx6bX1fJ+iqo7VLHtNQDH4Yms/6daLwuQo9bi0svqDNgKIbN36a1/CwUBJvhl
         m6rG1zyQgbjyUCZhbXV+qfJ0HFDxPrbh3B5ymaB6PmP7bHPWn1a+SNyM5BM/td30eQUN
         6covYHcKT3AFiF6Xgu2JRDRGVQTMDV5LHpeVxkd+3rLMPKXfxUU3lCJYOvi8XNKGewSL
         esAw==
X-Gm-Message-State: AOJu0YwIYWj2bfdPb/DO+s6myvIgBJmnr+GKnLavbua3h8iDjjka12oI
	A5XR+uLQ0qvUhEBg4v8Ok1UfQz7z7R+eU/R0HfnwE1D0hxDj/JFxJmIXmDXWbqTEsBO7cMl28mN
	iIuEQc7PXkOwNsjELEbkGBV+U9KKIoE2G/ixR
X-Gm-Gg: ASbGnctdApOZFnNxw3gkTwcNcBROmef0CygrAIgGd4ThsbMHApFmnKPkgGd2pGiNEdh
	XzpXcPbTRovutDxmGWEUiBQ86Zea0v+6r4dTF4VS7Vc4vZ7yxkW4U796HFSos0xG6Hryckryn6n
	q1ZoRVeMsZnlayYwRaye+D3+aAJu5URL4SyjgjiyZYgEceQGuc7rEQnJEd0Dt54cCBDt2ZnHHW8
	4rsJyoc9AedMaOdveN0S5PXM5NMu0qEZQxLrWXw
X-Google-Smtp-Source: AGHT+IF54yJu7VhtiyWg2iDmqIE8pZibYSkHU3BuQ2fugfR/bVOsIdM1bc+0zNFwzemXQ0odetk6c3toyOcsQKizoP0=
X-Received: by 2002:a05:6214:262d:b0:707:43a1:5b10 with SMTP id
 6a1803df08f44-70935cdf765mr6704116d6.0.1754076004276; Fri, 01 Aug 2025
 12:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im> <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 1 Aug 2025 15:19:52 -0400
X-Gm-Features: Ac12FXwfqzNJWTSrLETCpukeiuKY6zTw-EhjjcgjqQ1uFzXtsCQXAVOfovvhQvw
Message-ID: <CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing braces
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 10:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> While perfectly legal, older compiler toolchains complain when
> zero-initializing structs that contain nested structs with `{0}`:
> [...]
> Silence this warning by using `{{0}}` instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/reftable/stack.c b/reftable/stack.c
> -#define REFTABLE_ADDITION_INIT {0}
> +#define REFTABLE_ADDITION_INIT {{0}}

For what it's worth, the last time this sort of issue came up[*], I
believe the ultimate response was that the project ought not pander to
this particular instance of buggy compiler and that, instead, an
individual developer should, if bothered by the warning, use the
appropriate compiler option to suppress the warning. Whether or not
that attitude should apply also to the reftable code which is meant to
be shareable, is a separate question, but at least that previous
discussion thread provides some background regarding how different
developers feel or felt about the issue.

[*]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco=
.com/T/
