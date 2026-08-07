Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F94B04B3
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071674; cv=pass; b=p8MBiVdMzjbwbMhFHgzGRJzZbY5ZKRVi8sLA+u0dOyh9/10Zf+60N7UTK3d76eQNHSex/u2Tu8/Z+yiVUVKftRB6M0C+4ndYa5TTt8Jgmme+Zj84Ri7sMcRsUuju8gu5MUXJuL5jI8ulNhgN5JcLkzG+m7rcQdX2R+3tbdWzKpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071674; c=relaxed/simple;
	bh=WpX89Yk+npQS4MrSpzL5f4v1B3HDlMQb6PA6+fWLL2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU2KITB6uHEtG5nBGjqcHHSgWIgATfq05MNmUZ3jS3nZ+VYaM1nvLRZXo6mFDY9g2I4g6Nx8B4M8tpPYbYhOQTNE4y/I5k5Ux3kxIsT3Rw9/it0Lhj5BnqMvyM17M1I7xqIJ5GGSefSvipxvoLihrLwim/4uX6m0xjkm64hreBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGvabQ/T; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGvabQ/T"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4955cd5da3dso1083424b6e.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071672; cv=none;
        d=google.com; s=arc-20260327;
        b=fPBZKisHc33MXqVb3ts5ErJ7hwNAUcx5ASF3gpZTy0g3OE2CpkK8XfwMQx8OQSJnIU
         HX+1KfbE/gZ21g1rI9NX1PDdUyRKn34BrYCQZgTb5KbtoHMX34oIKzkyH21gVWhekIE4
         xNMb6PzVL4UeWPuMc3Xn3/Zi1j7v/S5xYwZWMUlL4tidR/XU4lq0gNd/dovhHRQvPUmt
         fUv6wVwYsDr9Ec3jfUAAAUYUiah99O7jj7Npe60KhO3oo1bvJGtGO3GWhjeBpESEcdPq
         11sEHcI7u4AzxjYbOeakeZt+cK8blSMAyb4WNUHvdRclxQw6OdAnqxlZGv+MNOfbkHDf
         eT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmekR0/ekAHY9U+u+9TNSC/jQZPjvBniExy57WAfXjQ=;
        fh=RF7Txg/Qy5EHKPT0wQF8SoXXRiHNj7JP1ffg1OoGnlw=;
        b=bhoJU94+0RshWUPhkb7IioklKERfTLxoCKO9Czqr52tnYHoQC/qxbbqyM1snjx7pCN
         qjkJJcUC2Xv9vU/i4bNuhL8TwJ5tyb5+/bDqxu3ICjHQvFXlcMraJAcQAJxregtkiQYU
         6gkekXMPpu6v43fs2ALhP7i1pkimLkwNluTlfRxM4GKceLiCVcElcVhawWoUUeD10ekH
         xUcDz5szb0dt86YCzqqxwbuE/f6aBovFfSfpstmlF22SohgcNeqgGo+cwHHin0Drn72g
         LRpApQrHKO1lAir2eaHhxaLHfUhx5u6FobQO3GNVw4vV2tAQAI78Nkq3SnIw7j2YKuim
         bASw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071672; x=1786676472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmekR0/ekAHY9U+u+9TNSC/jQZPjvBniExy57WAfXjQ=;
        b=GGvabQ/TJo9EB6eFvF74+NwOsEQjDY/AVj2JEtafnXmdap9yf1JziLNjYj9tpHrYq4
         5xysqmgVd/Ax8p76uVI+CTusxg289coLYPLW5s3bb7C1nq1VP8oGz3+AUDA8tOw3B5CG
         RxBh588EkKKGj42eFB1qkojfuPSdihiao6Tn2UUNc+frq5f+elN7K9sJtWmurubHrBc8
         5+99Tk8tR/P/w0w0a4lr4oBfoGXUsKZin4Skxshf2hMLwZmObWJjbZ2yQ6PciMOPmQkg
         XbStTRbuXLt3HzsB1k4bRgKoe5zvbFhrMa23ZL6tYo7l8U1M7tVovqETCP81bu0E1iev
         wjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071672; x=1786676472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmekR0/ekAHY9U+u+9TNSC/jQZPjvBniExy57WAfXjQ=;
        b=qOVBZ0MYE0us4/F4Zzkpzy0ssSDo3Yoi3H+2sAiq0bfiMyIcs2YTc0Km/1fsev24ha
         O2MmYf4hvVg9jYKyD1rjetHZhGKcqVe6FwS4piGk0e+7LbIooqGrYFPU7Zk102Rc+Wrj
         sC94/ElOxTDORqIIP83Y4PyARsvqQ6ZBNLQvomjnQj6WL6K3g00vqeTZ+VOfzLrcSHIc
         GodhKwQwBxelrAkeBZ9O8xfzx0iC0Q2odOGfEKVLjevIVTD6+4uqvxtbQlFiHMgKOntC
         5SIdhoLOmSxsw5GjNy9KGijOjW8VEExuRlhsiWsj4fD3+HXVPJbypCIq/YsU8Amvgp/S
         ZZeg==
