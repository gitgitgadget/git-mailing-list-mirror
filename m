Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938F172777
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728256432; cv=none; b=gxd6eYxGJ+dS19MtPpxk0LibphuRFXCcfoEcTrlqgBLKESB0UcL/gUYXZq9ZR3XrBJ66mw731K7reV2kllzGGVppPPVRNf3/yaqjQMqu5g8TNKXqfv4Bne3UzajYDdQZ1bF7NaCicOmhV0NxDFQ4GJn+EcM7rM+mxp2eDK7EHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728256432; c=relaxed/simple;
	bh=+5BfBwq2RkSNSz5T51nn+QNjlUEFu48Pg3FK+RrDT+0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcZyi4FXZyb7cUAhynfncgasq8Uw5w5v51EQYywckRuiJVzMNeb8Ng3YfqqYKnQFiSJqq7Iarx9a46BtgjRUrCJPfEqstTkntvKREfhq+qgV813YOvz2rwrtwPwxgCEd1eGCjp9M6JRNEUN7SOZpqwjwZtkZ028SB77wCza+2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EhYavDrj; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EhYavDrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728256428; x=1728515628;
	bh=+5BfBwq2RkSNSz5T51nn+QNjlUEFu48Pg3FK+RrDT+0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EhYavDrjyHpgEpXJX9N30xmaiVJZCdXIft5hiaRzeO0wyOwkZfLDftxRBZ248lWqf
	 irATb+xjASOqyR0g72yTHsHTkmQk+pJx1HWEBlb+Y8AcG6D5/XFOVd/LlJs16CrEGR
	 DVO5FzpGXCWfKJLGEAcP0eSO6HSbLlZDCTOeniS/3m3KyGZpFL3y3AzgvuXmqqDhZb
	 15DJJ8N0ytatTpY3mRdby4qMYMks6A6ZbrxorlCsKKNhgtb6tIUuf2OW53dHDxt854
	 TinNCyrdTIuOGF/GUb/uE8krI6xp3mTGLAgANZjky5YGhFRNBU69TTHJiE72wslVLk
	 P0aRfuUVSH4iw==
Date: Sun, 06 Oct 2024 23:13:44 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] worktree: sync worktree paths after gitdir move
Message-ID: <Gs20QHTpaeb8S4LJC8MapFaP1PN9dJQFgv2XxFKSMDqJV6NvYQ_2aD79u-Yls5ddXmLECCbljzYUdzpPr10QbGKUu_BdP2ui7xo7m-UY8HM=@pm.me>
In-Reply-To: <CAPig+cTKjebbpuy-SCLWd0QMKfHhRyJ81oESNjsUoPDLLNpNWQ@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-4-cdwhite3@pm.me> <CAPig+cQApvzpuCBfViPD_hJjqe_poFO8uB1GapeVpCd2EWvEug@mail.gmail.com> <YYay6Jp5c84h3Tx-LViX4teN5KSBX5PL3_WcOFRzUooFrpJpcBD2SRWf1EQjvrMZsI6zkKyPd7JbWt3Ed3OIxCdkg17fY2qvmT4-B6a0RAE=@pm.me> <CAPig+cTKjebbpuy-SCLWd0QMKfHhRyJ81oESNjsUoPDLLNpNWQ@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 462a625cbcb582c0bfb987f1c329f71b514869d7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------32c147b4fb1536631d4823fafe61c75ff78f21d7eb494a057e2b8ed995274280"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------32c147b4fb1536631d4823fafe61c75ff78f21d7eb494a057e2b8ed995274280
Content-Type: multipart/mixed;boundary=---------------------9287c573bf09e8b261a142345af6504e

-----------------------9287c573bf09e8b261a142345af6504e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 17:48, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> I haven't yet pored over the code in-depth, so I don't know if it is
> even possible, but it's typically very much preferred by reviewers if
> you can present a series as smaller, simpler, easier-to-digest patches
> than large monolithic ones. So, it would be ideal if you could figure
> out some good split points (especially since patch [2/4] is already
> uncomfortably large for a reviewer). But sometimes it's just not
> possible to find good splits, so a large patch may be the only choice.

There's really not any other good split points because it's
an all or nothing kind of thing. All of these changes need to be in place
at the same time or there's some edge cases that are going to fail.

I suppose I could try to split the *reading* of the absolute/relative path=
s
separate from the *writing* of the relative paths. However, I'm not
sure if this would be worth the trouble as most places that read from
the files also write to the files.
-----------------------9287c573bf09e8b261a142345af6504e--

--------32c147b4fb1536631d4823fafe61c75ff78f21d7eb494a057e2b8ed995274280
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAxmaCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACEygf/boBajn1rV9GDS52OFvSXLpkUMp+MuXV3OC4aCq5BxPTOsER9
3Bh7XLQeu1uoliZR78MM6y/a34/wMeK8Ero7RR1JsiH8vlB9gOxJEAePHjES
BsGprYq5moQj1tL/4oPITSZZWsX5xAvMPBN95CC9TkeaeGhS91STur9ltfOB
phAIzROXeF7wZxSSrk/rPXTSQt1SqmsvxWWl8+4W4aS8R/4t0JOaoH4g5plO
APUjDiR3rZyLcnViqXGRAcxGT7ry/M9YqL+/991ih3anOAyF10mtq612Yq/t
E5QjrR3TNY3E/r3pUH5M7LCRd+cGJkQYzKyfmQlo6OgSIUo6rIc8dQ==
=LkjN
-----END PGP SIGNATURE-----


--------32c147b4fb1536631d4823fafe61c75ff78f21d7eb494a057e2b8ed995274280--

