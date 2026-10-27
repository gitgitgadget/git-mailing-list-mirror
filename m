Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141825;
	b=Ig1arqXfr+QDbBPP9Kba1dNoFQ7+WAOccsT/82WlJdddFdjVX2UrgxbDmghU1XTsey5Q
	 FCDQ+Kp+NW9FSeI/QSGcgi7wcDyqHTpqVhzplK1KZ6zB1RAfv+oFUMs/FhL7rZ9NvxEmo
	 PzdnBphPB4bYTWbH6L743ZgDlyVQOnZmA/MHDfdbmFy3FhgHs9NNy0Bdzg+G240UV93/w
	 dQWYeVjp6DSe3fXHZO4EK2jMW9SMbTVCMdgfvDIKmyTaYQAZskgL7mbW5JF/DhWMWI4dZ
	 PFNF697pUIn3RhFy6gK+1g5NIYbP0CuvOsg9+/x3AcXSLyXKMM+tMttDI+tIaG6VM6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141825;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OeN2EsMqMaRFd5HO+Z4E+Ml3mwZ9BOq7pWqrl8yTNA8=;
	b=YCKaEgMWzT6NdL5iRm1m6ak8ZgMgugw1flJCpE7VqjeTySNjnPuyJ/cl1GuYGX07rf3p
	 19hIEmgAapyY8TCikzSrsHsLApWlzBmFAJobZKaLCci0Xzd7/0KLL663W5GnCKXS48rUl
	 wefRxEtGwS9eM7BeZe6QJgugSOgD46ZAF3mUmrgT5IQR5CKrr7VVAUVZLl74D/vMIMBBr
	 uK5EfqsWrQgHxb/zUrPJRyLxbFK+fSTrFR2pxF2AF6HqgMr1Gj43ZGjCYtH+DHnqt+w6b
	 V4+xXi1Y9ywDAM/lg3ud0g9GDKDDkgcdmY92IE8nP26CgODbOvHlRc7/gg8VvbbzA+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DYyzCETG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pO46gUnu;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA674606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 22:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA674606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DYyzCETG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pO46gUnu
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 597581D00112
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:57:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 18:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793141824; x=1793228224; bh=OeN2EsMqMa
	RFd5HO+Z4E+Ml3mwZ9BOq7pWqrl8yTNA8=; b=DYyzCETGiH/w2tjY0XMCYme9n3
	Et99CHXIDamtqYvcxyaMVIgqRKtC6vfqtYZ2ghCtaLJ8TvdxCTeO78xRpg4KYw6r
	A4tmuDt5HATMHOb9HlNkaV6IYSdhRZuJVm6097HfQcXTsDNNGSCD7aZVqyAB2rAc
	Sr6j6itRYcGUnjhEOc2V2zYy897N25ta75Mw6gXlLUUIsM7FNqX1ObcO7kaKRfIN
	AGK5bQnUto9dS/XsseQyG3c27qZd00Q72W/tIarwqMu1jMBrQQpyhZnLtXPEEztZ
	kDxS3NkOkFPg2Uwn7zVGS4zRGM6xFVrkWfqr+06ZK0wIWxGLefbQEGWQy+Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793141824; x=1793228224; bh=OeN2EsMqMaRFd5HO+Z4E+Ml3mwZ9BOq7pWq
	rl8yTNA8=; b=pO46gUnu61spluxob32w81NkU3jG78eVG9eJen7iiRrpexHh3Oo
	78HQrcpRJc7fQF9VNOmWjaG74jadT+J+Z6pe2fDrffjF3r6Dr6wBzGO2abQ0HhxC
	W3+BmHsmlNm1bukZHJwL87K1IBYMI9xyPqAH12FK8jdXLpuTVK2VSsXdM5E9QiLS
	DgylbS0ZlV8RkDHLjVjFJfxcgg8XB/pQCUoKSZIEhvC8CcidVvSK+vedjFkn5Peu
	fnYQVjey2JjNzGLTMRExJ2fwqUA5uCW8EYRqblC4+mu++0E+2Rsa9EaxB+lAmdsm
	HSlyndbfvCEy90GgFxNFZvTP17az8va7uqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793141824; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YEyOALm+rjPb6ZwKDoE419ZDxhNTR9dWbQCjT0utqbkHyNn
	KAXtTXYF5iWm7vEF+bZ05dDfrKT6LoFhIv3kDXEizQp1ncNwSdC344MmYk/gDfCF
	7tbGDqk1Uq4yZ7PsdHUIis6JUuVEmaNpI97g3795ANFoZ+lV0pgq+zlWu4twdvOn
	FQBCDAhLS+oHZ81okbHWqY7ApERKzCaTf272UzsyQKsvomO7jYkLdvAkDAVviNFZ
	K4Xdk2/iLfQLIxbfiEreRaYRyl5tFGwb2TL3wrPIWBg11KK8cUT0/OVU8/gnHWuT
	tsDLipqV231Rpn2xbwkoVmJtpIVA3tsw4Fh4lHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dH2RQwsummtNqzaIOeDwSf9uQWqjchJ/wdfhvqweWiY=:OeN2EsMqMaRFd5HO+Z4E+Ml3mwZ9BOq7pWqrl8yTNA8=;
