Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D717164E
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481910; cv=none; b=rn4kLJAA2FZ+Ogqf5nKtaIYAmYrlNoIczKp2cJngpmziiLTnp4TcTnVei3lpzGWk+yC5j7Z4XM/mupGwhT9lA5EgOEYJ+5iasxxPPur4dPBs/gTABRROntwZWUsCN1SGJMBT0f0QfhpTbuabRDkuu0/57iddweJZ1NtLddaDi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481910; c=relaxed/simple;
	bh=1pGBQsNnOqIvGMusn2YxQ1q2I9Nwf/bF0w5B2q/5DaE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSmO9qjj6X2CcwWv5wNzlAzIc/+U/Uj50zW4LCd6thAXEFnoCjWQAv8Bc6vjrDK2emClZppZLRDBoKCtpGoLy7Fm7QY/04zh4k0qWAiOJZaaWupe0OD2DmPnS0afMW6Sqbckezgbhp9Iketk3q2W7+frPvEAj6Xv79w0Qh+flR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBL2KlCW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBL2KlCW"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2395e037342so3385827fac.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481909; x=1715086709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pGBQsNnOqIvGMusn2YxQ1q2I9Nwf/bF0w5B2q/5DaE=;
        b=aBL2KlCWfI46QuitWGOp8vo5Vkr1GMZ7pQW2KjbBSBza694cf8qpJc4F1mgz0gbfwX
         1DVJY249r1iG4fkedDc5FCSFisQ/PZIl4JlNdHP4RxvAEmxLG5plJVdZrtQMNypsEuLl
         GnloVWaaKaGcaEWNyCYSWxtZObljvydr9YQuPLVjPkSdcYz5F/hX4IzFWppgdIqLRLUS
         uuSn1oLjkmqYwA95JVKcizs24A6wJqtYIjsxi5in1oHbqMzsUqTcy8RVhFm0zKWYPvyI
         I5A+LnOtEdNgr/awPkTJ8xzmEWEA03qYvJI1Lbbp06nqHBESttfMctu7xHdkDvLpYyx3
         THSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481909; x=1715086709;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pGBQsNnOqIvGMusn2YxQ1q2I9Nwf/bF0w5B2q/5DaE=;
        b=RkI7TYNrYbY1tlKDuPHTJUc4ewJccqdoa2dNKnnxdNeK5eoorayx74j0kvd3o8F0Jk
         zAjRh/zdzSiv2vFaRgAc3y8CmnMZa2dw2O+rq95ADVJCm5aXiLyMyLQox/0knCrL2Les
         s4g1W/TQsldBNtDLyEjXcYZtCUCYeRRex9GQchMp8P4ohpxc8R/mL4yah6epr+TMG+56
         N7Mnd5gr0+4kY+2BFZfajWnEwioaUn4GCeyaccjgcFDvR4rRaD92czirEIhY1x/fKrCd
         DYK7b2XfGhnQDU9MgcmlxgTX+h8OakwXMKZih0AwEHSnmg8EUiYGKnXllqrUzmJ4lL9g
         VDXg==
X-Forwarded-Encrypted: i=1; AJvYcCUwnOu6v5CG5mCTmakBAuzdN9RnkeHmsUoYlXD98ve+vZcwaXwZ5MnjO5OrhZFW4J6fMCfsMtd3drozmhJbbIvpVY6e
X-Gm-Message-State: AOJu0YxKaVp2sYg2EjPxSHVqkllgbqEU9xD18UZapAhGdduKazA2TPrl
	GhaBejWDshOxEoVCc7wr9synOyqrtTqudFDLZ7WNNg0ynsbI1GHv5kObuS9DzR2aSeC1Zb4hCLB
	APhDES8usmn9/ELB+Swzlvn7BnHQ=
X-Google-Smtp-Source: AGHT+IG4KMdeL3vlsuIzBaO/rZdWexi6hRxk7aHP48nZpu2xX/9zOU1nembD2ImB5OpA/BqGn+TTjXwun241ckeeZTI=
X-Received: by 2002:a05:6870:b293:b0:23c:58fe:5df5 with SMTP id
 c19-20020a056870b29300b0023c58fe5df5mr3112520oao.14.1714481908803; Tue, 30
 Apr 2024 05:58:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 05:58:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <e6b6db972d8009fa2a4e17f9b46e69d94391feb5.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im> <e6b6db972d8009fa2a4e17f9b46e69d94391feb5.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 05:58:28 -0700
Message-ID: <CAOLa=ZTgsH-dvhmmohByaujBoD78kUQDi95cE0Bs9a7nziZKrw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] refs: refname `is_special_ref()` to `is_pseudo_ref()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002605fa06174fed4b"

--0000000000002605fa06174fed4b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Rename `is_special_ref()` to `is_pseudo_ref()` to adapt to the newly
> defined terminology in our gitglossary(7). Note that in the preceding
> commit we have just renamed `is_pseudoref()` to `is_root_ref()`, where
> there may be confusion for in-flight patch series that add new calls to
> `is_pseudoref()`. In order to intentionall break such patch series we

s/intentionall/intentionally


[snip]

--0000000000002605fa06174fed4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1a11c04b2a0bcff5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdzZ2RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVhLQy85ZDR5RmgyYms4S2wxRmwwUDFLTHNLbmI4Qwp2TlpxT0lERXh2
S1pFQ2s2eVFxQmlSM0dHNWk1MWp5aE8yOThrNUZ6UmhncW03U0RheFQ2dXZNYkVUZGFSWWxuCitE
VmFXSjl1YkI5NmFtMk9QVm1wUDhTa1d3RkNvOFZkK2lNZVZDZEI1NVdvTlRldCtnNjNPWUF5VjVu
aVNaMjkKVnI4MUhZcEJBaENJRUNaVEI5TldseExXVFJFSHFJOHNNMk5PdWhvZTNKc1FyVzhWUDhE
L1RwL25aOU5XWVhNdApLNmJBRTVHdWRnb2hKbDJrYjM0a1hHMnhDUkNQYmFpcmFadXpkMkhOTWsy
aU1vUVk0V2dCMHk0WHhDdDV4aHRsCktOT20zYWpjTTlPZkhFc0JkT2xNVWRUNnZnb1VXWFpDL3Z5
bWtWWjZUeXh3T0IzWVhLeDJkWExhN3dBa0lMeWQKdDFYT01QalZRQ3ltQkR3QWEwZjdxeUZDaUQx
MVozL243azlsb3FzSy96L2txYWFVKytNUlNjRHA4MFA3anBqZwppcU5BcmRhTENYY3dudjA0MWRF
K3pLNW1JOTBBVFptSnZLdTQybHpwV1R5NjZNQ3RGSFJYZE1uN3UzaldTUnZuCkZqbkZFZVdqb3Zn
QjBmTDRFdUtzRmFCUUxRTFRzOVh2N3RyZUo4Zz0KPXJmTE8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002605fa06174fed4b--
