Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792704220;
	b=ykpiKIwBvcShI0AqyV5hDiXfehcuPT3GBe8z63TmqJSTCqOJaC1oyF8hmzdK7JcmsMtw
	 BpxZm3Rpk7xbaDifEF/Ky2zBX9myLiNhSmgitikgQZX3DSi4ng3gi68cQj+qxHgaup07/
	 E7/bqqVWG9asbmvCsJSZy4s5eKZJBDFEIt320U2c5i4D9H4BIXLr0SgTQcxxvu8RTBVBP
	 tJPtBoUNSwQRAXIi7us8K7vlk9Ayiw3KDFRn4Qvd5s0avB1zhEtTCRBhTr0xIocX23iBl
	 K/3bgsm9SI+u+juLAmbQvhcmyfs5Dtyp/81Nmh4EYn3crhdNZ/wc97HFr5qSsdmt/tQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=baXcvPyQaT+LNNuQIJsEeRRhvcNrI6NKJ2l6T8BMVZM=;
	b=5DxDhZSpLh68wLcYElvIHAfLErsMBpW/mqnr9lvQft4DEo6eVTbeUdqaXknhf1NIr1JI
	 ZRzkVS+KXJdnSDBip5k0LcT7e6ZmBlPr6wXbQ2wddeAmSxRkDXNOE8VvadvXoQ+k1Hj7N
	 2ogMCASBNV+4/ZuwC0ZiwNUYvG03pDTARRxKotpxo02zPNR5ppm/WLJQW0FqFFiaNVgHc
	 HJVFqDIEmRnoMxbwsPMMj5DHVOc3zV8XPNyVrfkob27AT/4OmaS0q4/0x/Cn11IlBtsci
	 Ybap+OpKN2Krmq7LhdojR73gr3+0felqidlgKxeRyYdthzslqxSSu8/MYmKz/IJCa+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A1QysMft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF53606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF53606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A1QysMft
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0d126f631so2715287b3.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792704219; cv=none;
        d=google.com; s=arc-20260327;
        b=iYBsW7ryeOGGVi7aKi63IdgnV7f7UTTHQ7EpBBqKIHrbsaaujs0AKaF6d2656edn86
         LVjAgMGSGkzvp72qBaX0mDqupZixh1DsJELuUb5WoR11gZk/ct+IQnUAiI7rRzdte0q4
         HNOC85hzlo/wx776nOCYgwsh7jKmqrJKSZ70EJPL7J+dLelwaL7oh/hcLoOAnpaXZkCb
         9dOheIAMpjTZtSpdkfSFy2SD9YPothny6NSnGNOJM268fn9bD21cjHzgXUh8W5tlv7sh
         /Bd2HgoAdWwSckuDP9Gt1xxWKGxDux7EfQPLeylLRQY6CQy88BNIZR5NsAWMYqcU+nu2
         fuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baXcvPyQaT+LNNuQIJsEeRRhvcNrI6NKJ2l6T8BMVZM=;
        fh=XDtuIuVWfMV6CNxiJIW9hxI0PpQ0rpxcGfC9oO9wyhA=;
        b=gSN3kw9Q6tf3qTBBNN9wJpHYTE9nZGKqk5rMgkuBK9acvwQ6exXi9QEAE27OpZCiQi
         ioWyONNjCJf0Elv0W/8W4hQ22hKYbTWPXyZky4rqoqgovjjVUlAQB31SMBx45Pg/r5sK
         Fil9jrYg8FQW8PXq+AfDp2JylFsrMfQVh5o8/hlbrBfvHKeie0UqkYob4Qnnf3DRnEt5
         Pqde5+dRYQAsXk7TZRZUvKWENVR8TH2mAmk9A9kQLNPoJSgS7GohzNwjpt+e4lPwe8vr
         JwR1O8Ibioh0fUkEjhnm6gG4GfHRid+iK5ZxIyphqDZCbyPiihUHBQvQTPuVhSE8Yejz
         fdIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704219; x=1793309019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=baXcvPyQaT+LNNuQIJsEeRRhvcNrI6NKJ2l6T8BMVZM=;
        b=A1QysMfthbFPq5EMjNQwCp4UrLRJmzzYIuFIQQ9gCoGOzjhmVIe2jbOReLqFHp1jZr
         njUPv8MaxA+vyfNl5t7Inssiblr0ZYQBqp+ANIflY6OqOTkLT6RFR6WbCFk/qX1VnURD
         I2TRo7m/CNcw43hEucwNOxUlfIUcL0NIV/wnc01gzZgRaLJN9jov4IdEWkJSWtRUtqIJ
         tUb3XeArMX39z8LH15wzna3ccZBHpM5mg+wrjo230KIIVr8Xpy2WwJE6BE7FL8kSjD+t
         sI91+4fIlbHtAzyMTYuM8pB6oNyRoITNOf3JPTT22H2kiwOeB83hGkOAuEA7YF9UwVR0
         LN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704219; x=1793309019;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=baXcvPyQaT+LNNuQIJsEeRRhvcNrI6NKJ2l6T8BMVZM=;
        b=MGbr1FmhZzjx8MBc3hWz2R+I2dNGj+GwcS+wneF0iHD0A5cBuouXFoYXmXr4kdUbiZ
         ZDac9eITf3+NI29Bmk7yYaDcfFPnueei18NjB9pgxTfGlDnOTmsTazfKETM34wdZKoh8
         oNYnjhLfj6rrXoRd0/t1cMX3EcQyfVPuO7+y/Lu5MTdrsbpTE96tWT2mY3johtBSlBiO
         2IWQT2b8F8i0a7T3oEChHfvY/4zXCI5X3aK9vmGILQTHc+tvm3UykxJG/ixJCAZh5nGK
         Su2O5jus/m/3KX06bVLtqtSsjTJw4uocHz5/q4TagW79AXK30cu/pceZKoN3uEOHZl1g
         at0w==
