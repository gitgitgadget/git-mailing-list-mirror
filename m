Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AB291864
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368108; cv=pass; b=XvZ6V1J9K48UJRgK6LQycL5+Lx9jRthfeq95C+VpgdNjOO80E5zfA9XgK6DDnWtpB6t+IbxhVrZ0HDbhPduXCPCgQvC59HfL2zETbJZr7ILkgc4L3jVirRw+ejCUsioo6fhgD2tT+tBH1RY64YWwcU6ZDQLGOQRfzWxwbeQMcCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368108; c=relaxed/simple;
	bh=QR5uIm1XL++gAg7ATy2uy7ZChhpLfKpW0lNZo5KLfS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmtltxpOLOSgMb4WspKHVyi1loqJuilPKqfrl0oYHTz8Vd2EUUsoFsgshErytR1wwLrqBADS6DJrjDxCmXeE1ffjgSLFUQUJ460ceNn2WpFiwVWCzL6SKqfkLACFNK6zEs2jGAr9xLVwbG5/tvBsPEhwSpPJlSvItKMeD9Ns7yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V78Q1HYY; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V78Q1HYY"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69e7dfcea4dso1760700eaf.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781368106; cv=none;
        d=google.com; s=arc-20240605;
        b=jTlcIMMvSuuU9HTCi6rexZ4bfi3tQGi/VNt0B7IgugJ7xVCT7Ogl3yYU4m/DhI+/US
         cQCIFPRy4AZ+SnYS8RQ4lxyt4T1OlvYILBloZ3KoWzpeBD59KtEaomsZfJ+bs3P3t7yJ
         ayMKFfOxaDBz/ZIsG2M/7kWgEMU/AkSPWw8PxKHJrPVgVfxSzvkTtvC6mGyRTZohoE5l
         l8hujpAWl0QEzQcd/+1oTIHBRLgC/OM9K5vvK4Exk83aDWtO8AthzJljasqErmASnjpC
         INk4Rl1/pukPFwJAMRJ0XrOvAMj2fCu6GtzPUPgBrD8Tm4RqjS863q6bp1vrFPoyWTPI
         wLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXclMQr1VOdz1IFXYkxSxGMSlpW7lJXOtAa2GCGUZiE=;
        fh=pWKKmNwrSAcaI8J6LD9vNC+oept7Ai0wbzE0cTxtCc8=;
        b=Anao2SjX+A3cWOaiRB04IQ8nBUnpQw0UdRIHc1BvFyCbHwOUX0uQ8YkhX+zrAo+iTg
         fXWpZFb7Bo9mfJyGKmhcBHDobqo06OBz1vGfVSduB6QbvWeGKaMiC83gDg6AlicHJqDW
         rdp3wP/RgGVniBBIeiKI0HUlB6YXXF0YzEZ9IsGWTghI6f5/UaA2D5GXy65yWkyROTNX
         LLjOU3S0F4fnS/gpbHpXOwvSQeBz0jLhq3z6cjh+m6TlI3j+KZVyIg8AKOAvtc7cVAD0
         n34geZbGYCcQtHRRpw+Bq0L9wK//mrSKGzagM0Vkmjz668/jsEBfsDUrjY2LvTZ4r23h
         DNLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781368106; x=1781972906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXclMQr1VOdz1IFXYkxSxGMSlpW7lJXOtAa2GCGUZiE=;
        b=V78Q1HYYxW6+C5XfASbAygeYjijo0/JJYCBNAPzE2ldgCoSDQv1KQbsjqKZ9v8hhv6
         9CzqPI4ZXvnjFtzHGhpZtQV5z5KqwKqBpxa67WHHN9Xmiw3tmSIkS4M3XyC+vIzDCmVp
         qbQ5YDnUfQd/TyTBVxCHFPJpMOnaagaCT3a3vtZXymWmWyEvBUlIBinpOdZJtq/WDxTV
         B4qf1EbAuoESFyR8AuohhKYMtytEaD4UX6zl/9YWPFBJQdpL1Nhm8Gm9dzc89VRAPwIB
         jxJtgADpt+F14Eq83fN3W+GKB4ONaNB807HjLnNSNDCh5CMNihDCm7wyLGm6rSm0jo/H
         gAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781368106; x=1781972906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXclMQr1VOdz1IFXYkxSxGMSlpW7lJXOtAa2GCGUZiE=;
        b=NmZdBy0j5W25Hj0q1VRKEwwI63cSKupKvnPJn98sSdGgT7dmAqKv7txGA+LJjetCRh
         ADNb0q5YP1G2LJKhj25cdjPk745mse63ftILuro0Z9NVePUc8ghhA+D/cSrvdR8+4JvL
         4LaJeG40Bu6J5Kv2lUhAxlmGve+lIjWuZI6uVk261/k0k1P6JoOg+Ob+BrZ937Fwo1gx
         SKpluYHxaexI8wKycFiLd4QUSJSecLZOjuKhmSNCb1TjIOhXCqu2Uc7h6DcEUfUSHggE
         WNMhc3v79FU8C70G/IBRIozYzBkMlscxPMSaIJvFEkO5DS4Zxv3mvcamM24YZ5lRqIVZ
         ax2A==
