Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C578F2B
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783219805; cv=pass; b=RfyFaSSlAnUi9EsJ62MziApZ34AHP0+wKSW7PEzo4FkrO9+tG5K8m/XDnxP6elx+f6qtiffSFm3KKCe9HjDxdCsGdzfZldUIWQwNXZxMmFpCJbVZz0PMUgpGDxvLUVKGy3bsKX/sNu1R7KXyNIAMbzVRcDIlY3+BEc6Ua/pen1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783219805; c=relaxed/simple;
	bh=z03xDMCORw9KIUNoc6lybeMK/yIoJfPlU0tdDGCT6MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJVY/AqwbhAKi0rN8i+1IMjJCGfSX+v241lvXKgWiUjIjWR+N/zhhzDf+AgDNeaCxq7YYnWiMCI5guhFQXXkU9mT0j544c6bxaV10c9XJ0EFEysif0/s7uzjYQPRu8rX//cPO1dJs/Wg+5UMftN+XmI+LgWYckUthcT39zgkLic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4/2Qy3C; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4/2Qy3C"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a1888969ddso1021035eaf.3
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 19:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783219803; cv=none;
        d=google.com; s=arc-20260327;
        b=E/TgmypiJfRstw+e/ysW0XVhJbVUMUDTcdQ1WiUELs7V3ML5F+cMMEIVwf5NxavwTP
         7AreTcOd28hCBdAC0dhQ6mnDj2i4J8o36N3H+QT9N8ZYsdZK68Vfc1mTNW95l1BfGoMo
         FoAxMT56OvVtwIbQnoc7L4fPReaSqE2yD0fqBT2irg0dz6JD0zFmULai+IdCEbv6lPE2
         4V82dfwl+PE7jjvjr32NAWAK3HDCIMnN3QlRNIejQAdlL1e1RD5Ap2yOcTPx7ei5uhbo
         GmhpUEmfqM2eambw2P7vWypvcRLTWNdJeCXjC1NlyZNyjaiy9WgaXBEIzPTA74d4M2+0
         Fn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmphjNVkurm8+K3z1OQRfdrmtwZW+Or6jU1YUsUr+EQ=;
        fh=RyQx3rVuCs3XEtVz75cvj2zqc0vato+juZGzqjZl7EE=;
        b=SHLo/4UsBpvyle42ieYpusZo3cWyU5YJ2sFvJkiEKWIlF3iTaVTlrXBLgHWkBaCENv
         Mu4cUyTasYTqnn03y1bxD6G7+9eia1mHajP+JHIcsRUvvjNBgmwCcyVx+aZ+FiCDsbii
         AqduxIPp/SK/SP5kpYOGQjDPAqvzhS2N41GJYX3oNsuZnc2ajqqJVKYqmCOTScSCh2Wq
         BofcZVRGDrIajZBGjBWoJ25G5KIeCHfts69sIYK97zcfmGIxKevZE/a3xZmbkezsHRtV
         7vcf3kn2WNzMtknmmVKA8mNzDWYElN89HO2KjzNxIptADOZlspNQNxKeg2eqh+28qOI6
         SIWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783219803; x=1783824603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmphjNVkurm8+K3z1OQRfdrmtwZW+Or6jU1YUsUr+EQ=;
        b=o4/2Qy3C3zkfBIVL9cCzSAM4QVhSWMygigSdRGrg63aonArev4y3Cu1hGcvjx8tJM6
         rVYsE/VtPY5rcchFIWcHnENUdXTMxb2diuPogQ4P6SMC+/QC5Mcfqvgd4CQ9WIpj7+Lh
         FFhuCccb3a6QFPvtGNax+SoeGZObOMYInNSnLsxe90poF4ire1Eia252G9yb8oWQoaI1
         lbAhTqWgVAJWbHggUT1wgNAXuX2mrcAZTtGPywZCZQ08E8z3Eeu4+h+wOYU21Aum3PQD
         5vHvN9nEAjzf5Nbd5xSKft5XgFK5E2VoIFHakyCmP5xA3waR/VCZ9UiV8UtfZUwSb+/9
         1yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783219803; x=1783824603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmphjNVkurm8+K3z1OQRfdrmtwZW+Or6jU1YUsUr+EQ=;
        b=AeUufR/gE1gPwy+U26Ei4wCSIepGhPNIolFpTzBm+VtgK/ioVA/Hs7vgcU2ewyY4w4
         q2rA4kP73zh7zBvv87QxSrbpaV9TjZpW9eXVwxCmtpEpKzst0YSRNl7rdw9fzbCoiW1W
         zXkfDKv7jKpDYpvrHE9YN7qLAJ08L32X2WAiW3gAMi6iLiMf3ZucGpnuUfcvPQPClQZv
         LzmgxHPIYiAIBTFFq4rVdtPLoVNXf1n4JJvlkBcoPpSmIU09w8kfqauixOQGPbrJT9fo
         Eqp8ySxVxNilGYwpLBMAfTSpi66Aoe1gOq3Dvpz7z05avCWaMf3GWHg/oJoLxRP8aDHm
         z2Hg==
