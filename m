Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792620252;
	b=aguVyuHwKxIbzHCEZjVt+fsp54sWJD82xeKydcSkCD4QfPNrLzdCCR99SrXyEVKZBfcf
	 V2PFGXP3wAwJkgjajXWXtlQbDQj6uERM6Lvupb4wt3LHtjXwHY/+sAuu/BQxlmd7KSKGb
	 DeU1ES3IpugprkGWu03lGEP6SBlgNptfukpRhNHtRZPR2SpGdWQz5q4odNmen2OaM5KKL
	 XWaMsMVaVTYHAsPVTPKCp0E6sx+8fNEIAFqA2BSWJHvMf6evKQN8ob/ShDI5E3sMhNoe/
	 A6fUZxsXlRPTOnP30Bw0HLkcHShdYLxScNNp5xxlS47C3UuXRYjN8UVAWyD23lSjcBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=RUVdXE01mCOs3s8MWeVAqzHmzi/b7ij48PKYziQHee0=;
	b=ow7LmaHzDAO90lhkKy5waSKU6+DTwFXkquRfF0aCnSgHxD2T55edM2KM6K2pJHWuydp1
	 ua7DxFwg4xFowgRGZqKeD+In69c6BtYF9UlSiGRamReRAXNbzp241LoHxdAZH5Vx2shMQ
	 gOZL7mvAqhhZCeTLto3Co+tUHc1racZe91D3dgiir573la+oEFWNFxR4ldlftXsN7y4x9
	 RyoOezzR+hg2uKw96YuqZ8VxjzqjGY6woaZpXGxEmekPWINR64fiYplwQLJCWfzeJ5bxK
	 LQDXkclIRvAfJAdUWINU8RcC755zDTd9SCPHH6yM58wboqH7ZEjsKO8G1eEaqoKC2Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F+0oeoMD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED9606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0ED9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F+0oeoMD
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4677aad67bso132663666b.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792620250; cv=none;
        d=google.com; s=arc-20260327;
        b=WU4LAX0GGxWJ1M9uQfsvEInjgtc4P5HuRS6EW6Oi+OEFoLAW/tWpjOKxD4wOw+1P8I
         23gkKs4qS6ruhvErImSdsUrJTtMR9ZyrdS0d7r8iepWxZz6K9K/46sfCAi5bUcXtOXiB
         HN5D3Odungf1Y49eYLLk/IAudP0yDGapNxhgBbUMq0fIEMotT+6lNMiAEWXbwNVTh6xp
         xZ+ODpy9wFuibqHEVMgoNqlT2pYdYRI2hkyp3R+p0C17dnNNx/ngElNQW06+CmNumNvc
         OKQpDwfiFyoT1C7C+rl0evCPyE3F6VQtDkIkQEHGmr9Q8CG5KySKUSvbpaQNZhtrgSvS
         t6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RUVdXE01mCOs3s8MWeVAqzHmzi/b7ij48PKYziQHee0=;
        fh=GV+q3+xoptdzTjdo/fAURyeoLF5hkow4oLuqL90b9Bg=;
        b=s9tDwWNg/4++pO1z8N+P9GEvFEyWEm0CNT7bi1tT62SvhbYUqFY+Iy2xbqaRILnGYZ
         +TFgOnGaSwGhN7HmdaDxX7csF9onXglN6Plv3eMc37eIT1V6SOdD2bvWZeHDnvsqTocw
         8cszm3Qz/ppXDIfdZIIePeHwZT37rzJYzeaB31qxT/zI67+qRtHpzEtJX3aN40gjQbbM
         3JNydu5ttG2c6f7BnXQXo/xS8FIEkVRKlWQh+vE9yGqBLydT9+qtlW5ZIQ0lfv0nCQh6
         iL7eWdmWO+BBBDIk+A6BlN/r/M2oBcpFGh2y3cVpWHgTayHnCFWfmgUscH+trN8Mms48
         S4hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620250; x=1793225050; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUVdXE01mCOs3s8MWeVAqzHmzi/b7ij48PKYziQHee0=;
        b=F+0oeoMDhjzH1DvUXkqOpwkTZdZq435B3W35QEMvd93TfzDmg7AFWHydl+QOPAtLnB
         zJ0IrcNyBvuf+ij8I+6Zv3tMy3muVcft/vMtMfKF61kZqOsEjzSA3+6LcEE1fLcJpKIf
         QwmlvJ0O3tWdAV8IF3o0oAQBj1wO4/tFNzRIWMU67+VByXXg+YuQ5E3U7Zxo9qmQ4gSn
         Yu1grUKFQpRPdK+7PmpdC2Z/SgwLUGj4j0DD7/L6pFgXwRzsGnecvust9FtSVgmhaTeX
         9ruGkD2HJLMhyb62925ZYdkQy5C9/MSckIMqzIXHtP++4Xqj7WRJiXuHHp4g4ArWwDpl
         /Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620250; x=1793225050;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RUVdXE01mCOs3s8MWeVAqzHmzi/b7ij48PKYziQHee0=;
        b=P94c7CelAlQ/BpdSDriOdwlbgHYR04Pf+dO8aulfW0NfCGHtbjk4qzMBo/3DBPMseB
         xZSeEvyTjCi4fcj8+teDVzLWtB09KZ1X6hjow3SnfBk/doQTXxZJ0WYxsH2BtUalbJl9
         yc7jh4wVAHTFFJY1GRuUB4zfUTlB0sL1F5l7BwHRBVeawUIYyT7VITptYXnAZXU5Tqc2
         KlVeUBioC2UGeMWozicrSp6qFeMfVapC2w6LmyTeg7NRy1lR7r/bwMlvg5vUhQRy6r3o
         AFzrQtFMNaoYgtYpxoZ06mtsjJ9+K1E0LME9+x/Uw/sHd+UTfoORcw9fzgrYwx0rf8PF
         hb5Q==