X-Gm-Message-State: AFq9FYKT10mimFtvgtFyYfyyrvpbMGX6wiOlCG+GlWju0sA3Vl84oxbW
	/+qtFHQk9hP5MNgltnZCArvdf2/N6Qbvb08Tjjuc77+2IR83V//apfRhsq6yGE6c34KdkuvbdGh
	hpOIfT7Zg+B3ZZ3onWoIXq0F45BqRnoE=
X-Gm-Gg: AYBFou3BONf7eWwQfQyPqp80UuN/1qMhNbWTvFmSlv+UWpZG5YNB7AX/1EZTLKUAFKI
	zY6oOHtGFE5fz/WVuUvfiagbNiAwnXlAspwGfYWXOjACpCOMr9JXMZZTdLi7W7WMXbmDTgfYJjX
	5gYlY8+ZRzPEhVKrRhORCUWAf//G52JyYzNBtGRy7Z6myEcqupffnx9AZOfKY+QbGeMQz9OidUI
	FmkTgZ4s8yjIO7jJZK61d2MZrY5nvd38a9Z/y4qlT85Uv1tVeEZUIOvVhsk9gh8zPaFSMC5WBu6
	YBa76pYNYrApd09/IzjfvmAkMXdD7UoZKNAeLuBWEG8ut2YF7BAJebliTszl/zV+NNpsyBjkkU/
	hBqUmI3qpUkOlknpBUYeUUSknqupmmZlTXw8XipKqe+DW+jPi+QrJjbBNOhhJob5uA9pL9YUl/J
	8Zhgt90QzUZ65SW1BZadJRRS8X1xMal44njCbucICr0PfxNLR7gDHi1LtASMxpWySRdlQFJwZw6
	40UFWzJ19oYusjM5VJVLAI=
X-Received: by 2002:a05:690c:7001:b0:8b0:a4c4:1b16 with SMTP id
 00721157ae682-8b157ba29e3mr3210737b3.1.1792704218792; Thu, 22 Oct 2026
 14:23:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
 <20261022105641.68963-1-okhuomonajayi54@gmail.com> <xmqqo6clfu19.fsf@gitster.g>
In-Reply-To: <xmqqo6clfu19.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 22 Oct 2026 22:23:27 +0100
X-Gm-Features: AclHuK-OTuX1KydQcxo37L7XUHyUyKrO9EIYoEnWo071FtK-RflWgDaYMj5Yxu0
Message-ID: <CAFpMFfAhONvaXUVHhkXr9KV-G5hKT2kLi4pa4qZMpVZQUWgBxg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] checkout: pass the repository to unique_tracking_name()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 7:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> The mention of for_each_remote() feels weirdly abrupt.  Many other
> things still rely on the the_repository global variable, but
> there must be a reason why for_each_remote() is singled out in the
> context of this patch.  What is it?


Thanks for the review.

You are right. I mentioned for_each_remote() because
unique_tracking_name() calls it to go through the remotes, and it
still reads them from the_repository. So the new repository
parameter is not used everywhere yet, and a caller passing a
different repository would not get the right result.

I will look into this more closely before sending anything else.

Thanks,
Okhuomon
