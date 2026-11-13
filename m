Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794572040;
	b=OSDyP6rAGmnL3jYbl6S8szVlX2hNfV4hA+vMOo7eQo1iWe2bIOz+4UBwOURZOl9FEvoX
	 mOPA30uoPBZFRK+KVzlLXVQKuDFYTOa3qHT/1ur8BQBila3j5h/1TZAykZaIIqANuvv/a
	 pD67kNmtgZ5xZeWxqavI1moll1+yW7hcXMz2fSexmf6EFTOdRvWfA+SnApF7PRgC/h7nL
	 YHiZg0snky5PhC/7v5Nv2qYN/doanITNVo0o1RnK6laY43DanTv25Sfuf8Uk10/bXHXGF
	 Frg+xv+AF0Iui/KhYZnpMD8xN+2y+3gdGF0KvYHfWGcTj3G20aXykyLBjJ/r0IduHmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=qrooGVNLJrw6HA7oi0Hq5Gno94Sqz5Ji8XpzIm1vEs0=;
	b=FrP2agKo5aMZ364mGbNoWfmbQd4/5I6Wu2eBPNQv1QDulBwfuJZlHLI7w/mVfeuHT+6g
	 AnIKAoFreN3uPx8FUkvRUVImmOg7v5uSkb1OIrDuAVYHwgEngcTnHqHLgSy8E+SESDnzH
	 eSNH+a3ovMK+vHCs4xy823LeDBPlT2K3o+a75wyoRNSeXDbgGf2xM47D4hoAsmUfqSOMb
	 BrCRz0Sg+Uf99G/diWpfq8rysG9Hvt5sE7lDhrrUwUTe7TP2TO/Np/MLwDg8IdpvX2axu
	 VJjJcnMx5RBM2ICwvmWzyTOj0A/3r38dKegMZNF0hEMlHbTWEJX98I5Upxm1XSBHKow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrBzjMs2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE962606A31C
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 12:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE962606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrBzjMs2
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so237070241.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 04:13:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794572038; cv=none;
        d=google.com; s=arc-20260327;
        b=kjrbsHkLBdbTlLWlXdBwsf9FJ/LNAatxTQzr0BTI8Bb9gjaK/WiCXtWbXwWGAqZQNY
         FIK/yJ0BlzGIY5XpRimWNjFtbhP6ytQ5iPuxUqbgrgNL5/mKyzzWLRHQcZWTRbvr4OQ6
         mdF4zrOGzfewv/P/0Olh94dZgn3Nq4gJZptI0wk8exftg4tdx59S+6y07UAWgKkuZN6b
         g29JGzy/P0AgE7RdcXTLlXfgH9WqnPmJ+ECdqcIpVxPw/PKhXSdW9UbUsYWCoqJQNUAn
         R3EicdvgR1McbUWAQjPqsSWy6OLOlOye+OIEvpD6dyeINxa0vAQgzTchjBJOa+QY1ZRP
         UB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qrooGVNLJrw6HA7oi0Hq5Gno94Sqz5Ji8XpzIm1vEs0=;
        fh=wQgUnpXGUIJk3O3LwnS1894ThlxCNh3Gq2z4w+1V8nM=;
        b=bcGsMbtHrwDqeSKzu7yluNritkMEYJh6YrIm7fX8Pw56uq8WcVeRGJDijasH7dwXuj
         NSO9C3hQSPSrc/ExJyx24P9cJg1ti2E7u1khRbg0WjtOvl9tfVUnYcxX3g/gCzFhOUIF
         fAruzgfbXxsz/BWxmoXM2792ctnJLu+9yvGGneXi188RxgByc/AxgTwRgjnHgd4OUl/C
         RBCuEPoXU9ktHOZTNdKVv8yrKmoFGCTrrpDNl7s4kDJljZkg+//6Ao0+7tNW3ktXMAbH
         8RiiaSScuCn/BokL019ZnCVdY8yVx95bFpcAaAsw+q1Q1/nRo6gl12IiEXS2xBmdufsO
         2Sbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794572038; x=1795176838; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrooGVNLJrw6HA7oi0Hq5Gno94Sqz5Ji8XpzIm1vEs0=;
        b=DrBzjMs2zXfXMlVC1K5fDRmVpiLuIj+ThIfCx3AkfYSYgFeBdLNceXEBqoOCRtQ4Xi
         G0nY2BqTZhRErxPenP6sRtLPgKa08Iwa0mxhxgvaR5fFKgqPScwkRScCeICpSnv68tHU
         h5HmelrlOokX9GUHTNSf9FYujtsKLeCAyOnz7qIJftVGPXjiRjNuCA5xueTgy4XuHyHu
         C+wlkbOteZnG3qHK36kJjTF3yoqPleNc+LzKRYRWLTs3HdwuPbR6+q9C0CtYb+rHOKLY
         Zmt9wwaYgc9Z31ox5kgPqZptqIaeMXNQH4k41dOYNZcBf7W4l3LfeOMuk30Y9ibje45O
         7ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572038; x=1795176838;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qrooGVNLJrw6HA7oi0Hq5Gno94Sqz5Ji8XpzIm1vEs0=;
        b=xTw/Fxw8FYxelxVD7voPHqOY+Ccez7hIUpHS5fZIw/myeWAEapT33X1h/WIAWwKNPr
         Ac9wITUwywZ0HmtWGaGHVOd8JJ17vQL7OKcBIz1fUGL/QeTu/pHn3uGOauIU9NJqOk4a
         s1EK7nlY1i8UHBIJIG0ACpnRRZ5SXk6Y1yIpH6p/97G98VrMjcz6sv0pllu7BL7z1jZW
         ku+FP4RNafPynaybHd/X8cKjuCdgZ77SiofIDaINiNn8br7IB+8FOdEShTO6FHpSRCKA
         zMy+hu8/KVjLAS3FeFfK7SBD2GHqGCJq0w3pIwvTVGw2Cyrdowm5s/aTVvsGLGRwM/HT
         93vw==
