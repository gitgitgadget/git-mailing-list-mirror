Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7F29B78B
	for <git@vger.kernel.org>; Sat, 30 May 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164144; cv=pass; b=ceunlyK0v7KnPatS0zngrPGOlqBvErbH4n7g++zZEAkV87KZZtiRgMfV9vmm258AiLzMAw2Pm+xhuD2VD4l0f+i9lv5Mi6keqMhieH15Ry/xQ8LkV4UEAoSzrKIt9NSFt60LLp3X2vX9/iP4uipZVVmvSKRItqYPo/xfkNFb4u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164144; c=relaxed/simple;
	bh=RfYNeoeLAPt9GQAqU7vV6ZAwTHg7BMKscYlKEJaLTgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1kqxbVsxB93XeCUif60OYt9YtJDtgfAkFzFbG4QF/j3/nBZAUf9IV7ipPrDosbk/XkXGzW9isQrmjjqSi7tOccZWmD27f1kvt+3x1HHQiapxGPJ5sRxTnjpfZ56jNx9b5dTizUASDKs035bgw4k+SaovvhJ1HpAo176QQLFQIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akyBgfOI; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akyBgfOI"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137c928ec7bso132242c88.1
        for <git@vger.kernel.org>; Sat, 30 May 2026 11:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780164142; cv=none;
        d=google.com; s=arc-20240605;
        b=BzmdbaSIZQle99YSzylJwC8omXPfnYbx+psbpIkW2BzhEbSiXJys6V8UapkVTKSqwQ
         hVva5VstB1Ezl7tiuiPjMUTZFVDr9608U8XbDmqoDAnRTZn5MGojF2WLqxcvFI6O5so5
         H/Q6aZ2quh5iwq15O5V0cQxiRqnJfXHbPKBatlZGAhlk9kAFrtebrnvCKMzbi7NvAuuM
         ZtXcN9PmbP6PSA7MGO3+6Zv9tSVTSR2sBVEW9JupC7EzcxTXj9p6xTkhPdiijR6j/lmF
         PDJ+npocCX8yAyfMW7sJakGU5zWPtUtL+0sG75LJuEZK/GhIKuqZA7lvlWRjdl+EaSE6
         EnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4QGiIk+i+pXwkkQOTzG0aCtCTKPTR52mqxAEnfV4EMU=;
        fh=hEoqR+K+i2TKfZzeZdxHavFML4oufOJDrrtQSUwGObw=;
        b=CfmO/XmqBqwDtl9un/LcTHy+PN/hA2P5fbzgGYxt/OjUccQyLMmvVZZbkdrBqCM8qf
         X9ZIPSb1HNzZ2OtsVhHywNrd5sIr3bMWz9kwOw+uRWc4+h1IQ4i/P01J/Tlgxe5eXBmy
         Pf7JKzSP/lEXnAgblErFTYPm3C0n5sY2Bu4jKrgTq02gaJmL1hvgeWamjinZdaMHDwW7
         UmUzMMNop6pmeOdUX9Ltu7Wqqi0Ej/kKHTIMl5GUDIOH/7JOLYgkZ+LM0zjLZNKX1FN6
         M8oxO/Ejp7wyy8yadahXzJZszlU0xscStd0t/I9csffFawUYpF0O2kGgyRiNE4SNkgZJ
         UJhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780164142; x=1780768942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGiIk+i+pXwkkQOTzG0aCtCTKPTR52mqxAEnfV4EMU=;
        b=akyBgfOItxnMUX5oIlUJdsNxOPVD2bwOKIy6aGFWydO6UodRc0gjTCGpJi0sh+P9i0
         vElS2HtbmHJgG1r7yL3ImW6LSVUmjAi90YVECQNBAAEowi7txGN4noImyJY4K7UMeQJz
         gyimhLqNmd0t1ae6yGdZTEcvv6PRP31lrRh9dbebgIUMGHouk2g6X7V+aAbIX+i57pDd
         eXygIxUmFMOJWkMSYWUwXoMZznRMPmfAFj+tCJVkTqu19LPowVMEhlf1cxOGt3/YAxLm
         r4PuJS1+Wc6uyLQm721xaDJcoqby4vubdGQqd2RwcKejVcJn9b2ozOa9CrSHTqfIQAkv
         8NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780164142; x=1780768942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4QGiIk+i+pXwkkQOTzG0aCtCTKPTR52mqxAEnfV4EMU=;
        b=F/mxgY3DAeaYhkEdNG9Ry+KbByeUd4gW1ir9DAd1hTimr2mjy3VXOB+AcrhJg29jkZ
         t0Of8DuvicpCCVD2CjWbyRY3jDfhT1I5xzjdlwQEWo1VcM/KM9F5juhwrudsu4+IX+N+
         gQW8Inr66idLBx92f6cMYxupnIWITo8PaWFpEwIWLZYhRXQM1RNz7yLZTDlScJhUpx8v
         uvgEa30Wpo+wUhrOP2BCT6P9xbunEqPZrI7/v+DCP06+4YzM4Hcj7Kc9+b6H8fvaGXrX
         Uo5ECIeIGto94siH0lsr7RUaGNnwnbM6MLkVt+3zf0a5S+VSEir3YwJ9vhqNTa8XGaGC
         zDxg==
