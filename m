Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE62773D8
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062328; cv=pass; b=Kxyw7Q1Cnekot/2NPs4VVhGlKNiSw3KTs8Qn8SuguoedthKai31D+pH9MC4GD6i+qjIcrUK2jVULZayr5XufYpyBELGhMPq5b00dvW27elEjOKCxGUK6fCiuzNkQa89l+nyT5R1a60ORsCFiDSqM7L9hZ0m250HxJDDmKpOuB2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062328; c=relaxed/simple;
	bh=x3pbzrFZQjy1+Dn6ONDlgKsHQ7lnyzt+X0cDxNybGPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOaWwTggNT7o+4vb42k7jApvBxP7YJxrtkSsd2RCT49L/4brFSEKf3qpKGpmdJi7i1cQp3zDaSU4pRsU6tnBKQYUFLdkAlqiYRoge0y54GVqRUm6BS5MmRYBQectPtsIEmwEH+pWN0NnYqh250ZqAQTuYQYoaKrxIgoFW74Ahf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=KZdM4Apx; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="KZdM4Apx"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-667bae10ba3so1563853d50.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785062326; cv=none;
        d=google.com; s=arc-20260327;
        b=hoPjNr1YwCo+EN1V/VQGflE/Nc3nVlTxn05bb6C9otLFNVjkPNMLriM1iDaTkCy9p0
         zBiUE+ZxozZVMP0F/hYi9lS2miaz33yzAbUT0xrQQMP5ZVcR3D3xelI8ifEwX0mQ81tG
         syGIL2rreUFL+yBBzv0fbKdGDCNNHCBpf+KrNp/wgktlQjoMM4tPGPkU6lvCMB1dYk5U
         883/4wwyWkXWcyFUnwNSU4Dkhy21MSCRo5bF0E4A6DglwEx1nlf6puM92LE0itK9vqi8
         qxeQk7S6GSWOYQ3OysWsRh2xfgHxg/H8ajhoboNzg7zVdbuWlgemijnFrmzeZOpwg3Dq
         0N4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbCAf0tMaUi9MfG91MmnIgl93Bhnc/9QHjjfaI2zwuI=;
        fh=fhr5qsXJ2Az+idu7BnoicfJqqD496b/x0JKyU38X+jc=;
        b=a68f2C8vcP0efleo5gwOmoo8ntqkZ2yRz/7gLbpx7RBh+KTxMpKTE01MnwersPS1rd
         UdXdJauBLtVM83IJpRTNVCC5/2y/3P7XgnupBslmFEuunpjTGfnXbhCCPXETQ+54nEkC
         vT4YFA5Jja1tn+haLT2iWzbDQDhu6/QplGSESn3FV7Be5TVI0k2WD9KPGEno2plMkQBc
         Vy8s/iyjnUKdPxPNNhpiBmWyVh09D/VoTnbcqJf3AbcZ5oubuvhWVGsoiy/D8KSigsom
         vO3Z3oUwGz2S0Hk0o2jr+IiGz5YA2LlV4SBEXpsViPoGiaKv5nc4csFaK8adSVlaOl+j
         YxLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1785062326; x=1785667126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbCAf0tMaUi9MfG91MmnIgl93Bhnc/9QHjjfaI2zwuI=;
        b=KZdM4ApxzJeSeICH+KY1oLH8N2IaSNhFmm4Bi3HlOYWRa6doOnZA/N3EV3gyV3aQyw
         lzYlawL4RH6+i0742v/xelkXWx4NozBMf6Ib79TygrP+22Tm2NA0akYHXyi9bTN86j38
         dXV+Py2FvGfcFUQuzuGAYSwsoqIhwHXzc0kvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062326; x=1785667126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbCAf0tMaUi9MfG91MmnIgl93Bhnc/9QHjjfaI2zwuI=;
        b=ce79soN/eRdfeMg+JrUMVktTTLMT0m+cWKdcaEORj0PSFfj3s7dGiX6GTps2vLGQKo
         6ONZwVDO9bBOfa8mc+T69jJrhiZWAAg8dQ4QvKPZTJhKggzs7BPdRSjxk64VZXRVKluf
         wbBkH//DmbXXnJHDGfJjotxflQvGZ3BYhzQAcn9xGHZNsvtzo8HKkjaFz78FyFeU/Dm7
         KQPEcrQg7pP65axkkzxsf4tNvWEN49KwNTsTuzBbEcGRSHRSbBFtRoZCQY3QjXIJeYNh
         sDqavlOkqqjncat9RAihmitj2LQhHhFiuxczhTZ6zCItDiANJAseH2IaEorid4YS70l7
         SsZw==
X-Forwarded-Encrypted: i=1; AHgh+Rpg47KqCCDRp0kaTVK0EwR7cYJ8Qk9tZbEA2GL3FUyOoJa22JVyGtG1zI8NeTeZ2TQJaxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEpw2hUCXPvYzUvnScuuSN2evpIY7kJGmh4IP+dw4/03rMp9L
	db8vNpMoZAHHzgougZehfLIEf619r3gM9RjYPBOuOD3dWTkl9nQeO5peDd7dpclhHjDL7SATAui
	rJVZtFbGXVz0xUYQJj69lTpxb7rOoJQXbGi9K9Rnbzxa206WmrOOZOkP5Dg==
X-Gm-Gg: AR+sD13Zr1sABICVe7joUCVn2BRFF/agc6dDC3ML4FdX8/nCPekLfTO7Clp8GwYxOIm
	10gf8pC435nOBCSkrMG5RbJL4Oh1NVo6h+6wtjMuTPbPzpa8tnu0kbBqYUaNIeH4WhZcU8W8Bsm
	4Mg/QlEuMo35Vl767LADy3TQHeYW4SOGLiLycgNumMLUSTR6smjhifg+atv31gW5XjVesNGWZ2k
	FMhaIPCPOXYUIE3fF3Elc98ckDkOnQgz0OL168927dui5uGl1BFnOu5wxCx1sM=
X-Received: by 2002:a05:690c:b03:b0:81e:c436:c530 with SMTP id
 00721157ae682-81f69ce00d2mr16738327b3.14.1785062325810; Sun, 26 Jul 2026
 03:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> <d0ee6d062ef60e2d9e4572ed2dd4d0968e1e29c3.1783776466.git.gitgitgadget@gmail.com>
 <81b0d8a0-5c65-4b42-ad75-2b818f0bb66a@web.de>
In-Reply-To: <81b0d8a0-5c65-4b42-ad75-2b818f0bb66a@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 26 Jul 2026 12:38:34 +0200
X-Gm-Features: AUfX_myWKM9mlm3l3GK-k4Zpl9_qTrNyJ8zMjKUhBvebDsbCv-ygIbDvphuHhiY
Message-ID: <CAL71e4Mc5b8rqD_x=0XPvrF9NtNw6Y_twrdwJAF5vE3sWtkzOA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] test-lib-functions: improve diagnostic output
 for trace2 data assertions
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Jul 2026 at 13:29, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> > +     case "$actual" in
> > +     *"
> > +"*)
>
> Nit: You could use $LF here instead of this two-line string.

Good catch. I had missed that convention but now when I look at
the codebase it does look obvious. Will fix for v7.

Thanks,
Kristofer
