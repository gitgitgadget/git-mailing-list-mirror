Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792446033;
	b=kaNDi+7YGDenL7EMLV116r5j1z9GaZO4qNJFBIJ6rLjINmSSr1t7cF4+SB3fPE+fKZ3A
	 7wqx+xwoe6kLK4fWBeD70hwxS5LOwJoklOaJUCe9sUHpktTlBsXkfldA2iBZSq0MHBvel
	 717yPoKJ81d10MoHylw7SYQzI3D3EsyGYBFvk+mQeiofEHePf87Si3kkH+sWXCWpCuvf6
	 yyBPz7wmN6S4M6fh/qplMLt1qn/aY9531n3/rBVeSMhWl7KNw44NYVfr/u55m/+sAJgiV
	 8he7XUfaL835vWHPWKnMuSBs8pwPksKaCHj9f5zFWIHTLkPfKRx5mijhqJ/FnE+1dYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=nglreT2V8ftY/KGemUyPbCjHZ8sl2Mzvk/383UiuWKY=;
	b=J+D/Ex7E/JPy/pERDnH5bO6jU5sVuizuzXA4jVDdbyLswH6EHCEeCg1rNww82litzdLY
	 90P/3bA+EcgZhyxKYhbYBBJapZCIdxPkQYd0fYhNxCKiyx8iDi5tA04QBw+rni98fqlT9
	 mcDfVRucFqhWEcq/GSbiSpmYzSEWq89QivbkHr53OnUyhRsQahyJ74TuSZdQ+KvqdFc4T
	 A9HP/8MVaBBXVCMjZb0zhmZ+bhwPpzyXhxmZPK0uaVuWJqpdkym62oDYJQP8muTQHBhaN
	 G0AHWoq9HGs/ymM4AtGKL+geCIfbSSDA7YzPe3CFphwBpuq0yCbX/nMD88roS2v820g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WwlsYDXc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69318606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69318606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WwlsYDXc
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-74ab6c88052so739977137.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792446032; cv=none;
        d=google.com; s=arc-20260327;
        b=WEs6gRO7oCD2M+zv076JCDSUcwGSpSP7dg13XJSV6mbkz0xMhOvXO5tePGVPCcKC6V
         mMRphbNA3fSRh17XTRAsdXSBsxpUUDnSZop+ZCqpCW45J5AnUsE2du3TIHKsU5z9LKv+
         lbJ5AdQQD7oE7O5U/nHfFgGE0ZQoAnqlXLmNpPKfHhZGtfYuFtumTznSsOWSPSAL+Mu/
         2Ckm1UTZW6b2lPp34LlpEAPRxlWSIp4nWJc1uGZq+fRP0GERY9NYZnkfMKxtDbwlbTdf
         ijzjKMxEZEPijoV13sgqgcLh72DJfOgp2bKDpokt4se4LhuoXPXEw8TEd+D8iPS+iuet
         PIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=nglreT2V8ftY/KGemUyPbCjHZ8sl2Mzvk/383UiuWKY=;
        fh=ECW4HhYn9vkHnnNAgPRNoQ8x9kt/KXECwpSj7zRratc=;
        b=cnGsMtKOGzcsXX3qh3x6D4CUVTD7Z1k/wAFjOeiQhNdsh+GT29Uxh0KZCX4JgLIrVi
         O4ZjV19PMB8gIIiVAbMUdAUzk9rclgrClsSWjG6nMO2GdbnfTdhDVZoatbOleNF2kfY4
         lPwkbLZd4S50jXFjqOUTS2ulHvv4Aoygtwn0AXJj/jZfeK2SF2Gdb0BT1E3m1azZGroD
         8TAQZHzaBFKjp0PiaDLleEVAGenHXFZTUr0dlOFeWQzeZH713TaEOVBqGsErcfkKdKOQ
         Wa2Phg3vQGDYN4BgUZJz9lZWRbP0Y+i4EgM93B6wF4Zc8Bh+w+I6kQwSiz3V46oyrbDd
         HDNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792446032; x=1793050832; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nglreT2V8ftY/KGemUyPbCjHZ8sl2Mzvk/383UiuWKY=;
        b=WwlsYDXcNP5EYslZAwW/3qfuhZQFaHQNJ5mKHObBdx9w7+oppY95ED374GlSXOAlLB
         xdZVIj+13d03hoA+n0hFFGPqUR6EYSkbwnEAPEq/jGM02BLNI9Uan/huEXNuyGQMec59
         16n5mDeSsr2cxfgA7ROJQSpvmy81v+qXrwXaYu5TSrHE3QE/4gWgm7QqHh9aNcf+J1HF
         R7leNrh2OSEH/n+xg62bp0SBB0w3PEe/m5uKXdEM5jiYUA4zsIHCLBRT4tNYyXueKMt1
         PLuD+9div0aNiwkAu1wlAjf79bGyVxXwRUFwnFs7Bb4ql6ExOLkH9BgsSVkb4RDLbJrb
         4HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792446032; x=1793050832;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nglreT2V8ftY/KGemUyPbCjHZ8sl2Mzvk/383UiuWKY=;
        b=rT5ofXi2I7jdL6jnF/nAbRnZbUBubTjpUPAelB8UYRQ/rW9Zt2hZrvfx3SWIyQ5F7D
         BPxK6+Xebe+cLuUBh6PlCN+6LtG5kK1uvmvhqTRxp/ZV9LHHI0IQcZPs8AdH7wAk747f
         FXSE3EEKbfJRw4VgB5ZHBWPoA6/imltvpRR5K/gb9czXlldM1yA4LrfPZGIuk88KxYkB
         tWMXTW3vXMpmGo7A/K8iDEo/W6vJulyf2WEyimsacefStD4rgjp+sx44x7Um/19YazX+
         hDpzucUaWJ0a7YS9fyncJ0C3oXnpFQNfyLc2i5RMZDeHlN3tyGwdJVaHTiuA48F4k8UI
         qpEw==
