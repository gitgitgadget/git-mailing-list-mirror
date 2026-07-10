Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368F374A1C
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705272; cv=pass; b=HWRHDa0tTd2aiFGhyMmH5y7DmPM55I4j8wCBk46rQx4Egd1MXB0dN+97cmA+nhsPFqBQa6nXmdZMfeBwkLTi8O8GKWgYOGe22bNIqgEIAZHRztWXW3vSwFOxqNGiOc1wSNCEFmd43QHXUKK88fvWlHX60jl83h7XrpAcSAVM9l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705272; c=relaxed/simple;
	bh=8y2A7IybJ/U4HxbB4EiD1q1aKhXVtE1InUp1LqNHBQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P70jPRk6bIIJyKHlAAshKWENe3gwcsYYGwkyATsc9IpHRE1T+3OOCKolGLFvWP1MibChJ1f7s5/QOYdiOO+kt5TowU06cji0OsbX7Z0Q4M1SMoxT6vKG1JltSXo8l1+3iLV20UoZgVEs4FuxGkhOQuvi1m7jysrHHPn3tikySEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=GbPT3lF/; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="GbPT3lF/"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48a0ca07c38so696685b6e.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783705270; cv=none;
        d=google.com; s=arc-20260327;
        b=FxunAaHtME6Kotib0Unrj+BWBV7b8pkfmh1aGkU5YJyv+GOzVKI09mHya5yH+ZvgAr
         AnXba/mT1nMJ50C40FDGQSwbqn+sLG3w+Eo/ouKIoIgT2KCdq6edQSK6UPxPAWv7E3ny
         u+Z54ARiIl1FKx02fxlo9nakzt5YUQU+ru6cnm/uinzxLK4nDpJ8lf+PE+nLnT+SXewM
         wH8hFTDI/BlTU25HivwHvGsNOHNNz1z8IS3x8bd/1C4Bn8xXjU1SYwjtJCIoQAPxb8ew
         xbZ4wDdUloKG0gleHhzVaGE2jUExh2F+aYKwLnd5Xa9R+8poY+Gu/Kq5HD2DefBg7HRJ
         cYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oagmaLudrO9dSlgXZk8w55igfOjIGTsVl5MQVreOUX8=;
        fh=EZ/hgNMzy1C06Gvgm96O+kOu1SpUfE8e65ESjcT+CxU=;
        b=B4tO0QVO6qdPt7AjBek9bLw4J7MnW/VZiQfDdJNPLZVrLnetW+AuSqJDTsX789J69u
         p5TH67zP4iVgbrwVqEeBAxxbqQ+A7PKIiSCCqs0SyVld2bmlVXkEKs0klCVaL6w7t0Jw
         YZrJ/FBnzyByQ7mvSnzQBv7OTvSH+cqgT1CDJ6qCHx5shlfn+2cLjNSd0WTpQM8aE9jj
         hUWYfRjtL3T7+F9iE3eJnH0fx5Ihgm9VL5h1MviW5fFRNjiBMO51w6d5ILPicc4M986T
         uRxTFWoMiefJTy/iAgkK9pi+rDlaOgStjwlvgwFg5+SgEL/OEI7hT59vqhX5rkUWI44C
         V1+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783705270; x=1784310070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oagmaLudrO9dSlgXZk8w55igfOjIGTsVl5MQVreOUX8=;
        b=GbPT3lF/dKzU8O/nQC+3vBZo3kIwO4QU5P8B4Mgzl2pk4yCq/j2ydBLzdrYnpCUkUM
         mlQ6fM3ftqVSEy9w2KRtM+J0yU88oEGf1Zees2K7p+Y9pU6NMxJu2JfeF2CSqTGiInUG
         s3zx+MdbfUxEe7zu53DWS0mE0TuBX1AiNbcK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783705270; x=1784310070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oagmaLudrO9dSlgXZk8w55igfOjIGTsVl5MQVreOUX8=;
        b=gWRe75EY+oe/bVgQZZk6xECENAppcSjR/jS2kQ3gZsJ2SU5Cx5+YCvBAEQhFawNoLk
         GTcbrJbdo+m/nqHGgU81f1JJa3J/YfrrEdr8jajoVICoCLMJoNMZxtCUuUW8C5UPilFt
         1ITU4/hcZJTo8xh/ZPH/9LNOZFfzGGTPGaISGHxrJMl4i7FWtqaD3hwLjPj32oKHLOyc
         L+xQPf9fbmsujDnDSwJ32srQPU11vNKMev3eXR+ttEfw+FyKza2tZARlFa5FxCyE8ODW
         bP1a4+84dKXt4VU8Jk02cPzOo/kGm7NpxKBEfkU/iCxrFbXNZqTVxM5wd5g17+xQhEx6
         xTEA==
X-Forwarded-Encrypted: i=1; AFNElJ8nu6LuQp9/4YQT6DJMeOwAov9nx62/rg8nGz+r5J8ylu/7V72IKAA3ELDCgQi6bonywBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Pyi8EnHf3kMQtwtegaZKqQhiFi4tnwaX1Fxk8GYJmUElqplm
	PQerwaghV3BDjwyseXz6gj5Pjs0a5Q/RatNNjsLjT+h0aitMqtfuXIkW3ygdXcMGatsIPsDfa1F
	yKHl2m8VtaqT8RxRPs7o/PBkXSCyUY3bTIZd1bqkm4A==
X-Gm-Gg: AfdE7ckhcSar5C1V2LFahd9K21QIhujDx/jkfMYXeXMWDXD+y1swa/Hdw9UiGt8RW9z
	CLRpv8ZyK719/vHSHw7Ev96iW4am0r1p4UpaIP4XLfi0nVMAcce6bXl368rEqbhr6tLVdauM604
	YbTkd5q6OcY0h23+yvTlNwml2XI6RYNaom7RMRYVSXzut6bf9B5BBcnW42gtJsp7C7PFxvq/3BM
	pWCMhl/wmbM09FjRVuUZ4Wb34DmqjlM5QZ8LRb5MnmCIWe99UdTOjTB5Me/xi6uYLQ1nVhUqA==
X-Received: by 2002:a05:6808:1b8c:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4a42abf9198mr166777b6e.8.1783705269942; Fri, 10 Jul 2026
 10:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com> <dfab9ff4-fbfa-4ea2-bea3-09c1d1b1cc18@web.de>
In-Reply-To: <dfab9ff4-fbfa-4ea2-bea3-09c1d1b1cc18@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 10 Jul 2026 19:40:57 +0200
X-Gm-Features: AVVi8CdndNaN_p3A1DSyciA0aHvzdW3Wtwbv6bBbRoJV_v6Mf6SimqV54tEer7g
Message-ID: <CAL71e4PvOdH9-aER35f=OAEurNzM-coYr64A7GPckZ9AYctMtw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] prio-queue: use bottom-up sift for extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 at 18:37, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> On 7/8/26 7:49 PM, Kristofer Karlsson via GitGitGadget wrote:
> > Note: sift_up() currently uses swap, matching the existing code style. =
It
> > could be further optimized to use copy (hold the element in a temp, shi=
ft
> > parents down, write once), but that would require changing compare() to
> > accept element values instead of array indices. Left for a potential
> > follow-up.
>
> Same for sift_down_root(), I guess?  It could almost halve the number of
> writes, right?  I wonder how much of that benefit will be eaten by
> caching.

Hm yes indeed, I stopped looking past sift_up() when I realized I should
not expand the scope of the change. But I think the CPU cache
effectively makes the swap almost as cheap in practice.

- Kristofer
