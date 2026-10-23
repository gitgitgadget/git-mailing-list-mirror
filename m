Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738238;
	b=aJYKDdQ7+xJ4FpHXl6uf9osj46jzx8+CwR9OKdeeYu6Imzed4Ol/jB3zSSYqYfHiJqQs
	 0O4SWanJy0r5Wbcmea4F2B1pT0sMc+vp3RKsgyMHglDBAVEZEg36riJlK4OtEZnrxsLCY
	 p5Qq76bk1RHTEzwJqMEj/9BNbTf+/OBxXzB3YUqQFNjjfK0BYqiR0A3OnDaFJVSBV9gL2
	 MvjyNuHGkcfqnRaD3M2eWv4hYZoS2mPUA3qn80/ILx3ywA9FqRq2oXDmqQW8ZvIkRdnJv
	 FPLCBV1imNIdLV20lQMv58bp0hX4ONtqaeXLEUYgB+W+NqgRRx4lLNIR8JsbXoPtTqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738238;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DqOgx2C9tsDeObztcsr1rLoBNwiWYq3sfZg4I5SuQTg=;
	b=kns0tjSJY6Yau67HegptfXXzai2QEHqUn6wb5KtAUvTMc18Vd/qwqRZG6Q3GWGsEO5X4
	 N1lf66q8k8lU9B0OVG6+3qlyaA2GHuruqRMMBUTxTxjA9m5gaN2ijR4aOhr3Rm4Sku79h
	 BKBCOJp0UxDvhaiUuM84t1riTqkBZ+hs7laM/nFijpiys1CZ60ZIAjjcci9Jra+WBZ3/p
	 0L4abs7gXDPgE8l3Nf8iXQ+uwq4cAPafxM6U7W8S3f8KLXyYBjNEOxcjPHRkaSL/dObmq
	 jNEqjWupwuwUIkI26/7UhRcnDzfvhJeDdLUhM5X20bJN8nZict2KlwQ3fO8ZW/gzYWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PtJKZ+23;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xrL0yG98;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B8606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55B8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PtJKZ+23;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xrL0yG98
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ACB1140012F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:50:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 02:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792738237; x=1792824637; bh=DqOgx2C9ts
	DeObztcsr1rLoBNwiWYq3sfZg4I5SuQTg=; b=PtJKZ+23YuTFWxO4DQugnaWlVf
	HnV3r5rI9/07gf76n0IPUFq+YRwS2vpSxfUFCICzvSPv3sGiwCJzt/tFFGhfFovF
	kYC/CpdIGgKcLwmyZwXu7SjW85bXAO0YaQ4qWrqGgceh+Bkc7qFDDvb794w7oFR/
	U5oz81G0btHRz4Ta2SGFd0C/lkBdT0OPCMtGs/NSlOAFFbsXRz0Lf9Go9M2OgyTc
	PgUgjJFa+MUFQky9/EaVGmyjDZ9uGFy5EhkjO0+NGxcmGIaYdJKaMbMcpF6sfPsB
	on8E1LQ+epgSHFOiW91t25b6kMr2XW0vPRejh6i5Z6XzkuBWXAhNSYbXD5Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792738237; x=1792824637; bh=DqOgx2C9tsDeObztcsr1rLoBNwiWYq3sfZg
	4I5SuQTg=; b=xrL0yG98rADQK61jXAMqie611fvu96gpMO7lw4xJoQCTJluthc5
	I8yEuXuH4PBWHRYyYID009DPXZ2GwjEHzzAVA+qYrF+KAcClJQr53C7Nqr/L4MF6
	zFuKMdYzr46+ypmbgHTT5TaVX1Ui1e75L7lD/sPSk0hUfF42ewAKehoN7jYYoMKS
	Ke3fzSrHNxvb3Vbk6GRSMFQLlXRaBq8Yl+7UIRUJ5TmqhAL3ShBpOOjMfGx3MMbu
	mvRymGUNN6nwRJPnbkL49xSNmqvyUVtbOvUABX4vMTrNj1sY0LsMETWCkgDy40jh
	iDJwUSiw541FzW838T6lNuGY9RkgUidUvNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792738237; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:otFZO03Vm65qpeMlsqeKTKbv3zVY+IHUmWfCD+AzuKDNHs3
	WpQ8d2DJhkTKq8HtW6c88r32eSAOCSpYzqK7IsDXIOcSpdQt7FXZ6YxVVUsCqGS6
	6EKO0AcpopH0C+lbR7DeOrzTu5zwo0x6dWzS2M1f1fwIwldQkw8/hYbwhjp00ZJ2
	qICYg7t5p1ZDUWaa0sE40nYmQX10hFe87i2oxBlEb0xGkta9Lx8eJ8aB3YuazGpp
	+7UCyAXayNo+Z6P2oe7LJUltOiMlUOoNGtAMP19HpF3e8KEMltRHragVB8MVgqUy
	qIiPkPq5biiHAbgH6vg7gXAmO/HTHerQiJvZLKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1wNkus8tYmvd9+2NFiEkJhE2EiG18BfYCbQiN7C51Uc=:mL95J5naYJ7hlUDBTj/P/F+xewQovWxpiZtsZafqVe4=;
