Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B5374E62
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049145; cv=pass; b=twwM7hOVs0hq0AlUTQKKTLEzTKaFHCh0lssyqJR2lahbAIWIrmlSFnqNy4zvW7SASO0kMbhYQOmEcgYhFrJ3K0OOoAHe1HBl6ZR5dKIcVwkR7+LENdYM13YqsGwMV71Po4OSZFweZ6LvSOcXJJliHdiFsDF/DINWJ3dKroxb6cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049145; c=relaxed/simple;
	bh=stabF8e2OCKt2PuyrjRj+ioN6JoU2cGlaWZ83pTQZZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCGIrOWGqX+O2k8jkysjNrVCtJyrfpI3aP1BmxkYjud3shxnysG6Hrf27Iy8bNTJO7UA6LdxNcDMvy+SxKFS5zuhqrnMe5+60Cab6gv2cwGZYBiZnj5rcFgdH5aJPJwPTxVfqlsZK6Pd5MsIT0xSfgNNoY7xFhs6sRnAhcdSmOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrza+HBC; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrza+HBC"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-495b250b01cso959664b6e.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 23:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785049143; cv=none;
        d=google.com; s=arc-20260327;
        b=puU+Km0vqTNRMfzYeB+MhrqhTQBYP8igg+TkS/IQaM/70dSIElcJcQNRYrxoRhwvNN
         eBEzIgYr8I8ofHcuTW+TK0g+mfy1/z+XzPQWRP1lbl7NeJ13YYBuDqCLSVRLOnq1EDhw
         a6tiE1Bh6i8SH/yMQl7szoN9cBSlW/OedSjN+FD/mCbQiCFFQrLejAEBEAdoPmRy3ILY
         eeKnfhzwp8T5L2+ObtRkZhnXY8kf2usF8iI6alhjKlaWBqEJ2yRt6+7iayJ9swlHXNY3
         9CCyYSlMFfqH+TXIVNT7NI0gPXq5IrTpye4NAaeb89b4s6NfeITDA+mgmbOnrzsJRPnH
         MHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nU6zyeNAoA1riwbHzcNNtp0u4b2bpyw12dBf9CQVzw=;
        fh=PJA4JaP/j8vSnwMGgKQUC4fHLIhv2c/ic/GPgVk54GI=;
        b=A6gaZUoAzQ6GvxfxafAglmc3YBZrMY9A5tH/SABRpn1+w/cmNr1gvZMy84xGpeyPn4
         SQCuNr/VN9QRZ/sVGGX6FTt54pfC+ZoRvVQMa7MxJf6Jl242a0y8v7+VBlB58m5Wv/GR
         MW3IU/7uEs5Z93duwor6zTa8ojSlgmsEyVxgQ0vPmLZUpWuk8iZ4bwwr7JPxK6j1tAiQ
         ZQDEPDh2m/p37vG06RSKZA3Yf01omMS790Jw4g183OL6RMpF+FHCAIjiRVvmwOwDOT0t
         FsQf5KhzNaVbATyMsTjdtWciLXKDdPFLUNifGdAK4Peq65YycLPoxV+TLOLSnZwX3ak2
         vMwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785049143; x=1785653943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nU6zyeNAoA1riwbHzcNNtp0u4b2bpyw12dBf9CQVzw=;
        b=Rrza+HBC3W6MiRN+TsgGCk5YSSvCXOvouNeYON2VYk+yAy5ovXT1QH7uHtzUKJCbmC
         MJ0A9ujjEn7CyYvk3saO8wvTEhfZXjkYW8wfY2IaUWTRh68sf8U2QDuEzRjyTbLXNw4P
         YFbA0I3zdikESw571f1GmrH49DUXAmnOu88aibidQK6YE4XMBQhub2q6CN5Pcz71fv6d
         rQbMG4IScD8KmNbnr0QLYChC8O2SDeojVd97F5Pul6cnKbR6KTNXFNsNtq0b6sv/LNge
         CLdcRLauyIGwcyj5cEO/ufSBG0lo7lyb3/GYANK7//5wZizVKWmQqOh1RTI1zPAiEm0P
         sO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785049143; x=1785653943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nU6zyeNAoA1riwbHzcNNtp0u4b2bpyw12dBf9CQVzw=;
        b=c6L1hvbwYf+/DhmGeFRc3UaYUnpMhPShWxpVhiUSaPPniPKyHjuTRSQt/U5xph2hKC
         VNDuar7zPItRlaTu14+4AirsRdfEYOk031UIOuGZx4/zkbTbOEgUx9iNV6+LY5h7LVNs
         dhUpkZc5p/qgU9P5AD4aqjKcqAvEKL15ThSy8IcnBLLYIScRcAtlrs+L0JF01IRQNZxt
         R8gsjMqIxvwmMxFKG6xyYs+tOYoZsQnguwb2OgTuOmOGB6DwZOdtTwWMrljHFlEhbR09
         OuqXHA9BUUzNPa23PiGRS4Sa9JGydGFwfaNNrrOAQ5G2gFGJgfZ9L84+DQ0K3s8aV4Mo
         s2bQ==
