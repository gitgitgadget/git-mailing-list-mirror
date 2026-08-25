Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A333CB551
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687098; cv=pass; b=qhkYWT/n4I++B0Vt8L+53J3QpE+LWyUCCzOWzf1lVz2uPvpH9gCZwWMlSTQ9AuOGp0zB4tr17VG2stjJ2DE+a0Q8uyzItfRryyQwvx1MjZLR50C3v3w6KuLyHotv5O0QGAAmgVrCBgFpXnEAxn246fl3KhTNjq6CTzim3PvOy8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687098; c=relaxed/simple;
	bh=RKqVoQ2M+AIrYBxFTRityE4tbEuWtBK/bDkh3/TwXBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsk3VGQQ22tZXI2Zr7bASI/qUXfMrguCfc1JqbSkRJDTOl4YaNEXATmT6EJOnhnlmpTofnB34ubQX6+7jhNUu1Ox0iYD6IWwmGpgH8GaH9BVQxUTHBFb3oe3Ete+C4SIujAPTRgIQheD0Qy8yp5bFz/q9y4ZmF01W2Z1HZAo5Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbiDF6N7; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbiDF6N7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a4cb36ae00so252381b6e.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787687095; cv=none;
        d=google.com; s=arc-20260327;
        b=UWZEVibLlqRqS8SuJWDpkGhvldNQkxnyHTPLdItJkWYEhaKqxm5ogxB1njBZBeuugD
         RiP61Mn2TWhACybQNU7mdql7NTM+8mhysJ7mtHCHeznVturX+5FrGURILIBf8NLau969
         Dfj7vsGP+m1PegsJJlPkQuf/MHAmudfp23QXkggz94dfn8ELmlpdRkpaq9Y3oTOnGtB+
         zBz1DFm9ipppJc+rRRicQMXaBu4BbBp+V1rhhpV8OBRV6CPr/TzNJ4ktrwl9hoZYsLUb
         1VhFzL9TlB57aMuGU6CA2TXKc1rl/Wtct7ABbhVDZdbKR6I9R6Gfn68YgdKUM4E51543
         uKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/B2Q47fLFjN0teYmr9cYymcmTLN+ySITLRBVSwmdqM8=;
        fh=+4VZ6tdlnaiSiUvxibrIWqeIRNRmZ6y4CAINKUCullM=;
        b=c+Uxq9R8JxjFGfLQUsZX8nw9T7v5aNsiDl8qnxfYvmbrypZ3zuVVuYznNuDIytYtHW
         YdfRnWALWoKDXc69YyqcmYVecSHg1kgdXEr6CcNPtschdTuGL+btY0L13lkef38vCByZ
         sp0RmINwfrkhYYsmlmoSl2FoMtQB351q53KyOCBuaDpcaLJ1/xrukL8AcEZ9adEjj7Bl
         3vKnZLxqBi8Ybvd6mQeSMptE3lJnGEIPxHcaVH5PRxsFhkapm2Ks1bSKZcGo7+F9B8D4
         0TzeQRU8YFW+bjuOh/ACqQo5u+3gBKyKlZvihOrWOq4U3wvHWAX3UnxHo/iYBBPsi5LR
         l90A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787687095; x=1788291895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/B2Q47fLFjN0teYmr9cYymcmTLN+ySITLRBVSwmdqM8=;
        b=MbiDF6N7vzjd+X+6dFJadItW3yuDO/YMjlqSKtTChSHAKnmlpBP6evbziD8H9RkLO0
         pq+0o3Pn64qAT9twcI4oX3Ynx0CGVu2vZ3SCmG7F8ggKK10pcuO6kWr9W43k4+LI0j9W
         Rtd4kOj8xxraYTPqtg1jkOw8iFcsrOr4dhkCuSGItV+wEc8Xek1cPJcCT5ylPgk85D7I
         HGKX7210hsm/WbqXomqeNhiVtBt9i276khVu1rqV/vK3xMXFEjnDfgw8tY8ohzwBV9IN
         VIwHosDQ09NoT1/Aa2ONVdlUixgLcXUN2zTuxTlJxchjBtD9M1n836KSnqtb0+X5OJyH
         95cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787687095; x=1788291895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/B2Q47fLFjN0teYmr9cYymcmTLN+ySITLRBVSwmdqM8=;
        b=liwaw+4XCNWwN5VO/lhXmdHh+9k5KI4lOq5z+jmQ2RmixLXqhOzy48HLniqgQuYExq
         IIJd3NqZgpjQ79iB+uN4woa9kISEOtl2fex9R9YO/PPuuBzIwvReO33qDToahyfHnM4O
         p2l5Wc1LnEJ6TDj60/KdcuLGqlJPJzAOxT0JSU+TPu6gsSQwBbr9RDeYx6IXxp6dcAaw
         4Li+oGL6QRcqclIOJs+6fN8HU9uR4AfSdWVQgR/QK0sVR/We3rVDE/dTG3JKPOC2gm0z
         WUMJfPe3ZjemGysdBhKLIHFQdQ52/F5a8CLmxWSAiQ46+Bee6DIbIWbWKKdGwU7hySlk
         f4xA==
