Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793961703;
	b=U5DGjP3EBZsYFfoxB+En/qWH/0ZgxGO7cX3jwfya5y11LZ9T2vvA1bIdJs3wVgKwKI1T
	 Th1+NzZ4wgmOIV1nf1Q5FtLXPS7HqRTiHo7WTpjni8B6/oHO8H6Ui3Le+w9TwYIN/Dlye
	 +BXpeQSjS+q/cgXWVifYIXPLxJPRd6JRDwb1BJjZploIUybZYz5wfhuMX8E4miYDZcikC
	 gpvzcj/RD4hWptshoB9kQm76qxgBvdVA50q9WgT7fbx2xUEHJbAbGtRdNluie7US+xJAc
	 gidGbCBnVxhkP4dEp3GmUAZYALDBRhyvrFn+kHDgkVaTbhSywklfACBZntXteGvTtrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=hpCQXpvQ8IXexM81pHFIFaShSomEXqb39OfubzZopvg=;
	b=VNXZlfJzcGqdLqhEghtsC3NTBF0e3bB3fJgKaG5WQtMNDdWcQssaQib8UZvz3tWPYRkc
	 OYMgyLAbrmvs/2PphLGi/HdmbAx9AzSBgIPaKYCJA8/GQZ08p9vqi9yOk0cCY18xAS9zq
	 5PpvrB6HXQPZgmEHKM4K60+OYHt0Bvv88NW4bjEzgYB7HR4Qrv2wEOLfB5FHRFpUoqhTC
	 j6/dWVwblqdQUWLNYDcV9LrU9+GyAa6sG4R8qaZpk+t+nET60G9Z+WOkcYV38edifwWjW
	 ikn+9ilQW9DI9tRTaEMiyXmaSYOI9tI/oDtRJNxjr7YBNP6SlJ82oaR3MnN/uwIeR6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1lz6N03;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAE606A331
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EAAE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1lz6N03
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso174611e0c.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 02:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793961702; cv=none;
        d=google.com; s=arc-20260327;
        b=l6yDBy6u9ye/87Bu+qhhVejyGAN+Ly3LicaZOLLyVJ71RcGY8WAiQNQIokYLj4m/Lm
         re/iUkufT4iHIkdWf7cCLWlhkIZGhnCJKwB6ZsRVSoZzBG+cTo6Kr0w1WHEJpuEbSXM2
         g4w614EpxAZBeZgy09zMBIajVyfVR2UX9s3McXvu34BzEQEJTIkSyhyqFPPpA7arIyqv
         2VM2f5vXclmOWdW0GWzRPmTaQJn6GWIr8ZjnI56VTWqR6BsM0zF21H7TjvmbS27yQETI
         mKvpx6bM93hL9EWkQnbkHQJrD9mmHEvohksdwGf+XeMp4N8GrVNaLGmFRrbl26iaEKPi
         /++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=hpCQXpvQ8IXexM81pHFIFaShSomEXqb39OfubzZopvg=;
        fh=cCb4DZOm74JRyuM4A1vTOA4cx3wIr6lzhUt7yB3KvOw=;
        b=e8OTJQI33U7m9U1GmgHAwpzWa/p4F2Z51Dz6ohXx8b5ER/L0FLcEw5exdyhDtvqaSM
         Ed3KmXWNhjhOuRogV51HJW5npsx81sIpNqjj5oerYrGOaKF4HAwqfAjWWXd/qo6u5w7x
         ZoD7kBCYGyOPudxwwecFtW4i8Ij1AjzljKYJAxFybNn/W5Q/bWRAVryCquTC9j0qjr4G
         Um1OQARIrZhXv9f8XAuyxkYOMu/g1aaCUGmuOJ/gpuZ1w6HHmlq7Zg8Lom0WVhgDzVAF
         mxBfa82cmB5a1A1GBfYdIKnZZoJ12x5UCKEsyhGRqB7d1q2OWaTT6LxaCM1xd8TWb5LK
         qYQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793961702; x=1794566502; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpCQXpvQ8IXexM81pHFIFaShSomEXqb39OfubzZopvg=;
        b=g1lz6N03n+RF25YUoI/PuEQGotVWeaUb2+UEVcCo89J4zpWqp0VgS21yjCyKHOHSCP
         IHbHeU7EvZujmfUJy/L4ZHL7clapog41Jfn6GcJn4E3z3SMEoqlDoQo81kWu7Totxuzt
         7vdA8cDKa9gfw1VyX2H6WeXRJaTphI46s+Bm7lfUE9mTl7EkMda+2LtEcDxIcQSVwQb1
         rVntUthAUZer278ELlxj8Jx8Pi77LZT80VI7vC7ePm979y/wtnERXrKQyA0c6Oouvih1
         WubjJR0FWxnG2Ta5i7SX81kabguUTE8gLOMcfBSe/Mjr8OO+AAeql7LeRHNhgCqDFUtC
         Qzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961702; x=1794566502;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpCQXpvQ8IXexM81pHFIFaShSomEXqb39OfubzZopvg=;
        b=cP7ZGEJtZiSGw8k9sBrX5N0vXiedJw+WW8++5OG/jh6yQqtNQSNNavR0Zem6tEBvov
         dH9eEGe2yZAW8rsohPW3N2oIRnnW7AFTqa5LVve1yDC5x5qx0wOiq1g2d/cZiP2WBGV2
         PoMStAG9k91XR+HkO7ojxr3FlTxOpybSbcf/hDYjOQ+Yk6AVx62hEpSH+MDsELrdtWtZ
         aR6OzzuR4/GR6nWSTCrTAgoJZ7/W/mC+pxklZSOIrFPjhHzissNVxCJsfDYoLeBu7FKL
         TB4Xq4ksybdJ92Ch/+3lhw6nee7tdQMvw48bphYBeFmg69EsKhwzVmBMEWe4WvPzp+Bq
         bveg==