X-Gm-Message-State: APuU4Z+x8PErpf9vKtL1SXvbuwBIHgbbF5NTCuOD3GYBZAjwjxHvvpCq
	vbGKyiZSPVB1eK88C1KDeZgoIZ3kY3gllC+inNuY4RgDEvdqMoYi+eQENQYQfE1a6IL72RV6O1J
	koeHWW5ovj7iGnKD3OQUhTfXt0XrZABoDx6bo7bY=
X-Gm-Gg: AYBFou3y5lJzVyubVthWQWkSA6lczxucXjbeFtMmu8AHMeAFSJ3POg6fsTgYoRcbQI3
	uOea4wBdzdIGcVsvln/G95l1Wyb9i/wA0AM7hslI/4PIRv+o9VkjWzfgFKvUBHiN2NLL5ELiGti
	yEWhel4MeXHE/I51VMBVHMe+0d61qHq5ChPqbOxRjHWAOkbK8XDBfEFrwivKuSUVPezS3jHaEnz
	6Mg0RysdqcvX5xx/kvoRPoUTYr7cPL0NdDJZ7OJARow6koAlibqYr7TCNSU6cRgLZAPoZ5fm6Qz
	3lTuWbY30ZzU34yJUb4VXU2zO+jn5AuY8Xikn7HM7liz4K9QUTAt+UrZVuvTyL1+TrwBlSeA84r
	jZ26cRfZo9jOTNRtjk951GmKuVKiUMx6N5Fix1pZckjHD8elwdwM3c40wbItm92UHSCd2SmXyy7
	+EGMQhz9MXDzVdwo6u/34QcjSsyd1vi5hXs/uBmPrl96wW/kU3RMu7dXlYpHViewMJoLvo+T6Id
	4Fv+l+bTwo6OUtdh3Ib/bgY
X-Received: by 2002:a05:6102:f88:b0:7ce:a69d:b020 with SMTP id
 ada2fe7eead31-7d64d482d4dmr512573137.5.1794572038485; Fri, 13 Nov 2026
 04:13:58 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104172434.691381-1-yopatatchou@gmail.com>
 <894327d9-57b5-4adc-b300-25d946211606@gmail.com> <CAG7jffxRscX3ntX3p8L1GwGbs7WJmj6WoKPRGUuz3wcCS0NZag@mail.gmail.com>
 <a3ae6756-0985-4873-9d23-96d4bb49eda5@gmail.com>
In-Reply-To: <a3ae6756-0985-4873-9d23-96d4bb49eda5@gmail.com>
From: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Date: Fri, 13 Nov 2026 13:13:46 +0100
X-Gm-Features: AclHuK--uOjIXjHRbZdiuKlb21ntt3AHw9hlwJnod3qmbiiQFDa9yo-It4ACjeU
Message-ID: <CAG7jffwSn_hv6tT1gSA=ZvMo5M3ONMC4hqo20UV0sg7ZhOseJA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kaartic,

Thanks for the clarification, and for pointing out the
To/Cc issue in my earlier reply; I'll be more careful about
that going forward.

Treating the current patch as an RFC prototype and leaving the
actual implementation work for the internship makes sense to me.
I won't push further on it before the Outreachy selections are
out. I'll keep an eye on the list in case anything changes.

Thanks,
Yopa Nelly

On Fri, 13 Nov 2026 at 10:51, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 11/6/26 04:25, Tatchou Yopa Nelly wrote:
> > Hi Tanga,
> >
>
> Next time try to make sure the person you are writing to is in the To/Cc
> fields as appropriate. Otherwise, there is a chance that they will not
> even receive your message since not everyone reads the list by
> subscribing to it.> Kaartic, I've also re-read
> SubmittingPatches#describe-changes and
> > rewritten the commit message to describe the change rather than
> > address the reviewers directly.
>
> That is good!
>
> > On the RFC point: I treated the
> > Phase 2 config work as the micro-patch and skipped the RFC step
> > you pointed out. Should I step back and send the design RFC first,
> > or keep the current patch as a prototype while we discuss the
> > config shape on the list?
> >
>
> I think treating the current patch as a RFC patch and discussing the
> shape is a good idea. The only concern I have is that this patch is
> submitted in the context of Outreachy and the candidate that we may
> potentially pick will work[note 1] on this during their Outreachy
> internship period. So, discussing this now sounds a little premature to me
>
> Of course, I don't mean to suggest that no two people should work on
> related areas. I'm just thinking it might be ideal to avoid premature
> work among Outreachy contributors before even the Outreachy selections
> are out.
>
>
> [note 1]: During the candidate discussion, it may also happen that we
> may not pick a candidate for the project. It is totally fine to work on
> this in that case as there will be no conflicts. But none of this is
> clear now, TBH.
>
> --
> Sivaraam
>
