Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793434250;
	b=DW9gzyi8vSa3th6jmEKPzs5IBGuGSnsC1PeYMeYqh3nT6qu27lLvM9njL6pu5WZMJ9fT
	 4LaWSjtAaehOznPcrDQ+pSnA3nJ5Fa9m3o52USAl/A6i9DYRWAaxxLbNRuBBdTElfza1K
	 Kvqh6eQvbjyNdEhyT23hf3teIqkkeQAP8src7bl4qmZ0+Qh7j1q96dyDftYGh5kFVnkZU
	 u2IJFNgqjdk4pAdEg+F1rsEGD/obRg7WCwqdTXpKRWwkURyHEqsVxG0SsCgRhFyRmMzX5
	 DbVATW0n/8b7E5HyqwLolx+6ntONjA9Hc1atuZFDV4dtqpkRxO8ODiBbcf4pBJ5s0QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=i7aoxFJS4kqwxdyET0BAIfs5qvlExtsj7VKVa0z4TOY=;
	b=zzgz8RlFMSVD5tiwyV3MakxijJGAHq/F2nTarrtZZyreRqOB+K7hUMO00W0nQv1f+Y9J
	 yLWRkKSfQLkwqOfCo6DgZJje6U2jeYj67UXvxOsTBSv3HVfZ7uEl/RILSVPR8X8NU+jff
	 y3GzDzE++q1CI3o3muR8vA54NtJa1TOnT0gA/Wv8ZoGnOCA5TMEh7If5Iep8q8PnxFCVD
	 9qsCmanU1P1qIa32IhRrCAO/VmXaEo7Bx8hTS8Lw4/7BF3DhaIJyCyL/sGhtoeaeeNSWl
	 jfasd4BH3CVHcSR/sJ3rdB71yrcsP+w+HOwNPy425vzWj9OIOs1sjd+cAqaQ/epdm5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAFKnr7x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C668606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C668606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAFKnr7x
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c40e30c26a4so518109066b.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793434249; cv=none;
        d=google.com; s=arc-20260327;
        b=msH0qgf7jrxoquU+uhSP3yk+HRUv5je8bbnUMpUK7Q1FxJXzB72qWSmRs/9UnwVQxt
         XKHrVLUTJYZJY/UGDmEFvgJjLKuBs8z9JNH1vhbg0Pt10gqBV9C7IAVa8X58pjKJovaD
         JQYdY7GAqyBSADUxnD71dbVBNoO9vYL5/C0t88RCTeVFPkjOuwl+qyy41DqEJe3m66In
         soc3fX6DhUDIZ8NAQoPeJ6AJ333l3ROOZ5hGJRLfUpLqH3AgfPz7pPxNpUqHgP48fpMV
         yIBUSob0Oc/15gAw9kx7bNa0NHEeukmppSKoQCmQYe38jcYjMQsMXiic4yP7iAHHg0RY
         ocCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i7aoxFJS4kqwxdyET0BAIfs5qvlExtsj7VKVa0z4TOY=;
        fh=B0KYd0QitrqsYM7EQ8ZalJoX3xmwYpGNT6cKtGru3Eg=;
        b=aeSslFPNR+6ggzShRe5fo0XQhEH2O7gvOaLRP1Gb4DRjKvr0fvMU76iuwVym/o82Qc
         GEticHS9cpHs2jn/+Qm741xHfO9Y6lZsdgPkHiAQU2Cf1rBUcI5ABpLm60Mmxxd2Ttnm
         4Z4wZy/i+vu60yZCztBCfvpH7On3f+r/B90+l+Rufe+P2BXMza3M2Lo10FtrWNQWRiiB
         C0QyTgX0OvwpzeSsz0QSzDIvQ1A20q7fHY+hf4TTWbVewt1lJcltYu+PHs5cKD8z951l
         doYraSbzxZ4sv6DU+Tela6z2kF9lz3Df5CsNVBaeDmYcSI/C+8d4YmD9MsaFt70Y9xku
         fKUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793434249; x=1794039049; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7aoxFJS4kqwxdyET0BAIfs5qvlExtsj7VKVa0z4TOY=;
        b=ZAFKnr7xeYtJXaRG78Wctaxz93hUwUeK/hZEYEJm8XdnoIgdA7AjcVoHEnqMZusboz
         9KVSpJldNzzQn3IrwGPlHSUK5rA/95lRltjERHgwdUL0u7YylJ5QnV99MHnv7RVrznKO
         7Vkmhm2c7Gzdy3DTvJQqRrcDuE3fGLoDEBfTvVfBGBLotw9iyiPF2xUm1oqsW/C5mdwE
         6tCvYmp9f1wgVwoTHkspFShbNdlOaf20T09VBD2vzJvXxMegPNulKIwz239eAB3IYWY9
         cJgBZbgq50/GrvZU4Q/3yq0B0cUw1EWQS3H+LcKuoZEslMdPM8di2bRwFMPsKO4DzzGI
         OgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793434249; x=1794039049;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i7aoxFJS4kqwxdyET0BAIfs5qvlExtsj7VKVa0z4TOY=;
        b=mHXYkPIlpBZ3XUdJOA4krLumFDdkwWGg6jjHf2Mw8UDlZIdJOnaTizaVdcwHyP/gu+
         wG9N1awp1layw62ErUopI0hBJLQCH9ZeLJCw4jFUJ8B9fiMCKlN0+Y/5GbQh9xG9m4og
         ZsMtnd7jbO76RO/tgqM/d1PINbuFtEkmdC8Lp3yhhbZO6oNgnnsWxJRdZq8NXOeCdQSS
         lpPpYizt5zSu88j1FOzB0oLYpIxm+JVRuswzG0pBiRVa+0mbH6swQV3SFJTMr9ZGK/tT
         4sJx30vSgEEQGv5tEYL71n3LxMX9YQW0WHbhjyYaOnm/RyWreJNZ7yPrHW4bGdp5myAv
         VYOw==