X-Forwarded-Encrypted: i=1; AFNElJ/22Tvh8jaiO6DbhrnUJyEdqCwmUxUDEVdFqEQVnK6oIDJbPRVqzSnDvN+fxBedmZKords=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIEUd9FNMNt3AWeiNLaWySO3I8gDSMK8E5Cu5qgLy/+DWWIar
	ef0T/iWg0FLYlS5u5IYZ3aCrSyA4+YsyIKTvT6/bDy6WvdXkZsFlv6uSg53yVqBlys3Vd/X++2Y
	Skf8kWeYLtedcWDFImx06z0EBXPx1U94=
X-Gm-Gg: AfdE7cnOT2pV4UZ7quLFyOGExKLcxfKd9PERHW/PmHcLi8tOO936UTa3I30cfkg69hF
	RXieKJOh7ir9ws8TDJPeWmok3vtYNqpCen/c8JAdkK9YIl8UHqFKdf/pn51L6D4DAKwlVs5Jf70
	SciBFjpNpXCe57nlLoHb/O3S+N1aLHnUlF6ZpiaqevxMhZOsE4H8NigWLAB3Vn8a3udhBV75+Xc
	jt5PoSrWTRme28PBV/qGzxSJsmr7nQvhplorywRD7UCHjVbsPuAP/udxAwnAnmHNe2AD1d5nAAV
	C8AKJgzYmfqi/4Yje2jomfM/h5gvC/AA9QEmJ9C8w27bP2/9ClKLtMt7jM0st2WVZ3CFkISv6e4
	UJ6xDMs7aqdQCLCM=
X-Received: by 2002:a05:6820:221f:b0:6a1:68dc:4a82 with SMTP id
 006d021491bc7-6a32f545aebmr2637309eaf.40.1783219802996; Sat, 04 Jul 2026
 19:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
 <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com> <xmqqtsqedxmt.fsf@gitster.g>
In-Reply-To: <xmqqtsqedxmt.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 4 Jul 2026 19:49:51 -0700
X-Gm-Features: AVVi8Ceh479rHaQNmdSiYQONvzHd9i0vMEL-VLogEoFmtM_H_Q7HLqvJRuQ4WTo
Message-ID: <CAC2QwmKvb24Rhx44aey8MuGtV5=3m++5OZwcCrMGwqvAhjdmLQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] t: add greplint.pl and convert grep to test_grep
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> It is not quite clear if I can follow this instruction myself,
> without knowing what a "plain guarded 'grep'" is, unfortunately.  Is
> it different from bog-standard grep?
>

I agree with you that the word "guarded" is really confusing here
after reading it
again. The suggestion should just be to use "plain `grep`" with no mention =
of a
guard. Will remove it.

My original intent was something along the lines of "guarded against BUG'in=
g
on missing file", but the wording is confusing and, worse, could encourage =
the
anti-pattern of using grep to test for file existence.