X-Forwarded-Encrypted: i=1; AKwUvBykGwsl2YOukV5QopWkyMlMkbLoQl2Uq0NIfi4qBsSWW9lGaZkZv9DmqVGh7bg8RMTzNWc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hkiNWVs6U/W2dVl38zpfLNbiy0K5BcHKYBblDxhCYxOsk3FVt
	lJaPtinGkcHhGrhoMrWrd0jl14S6KozTuH1s2vBtwsq8tI8zlI/FpbaaHZZj2lweIUphmPnDNRB
	DZ0755vdhseUa1hmE8CkZ1xFqYDmO1W4IGw==
X-Gm-Gg: AYBFou214kQ/5TMqo0NYO6Gw9optBlp89CMQNHlu0rRXJcE0itMq6nohhRtqxRfzt70
	emv0ObcJ79cDnEPtg1kydcAIFMktNPBYsUqS+TUA/00Ped/Q9HUkWQUA8lvNlp/7Xul+lM1g8hy
	xWWcvClsDzuPl+10cBBYesHoi7vwuRVmGOfZsY4UGdb+dTgX8pUwKNwMZKaGq4U4CJOJpgJgA5n
	zRaHZXnrez/mFgT2Nk4xkoHmbiSiiXBX4HiIpf2+yl2YCo9AmqD9L0iJBBkVeoVNnxm2SDnZOjx
	ZcSFtVQnQ92sKrbDlqgQF1pw9g1nkF4R8o0xqjgpccQLwUsFwEWqCGt7jg6tGdNzkGLxuKEe5As
	h3s0B+vl44NKaqxOBSRwCdlZCQjNu6D+phQsYvoJsdqaCVChme2UNS6auuKS5gHCp8DdwqyQyJV
	k6hvTFM0Z98BWkTnVDEXMWCUMDpj4=
X-Received: by 2002:a05:6122:e246:b0:5e1:c1c8:9ff9 with SMTP id
 71dfb90a1353d-5ecc4306008mr1001364e0c.2.1793961702271; Fri, 06 Nov 2026
 02:41:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 02:41:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 02:41:41 -0800
X-Gm-Features: AclHuK-hBepxPj6nE3vc6Bzt8nq3TkW1FEgPNcThpnc_3QoBhKhMmj-6ffhfydk
Message-ID: <CAOLa=ZROTekhsC5g4vQKgCKg-akb4X0DMFf3bcfbO2k0uHtxsg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improvements for storage format handling
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000153e7065f994249"

--0000000000000153e7065f994249
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series includes a couple of improvements for how we handle
> ref and object storage formats.
>
> Most importantly, this series allows us to run tests with a different
> object storage backend via `GIT_TEST_DEFAULT_OBJECT_STORAGE_FORMAT=`. As
> we don't have an alternative backend, I also introduce the ability to
> specify a default object (and ref) storage format that carries a payload
> so that you can run all tests with "files://objdir", for example. That
> surfaces a bunch of tests that assume objects exist in ".git/objects".
>
> Overall it's a surprisingly small number of test failures, only 1105 out
> of 35000 tests fail. Fixing those is not part of this patch series, but
> we'll start upstreaming fixes once this lands. Such tests will either
> have to be adapted to use plumbing commands, or they'll need to be
> tagged with a prerequisite. It's going to be a bunch of work, but it's
> basically preparing for the introduction of alternative backends
> already.
>
> The series is built on top of 0ffa3e35c7c (The 15th batch, 2026-11-04)
> with ps/odb-object-storage-extension at 87a55d790ca (builtin/submodule:
> propagate "--object-storage-format=", 2026-10-27) merged into it.
>
> Thanks!
>
> Patrick
>

This was a very easy read. I don't have much to add apart from a comment
on 1/5. But you can also leave it as is! Thanks

--0000000000000153e7065f994249
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8607e6260147cf95_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHJ1TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL29vQy85MlFBTURoVHB4eTcrN3FaR3drSUliRGhFNgpkV2I0NElVNWUy
ZjJ4czMrbVhrVCtYT0NqczE4bzdIODhKMlRaK0Zkb05nVGNnYUYyOUVvTHpUWlJDV2d0Rm5hCnEx
eTU1WEZHVVJuaVEzUXRRZk9lQXYxRmFlYklMZlpaM3JqUUI4RjZ3ektmWjVUb3B3NG4vVXFLZ3I1
RVlVblgKbEUxTEhzYTNtbkNIK1hDWGZxRVh2cFptVFBncVVtbldOQ2ozVW5EUUZXbm9SSWVlbHhY
TnBDQkNxU0IwN0ZXWQpuczJ2dW5CS3cwMTBxNFpKY29LMHBrRStDUTh0N2N3bFk4VC9xSW5MMG43
K2srSzVSdWNoVTlsS3RUWVRFWHlpCmxiZnBZWjZDWkFPQldCWW9Sb3l0S2RNcmJTZkR2MG9QNmFq
Sm11QnZFZ1lsdGgvUm1OTFpXYjAxd3p3VnRjeXMKMURBd3dYVHFtTkdITGVremFRenp2OFJOYXdo
UkliUUJnQ1dsalNyQlRoQXhDV1hTY3RGd3lnOVVCdjVEYVVaegpvVFNaZVdTUWl6NW05TE00SnVU
Q3VLVkVwS2c0NnlMOHJ1RTkxdERPWmsyS0FyZnlTUEF6UGQvRS9qVERoK3piCnU4OVpxV25nejNy
TnE0cXFWZzBhQWYwWHR5TE54OUVVUlpkdFVDZz0KPWswME4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000153e7065f994249--
