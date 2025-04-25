Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD015C0
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570012; cv=none; b=uy45QF59HYiQFwkCm2AuzZP8OIUY8qcBfl79L17w2QSmzor23Kv0Wx9JYG+C9v16savMkAc3qlaolYDsrpwYLKNKGVrBbfQreCGTUtIC7cQD1SXX3eADZzF2Kc1lT8NPZCw5Tw+CbxBlfOeZz6lEOc7a5gx+vjs7+fK/3N6Crus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570012; c=relaxed/simple;
	bh=oOt+W9DUrLzKH4NCLoDHw2hXZQiLK4WdNzcR71TknHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFw+wPFGAZ45HuLZ8B7JFHUR8vnWlHFv5MdAeFiwgg9nyoMQBsqh1DxKqH868kACPS+avZlVmWVq1aMuWUkpHGI8O9CDrFXX/lqBMkf1pQdNGtG8VgCR904IH4VRP5Yj2JvDjh7un+Lh56pgHuZWG+5TcRu1R/bX87qTo44SbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHXh3Xsj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHXh3Xsj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso310267466b.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745570009; x=1746174809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/m0f3Wb/yra5U32lLYAM9f65HrAaQRFk5rB+9OkqmY=;
        b=GHXh3XsjST69Qxk0QqazV0QggM5b6YgmJ3pplZ99/45mtYTi2YmZok0lplsnB49uUO
         7Qxb/Ut+MuMX0z/rTexUfBugiMISKKN6jc2PeIWoUDRp3u+qrKoHw+TYqMQJHLERi+Lx
         +3SsGkXm0VZRInVNv8R1JBCz2Oq6vZ4aVPgmQUZS4pvDoxpnXOeefYGkjSQ2WpIjs0fW
         okCVBcvyvJeC9pT0n7AoOjCJGHup7xkRzfOQsQSGp+1p+A42IagHjyFTkYL7NNmNbk4f
         bSXHtWRhp/0mvDFGD+1vtzvznSK3Ly+c5ZoT0+WeMxKUnt0LNQhqCDnupHFXQiJxrtXr
         gzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570009; x=1746174809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/m0f3Wb/yra5U32lLYAM9f65HrAaQRFk5rB+9OkqmY=;
        b=bvDqLC1W0apL3X9Lw9ohrTVE50ZOrB6tJNahmW/LHOCS116TisczCPOMJGw5fxXPBC
         WxQi2/S4kQ5rjBaZCag9SZ16nRy7tuJ1tZiIKVjLvroZopoiK5lN/LU1+v/PbBYiaWVg
         q66WRR46t/gZrI9sQOVSyxe/4ny5GUbDBUn/1UHKwI+jpXOHWEVXsaVRoPDttpvoME0r
         1DLmy5mWzyg04RKgFtUJ3GYGKc6uAz+Qpa5S2o3N9FZQE82gAwIJkqm0xPOInQsP4gR+
         PcyEIVBQXT25UVtSZWLBGfKlllxPAXPM+zVfAIcfqbd51FhDXhe+16mFWR2/xWrVkUJ5
         psyA==
X-Gm-Message-State: AOJu0YwXm2hOinXWbvqTrfc/DTjiJbTVstUQmcZcQcM35UeUw9E34GkV
	NbtiMXhhVMSLGe1NY/KZmG1sPMzH5DKR7rqA9Cj7rr/8YmBDQhe6ctCMC4EmFwxtRtw6SIrcgpI
	5oxK77HfJ5g1+Y2f5PdAQ9asW5x1F7w==
X-Gm-Gg: ASbGncsPEjkyBXo93BJrjRPPSJxu3wF/vHFYSq5LgjjjIrl1M9Uummzrk7phVpJCJAs
	OoY4Bt64w2zOgTR1XBRj42JbNrkYlfhT4cdw4bxrVlzeAONmP0q0F27xVWHWydk0LbaEkhUgqOP
	Hnk9vFHqWIoVJ7NeUh0kIEU4T28kJ0oSNFibPYW9HymA7jID+A4x2wKg==
X-Google-Smtp-Source: AGHT+IE+GOOQa0sBnSiDwtFzi86iKE8ApwoHyFR7AXGkafhxj2msUqKBmYZMC/4cfyJOBMm5bt3VAq2zzRZzIRS44mM=
X-Received: by 2002:a17:907:9804:b0:ab7:cfe7:116f with SMTP id
 a640c23a62f3a-ace71399afbmr125226666b.46.1745570008995; Fri, 25 Apr 2025
 01:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im> <CAP8UFD1ovdQdfvLMvfPi8fz5S82n+8mfjK7ECqoQUMW2p-khjA@mail.gmail.com>
 <aAtHG38GPdbhOCop@pks.im>
In-Reply-To: <aAtHG38GPdbhOCop@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Apr 2025 10:33:16 +0200
X-Gm-Features: ATxdqUHtwR3Zh4yNUcxqJPo5ttKPIFK0_871NmH1uQ1vc1KU_IgmcNSr7P5zCio
Message-ID: <CAP8UFD1y=rB1PC8M5aN4qz8EbEdiXuVOgoFaYG1tVw9NoV0rnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: wire up support for benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Fri, Apr 25, 2025 at 10:06:12AM +0200, Christian Couder wrote:

> > In https://lore.kernel.org/git/aAc8f52rJ8ATncVc@pks.im/ you said you
> > would try to paraphrase some explanations about how GIT_BUILD_DIR is
> > computed, but it looks like there aren't any changes in the patch
> > since the previous version :-(
>
> There were, but not in this version:
>
> 3:  d03ca0c0630 ! 3:  a66bc5aaf51 t/perf: fix benchmarks with out-of-tree=
 builds
>     @@ Commit message
>          assumption breaks with both CMake and Meson, where the build dir=
ectory
>          can be located in an arbitrary place.
>
>     -    Adapt the script so that it works with out-of-tree builds. This =
prepares
>     -    us for wiring up benchmarks in Meson.
>     +    Adapt the script so that it works with out-of-tree builds. Most
>     +    importantly, this requires us to figure out the location of the =
build
>     +    directory:
>     +
>     +      - When running benchmarks via our Makefile the build directory=
 is the
>     +        same as the source directory. We already know to derive the =
test
>     +        directory ("t/") via `$(pwd)/..`, which works because we chd=
ir into
>     +        "t/perf" before executing benchmarks. We can thus derive the=
 build
>     +        directory by appending another "/.." to that path.
>     +
>     +      - When running benchmarks via Meson the build directory is loc=
ated at
>     +        an arbitrary location. The build system thus has to make the=
 path
>     +        known by exporting the `GIT_BUILD_DIR` environment variable.
>     +
>     +    This change prepares us for wiring up benchmarks in Meson.
>
> The changes were already part of v3, so you have to look at the diff
> versus v2.

Oops, sorry for the noise.