X-Gm-Message-State: AOJu0YyD97bdDZQHwyJom1IiMWl5SCZC3HHp1DZsBd0REXSGQa+nlunW
	NpLWC86B3SMKjJE+g3qjAoElf3GHFZjdwN2PvcyE0bU/Eeh/kZxcrBLF7xuygOAs5mqhBWJKU1o
	nKMNgztSjR5PpCppsPpsqDBTYZkGxRFJGxA==
X-Gm-Gg: AR+sD11j1tVnwjOkS7tIJt3Pff9Wo9f4nSQAzFxo/hHzT4cEJUV+M5yy6NUOSiu/DiS
	DeIHE3NVlyUk0hsdb9NiAdeb4MBi/IQKxkE+24EjAxktKPihWJ9rbbd28MoBLEcH5j405FbaZPI
	QsFfRuNWgk3lu7LCQ6Mn1EjTTTm407hOPBx/BraCqRFOdYn5uQ9OZ/DDOSyPAl7cF07bng3+Cxt
	QcZIqjcoe/Tw8hiuqx5KU+zbxVi0CMuQgZ2nnsNk3W4gU0+0lslN2bEnPVM9mBd+xNeieXy/2q3
	tKV5DeRn+HibabqMVTvHRFdC+LOuCS1xu4AsE/eqB59UjfNEh44BCu+sTBl3Y3Uyz4Yzm6On3yj
	nZq3Z/g+VsUWpRuv9ZWMiitCday6bbxB1xbjpxiDJYHd5zD5X6Mn6ssS9zvtWo0rAd/crIhbp
X-Received: by 2002:a05:6808:3a0f:b0:495:fa73:2e44 with SMTP id
 5614622812f47-4afae19c2dbmr10765324b6e.15.1786071671918; Thu, 06 Aug 2026
 20:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <f857577e0cedc11f8db614b4ab2bf9217652a312.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <f857577e0cedc11f8db614b4ab2bf9217652a312.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:01:00 -0700
X-Gm-Features: AUfX_mxG2PpwgGT7jqrVF-Bey5NrhjtGYCPQe1hk8z6vwh3IE-6e5flZqEEgm7c
Message-ID: <CABPp-BEV=u82AV=bXoHN9N+iNOrBjAig=1FY0sxiQNusrNGUbg@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] t6600: add test cases for side-exhaustion edge cases
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:59=E2=80=AFAM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Add test cases to t6600-test-reach.sh that exercise edge cases in the
> side-exhaustion optimization for paint_down_to_common():
>
>  - in_merge_bases_many:self: commit is both A and one of the X inputs
>  - get_merge_bases_many:duplicate-twos: duplicate entries in X list
>  - get_merge_bases_many:pending-stale: STALE transition on an
>    already-painted commit (ps-* diamond topology)
>  - get_merge_bases_many:infinity-both-sides: both tips outside the
>    commit-graph with non-monotonic dates (pi-* topology)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>

As the author of these tests, and as my Signed-off-by attests, I can
confirm with the full weight of my authority that these tests are
good.

However, I would be remiss not to note the perfidious destruction of
my two spaces after each period, cruelly collapsed down to a mere one.
Have you no decency, sir?

(Kidding, of course -- I mostly point it out so the next reviewer can
appreciate just how little else changed from the original.)