X-Gm-Message-State: AFq9FYK9K6nEx7eRVyInhaGdP1rnWCpVZ29pDWwImcQqwy8eBRh4HkRr
	L61x5os8xdJFt0NpO2mQiWIDYFWRD7AQaNMm9U18ZDBmcFbPb0MW1kaYjZuqtaDAiE62SeFGC6Z
	A53vH4zSFJrhTMQlvI4P1iWeyw7X8T6g=
X-Gm-Gg: AYBFou33Do5rJDDdkx5qdLHb1jnL8roVpfcLWhTjWRof8yy4PnQxNTsdvsHHLVtxqkf
	L3qY+iDtPSlKtSCq1sy3yLFU9Rmjo5EQqZ06cRyH9O+9VqvCsF6aI8aCSUpInbMxPQHdGT/9gje
	eBUWQjmekG5unlxjKTL8RDHfQfIRiFsP5BhCDwNSMgI4Pj09qbfXJ78XTCqLPOnX8Bl6l0H8lOu
	L61fiJnu4166InG3zJGPBvNC1C9vQxmBDMtPABjTZ+ovXXDP4+fnl/YXRbJvYgJdOL7UwRKdoa+
	WWkqKXx0xuQu1SA7HOxSbSsYj6vBH5YOsMe+KVRbn6oRy8mDPME/XWgw3zyzkpba/yz4mXk82cf
	7LV+jnbAdVCdl8OFEEAUeY6W321JdSyVoZ94w4LXmrhK3/IFs3ytlYEnybHMT4WjHOVYu2g==
X-Received: by 2002:a17:907:c499:b0:c2e:4c59:a3ab with SMTP id
 a640c23a62f3a-c4679b54464mr300734466b.48.1792620249844; Wed, 21 Oct 2026
 15:04:09 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
In-Reply-To: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 21 Oct 2026 23:03:57 +0100
X-Gm-Features: AclHuK-h4b2A3dJKPUsYHilYvXMVIZa2AGjX2X52O4mdWgz2zQi2DYOnezMr5Lk
Message-ID: <CAPSxiM-Kx1=s45W_cocO+wrcaTaH7qSdqAFBwqJ0rwFAB+k06Q@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] t0001: avoid pipes in test scripts
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Srujith A Poojary <poojarysrujith@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..e835afee68 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -678,7 +678,7 @@ test_expect_success 'default ref format' '
>                 sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
>                 git init refformat
>         ) &&
> -       git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
> +       git version --build-options >build-options && sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
We can put this in two lines, something like this:

               git version --build-options >build-options &&
               sed -ne "s/^default-ref-storage-format: //p"
build-options >expect &&

>         git -C refformat rev-parse --show-ref-storage-format >actual &&

Thanks for the patch.
