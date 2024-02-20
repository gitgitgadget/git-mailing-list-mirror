Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC028DBD
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468802; cv=none; b=IK+Om2B4wQ+7rrX0j0hf9V81SvzgWxZyelobZodWuXKC52mc+EdDVhJGzUJrA1gunBkXUvrGa8bKa9H8494dIOSWfit2L5OhZNhpkBynd1HAuVx0P94EU9zaWwtkNtyyFMWudhBQIHyLiSq8y6dQwgK7EaKuYcSmNdDHZx7995Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468802; c=relaxed/simple;
	bh=N+LcXl2c4ZQ/j0yG4MEb2WwKyW+N8/SwEBtkSzc6oig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLe65STOK3wbMiB1ZFG19jmUdDVLX9mys856JbS+EamHE1OxZdUX2yeX6KpMohWSdvWK15mcBaaaER4fedPGu8K68HPkzGh03MWVIK7xKTRcAkCTlpHzfJSd29UuGukQty2P8+cN6rT6+M2FzYkIJ04Kf1wR7vtuoJETYxiwM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so4213135b6e.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 14:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468799; x=1709073599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+LcXl2c4ZQ/j0yG4MEb2WwKyW+N8/SwEBtkSzc6oig=;
        b=duAr7CUIMKA9cqqklZLZ6Do/hDOriZZYoExlRZnSVUafEIRqWxUWQqAQELMjIOOfe7
         6OuzboQkC5GX96zIZ3zOC48UBV8aWhHMrCt59l6XHTr56G4Gy0rg+qhGUQsA/N3wP8i4
         h3q8hYnK+3Xr/S5tzmHkFvj2GtBXqj5aMbjCRZe/28cWn9oFMu55vziYx6NF/Mj7/ZoH
         dS4uRDalUxefXAohtygFZEB3DjiKP+doG8QDkP56XULFXYPuHfd6gFRpSp6HQ+KedI5y
         w2OGD1AORtNa5oEeXwp7DrSa0SXh2up9bVMQ3ITy4Q6/ukQUFBzkI/xCA2DIJRjH50od
         U73g==
X-Gm-Message-State: AOJu0YzktdHgH+6YA1Kr6nM7bZkHXEXSjW8xyo85//yTp7AhsgdrN++H
	Xscr0uuONz6vi/h7t4vupF+Vvz+3H3+y93Q9tX9cthlkROoFna9yBVokwYnFfxruIx42NGajfh5
	FMSX7W+yzOMwILMa5qTmNTYQWCvY=
X-Google-Smtp-Source: AGHT+IEra9BlGaKzjz4mwWktLjY2I3UG3y3QKYdvAvHdQhipwzLo/NIoFn04TFHMpQzK2OGK63qoeouzmc6kRBoSTPo=
X-Received: by 2002:a05:6808:2f11:b0:3c1:5d20:179b with SMTP id
 gu17-20020a0568082f1100b003c15d20179bmr8295053oib.9.1708468799554; Tue, 20
 Feb 2024 14:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com> <7d85bfe6c5511d3918dd84365249797abe6fa04b.1708468374.git.gitgitgadget@gmail.com>
In-Reply-To: <7d85bfe6c5511d3918dd84365249797abe6fa04b.1708468374.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 20 Feb 2024 17:39:48 -0500
Message-ID: <CAPig+cSFK_sVZn5p3Bw12HOEF4Z99niPGMHp1Dp2w2EUjjZ4zw@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: git-clone fix missing placeholder end carret
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:33=E2=80=AFPM Jean-No=C3=ABl Avila via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
> doc: git-clone fix missing placeholder end carret

I believe you meant: s/carret/caret/

In English, I think this symbol is typically called an "angle bracket".

Either way, probably not worth a reroll since it's just a commit-message ni=
t.

> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> @@ -311,7 +311,7 @@ or `--mirror` is given)
> ---ref-format=3D<ref-format::
> +--ref-format=3D<ref-format>::
