Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94ABE49
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658551; cv=none; b=pa1gJXM2rV0spGU59WnzYh7W/Ax5OrAKPUshAkydjSOJe9FPYMBdLMx5aFpL+rEAlpWJFq5VFW2EzW1HMHz+5VdVAd55+BFSB53mGstJ3JJQO2L7IdtnizbO4HHQU3S1gNX5ujAi10LRyeiHWQgFR+w4x6MxLPk21WkttLTbq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658551; c=relaxed/simple;
	bh=N45rPSz9FbIMc122LNMtj96KTm8Uab0bIsUgjDaIkME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iX0U02zUV7AYe1O1ykq6YKpUIH53A6k4bulThpWnLyuofqcMgWH2OpBJmxOLwfY3e4tTLo7G/pSD6yBA1TYy/tef8DcsByLmjeJtKcBNym4oKbEQxmjGdu+WwldkhH+Ey884RpPUoyH+pm42CJQxjXhyr/HXPEDNWcjvutwxbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0WDfK3I; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0WDfK3I"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3637d6e9923so43844311fa.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758658547; x=1759263347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgI5nRQuMngWi/FUXsQh+Uk1u+PWfJArejGETsAwWAU=;
        b=J0WDfK3IU0gNAbnBHDTCK1dQz3OcKVGJ5Eo7TtdTEab5PUQH1/f+dwQakQ9nQaqfqX
         2xvuunmPR0okzC0Vgg1HzLjm3gC5gUioRSmCRAHtKWrPLcVK/YSgkLyXJi5KW3c6wdYJ
         9dh50osJvrwHWb0SlKi7cj4Wd1N5+SWKBloHeSzlDwz52mdSMZMbOoxogBHf8AzfZSQU
         G9IAYS6ZNbiWdnXqfNwOBcGiCD9qE5nkPfpEynELqAoJem6uEgr9c0spHhsYKVQZb5/q
         0RwGz35ZX5VAwXGCeO9pg/NtCwHjYYvGoC2cvy+KVBoGUPdO0Inh9X0gk4rWDUxcE3rC
         CT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658547; x=1759263347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgI5nRQuMngWi/FUXsQh+Uk1u+PWfJArejGETsAwWAU=;
        b=YYNRNhoq37/qRumVHT8xv7H/a/rfybOpmKs2PWUMZHPoFTFxuFGYPzhl9GSsdLqsyk
         TBpUeYyE0MpFKZ/D5L5WE87Sja8rA+HwSH0hewqOuS2AuOBJiyY93CfIS4SJhMt1GH20
         bo5Tcp9lfa/+PE8aGlxS4HERq+qgyQrQ//zFTxqirTSn3aE2ESBgtgbkQPg9n4W3UGcx
         DIHK9CR1F4WAgX9AgByPKLCCg5i+ziSlRUTLvgmOWpNFTdYryy364h2xzoEk30B13C7A
         W5WX4Kk+A4Gb/ISLWdgkZItbRniC6SYSG9NniD4qnL0Om1H4+Y/fPq+F4NFWaa1P4Zv/
         xU+g==
X-Gm-Message-State: AOJu0Yzb/RyrP2Ry/aw+15+S6f/jphRZNwhDrVPe7kZ/ZqSMep6Y4X3k
	C4A2n9/i7YX7nQ121bZizRocWDUCLTvdt7NdXML3QuOMidoriYvjbLBk7tBRpHn6PJaPLhl2hU+
	2Jdxu3sHhv1TShQauHHnpP0RJ0SRBqswMYlzN6ZpLQA==
X-Gm-Gg: ASbGncsNyXEQJxU2sDU3zOO/ctmAPzRYb8mHDw8crYpUnTZ1RDNgaM7T6JXpCp1wjfK
	I97ls6nS97Cp0YKZTidG6Qdg1of51m4RDQ6oNufsitCh6QGYK0uwlUDOcXEPLgnTRChh45alG97
	UwhQvifH/+N7NtGBqeXnmvLEJu8//BPBBCfpQezTxvsgcHJhiKCY1TLaF1yFapHuOJE1R1jLThW
	xU2hAvE
X-Google-Smtp-Source: AGHT+IGxFro92W7LRYVZUyTrQ9ooY+e0hbanwd3Qr685Z5YJqzKZFaAvmZhPik4hLWtZSJ+6wZjit9yiMj1zbwzYbm0=
X-Received: by 2002:a05:651c:438d:10b0:36b:9e0:dd0b with SMTP id
 38308e7fff4ca-36d17dbdc9amr10759761fa.40.1758658546483; Tue, 23 Sep 2025
 13:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im> <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 23 Sep 2025 14:15:35 -0600
X-Gm-Features: AS18NWBI_11cZX6KKDYG8YrUkqxGcSDPRJe-Gkn0grWHS8LDQuiDkiPt3enAm2U
Message-ID: <CAH=ZcbALjKY+=TQfv1L4PsAyC=-fxNdi8PhSFnXq9G5zcVtkCQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Introduce Rust and announce that it will become mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
Your patch series has 2 critical problems:
  * meson doesn't check for "is windows and using msvc" -> <crate>.lib
else lib<crate>.a
  * Using the name "git" for the crate is problematic because both
Make and Meson already produce libgit.a which is different from the
libgit.a that cargo is producing. Change the name in Cargo.toml from
"git" to "gitcore".

I created some temporary patches on top of this patch series that
always forces Rust and then pushed it to GitHub. The only target that
failed was windows building with meson + msvc, everything else
including the 32 bit linux target passed.

I have some nitpicks about varint, but they're not worth mentioning
here. Fix those 2 points and you'll have my seal of approval for this
patch series.
