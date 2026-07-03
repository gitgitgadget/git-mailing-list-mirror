Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5B388885
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062634; cv=pass; b=I0eivVI28WoiF/bozb+BhYX3d2yuJzKQvFIglK4eG8s49aqCRHT4EFqJMhht5h1t6dDbOEM5M+zJ3xjH+kC5CH4BD0DvdxykGrnOkTSGLcL9CLZ2kwKjXYfMlvNu5vJa3VqxuLiSJls/Cc0aH1KXbj7DtUt5J27OvavCFpe0nn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062634; c=relaxed/simple;
	bh=aogCxskktMdZDwl4HYu7y9oCIXPQtQeGpZAcjwcu7Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bm89pT+LJLcjoDyCyjREqRR5zi4sUPZ/sVwNqyLDyVb+QG/XtRzBjIEOFEi2oyVSgujK5lvw6dDdYEP+oCURTT1ZBTCBOI61iwd+7ptbSsQaQehK7yOC6jloIzw6CfjSQDaET/MIDRxCLX9lzpnkUWWcjM8sXfoB0hfpHOO/DZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGsMtTWl; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGsMtTWl"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so174163a12.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 00:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783062632; cv=none;
        d=google.com; s=arc-20260327;
        b=YBDlbvxjwpBIKwiIrIvkTTzrooQigY1rL6PANRWPIEYfuzZMmtDqHRuqlZu2gH0D1O
         QYUCwP4LKW+KmBfWY1Xdh6rOOzGHBNoc/JbGPkqxq50HfS6UVdReGLtX2fwfrvhW7lb3
         CJn/dIRtZpmAOiJ2H5lKOuNvMVaqM/6rzTDbrrsqYD9YDtb/FIfxBuP2MUlwgMKzkE2I
         1jE/htg+OrbsKDDvjzpBdFSUtuklTftuH0c9MsXOm8x07yNebt2N9NvTNSFUtdxD3yZi
         uiJiI56+ExstSga1A/LCTRRWiWnC6gnJ05tMX4KGKeD/KLMbnzR+/1tPsLQuaOApZ3Sp
         j1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/3zv2atCG1oJ2Xs00epUHAjhRX4KKv1qVoLQRFGRpo=;
        fh=NBuqo4SefB35QRIgWelYQtL2t+NSesZoSkW8edUAe4k=;
        b=CWCd6CkSZrsaU/ERXiRoi2MQyzXQztHGwn65FgktUvNiu1WJSGV15BbheJ7pGZJd3w
         bA2hfRLccdJuN8k/C+UCk/mcQlAcDHIquAn9ztm2IYBomjuZJ8ifRo/UFL0uKQV9KDcJ
         IA2TRVebRRCVjRpreSs3KEwgK58pzp43B/BfUGVM9GTpQ7qGt2pUixdjwkaFUVyiEIAK
         fvis9sIcfbPAJRFX/7RFgHe4MlWpst5EFJkgxpdLr8G3FAsY16b/VJDDP6uKreQIKm5g
         ZJJzhjwUjSC7sPi3X+EFk8axGwPABjh4Cm2yXVhqbG/tDE4Nx/BSQnN6/Ia5nCde0isF
         6waw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783062632; x=1783667432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/3zv2atCG1oJ2Xs00epUHAjhRX4KKv1qVoLQRFGRpo=;
        b=lGsMtTWl965hbBrVW6iCkPI0wmVfDD2i/td19opWyr7qIbnzZqOj5gfq3SxqrbvUyp
         JEyL+Xz/dsn2HfRMFJV2Nin40Ahil03jXp/v+Nyk1ui12aypkMRZXiTcSWMboSck6S1j
         zxBkHZEOiNgoPm9UJZ8Wli5AHr+u9l54mA/cb4fC8AEB2SjkNrBoSM8sgojZV3oB8xya
         hrEhZLxHjOiS55cFAjIBEzO+e4gaVf3Fnnxh+oT0WBYIv/Fdm9uyRI5xT+VM8KTZvBPY
         GqYMBL/aXl25lGtXXTdtZr12zeLd/JQn3DevODNmb4Gi9sQ4yFbQTyuETQQ7zkQ3WVgF
         pgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062632; x=1783667432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/3zv2atCG1oJ2Xs00epUHAjhRX4KKv1qVoLQRFGRpo=;
        b=q+bVAxqff2GBY4eM0WenpVmRd7skGd+bUgOV+vEVPLvzoCS4cwnzswDMublM1MrXy4
         5Rw3ZjXfbYBqAbLexn5FEP8TcwcgEcgdyfuDtcNmbAez4kyh2yz/268vZmXMkCYZu16E
         7sGsx644zzXGlHN2LLC+dyk6FLsFZPDeT9XK5wN8YHvGKb9IZTgQCGZDA/gdciC7KajE
         c+L+L9GyOeS1wNmGdj+XjvbuPN3ZwNOBuQsQzfswLky989q/zO0xJaoXbsRsLMS8oLS1
         FhImofD1doWxvuAxiQsHzcpNeFQOEWGKkNYijd8NxdSeXFrRtjV5AV7b8sLvOJUf82gp
         z9Pg==
