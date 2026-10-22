Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792653560;
	b=luhWE1RMMC5W0A2b2FnWc/6cg06MeyER8CrJyy7ooeB52ri5anJUm+WSpzVtxCHUe3oy
	 83ArkT+qKp1gY2dYutsvifnAPVJ+jWB/tCfBl9O2rleb03rDqJBddJkjoD8bFJ+rRhNSf
	 HhTLv+QQzh/7Nwqw0EQbFF0XCya8qJHByvbUhGh6JuXTs8XuoRYGyGX9lLwnv0ZGnjBCU
	 D+TxoaKLW6GrKGddo1vXj7qV2fG/7y6WJs6o9B0+Cim1/nwo2QLxSm/tbuQCgK94YzEOI
	 DH5MT0ztw+bvSLxkj/flILmLcj2/PR8yPw2sP8qhDaUoUhs0eoq+w1bUT/Opc0fY3AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=O0Kzqd7d2lJEEe1503N4Vzm8W0nnNG5XHQbLEAxSJQk=;
	b=NdV/TwxkhT4OgayVM8Zv6TMPbctrFvgL2Wf+P4+VdcuV2L4uZhefsiVI0B8o/cFSWKhT
	 LBQwgmcMAc+JQ7MI0vcCx0HPMG9Rz3rFc22eCK1ZjPeZ64rRtdCeynr4EgGirqQP4fLUr
	 IXfBODG2P7WN+vyKtb+jw49b266odVZ02skygtZBb8wPuC+L0KTp0KMAZsbDp2fTl5Zza
	 P8pqmxkBDtjd1FuOV44Fkb3CoOajdikJOwZc6tmP73u7Navkt15Sc98+Yjza89ZpYm1Z5
	 sDRDsnX9r8jLeSmXaY4xdL4lgLqtARxOR/YWL0FVus/qmonofPeQV4tBndMgm4rkM9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gst7rxf2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261D606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F261D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gst7rxf2
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso2019808a12.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 00:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792653558; cv=none;
        d=google.com; s=arc-20260327;
        b=lfuRSw1Up/unQNr5LH8l/rPdT+oa+dsu97vf6NQxMQYuA9IXC8JK27V/w0jKH5hR5t
         3O5Dwg1Sg5DiuoxOtXYxObGlpZzX2lVdszphN8ptK3cwwRO70lr7liU2Vx85I0nQk8w+
         ZzFoKEavb9F9k375M/MrhYwXB6m9Tb3qlykgp2DDWP4iiRISK2zMr5Sjy+nehmQXz1Dk
         N6SsGbJhNdJ1iaX579IV6PSmJ+bAlzbZT4QvScRSTqXHSsRZ9NA6ZLmra4dQbe5GGbMU
         hoLAtMFPYfzYodyvO8yndZO7wtriUEWcxlGvZ9Vsuj+kAKLjxGCl5T0BqwGJSANiuedz
         h9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O0Kzqd7d2lJEEe1503N4Vzm8W0nnNG5XHQbLEAxSJQk=;
        fh=nCSmBUdXADq4y+FUe5vgPB2R1D2D8oqnicP8htLWWSM=;
        b=MPpzKUMZwkrc5O/yJSWUTXLfzVZ6s1WS8JKPBqDoa7ne9xhxt1M/6rdDXCpVpu0zaT
         PPM7gz7Jh1WY2HxV1cAClPnpn0YN8v+xHsVISc/Ne0Q1MHJQZtbAZ0DwA3j8at+7s5Us
         8ixDHQo+oAAw5qkayL16QafpnX+0YviLbHMSFFReNmVje7UNE4bJxoLKQWswOrOI+DqB
         IHZZsdU8lRYkckdaFWwemdsmoasLZxBmVHByyPyHvcVCvfeIjRPwD6lnCKe17hT/WgLn
         Osu+AulNnx9fL3in0UjihVlNqSZUP+qMv2Sj36y9nCprBX5JPpm0CIBammIY/ZJe4nJ+
         G70A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653558; x=1793258358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0Kzqd7d2lJEEe1503N4Vzm8W0nnNG5XHQbLEAxSJQk=;
        b=gst7rxf2RlHrXv+fbUtvqReatcl/BYlyKn1gZvRDnRrAvhzj9J6M0bqtvUjU18R1XW
         tdBhRLm4WN+sBX//RP4HX7DDAMMgYHoP381BuSD5tz8R1oSboAVhP48Z4YPn32k4u5F5
         I/R5WzOGhUg2hZ1teyEkpN6w8KN/Tcn1T5Hcjb2Nlgl+ZVcBJW/QcxxEuZMr1v6mMfJN
         xAXP2q4EG+VFN/QPFES4tcK3AHD0gkCrnolKsm+c0W9ntZiZSE7+XncqId7DTWAuUjc3
         SOncGVv359MFqM7icaeC9qvXp6hspX18QTYnb1Q93IAgzrr0oUaddW/B6cAmbp4SE6NX
         xUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653558; x=1793258358;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O0Kzqd7d2lJEEe1503N4Vzm8W0nnNG5XHQbLEAxSJQk=;
        b=GylMh0POeUZg69pyErNGoHkVBabXfgUPoUxFHtgC1qNk2mzjGrd8DRHbIHdWFmX4pZ
         2j3hOWVGcrUnCTsTZg4Y2CipmwxV5uWYapRJFNvQjuUm8jd/AD5Zgv/bWKEUDuQgx8W8
         G16Ptgqe9ZJRR+rVZnPKXlFpDGxiW6+PAT6O4YbBzT2tE2xqwbbNray3wQkpPG+ynQQR
         tZV/Z3EPP5dl6nlvmc56Dzq65JTd61stkgbRFRbW4Jtu80NBcD7/84CcmqClfE6Dv6Oj
         XcwXkq/4tRuokPkKODj7ntTV9WvMzV0sB79qV8pkloAheSrBtDrRGmoo543sQo7/lTLQ
         VTZQ==
