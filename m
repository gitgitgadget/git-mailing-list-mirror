Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC33E7640
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093401; cv=pass; b=Nd0ttsbVl+ygbuYpaDBn6CvMBijc9PPRK2zhgIG1MQghmqTTOY/soGHBnAxL1KykOD6mm2cRYBknkA6iG7pdwVUKt2JUEMxw218jPVlj6W/RGf8Dq35f7vNA7aDM0xC5uB8EJYjjvtJwyQtQDeGLDpQUrZBIRIqkarVBHeJpNlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093401; c=relaxed/simple;
	bh=t8DPzbjSzZh5PNJyLUMAaIkwjJn8uM/67cW4jXSNEPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMdLIimbC3CZzhSOiZCbLlTtuqO2UWvJGMJ0TXEaBC4T43pJvgDLiNFaT9uG9bJIdn6sUe4CkbQR6J22VYZmJCTpaLHY8DfsMQlORPgptGFpPf30DnTsLy6cpsxSZ9kvNXU/zR/9BNdVh8rZzlyPMuDz2L26BGi5oI2AIg4NPd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfa0o3fM; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfa0o3fM"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6de1ca1b05aso3760568eaf.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792093399; cv=none;
        d=google.com; s=arc-20260327;
        b=Qwp0+SbfoJLwH+zH6o4i9Wq7/KB0zRdx063LC7uAAJXBDvLA0vQctmAZjEMKyGXtgZ
         HpeTvGSOxmijXyVmJW02BjOC5YshacrawuhQRRYkgxD7mDQlLVY3RbEwwlcBvhaWObKy
         ysDCIupcvI0BlZmou89COQQp1vNJmFGHYWaDd3ARfn0mABvRosP9GiVgoVKkih+nKw+f
         wJnTmYj8tfdwtyryIhNuquv+1T08MI8fAQZ2OCNkRT/W620WmdRhiqTli1ZmUFVr9Pi4
         kEZW0PWTIJmC2pKI663uCDk4SAOR5L/0aJm/VJY6UP+zIE5JTp4nufFyaKPsa3VOv8rO
         8tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=utlTfKViyjBzy8R8woSxA1BTcHpgztw0a668U3yPORk=;
        fh=G0JnDLNJP0BpiWLSj76ohlq/MxrD0p4yG2Eg1RehNyo=;
        b=ERSd0fcEkAnGij7D4EcATQVgXyFXqSQMW9brmgESo20WVxlmJYVVo/okp1eTESnp1n
         791WxO1YgCFxUM3hxiWZf0tH2mYroLjjliQyZr8eHRJRGXOsvPJZd9n5Pv+O1BBGLeh8
         q1adG0GmyaxlixXgcapPgWW/CGQfwM4mH+Vpe8g9V7x/r6ECMdOtjzW1M46chTKgUODI
         N071+yc0Kud2xoTPvgY94OjlXxPgnxHCQKVYkp9pgdWqf+47jIK54ohrQKOIWH0xGTK3
         b/wrQubBsvOT6vHca2+tU3TNTuZjKc0henxBWLZHBtxJ7zjBYoSs566VPxvtdkIemjMo
         ADSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792093399; x=1792698199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utlTfKViyjBzy8R8woSxA1BTcHpgztw0a668U3yPORk=;
        b=Bfa0o3fMY7ASB1bSACv1tNhkLDesM/CM7E3jhnbpIVckFgAVQ5bxAsLLk6yIZdjpg+
         DyHVc9QD9AfXSr94wwj6EMLhH4l9gWSoZbnPXdUtL6SoU+d//l+l4qWbBXIyqEqM4SIM
         MXDYUbF918A8q9suWeJL06OFEVHB4DFEB1eIzqodMFhlJbzIzfObMLUjCmP9Kngxq3wL
         7SnhJcvREjOPHDNBMIHGoInM2qykwvuDA52tYIOdDUFDiDZBdgCYuY2C0OTiXa2TCUH9
         ykVvbIrX7nV6NOCuIEh83xStSDA7GLlI8VjkvJ0q/kqbPmAZuHHHhuXDMjAhCgY/flRf
         89jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792093399; x=1792698199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=utlTfKViyjBzy8R8woSxA1BTcHpgztw0a668U3yPORk=;
        b=HcY2tXeRrQtaJZ7wWuTaQMMRj6nXSu8lwvPPCq5sTfdPp1g9KwZ2ZfhR+Q1nxEt/Pp
         gxHm8rAeAAJCdzSqCULQy75n+hcUz1IAIY+gF0CcgPKTZDBIr3sQE1tUxlGjwQtUi8gD
         /jko3oqFI/I8uf0yzzLSUDL6i6PEhWfqPIm6PiZ9dsKDemcqgveXrCeOd2wSiTcjX1iU
         Lau+vPyQCNhFsYiJcB8xaT13O0SOvRAH6q2pgBfyVenpsfU1W9jQIoaxiAnk7ONQv0Xw
         EKkDMpts3qDGW/dJl9yBHABmA5c1r3Is9wGBkARCnqpw0xmELWtBztUnlXf7PqYCbig/
         tDAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLxHzYVa+qDCi2UxB3fdFUVSOPAbYbNtiEmwOeyx7eAaZ+Gll0dGU1Gd6tI8EieGVJ1jg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZDqfZeesGrygozS7g3f6NjD5xdnmbFrNPJ0x3aSJU+SfpqJaG
	V0/tlpFTlAlrpaAq30mPejZtQ8wenBaRlXEv55X36SeBk99/WTPJyRRcwBpoC2unolUoDrJfqfP
	0ydoh2E1ib6tWFYgjHUz64++hVjFGTdQ=
