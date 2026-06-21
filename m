Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF6157487
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782019534; cv=pass; b=UEBy1PYDvElMxoK7Pl/6AzxsITpBqi1PXMypKUg5onaNZ2wWJX9g96uMljhFaNWdA+Wc4RgLnIOXVdX2sed9BJb5oQtFy9hN6fjj+DpkAOQissHnMF48Ool7yoS5ICATzpEidGsrtWfPDSCL0vXsI0ibjNjDiair4TFEyzySmqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782019534; c=relaxed/simple;
	bh=Yh2OqpNHFa0mKmPFndNne78XEkdqxMudZca/7QTkCXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLJn97q1AnzS9YNUf8f9TWzqX3HbcGdgz7+YpPhNJZ1qZ28coD7WrkJ7r8IIhmxjcdN+bdjyuJEa+K5pe4n100wZ388PVeeat9NAttC5n+FV7PLqWHjBK5bKYWOxAgtNwCXXuAmg6vmnRM9+su56Et61zGY+wyMWKunVTs7c/Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9dQlMSW; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9dQlMSW"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec423a5265so592942166b.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782019531; cv=none;
        d=google.com; s=arc-20240605;
        b=Ad+3tkO7eMI+MDxfRox3GH4lTZ8gxt8ZcdZ+OQYNHL3tBQ1vYUlgDLJcWo0r9N/5o1
         UqZPBDUPX+WQNZvLucc4SmZ0XGp4Mkuk2SX9WcJk8rvr4Hp1WmEygAk6CUbBtjjI6t71
         GLI/jiZQcu1kWCLZpGrM5AtUxe8kuVPfF4lX5SIKzZ4Pkj5oAFUlkl3+Kv3ZkMJ/Tnr1
         LyFJOhJvkNUxPzdnSBvA37Pqb2SuyP/oyKJP4BzTyYYjOIDaCXwuhWQpV652J0Yq+dFa
         Q1QfhDVTuILYx0aMgw8s61TIfmiHy5jwKEKfxiXW30jnfrxxAP5ac3h86DUB0WWwjU6H
         iloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f8bY2n+M2UfAcz4Vp3Jzs8ESr8b0vG0IGpBaqr40ZjM=;
        fh=BKp++ymVYoIWqwQWIM0pIHjWF1kIubjPrL466ACJkPE=;
        b=c8U9ancLBVw3fy4fqXUDCeYySysFvmeeJtraD0e9/h6YDE/Phk7YZX7avfL0zhm0ru
         RB+5UzjR4zOrv+5srk5UsNyMiM8qUKFc2nMMGFCyU81jOz/GS7aYsomdrG98ULDLoruD
         4GHkpfzWyztlczuAP0+GGXsupxQkTF6XnEMC0uinZqYgVH6LzrUMmEE/5HjAwjSQnIh2
         iXYeE5PtZcQOtR/kaN41ydq4Hib6Y9+ES6NS1l1ma7aGcGpH1NNA2QSjZv5hzJnoElOV
         v/X9uEqOXRlOoY4LesuPolhAdXvLK2018s0TibEORwkQD8Sj/uniERKzRDxCoXFfPKOL
         lhTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782019531; x=1782624331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8bY2n+M2UfAcz4Vp3Jzs8ESr8b0vG0IGpBaqr40ZjM=;
        b=r9dQlMSW/6MLbojOPHsGKg09/mcJ0r1B+kHc7ImE7L3MbPNdBBXwI18dLnZEAXg2jE
         aTnuwLuT6PJio8roWjPcS5FmZh68fmnb8wkHYayKMcDWaRDhHkT6YuJtjwe4UURQLs+x
         HHs6hL4h7gvAD10QJg7cZu94W9DUHm5uou19amyEWCKd1LNC073AEEfi9S9lK0AM2vVO
         kvHV00mv0Bs4RK4+eCE1QRBrR4B7YqMeiv7J9ZZQmLiiPDsICjYPoP00UUd7qZOl+X2e
         ebPTvtlVuraxibnbjI891dBUwvQzGYMr9oI9TP5Fbo90/qgl2ppE6a3ovvrUPz+238aV
         zZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782019531; x=1782624331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8bY2n+M2UfAcz4Vp3Jzs8ESr8b0vG0IGpBaqr40ZjM=;
        b=P34QY/4t0gOfb0uAhEUTJVHMifjc2POiLzj+glUXFnVHgVbBQFHklMuim+AGZinwwU
         6WIjAdER6w5u809FOmJyooCdCpj88fm76bk8SkMOANIPM6GidhTu3lmgLScA6k8AeURx
         9teRsHSZVcGL9von59hthGlYryyaMkTaPtUJRxuXBCGtuVdTOuiJGIqnyuhWPmvXSDof
         n7msDBIyuJH3fFqOUF7/FXTEAb2hYcimutIf5quZZiq//lfwSulirUYjT00GvbufONpo
         tLlgmrbn9vpa17T5brY3bUZD5RsFoj6xKtXyzhGv1OttQY/lN/NwsxcF51cW6x0tX3D1
         kXoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8C27cgzNZJ88YuzHXv3+2Pf7YvWOglxwqiHgmV1vBPKNa5loefjseUqbOwPscdex5tqgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYriXDs9cLxwoqGCF3mTruPM6841YWjaWYAAJXk/eSntDpCWO
	KRUT4HgMTsyQ6wxM5l0amkb+gplef+L5XLBVp4gHBxURvrTf5nDwnw9p0eFbozp368583kDCzND
	7FrJ0UxKHoi2Cu6RU8fq6OjgEB4vvAh8=