X-Forwarded-Encrypted: i=1; AKwUvBz89LnSgJAQ9NMTAbvtOYM+dL5aqg/q5z1KohcTnufb7vpSG28xhLkhrgaV9XoR1DolwYo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+DsrZmcV/ktSyH2ojQ/BPV9aVtS9gKAv8yhTu3mWU8/X2LcH8
	3ax6lfgvt0+eSCpRkmu2V0bYaQ78MNJWN8kneeP9KwhjvEqpPDA8pCkAF5MVUWmC4sRMjF6NJal
	ZWX9tL7Sx3OEGjB0Niq3XTGwfw1qkD7g=
X-Gm-Gg: AYBFou0iBnivDjRFBM2LPA+Q3HnpVKrvlHaFFTX+/RBwWtcUahZsPnw46vAlWNFbjXq
	KOjMhMhyOlQFfoaR4o1H4ubOsBgUy5Pm/5eS+/K5E0kwn2P+YG35EKC+Xr96TAfhg66mI+fcw2h
	2cd1eGOC2GieqRvaBvg9pbdI+fnrh7ROVNb8laLUht84U+uXtQTx974Vy2enO+3s+oCkxx2HeW3
	v6aEKsq7kKlLPP0s0u8DvAy6cZulRj4de1PrKfWfBc4vj7+/Iy3pQ5iOkNJZVpUSWQEu+09DUKF
	cwNlcwTNWt82UDBx0hkTmA8fFEPcz7mh87hCzCYyKYw4/Ovl8bJHqHIcmVfsQq1rmU3BXudby0c
	nu9CS7XjrNkIim7QGFj1U5zDShPwqJUwAmjI=
X-Received: by 2002:a17:907:fd17:b0:c49:b6db:1 with SMTP id
 a640c23a62f3a-c49d12d7a97mr714953566b.12.1793434248816; Sat, 31 Oct 2026
 01:10:48 -0700 (PDT)
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
 <pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com> <9443055242b8968e7196530bc67614d5b43d1a45.1793357582.git.gitgitgadget@gmail.com>
 <xmqqwlqzuh1p.fsf@gitster.g>
In-Reply-To: <xmqqwlqzuh1p.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 31 Oct 2026 10:10:07 +0200
X-Gm-Features: AclHuK8x8OPfRUHQdPKBsMeAb3QXZDpwqZ5M1TrkwDm020Yi0prCdkd6cxEgfNQ
Message-ID: <CAHwyqnV5xv1jkpXggSi_HoDLJBTXCMqXzKR+ZaNLCBm-WmAduw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] branch: let --delete-integrated find branches
 merged onto changed files
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>
Content-Type: text/plain; charset="UTF-8"

> > +static int merge_keeps_upstream(const struct branch_change *change)
> > +{
> > +     mmfile_t base, upstream, branch;
> > +     mmfile_t result = { 0 };
> > +     int ret;
> > +
> > +     read_mmblob(&base, the_repository->objects, &change->base_oid);
> > +     read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
> > +     read_mmblob(&branch, the_repository->objects, &change->branch_oid);
> > +     ret = ll_merge(&result, change->path, &base, "base",
> > +                    &upstream, "upstream", &branch, "branch",
> > +                    the_repository->index, NULL) == LL_MERGE_OK &&
> > +           result.size == upstream.size &&
> > +           !memcmp(result.ptr, upstream.ptr, upstream.size);
> > +
> > +     free(base.ptr);
> > +     free(upstream.ptr);
> > +     free(branch.ptr);
> > +     free(result.ptr);
> > +     return ret;
> > +}
>
> The function calls ll_merge() and passes the istate associated with
> the_repository global, but have we read the index before the control
> reaches this point?  ll_merge() would want to consult custom low
> level merge from the attribute subsystem, and with istate that is
> not populated, it would fail to learn what the in-index attributes
> say, no?
>
> If there is a reason why we want to ignore the attributes, perhaps
> we should explicitly say so.

I'll take a look.


Harald