X-Gm-Message-State: AOJu0Yz2ZX3bCGBRSfau2VPTgOYZVewcfan/yDCsJfoWuGJ4/KZJ/dvi
	0L3p5qti/gz9Q3P8A/uZPVERfQqg5O+mVSoEbmYXJS9CgLqb6OO+Fc46TrVDnkp+RD/6gc5gViA
	tsvwUneaflJQ50XE0WTWPPwOlavBi5fo=
X-Gm-Gg: AR+sD12wBbI6IFMvVemK0s270Yo+kgR8dDJGZnKdDZnG2hkdMcmnlO0MLiMCdU+2DCF
	8/z1dIA038BGidp2gypzGgx3+9eyYwaO1WnUkVIFuqYaOrF79sSdbRuBpaQmrrGMnd8EyKRPlsg
	QThFAp+riZfNHC2fqImDpETrJ9MT5LLcBLqgde5V3keUUMAmHiFAKndhSBT+EcJBXAfpmTteok/
	zus0RNmMF4fk91xeru8OsvPbq6oppJbAUzegUPIXK5SY3g2d4ft1WA4AF4ufwM/GpRjNSan44FX
	/ctIyG8odfCuNp28pgCWEbJYVkDDakzJ1y31GK/C0ZSlKyclgASxx9xqDu9fODeEgl+fmEDuA/d
	1N6+o
X-Received: by 2002:a05:6808:1481:b0:497:dedc:605c with SMTP id
 5614622812f47-4ab69f57143mr4797938b6e.7.1785049143249; Sat, 25 Jul 2026
 23:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com> <5ef4f08105bc5485444e824cec39e684692a9348.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <5ef4f08105bc5485444e824cec39e684692a9348.1783776466.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 25 Jul 2026 23:58:52 -0700
X-Gm-Features: AUfX_myFpGzd1mRlI2-BiTKDnKpyD45IS6d8p0DpzQDDD_Dxw6JsMPJC31J2hjA
Message-ID: <CABPp-BGvoZArZ65ge_2qabb9GQDbtWG=pP=g4bZDmAvX=yF=xA@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] Documentation/technical: add paint-down-to-common
 doc
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson <krka@spotify.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 6:27=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a technical document describing the paint_down_to_common()
> algorithm used for merge-base computation, covering the paint
> walk, generation number regions, and termination conditions.

Thanks, this is really nice.

> +In the finite region, generation ordering guarantees topological
> +traversal: children are always visited before their parents. This
> +means that paint on already-visited commits is final -- no future
> +traversal step can add paint to them.

This is the critical invariant.

I think there's a small hole here, however.  For a v1 commit-graph,
generation numbers saturate at GENERATION_NUMBER_V1_MAX; from
Documentation/technical/commit-graph.adoc:

"""
We use the macro GENERATION_NUMBER_V1_MAX =3D 0x3FFFFFFF for commits whose
topological levels (generation number v1) are computed to be at least
this value. We limit at this value since it is the largest value that
can be stored in the commit-graph file using the 30 bits available
to topological levels. This presents another case where a commit can
have generation number equal to that of a parent.
"""

> +In the INFINITY region, commit-date ordering can violate this: a
> +parent with a later date can be visited before a child with an earlier
> +date. Paint flags are therefore NOT final at visit time, and a
> +commit visited with only one side's paint may later gain the other.

Perhaps we could lump GENERATION_NUMBER_V1_MAX the same as INFINITY
for this algorithm, since GENERATION_NUMBER_V1_MAX can also violate
the ordering we want?

> +Generation cutoff
> +~~~~~~~~~~~~~~~~~
> +Some callers (notably `remove_redundant()`) supply a `min_generation`
> +threshold -- the minimum generation of the input commits. No merge
> +base can have a generation below this threshold, so the walk
> +terminates as soon as it dequeues such a commit.

?  I'm not sure I'm following the wording here.  Typically a
merge-base is a common ancestor of the inputs, and ancestors have a
strictly lower generation than their descendants, and there's no limit
to how far back we might need to read to find a merge base.

I think what makes the min_generation cutoff safe is that callers
passing a nonzero min_generation (remove_redundant() and
repo_in_merge_bases_many()) don't need those deeper merge bases at
all: they only need to determine reachability among the input commits,
all of which sit at or above min_generation.

Is there a risk that with the current wording of this paragraph that
future callers might be tempted to pass a nonzero min_generation and
still expect a complete MERGE_BASE_FIND_ALL result?
