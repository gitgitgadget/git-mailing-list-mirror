Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CBE1A3035
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394090; cv=none; b=jaMGSOrGl4d1pRoXC5/uC1ysk7LzItJMcNfs2RFsD9UNqjCCcw5aDWtnm6kCLTMjf4eodk8UuAIvy00E9wCKs7hKd7aO55pBcW+m71jSb7COWvwSzUv+gteVzdAN8CsfvN4u5COevt31WMlEhyGkJkVsXDdJn6OTrb9+PWXCaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394090; c=relaxed/simple;
	bh=clhUGGYzeTJeD5zxeCdklqdHVor5tx6xzSZ7Acr345Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYoFVnRldnsfZVTCuR6VmdpIWTem2P32ea4lmAtq4Ri23S7gQLXzzeXYQd0DySvR0j3go3COmdWX1pM09yMcyqyr2U94dNbjdYmzefJjxI3P6VJBa2FsRUfznTbulfz1Sdq4b+bW4oJR/x/+w2PGK7+8Dz8qv1jDY6DsD+c5yzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9gxJx6F; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9gxJx6F"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso24688139f.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394088; x=1742998888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ulouhVWBI229nzS15aFVTuwAP2E28MfNgL5sXAohGY=;
        b=S9gxJx6FNak7ZgSZtFv5CG+B4GpUOOOqIcz0jsdWqY2t9hRe8stJHHimVU6kp5P34O
         +Frx/2WSRW+iq+4d10ZvAvJyq4f453/959rUTC7qPB8I1auJIcxiZvXOw68ki1ZA3FOH
         8t/3KOiU1cR30UTloi6EEABFuqjsjRzcE5Fc53/yPwvkIchS4ogQwcCicrP5xklPXqC8
         1SUXyWv4T4xUQnR7ADO0I0M/ytSuw+exbH4h3UN+xkxvXupsr2X7NSCqtPN0Za9YYutd
         nP+GGHQyhcvKVJvXVzSq9PPxjECb4k/cmQ8HBo4JHsM4tL+Mv/qkItq2VT67jbs/mNvY
         VonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394088; x=1742998888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ulouhVWBI229nzS15aFVTuwAP2E28MfNgL5sXAohGY=;
        b=okEt5pIpgWTIzj40JZ0Q8AMeYuD8iqJDUYsO6LfnWxwuOO4XGbMbRZUj7MD2h7hteL
         onNKe27L30JPfVfBM9O+6LeLbpFHATjInX3bTPMPwaYfi4BvJF7Y7aUWlXIN7kMeTuw5
         GG+SJKaMuGSre5ndT6PSO8IF/fph1Ss6LphRymVWuizl8vaYKn/3MAD8CQfuZmzJ5nNI
         52vHUXNKKK9IFANQCQ/HFQdKHH387Xr6LMo4SSBBcuWlf1hbauEpNTQsRrqCaCSwKHNF
         wbvS1UZdWqDQ2oydpNMMNIEUV5RAhpEEFJKkEtF9unjpCBwllWk2Oj+ZEstNjtPCSq1z
         l34A==
X-Gm-Message-State: AOJu0YzEQFwifTXKJx5tGHMnuCZGYL7l4MAchI7aQhvayAkzRfGwp0lE
	XDVanLBSWixF50NgyYnY81LkBbuyJHHr3YfNnN6karUV7dYAlgm0Xfxgw2oshEcu0AAL+i8/mCL
	M+oncewGd8XRhTIye97Hu3UhrwJ0=
X-Gm-Gg: ASbGncul9CXl/18t0brDebsbjwE50gdb9a4l9GMBIg74epS5BMWy0mzo4nr9VOXNBcu
	85jnBpaUsazGqLnEug/8eiNhz1I5MZHlbN1pGxROKlsREFb4GwFzRjPZH7xQNwXIW5LQYSC/98W
	Aj+m6nvf8jqIibxFFz/B4o1AbuzTf/
X-Google-Smtp-Source: AGHT+IH2LCZb60URMGuZSrx0AmTL1lZrVOfGC4umFy0lhLF+0UqGPt8TTW9+xO5lrfzHIu+Sny6bQw8zBstjn1cZf68=
X-Received: by 2002:a92:d98d:0:b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d57c1c3482mr71831055ab.3.1742394088135; Wed, 19 Mar 2025
 07:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b3cc5c0fa2d0696eb15c5d3c97a6c93a0d39252.1742338479.git.me@ttaylorr.com>
In-Reply-To: <3b3cc5c0fa2d0696eb15c5d3c97a6c93a0d39252.1742338479.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 07:21:17 -0700
X-Gm-Features: AQ5f1JrxxM99bbFPJf59L7PQ_Z3iQX6uNhX8rpZWICaD-OBfXPLJ3PK5HKQPTLk
Message-ID: <CABPp-BET=AGEm_K71ZdY=E_KGXT904B67688MOakxg4yRxeQRw@mail.gmail.com>
Subject: Re: [PATCH] pseudo-merge.h: fix a typo
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> The comment added in 7252d9a036 (pseudo-merge: implement support for
> finding existing merges, 2024-05-23) misspells 'bitmap' as 'bitamp'.
>
> Correct that so that we no longer have any stray "bitamps" lurking
> throughout the tree:

Those poor bitamps; not being shown any love.

>     $ git grep -ci bitamp | wc -l
>     0
>
> Noticed-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pseudo-merge.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pseudo-merge.h b/pseudo-merge.h
> index c9fbe9d312..cf0e62ecd1 100644
> --- a/pseudo-merge.h
> +++ b/pseudo-merge.h
> @@ -210,7 +210,7 @@ int cascade_pseudo_merges(const struct pseudo_merge_m=
ap *pm,
>
>  /*
>   * Returns a pseudo-merge which contains the exact set of commits
> - * listed in the "parents" bitamp, or NULL if none could be found.
> + * listed in the "parents" bitmap, or NULL if none could be found.
>   */
>  struct pseudo_merge *pseudo_merge_for_parents(const struct pseudo_merge_=
map *pm,
>                                               struct bitmap *parents);
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> --
> 2.49.0.1.g3b3cc5c0fa

Simple clean-up; looks good.
