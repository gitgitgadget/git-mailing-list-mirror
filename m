Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793814607;
	b=ZDpc3GyK/wkDubqNm1Y2pJWP7cNuXWflh6QrTzClzmHAiCg8tsMvzBA/X4XhIe47MuUO
	 fANFF6eNBfnqMkGZWnkp2BDiyLcJXh9su/cjJPBRNjmmdhogXRFbUR+Izr11YYUCG3v6S
	 bmIukZUvR+eXtKMYSfFcoRvmIViixgta+qQYJy8xMDpVHv0LTDuHKJuguL4VloejtRYV9
	 /Suey/INb5Xpx4+SBYDBOYwI/esTleGVzllouRKFeycvVXidxVceN3IIdVGUEOGGWtW2J
	 4LLjTOAm6dPn1dIvuwUF+WQo/LDbSNs2EDBmH3ovaRQhIhfmUP5nzZDnK8iHxTQGAKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=UkQPPR0k8s8VWI85tMlw8swmbVjKmaKXWzIrndprjQg=;
	b=tF6vMyn+5LGbIxxsMJNiE3ZMiCrJFQWQF8MDU9wq88G1vTdfP7X3k+9TXEc3kYvPey1V
	 zZcue2A2Jkmu75Vgv9kpw8qQPBQvNU2XPRJQU8Q8eQEjkL773ISl/zJ9i5gJWmyUjHLZh
	 hvMA4tR316BnR2GyUvvYB+/j46YTSuTbXapBWUOm4O2scj/2C9VNsP/kV0CxII2OTFq2e
	 grtJsWj3B3FKi1labschlg6VAfiGiBfoijwmrkBf4cYQv01zCf7DzoEMHBB37228/Owwv
	 Ztr60Av5Q34u02e6RdgiCnCGOkltcwUU6GlbEzV3ppHgO1jNLknvtXzFuOdzjfIzosQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=Kd44ggKq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A336083615
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A336083615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=Kd44ggKq
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4550d8ab15so153711866b.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 09:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793814605; cv=none;
        d=google.com; s=arc-20260327;
        b=D9FgX1V2OdgZz9e0i4s0vV2/Jhd5bPIMNEi4ezm+xKjtL4ImBIFO9PH7Zut9lpsnlD
         FZ5dM1DM23JflrVtm+Dcgn4SpYz5wcNkYK06XG4I6Xc5cf9LKE+/Tn2JFmoygsdbnNt2
         gmVHA3eSofAd7qge+5fd6SNR7r2Ec/3s24dJESzWA8nibpHD6dT2ASdNU69FQeb5MY63
         x37rrWVT+VAkP+tPRIvLLsBPBwzt2b1dY9bVIhCyvJWGVEs0+nyr+TX6a1iNcsNhJV7S
         V5hMufs1EUFDrHkR1r4aZABHtcPhLl4QiCYAcsE/9VDflOWaD5VMK5oQ7spdy1h0CF7y
         h3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UkQPPR0k8s8VWI85tMlw8swmbVjKmaKXWzIrndprjQg=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=SR8BHAMdM+D9mZtom2jI6ty+mzgblhZwlr92hIYUwF5YAernxhfNvF8H3pCg7rsGC+
         Q+YMhmFmMsyxG5Nb89nh3p/Ysb+mQF+piR8FD4ZuH7iFA+km+OGCdGI7uBcP9RPNcvCu
         2RbYALyyz7UgR4SwlhX/yGwrNcccN2UJC8gmVuiUbTGdsXUrnH9bDRSP2Fi7cDvb/Spo
         XVW7F91eZh0ZVvwH98tjLABe7AW7sULbFZG57mwTw9kLqc6v0yAyJqqjeycaZly+d0Tb
         ucOrVDrxP0eo/YaN/VecJYtvmiMen/STmmhxJvt23f6RknYKVIHiYZ4dr7rbrephp/WE
         lfpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793814605; x=1794419405; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkQPPR0k8s8VWI85tMlw8swmbVjKmaKXWzIrndprjQg=;
        b=Kd44ggKqBdrb6aJbdFlpedCQ4vST9NZghijtl37tMK3We56idQgp+VyrB/phLDpRe/
         4udAWrXCtIEs/KsKVEUcRxpRybOuRWUrrFOU78QEvcRYA62rh78hF8zdf8trk6hRfRAd
         PQ5LRt0p/3AeSTjjSiISK5obqkmstkVp7OX+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814605; x=1794419405;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UkQPPR0k8s8VWI85tMlw8swmbVjKmaKXWzIrndprjQg=;
        b=ahQe031HWNeRBSXvpiU0CeGhnc34D3aFkoF00VnCRj5FzhD5LcGuytBCLcu/uxu0Ms
         pOL3Ve3vTROC+2LRTsv75SouMmYfjXlJWDS8yM8gDPQ0d5tCRkExysHNTnoFzlXdSRgT
         qAF0mZTaLz77S6JbSXITATc3RxSbgDLAmRVgWn2MXC76lWC4AU0eEXA3nEZC0YztxMBU
         6LWaVpfB9Wc6v8XNbDHWWDc3DFLIcucwxbggpCcPPDwkJ8Xa0Yq6+4ViXIkuHJiYvJRI
         /tWxyWXdOtYzS1q49fy8y4rsE4C/6oQi5Rflby8u9XpawMASy/b4ciJ3Ks6qwXrnDCmV
         lHvg==