X-Gm-Gg: AfdE7cklmjL3KW8ZUr1Jd67oM2mVmQNWuBgVS87qkxcpkaH5pVvaz3s91z9sz6m9fst
	FyViJ/bTO69A9qSD1LNEp9p0LBy8htv02t3zcuS2WBrfNu4Wsvx7xmA+DLCdYtdYdsHAZvKGn9u
	keziKKN95FZJ9wUKAC4GrHFr4cIMYNfoqcDLTiFcvhIcjHQH3+he+6VnLFNVsbbXhtQpP36qLrq
	Irt57WvODrbrXA7R1mybeETLPO50m6tgjHwZBWp0xxK3t6SdgWUqIkvDhOouD0x0ZHEiQzYZStG
	VFrPwkMc6W+bTvd7M0ESi4nqjwilRc0lB20oxodARGAEg3r4tHs2mAmHZf65tO9gmwfBE7lNY0x
	40Z8hDcvkGw==
X-Received: by 2002:a17:907:d1e:b0:c07:5ee3:cede with SMTP id
 a640c23a62f3a-c097ae018a0mr515410166b.2.1782019531234; Sat, 20 Jun 2026
 22:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com> <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 21 Jun 2026 10:55:03 +0530
X-Gm-Features: AVVi8CdE0RIRboZhipaFh-1L3Ihq4kmAcD65JSWU7CF1faNdJpzFGrTaS8mIFr0
Message-ID: <CA+J6zkRam3hPutyFnQ+RVrPczT+O6cM+e-aZL0m0t3a5ABo8VQ@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 00/12] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 20:26, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> This path series is a continuation of Eric Ju's (eric.peijian@gmail.com) and

s/path/patch

> Calvin Wan's (calvinwan@google.com) patch series [1] and [2] respectively.
>
> Sometimes it is beneficial to retrieve information about an object without
> having to download it completely. The server logic for retrieving size has
> already been implemented and merged in "a2ba162cda (object-info: support for
> retrieving object info, 2021-04-20)"[3]. This patch series implement the client
> option for it.
>
> Eric's series adds the `remote-object-info` command to
> `cat-file --batch-command`. This command allows the client to make an
> object-info command request to a server that supports protocol v2.
>
> If the server uses protocol v2 but does not support the object-info capability,
> `cat-file --batch-command` will die.
>
> If a user attempts to use `remote-object-info` with protocol v1,
> `cat-file --batch-command` will die.
>
> Currently, only the size (%(objectsize)) is supported end to end in this
> implementation. The type (%(objecttype)) is known by the client's allow-list
> and request path but is not supported on the server side nor the response
> parsing. A follow up series will add full end-to-end support for %(objecttype).
>
> The default format for remote-object-info is set to %(objectname) %(objectsize).
> Once %(objecttype) is supported, the default format will be unified accordingly.
>
> If the batch command format includes unsupported fields such as %(objecttype),
> %(objectsize:disk), or %(deltabase), the command will return empty strings for
> each unsupported field.
>
> This series completes Eric's work mainly with the refactor of the validation
> of the placeholder with an allow-list that filters what the client asks with
> what the server is capable of provide following Jeff King's idea [4].
>
> I have a question for the design:
>
> 1. If the format includes unsupported fields such as %(objecttype) or
>    %(deltabase) it currently returns an empty string for each unsupported
>    field, this follows what for-each-ref does with known but inapplicable
>    atoms. However future placeholders that will be implemented: %(rest),
>    %(objectmode) can return empty strings. How should we differentiate
>    "unsupported" vs "no data".
>    Eric proposed to use a placeholder like "???" [5].
>    Should a placeholder be used?

Maybe it's best to fail cleanly if the user requests an unsupported atom?
I don't really like the placeholder idea though. If a placeholder like "???"
is introduced, any script/test parsing the output must add explicit logic
to check for literal question marks, and that sounds flaky. Not to
mention some atom's response may legitimately contain "???".

> 2. _tangent/not related with this series_
>    'a2ba162cda' is designed to only work with full OIDs, which is
>    inconsistent with local `info` that does support short OIDs and in
>    case of being ambiguous returns a list of what possibly the user meant.
>
>    Because V2 protocol is thought to be stateless supporting short OIDs
>    could become more inconsistent with other remote commands that do not
>    support short OIDs. Maybe a --pick-first option? That does accept
>    short oids and picks the first match.

We might return the wrong object's info if we do this. With the server
giving us no information to verify whether the returned value _really_
corresponds to our intended object, I'd say this isn't the right choice.

>    Alternatively, would sending a list of possible OIDs to the client so
>    it can re-request with the correct one be ok?

As far as I know, disambiguation like this is treated purely as a local
UI convenience in Git, never a network-level operation.

`fetch` already requires users to input exact, full OIDs for their `want`
lines (obtained via a prior `ls-remote` or ref advertisement), and dies
if one isn't provided. Thus, I think erroring out is fine here.