X-Forwarded-Encrypted: i=1; AKwUvBws6aQ/yuWu1ElPr8H99i/shjU5o2ryPXPGIctrnOwAoTrZXgREKhx37ikqBBs4RahNJyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkaoO7V+yHqa2Qxthjm6HdZe54VNnvONWke+D6jnT9ZygyWc3k
	IlluAq/FeYvYRnOUtK3JGkVTJdwyeJrOO5bKqb0M6nerskqU2l7Ly/1j2M54I/FWIvvQk582By4
	Wvesw8DO4h/OmNklslKu99WIqSNB17TeHLZT/NfY=
X-Gm-Gg: AYBFou37E3ks0D4Gz9LEJjBA9fYZioJ6gjNES2YoFPeUpA4Pq0c3wFt7yNiFNSHynjE
	BTe0DIm5uGl2TidkT/WUpJiLHMNX/5LHvysnP85BS3Abw+r/Ox9rWvWqdL3JwYckb1P49xxZsKL
	7VLvUaYznaoxmHrNFlHmDm3THTPjgpB+HLtqaMDbD8AzAaIi3UYk8j+X3izNkp/j5Cq23s/e+Sb
	+ckzBz+QQjkykFUnplmHjpRhvJrUd7P+P0bWStvgQ2F34t5Rhl+s+2v7XlhSVycW0v+wr3QLB/u
	pzI+89hGPKQdga41rGcv/tJC7XV8imy0znoglL1WBClsZaBk8kULca3+Pqh8gD/04X7vr04v51K
	zbgjUxdRd8lIIv+yDV36urabWVsCdrNtw7Phw
X-Received: by 2002:a05:6402:5d3:b0:6b1:ef9d:9d73 with SMTP id
 4fb4d7f45d1cf-6b408ecc75emr3725967a12.28.1792653558277; Thu, 22 Oct 2026
 00:19:18 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com> <xmqqjynajndt.fsf@gitster.g>
In-Reply-To: <xmqqjynajndt.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 09:18:40 +0200
X-Gm-Features: AclHuK8t7LUoG1hYdJYaWuG2_qek2q9QVk3ml9mB-W3sCuDa5uNZ2e0BPtJ6eEs
Message-ID: <CAHwyqnXcdgzRnFgFhTfhQFFOgDxUUKoPf2sGViBTiXMK1aNttw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>
Content-Type: text/plain; charset="UTF-8"

> It would be very surprising for the unsuspecting users to loosen the
> behaviour of "--delete-merged" like this series does.  As requested
> elsewhere [*], do not change the behaviour of the "--delete-merged"
> when no other "please make it looser" option requests otherwise.
>
>  * https://lore.kernel.org/git/20261019044005.99247-1-me@jaspermayone.com/
>
> The attached new test illustrates the extent of damage.  We add a
> file on a private branch while the upstream adds two files, one of
> which has an identical contents to our file, under author identity
> different from ours.  If we run "--delete-merged" in our repository,
> we should not lose our branch that we never pushed, or asked them to
> pull, or anything.  But when applied on top of this series, we do.

Ok.

So do we go with `--delete-irrelevant` or
`--delete-irrelevant=squashed,rebased` to give us two levels here? I'd
rather do the former.


Harald
