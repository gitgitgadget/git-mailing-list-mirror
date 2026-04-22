Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787C22257E
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869140; cv=pass; b=ZkbkGG43Q9tC3Wcmq4ZFaz1Mb6nIO86gtT4yNBgsZriUXY3TGz94OYfmPMqUlWuiCYL7cUaaCM9LT0Dq6PfrcLvWq3D+vzGBrO0pdCo+aP+PUDJR1CdM4Y5C1z4gQhq37Saxhl9eSK9v1cX/XQjdpkAyoQBtTv+beyXcbQoFZfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869140; c=relaxed/simple;
	bh=SkNG4vfGT8Tx/2V2WJTOps/SeUa/jX7iw1g0JoOPH4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqJX+rx73ozPyCosfvTM0ds3yteJGp0QupddEhJi5YzuYGkJd/+nnrAwKl8sUoTzulANfPPrbhEurPg4+BxMJWqijGfpckX7vcveG2o80HmnnwjithgYp25Ld8uefJwg8Dj1iw+J9J92Rl1IGzgvATdb9sJoHOAxP+HpzKnc+Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp3j6QY4; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp3j6QY4"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-692205ca402so1954263eaf.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869138; cv=none;
        d=google.com; s=arc-20240605;
        b=TVj+KZ65n2m0zoT4Ye0ynko5VSP3YnKyxkUmvGBffPt2ZxFzqGi/SuF9VABOxvNN2p
         4RMCO2uovBADwoLtmA5t2m3v4xQkhbZepyZAjTo29NxW0HZi9SF/KqMaxRnMPNH1tp1z
         oHOJeTaRxBoFWDte2cw+QTwMp+UWdw+kpw7n0tmCiJBZhK7XCyb1DyAnAa4GEnwLFnX5
         1n89t3TRMes5qM5z6ch2wSWQc/iBsmkoifKHblSCehKJl7ZoKKeDlckjg8T7rxqTf7Jk
         UGayu/6tTLF2R7karQvwLfjRxesSeaGvxUmmvwsHgL8LH7sT8uPMYZz9ROkXTB7tv5sa
         QV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYlW4SweQEPFTFww96eyJfWsOpuR0ARl0O21HcqQpz0=;
        fh=fDra5E97jdgrddDfDvRTGbshnji+3XysukvVq5At42I=;
        b=aYu059rruw7NRcHdfwtXA/I7+zxQ8UmLcdJFUAKl+koXEdcPtERAHBjNjnlLQw58pH
         rgWTMGe1KeqEnDIqvvZyU2ua/oIZ63QT6QuijqZ3UhAgW66MMfVzbTQm9kilSAnTY5N1
         DOAluHzgg8Ei7RJZT7w28d5nTs68KDly9AUd9wHMv0vCaW9fa8u2wzwPC0WjsSgCkRT0
         rWe0zZo/OlwWGaoYG52QoU/bFMJyzt60rhFNsyunnMc5A0GodsQu5MQ7RoRcl/1ea+wn
         JOXxYQbPEi+2NU76qEDK26xgk9mNkDxM7PeZGM0HsRufnK7PQmAcCAd/bgJ7lWr3V3Qf
         vxCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869138; x=1777473938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYlW4SweQEPFTFww96eyJfWsOpuR0ARl0O21HcqQpz0=;
        b=Kp3j6QY4ALVwlmRyuoXmTfM5zS9Y8WJG9mHgdnOxEhURq4KuAbVDOnbdJuEz868sOq
         DTMJjkq6Oj4bA7rH8QIR4yh3yFGaW75s51FTykSz4rwpAvEmyRBxjGVQb2EzfcCdKdIf
         kduk54rbg1e2qRJWoyrCJgi0H4MlBpnhdsTRj6Wk4KjpyrCweEtFRxSAPH6a4NnF05P3
         QBVS6IAoXBv29G422YbZcmf8hb7TRZQxl9zXPmla/uvldaZz39T0NDmQY0CA7W2GJzgs
         NGEkytisY7mNVhvobd8XvSxjaamHzmMrfTNJd2Yx3f+NwCg+qoCjXiX6Nt2VapKu7oMx
         RgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869138; x=1777473938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYlW4SweQEPFTFww96eyJfWsOpuR0ARl0O21HcqQpz0=;
        b=bJ/VYhz4/7U3pO+ZC9q+IsmJuN3nehhcTua5GfC24UGcOaTBJnHYH6yB9dDe4K3j3n
         km8K+7/MThsNhf6172nQ9MiZ9DdQp1++lRFjQ+GAKXOAYsekxJNfcKhfhlgPD2AEpu2K
         sejBRQaeAOuhtZw4UXWdaRLH/fXU4cQoz/NDL1TjF3GeZvmGSCaQb4ETiCLE3EOuhsrb
         RvH539pQSW6U576CGryR2UPTzsvTCtvofLJQvAcaibsKgdJ+yQe5Sde2FRsBgZwh51Wz
         U8/PdGwE2UqFWLJt0ie5peL26pqk9IUy357F6Cy8kbTlRkgz7PqUTeSEtyP7pJma2lki
         6Pmw==
