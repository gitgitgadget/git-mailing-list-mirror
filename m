Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D975240
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710648226; cv=none; b=beGOF+xfIZ9lCZ9pQe1HOAj6MH5Twyj1XI6leimT3QOWBlu7BoW6W4Uq+vYW2GSHJbPG/YGZENAY2SduS+CoCnsFtOCdZoM78n1Ih6beCzOnMcl+hFM+hM8xlznjLZdAK4F45jDVe4obcxeY2YEfQJ05Tf9mxZ4ySVUHFPueans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710648226; c=relaxed/simple;
	bh=LSgP1OjRis2iR0s22OiOisAIG2AaiA2ETa37quSOTn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6X3n3x2tPNzutysAyf0tnrSQ4gcwCq0OpK4Psi9TOgJxRklzxl5k3UoFMMtbF1S0Kui2KQG2YVT46yImlJD9hWe0o3zXpVQHUokcRbg5inhIkhyVTEG9jtsCnE2qwt4VXlkdVhO10USqaJTSz/kZ3tM8WGtd8QfRcUspzBtqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f41af71ebso27651136d6.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710648223; x=1711253023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy0oyUapuMatkKcmDUVavWVphu53AljEY31Xa3uZSsk=;
        b=T/IKY8Rtb7IHpGG83ylpcVc1bL/JXVWGjRlDAHKvI84PeLHbVgcFv+D5kzN40tW99C
         5yHjgV6ZkSF6Jauz8oOrngF//4OrGY/BysBleKouYwrS4dKtxQuFwaiCeCDQcnPatGtM
         o8gCC+Zl+MgU/T5JJovmQ4EWKembevRrMK24DwodH9jJeQDRv+TokqQj6NsGBb4XGS2c
         Lu7QKrXbZvswnciBBLDJi00QjfhbhDojigoR7vgIFO5KpF+ww3dbPXEATOhhaMLPWfdD
         9sE0flCW0HWSW7jrmfq6cuEyZMx7xVTLNi/FYgEG+024hybdkJnU33z8o1CMjWGMGVUo
         zjWA==
X-Gm-Message-State: AOJu0YwQya/XEvsvqI3UcEYFpGukZuQCHNhLxGPuibjc+McDU/eaPDs3
	0oG37ynJ5Hp/GLD956tD2WQoUKzAkXARWTd1lz/YPfkGicFuR5tXZ1raba5qYN4pitiabcFAeiT
	K/VMu069KYxf9XWBayje/8cqF8+Y=
X-Google-Smtp-Source: AGHT+IG57tXdRqJeXL7SOomP6E1Ui5WlNdORgrLXQ3jIsmR/wFxXX7r3SQnmxsctJBbqW9mADPcDtS4R2ZYFpqZ82YM=
X-Received: by 2002:ad4:4b73:0:b0:690:aaef:7f0f with SMTP id
 m19-20020ad44b73000000b00690aaef7f0fmr9150337qvx.3.1710648222946; Sat, 16 Mar
 2024 21:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710646998.git.dsimic@manjaro.org> <480b46f2db82ea9c6cd9bbc2423923f81f2d36f5.1710646998.git.dsimic@manjaro.org>
In-Reply-To: <480b46f2db82ea9c6cd9bbc2423923f81f2d36f5.1710646998.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 17 Mar 2024 00:03:32 -0400
Message-ID: <CAPig+cSLb+Rsy81itvw9Tfvqv9vvKSPgO_ER9fWL04XZrgFvwg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test: introduce new x_to_tab() helper function
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 11:48=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> There's nothing wrong with the already existing q_to_tab() function, exce=
pt
> when it's used on strings that contain uppercase letter "Q" in its litera=
l
> meaning, which, for example, can happen with git configurations that cont=
ain
> "*.*Quoted" as the names of their configuration variables.
>
> Thus, let's introduce new x_to_tab() helper function that does pretty muc=
h
> the same job as the already existing q_to_tab() helper function, except f=
or
> replacing "X" with a horizontal tab (HT), instead of replacing "Q".
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -107,6 +107,10 @@ q_to_tab () {
> +x_to_tab () {
> +       tr X '\011'
> +}

I'd like to push back on this change since it may lead to an explosion
of new almost-identical functions. For such a one-off case where
q_to_tab() isn't appropriate, it's perfectly fine to simply use `tr X
`\011'` directly in your test:

    test_expect_success 'foo' '
        tr X "\011" >expect <<-\EOF
        some Q stuff
        whitespaceXhere
        EOF
        ...
    '

However, if you really insist upon using a library function, then
either add a general-purpose function which accepts the special
character as an argument, or just retrofit q_to_tab() to optionally
accept the special character:

    # t/test-lib-functions.sh

    # usage: q_to_tab [<needle-char>]
    # replace <needle-char> with TAB in stdin
    q_to_tab () {
        local c=3D$1
        test -n "$c" || c=3DQ
        tr "$c" '\011'
    }

But this is probably overkill for a one-off case.
