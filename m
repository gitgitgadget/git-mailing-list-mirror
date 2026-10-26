Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793014530;
	b=1AArreqCAQgQUWcz089VjgItiAd1L30iG+AHDK+BL9fR48mQAVGf5nzMoRSfOhFc1PdH
	 n9g+jMWPo4JC1JoSQPrtLp+34whJXR2NDQljgIFVVsk2MbcgLSEUaq8PgREou0hlKFwU6
	 nLofmgnWwTZ1bWKWEhjTvXIKrNr5yAIKW8HiY39fPzCZ7AdW0T4D0fQ5ub2ARJ1oRmHqS
	 2EKpYT0vWS5Vor/lHRSp95V3VnJI/Xy2HkdgZLXvDYmgahGnzW8w9PKsyUQP7wQj7oLOI
	 Ulks9gDAohT4Gd7mMG6gQEIz4Ym4GGgaKqmW+4lbOTItp4t/022SozEaOs7eVXu7gFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=TM6lrpszI/0NVcrQ7ccVWEoCVMPRUpHPO90sRej+tpk=;
	b=Hk41CoOoJ4hWJwhE0YTmj1dJ47Kdp3mujk3o1q4ufr4mLDoJ9Qfh7dr32AU3dZvs4S+6
	 kD/fVMtExmTqZT/E7oE9U/jvwA2wspLUZoVKewoMm8f5JcjyeB247rjZFv52BcToFYUNP
	 wkm0QWsuTN1GP6CDy4smTB+NiHyKQJp9ST00cGKHkPsY+yhZ8WzDCQemH2WqK9W9fuS9Y
	 JyedsBRduNrQKjCEgUiBwKLAH1RfW8wcuD6u98xLH6/XBAaq+BuNnuMPd0hmV2igZPSmJ
	 mNWqmrerQQQeLbqhu8hqnvX613/TQuVDXf8IurSE7vzSaPV7ywpXvt3kLXY1sNOgtbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iiUy5Nr0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B80606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34B80606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iiUy5Nr0
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso1223823e0c.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793014529; cv=none;
        d=google.com; s=arc-20260327;
        b=fwokxIw0QfaCoAKNvNRZVXmy04M4/+RgWF1RWIhLxnmRf9WU7nqtKaF1Kfqfgz6l+Q
         grxd9bVcqFY42MO2sqo42/vpg79x1lotQ4MesiNXAKCZd9xeZ4yxbrkyqA1wxsd15SeB
         rk4Ptb9nezgsmXVnZdic6NPM6bDkvIo+lYl8M5kITtefhz8u50UdVCTFKF0Jtd34oGQN
         iW0i9wgGYDc3Rh85nXNPKKwxyEPRTIt1qURKH7T+3cuAa8dMUF+SUHThaGx2jZJ5aqkz
         p8T5vkKBaiho4MPj1KnIm9e0thlR/3on9DwpNhx6GYN0yWGhxLKZ3800EY2vKK7nBBqf
         0CKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=TM6lrpszI/0NVcrQ7ccVWEoCVMPRUpHPO90sRej+tpk=;
        fh=oM2815uDFeV2OkG+4YpszxVPG9+1dl/C3pn4ODNyOjk=;
        b=fysPpqlEwWbVrCTRm15Y7ildRRbEYAtlE3a1mZO9mNsCpzHsEaDpMobOXwpvHUl6rO
         Meu63sIFk2A0VyrOWBWlJ6vy8lXVnk39wrbxt3nJxtQClQC7/RMr0oVT6PAf78og3hMo
         /5CuciFo2SY380fXQqYFDQClsGo2TXRQ63lW1PMEIdfsahdZMCgHG0GMNqXF9UUMUvgZ
         B6a8EOIdqpJmwoQyQuUrDcPUjg/EjJDMcQzwwN38jcGm3EkfVMoMZNzKdsvwWpWKyc0r
         W76UOD/bCi0hKcfGvK/U8Io/P9UI5eNWT9+Lhrj8vNTnoiqueXTDEKoT2k/FkeuFXuHV
         QUUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793014529; x=1793619329; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TM6lrpszI/0NVcrQ7ccVWEoCVMPRUpHPO90sRej+tpk=;
        b=iiUy5Nr01XRF8XOVGTrdAgz9Do4nt0BD4VaD1BT4abGYVG+LpLXZVZyctJe29ePs+6
         3C+6d+FyvtXQeKbAK9Q9FVoQ6o8bgEvRBfqrs0gqQ4aSNkakmvM1nQX8wQuwKNYNR2wU
         FE2BHYJH31FSdVct7fOT9c+orvNFrUGCm3rjlV7FbEshjPmnXpJ8I+/WI23gnjtqS30u
         Bqy6jE/MD+fqyScYxtrELsLu/1ECMbYIbFLDY6Ftyp8PXQUwvsHcVGqXCV4BaoTwerK9
         S7qXB6z8UaNnHQlhuy5a1CiiElSF+T37eSgjvP68063ztUMR1+2qHbP0HV/8n+0N0wJe
         XDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014529; x=1793619329;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TM6lrpszI/0NVcrQ7ccVWEoCVMPRUpHPO90sRej+tpk=;
        b=SatyzH7GhhxZJbLF92CBdksZZtOaWmm2/Ke4trtNTpOL7T39M89xWFjpiWdJTsZaI+
         5WOjg15yHiSQrAuRaMpIdzhvzRclQGK72bPiAVsZ+kNASpgdZF3NjelTJZTsJ/LyrOWY
         KAYHssaKnGbg8VrH/7aV1k2TIbhUgk+nMGtRmyDCsC/iX2eHobZNUV0wpdsZXLltNH1z
         2jml039swBk1Cbomlsr2j2Ed7e7xHIIbLYemo1f+g/lcJK4Jy+l+k7URQPXXkGx7atFl
         bi8T91enD8oVx8CeQVHx+Lmp1xoBiXHmc2o1LxV4ybSB1lp73VZ1FAZI/sWm9E5iwcvl
         v+RQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6roIeWOcMYHFcN4lNAcemULxty303AyagM03QALXQyFRbSAaU6wd0KWdxR9fpFTLnBZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPEwCJ40WKIklRvdbYczhvqTzB/dWV5t8RbfXqSsjuzgShdtRG
	tINlm0eT9Mx9vXXiwFwklVslBdYac6fw7Ki8bK16WsmCEObbI/3i2nez2xVrF6KhmjpG+h9h92P
	MuN4z9XFpEhwwgvLr3wGY0A2oLiB7UtQKug==