X-Forwarded-Encrypted: i=1; AFNElJ8X+xqQzLytQVvJuIFqR+BCzm8jCcNr/uP8nwWShfNixL4t+TXynX3DflZpSlVtfWGlRes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJskiIKLTaCGmX+x5ZRtb+pPjRXVvZd9yZH+H9IDNhrnkmNT/M
	4bBWLJ/4fy0EbeiF7Hf7wrypzdJlOIg0xpE8afcfrwrj3iB6jRSzq0DB87pSRnKSLDpTL8cw8Ez
	qtZUXNEVeNbkSdFZ3nsg7uYEE+MWze4w=
X-Gm-Gg: Acq92OHscvVgPgObpMxuicDxYRy2/+WRGNhYAbGRMAsgRV7Jy9hcjkHWiPD7fl9cB2q
	ow1KAgyDQBQJUwFc5s9Xv3q4SggjKnIO+g6fVbHqgaFxnXFMFfOxM/PvLtoYO9bZBR9sLAJZUlf
	nZ23FQoBtH5NzcByt6q4nq726JYBhQyFRs12FUt9zftkMvsQ+aJ+aXoBB1u6g3qxGyad15SCM2P
	diq8f/6YuBe1XpSB89HmabQ9l6fHXy9o3QPul4m1xiTTPvEKwbS/LzyVlZ3Q/T/KUeLw6+F0oZG
	/isEQuqOvT6B/uOWsc4d0BKTFrPBVvyOJezXxRRFAkukDza9yP8=
X-Received: by 2002:a05:6820:189a:b0:69d:9132:566c with SMTP id
 006d021491bc7-69eda86d8b3mr3666834eaf.13.1781368106488; Sat, 13 Jun 2026
 09:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com> <xmqqldcovhnf.fsf@gitster.g>
In-Reply-To: <xmqqldcovhnf.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 13 Jun 2026 09:28:14 -0700
X-Gm-Features: AVVi8CfliiyF1w1QYJq3d0gexzYmsajpYcLWOXFf6zZ_sw6XT7_kG253E5UVaq4
Message-ID: <CAC2Qwm+-aNRa5S1UiTqXbMZi9hxE_FCOjCQ6cL2trgufktsNiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] t: add lint-style.pl and convert grep to test_grep
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 2:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> I do not think we want an automated tool that rewrites the source
> files.  I was hoping that we would get a patch or two that _adds_ to
> existing test-lint framework (i.e., 'test-grep' that 'test-lint'
> target depends on in t/Makefile) that gives diagnosis in a similar
> fashion as test-lint-shell-syntax and test-chainlint do.
>
> Also some existing uses of "grep" are not end-user facing and should
> not be rewritten to "test_grep".

Apologies for not responding explicitly before sending a re-roll, I
will do that in
the future. v2 attempts to address these points as noted in the "changes"
section.
