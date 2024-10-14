Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5113BC02
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941683; cv=none; b=Vtz/RHMe0ApHE/xCvPN5+uoyJL4GmcaDJfrY7JDwVvZvn34FOOaMX7qEj4+GoTIejl19QU5dLWMF/xtPPxFeEPz0hScP+CzC0JpkJMY4nZFlOXOBSdVExED1Ksz9xVbvpAiGYN1FjeXwg98spb6XpsYwM74olnFJSKjCxraTBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941683; c=relaxed/simple;
	bh=1JjxvxJroEOT3tABMnEj8AiBz6QrHHFtHV1Ck/B5feA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D809Fkw2QdyfFuoQVXJNwlgxTDCHZe7IjqQEvfaCeHYseMAGG6XvRBRuY5q5EI0odNa1wvFupDbUDW0BdnrpTaFPpPYuje8YPUSC1TY5WXG8OGOk+JgSn7CK7NyUAHEkXQ/GhzDaK/af1go3PwPjRyujcherusgtCAaRcL4wsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1hmSf+Q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1hmSf+Q"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2393147a12.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728941680; x=1729546480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0GWzCj8IuYxI50mDXQDIaMHo69WWRnJMemVDgP1ngI=;
        b=K1hmSf+Q+1coXdGUL7v4UacJWYPdGh/DP0ZghOtvtZkl//7cgGTQVRxMtxrDPCKGUB
         Fs3sMIamaDkpUmB997nZIp5DwGVPChUB2DWkNQUJ32vRCYUCdMXENfgBROG8SzJBDU+4
         EM1kwbPAIcni5KS7cqjvViTjD/PmTEOUNn3gGzD9cA6k12WS9ScxW0akvhIH1eD0c7SQ
         b6qnLnXxCvWdk/87005d9qjMi2QPZCPSaP7ZEOmOV+GUNMoTspNzbh/HvN9XtEX04CZK
         z9T6G+/6z9r47nL10j/GDqTD1rLmm/obXwe5s8z4y9HBM7CoXnYnIcwawVHQP4rhVnIH
         FgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941680; x=1729546480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0GWzCj8IuYxI50mDXQDIaMHo69WWRnJMemVDgP1ngI=;
        b=ehV8CrdiSkHbfaFerQaOfe51jjbhFuwqVTfS8cG/BiBla4xgZLsrponr9GfOz/xk7A
         GOJRRfU5KGcjk1rJMP9sDzzBTj3cpBXLBGBOyDvG7bJDKs00ROkos654wUzeEwgRVlQ9
         v6Pj9Ce2sbwIpVdeCnhC3XZd2hw1gUykCQCrlnChZc6QPEadEf7ReDpUQAboSwAzO8uO
         X6sf6qj7Qip6fLGJxl9zJ0/zfTaqGJoMl+4TlAbNQ3m7HV2WTMHet4FZFXeWCNWpEo8j
         sUlK36WYbPwUn4yN7u4zoHuYWmrJYJ+Hopo1TEm4WooDXMV2eqiUEt3MobOJt/hBh47P
         QzlA==
X-Gm-Message-State: AOJu0Ywd5D7IBoWeh01xb33zTeGjoCFBpHDASZiypo0cKHPz3vHJp7ga
	OO06x6HOGpabp3tCl8798zwOnvq4UVzO1lQS5IcNuAI5980JkdLfQqnK5EbQUZTGKYQBeXwFpDe
	kq8WOE4bOaFCEMIgu+25oeawlY+kelMBP
X-Google-Smtp-Source: AGHT+IGYqwTEBr1Y7GU8oN8FhZBuragJG/Asf5n8yL00y4NVmXssc/3o4Ag/iwHOkWGRRqbi5PAcLzxu8LMK2mNk/xA=
X-Received: by 2002:a05:6402:c43:b0:5c9:4b8c:b92e with SMTP id
 4fb4d7f45d1cf-5c95ac50946mr12792347a12.26.1728941679735; Mon, 14 Oct 2024
 14:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local>
In-Reply-To: <Zw2K5xJAOGWitfXr@nand.local>
From: David Moberg <kaddkaka@gmail.com>
Date: Mon, 14 Oct 2024 23:34:28 +0200
Message-ID: <CAL2+MiuG4FQdV3c4tGqcRgV+JWxAfvbo91vdGsnFHwDT0y_VRw@mail.gmail.com>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Taylor Blau <me@ttaylorr.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am not sure if this has worked previously. Where/how far back should
I look? Is 2 samples from 6 months and 1 year prior reasonable and
enough?

I'm not sure if I understand you, What is the behavior you expect?
Are you able to reproduce the behavior?

/David

Den m=C3=A5n 14 okt. 2024 kl 23:19 skrev Taylor Blau <me@ttaylorr.com>:
>
> On Mon, Oct 14, 2024 at 10:46:45PM +0200, David Moberg wrote:
> > What did you expect to happen? (Expected behavior)
> >
> > 1. This command should return the worktree toplevel, not a subdirectory
> >   $ git rev-parse --show-toplevel
> >   /tmp/tmp.DUUAVQCIKe/repo2
> >
> > 2. And the git grep command should return the match from dir/Makefile,
> > not Fatal Error
> >   $ git grep banana
> >   Makefile:       git grep "banana" -- "$$BANANA"
>
> I am not sure if this is expected behavior or not, but it feels
> unintentional to me. Perhaps I am missing something funky in your
> example that is causing it to behave this way.
>
> Does this bisect to anything interesting, or has it always behaved this
> way?
>
> Thanks,
> Taylor
