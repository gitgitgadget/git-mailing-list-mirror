Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792666443;
	b=FCI0+LuqMMDbqv14uzqLE1cVrFlGpSKLsRQ7tc7uUqQHNopcX/g2j9EXmnTh7n/EzSRZ
	 QvxRKPs3/Ku474gGzM7ieQMkCqHH8zU2YI+VZbnRGXGeioy0YZQPuDCQLeoSx/qkoD3+q
	 3sXOHHKHTuPBb+vlUCpP/Yp+yQQpGhMPmuv0sVj2UkRmCh0t1VjvOfSwG6YK4cbEyv0m0
	 0JpaLce+IuwuXk00HJ6qfUwCEUruqYoUzT8mwD8Ca3OP9w4x2+fPPIkt6pruNk2sIbLTv
	 8d/JYF01gH20eTyE3BkP5wa6EGq/bO+2NGIR//GRd/Hl7JfrmqHkFKWpy5yrlOn+LiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XGGbNmJUTG2ySprTgTanBBVNlUigaWGuFjz4xZQvpXE=;
	b=d+qSfsJ1ema4ft7h0JMz4ikDluUKAZjQ4LsAvpe3X3EYWJGwgXb82OIQwCi+bSDbGOz5
	 HZADebLWsxPZKuAFbgTfB7GoJVLrio7boJ21CxLYlKSWlQMDsV4MjdpxrHT/uC4Wjg3S+
	 FOk33LUZfgDUAFNUsK7tj6q1WRUrpGuiw1xiqn5bS/nwCAM1dF/NiC/MV2XAJBYz9kjEm
	 PdTOHNSvTBlyBept2BjJ/71KvdtbQq/vtLbpP+YRrQxLMtsA38vAGoAfThn/V/xwsKiGs
	 CSimwA+CTfyx2p49xvU1nGnTCxowc8y67aIRO65B7lgWkBthwJqzBn4GK03mSORifyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TAPXDov1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F6606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 430F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TAPXDov1
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b9e758c50so12212916d6.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792666442; cv=none;
        d=google.com; s=arc-20260327;
        b=M8IJ18ij/KdbZX4aqi8d2TlswyNEQ+WtrZ2kLm54cDfV6OrJ5whxe0C2Fw0yhqS7d3
         L4cztsC08nHRdQCamCLjRs2ezHDM0rYMco0Q+Ep41NxbKN/k3GDQbI7RmrtfxtWL2IPh
         OjadYzUQ+jKB2i2lO2Fd7Rgzuk2fF7VKw+7YZRd9f+DK/MC7imY3BhLaewnFX6X3NXV4
         /mkYPXzd3RYziGh5udTPH15t9RL2wXQt9hOuCZGpip/yVr8rpDJWJpPV3GAP/OYlevBm
         k8DkaEHG3BTkvf/isSIS31C46IazctiAzVVzQKPFVDvYgN5kobYoZdoNHDNk2taz06Xd
         X80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XGGbNmJUTG2ySprTgTanBBVNlUigaWGuFjz4xZQvpXE=;
        fh=AkU2g5erGhc3F0ZPV7h+0K4d6mWoSpe+4EjTk91+B10=;
        b=KelTYctutZKFQDirdfireyrlwpfUFfjx6CESJw5Js5tGtlOPc2S3VU4H2HjUb7XW0r
         JE/908rWH2u4NsbS4Hw79OdjB0V9PMmRztd1tdr4Bc8P4RgSbKrXXwfRFzZCsBxlPT/7
         s7mMrxnhv1sdZe+EKyQgbMwGU8up7KX8EJ7xRxUHUzf7cgkYadVH6N2bMlNEp8VnWT+R
         WHjdkhI1LRELZ8GezjZrzV6Pl00eygzD09u6rQy0k51ly8JdHpMJk73lz7lQk3jJ2b2Q
         wgCNEBRUorurYqMEuWd9u0VACQTHTOtOOzbQzKXsbOiXu8ruEmmCleuQfB/QuQNzIphe
         hQSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666442; x=1793271242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XGGbNmJUTG2ySprTgTanBBVNlUigaWGuFjz4xZQvpXE=;
        b=TAPXDov1IJgDl52xU2ekmoLfXU4DRHrZBfbijJTD+uw5PSlnjHkcC/FEg8abHBvfEp
         qqsBNItuxcPPny3iAiVe3noF5PxMxUlahBKLL8N6RIQSc21qirCWrr8HjexiMF9qa0lO
         vYp+9V7z4J4sN64DeXuOdyhiBS9eOnI025ZQ0UH2zNEpdQI9VcA6MaDOuyBeNDObk1uS
         +/SrbBlvFGfcFmmMLL8v8NN021lOzecLYnKnRI2J8tUXK+L1RjZu40GqdShpm7POOKGs
         XmSYJ5//7KleqZRJr8L6FsKEhlf6IhcmI9YhzNILg0ZhaysFZiPrGJly9wN4xkIZ4d5w
         uY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666442; x=1793271242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XGGbNmJUTG2ySprTgTanBBVNlUigaWGuFjz4xZQvpXE=;
        b=aMifr+eIoEreK+2qt2FvGBilCLcGRkLXipD2vgdWFlLzJ/QfTDiUsk9DI6Jo59+gOI
         P6JgGXioAsnFDiithWDKmekx9qOOWUdUaOZg3zFv/GWIyVTvPMiCVMfRJVvIFWTeEBnB
         23PyLgGUFlKhe8scs6LPBOBYcmTzJscUso0iZQo3naugQJzqVTMEtbCW/4JaU7TRtBso
         ulx5ZuypNI/NWe9IHK2nKjSfcalyfUt/FB8sljPKzpKlIykIeuTOAnNQfJ2wEHsk1gZr
         5WG0i3cEHFbWEFk7v1pJ2ggC76U2M4iCAb0Fkrz6UKhI0vKthaqMsMiRzXDwNTISjf1h
         GZtA==