X-Gm-Gg: AYBFou28ifFXUFcq/OkIDSXCmi+dYs8HY6G0DTQVscj051ueP0U7RVYw1s9SfgZGMBY
	GBxfmBwknEd3bUS4kMnYc2Z+j3gi3eQR9++YSrdZb9LDqYuadByrHj+wcopIcMdzkN7PyLofvfQ
	y35qZOa335Qfjr3tXgOrh7gKhEOeE9fazLO6tVuhC7wXp5uj0Cp45oxGAXBNo77+QqmNW4MX2s1
	0WbEP6d/diQfj7COBL3uQhiJbFW/HgReh9zS/XQd0mCIVbrKJwRLx7Y9aQikvwqu/gTe8oJC2eo
	qZX1r5g0nzLWeAh10r82aYj3Zx5txONpg8KYgXnT39MieeVlGyLfBJ/UJBCK39v2ODz0uF1yyGH
	rYUlgGH5f/ys6+l9gfX79sJvCb9iwGP9AQk6ClvpKghrZ/NgSyqR1I5w7/nkuVUgDUmobGtqKcJ
	dm2xJcOgzXmWdm7iCBx/GfozVbG9E=
X-Received: by 2002:a05:6102:570d:b0:7cc:1ace:fd06 with SMTP id
 ada2fe7eead31-7ce5cdabfa5mr1618612137.20.1793014528980; Mon, 26 Oct 2026
 04:35:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 04:35:27 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 04:35:27 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 04:35:27 -0700