X-Gm-Message-State: AOJu0Yzssp1gN2M576dUTJDIt/v9jXFW8fXPK7DQIMB4W3yxS9ckcZPA
	jUGOq0N/sqc5GGoAJt0IMX7ZzBwWD0XT86hOgkyrHlUNU9wqKjjODjbcUoAQ/naa+GO9Uh4Xbhe
	9HeaUnkzmJA7xdUMS/k7t0BREzQkzqrEPGA==
X-Gm-Gg: AeBDievFD9N3jOGpM8SAKiHTKKL4xGJFDfX/sN8hj2KnI9XlIPSopq2PGqdeblhzSp5
	fszFigqKckL3Tk/GzYq8/Tcx1nngIKGgx5jjkmCQ8Rt3eM95gfN4KLJrZIvIXQx2Wh6VfwZsWXo
	qSAyyQV34AFm0VoMjZrwPUz2aDrAmzH2trErp9OSXqG6IYxBr4VhlY0O9z8uaL2hp/8VpjGc933
	XVTWPUxww5673Fij8jleF4gyLo2l1oytm7j+t2tfAWObYhAWDdv2nafJIT0YkDlIUpa621wWhBx
	qk/0TsiUq/KWoWjusYP1CeZB+yPf2WuDzxceDaT0wJLZbyH25rExnrq/I8knqWhtd7SHLgZ7wt7
	T0eKc
X-Received: by 2002:a05:6820:28c5:b0:694:a3d8:e532 with SMTP id
 006d021491bc7-694a3d8ea68mr1242538eaf.37.1776869138285; Wed, 22 Apr 2026
 07:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774820449.git.me@ttaylorr.com> <cover.1776803827.git.me@ttaylorr.com>
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 22 Apr 2026 07:45:24 -0700
X-Gm-Features: AQROBzByuzdh0s_g8DJMt3Tmlo18nCuk1cQ0induJ_mes_TC1ws0y_1op-XiZpk
Message-ID: <CABPp-BEoXTukGMQNMyj1P2DNxU6KrYasq=3uWcjOgkstqeK06A@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] repack: incremental MIDX/bitmap-based repacking
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 1:37=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> [Note to the maintainer, this is rebased onto current 'master', which is
> 94f057755b7 (Git 2.54, 2026-04-19) at the time of writing.]
>
> This a modest-sized reroll of my series to implement the last remaining
> component of the incremental MIDX/bitmap-based repacking strategy that I
> have been working on.
>
> The main changes since last time are described in [1], which I sent to
> the list last week just before the 2.54 release was tagged. For
> convenience, a copy of the main changes are below:
>
>  - Use a strset instead of a string_list for keeping track of the MIDX
>    layers to retain when calling `either clear_midx_files_ext()` or
>    `clear_incremental_midx_files_ext()`.
>
>  - A new patch to rewrite the logic for determining which MIDX layers
>    comprise the new chain via keep_hashes to build the array in order.
>    The subsequent patch converts that into a strvec, which no longer
>    requires direct manipulation.
>
>  - The new "--checksum-only" option has been renamed to
>    "--no-write-chain-file", and various small implementation tweaks
>    (e.g., relying on `is_lock_file_locked()` to determine whether we
>    should update the chain file as opposed to reading the flags).
>
> As usual, a range-diff is included below as well for convenience. Thanks
> in advance for reviewing!
[...]
> Range-diff against v1:
[...]

This round addresses all the (admittedly minor) pieces of feedback I
had on v1, and I didn't spot anything new to comment on in looking
over the changes in this round.
