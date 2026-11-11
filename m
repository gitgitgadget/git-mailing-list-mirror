Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387933;
	b=2k05eZLTCGLBfHhltlT3hs1TJJG1kwFrMh134UsFEu1gfcJeQ53pbK4xPBj53j36FqO9
	 f4+7+xH5rvGKtulZK7VOibFvQ96BreNAbB+AHpwQGNbXo61nHmNhHYUU2sUQymrD7TK1D
	 yFr1ZSs0z2OxqPk3pUSinqp7+KR0o7fb2Ewnq6QGF17wUZObGHJv/XAQSFcSt0OU6Pr0E
	 rcqw5Z89WMF/OQjm4JocHl3As7ijUb+zolndbbI7KdaHi+hFn+S3e0gbgN8vAE7A2ktYX
	 DmxatlOdUBoP8fy5VbpNfJfCHafwpZIOpJRC5kwAOfyTskWVz9GHr6uIlh0eUrUujOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uBScIktjnsXnRZlUBVTASsuVRhCcwx5Mx1D7/LgUVZo=;
	b=IHu1wuKogfB2awCINTEu+4zyvv0/BNzbWQ0AymhIS8EER7ZHmFPtYM4rO0tB7FZvq7rP
	 eUisJdvIxVwc9JpwKT8kvGk/z89McEOLDxlNCZaaYehL/Kz0JKRRduhSDLcGhcFOUOXoP
	 1BF3fgamuIU7chjrkMBRN7sV5pqZgnHn5hZvArd5rVd3h8F/whctMfrvxLzGIHcuTk+D8
	 Ctc5BcS9U+ZyMLrtEkXeet0c2hPfSeKh6T0v/umriSz/pNmpFEWH5II2bSeORUpZFwe7y
	 gLAeLLssxKzTzMCszk8ZbcdUnrbXOovIrGwkzrIMkk41aXP+BaRC2BWmpRZYtxMNs/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdQ6Zt7H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A6606A33F
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 09:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA1A6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdQ6Zt7H
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-51f2e9e6987so1818543b6e.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 01:05:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387932; cv=none;
        d=google.com; s=arc-20260327;
        b=LkrHIYz4BZNhlZcz1et0fIrE1RRiu/+sDQ1/QGsIlytah5NdJRjGTWs9WVxQ5obG6o
         J1y3rFq3EGwN5MC1flSwjgTEfY3PaeLEGTOADO1hJABe3fXzeytFjB/7HYX8h7phq4xv
         g1a5CRVyBSyleS1ZnHwtzyp6zHdING9rtx6WKGRqM+e0Nhcd4BkvGcNAAMOaS4Wkbotv
         WUBZQsra457BzMC4jmHzrgEFs3HRK5EkQW6nzbCVd76mNDgh9xEPvm2gZ3yxucq5rHe5
         Ov9KruVNz+Qb006AaZHeiAFF1ceKCsGCCGSSJ4trUPhq5Vhec4EkI1WDkF7RbH0ahmqM
         7kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uBScIktjnsXnRZlUBVTASsuVRhCcwx5Mx1D7/LgUVZo=;
        fh=eLHDC6aimbDvnAE+E4ClcOzayOjKximbkqpy5q6mUm0=;
        b=bjI2gTuNafvcwqyd05G3WxAqT5me9mhvvvHJLIf13pkCxUo46T/Le3UQvVjYdo13p0
         q61ZqiVRDHwAAuKdsODdsZQcZeLPmEvAze3v05bey1FQdc3RlHEfLkSjq+8VkF8LhtFM
         8DIJSRvI/OXt/bvh92UqXYAmkHtbYdG1QTEb86oQ3ot4lEPh9n9QrxuRJeEZKVWEOjVz
         HKAbQLyhvQEhpDuXue1NeFEjV/jHzBv9Sxw79luHH6cRSQ+wgUn+t3Cf9feevilFgx1E
         W0iXutJ9JOfUXUXRXZGc/s9vH8/KgKoxkJPUXiFyu0BfZkdYa5cY+DZsR7vQ6WXnRKOU
         VXqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794387932; x=1794992732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uBScIktjnsXnRZlUBVTASsuVRhCcwx5Mx1D7/LgUVZo=;
        b=VdQ6Zt7HodTztv/2ueuLOCBPBZllMeWMVTMzdMBz2Nrncbph9pGWOXK8scZN8Pa6PJ
         1wucCePlveQ66DgP+Fwd9sJh6hLIj41FcZEF362FvbUdsRk/igmc6nKQU8mkVwQHRso1
         Gip+HzKHrOsXsT6GZJOE4wbyN5jPGRkSl/oCScDOe2O4QRpek+eaOh4z3m3sad2RkgRt
         ZUa39ReLZN60Jj2pmP05jYJJd7tDSNi27b/lxfGq/JeVCeLCBZVT2R892t6A8bpZzlqA
         bPOl+d9MTTZ+ee4ImJgZdKtNCbDldbCyuTzaytkbtEfHEwzoaKnQsvGLeI7x0BfemIgB
         aO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387932; x=1794992732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBScIktjnsXnRZlUBVTASsuVRhCcwx5Mx1D7/LgUVZo=;
        b=Hy86N8WLXQUjHXA20OeQVCykAqJSVSE9KMzVMLKZeZ/cxcuLGQ7S8V8BAQHjHpwd9O
         oyZICOh1q9PXb5tjCrUukdzd3OCyogSvIlx7UOxd+eCbJzl86jwXMNKixwlk00UiehWP
         dDR+4mRr522IZZXH6E7tEaQ54wr+AQNDAzuwo0NeM/B1p+uPRfWzz071ZsEPd5CsQQTZ
         G1cz785z48Q3r3ZuTHPu9PUETT5ZcNdrrPwwN7PBPrWbDgkNL251yZRDGGHp6i6KLln3
         iAfkPAB/l3K8J9MyIE5yUqNzXB/AOt/kZpuw745nI3nRVx+VR26kFFAXxhWHqpU1iPUI
         3Jow==
