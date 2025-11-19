Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6E26E703
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590834; cv=none; b=f8lbMRIqFrwKTvNPKDsxM/5iXz/6BW8MPEJYXcYoWt6eyEpvL7eh/XGItATZQGw9J6vtGz0wsnO9iiFS8kdqB2ZwILF3VZ7C9upc30vdPa8nBFhMOYIyoU3EB+mnovBl5FMqOZpc6tX+99qggIJpD+L0nQsliY/OJyxeZZoucac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590834; c=relaxed/simple;
	bh=jvVYWz4ZwscAupoA0wHYTRifaXWYWkTVGSoyRRf9d9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnraqKAaaCj5bxts6jR/Mi2ne+Ai3DQ0wRKV3l9HI3mlKy6UKfy+vcXbjYyUAONowMSAB691K9oWrzTVl6O2S/1ghyoVDb0QvI273683tqh+I4YqKbFtx4iTRQ5M8wB39qZZLseem4o8XWSe94xREMtQiAX+FgYUcVNh1ue4U6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b15173c4c5so3696085a.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 14:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590831; x=1764195631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STfAeXGfcKDlnguQUMCR8IoC5lN77doiaOp8ZD01Cg0=;
        b=Vddk7ZRb/E8n0CWMG/LUqHvGP+pK3mFXIaCyPSXBIFN9+NKw2dyr9ZWT84kFVPs+VZ
         5sP6ZpcfgS+EBU6fYUR03vaSt9tgR/mAyYv899g2jexhEYpDrDq8mZtWPzOWAPPLd7vE
         YRFQKwNxNWe7O0SCBffq18MpknrmacdMzsm2kORbatu/px3PnnyKMvY5psjk0RaACwA2
         JgjbqraJXglRcn1iUu8hyTYLBXAFoFWM7O4JxQGoJXUrrLGdnWA05htq9e1vQNygOeKp
         Zako0aspDLGuCrWyFiLTP6/FScIts3u0GIBfsGyVL/Y+H0sretJR1AMlyfsZ4ZG8D0i0
         J5vw==
X-Gm-Message-State: AOJu0YzZKpr1co/uDczCxrv+e5T82NCU3o0t5g+H1B+RgkRMD+MNvfYq
	9U9xdhNCcjQEHm30dCGAhPSVEY01Bh0QFWKH6pqXfGptgEW25XWHRAohReuPoTBSajzH5Di4aoh
	Ton1iJWRs4nZgOFZVna3bQt6W50JwqzQ=
X-Gm-Gg: ASbGncsfPVOvFQTr7MrU+mSj7nP4iGau4lIR8Ay/aE/JhC7iicltfWrXZ2E/286Fsb+
	C5Wf8Lcdrbnam6qJMK0PVRe/oL6L50pL2hn0/OxrHtYRxTyY07OZuW5qQc8RYYXWmaZtqHmcJ05
	Hyjk+lN7LLy4MnRtd+EHH5XJ1n8GyR5H2PZj/L3dWqBz/LSCvggGPl5dFw/x5iAg5+c+lPb84Xh
	m+H9sK8x6GaUsAe9Bo6JdjAXYPLWK/ACMjS5SzKFvOeXs1lsOL4looMum5Ga3oXRMGrfOqDfAiw
	VftDPshnrA/4/1E1g+aO65uYgXnayo/Sqx5O69LbRDn7Nm4=
X-Google-Smtp-Source: AGHT+IHZB3juho/W2AoxgngQNdYwQLXTCjAjXbwBx9HsJD1p6nTXM+aHStYZ+LnlwKv5iPgGHlc4pdjoiA/ivWteLPM=
X-Received: by 2002:a05:620a:40c6:b0:8b1:fa2a:702f with SMTP id
 af79cd13be357-8b327332fadmr119055485a.3.1763590831290; Wed, 19 Nov 2025
 14:20:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com> <20251119-fix-tags-not-fetching-v7-3-0c8f9fb1f287@gmail.com>
In-Reply-To: <20251119-fix-tags-not-fetching-v7-3-0c8f9fb1f287@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 17:20:19 -0500
X-Gm-Features: AWmQ_bnpX6tl0Vjt4X2TVZeIPWwClD8PZecJIN2Tj16oPNf8nIPRa49wMgYviqg
Message-ID: <CAPig+cRjN85S3oCvazAvUD_V0EwkzdvKAm+DC66+uVijF5=HQA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] fetch: fix failed batched updates skipping operations
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:47=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
> Fix a regression introduced with batched updates in 0e358de64a (fetch:
> use batched reference updates, 2025-05-19) when fetching references. In
> the `do_fetch()` function, we jump to cleanup if committing the
> transaction fails, regardless of whether using batched or atomic
> updates. This skips three subsequent operations:
> [...]
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -1639,6 +1639,93 @@ test_expect_success "backfill tags when providing =
a refspec" '
> +test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates =
fail" '
> +       test_when_finished rm -rf base repo &&
> + [...]
> +       git init --bare repo &&
> +       (
> +               cd repo &&
> +               ! test -f FETCH_HEAD &&

Is this supposed to be asserting that the file does not exist or that
the path is not a file? If the former, then test_path_is_missing()
would be a better choice.

> +               git remote add origin ../base &&
> +               >refs/heads/foo.lock &&
> +               test_must_fail git fetch -f origin "refs/heads/*:refs/hea=
ds/*" 2>err &&
> +               test_grep "error: fetching ref refs/heads/foo failed: ref=
erence already exists" err &&
> +               test -f FETCH_HEAD
> +       )
> +'
> +
> +test_expect_success REFFILES "HEAD is updated even with conflicts" '
> +       test_when_finished rm -rf base repo &&
> + [...]
> +       git init --bare repo &&
> +       (
> +               cd repo &&
> +               git remote add origin ../base &&
> +
> +               ! test -f refs/remotes/origin/HEAD &&

Ditto.

> +               mkdir -p refs/remotes/origin &&
> +               >refs/remotes/origin/branch.lock &&
> +               test_must_fail git fetch origin &&
> +               test -f refs/remotes/origin/HEAD
> +       )
> +'
