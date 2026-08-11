Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B3356750
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437050; cv=pass; b=UGPQXvoc3mbHX8tw+f+PK9jbE/rFcvK0EtK5Y3Bf+vfqgFmmeWtK+kqT0baHEtX3gRJmz8iRpDLJAxPxR14GB0Jd/+vQOW9f8Y5TktX77pQwcxYiKpN4L+5QDiybYm09GG3NkTD6rtNn/eWItpmH9xnO1LTAzwFij/UKzt0r5oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437050; c=relaxed/simple;
	bh=yEN0Nky5Z9iIcUSsDLse8Eu6fAIxLMz4kHFBVmNAIaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UriJHgU6DcqwpdlmMTeD4isP/twB8gyxmNxeFtmBWoktuY4YhfPDuBaWg39e6YiWt4INwSbaG1pg0mMJGmFdkd7OcYnFqKP0HyxD7bBjAyg9GWadbUgDAtrQjpd6EgrXgb+4eDLBYV//+Zc3Pssrg/kGLq73osAUq53mWP4qA08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuDTfj8H; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuDTfj8H"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1666745a12.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786437045; cv=none;
        d=google.com; s=arc-20260327;
        b=dzD0qaLMgWcKSUvi1NwVVlHkVQoOp6PW8GezvgcrXjdPxyGm50L5UzPSc3Z0wcEYJX
         avNepDNZ+IGTCAf6xP02JHCIpCHV1ls953j/3dFBL9sf93+4NJpjTDALJgT3zpCdazzp
         r6jhJVwQDlqBH0UZYS7XwJLpGs1HuRYHbiOUm1P4W2z8DRht7D8a3jMuTp4b2F0DEEoo
         KkrSS0mdVyA/5tzLv3VkoeWYkD3vYJJIIzSkAr/kAJDUjFgDJpsoIx/agbnG1uRDdNtf
         qsd1HIyG7YtBWsLPOs+SHd4cYFWguiMwU/UwJyuGNLb8Ti5v0YXgpulNuqtRCBQ6OhFr
         +Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8CljSSXBaqwu4mbosEYBlJDPELX5Yt4a1WOnehsHwoY=;
        fh=KFNjeyWgmnf7cA85VfKAZ5S2SzPYhEM9Piv1MnIZ0+o=;
        b=AgUJbxicq7t9x57sLQS+Y8GLLnuamaK49eb7o4ibO/6ofhV858gMpWjidV+86k0xsA
         IQOPdenjW3/MJ7bTrBoZb++cWs43PGgSKu0mLbCauH3zhu9bbffC2V4MzeZp/SB19GMR
         j7zgUB1qKbyUOvJ0JW/H3kdEsPNJ1sZLm3jgZS7aAVqc4a/g922xj4c+VZM20Gk9PDhZ
         mZU5r1hz6+VAqM8ykfDnOpGjaLWvLmDWQRFys2jl8b5RsR0FduxI+XHQhCnYSDwVSFvc
         OTB3Fz7Iqhj1hc5bHYV9EvwhqTFGBzTJlNvk0GlEWrzea+DmOGRR92YNTqHiKN2Oltgr
         vSwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437045; x=1787041845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CljSSXBaqwu4mbosEYBlJDPELX5Yt4a1WOnehsHwoY=;
        b=nuDTfj8HWh0CeFC51jKrSphIIiyuF4akIqOWdgsp6Bv5kTLhcvRVFETY7a+FEmg763
         v9pKwMwVrjcwEyNXfTcM2YUW2jnzloUc4vB8VCahp8ICHI49Eal5rfkeckDC2UG5EYe7
         Sdnp0SxydPsQ7PwejA+zeNXkQGV1X539xc1Qd4977jx/0gz3Nkom38psXEYElIuS9ze0
         E71fhDCcdzY9LEWd1Tu6+IQeuKNf8kp1L1kKjUyPUoIujZ2hz7hpD0/+KZRKg8QxnqXy
         V4GQWdoIGpAlX6T6meanX1jXsKdqB6RtRUHDahjlYhtPNOZ2/hjrp1nW8gTtp78LpUpZ
         9aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437045; x=1787041845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CljSSXBaqwu4mbosEYBlJDPELX5Yt4a1WOnehsHwoY=;
        b=ZGWWDLGsgy9B2qVD62I2Zx0h9FOwHwnwhatccn9bNO3kM3f1WhnCUdVcIK40pYdhgF
         Pjk65TV8HHPgH9l7SXK2MoCq95b3+R2jM1ICzdXWKzYTBP/ge6w+uN089VjENqU0zggp
         59OfaXp0i9mbKbFuMi/LP9V7wOocUBJn3EQPgfZwiYKcKrDoHvu9oXryUUm3mu+fxjuC
         YkIKj+6p1ZKEMK7yB/PoFwn7w4OtoO9SAzl3RYCNdGeHnnCErKz7sykrAMO+bthUMfCa
         bF2UoQ5sTN5I/ieHUOlqyoknOpqqitnRV8i0i8eMeViyq2n8Bbpia4aNBA4hsd2D6G5g
         JuVQ==