X-Forwarded-Encrypted: i=1; AL+hErEo9himDOuL/nWe7v9y507K8LlI/e0nq5g8jKcRWHjDfQ+WFQriULnF6U2L62wsfT115AU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b8tsuJ5t9jLFbQylVeKgNv7iAFoVS9n92bkHx5QuwHfJKSPLu
	6bhdoazT4skEuaptX3+x0h1sWHEz3nPG3+zfKayx+EVsKSzgvy8hLWJurGq9p8JkCQsJqRb8Mhh
	s4qIMhfKx2pWCCJIL8I+w8sUlmYyzeVQ=
X-Gm-Gg: AYBFou1UX6jMqs6aAJhUujg5iXoMYVUxMsZBPmeiIAiSwwosrZnpQ3FwBtVCTUdwe65
	VZsrj9KGRocXwLd00LCdeYMLhtWpySmpmUcNqN5wVXMKWxPtjQM5of7S2AsZdw5dUllALaZmkO2
	th/r21t/IFpOESVi9HagC/mmnRiedjk0Rcp81sZOZ0pxD4ZuPZ6BPW19sOP5qk8rU1yHroN22MW
	q5vADqNRcZT1Nb8ggWsTQnnYi1XZ+qYo61AYzw0wnQFNo3iKJlf/m/gsUKLnj9RCRES4ZtzlYI6
	mB2RO8PHFSLhsrWweAWmsPoB7YMy6wymOajfWbrurtqHxZEP2FybR8pMFEAEYcprC6bePemWugH
	+KjOe/bAbHS2Qp/N9atFOfRhq75sfSfAVbfStAxmlCQacJhFmK5GsytY/G4y9jh477cryS7U2m9
	6Wv0eRt37aVB+R4ox5FfUNBGUswQOxFBRU7Eoe1vm2eI8GhwvKWjQgQSQ=
X-Received: by 2002:a05:6808:c215:b0:4d6:9133:cfe4 with SMTP id
 5614622812f47-5688135c4afmr2843316b6e.41.1794387931859; Wed, 11 Nov 2026
 01:05:31 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
 <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com> <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
 <xmqq5wy5zsqy.fsf@gitster.g>
In-Reply-To: <xmqq5wy5zsqy.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 11 Nov 2026 14:35:20 +0530
X-Gm-Features: AclHuK8_uOMagFlLKJt_mm3yxFL7aPV6Sl0dAzy_1zZgSfRdDBi_fN10TIj1e-k
Message-ID: <CA+rGoLfEmNJgXw6MivTrNe3mkK4OXT_t9ZCUcOHeiZE9N_h8ig@mail.gmail.com>
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, jltobler@gmail.com, 
	lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:23=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> >> >    - `path.superproject-root.absolute` / `path.superproject-root.rel=
ative`:
> >> >      The root of the superproject when inside a submodule.
> >>
> >> Personally, I'd prefer "path.superproject-working-tree.*" here, though=
 I
> >> see Justin thought that was a bit of a mouthful. As this command is fo=
r
> >> use in scripts I'd rather have a descriptive name.
> >
> > I don't have an opinion on the name itself, but, that said:
> > I think superproject-working-tree is a more suiting name.
>
> Syntactically you could put anything at the second level of
> three-level configuration variable names, but I thought we avoid '-'
> in configuration variable names in general.
>
> We can see that we made many mistakes in the 'maintenance.'
> hierarchy ...
>
> $ git grep -h -E '^`?[^ ]*::$' Documentation/config/ | grep -e -
>
> ... but nowhere else.

As echoed by Phillip below, I will avoid the hyphens.

Thank you!

- K Jayatheerth