X-Gm-Message-State: AFq9FYLeK46t5RfWr36xevqvcyU+D6hnwwVY9mUNd5CjJxeSU8acz7A+
	P4rNaEFAPeQJbm0TF7X1c5koBBzQeLjUDEEE73ZgJZq/0xwKbGYO0hnB45q9rhZkqxk3Qd8gqPU
	zA+5LpI3hkFwgtPdE7Ply5x5JECIrGP0=
X-Gm-Gg: AYBFou3RAYvLgC32IpxJUhCqscNUlsh47IBrBC70DdFIb1itFJho4rrhzybDRBiqlua
	IbSEB/Rl2f+XHtSNGkhl6PwTd8y03glk8qY4d3RJIbW70uJwbXaocaq3yGxKlaZKZ2VXCkRmIXV
	BFPIZOkZiDkotiWOE6SMdwFzv+x1HHpZRwJLmnUh5FoLYlmjK7d4nZ39qPHplqD48/ZCTKsjTdi
	AS34NCuIN5z6VMijSwR5KwKnq17HHEpFfViz2j7FGEB7rWCDmKIkkWL33oTlgMlHxS87m0wo1OI
	WGW2AiGpTSsok69dYTtveZPbrW/hEDip5YIxKQ7Lw9B5Q8sk0EdkXoukkf7eXt8/HU6OPBEOFxc
	gfggplhHva4XEDkztrrk2fhTXZJCP8ZD5ZFhGVZhU8mbygZJZphvfzEuMi8Zv8lmk8jJba64=
X-Received: by 2002:a05:6214:21ef:b0:91b:9c08:fc6b with SMTP id
 6a1803df08f44-91c2337db3dmr33210976d6.16.1792666442163; Thu, 22 Oct 2026
 03:54:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com> <pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com>
In-Reply-To: <pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Thu, 22 Oct 2026 16:23:50 +0530
X-Gm-Features: AclHuK9MYTX7PiW4D65WatCoBwpt1TB9ECiNQ-LqJEW2Prrx_g9fXFctlHhJ1Ao
Message-ID: <CABh_KWhtBBKGn1RMQxqBLLpDh5hMEJwCe_2jCW=nru_wNYFQRg@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t0001: avoid pipes in test scripts
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

Thanks for the suggestion! I have updated the script to split the
command into two separate lines as recommended and resolved a trailing
whitespace issue.
I've submitted v2 of the patch to the mailing list via GitGitGadget.

Best regards,
Srujith

On Thu, Oct 22, 2026 at 4:20=E2=80=AFPM Srujith A Poojary via GitGitGadget
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
poojarysrujith%2Fmicroproject-init-pipe-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2260/pooja=
rysrujith/microproject-init-pipe-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2260
>
> Range-diff vs v1:
>
>  1:  92ecaec2cd ! 1:  7d118290ce [Outreachy PATCH] t0001: avoid pipes in =
test scripts
>      @@ t/t0001-init.sh: test_expect_success 'default ref format' '
>                 git init refformat
>         ) &&
>       - git version --build-options | sed -ne "s/^default-ref-storage-for=
mat: //p" >expect &&
>      -+ git version --build-options >build-options && sed -ne "s/^default=
-ref-storage-format: //p" build-options >expect &&
>      ++ git version --build-options >build-options &&
>      ++         sed -ne "s/^default-ref-storage-format: //p" build-option=
s >expect &&
>         git -C refformat rev-parse --show-ref-storage-format >actual &&
>         test_cmp expect actual
>        '
>
>
>  t/t0001-init.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..02217a9bf8 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
>                 sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
>                 git init refformat
>         ) &&
> -       git version --build-options | sed -ne "s/^default-ref-storage-for=
mat: //p" >expect &&
> +       git version --build-options >build-options &&
> +               sed -ne "s/^default-ref-storage-format: //p" build-option=
s >expect &&
>         git -C refformat rev-parse --show-ref-storage-format >actual &&
>         test_cmp expect actual
>  '
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> --
> gitgitgadget
