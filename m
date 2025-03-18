Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48F1B3957
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319590; cv=none; b=RIvJ8ekjMalYwLkOeh6FghghoXrKPvN+wdN8q5tMtyA68rjbPUbQT4USsAKxEfawBK4jnUZSGNywj+fv2KtWy6hDdVYzB9P8eHVCVnBh55mxsxlsSW0ZjYv9AgN/Dm/LtXx1pbi9RGOSIBTP/KR1KpnHgR743sRHM1YsQR7gSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319590; c=relaxed/simple;
	bh=VedrHk2XNROp/dFHZqmDrvK1R35korbUSeU3E2pUmrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiUl2j3T3qQOrmw8LziUiCRjqeXY5yur5G3BGyB8JV+E0tbHrW2C5Vn9+uWdwdP3flwg+MqwNptKAYwk+pBnqJPO8kJ7m9FVXbvN6k2DYQ9lA4kxNohSxqf1rGomVdf/db7JNZGwqjyZ2rTDKz/kRS8cZyhDfwCRhAjESOfTdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6eaf348103cso6955486d6.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 10:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742319587; x=1742924387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/cWLyeZl633FObgrMhLUweMaq0BkdT8th6OrxFNvR8=;
        b=sKUi5SSD4Jr+n8aAYZlQZKd9oL44Tbbutgg/6V6Kt6PZ0YNFqyg9SenQ2j7qN2S2YY
         ZEEGatQz5S3gAc2oReVcb19gxQMSiGZSncLkTKCzL5NDl2bOsCuPkQFhQmfHczEzfjBE
         lvpfLVRN03BQ0sfL6a7+3Ey75vm2CMAw7IXYSodbdpIK3eGVavN/s3Q9Zlp0DwnVsXJp
         bnsO1ZHzRTuwT6CxM4akycIZQklwNOWS1bD6NVR6E1pvX6Yn1TrcrDqQNEIJ1g0R86hL
         sF89+fCQ4UL+c2ssIl2fAqHMkzrYnvrJYAaZnVPTPBqqcqZGa+cjVWod/2MkmBMSPPbe
         x+Nw==
X-Gm-Message-State: AOJu0Yzqi5Dr8VtwVgTqVI2xQsBwhH4pG8MA+hkJx00VU0QFcKUDkH+9
	DGSgH51KOXVGfcdM4EavzFqxiz8uxuWMbUm69YPqdru7W/CEEPS48vgos1xXIIxNCxnVp9Q+R9Q
	gjk3NEPjBdk7VysuLWzs3qDbCoSrqp56U
X-Gm-Gg: ASbGnctfB8FINIECYY2YwTqBiG4itYdscZzHPp7K/uT9XDLXkgGCuyV18l8I7RFaK88
	GcA70UBnp+qH3wJwUgSwjeXNQZ5I/fepGOErXWJPcCUZUFTQ/dSDf55YPOy3G2631+cgVTnrz2P
	wNKUa7zc2M5fgP85ccF7BJU0l9p3+rK2cDwUE2cLYncm7VS0d5XgNxxUrqfXVic4W4kTbgYw==
X-Google-Smtp-Source: AGHT+IEKHUcVhtyjkagDEqOfNrJKpjKap9l88Hep6OkiqBusSRTWUQKRHhuGRpBD0BkvA4z0xtYe8zkwgl4EZLRJQVs=
X-Received: by 2002:a05:6214:260d:b0:6e6:62fb:3504 with SMTP id
 6a1803df08f44-6eaeaabd7aamr92583476d6.8.1742319586962; Tue, 18 Mar 2025
 10:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1918.git.git.1742299111861.gitgitgadget@gmail.com>
In-Reply-To: <pull.1918.git.git.1742299111861.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Mar 2025 13:39:35 -0400
X-Gm-Features: AQ5f1JoN2-7wiNr88OzkNLq6VNU_RO72U_gaEHG5s6HV2621Aitfdg2RGD_h4KI
Message-ID: <CAPig+cQrCdtN4+hyZyPWQuvnoetarbcgkwKU7cD-TpzfzK=jzw@mail.gmail.com>
Subject: Re: [PATCH] [GSoC Patch] Modernize Test Path Checking: test -(e|f|d)
To: Sampriyo Guin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Sampriyo Guin <sampriyoguin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for submitting this GSoC microproject. See comments below...

On Tue, Mar 18, 2025 at 7:58=E2=80=AFAM Sampriyo Guin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> From: rimo <sampriyoguin@gmail.com>

This name should match the Signed-off-by: name. Since the "From:"
header is generated from the author information in the commit, you
probably need to adjust your "user.name" configuration to fix this.

> test -e changed to test_path_exists
> test -f changed to test_path_is_file

People reading the patch would like to know why a change is being
made, so this is where you should explain the reason (for instance,
"the test_path_* functions provide better diagnostics upon failure" or
such). As Karthik mentioned[*], read the "Describe your changes well"
section in Documentation/SubmittingPatches to learn how to craft a
good commit message.

[*]: https://lore.kernel.org/git/CAOLa=3DZSkMp+H9PZeBZXK47=3Dfx1sH=3DS54AuP=
T=3DoUosm7F7V8MGg@mail.gmail.com/

> Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>
> ---
>     , Jialuo She shejialuo@gmail.com , Christian Couder
>     christian.couder@gmail.com, Ghanshyam Thakkar shyamthakkar001@gmail.c=
om

It appears that GitGitGadget didn't like how this list was formatted.
Instead, place each recipient on its own Cc: line.

>  t/chainlint/chained-subshell.expect | 2 +-
>  t/chainlint/chained-subshell.test   | 2 +-
>  t/chainlint/function.expect         | 2 +-
>  t/chainlint/function.test           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Let's not touch any of the "chainlint" files; they are checking
validity of a completely separate tool ("chainlint"), and have nothing
to do with checking Git itself. Instead, pick one of the t/t???-*.sh
files.
