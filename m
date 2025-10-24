Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A51C860C
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271621; cv=none; b=OQRvZbec7OVJueyueQiPpCTVkBWq5ybHeBJbsUuFfFO4XQqhpduELxHnivr82zWrW73OvSLtahSWMmWz9I+plh/w2zanH44pKKQB9kytusVIy5M23J5OPjoMnYXHQVT6xRg9Wz6JWJN5a03YuFDrFa1R80lRIJBd1eTo/ladkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271621; c=relaxed/simple;
	bh=ARK/tI2eBFPMLpiQhis637RZMURqavnSmye9lxd9z5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6TdpdgteoOeoTx8B07ixbUUypviilltsHE1VwmKl91w2qUuwFPMS81uWPoobKeM1hl+XawVWNcQG+0mFX8JQAk9h3hsWWhB5VicDlMDIdJBgmB0x8GqVdCaiA5GSp9hDPKR8Wo3FHdNPRvGfpz0ApEvEWtfl6Bh8wbx4nBryE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkbKvOmH; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkbKvOmH"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430bf3b7608so15511845ab.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271619; x=1761876419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARK/tI2eBFPMLpiQhis637RZMURqavnSmye9lxd9z5g=;
        b=ZkbKvOmHgVnQ8vo/ZQFs8J9BaAP59vtoPaGgC28yVVzNG/NIstREYWdphHbGcWM/9R
         tcvemL4lsRH8KL9AZljyGghdhXEwYyVLsCsW9sRQNM5xP/TpgJOlwhwwLyIKY8A9G8tq
         I1H4nHdmmsBD5Jhzw2dtdN0wPLeH3D9s2++5OxLPRLWewLkQh1SiMmZ/YUWFGCceqfJK
         zoDFKS23HfsCjR+4SXmJNWRH1hl37tdLakyTVimEObk8LjmOFGkG8RCOUnx/lH+UKIrt
         L5bqmPQyMJf8HheZLppudDU+zhmUMXCGCHipVLpqsNOwjCUAURcqhO9tUizdYiVSWNjC
         NU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271619; x=1761876419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARK/tI2eBFPMLpiQhis637RZMURqavnSmye9lxd9z5g=;
        b=CNaR1VJFhtRPT+UVRjIxgCkk1gv590JV2CgkwmglclFIDuyXr+FrG8eJUKLhAicbkg
         SDX99QE7l0CyBy/U6GdGJiBGiYjai9GXYiUdme3pgBJXKQ+bYhiDIpR1gOChP9qIGlr0
         0rCKDA3es2znG/xmzbrG3+FVERhi/qfIMtkUvubIfX5m/f7S1bU+CInf0qm0ljlojOdq
         te2Esf9GDNXoJN5ZvclMF9F+wIveMOpGnHEKBTwtEZM6R/lVPUiku0RoKzen2+IBVHYb
         L09RN1sf4eow93tINe9uW/96xi7h/mUpO4LTwKVUq+ksqEC0HwpRpuu3p3WyB5+z2yv9
         lDIA==
X-Gm-Message-State: AOJu0YzZunx5wGrQmX6xQ6u6C4Ncm0dKNMyEalTwXGYO/uycR31dmkeV
	or6/9FXTAgUzFhhI7+ol9FOnBy84fP0vpE27akDn+b3D9yixFL/OFust/eu/+PzA5XjTrlQSIzJ
	iSpeLtVXXCFvKAoHWfjMs8qNWI90gyhM=
X-Gm-Gg: ASbGncuotEQ4fuPdzquRh9tU7jkoZoE4GiCoFjn5khwwFozmQoIcRvJsGPjuOyOLltA
	vvIM0s9aV//gf4/km70WwQVn4AF97QSFlO1RbFWsuR5SujI6/hLi9VN+ipQ725++RpXvNLr8Bet
	MOpdTVWrukHxbagp4ac7b6S5TMTit05vhgR7m5IYjxqKZ50dv0gC80D3aPEzUqCm2Ndssb8m/LN
	vDsXaBQnPvFJXtZwWSMiaKh6kqlTAknn6vHIalIlD436JJeDPFERU6EVP0t
X-Google-Smtp-Source: AGHT+IFV5H7YZ4/CjSsG2hojpd0X1nan54xE53ygfR7xwyzoDtpKKM6Pipd0V3xLQ4afSvqqMYHYZ2ZUn6fv30Cwygg=
X-Received: by 2002:a05:6e02:148d:b0:430:b167:3604 with SMTP id
 e9e14a558f8ab-430c5209bafmr393572865ab.4.1761271619624; Thu, 23 Oct 2025
 19:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com> <CAP8UFD0Jdb2Q5dpspUOnKBJuupikJ21mJmzRyYsNOhem-JP-9g@mail.gmail.com>
In-Reply-To: <CAP8UFD0Jdb2Q5dpspUOnKBJuupikJ21mJmzRyYsNOhem-JP-9g@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Oct 2025 22:06:48 -0400
X-Gm-Features: AS18NWA6Q5tUjWcvICs1MajdZpWjPRxKmheZbJzRIj8bI88_oeUZlt_Qwm10wN4
Message-ID: <CABPp-BFgKSLQazjEwCn7rFd2BiQBGri2uNxxK7EPuEOWEAf1JQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] fast-import: start controlling how tag signatures
 are handled
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:10=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 10:49=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
>
> >
> > Changes since v2
> > ----------------
> >
> > Thanks to Patrick Steinhardt, Todd Zullinger and Collin Funk who
> > reviewed or commented on the v1 and v2.
> >
> > There is a single change in the first patch (doc: git-tag: stop
> > focusing on GPG signed tags) where the description of the
> > `-v | --verify` option of `git tag` has been improved.
>
> Sorry, this should have been sent in reply to the v2
> (https://lore.kernel.org/git/20251009122457.1273701-1-christian.couder@gm=
ail.com/)
> instead of the v1.

Sorry for the delay in reviewing; the series looks really good, with
one minor exception: I'm worried about the default chosen in patch 5
(and also the default chosen for --signed-commits in the recently
merged eaaddf579124 (fast-import: add '--signed-commits=3D<mode>'
option, 2025-09-17)), as I commented on there.