X-Gm-Message-State: AOJu0YxdJHn2qObA0k1xy5QhHSNQdBpwoJK3Lmpy8T+OTV1QgHlQ9IKc
	GT/Psu5sdSngiSEjoH6yT22BIrXHCE6RdjjQh0CQiwiOiHX+eb3KqixcEgtphienZhooGHbhI8s
	YBIY6yh8jbDmXKiKRa1hbNedf9QgVUVM=
X-Gm-Gg: AfdE7cmXh8RzNEvK7lJMCsx5tFPVT0H0orxmC4IDZCuQnYXf95vyzkjdayiv1kjEuIx
	GH1/+iGIN9Kf5kCTOZFvf4l/a6BnHfbHZ2zCZ894AC2PM1Nly5yVQxfDnoGChF/tZU2sqQNL1Uw
	10C6dXyS0zaU1cqgKcb8b/Y0F0lBY+EFKaPE+ws8TlFdmWetSTiWKtuxFYNLvl8JpRicsbkjXIc
	MOC2LB4VCL21pnBl0C7Nvn5StyzuhF2PMWe3kBhpS++DypuzvVcRUaq9MVQdKEGO5DhS0K3Sr8y
	PWewG+CTKQkTRi1+ijioV7fK4aSKcNihljsFCwcIFR4kcncqXpRKIBLW6g==
X-Received: by 2002:a05:6a21:7014:b0:3bf:7f0b:2f70 with SMTP id
 adf61e73a8af0-3bfed47a56amr11161689637.34.1783062631990; Fri, 03 Jul 2026
 00:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im> <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Jul 2026 09:10:19 +0200
X-Gm-Features: AVVi8CdNLrQko7d-0VJitU-VszjFjSI0Esk6jfrU5HlyiVpFfXvrpH83z_uymv0
Message-ID: <CAP8UFD3OAktVQsLuqBNFH2uhEO31PH8ZF3ZT1ZW8k++XE8YLPw@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] builtin/history: introduce "drop" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:35=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> this small patch series introduces the new "drop" subcommand for
> git-history(1). As a reader might guess, the command does exactly that:
> given a commit, it will drop that commit from the commit history and
> replay descendant branches on top of it.
>
> Changes in v8:
>   - Pass `RESOLVE_REF_READING` to make `refs_resolve_ref_unsafe()`
>     return a NULL pointer when it cannot resolve the reference.
>   - Drop unneeded code that sets `head_target =3D "HEAD"` on detached
>     HEAD.
>   - Add a test case that verifies that we can drop commits with
>     "--update-refs=3Dhead" and a detached HEAD.
>   - Link to v7: https://patch.msgid.link/20260629-b4-pks-history-drop-v7-=
0-6e9392a957d8@pks.im

Except for the style nit in patch 6 (spurious space character), this
series looks good to me.

Thanks.
