Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2601DE88A
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532167; cv=none; b=K/kqSEhN7NLF/4LhWsx74/rv+krWmj5iPi1kWajGA7oEzm6gag5vCg08OHYwfFscYe3m15fuFnAkqEvLx9ImNNS2Y9YXTV1j17g37A0I/dL5sf+To5fhjzCRGrtAaQIL02sYtNQr47Ce90Cfzayrh1sQqCy7rf+eS94Gf9iRo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532167; c=relaxed/simple;
	bh=H3WP7JEnI5lek/bT9/bc/AE7H5Fj69Mf40ZfpTuhKOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCN74p1ruJGrxJ+hhZjr3jpdAkY2PkBZPe2EfIwVNVXrUqXXFVfhm7wyzV0G4j9xVFqNJYx1OHEESg7zw/1qyUqZ+GnlYGeBAyScve9nGzsNuo/UOKeKaQjTKd5m6YlmlUBOPKSEEJJrVlu22OFtk7au7q06EFkzUACbRX7hCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re3O+yKJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re3O+yKJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4766631a6a4so12369291cf.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741532165; x=1742136965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3WP7JEnI5lek/bT9/bc/AE7H5Fj69Mf40ZfpTuhKOQ=;
        b=Re3O+yKJIi9MnJ1WzNhHZK8dgNC9oZD/qVOzjI39xT59PqBeP+tT2xT1IJ2dyr4lyE
         dwpWyxyAxm3RnKBxrCLDTK6GAIps3cUcTzT3X5a78m7mE1+caaVW4lJDyK1/chRYw+cR
         Sxgx+xtRTeV4jv5OOt+SIoOPVkBwbuCpm1OjaFwIwkMiNDzY4/j9nBss452d7uFnuvIs
         vleEGUxjeF3+04OY+mqOVGbwGudJfrKedQkZhiH6t0z0Ufn0OY/j2UUTrhtsun/31+NF
         /VwWnnIvlZKp+34mljVhFPol3y5J9atkhyMAUQP4i5YlClPpVyGJhRqZpEeRiIYvKipU
         RX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532165; x=1742136965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3WP7JEnI5lek/bT9/bc/AE7H5Fj69Mf40ZfpTuhKOQ=;
        b=kTLW/rHDuXoSkjxqAvFIYjcMaTktbciRiCzUTSa7JksqTbxVvEG3g/YL+4rRkvencX
         NiRF1UBPSRfNlXhe/gEtOT2kts/+kh4JEtcPjayAQp1Zfneoza8YV8vUNGu/Qw/crSxj
         9d22sHMdrOhhHx/2DssptpCK9fHENzrWHa+3P/EY0jjBJKAE89u6s/Cd7mPtGASCJBjm
         7bVd4oiNzDQA9YGYvtcmsSNBx0ZXOZSgdb5o98LmqpDfMPsA0MgzrqgTxGHHM1dgv/RI
         AXylkz494Q7dae5T7n6LARfL0DJ/lknYVWJhySCwi5+dtfBE5bSPOtcKE0pzU03QWtvZ
         3UPw==
X-Forwarded-Encrypted: i=1; AJvYcCVLBzvv9K44YbNiihkOYSyU4hun1Nzf3XH1+AHh4zWvZHvU0h+ORU8d45qM1HQmy+/1xEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabY1mYzLO80iR2P93cXyfI31WrJmwr/mEttrKdsoCgQMIXm1H
	1vT/Y3I6iq55uPCDpOM7erUeuT5C+044uyDL0b6mq8P+b7YjszyL2rARtPLUxcJT35uadu33DAd
	MUoaDhHK2eGqRIupFVgd30oblpNo=
X-Gm-Gg: ASbGncufRYa/FoPoococCR86gPiIOV6ajUfH07U4hegfT6LjBwaC4FKS15aH5PTwaYR
	DUz9R2TEp2KxcVIoAozvba7IuvNnaQRMAio1f9tyCOAgf6A0HHzjnOdLFIXWJ6FSkOG+yonT40K
	h/Naaoab4QhgqU7QAegUVfqOre811EVmJk8uabCay4PK4mmiwfdOYLTjvLzS4=
X-Google-Smtp-Source: AGHT+IEjp/R3ahUR7gdxbFYHQ8N1f3CkZJ5dm2khkEayxsXV1x262FjjiqX4jP0RDj+a5BcevRL2Y9EnvyFC9J/EfLE=
X-Received: by 2002:a05:622a:44:b0:474:e3e8:1a58 with SMTP id
 d75a77b69052e-4761097c54bmr145046761cf.16.1741532165027; Sun, 09 Mar 2025
 07:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
 <CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com>
 <xmqqo6ybb48p.fsf@gitster.g> <CA+rGoLfTJSHQZTvNBgfcMmGjJwqak+wGHh9PRhHfqHSxB2p6-g@mail.gmail.com>
In-Reply-To: <CA+rGoLfTJSHQZTvNBgfcMmGjJwqak+wGHh9PRhHfqHSxB2p6-g@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 9 Mar 2025 20:25:52 +0530
X-Gm-Features: AQ5f1JqgakoI9MVDnkfjRNuiLApbbkQyOYKZoyYlkiPSQFPMhxYLCblTmzSvXlA
Message-ID: <CA+rGoLfwetxdij9ZLZx7bcxNXfzTi7hRSSkJu+AMhVX6W02v9g@mail.gmail.com>
Subject: Re: [GSoC] Microproject: Updating Documentation
To: Junio C Hamano <gitster@pobox.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 3. Incorrect Config Function Reference In the "Implementation" section
> (https://github.com/git/git/blob/master/Documentation/MyFirstContribution=
.adoc#implementation),
> it mentions git_config(...), but config.c doesn=E2=80=99t define it.
> I had to use repo_config(...) instead, which isn=E2=80=99t documented her=
e.
> Proposed Fix: Update the doc to use repo_config(...) and explain its usag=
e.
> Additional Note: I can also edit the config files to appropriately
> correct the git_config() function if needed, but I=E2=80=99d require some
> guidance as to not mess up other programs while doing this as I
> believe config.c/config.h is used by a lot of other files too.
>

A small clarification on this I made a small error where I said
git_config(...) was not defined, I actually did a grep check and found
the wrapper function(#ifdef USE_THE_REPOSITORY_VARIABLE) , here's my
updated proposed fix

To update the MyFirstContribution.adoc to use repo_config as the *repo
is getting involved with the cmd_psuh. As this would be confusing for
many people at the start.

Thank you,
Jay
