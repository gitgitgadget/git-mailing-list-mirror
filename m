Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285417736
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568388; cv=none; b=u2SEpP4sx+aw1sxVcRGfIpYwJOWVuXtdxptL5cMT/OU7ijecB9UM3Ict3Xv4CzlIkAdtQV2XbshIoH8eDJGJJxRSRlluFkNQ6gNuOZSBak8W+Lc3GMLwErtNSrTXQtylKOUNg0EoS08fVbGOV25M0jtV8Xl5xm8totpmN+n8hvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568388; c=relaxed/simple;
	bh=X68NMoUu8oc/q+aybPd1ISvtiCxMpyO45ryL9uR/hyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3BJC1m3xfNoGswCzXOTuk0D9a8D8QSa8IUZum2b1zThcLKKEFXRPgRxeS3hvjJpCoxb13zDkIzAPobjhwxDnzwTCWXjdkhb7x3igBBboCWDd9nffw835vmLZLjnYvJPrqTB3Wyk3c4GLRpkSsi1taGtcc2gDgLg7ycmWwb91VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9wJG9pl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9wJG9pl"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac345bd8e13so279780866b.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745568385; x=1746173185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nzi8+JEZlPCAZEI31F2nE/1vvpm6am/z3tyvIBixsY=;
        b=X9wJG9plbe4LAci4IPtG8w8ZiZUacm9Gu/Ez7wuIxAP5itr1cATAXIeHwe1krXF9Qa
         5Uvp17YI0G7tOmdx/aB07NP6AKoy8DZibk0d9wV568HVjwHqkwGikfD3Wz684kGjXPrz
         v8DmMCxWUhYpAdu5NgG8Z5nEU8ewRa0+CFEMVUan+VAIsI7BY1SHDmm3N+2TGo2SCWBp
         0SO3gWMP2cUqvxgk3CW+J46FQg8fQn83qqfpxlos6OSJmE+Mkulmp8J+zri1ddRbhUus
         AwS34XfnhOWqZOljblPmAQzkHEkL7SDx9AIYttzHDwvCwj1rkY7uxfNBbWy9yvud7phH
         3vBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568385; x=1746173185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Nzi8+JEZlPCAZEI31F2nE/1vvpm6am/z3tyvIBixsY=;
        b=a/URsJcDxwM1rca7nIy2rrQkM9jzIxXlzICEAP8TewbmaBFl6nYpMdM4DuJCwIOZvX
         Bddy/L7FCVLzaLs0uKxrJOwenKxwaUlU+1dmA0lkFvcCAK24zaVLyW5lD92Xi/XpzsAo
         buDtgZcSyRydkS9mrsi776hQJgS6qmJ8Z2dTAAFQUUJ/nLWNLp1EExBcdt5ckJVjr+bT
         g+spRnt6tzLbT4o5GcjPebD6PGxkypabwfpIU1s2OiR53Fugy8iYE8Ie9mVsstSsWMuq
         I2Xk/tmMFhe148ovkQCnLYV1IAI9DBXFHoyxheShKmvyR8vPArAM7YSrS27QQWcVB1vd
         tqZQ==
X-Gm-Message-State: AOJu0Yx0GwFb8A0pnZnTKjeQ3dOfTYELbTVg255B3TnnGoEn9jt0qYMa
	XueVfBs2+WDZjOd9IUNyK/Ec041sUrHgiiwIKM3KNOVsNFojHkO5JwaYVETGF8iEP1VQxOsoGyb
	PDY7PJYd0jVWLsS7j4MdpW+KKrT4=
X-Gm-Gg: ASbGncu7TI6NdDuaS6XWSMV8k5QkdDnVBJcoqbXX+NoJmdUrGWAsJ5MrEhTFtbjMS1V
	o6JbulGDQKtNhEu7pvU4hMKUfyIMq9IHBqTFgBAIxLMxpsLKylf6pEkKayVfQ9jI62sAXmcJgmn
	Tf807vhnBym/OFc7G+mTZJDNnsnuVpxEEVkXELPvw0oH5PLOGWm0KNBA==
X-Google-Smtp-Source: AGHT+IFWlnyastrmJv+Ffvp4UdI4Mpz3NsFgfrNtBYqWUDVFNJKl31hfaXpIB3yq/OLKG/ufofoxPwZvd6NVS1UB1Ds=
X-Received: by 2002:a17:907:2dab:b0:ac6:fec7:34dd with SMTP id
 a640c23a62f3a-ace713fb7d0mr124442166b.52.1745568384858; Fri, 25 Apr 2025
 01:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im> <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Apr 2025 10:06:12 +0200
X-Gm-Features: ATxdqUFepPQWNeQD8hJw4hpvCWhoP_pggxfjxsjs6zEQ6sD45LiA9FqgPGj6i7Q
Message-ID: <CAP8UFD1ovdQdfvLMvfPi8fz5S82n+8mfjK7ECqoQUMW2p-khjA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: wire up support for benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 9:28=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Changes in v4:
>   - The patch series was rebased on top of f65182a99e5 (The ninth batch,
>     2025-04-24). This is due to a conflict with ps/test-wo-perl-prereq.
>   - Introduce a 'benchmarks' option. This allows developers to require
>     benchmarks as desired. By default, we auto-detect whether the host
>     system has all dependencies available and enable or disable them
>     accordingly.

Nice!

>   - Report whether or not benchmarks are enabled via `summary()`.
>   - Our benchmarks depend on Perl, so add this dependency accordingly.

Nice too!

[...]

> Range-diff versus v3:
>
> 1:  2375a16c2c0 =3D 1:  174804805c2 t/perf: fix benchmarks with alternate=
 repo formats
> 2:  69782035246 =3D 2:  41faa3d9b3b t/perf: use configured PERL_PATH
> 3:  cca40e9dd0e =3D 3:  87ea3ab1a45 t/perf: fix benchmarks with out-of-tr=
ee builds

In https://lore.kernel.org/git/aAc8f52rJ8ATncVc@pks.im/ you said you
would try to paraphrase some explanations about how GIT_BUILD_DIR is
computed, but it looks like there aren't any changes in the patch
since the previous version :-(
