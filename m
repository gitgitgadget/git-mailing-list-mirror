Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD022425B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025268; cv=none; b=FBa389ufSsmxT75nWPkcz9JaPknt9pfla0va7036hqOcHzlsImcPAE1cMmybpMEHoZ0kSTyChY4vkg0K0n14piWtGvsBmimNR27BhKiQnq4Ck1bm14VQ1YPQ6lWBDSLW/Mm1mLadzWeajN5LS8WWWdNG0d3PcJys9u5kcVS/+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025268; c=relaxed/simple;
	bh=i4MUgWsUo7GFtLNCBOA2m63aWzkQ7HTOvJ6vopBFWEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Omudqtqmlg+UJ5GiZRLINaa6iclfhP2rZWCGeo3697s3F3RytnkqlLdENXyHYaBFeSw8Mu1un2VMhTLgAz+/k0hT4tNlrf0Oj8RQc70UacyMqvvZgKLoXLZ2S/Jx8FNPqENCrctxV2I9/Ff1VdXnCbpT/xW9NVV5WTRDwyMni2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hripZGqQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hripZGqQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso38964155e9.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755025265; x=1755630065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FMsOYQ5ELTQRVZkqMfWZZ4Oy0hxBu6MFXZdb3PL41g=;
        b=hripZGqQ9Ps898tfm8lGaK59qtDEMQzQzdJAHI+jhgcOfSgc/Lz8+QYKE0hBWtrAtT
         /v466kAF2kbCiaxqbfxufGRNKhns+6bowxdNMyuu7dYl2jctzdvFxaAtbIExPWgjWQSU
         wadBRdJ/LcWj/cn1/irSdXwN1EeoChgB/ncAm9vUB2Mpt76A7t9RWLclaWTiiAjB+iNT
         SGlMX3kjVFmwEcQUtgD9FfDjOpFYwZQo03D6cvCn7NwST2p22C1BYOhjWqf1l+6V1PRG
         cFph00T8BEe0zEUOpjdyfOE9yPm95T+eoyjg63dPpBeni+j7Vw2tMOYRonspF990Cr5K
         A2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755025265; x=1755630065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FMsOYQ5ELTQRVZkqMfWZZ4Oy0hxBu6MFXZdb3PL41g=;
        b=HceuAEjDEToD0NkR2T4Io9s3qnBea1Albd1+Lr3kq9/gBgRrZPXBsuEQEw1gQsUrlC
         4KgXgY1KKpcZPuL/sv+2exWp3s7g0cGQMcSTdyKfVlfQqTEqmQN3StsfgYwtod4qPkct
         CpBrXOWcqHu1nmIPXbsoi4SCVn3VIsv+AjAXVAIzmywCdKMJowCrSBEhy0aOts2B8soy
         DRLDhatwO/qD3cvwZkS7gFkC7i1eLjl1LyKhCibMpLtvmcvNbSPzZXD3wNcX1+wy+ai+
         R4OjpntfQc/h5UC0LK7ZXKQF6O8jUR6ZKIb6V2TFoC8f6ntmgWnkEGAtvQ8ycWU96+ef
         1bxw==
X-Gm-Message-State: AOJu0Yx0fTkEXsKyEebRLTKsE9IL8CYVovnaK63gisGRVEj42G5os4/s
	7AueI44aS0NedxqvKaxAEk+ZHj5LpSws95q3nSfZ5lpOJkUix7nUKDEKyRFyk0/AV4iaZ0Djwui
	mHzVseKcP3Ddo8JzzrXhEndfUyjpIr0s=
X-Gm-Gg: ASbGncuzalueQdSqzVhxCqr7Y4kCiPpZCPWG3V3OSEZ071rf3Xi/RwklyRNa527B8fM
	d8vMsEgk+QEmEr3GcxPet8YHg6Bl6IzGCqr4eltirNp6idf8tRn255/bstphm+uqOZH/b7+iKDv
	0uwWWNr4BJvjhuFYE+nhFcqidpU1Dyq21rpY+T6HyDVfdMNaMC8zlTZU0ISkW+A55SS/3wLf3sT
	CCVeIzPHjHAcg==
X-Google-Smtp-Source: AGHT+IFoVgXCnH54QsYsJMmNj0/NaWP6hXOp1AxgoiSZ+lIeGfpDlUWv0FEs8YAu70N1JsaaHdmVb4jRPaxBOVGfON8=
X-Received: by 2002:a05:600c:4f49:b0:459:db5a:b097 with SMTP id
 5b1f17b1804b1-45a165dad94mr2236835e9.16.1755025264409; Tue, 12 Aug 2025
 12:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im> <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 12 Aug 2025 12:00:53 -0700
X-Gm-Features: Ac12FXykIl_QBC3ObwTFfV87p7Z6-bDxSQJ3ub_zPWpqSFKURbn2jG8nOjnmrhY
Message-ID: <CAPUEsph_rWfbxobf0fWuGcWF=XNa4911FAXvB7agbfyUiZDr6Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] reftable: a couple of improvements for libgit2
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 2:54=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Range-diff versus v2:
>
> 1:  ce08ba1217 =3D 1:  1613715dc9 reftable/writer: fix type used for numb=
er of records
> 2:  80a87ff19a =3D 2:  4a082b71fb reftable/writer: drop Git-specific `QSO=
RT()` macro
> 3:  e230c97347 < -:  ---------- reftable/stack: fix compiler warning due =
to missing braces
> 4:  dd413b76a2 ! 3:  3977a1f497 reftable/stack: reorder code to avoid for=
ward declarations
>     @@ reftable/stack.c: int reftable_stack_reload(struct reftable_stack =
*st)
>         struct reftable_stack *stack;
>      @@ reftable/stack.c: struct reftable_addition {
>
>     - #define REFTABLE_ADDITION_INIT {{0}}
>     + #define REFTABLE_ADDITION_INIT {0}

This define shouldn't be needed anymore AFAIK

Carlo
