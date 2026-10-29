Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261157;
	b=Dn/YRl6JRPmk9wYgMz1136kMPVVV+SitnYuu+iSS9uDItwNEnTHMxjebSlK7R48d8PQx
	 gzy2e+GHEOOg/1QSIONweWQb8hbv6+qp0KauPuAk2kR3MbHvmhgowEOOZ3egVclzZ0ZLM
	 tMspFgv7hwoUSUahwpVJfLHuJ65Exx0QGx71lR5Z8RhZvuKy3XBRNkxAzKuk4dVvdIESc
	 tVApLbFrwvrclrt4Yhg/ZQweLeEf3JJVmkv4EU6L6/+V0FoePmnaGPNPuNeBR5UgCa7Na
	 fZi85GRE11UnbJrXV/dfdaryXpf6iZWyD/GaC810hJz+AR3dkinPTtiAn+tsH2k893A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261157;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+SemXF29L/omuuVC6+TqQ0RnKzEhnQFvyjgjVqD2+88=;
	b=ZzoLZhrufxCgQoEJl3+vTD4/A3GWYm27OIk7GK4OBnjWXPWjqV8TZhg00Nv/9hIibFPS
	 DdhvREdgf2RGxkW/51RHupkBH8iZJzhQmkLBwq5/POGmrO0UXUCdKrQOIKhr2dVhsmRAm
	 RBiIF0omsB/mEb1ZKKYJE/1mmYYjkzBi123p26ZLexR2Jweuk4pRyzeo2+LMPlvv4/1ls
	 BZqoqWLt4CyMYxa2ysgNAhD8SalTQ8Xy3bPH1Uy0p6onXRYYplWImi5eS8nyrtr+v+NR6
	 wLevgZ/3OyZUFONYJfVZBIQCp/iDpJKWXT4gdaiAr0ICD+MPv9xntlqvPISEefXFk0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="F/GII0Wz";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="W1T/AKlY";
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F42606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=F/GII0Wz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W1T/AKlY
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 012101D000FD
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:05:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 04:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793261155; x=1793347555; bh=+SemXF29L/
	omuuVC6+TqQ0RnKzEhnQFvyjgjVqD2+88=; b=F/GII0WzvGBMqpp9hjkchA/d8H
	ezT+xUyqjNgsRIAJuOQaweQIlOdntKHppYeDEFqD/8OeVtibEiDLJluzvqFCzpDV
	ru0MPo+ba1zYpEtMo1tzgtpStBx3qAFIm6s4uUfOnhqi9yiO3uc33cOe8k/T8gfc
	0dR8UNaL8DOguKuVReINEj6BI01/MPQMOwAC6JUkak3c1WyJ02/T6dQUJuWoET24
	E+xyG3OGTvIKe5tigrOHD+XnsfYiYy8Dv9NC/D9BKFV/NONs2f3PfijsenpGkyea
	610YruM3B633d/+MCRl8CcFNPrdYpUm4ztjDwCfF5H73TDvc1HDJhmWiZcbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793261155; x=1793347555; bh=+SemXF29L/omuuVC6+TqQ0RnKzEhnQFvyjg
	jVqD2+88=; b=W1T/AKlYYhsYFEHYAnWrJ0l8u0u0m6/BntF1YNpj3B8ILbp+T62
	+D2xmkyvhJmZjwvJdzJk9utjuqAvV3PG0xpmAtQa9KrahzmSdPI/rxZMNRWV2fnc
	EssL+uFn0xOD2QYEkJBSqhsvLjI6YLQygp5l4OY1QMo7HcZEtwCzhrJXCewkzuHx
	myclTWHs1P19DHywaoRe6cyV3VvdlSMXQiBL2itAOPZAsFW5acgMURw6/aNw+7bv
	zmU2tSW3Ymfp2ncB+uhjtPHBJYcm7ve32SLwrMreqhzlz0HRKuFheLkxGqdjJFF5
	kqUASA+ZCNrhDCE7kLyKo4XWshiplYvI2Bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793261155; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gNYDFO7y6ypWVmd17FOy30AJbmK1MDFLc4t4ueiJ4x1kmvC
	QudCX2gmRdKyLBNt3/m2+nPRrvyHGC/qMkAImUwnS5KvuITL5lBgVX47JNVtfYgz
	Fqusb6TxZh1V1rbKv0iFFd6ds6+Jl5NWZCbNdf1t4RYIJWTPzCwlvxHQKpf8II2L
	GgKJlysM+/Cprtbe6SYMAnYM380/6GIRSLFgbTFrOBI71/vALIkzNX27LW15Tw5v
	B8rzJ8/roRHcxjOWuIdHN/YXjTEDrLufoi/Ag4m7Fkdz/gab0+g5Jgfs7BIBaWRB
	rSVIPY7Gh03jisbXVGQVhd55/1ma7GKUXcru3JA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WlD4uKmiZ4vkzST4JDhJv5/RJmnaKaKyCGLnpYJTXmY=:M/iJ6X+BI+DhxyRZYjZHCfwMoGvKRxvb5c4zOMKJuyw=;