X-Forwarded-Encrypted: i=1; AKwUvBwgL5lnA1BUBMAD+K/Cl5DC1jYJxorl8nU0MAhZEaJlxksszQ2mgDFpgRj14r3UxS2UtRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgG8DQV65BfA9SxIplWs9bkKd/54vwIhCZmd0DxEpqJbgb8jHh
	Yv3oViBc+7uP1MU+Aa+5BKt6hzT/OdqQI63leFTCOyEJDsh54b7yr1s8tF/GrE1d0zKktFD3YKy
	NVif+zaSCQMstJkwHbJIr+k5KgnaJp169Bw==
X-Gm-Gg: AYBFou3OXZLwQn/85YhPFrJ/rtv4gCXnWJvt3/U0/N9Y8FCD47AgakCjY+LC9a3T13m
	/GGWlzmzkjJk4V9euJluuWsenfBcrhMjVPRKRPFL++TLo+5CwtyDDeo478Gg5dTnQKqo+lOiaTl
	vm9LLZKKgkVA2789zR4COJku9z1auRprr4KeZaEjl6zfn4x0iyLxdz+/pkZYoDrFR0E6pH33VCX
	RN0LLvDjA2joZ2QUzqPGsKP5p1vFo3SAdRSjrcf+A9wLHmA2A8nEBbCTkROOI4SHj+XIh4Y4PhI
	0FIJunHHr+Y3lhFhTuKaDR7drhgSYZIwdKiIOWTmp9UoZt5bYQybOSWqwlraHdkqQ45jIL9gg8/
	/3KRTeK+jomki32dBb4R0CyQdID6DPtJ0F/Ld3QB1OsKC4qc=
X-Received: by 2002:a05:6102:374e:b0:7ca:e2c1:9a09 with SMTP id
 ada2fe7eead31-7cc369e5987mr1886997137.20.1792446032299; Mon, 19 Oct 2026
 14:40:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:40:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 14:40:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-4-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261019-b4-pks-odb-extension-v1-4-143a5963b77f@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 14:40:31 -0700
