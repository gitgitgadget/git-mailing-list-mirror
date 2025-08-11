Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C881D8DFB
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951680; cv=none; b=AOYTPpz2pMdfS1Pom7deZ7UCqoARZaEPxlLYK+DtNwnHKGSjMBmhUBVt60f6KpL3u98aOoYA5kgx5Huq9m0v69uzMzzx1/jWs3NZAR25IAGov3o7IrGoinLKAQQTMgDvb07xXNTGuhVi7ZhRKWzhPNvYjmNLCIUSPbnaqri3pIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951680; c=relaxed/simple;
	bh=fd0aL5RB+WeuRGMO1NyZkYxvMeOS2wG2CZZwU0ThDow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIq0tX/Q7cSAUiidsX5OCg77Pp+rvEuFz5IumTTnZ0Cdz+gOP1Fbh6Jnkn5IHA63EubdOIi2ssgNaSKFkMeb28S9ct25am/BcKjcndzPE+rfWhccJ9Ft94TIZJs9T96qD9k+svJ4TZuV8HKEj0IFk+o7Bs7uIoHX2H4HvrFxc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0742a1d95so10509811cf.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951678; x=1755556478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9sCViDapXA6Z9QMyHm9J/At+NbX3Xj0CZto3K+qyGI=;
        b=ihv+24FMZ1k3QSWPOZkjECYwJA7HH/nyhs3tK7NN3pO5E9r45y8cyu6R0L8g3QuHWk
         AcvzGTnm3yTvicYecRZPAW4e16+78xAVZ7i1Yd6MKZpWTj1dSA0jEOMD1L99xlepXCgh
         pRccdARmo9HaaqsVwdljkI4YOcS0PUSCKYgiDZrPbHzVvej+da+8uDpWuBQcziGEdCls
         NhXZKwJg/+P+IkRLfZiFmHr8hlZn8QOcB0leq+/QDiZVwNZAPLJKkn2L6GK32nbqY7wi
         w+pkJnBFK27bUGetM98QZ0qJ6rTOlSywyUi+SkhcSnjdbHGqGkZrNyPVMCnEM839TLaE
         o83Q==
X-Gm-Message-State: AOJu0Yxah5VqNRbzOVzQRdi3Ds1h7QyaS6Q7p04Zq1knwPpkiXpt0h3k
	0pA3aB636CpxID4zrf45JXoWrMW6MOpqdKqtoJS4nZX+90tIhlsyxnHA4AccaIxhf/zJ9hKbo9K
	uYc3cdEN6siSjLnqAODxdmJ9El+ClzR87K+vD
X-Gm-Gg: ASbGncvBy0JJa2aaSG1WIWIFU3Yv8IMAXNHbMFL9KkeB5OnBQGtI+x/PeuxtG8X9wR4
	pDTxLoJbu370G2IhSE0zyDZ45N05g2nhm/WRsyneT4ZIbe2Y4plHtE/xMHx2h3j0/kfs7PRCCLL
	URmAtvF2yPVwVuzQp82zi0I/nE9RKkx17GrD6HTZiFDhZtdkjXJNEUfylQpHzs5NxE6YGJE1v0G
	9Esjpt5vsbNN4cR26bEqMKsmWLDKlUDIsNENZFDa7Q3JvRGSmQ=
X-Google-Smtp-Source: AGHT+IHFAiXTJtONCTipmsRmN0J9BiKtTkBS9mT63WroirAp5mViTfir+Hkk7S6bS8FX/BhfULTJPuYegeJM7CwT0MA=
X-Received: by 2002:a0c:e343:0:b0:709:d664:3cf5 with SMTP id
 6a1803df08f44-709d6643d2emr7419786d6.3.1754951677766; Mon, 11 Aug 2025
 15:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810160323.49372-1-ben.knoble+github@gmail.com> <20250811221706.67168-4-ben.knoble+github@gmail.com>
In-Reply-To: <20250811221706.67168-4-ben.knoble+github@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 18:34:26 -0400
X-Gm-Features: Ac12FXzRKNDgPYkjlEwR6UDhFOc5rI_iC5jhbsl93nGIuwpGukz098oiONx1FMs
Message-ID: <CAPig+cThhm8b2vE=vAHYc5cEA9n232Lwi1c+p=LV9hK4hz=0Hw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] t7005: sanitize test environment for subsequent tests
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> Some of the editor tests manipulate the environment or config in ways
> that affect future tests, but those modifications are visible to future
> tests and create a footgun for them.
>
> Use test_config, subshells, single-command environment overrides, and
> test helpers to automatically undo environment and config modifications
> once finished.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> @@ -34,61 +34,57 @@
> -TERM=3Ddumb
> -export TERM
>  test_expect_success 'dumb should error out when falling back on vi' '
> -       test_must_fail git commit --amend
> +       TERM=3Ddumb test_must_fail git commit --amend
>  '

Don't use one-shot environment variable assignments when calling shell
functions. Instead, you can do this:

    test_env TERM=3Ddumb test_must_fail git commit --amend

or employ the standard assignment/export boilerplate:

    TERM=3Ddumb &&
    export TERM &&
    test_must_fail git commit --amend

References:
https://lore.kernel.org/git/20240727053509.34339-1-ericsunshine@charter.net=
/T/#u
https://lore.kernel.org/git/20180713055205.32351-1-sunshine@sunshineco.com/=
T/#u
