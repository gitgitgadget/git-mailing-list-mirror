Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8B1B4247
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800154; cv=none; b=HCi2QWh8VlIm6N7tVD8M4SykGjm7tdpSBs7L5Ml3ztEL3IKPqdKX41nGDJMnB/Es/T3yMpdJRji+aPwsU9MF2CwEeCiMM1QRmoaVZ9t//IvDhoK+Hc6shjPzM8RaUOw3Rv8fe+izSzeUSnCdWWrRvxPFNt3w8u7lzSzX9ThpBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800154; c=relaxed/simple;
	bh=KAqviTSVoL/OeUntEa/+gPgZnL9a2ncQ3+mkFnvi/rE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiihkpGe9LiqOAlJ4suo7B7nAsgKNdygaS1636v4Pn7gIRSbMt4VlihenQPrNQnECZmgJ3tS8oHXI2RIbGURlBZauyLlCcQ9MO857XgbPZxKWOEpK6TPkgA8iNg6gX2Jkwv/pSCTQEYv021jfhy81zfgr90rDmj7K3VQeJEHWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DsY/KOQ6; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DsY/KOQ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760800140; x=1761059340;
	bh=KAqviTSVoL/OeUntEa/+gPgZnL9a2ncQ3+mkFnvi/rE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DsY/KOQ6mv4KBR4dnL3LCusQi3yJ+339BlgXepYGcqHl/YT7o4LrvYa0ZXbHrWJ/C
	 Ij0xK6+6cFDPmghRlvz7WpYx7xnUfPkZbfFpvj8F4w2O9hsvLH3nzgczw59j6UA95r
	 zdxBLjxVNPv6N+5fK9ARJEpY9E+h8Tx3/x7Gnvwb5unD3fE7KwykOrWcD408hnEMll
	 keUnBk8O8pFy11yMrZuSW+o8uiGB01cFsYD8oHgaUWfs3m1eLjjJOZ75p3emcgKHOl
	 BeswFybBrKFIt7sqG+5W3u3JRJQspf6pXX9Ah97tPhYqrpKPEgFYMI/0S8kh6PMSbs
	 +AmosZelW2DnQ==
Date: Sat, 18 Oct 2025 15:08:56 +0000
To: Jeff King <peff@peff.net>
From: Langbart <Langbart@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH resend] status: make coloring of "-z --short" consistent
Message-ID: <m-o4xSH-_z7mD-3ehDnJCp-J3JOsEeo65xRb3BxywaB3voOguES48T4E-mjZwdmqwcP-TxF6kcr6nKMU6YE2z8SkncQl5jXDqdFH6xcl6S0=@protonmail.com>
In-Reply-To: <20251018095026.GD1060824@coredump.intra.peff.net>
References: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com> <20251007082920.GA3349249@coredump.intra.peff.net> <20251007203406.GA4028057@coredump.intra.peff.net> <20251017084455.GA4096702@coredump.intra.peff.net> <5y1mZIuIa13McbaoEhdBCm8CNMyjkJ6UE39s0kB-rYSmAmuPFnAof5fNVatncDUXIRoMvlpdbId3nFn2dnwU8NwNk78XArUYCf3RncWHu6c=@protonmail.com> <20251018095026.GD1060824@coredump.intra.peff.net>
Feedback-ID: 20607877:user:proton
X-Pm-Message-ID: 0dac1307b5c5e7c94af39b6563fe5101f0da3b99
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Thanks, my intuition is that something like that could be useful, but I
> didn't have a concrete example. That one is perfect.

Great, I'll pass it to the fzf maintainer, who proposed it.

> (If anybody tries the above, note that I needed to add "--ansi" for it
> to look nice in fzf. But I don't usually use that program, so I imagine
> there's a way to configure it to do that by default).

You're right. I only set it in my environment variable:

export FZF_DEFAULT_OPTS=3D"--ansi"

Thanks for the fix and for being active here. I've come across your name a =
few
times while searching the git.vger.kernel.org archive mirror for issues, an=
d
I've always appreciated your thoughtful replies.
