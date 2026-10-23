Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792772601;
	b=WecZaYgFV4SMvUXwZHG2OQsJ+VfMCRxPMRv/ZGt288BNXNvpsXU2wZe+37OdqCeahB4E
	 0RhdZIJzesdN9ouDyVSa8tGFkoR+ncwdnNAk6Td78bqmZweGbVEjHxsiZS7nCYcLQ3CQB
	 mu8/CqMMsBOPshw4WSnBYL1TnOc1+gnn0oZqjPEYgDYzve4bZEAnWInZcH4/z/G/H5NNE
	 GnT4BSoRC/oqDIMI0Y7nxGrThj/DPGCLx9putGHgFYw7r6pb0vCXYA/pC4E+11+sPHg0s
	 mZHYmJseq2HY1xgems1VDPXQBJkp8qCcRkOGXlJmrqUdEHOp6nCwQ0uMCBaTjnKVCwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0X6S0XiIK4GCTBbQIzDl+cVrHDphNy9rQEAGDu7PjWA=;
	b=AGMgY19hqEpD/bhpoUMBooD32b7cVqn5oiXDjfItlz450LrZhjJGdE53YgMDQf9biv4b
	 5VNnUAacsLUfaD0clQQckddVnzImnhvgJPZmpeaIKiIH770rzFLH1SPkWj0Q2yOY8JPcB
	 ivwlc+mGKFJLwmbYEkAOoKFm8EeisZnRcLCLMNKHIPohyGml7a0lKOf8wVQvK0H8hRFfe
	 qfCosVuf7mgPhWLk+iY4mn6g+3OrXHL/l5vHvQD7njjNTyElkyz8p4VAftV0OuLh5w02G
	 ROWDeQhirlkrDu/WZ3nyDhHNYwbDNcVN8qKcHL1rZw5LjtX8EGgdmxSyi9r++ThhaVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T9B37Oak;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBF606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CBF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T9B37Oak
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917aca1aee5so11496936d6.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792772600; cv=none;
        d=google.com; s=arc-20260327;
        b=oiYvewUFNRLjZRo2XPgHIh1UlLlacGC9YiBGq5PU/UJDrPuOwoe3Ds+o6VC36+ky1p
         Y1BQYO9dUgR+5IWNGxlgIBDZI2nJfrwpRqT31PZSIxxyq5zwbqMdZ/zMOSfEhyPRBQNb
         4LgLizbKoogHP3/UQUPb6Rmj7uSeTCcj+ts0xg1uwzptb1sgtwQupyCQ8UsuOv1v4dpI
         2wQRkJ+tbTjUPd4bJo4baNz5MJceGd3Kx6MgaKWfLINAVfCI/d8qXL06WkCrpqWZFvdw
         D4Fp+fEJL/X1O/7nS1Dj4dbO1Qcc1DtLcIkWMo57Z/DfKIgQfPp2CSHJppOPXbdZsXxK
         TptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0X6S0XiIK4GCTBbQIzDl+cVrHDphNy9rQEAGDu7PjWA=;
        fh=dG9E8zcZGBEMjnWCbCAvqFLCKX4Iz4bLTgQVzy4T4vc=;
        b=IS8f+pUUz6XHUcksc9zid4jZ0tl8qdURTvMvGL+jJ9qcZxap+1vq601kWZSfwi8yaU
         hhF1cxfI6cDNAzne155f73J380BT5Gj0B4PN5nLpSO7wlryoQMMaJKSmX5UCJ1Fm+aXi
         1FZkqIXjLKYd1Y2Syap78NXCE3hhxDFBVOiY3LU2nxfxUK6ZXfLbZ6/EE/2cJILdKFuS
         5rQzJifQB8zolsHIgT7w620Yr18LDDV/9ywBuzY/cGIJdXQVIflHjV+BOqO9/Gu4sW9X
         2ePfenWe6kzdxw1ilH2tQRVYa5EEBqj6cfbj53MMiAQQxfUav7pr6hNFEkfQPKHeZx9G
         Ei9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772600; x=1793377400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0X6S0XiIK4GCTBbQIzDl+cVrHDphNy9rQEAGDu7PjWA=;
        b=T9B37OakxmnwRit3PG1pdIUuiv6/8166tFwKw2spjF2HJzjJE8Q3hhePDpxh0rv7l4
         fTD5jOJY+g0VJFDPMP8zOX5OFUlSlTKiowfdRxucM3ryWp7Qguq1+fdZHNe+q+4Sd3Gn
         4NmgXWrRs+YGIMnQjn1RLiRLD4KDN3hwOaDC7QDGWYmzSGTKVljNOtjGYtYk0HTSMxWi
         wyT6aLxugfF6WwuPxqJ5H8/c4mSYjXO9DpDjyd4B2GfpM3rqhstvYlLplikZ1DmdhYCP
         bNZq2t3NmALP3NPh50CEveFUc7GczpgrkdBJEsbmSpXtD+u/sle0fDTDwTZZDQ6nJeFW
         fCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772600; x=1793377400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0X6S0XiIK4GCTBbQIzDl+cVrHDphNy9rQEAGDu7PjWA=;
        b=QdEb+oDJZImealOxx8q2PdtDfhevOPJ0wsHc3h3Ddq4H7i19/1uGLZ+L3PW70a3qXW
         ZN1iYpfGYAm5qSOOPL+2RrEsvzKjBqxYC9E1PEe9cBqinsz5ZAtCgwm654bMUZtQC/PV
         /kJMQcTE5hjSgUvoxBSpUaEMA2eTaxycHqF0p3Jcv0CkWoLQx4MXCoGSR1PK7y+M7S+C
         OYj9EnOxFsQVhyz7wGdkcNACDa2KjZnNOVKEP35sgyGYlvAmknXJUI66hYIZR7gs99Dz
         9OziitzcdO4154wBWVLp0IQM5DDcTMM8eBlexs0MeXSDagzVwno4Catx5a1DOnS1jxE5
         e+Gw==