X-ME-Sender: <xms:vAPbaorSyX1yOKU2PPNWNts8UHT0BKhpwIBRwYn872PqzRrw4FUYwg>
    <xme:vAPbakpA4n0kAf7RZtZTRnnLbPoc0GRF69wAILx4gShsqYPDfDb86EMJFp8YF7vVy
    TgkZl6GGeYqSgMK4W55CrdO-AgWU1G5cr77YJEqpRSSn9D8HIPAhg>
X-ME-Received: <xmr:vAPbaq3RmIOuoOheQ3fVnMxsudqs9mmxhegtPdQxsn3VrNRwlH0gEQ2-ZaNso0ochVTnug>
X-ME-Proxy-Cause: dmFkZTFw+A1ZNZszEgivYi5SCvDcUWMk9fuScCqdYAcWETZohX4cScdIurNmR0QKcK2yQw
    MiZJlxmb+heRmFvV3vlI6S+xX89GZuwYD7wC5NpgAkNDr3xck76//7NaE0mzYQfrX9JWJ2
    BYFSybdLpvgfS8HedAjaxB0uesUkeTdICEOcmHJII7w5tL0oMVSyuUBHhoZjVBRCLG7Czc
    YssU7fLXNs92DryyrtQ4tH9JOb9v7/W4Hmbv20JWaB3kAQ8F2w7Xf7/YN3opYqBkk4hNOP
    b3yqoksfmJQpAkjmAzlwJ4s4UE4KMNUEnl9eSYN00XjBxv2HzE7KE0+bHkzw1w+rXu2LJw
    rGITS1ZqUbcpm6IBjXimFaZfnyLVdPGLSFHKIfzL+JiQqaJKsG7H1R/rZ5uWe6ZV/OJTvp
    0g9cLAD3vWAp92rWs0Isjgtp4eDsIjdYb30FCQBT/T4rM/VTmjelkG20DZ+W9VKhLgzikV
    QMwd4lSB5wY/tedL8Szzu99isLXKcNUWHXMtHEYsITNp16JJFhJm3uKBsryzDSkeH1cgcF
    mR1y3nXYYUIDEWkdk870yo1NMXYxigzyHAkriaxpus0Hp6v1+jy6T1qdwYl2XSGa+fUgXS
    v1XEI0qMwmGTavj9r1neptxJdKcuyLRCQKgaK67/N+hMzSnFvEIaGcChHhOw
X-ME-Proxy: <xmx:vAPbarD9yM0fW4gtKNWzCEQF4w1p0hq-GNmXp8zuO3TXkdiFNQUNOA>
    <xmx:vAPbaqehhprge4fzpzCzKE1W2SOPrxQX5KOCFeAyOjI_VkkV-iJBkQ>
    <xmx:vAPbaojJGjYK7vs8DFQA1JWwMYr-ASzgg24vs6liE-L9SQkDrhGJeg>
    <xmx:vAPbaqqxbK9mksQ_twAwKr3KdQnFwAKsK2sqOKBvQib63ogcgG8O1A>
    <xmx:vQPbaiZmLR8WupRC4BPlRTZm9Qll-0q8fqxbIgV6TWJPWeIOSlLp1auV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 02:50:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea99e76a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 06:50:35 +0000 (UTC)
Date: Fri, 23 Oct 2026 08:50:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] unit-tests: reshuffle NOOP arguments to maintain
 order
Message-ID: <atsDuCBc5J2lXOuU@pks.im>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
 <20261022-ks-unit-tests-ignore-long-tests-v1-1-554a590d418b@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-ks-unit-tests-ignore-long-tests-v1-1-554a590d418b@gmail.com>

On Thu, Oct 22, 2026 at 04:31:57PM +0530, Kaartic Sivaraam wrote:
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index 752fb38fb3..d066c8a4c8 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -33,12 +33,12 @@ int cmd_main(int argc, const char **argv)
>  		OPT_NOOP_ARG(0, "root"),
>  		OPT_NOOP_ARG(0, "stress"),
>  		OPT_NOOP_NOARG(0, "tee"),
> -		OPT_NOOP_NOARG(0, "with-dashes"),
>  		OPT_NOOP_ARG(0, "valgrind"),
>  		OPT_NOOP_ARG(0, "valgrind-only"),
>  		OPT_NOOP_NOARG('v', "verbose"),
>  		OPT_NOOP_NOARG('V', "verbose-log"),
>  		OPT_NOOP_ARG(0, "verbose-only"),
> +		OPT_NOOP_NOARG(0, "with-dashes"),
>  		OPT_NOOP_NOARG('x', NULL),
>  		OPT_END(),
>  	};

Makes sense, and the list is indeed sorted after this change.

Patrick
