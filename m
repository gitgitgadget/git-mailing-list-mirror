Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793070978;
	b=ZI4dF15mn5uM62yfgV7MNY/Ynbh/xpD3Ls7cw4N3V8paZ5JkN0h3dmrYOkc123wDR/bm
	 gOaIP/93SSZJetQ6CQcBqoZt1XXWOQfdhu+Dn/ygzMf6uSzbHU1tfEHPn5ODx5FQs34fy
	 Ya+cV9qCYQ/RyHPhC8dztv6upw9aj+uQCUxwBcplieFWnRrIuNMujIkANdLEp92s6Ag/j
	 F4z04X6g2HPdoXhqN2dPvmWn9MubTS+HTZrTp+b/8otYJseuYHe9ss+YygjGr44NlJtQ7
	 0ICNW7Lhc4ZJhVhrgi1dXH+k7QY2DqxqrCxDxMReRy8juZcZklAFA7ZHmtMmMA9mooA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=AVHnYGhkXPX4T05DJbL8k3proV7ETmyNvRLJHyNcEz0=;
	b=FkO0aL39z93nQYW55Kagg8OZDZj47YEHRYiU/3EQPHGNouVsfKpVfD+/5edt8/iTeXXq
	 oFkJWqfPUIKLdb5sdCjNVgSEwWbFBOxeyQDLB9hj7wPTKL1DKQaL55M8zBccqsHA1qj+Q
	 PTy9CDiNmE3oxliwKZXBy/lO3556GPd5LhNMzGBPYsKAVxvuBv3TNV6Tjm9XYfVkac3U0
	 oUF54JEPt57uDmjU4n8gri54hkymKFTzUsRdMAQIWwta0O6bRUsZdrb5ZRopi1TtbdlcR
	 PKaD+LkQkDa1YnDVGDEqWbZwvqCHc8AfakNzgDGt7A7kqHprxudVPZxRTIOylMF96kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NGp9ZvSd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A4606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D17A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NGp9ZvSd
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c315869241fso476705666b.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793070976; cv=none;
        d=google.com; s=arc-20260327;
        b=kxDIk1iwBRoNJVXo/IBjXLZRFZiBZJii7dTn65VwwU9Tv4lJReVYjqzFpVk8KfHVY/
         BlVOfAJYPS3hGwFhqTvvsD7s/8OBVynyyQS45Ofcaxed9jSU5/D42tIi+ZSc654Ex6jn
         W74b55v0oImr71vRZMgwW3wj5IRc2MRUn897FulkzgGtlAvhbdfVlGkdLcadWsmix3Hf
         TwLB1G5xEyso+dGJeUoSTfkNAtz7GbaaO5v+G/9sCV2FXzDiFpCl+i5TR7/OimOSqUnY
         4Fyirz39EZdixTYWSlkdBLoS4PU9DUNE6MmVc+UI6zDucjm5E67nSwa3enlQwxQ4DVSO
         F9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AVHnYGhkXPX4T05DJbL8k3proV7ETmyNvRLJHyNcEz0=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=a98GZ6pibJTv+kmxqLTZXkYYGg2lrtOxVH51IEmjauTEaJMWrxavtBAKpvlGW+ekIc
         qOzMC/m1H82huduW1XkIC2vXhT64vLwpuCzds/25KfD1+HEMIaSF8BMfG4vTJwM7MBCH
         Oa+PfLNdPZUVCpccL/GsWVfO1UiNYZxrPQuPTEpBGOy8d4fNflTg6Uy1mWVz6QKvPiOU
         /VNrALzzAEidkiOpxiyPp8t/pYJ++cr9LbxJfFFC+Z3HVvaz+FwBBhKBcCdRN8anqPnA
         SZt3qeA8H6gke4TAK9XoHS7VxdG+3gaiNr/Fz+DSH5Ak2fxS3Wu1Ct2rmYUYUUToUxpG
         A55w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793070976; x=1793675776; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVHnYGhkXPX4T05DJbL8k3proV7ETmyNvRLJHyNcEz0=;
        b=NGp9ZvSdh9JRnsmwkHe/eTNM7gzM5zQuyOdlG8AkHMfnd5e/RejKWUY9S9LGADqkJA
         /lWfPvAg1b/UBW1bx9ggaVhUrQQXr+7eWsMlGH541Wj1bTDSV4iVIVsmfmEbxglTOcPw
         WYbqMC/R8jEjAV9+PQ9MWCl6BN7FtiB6QezmKfAG0sGlm1cElu+E5axu26VyGKkulD78
         WYd1KJ0AWbcO5jMowEoZAE1KkRQWcXNqPiD9epTF0Z6bByq6FR3FF3S91+dK52PWcB5P
         XhssZPyIiGvqzBR6nNwOo+u1yHcwzUpZTR3L4QFTjGJum642UQ2WlCUWyukVfjwS3OIq
         CxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793070976; x=1793675776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVHnYGhkXPX4T05DJbL8k3proV7ETmyNvRLJHyNcEz0=;
        b=e2lca2pW+2M//uByQgoZKqEm8BRoTOfwxASRRMsO6Zy26VBqoaOBfO64cDQm4cbzSC
         N8mOKhXpUsyR+voKkr3XpzEVTDfGSWcyVru1BPgVG9/RRTDRHw71KYArlMgIk5O+VJFR
         2xQ7AFH5CMK0pcTOitgByPS4Cl7PQjsouWiS+s3k16XEOGk4GeE5NpD88YSNDY5YznRi
         44rSd2+Et0mFZrrpr8XKCAdieyI8xP0JufltqgairQeKF5tDcH2vpQBxSqSGRFY5+Cye
         3RriWCZ2UB784V2AqTAzT0uJCjFC+XlqJkbrpLY/XzL+2rNTswmDwFXYLaIqQMjYeVZv
         9eeQ==
