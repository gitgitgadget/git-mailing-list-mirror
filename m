Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4E48F832
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099067; cv=pass; b=tjOr5nFjNyo3g3g3BUuDRacx7gnPc6kv5SNdR6auRm7RgE2oGaLdnph4w1/AHvme8ZUHrp25KXy77O8sEkcLHeyC2KNl0Ss1/wFrjyoRBDviC3n7LPZ74n0cOu/aCfZ28bp2NokdFpjKH86bdjLkgj/ZPnKQbARtqhd/Hqk4yQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099067; c=relaxed/simple;
	bh=ya3kYjQ8/YDmUttuFQjKBlVkUbaur/aH5WY03MkFjE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6X6l6fJP/boVYiuJjjiih/r5ahLC0nkm0vES1m4UHi/G4FT+XyFcj0JVwy2W1M5wVwFhhuudl/0p66ew6GHzKEXzwNMJBeRIFD91PgYk8IV9m5GrRKwZy1BW/v8R+ukf8jqeqel00AHLO4l8QK/VoM51iFdjyDWkkboA2HUZvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSbo01E0; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSbo01E0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so2030523a12.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792099062; cv=none;
        d=google.com; s=arc-20260327;
        b=Ujtq2AgTJZ5jOI+YTbBXgQdHS6uCdl/69zfVq6c2wGMmKdT5yOYd8I4uiTEOz1zana
         YnI4oVuUl8lHoRz6t4di3nTLREL2O6fS3We7pLR/SO6tIY0/o08aPEJvRs8KTzz5mUL/
         6SHzRDwokTIJUaH914vIgY4pOdkbftkTFog/p6A+gvvVOesnYbHwGZJ67hrfYN71IuJD
         iuqLOgZVkLUZ0h7bgn6ska58hOBJyXnZc+11IcXbpZxNDu7aimY2MJnObxcIeVEHsf9o
         tS9MX37PlB+tu0MEvMnWdBCx8fcKp2/TK1SNFqM5aAIzY40MBz9tlvtjo5SIK5MQrlBc
         bK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RKyRrUY513j7OtKTcgp4v7LzubgEsMgSf5B7dGlDgHs=;
        fh=3LfGuZteP9RDSIswxLZ9ZmryBGpbnK9gWKA0P262kHk=;
        b=NwlNDmuDPptPMzEUO1uVZT4ctnxKUIjOm2vPkzmZjt+U85WCq7NbEUBDgXXkir7jee
         FJTcg/rZdwzRWk+ytIyh/f05OU6KWKIwYz1lpdC/VbaB1ajRSiCHSte7+hK0jC57eLvb
         j03pxLIEUrSL2Vh/02mVS/1v5XIa+m52OZFmbee98Xa9u2QIfpb44Iyq0Rx67JpORMxU
         Cx09O5a2WL9TOOyoWFFwYjM7JJNHVvcyia+NEHAQGfhHdXIJ1TSn6nYmmrhVUBxbb3FC
         yWneNA1hQI47uBNfI8MPcfhxV0njsKLLnVfbYHaIL2K2SqCZx9YdvIxuIIxPLJK5E3d/
         sGYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792099062; x=1792703862; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKyRrUY513j7OtKTcgp4v7LzubgEsMgSf5B7dGlDgHs=;
        b=RSbo01E08qRTj09zdposPAEVPJXBGl+N2Ij1ZeCxTNQiLID0cI/XMKvnCtFBqhwFia
         wf9QUoY1ngzWU6nwg+YNL4uNMR2KwYAmY9axR50cCWk5N99kHn+IcMgp2rLZBqAmZ0j4
         3rLGkTa5A8CAE+IS6LwsX9fZ7yiU84GTzct4y39pcVEe88mG+FxGaCmT00eKhw7Ing36
         uqrwUe7ls/2LRfnaAUYmRBxjz7PSA2t4bTdvO44+1luZwYOpkoe4uX2r15LIzyVKUMjZ
         Je8L+jv/KopZvEKEVewUNq6Ed88/YRuZsHb+JdMgEK5OzV5mo139bJMlM1NyQJSkP5Mf
         1OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099062; x=1792703862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RKyRrUY513j7OtKTcgp4v7LzubgEsMgSf5B7dGlDgHs=;
        b=To+a8VQOGrYcozaOyb3lqjBfk2VXQlCuGE9dGLDKzx4hlbIICyaaunMRbaUuaa3+s2
         L7zFPGRtHMRoWjGSjvtW92lLtWfJ2Sh2g+gtTQ6Hqaja0IelXJ+ebuK+r0zAELhIMC2G
         k3UtFocn/VKXFWGzuFkCFiTzLMq8rZGF+h9mRtOvj9R/y1FzMoZxuC1TzLpCSCa/7JTn
         aoSQhGvXlzxq3jr+MdbAeiXNp9eetPRE0KlIJm3ksLy0zlshl05vSwIIAqCsy2m/MHov
         KpmMB77DiQZgdnsN4LQGU48M4GSBKtnCHXIVVKh5tncgmODZ/jBF0WXGS5Z3XSky/bsX
         1GKA==
