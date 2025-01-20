Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A61E3DE4
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386890; cv=none; b=Oo2p8xhdA7erSLjnc7KwFtNaoEagRJKIj3kFAjGnJiKYYmGids6d2+2THQdcAhoCTjWy20vY7Lfp1gPxcWLNjPXDZyaT7B1usJX8x1Qdo2IKsF0E64EwDbsMBox2FekfpUUGIuDoHp4WvNBbsiDILNHp9pQUyxr4Emls5ZJdhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386890; c=relaxed/simple;
	bh=zhz5AAAFF8w8v95BuVF7cJpMhoYdeKiVfs+qulZHflw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG3OGH4HOKXZXnqKBrFoghBQrb7uUt5JE6bQLWkBfXej7tZMTpPNqpyFhQ6h8FeiSDuQOAPp5lqQDHXqm4l9E6gj9Ox3s2Sz4962HzfkFgdQtnfl2jZ43B24RyUX8/kxFGNs/iICzOV9zEkSz/SWn/tk/URO1GxsRYOKNvubkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=sWIcphPc; arc=none smtp.client-ip=79.135.106.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sWIcphPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1737386438; x=1737645638;
	bh=zhz5AAAFF8w8v95BuVF7cJpMhoYdeKiVfs+qulZHflw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=sWIcphPcJDXYQ+pOKm7dXwBLCefGLM2xXFZQz4KebtoaVn/19Usr5nBfdL1uUCeNl
	 jO6vm8IettH+q6CcmZkkPcxoBXsaiccb0FKHDnp6VAOXUFwdNxD2B99nS6EwMOkXud
	 74iK5x6USaNjUQm8Ur2B4zURS/f42iphNxHwEpaJFqWHNgCz3gXC39eEd/amIDDIP1
	 r/kc6SWl7N1sGoFrc+PpE7n3G8PsqKHOmpbyPIBrzbRtyu8SbNM13BjUE6A6tXF0gn
	 GlwVwZ2RHsl0MFn73j8m7KqrLVPVE4Bo/q674GD21nOcCi2GQiHGBCBWso8cqmKwwg
	 Hg3o9BUt1gVKA==
Date: Mon, 20 Jan 2025 15:20:35 +0000
To: Jeff King <peff@peff.net>
From: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <OZMxBc6aAmluYw1_O-0ML1kM7cHNUEuFuhQwX-jurD482L-tjh65TOSWSq-hRzVXvQ2Bnz5SRqzWphewMPH_j-KKSdRtI-f_aNCeIkDLVSI=@protonmail.com>
In-Reply-To: <20250119131224.GA1541095@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com> <20250117121121.GA2356599@coredump.intra.peff.net> <20250117125207.GB2356599@coredump.intra.peff.net> <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com> <20250119131224.GA1541095@coredump.intra.peff.net>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 78f5617e7de569424ef375bc2664e0040c39e021
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> wrote:
> Here's a v2 which fixes the reading side, as well. I think this should
> let you get through a full run of unpack-objects, but please confirm. :)
>=20
> This also includes Junio's put_be32() tweak to silence sparse.
>=20
> [1/5]: bswap.h: squelch potential sparse -Wcast-truncate warnings
> [2/5]: packfile: factor out --pack_header argument parsing
> [3/5]: parse_pack_header_option(): avoid unaligned memory writes
> [4/5]: index-pack, unpack-objects: use get_be32() for reading pack header
> [5/5]: index-pack, unpack-objects: use skip_prefix to avoid magic number
>=20
> builtin/index-pack.c | 30 ++++++++++++------------------
> builtin/unpack-objects.c | 31 ++++++++++++-------------------
> compat/bswap.h | 24 ++++++++++++------------
> pack.h | 3 ++-
> packfile.c | 20 ++++++++++++++++++++
> packfile.h | 6 ++++++
> 6 files changed, 64 insertions(+), 50 deletions(-)
>=20
> -Peff

Okay, just tested the patchset here.
Both the testcase from upthread and actual pulls seem to work well now,
without any crashes happening.
Thanks a lot!