X-Gm-Features: AclHuK8OmKlbxzEB2FDwogRsaCXz0VMOJ-0I5lZ8PtiPV83QRVBybpTZC_F1ubs
Message-ID: <CAOLa=ZQ+25HBP5NAOQ+6TKBtNH2gSk-sH8d6DPDmxgGShowvAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] odb: introduce object storage extension
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000013d538065ebcba3a"

--00000000000013d538065ebcba3a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series introduces the object storage extension. The extension
> is of course similar in spirit and design to the ref storage extension:
> it can be configured via "extensions.objectStorage", has the same syntax
> with "<schema>[://<payload>]", and we have the same mechanisms to
> configure it ("--object-storage-format=", GIT_OBJECT_STORAGE_FORMAT,
> GIT_DEFAULT_OBJECT_STORAGE_FORMAT, "init.defaultObjetcStorageFormat").
>
> For now, we only support the "files" object storage format, so not a lot
> of stuff really changes. That being said, its optional payload allows
> you to configure a different location for the ".git/objects" directory.
> So if you specify "extensions.objectStorage=files://objs", objects would
> be stored in ".git/objs" instead.
>
> The series is built on top of c51408889c (The 6th batch, 2026-10-16)
> with the following dependencies merged into it:
>
>   - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
>     `read_alternates` callback, 2026-10-08) merged into it.
>
>   - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
>     (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
>     `read_alternates` callback, 2026-10-08).
>
> Note that these two series conflict with one another. The conflict can
> easily be resolved by just deleting the whole conflicting sections.
>

I went through the patches since the range-diff was on the larger side.
Apart from some nits, the series looks good. I think we can ignore my
nits too :)

[snip]

--00000000000013d538065ebcba3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8592f5d29c1711bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZk92MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3FhQy80MDVRQXpmKzFnZDhPRURZQlAybFJSem1HcgpJbkR0L1JCU3dl
YllSTVdNMzdRRVBGSGl3Zmxmdlp3UXJyK2ZIMi9lVi9QR1c5SjBINzZJUWM4SGtjWklscDBRCkJP
QStKZkpROVdXWndMSkhWMkRma1BKd2IxcXFjV09OMlIwOGZZR1JEd25xVW4zM25nVlNGcTVxTkVZ
M0tWbnUKQVZzemovV0t5bUxuRzNHNFdOU1ZIWUNzLy9EM2xwOG9LRUhMb2Rkb1RFOC8xdlNxVjBY
Nzg2MjR3MmpCaEVJUwp3WUNNeFlVV2pObjhzOVJkeW0wKzJ6YWNEMDJkRWsvdFRxUXRPRm9SNHJ3
T0lSZEc3WG5sNWUyL3ZaT2YzNEx3CmdRNG1USW9OeE5Hanc4UEtrYzhVbGsxWGQ3V3FHU1RwdVJD
WmtSbWlMbElTSjNxb1hsaThVQUJRRlAwbG9xK0IKbnNkM3VXVVY5NGpHb3FSQU9Hb1hOQXdTUTkr
a3UrNHduUXlweDJYZm5uQlRvU0tHNUYzdC9ueE9mc2JnVkxKVwphTWZUbWFiZitCeGNybU9JTmh0
LzBDeXdtZEFFMU9udW9JaU5waFMwem1rVXFJb0pla1EzSm1VL0FnWFovZkZwClVzQ29QVmk3N2Nq
MVJOcTdiSWhDZWFTNndJNWhKcUhJditzUDBZbz0KPU9lcloKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000013d538065ebcba3a--