X-Forwarded-Encrypted: i=1; AKwUvBwQR9cbuxNrUOma1OGCo3CkNOvQmMGl5vAMyKD69OZ9YpPGhZK0ymDOXMul3xp/VKAFz84=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaaEyKCRpsKZq07dNKwMG4e/7H4dDhn0YW61rgpk9QbUt9sEZU
	iDtqRZz81BwEGV0JiPtv+pVC5h39ehpXqpxYwRoIE/HgGOWgDpRRM+sLmx+UVvyPJflPI8h+ZS6
	t5KFErfxCmjCtD2B9aglNdlnKOCb7MJo=
X-Gm-Gg: AYBFou2qWtnl08K0PYeG/s4h0tY8syLedVGmC8Xu0ceKdhJ1TOK10YsTVLFv5UCljbw
	H64/w+wNGkmxmVn0Uv26u8bA2yVTs0ydG3Lj6XYsMgAHGKuZA0EK6ZbYJJBjmlQ/j6DpfObFofC
	Z3k1xemqrhkSRpBe/ICoGFWTwe+eAhGQY1WdZ33Bw9ypkbLTukRfIELoTACHm0VfHEd+jahQSho
	LRFO1p7oNQn0talcjN3rXJhb2QbKjaMtxsHmaSfSQT4xZknFmbP9TZ3X2UoQRY8yVAMG/eG8cUM
	DrKB74A013qSd2enI4jPq27OnI0N11Zo9XYJ1a1aiGyVI5Z4KvdYVt0=
X-Received: by 2002:a05:6402:5285:b0:6af:9a96:5308 with SMTP id
 4fb4d7f45d1cf-6b17c293f5bmr16751290a12.44.1792099061924; Thu, 15 Oct 2026
 14:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
 <20261015133624.82112-1-haraldnordgren@gmail.com> <xmqqse26n5fa.fsf@gitster.g>
In-Reply-To: <xmqqse26n5fa.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 15 Oct 2026 23:17:05 +0200
X-Gm-Features: AclHuK_NBOldHqhgGdVCVqz4sHhdmuvpsQUGlDiqiayPTjHtBG45bGYOjIfwpXg
Message-ID: <CAHwyqnWX-3NXtFkKZvKeGweNqYFOp+A5NLgf+aO2iuwg_c2t7Q@mail.gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
To: Junio C Hamano <gitster@pobox.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, karthik.188@gmail.com, 
	mail2venkat21@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

> > The general idea looks sound.
> >
> >> +                    if test "$storage" = mixed
> >> +                    then
> >> +                            git pack-refs --all || return 1
> >> +                    fi &&
> >
> > I don't see any reason why a test would need an if block, we know what data we
> > expect, no?
>
> This is three tests implemented as a single test with a for-loop
> around it.  The variable instructs the single test_expect_success
> to behave slightly differently depending on its setting.

I realize now that I didn't read the code properly. I didn't expect to
see a loop encapsulating a call to test_expect_success. That explains
the if case as well.


Harald