X-Gm-Message-State: AOJu0YwoShg1Drvi8e/JgbOpj3bw9rgRN4UiaEjlGORWt21P6+O2Izwj
	GIafdGSNWuCFnh4tzD0N/xYFePtLapfvQ2OmZAfk/0abH4nAL0ycFP/FBBs2RvgEE1fZF98Aqi0
	CXqevYuD71/NA+B8eC7mE3QaRdSApjaA=
X-Gm-Gg: AR+sD11iKkli4XdeR8siEaPMr6+5sw2b8IoDmbPaNwzlXfRpyqoaSHIJ5eojJH6H9YX
	EQsWbGZoZd9BG0f84QOBR8l+BVpTnXsRhk+W9AqJVjXfRYHO7X13aGL+g7iiYu7HVGT4K3+EDzs
	XSDbFEYtgI8a4ALIZE+CvJI0V2FvQ/1BcCoI1D2z0YZhKj5sJRxHMyZJkxRClsh9jkAoBYEwfc/
	vXjiUe9Z/kzDC1AOUWPmw+J9Ht3TAxcJN+xIDFYNII4udxtacG6ZgJQtyG4eVJ2oBRgFuF5AELZ
	FM5BrDWbgi5IGng/88qsZZLXdOY0F9jXsUhScJpyQwItIVAhDW01XjgFqrjhlDWgfqvhoNfJoXS
	oo6tbIZRw2usRI37zDlRs8Tp2FoGpphMBKlcV1hpK6J0UmitlJETOH5/gviw+Jg==
X-Received: by 2002:a05:6a20:da12:b0:3b7:807b:3cd3 with SMTP id
 adf61e73a8af0-3cc2ba01e09mr2099906637.23.1786437045264; Tue, 11 Aug 2026
 01:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com> <20260804100355.1299498-8-christian.couder@gmail.com>
 <CABPp-BHoxLkYJmoJ1N5owJ5-S+yr-4JkuectxSVG8oa6PESkWA@mail.gmail.com>
In-Reply-To: <CABPp-BHoxLkYJmoJ1N5owJ5-S+yr-4JkuectxSVG8oa6PESkWA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 11 Aug 2026 10:30:33 +0200
X-Gm-Features: AUfX_mwU99NAccSgcpWNboLWN9MhgKChoEnSl5C3NaHxGEr8ow3P_FAXAzxyy9U
Message-ID: <CAP8UFD1V1LA6E8BhuZwn2WaAiidHgZVUkRA4LO_8pMUrsWFu1Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] fast-import: introduce 'struct fast_import_state'
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 9:25=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
>
> > -static void note_change_n(const char *p, struct branch *b, unsigned ch=
ar *old_fanout)
> > +static void note_change_n(struct fast_import_state *state, const char =
*p, struct branch *b, unsigned char *old_fanout)
>
> A really minor comment, but you've taken several lines (some of which
> were already too long) and made them much too long.  This wasn't the
> first or the last, but at 118 columns it was particularly far from the
> 80 characters per line guideline.  Could we change to
>
> static void note_change_n(struct fast_import_state *state,
>               const char *p,
>               struct branch *b,
>               unsigned char *old_fanout)
>
> ?

Yes, in v3 I have changed such lines that are modified by the patch to
what you suggest.

> The actual substance of the patch looks good.

Thanks.