X-ME-Sender: <xms:Y_7iamvL66h2bRZoP9iOikaEo4Myp3A2ZzyocV2pdo0o8GoEp41toA>
    <xme:Y_7iahdeX-4plBUYfH7yRfziALmeYwZyAmG5RHnftJfrHhx-zmss0edGp3iPEjXL7
    wB6o5CijPOAkazSYNy4wH_YcjTcBnwsf1iAmKkShJu8Xb9GCUV2N3g>
X-ME-Received: <xmr:Y_7iavavoBAO7Qhck6cFJlfEuG24KO2q0Hj9F75siinqEbl2H9luhw>
X-ME-Proxy-Cause: dmFkZTGHC0ij1QijoNMMYRB1PJw9ihfhc/Ds3RHOk0VoYHbwJQEoYtydlvIm6PpZBd1zYc
    nZpes/FB0rhrJVkJMyQrN7WTc2V6G3IZie0qjeVCGdK7+hRoHoH7cziSOkBXTbWRY25BlY
    Jtlfp8wktF8PRR4A6cwBwhI2BCOLwY7XeoMYqbb6DmcLyw1cDrZvDVWBqMGjMUMzAe1OVZ
    VxScDNRe7m1dNZslxdK5vvESrvb19YI010lcozKxs8IBJ4+lF7FNoW0hlSDogKneBwKqT1
    3NNDu9ExpbE0YL8KQApr82PPlqzJptYcMFQNfDJbBaIEL9k875BWuznY05iMmjQP6p4hau
    duNXCtBvXVWCoaWCZ8msb/qD79/9AyEntxTlK4ZZ8wtHAGjYO1Pgjd4ZZXCMokfzOSc5PP
    VRNwKp5zaN2fjfE0v78QgmJSww/6Vs9f5AV+Z6e1QAUbTyAugQjcpf62JTH3bv4VQ4Dg9J
    GOzSoM5nFJttxgjKHTN/aqqXCKiCJ/QQWLXRFVDCr1hmHFfS/WjDr3zU0GS/w4tAAdPc+1
    mdo1oAvAVjaaUBKuccRaMoic9hAiiKu5nHOom1K3XolkXAah9HW7j+orHWrZ1j/NJ1NDUD
    gcJqBkne+UIWkodf5FDSHxkulc9PZx5CLVdk+bM9L+uqIttvdmRsgMuzPDRg
X-ME-Proxy: <xmx:Y_7iasU4JCX8df1Ya_ga223HYyo9JuLLEwOKYmDQbGqSxP1ulV2EeA>
    <xmx:Y_7iapinz3DCBpyDaP4VWCjbNyq9SdM4azDnnCSMZdGFPZLy4eOMzg>
    <xmx:Y_7iaiXXtIaakZV4wR9FGHJwQPVYWatF7aaTXDsKGr7b9q8j0qi8hA>
    <xmx:Y_7iaoOL-xsW7F6IEaUjrPfdx7piKb5rw1NOv7fGMrwMzCu82G5e5g>
    <xmx:Y_7iahdFhKH9ZBrAofuwbT37C8odBi8rv76Thw4D3IywyI1619l2MR9f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 04:05:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06feb8aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 08:05:54 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:05:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] loose: lift loose object index writing logic into
 helper
Message-ID: <auL-YMoeDgx3wEv0@pks.im>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-4-jltobler@gmail.com>
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
In-Reply-To: <20261029002413.3291184-4-jltobler@gmail.com>

On Wed, Oct 28, 2026 at 07:24:12PM -0500, Justin Tobler wrote:
> Writing the in-memory loose object map to a "loose-object-idx" file is
> handled via `repo_write_loose_object_map()`, which always writes the map
> into the primary object directory. In a subsequent commit, a separate
> "loose-object-idx" file is staged prior to commit and must be
> constructed from a loose object map not attached to the primary loose
> object source.
> 
> Extract the logic for writing a loose object index file into a separate
> `loose_object_map_write()` helper function that allows callers to
> explicitly specify both the loose object map as well as the file
> descriptor to write the entries to.

Okay. This commit is essentially the equivalent to the preceding one,
but for writes.

> diff --git a/loose.c b/loose.c
> index 5f72c644f9..f2e111c25e 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -146,25 +146,17 @@ int repo_read_loose_object_map(struct repository *repo)
>  	return 0;
>  }
>  
> -int repo_write_loose_object_map(struct repository *repo)
> +static int loose_object_map_write(struct repository *repo,
> +				  struct loose_object_map *loose_map, int fd)

Curious that you're using a file descriptor instead of a path as you did
in the preceding commit. But I guess that's because of how we first have
to lock the file, which we of course don't have to do on the writing
side.

I guess we could've also moved locking into this function here to make
both interfaces match, but maybe the next commit will give a hint why we
don't.

Patrick