X-Gm-Gg: AYBFou32dD6P5o9vgXyveFEKEXtvF5rKd+cwrIUnCEIETvVLMVNBKJkNw3tyNvOo9IO
	9GNvh+NOQI8L8YX37Njn4qDg8+60YoZI4nZa23AYDp3GKlJWUY12ikyvBi8ZzcLn7Un5IVeHAGX
	5UqogsHCmliomSQzPeqfx0DpdDgwmio8Qa6KZtPt59eoOiJWJ6zy+QTBpQc0v+4os7iYJ3iNabO
	I5HBZrJ7s2X+EAAa11iFyzqTqlzIy5tPxM4v1FWOdNQdDiNUH+hdPxdeFOB3i1Q/V8een4H04kX
	doLKA5OI1ZgsxcWRzl5AysGqutN6eWRVbUS8WxFRI+VFK6XErdqXEg==
X-Received: by 2002:a05:6820:1986:b0:6de:ba4f:af00 with SMTP id
 006d021491bc7-6ef10295693mr16200260eaf.63.1792093398378; Thu, 15 Oct 2026
 12:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
 <atBraYoY1SVwnezN@pks.im> <xmqqmrseooor.fsf@gitster.g>
In-Reply-To: <xmqqmrseooor.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 15 Oct 2026 20:43:06 +0100
X-Gm-Features: AclHuK-3KqvlG_xs4lairvuSURD8bPLsXEeNVrRJUL5CrDvKHPXmjHY21qs9pbM
Message-ID: <CAHWeT-Z4n=txTGaBNuGPj3jcOou91owB59gvaPvF=2_p50eFHA@mail.gmail.com>
Subject: Re: [PATCH] refs/files: keep root refs out of loose ref cache
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>>> +/*
>>> + * Create a separate ref cache containing only the root refs. These are kept
>>> + * out of the loose ref cache, which may already exist and is shared by
>>> + * iterations that should not include them.
>>> + */
>>
>> This raises the question whether an alternative fix could have been to
>> teach the cache itself to skip over root refs in case the caller is not
>> interested in them. The answer may very well be a "no", but I would be
>> curious to learn why you settled on the proposed fix instead.
>> ...
>>> -    loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
>>> +    loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
>>>                                            prefix, ref_store->repo, 1);
>>>
>>> +    if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS) {
>>> +            root_refs = create_root_ref_cache(refs);
>>> +            loose_iter = overlay_ref_iterator_begin(
>>> +                            cache_ref_iterator_begin(root_refs, prefix,
>>> +                                                     ref_store->repo, 0),
>>> +                            loose_iter);
>>> +    }
>>
>> It's a bit weird that we recreate the root ref "cache" for every single
>> ref iterator we create that asks for root refs. Is there a reason why
>> you have decided to not actually cache the root refs the same way as we
>> cache the loose refs?
>
> Curious.
>
> So an alternative would be to have two caches, the primary one for
> things under refs/ hierarchy and the other one for those outside,
> and callers can choose to use only the primary one or use both of
> them?

Thanks for considering this.

I think it makes for a simpler change with less overhead to not
actually cache them, as there are only two uses of the
REFS_FOR_EACH_INCLUDE_ROOT_REFS flag: in builtin/for-each-ref.c for
`git for-each-ref --include-root-refs`, and in builtin/refs.c for `git
refs migrate`. And both only invoke it once.

I considered keeping the root refs in the loose ref cache but skipping
them during iteration if the flag is unset. But that would mean more
impact on that much more common case.

A cleaner approach might be to drop the flag and change all call sites
that currently ask for all refs without setting the flag, so that they
explicitly ask for "refs/" only. That way root refs wouldn't need as
much special handling. But of course that would be a much bigger and
more risky change.

Andy
