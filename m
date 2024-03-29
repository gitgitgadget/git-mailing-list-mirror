Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2987383A5
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737762; cv=none; b=qlLh/dRgt7czZ2GAlovBDeb4jAXb0GceRR5YKi7eZktEFo8FFAc1yulO3DDSLXYabYog3Zts3YDGcRo1Exugznug3OJjO7Tska4XzY2Mq1n8lzymjPISgIU4rgfE+h9dcNJLa8FNT66vDvXrf2dsvUQTTHXOsA0xZ9l+uR/jZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737762; c=relaxed/simple;
	bh=oEIj9N7TpddLfYUet9PibamL07/n8ZuodGDKkdTfglY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwjgLgIGWqjppvdXrggnA7Ma51JfRECUiuFJzRHSzqHVjE8XO/t+wdN35vBaobZ1KPzKZkOvl2s1SH2dAmXXKdj8GkFmgiwaxkWhIOmxC7YaNWvLXsYrbXPtM05JIYsTb+1fL9BojGX5OGzzQs9P81GWSjSvxIVSDmdweAe2jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-696719f8dfcso12859856d6.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737759; x=1712342559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwJhmUJ/lbd5ttD7E2f/Ppt7KqoqekKxuV8D3h4o6M0=;
        b=UsKcoVwe/CTVh2jixjioBm3SUpc9+v/oVO6eYg46vdBXZ6HCDEHyauKtzKFJ3f2sHC
         7rhq+vI+bpjkbTN24TepLN+dYPtpJ/Rg398cbm0ZJ0fP3/TW2sph4q7ncYfHwM41ZWlA
         4Ykjf57K86luPlbe7EpFjSBEC9DDqgjthGUwd1bLzbtFlVqjpNb5NYFIupRMq+30IqR1
         mM3G7rFDP8MArAXdNbhDgkHGk/Ut9wBh6myHXcAF6FpPy/kX0mi60uwF2Vk96p5Q7qCv
         cTfOiXzN1uloG2CNHRwXMOIuRLkFAdbCOI+bwxaQvbNkcejrsUgaYFJ+Bp2r7UTNrQrK
         Oe+A==
X-Gm-Message-State: AOJu0YwXG3oeFtYOV2etuSgg1vzfBjsSCdEYIq1Ie0dX5KdfB9/arraL
	V7nUQOFmo5zkXfG90yamkvCHJKrFytNoWKZunEa+JnYBJHB1EJCAnFLMAYPw4Nltxo7N2t7db8O
	StK+XY3fRONRWeOO0k9z9RvfcEK8=
X-Google-Smtp-Source: AGHT+IGVUFNRGPTkzMhJDJdHFUqSLmZa34yNdCF9ajs4nKAnyIDj8pZFxhaRCT0x2hg9R9gOndHJWjg/mswBarm+8Rk=
X-Received: by 2002:ad4:4e63:0:b0:698:f227:c5cf with SMTP id
 ec3-20020ad44e63000000b00698f227c5cfmr2286133qvb.8.1711737758950; Fri, 29 Mar
 2024 11:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
 <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com> <8a25ab1c3b61ebea9942fe106d4e0547a81743a4.1711711181.git.gitgitgadget@gmail.com>
In-Reply-To: <8a25ab1c3b61ebea9942fe106d4e0547a81743a4.1711711181.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 29 Mar 2024 14:42:28 -0400
Message-ID: <CAPig+cSzqUcTfnHBFTQWxjMbUZQBKahpD7eafmL=QvUDYtXTpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] doc: rework CodingGuidelines with new formatting rules
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>, 
	Jeff King <peff@peff.net>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 7:19=E2=80=AFAM Jean-No=C3=ABl Avila via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
> Literal and placeholder formatting is more heavily enforced, with some
> asciidoc magic. Basically, the markup is preserved everywhere.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -682,68 +682,118 @@ Writing Documentation:
>   If a placeholder has multiple words, they are separated by dashes:
> -   <new-branch-name>
> -   --template=3D<template-directory>
> +   _<new-branch-name>_
> +   _<template-directory>_

Having two separate examples made sense in the original because it was
illustrating a standalone placeholder versus a placeholder coupled
with some literal text ("--template=3D"). However, in the revised hunk,
there is no reason to use both "_<new-branch-name>_" and
"_<template-directory>_" as examples; the reader does not learn
anything new from the second example which couldn't be learned from
the first. As such, I'd drop the latter example.