X-ME-Sender: <xms:Pyzhaucu9XYM2v7vFJ4AV0KA1y7WnuX_gH2DRZh7djFh6qQeAMCtew>
    <xme:PyzhavFoqZhJhdoImink4o2ZzJgITq7ht968rlnc1dhsYtFkB4YiUBE3KQtWPdLva
    R8UFCVdkmTnjHaBmH1m5eYK75OTt18jYzSzetQ4BrQWKwGx5mc41w>
X-ME-Received: <xmr:Pyzhan3HqJOovMKa5nCWxM-AAruY6IUfMrVQICftjBWNAfWoKrRpE2cr0DBGCxKuvCJbMBU4kfbX11_EJfiJm7Hw3G7zxveQ3Iiu>
X-ME-Proxy-Cause: dmFkZTFGKy7NkrjYpn5ZzzQyOzC0sNxC8Fs6pfbu5tDrvqVw8uN5XY3B8FtFLANPeGncRZ
    +/KgW//30SYIKqohXozQq88lYTdI6v+62Lpn1BtKxzEBLQSmFOHzf8HqMYzqe6B+thsMk7
    rIlytvtoHpkz2XQPg5N8HXNMhQ4OJuqunwm9VNa3M4oo0D0hpiVKohTEhCvXRfOR/OkVZg
    6s4iedTs9sKONOVTi9xN6rveYqkogwi2+FeKi8Vk/Q7G8PmQ0cyOyuNCtRaGA25SexRFjw
    oU2DjX9u20Gl+H/rfWAYvWwAyIWDBd+Y8ZZRs8Sn8HwFDPWphUhrFTpmOa04NaW5koz5ng
    JLCODRiINPVGcc6x6H9QxsRZ5SilRvMvOEvJkILm3QHqsqTVCPzDPORE+YD4kbM+rEgQor
    pjD4IYGNkJ5rtaFz+lXuoUE9U9DNedoZcBKd8VmcxvuufHT5DIbnpZ0LI/8N+WUGy9v6+3
    zMm3o6Rma9qsd6yAWKMM3tl+JSS/kEin0z9D9LE/WNnkZbA/kycFlob+V+MgZ3W31vq8CS
    9bHrhJWEnTQnyOU/5x3UuybqA4Wgc/afInkOZrFdjUa3nMGr/dC9PffPw9LLxkMNEfaNPS
    wzn2Xw/lwhPDdrIvWbdUvDrJ/BsJcP36l2XuL6QFtS8v5G28ZghquJBLO07w
X-ME-Proxy: <xmx:Pyzhanlo9FSG_i21RXwAjuiNRc4vbDRDSVp9VSeB2gDWXuNt-l7g8g>
    <xmx:Pyzhan_ujjSRsMKAEN_qs9mQuK83mRJKAQchWGKGlhCtnfHiKvrpfg>
    <xmx:Pyzhasr_Mc6aKMSRQJfrvKb66n2z7cCDjVqp8sduxpEC8DbBOwY1TA>
    <xmx:PyzhagmtigcHvY-G3q3uslgVWfkxt86TtDU0uOf660eCniOsb8H1DQ>
    <xmx:QCzhaixW88FpQzOBZh-RQFOgxQFHUwvWuPsytXPslG0-796BnyLPxolm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 18:57:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: ps@pks.im,  sandals@crustytoothpaste.net, Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v5] move rust gitcore crate to a different subdirectory
In-Reply-To: <20260917060415.2986259-1-mh@glandium.org> (Mike Hommey's message
	of "Thu, 17 Sep 2026 15:04:15 +0900")
References: <xmqq5x0df19l.fsf@gitster.g>
	<20260917060415.2986259-1-mh@glandium.org>
Date: Tue, 27 Oct 2026 15:57:02 -0700
Message-ID: <xmqqh5i6g3b5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> Having `Cargo.toml` at the top-level of the repository implies that one
> can run `cargo build` directly, but this doesn't produce anything useful
> on its own.
>
> Additionally, when including the git source as a submodule of a Rust
> project, it prevents the git source from being included at all in the
> crate package because cargo skips directories that contain a Cargo.toml,
> assuming that everything in the directory is relevant to the crate.
>
> Move all Rust-specific files into a dedicated `rust/` subdirectory.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

I was looking at discussions that are older than a month whose
patches are not near 'next', and found this patch, which we haven't
seen any comments or updates on the discussion thread.

It does not seem nobody, other than the original poster, for obvious
reasons, was enthused by the topic, and given that the exchange on
"what happens post Git 3.0?", I am not sure how badly we want to
keep this topic.

