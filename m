Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BED21254C
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106623; cv=none; b=TKuWIdKuAx04ZWbsxSLl1btkD/ahyTo2jlnrokZ4cCjNrtOO+ERViX4aGCbL8cypaNMD7UzBsaAqHJVGbsEXmtMK1SvIa4XO3ZcewcM8FetZycFuznO3svThHqtNPt7sjZAK5XRwh1dUFa8sKeS0GwwPA6wVFPxmw2a6zCSRUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106623; c=relaxed/simple;
	bh=AVZqzRKi2LOW3ZTOS3jl66zQYuHK2FjwqouC5SElTtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6T50o5nDwNrN7rytkrwbZoUuu2LF2rxcyhn+/Nw1kZ9CCEQ9+g40nhiS1KK4P5lrf5Ux0OkMM33xiZIZ7kK7b49v5g8TkxuLhKt7KtuqxGDtSgtmGFbYtz2TemxAmCqkKsimuHvc5lEFWry0WlGPtLdR4+43lXDUFDw3lJsf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XercloSl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XercloSl"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a0550cso16046666b.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755106619; x=1755711419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUi9IFwizcPvVV+hlonCVBngxxVgUTSEZpzhJdEMfNY=;
        b=XercloSlEySPTnJ/MVA3FpXn7NZJGKqAbKLlQV0QfLMPaLcBJGe9lDqNWXeyll0tG6
         18tBkCCmy4PkkxAGnvZfHlV//z/d4HY7wo5DQkvoU771sI1q4ooaMLvuQz3/ASB3Jtl5
         RA+xzKkhA+SomC0wPwPwsw/p/3WM39qOA7l/D9YvSg2H4NERaAgdxSbfHf0eWnN2reJB
         iDDZMjy3IS/M+267fvzBQtANwFYraBYKrq0QY8LKloEKex+TIn7pATPhE8vCDJBPM2cj
         dvSzOsB0yMRP+4k22LLOusgHFwxRtvsWPDbV8h+hMTJzOWic80HTU6dA3nrIReLhfRa1
         zjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755106619; x=1755711419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUi9IFwizcPvVV+hlonCVBngxxVgUTSEZpzhJdEMfNY=;
        b=DqlleFltDvmIz/tfpEUqnKArACd06NdAUVdftzuRP0u1eAPr3dIN69/yvf+YcVLiE2
         3McHUyM1/PZBTuHJfUSCMFhQYf4TUqMUG93BSdWUNutKBJCaddStnoUta+p+LAMQ3GW2
         Hu0ZT2nhyJIbk2IIXwjF9D8g5OJIZffFPmqmS07BFCMfCBeC93sQrwCc5T4ETLMLICvs
         Ii8LDiQZQk6+zApRK3bbgZ2cRTyynSvk/6vGMiYWGYKOoMOcr6172wAw16SKun6K20Aa
         0jAh8sZntUMyUVP833lF0Z7lTu4BSiwnGJsrj8fn2Nkq+7CJtdvJ/9e8RBKyb4xGoAp8
         NY3w==
X-Forwarded-Encrypted: i=1; AJvYcCXq0jL5SYWXnegMwtYYD1IuuZR7/UjOobSbQJQ7rUFZH3MUeONnsD2gSI/2SRwdtj7g4vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9U3TNNxOKTtg/UXgvpvlMtf0E36qyMEm60qUSk7p6qCabv+Lr
	yO25fIVsUxSsiD2D3Z3EeGrUw7rHvlCycDBxdIGC/icF+P5J9Ki6EHfNPlNcnVocVUAiBqimm6k
	TVgAqwuf0wFWTpPcy1klyhmP2j9o43es=
X-Gm-Gg: ASbGncvFQoEcpcWKGI2XCvi8GVmiF140oEIxUZIDn6QwLW9zjGJadm73AEn/1eUr3W2
	s1IldBHQmlYPaplyMct4vtIlAr9uZc+11wLRD2in8sRg1hBkhJ1KLZspaPQtB5585ZlDy46/AsY
	grgCruoxKG6boGmGnJSroxNbTiNDiAc6PGFyQRKolKz0GeTAyjt4MG/ibajmmlB49ZlZFjTUtdk
	PKfCrSp0PHVh4/wykWKi9VK/5hf6pICF9+sYYBHfg==
X-Google-Smtp-Source: AGHT+IEdHvE3rh9cMfqar2KCmkZEBnHGR6Ks1Tod0H+00J/7KVWBltIKwX+WJxuAzHDjHgtLKvRXI8Alqe0AyU5CkIY=
X-Received: by 2002:a17:907:7f14:b0:add:ede0:b9d4 with SMTP id
 a640c23a62f3a-afcb91d8a02mr9320466b.0.1755106619322; Wed, 13 Aug 2025
 10:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
 <20250812170256.71751-1-ben.knoble+github@gmail.com> <2250a8fd-62b8-4218-9858-23032d9c807d@gmail.com>
 <xmqqfrdvns9d.fsf@gitster.g>
In-Reply-To: <xmqqfrdvns9d.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 13 Aug 2025 13:36:48 -0400
X-Gm-Features: Ac12FXwwegEijtxmREhjLq-DKBhI1liDqw3s38bsIMeGaDywr2eB-PGB6QTEYwE
Message-ID: <CALnO6CCUAHvi3oC1A3czRLsuGNGUQMeRomB8A8sF=2ULWcmszg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] clean up some code around editors
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Ben
> >
> > On 12/08/2025 18:02, D. Ben Knoble wrote:
> >> Changes from v3:
> >> - drop 4/4
> >> - use test_env (including a case our lint does not catch when the valu=
e
> >>    has spaces)
> >
> > It's not worth a re-roll but for future reference
> >
> >       test_env FOO=3Dbar git commit --amend
> >
> > uses an extra process compared to
> >
> >       FOO=3Dbar git commit --amend
> >
> > which slows the test suite down for no real gain. We should only need
> > to use test_env to set environment variables when calling a shell
> > function. In the special case of test_must_fail it supports
> >
> >       test_must_fail env FOO=3Dbar git commit --amend
> >
> > which is widely used in our test suite

Aha, I learned something new (again)=E2=80=94although that still means my
diagnosis for this about the space in the value is wrong :) It's not
flagged because it's not a shell function. Great!

> If this were some feature series, the story may be different, but
> since the theme of the topic is "clean up", the above clean-up is
> something that ought to be part of an update.  A clean-up topic
> should not be adding things that need to be further cleaned up ;-)

Agreed; I don't want to add more problems here ;)