X-Gm-Message-State: AFuF++ncobtafZD3ctjIGdM3D9Z19aYUagebDGdlEgQO1iyI4qe9tOjH
	JlSPpd54FwrfLtqQ08nac+BXglVsbJPhxoqIz9JmELdpcoDM5m5hSPeQbG2rOTqv0vBQWYnhEry
	ElffSqPc3XL4eMCJu6eeLRgVcUdPZqvQ=
X-Gm-Gg: AR+sD12Rpfz0gmSUATUS/M4ilJiZPJUQmXgfFLz2FD+6h3qWSnIfWKMyyPxqYnWteoi
	dFZX5Wh8DUQCEPW8RNWSGkNfJy1V3fhBjDqdm3zDeHWT3e7Uh1DfeVydOA/hTdHqzb5ZDFEom50
	v7MB7MAxV3TXj+ZMQRJFKNJISdVVUTfzK/ipTjNhohG2vNmG43p8nUQ64KHl25owsPRxcW9kJsQ
	PaSXfv13ZzWiAvS4M0GALuUijF3EOpp32ciAm6qAqWeycgl++Rdwlg6gatU61TKcv7zoKX8NLl1
	AOH5v+9I/dtpy65RkqLLPSxDhWMom/rFcyCEgoRwCay2Ide5vFdTHV/Lwad1U3HPh1SZCOEruFI
	h3uldhg/V3o/6P9/PTCxrKIntmN/VEJL5VXAzjVI1q6BMxr2dTUKYWas/Z8aJ
X-Received: by 2002:a05:6808:1486:b0:495:feaa:9e39 with SMTP id
 5614622812f47-4b366a7f7dbmr2392616b6e.6.1787687095586; Tue, 25 Aug 2026
 12:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729233215.398654-1-sandals@crustytoothpaste.net> <20260729233215.398654-7-sandals@crustytoothpaste.net>
In-Reply-To: <20260729233215.398654-7-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 12:44:43 -0700
X-Gm-Features: AcwNN1UJPGAzw_ELmqIzsoIUderCY9_ogw-B-pGnb6S7emPyuhFj09LDkj-pAPE
Message-ID: <CABPp-BEAx+YZ547ig52EQaB65Yg6aEXb0qdLsWsChekhacqCSw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:33=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In preparation for Git 3.0, only allow lowercase hex object IDs in
> breaking changes mode and document this as well.  Update the single
> failing test and add a new one to verify we reject new uppercase object
> IDs.  Note that in t5324, we change the hex character from "A" to "b"
> because in SHA-256 mode, "a" is the correct value, so our test_must_fail
> assertion will unexpectedly succeed in that case.
[...snip...]
> -               corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
> +               corrupt_file "$graphdir/commit-graph-chain" 30 "a" &&
[...]
> -               corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
> +               corrupt_file "$graphdir/commit-graph-chain" 70 "b" &&

which "A" is the commit message referring to?

> +* Git will accept hex object IDs only in lowercase. The fact that Git ha=
s
> +       historically allowed uppercase characters in hex object IDs has b=
een the
> +       source of a variety of bugs and security problems in software usi=
ng Git. We
> +       don't expect most users to notice any change.

You've indented with tabs here while the surrounding paragraphs use
spaces; is that going to mess up rendering?