X-Gm-Message-State: AFq9FYIrgnX8l4Ijtw0Oixg9yI3ovwlrIsin6U+HGDnImOgaycB1rcsn
	fOW5xWRtUeuzf/QGfIT/2GWNN1zijtyL5OC8OrRJmidzvLcozAH7iQh2u6I7S6WMiM5oOnSjBJT
	EMyo9FL4zUdzL7GS4SZoDqY2zBaCCaZP/nE670qQ=
X-Gm-Gg: AYBFou0wWplVZTUah4Hx1sJ4OQbwbKaAX/9AOi7uPG9TWyjcnKQ/MqMLYduWB6AMN6i
	t2YpRPP8MUfUAfYEjaPPwGmkqdMUb4WQG0+AjD9TQbes0X8IVvs0NMc13IuyOeB2uz7bD2KtekR
	x3ySPbekVGP+H9dSuk/80/vIAs1u5CMvt8SGSNMtqI2kDEv0TkDgKKCTmM0cZb5cu844dj2+GDo
	IsdgimZqB/ynkyRBfP4Uu+ePiRF1Iri9z8M/e51yLd7E4aWCOlfJwX5NzegoLjqkMB4uiwVJEUu
	tcIzdhhzxKg0ntTNuzhw4pQM5iaOH/kTdn1IJ1jm3HuHKcSJnar4v5TDyX1d03q55u/ZRPcdvUw
	zCwZLzu44E5YD5hOxzQ4rPeyld6ar8tNGKN0bHlvz+rH+oAFOUg96DjCiYbFlfkribjmYUkE=
X-Received: by 2002:a17:907:2d21:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c46bddd1114mr947731766b.18.1793070975966; Mon, 26 Oct 2026
 20:16:15 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026164536.50520-1-raaztilak07@gmail.com> <xmqq7bj4p3ax.fsf@gitster.g>
In-Reply-To: <xmqq7bj4p3ax.fsf@gitster.g>
From: Tilak Raaz <raaztilak07@gmail.com>
Date: Tue, 27 Oct 2026 08:46:04 +0530
X-Gm-Features: AclHuK87A2fPesVBNNMfntN87epMnu6bABGvI2hOfr65mOaWb9c04OTkM9zVD9I
Message-ID: <CABB4Jh3QD5-4d8+cSgVj+WbP3Uj+FHqL4kS_4uP5anepTEQCQQ@mail.gmail.com>
Subject: Re: [GSoC PATCH] t7104: use test_path_is_file instead of test -f
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> This makes sense but what is GSoC doing in the patch title?  Has the
> program already been announced for 2027?

Not yet.I added the prefix while preparing to apply for GSoC 2027,
which was premature. I will use a plain [PATCH] prefix going forward.
Thanks for the feedback.
I can resend this as v2 with the subject fixed if that is helpful.
Thanks.