X-Gm-Message-State: AFq9FYKTYVsxmRShOGRfi6IM5fpBgtElvKQdN6FZgYMA9qYEp0U319DK
	TYmFsQWH8f7JGdtiXUtG7lJ/ZimQObcRTHzxvP61vFL0TeQu5QoJ0OHANbSyU1LSc9Xh+K7n9wG
	AZ8mR8Cvtp8BF58bXX7lxhw76E2O8U+IPIQIEU6o=
X-Gm-Gg: AYBFou2fNZnOlBVZ9wMEaC2TSECaVdzUU3VN+xF7L0rnysCMIjSvAnzjN1c/Mi7rlFv
	s4ttyBH31Aw+B4CJGVvnZtEAnC/d/ysNwGto0CA/661Ac7v60pEhCECHSwik+Ua2NDh4YkkA4OT
	Xd1EAsHp83kmtQ+3AGIlEMDPCts4BaBBYyUAGqqHF4Eyhu3ipTqj3/ueHwKDYcQkQmtt6kU0XBr
	Nip3wpOus5ZQBBxiD2koTkb41snym+4w71J4kENtgBDb0yEUNeh2IIPt16cMKw1FdDqkiBOcsI0
	Vgu6ng6zhY2k1WkazM01Q+lMuZC7099OPBll94N4tVEJ4I9uCeAvYU5BwohRmX0KbwgSK45Yxn1
	sENfqaaKXX+Gh8C+HjsP1cnH0snpZ3jKfbsOPnXVWN2kwZkTkNKN9w4bHMhGl9uwlA3RbTOP3uf
	qQ+bqQT2OlfEbHpcBO42GkcMH2aZDiuTZbvw0TWxfePGJtv4ayAhfXu/cx
X-Received: by 2002:ad4:5ce8:0:b0:91c:15ce:66c1 with SMTP id
 6a1803df08f44-91c3a8296cemr37995286d6.16.1792772599876; Fri, 23 Oct 2026
 09:23:19 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com> <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com>
In-Reply-To: <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 23 Oct 2026 21:53:08 +0530
X-Gm-Features: AclHuK-cXGI6B7YlVmFew2jzOfxZ7FnlWkgw6frxbhC6KSC1yyZhoABrFs-Z6w4
Message-ID: <CABh_KWjPyBGYg7sTAg5Y7ik=qkDQJCLRHFfCiOr5O+3=mCYBPg@mail.gmail.com>
Subject: Re: [PATCH v3] [Outreachy PATCH] t0001: avoid pipes in test scripts
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have submitted v3 of the t0001 patch to the mailing list.
Just a quick note on the CI: there is a single failure in win test
(5), but it is caused by t1051-large-conversion running out of memory
during a 5GB conversion test, which is unrelated to the t0001 changes.

The patch is ready for review.

Best regards,
Srujith



On Fri, Oct 23, 2026 at 10:43=E2=80=AFAM Srujith A Poojary via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Srujith Poojary <poojarysrujith@gmail.com>
>
> Avoid piping output from git version directly into sed to ensure
>
> that any command failure is properly caught by test scripts.
>
> Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
> ---
>     [Outreachy PATCH] t0001: avoid pipes in test scripts
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2260%2F=
poojarysrujith%2Fmicroproject-init-pipe-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2260/pooja=
rysrujith/microproject-init-pipe-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2260
>
> Range-diff vs v2:
>
>  1:  7d118290ce ! 1:  a70ccdf49e [Outreachy PATCH] t0001: avoid pipes in =
test scripts
>      @@ t/t0001-init.sh: test_expect_success 'default ref format' '
>         ) &&
>       - git version --build-options | sed -ne "s/^default-ref-storage-for=
mat: //p" >expect &&
>       + git version --build-options >build-options &&
>      -+         sed -ne "s/^default-ref-storage-format: //p" build-option=
s >expect &&
>      ++ sed -ne "s/^default-ref-storage-format: //p" build-options >expec=
t &&
>         git -C refformat rev-parse --show-ref-storage-format >actual &&
>         test_cmp expect actual
>        '
>
>
>  t/t0001-init.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..c8c74f681b 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
>                 sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
>                 git init refformat
>         ) &&
> -       git version --build-options | sed -ne "s/^default-ref-storage-for=
mat: //p" >expect &&
> +       git version --build-options >build-options &&
> +       sed -ne "s/^default-ref-storage-format: //p" build-options >expec=
t &&
>         git -C refformat rev-parse --show-ref-storage-format >actual &&
>         test_cmp expect actual
>  '
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> --
> gitgitgadget