X-Gm-Message-State: APuU4Z/wXJfQlm+N38IvPGzhORMXkY/kluGua+wlDvCPkn/oZQ5JEA61
	XiRRNmEN11sn9ebRjUkJgqH8m0A4UubRLaVHYlJAVA+rLsdBf3YYn1Q8dkkzshprfrEnaD8IVmJ
	y/4qBDuHinlwLlRYy/rRLhg2uxovYHD/Wph6YIY9ZIjZ0uALWB6kFcbU=
X-Gm-Gg: AYBFou2uFlaXlbBJA5isr6vvFQsJ9jJnaO8DcztAwmTONlCJjg9A5d0Vq/dwgN73IPU
	PgPRl1eihCTKBOvr91bRRKaMt09j+3lT9MKSnav5dsuxdqQbPH8oMrFAERHmNf1HORoRibkOnpH
	kq/Q2FWAysyU7Be17O+mI2nTpdYXziU8RMMcZAAXJtYzGRZUidAJBiLRu5vL8Tl81KVrfn2KGo2
	SbinvD6jIEGuwOiUWCLYibIPBHPiaxi1vBywxTMN2m3nnmBck6g/KQRP6f50ayvk24RvHt92BJx
	ej6c3RZhnDwIJg3ofWGwiTc9N3TF/wGw734Eoi7vN7HpQaQEvIUQOVNFO6cJJQZ+IwKbn+qAj39
	KWgYynZrap8q4fO4fKoeSaV5OK3sMeEGd4vUL9g==
X-Received: by 2002:a17:907:84b:b0:c49:8f1e:af0a with SMTP id
 a640c23a62f3a-c4ca795e453mr1438721766b.7.1793814604937; Wed, 04 Nov 2026
 09:50:04 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 4 Nov 2026 18:49:50 +0100
X-Gm-Features: AclHuK_ZX1ZXyYVjAmYK9DtwrhVAUcI7DwTu4y3DjUupOeEzubiiivmUCZ5QjWo
Message-ID: <CAL71e4N4BvO=eMfO0wnJ9=gGbfTRz5ayWFZULoN1dGSF7uCZAA@mail.gmail.com>
Subject: Re: [PATCH 06/10] commit-graph: move remaining write parameters into options
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 17:15, Patrick Steinhardt <ps@pks.im> wrote:
>
>                 if (graph_write_mode != GRAPH_WRITE_TIPS)
>                         write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
> +               else
> +                       write_opts.commits = &updated_tips;

Ah, this touches on my previous patch cef2d8c4cb
(fetch: write commit-graph using updated refs only, 2026-10-07).

My only nit would be that the if/else also covers the skip case,
so one of the branches always fires for it.  A switch would make
each mode set exactly what it needs:

  switch (graph_write_mode) {
  case GRAPH_WRITE_SKIP:
      break;
  case GRAPH_WRITE_REACHABLE:
      write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
      break;
  case GRAPH_WRITE_TIPS:
      write_opts.commits = &updated_tips;
      break;
  }

It doesn't matter for correctness since the skip case never calls
the writer, but it looks easier to reason about to me.

But that's just a preference, I don't feel strongly about it.

>
>                 if (graph_write_mode != GRAPH_WRITE_SKIP) {
>                         trace2_region_enter("fetch", "write-commit-graph",
>                                             the_repository);
> -                       if (graph_write_mode == GRAPH_WRITE_TIPS)
> -                               write_commit_graph(
> -                                       the_repository,
> -                                       the_repository->objects->source->path,
> -                                       NULL, &updated_tips, &write_opts);
> -                       else
> -                               write_commit_graph(
> -                                       the_repository,
> -                                       the_repository->objects->source->path,
> -                                       NULL, NULL, &write_opts);
> +                       write_commit_graph(the_repository,
> +                                          the_repository->objects->source->path,
> +                                          &write_opts);
>                         trace2_region_leave("fetch", "write-commit-graph",
>                                             the_repository);
>                 }

I really like this unification of the call sites and the patch
looks great overall!

Thanks,
Kristofer