X-Gm-Features: AclHuK-fnABmAC7TfIlVjLqVM6IHqFeSXCgnu-iKJKdvO44YfX2qqFnZVyPKE9I
Message-ID: <CAOLa=ZQ1E5sg05++KCXgbM9+=4=vFeCHU-5iMbNEGRuS-8+aPg@mail.gmail.com>
Subject: Re: [PATCH 4/7] builtin: expose the object storage format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000008e6dc065e385df9"

--00000000000008e6dc065e385df9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The ref storage format of a repository can be inspected via both
> git-rev-parse(1)'s "--show-ref-storage-format" and git-repo(1)'s
> "references.storageFormat" field. Introduce the equivalent options for
> the object storage format, as well.

[snip]

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index cb8c1e7292..d2dc9b7a69 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -105,6 +105,12 @@ values that they return:
>  `object.format`::
>  	The object format (hash algorithm) used in the repository.
>
> +`objects.storageFormat`::
> +	The object storage format used in the repository, as configured via
> +	`extensions.objectStorage`. The valid values are:
> ++

The nuance between `object` above and `objects` here is too little and
can be confusing. But there's nothing we can really do here.

[snip]

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..da11a56ede 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -128,11 +129,20 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
>  	return 0;
>  }
>
> +static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
> +{
> +	strbuf_addstr(buf, repo->object_storage_format ?
> +		      repo->object_storage_format :
> +		      odb_source_type_to_name(ODB_SOURCE_FILES));
> +	return 0;
> +}

Is there a reason why `repo->object_storage_format` won't be set, I
don't like the fact that we have to expose the default object storage
format outside the repository and odb subsystem.

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index ec33c19bdf..b206944ad9 100644
> @@ -1138,6 +1139,12 @@ int cmd_rev_parse(int argc,
>  				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
>  				continue;
>  			}
> +			if (!strcmp(arg, "--show-object-storage-format")) {
> +				puts(the_repository->object_storage_format ?
> +				     the_repository->object_storage_format :
> +				     odb_source_type_to_name(ODB_SOURCE_FILES));

Same question here.

> +				continue;
> +			}
>  			if (!strcmp(arg, "--end-of-options")) {
>  				seen_end_of_options = 1;
>  				if (filter & (DO_FLAGS | DO_REVS))

[snip]

--00000000000008e6dc065e385df9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ad6f5843be259439_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yV2prMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzNEQy80NXdKMU5TTW5HR1M4TjhkQWNZS0NBUU9GdApxWnowZnhxWllH
YVdQbXZRUzhHRTBldDlLTGt2clNQZmJhRjcwTXJIV2RvM1k4Q3RNckF6dXIxRHorU1NGMGM3CjlS
U29rRGFmcnRMY29EcHVOMEFaMEJNOTJqdUhOSVhuSkRncHhZUlNYZ0dDZ2UzZGVRK282b2tGczF0
UVZUOTkKQnFkSVdmYnhZSDhLS1NEOHcvS2lNV1R2SWNIVmxxMEdoRkd5RnpkazdIQ0dKZktMOGdM
Rys4eVg3dERMM2VreApWbnRCQTA2UWNYcW9MeTNZZHhQQ3RtaERMVTl0QjVMRDMwYW92Sm1VS0NL
VnhabGxmd2taT2hHRHBOcWVEZlJUCk5WQ3B2L2hrby9YVUcySThpemF1cy9ZMVh3QmYrdWVma1p4
bmVBc0NLTjVuZGpqclByeTJyU3FGZ2Iva3J3REsKT1FPSURxMDlFWUZqV1ZpejRwSUx0NU0zOGdy
UGlRN0RyNE5TSU5iaWxwNlh0SVJoNjVzZWVRZzFxU3FhM1JEdwpLS3gzeXdlcWNTOHNXRDlySytj
NllyU0Z5NXRCejVHN1Z3d2EzbDBiTEZva1FwTUkweWtMNmYvT1craXpDbVRxCmxMU1B1UnlsVFN0
cTh3b2hhOEVTYjArN3V2Q3YwK3lmT1VUTGg3bz0KPXZoRDAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000008e6dc065e385df9--
