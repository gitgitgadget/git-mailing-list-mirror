Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD173D47D9
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365861; cv=none; b=FSaoBdANwwwMWEPyILgNt5v8A7kJ//zlnzH6zRytnmGTYu/FlxPE3hI9+ha/Wd9BFqwmfezV/fAt00K2uhd6uedvV5Ox1LcgAvoertNeyu4Qk6Yv8qKNvmc8sXFMoUimP0cRkKWQlzuhZYO25vN/Pc012w5CKMykIOmAQzXUKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365861; c=relaxed/simple;
	bh=Zewltc+d08JECZstm4Tcsqihsw8XMODkbIe2PXFJc2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uT8H39OtRXU+Xax5KOR60LSpnxdHGyMjD0OkpHKUHMTgXlp5+F+i7L9hR+q5Kh5zOQSlJKhlOkswblUZUZlzhT2SizwQn01Rtyln+zujymxgHvzCQBtrVS4Zedr5b4B1GutHT8icXDu/rahECamnMm/s0dwlcNZsVVT9Y6WjZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMEZA5XM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMEZA5XM"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e7d984096so122959311fa.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365858; x=1777970658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlMvQGaAu7M5OwB59SaeTQqOVLAt1W+aLNfuJTnuPrI=;
        b=jMEZA5XM8MUOg/cE694bP9vnK23Lkf4baAETD9AdGxWizPe0XKOXEIuqZHpbF39ven
         9RH3TA+ar7PCpnWmcPasIbFOJZUDpFtoFddIMGCsAbtPrgG/hyLaVIrukFthfuySbp3m
         MgqHrTpwJKER55nPuidhiMUY/fPAyusVLshCbgb8Q5QFl41dCNnh5m7dDxwk3julmwnx
         wGGbc/nwrLjWhVaLjmj6J9MP2OTj0cepEWPJllUTJxsp0TP2/HUFOCxOWx4BWnlKLg0L
         UfVNgQdPX2RV46eLCYCcf1CcN2RqNkXLFG0C5RjGqrEUVzw1bWC95/pGM5/UoD2tDF2x
         /OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365858; x=1777970658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YlMvQGaAu7M5OwB59SaeTQqOVLAt1W+aLNfuJTnuPrI=;
        b=JJTiC6LIEvD3PyfGxk62esOzQdJ4OZJZFiR++4Z5a7fMWqBbeeJcE1fRz3MGKHy7l8
         hC0N1ML1heeGn55D5w/oz8+QXgmcBqOAh3sEApz6QNFOUhIidEi9kVxpacpQfbmJ/WgC
         mWzzycPDGFRV4VdHzRYDegwsqCB0GTTtt1BhgKZSjbOtxb97XBVfGBbRRXlAAxbQB5ea
         hpnt+9YOpnp2gQqLXfAlWlaZohoWPtezM3pC7Y/isvoqOo2ZfitNtd7qMfm56Osk20yR
         FtD8G8IN4cFBTc/92GHi/7oAKBvQsKdsBtOFtrbczB7cxHVLRyCpbmpzJV/oB6ogk3gK
         TDkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kY+JOSBATAtJlTh3fWXDS1tU4JTeZ73cPU3zZnGM5DxkOCwnJq5B6R2LtA09F7h1bxmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiC3ZrjTAEGZ5xCKYklDBJv2U8etNEyPGZ3V0OoXsth3s+aMR+
	b5x5PUXCBHSDy2outJjU27PmX3xVbDTTrONcqPNzJpL/LaLa4DyPARtP
X-Gm-Gg: AeBDieu1IDCyaCLfbz+4m3FwuyxzJgpIj0CYeM98+LHQdnEpMwFo54+5Cwmxj3UQYAi
	jtpkyM/JJklybQzGDQcgKRhcFG9smiwD94fo3LGNG2h6oxauxEBPFhEQT8c0s+hKs0Bw/ggJoqN
	j6wVMOuFa1HeOh28CI+D3xM3SrWH3q7Xh36ONg+uDtw4arAINqgVPPt/l6eC7ko0mt2eyKbzAE/
	oOllqg77ogETEVABO1UmX+CiKzJ7w+W5RsKiv3BgojA9SVBe96OTW6F8jWEMe3zjJkZPtnkduq6
	KyH4qIne6J1MIREgTRznjacl64AzSa+uO4EU9lU2uTUi7mR6SfEmx9U/HipxJaz9myLy9syHuLK
	YAzP9Fs/btqkSYoBUyOD6anLU6Vjvb+YdFStYhoh8+D9Ciu/UDvBEfMzT+x7ax7aQ0z7SIzOWqC
	uwhBwyl+n46DQPRqVYBESAMHpj5w1mxyyMp7BTh/g0s49KnGs9LlA/tT9ZFPFuvm3q0W9wta+7F
	ibLxgfmVjPD49T3Frs8P4JQcCYEFXYFqzY=
X-Received: by 2002:a05:651c:54d:b0:38b:d004:3b13 with SMTP id 38308e7fff4ca-39240f813a9mr6957111fa.16.1777365856889;
        Tue, 28 Apr 2026 01:44:16 -0700 (PDT)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3923f2e0d9bsm5430401fa.6.2026.04.28.01.44.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 01:44:16 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	marcnarc@gmail.com,
	ramsay@ramsayjones.plus.com
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving start-point
Date: Tue, 28 Apr 2026 10:44:15 +0200
Message-ID: <20260428084415.10702-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <xmqqwlxrzwid.fsf@gitster.g>
References: <xmqqwlxrzwid.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I hope you had a good leave and is back with renewed energy! ☀️

> Git is among projects that encourage forking only from a well-known
> point in history (like the latest released version), not at a random
> "tip of the day" commit from the upstream.

Are you talking about the Git project that we are working on right now, or
talking about how people use Git "in the wild"?

Because how people use Git in the wild can be a bit different, and merge
conflicts arguably the worst part of collaborating with a team using Git.
In my early days as a professional coder, snubbed my toe countless times on
forgetting to pull in the latest changes, before starting to work on
something.

I respect that things work differently in a neatly ordered project like Git
itself, where you do a great work of organizing, but all other projects are
not like that. My advice to a junior developer is to pull in the latest
changes when starting and to rebase obsessively to prevent a large merge
conflict down the road.

> So instead of introducing a totally new option that can only be used
> only when "--track" is given, it might make more sense to introduce
> this as a variant of "--track", perhaps "--track=fetch,[in]direct"
> or something like that. 

> I may have already pointed this out (but I do not remember), but
> this option would not make any sense when --track is not in effect,
> so instead of adding a brand new option, making it an extension to
> the existing --track option might make it slightly more palatable.

Fair enough. You did point it out and I will give that a try!


Harald