X-Gm-Message-State: AOJu0Yz8xWs+VfJpEfkjSLhAbeYUiftrwL1QrcAWavW/1mbXiBoWYrZq
	ZfDA/ZDAuCB8OP4y5XAXK/BXLMnJtjck8TRQZ06/sSEqWYBpIS3rbljxpBv933Yl2sgyZEG4n64
	FudU4SGpTIHexeIEGsGLr2D87lf+OHdM=
X-Gm-Gg: Acq92OHr4QkdUuG1+xUYugKLld3biKavtUHA27StZwD338+oO3ponLWxSb6nqPeqLtd
	rjqme1FV+jA5N/OBW3ul0j8dlQwzJpI6o9hsKQS+1FS07FLwtkuyTaK8Qkz75w6xO5NL4vRBoE9
	l8ZUnVtGY56/vkPbcx5RFzRSqqQzhGRRsyRyUKj3C+oE8r0CtoBHWY7JeNCS5jMVHf8iZS+zMD2
	Je+1LNgdcCRS8QVZVVp5xN/N9Iu0Zub7V+CmbwCBIJZ5kS39/WPbCHKp1pViQs3FnrbFy/pPN23
	5eI61cZenWL1I+ukom+asB10BZfT7WgcokS9pBSy8DVr2U80dXls7ySr+WgGPak/12D12rqYO/s
	jiS4=
X-Received: by 2002:a05:7022:b99:b0:128:bae0:e03c with SMTP id
 a92af1059eb24-137d42883b8mr1952701c88.30.1780164142330; Sat, 30 May 2026
 11:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160520.77859-1-cat@malon.dev> <20260530160520.77859-4-cat@malon.dev>
In-Reply-To: <20260530160520.77859-4-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 30 May 2026 20:02:08 +0200
X-Gm-Features: AVHnY4IWLUcCgDMhfIPyLx1pR4KtddKO0bjvW3VIBF7PrEzFq_5dePTDW07tVXs
Message-ID: <CAP8UFD1GJ=caPh-M97KLCfB1ZKtpomzosYN0uYBOnay+G23GcA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] environment: move 'trust_executable_bit' into repo_config_values
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 6:05=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:

> @@ -720,5 +719,6 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  {
>         cfg->attributes_file =3D NULL;
>         cfg->apply_sparse_checkout =3D 0;
> +       cfg->trust_executable_bit =3D 1;

Here `trust_executable_bit` is processed after `apply_sparse_checkout` ...

>         cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  }
> diff --git a/environment.h b/environment.h
> index 123a71cdc8..72c400923d 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -90,6 +90,7 @@ struct repository;
>  struct repo_config_values {
>         /* section "core" config values */
>         char *attributes_file;
> +       int trust_executable_bit;
>         int apply_sparse_checkout;

... but here it is before `apply_sparse_checkout`.

I think it would make more sense to put `trust_executable_bit` after
`apply_sparse_checkout` here.

>         /* section "branch" config values */
