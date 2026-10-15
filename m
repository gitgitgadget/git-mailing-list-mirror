Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F33EC82D
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053397; cv=none; b=qyNudR5DE57RhoRKj/yJD2ox5NnknwCq4jN0ZqFSjeh/XGdxVaq0m5Y2O96KZICSMeKOLlASY3vpWmizhZv4zfRlXg0UHJFwWtaqzgPaRJt/mUtU30vJs11isOMqUoJI8KoQd++IOMe14ELoc9iRrvF5o3vbkGPpjRikB4iCdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053397; c=relaxed/simple;
	bh=r0H2O+S/yeZem4ZIy4ltcbDPAoH8Mk15TSXxZg/d+aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB01C4XpD0I1/9DdWcN8FgfZjg9Ll1Cwh08q/BadXU6qUWNxsQDVZ7tgz3Ii/1QKkjMLNJb/mMwqxcU/PzoHwfLGHEcx3Hoxg3LyWJODC9JanQg9613kzwZQoY/eKH882DzuSr9MXtRVy+4R9cEEBXNzfV26lSIrJsWt/bzMetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4plPylb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4plPylb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso3172927a91.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792053396; x=1792658196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ot/U0QwqPw0Cp21AaY7UdtUyck6IGEDxBNBJPT1Maw=;
        b=i4plPylb71DgSuEuNu8O2EobzBR+KIfZFDcVtS84X8Ij1G5lziEoUtoHXqOSbkCyxZ
         JffEvD9oImwW7ILPQdvOtGhxjS6BkXpn/OOu8W30TRRN28NVWwAFiYEWzhzuwOXrIZQg
         JHMt62hmIsJiZ4vlT5lN3ABlvECpeSvz4Y8ezEaUvY593CBt6DWDWrer79Z9VQD7bgnx
         sxzLLVLAlV4x0HylSsYczN29ytauDDSzvkPCgESgTXEiJv6v6m5KDrNhn4WJM8CgdOWr
         IYqn1whJxeRHu1aEKGoYlbrhFLiRJRhH+Soxa9QzeAj5kzxvuvrBZ5tlWrKMf1mMyaDS
         DPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053396; x=1792658196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ot/U0QwqPw0Cp21AaY7UdtUyck6IGEDxBNBJPT1Maw=;
        b=L+eQtnbNN4OGILBrIPdDPPkQFy9cz9RwKPe2N1Q2WroMcrIywk7/cXqdGLb2M2Y1ve
         21d1hZKW1iIHzEr+jGPfVGddWKXI/MK+CawiTwXhUeq7aMEicND0gwLm9XkNnzerKOsw
         s2XRdRoGoeYe9XYF5+fm5SAK/A8IMVISwNii93eYzwkiZIHKVe1fe/RNwVDAivKJZNVD
         PJUGhFfyv9cpORRQ3O8IVkfXwCKLUvMSeAcipjBIWyY8dB6I+aJKOo5ty+I2DQfWRX5v
         gR45195cJzdMhUZmigRNUzinkqXVh/pfXdkOSTq9vLxNV2DTWptGK2dKCRa4KzpcMm0U
         sRKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7zPx5vNpwwcX/2W7BfLrt/Bjr9dttaycXm2J1hPJPwLF0/A4fVOPNGJzTNk8dA1wRZ2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKE81bTScR02fVHvmQ3eu5YxmGpAwwgb2TD2iwMd0pGUk3gqCDq
	oSagR3LkZ9cTauvoAfAdkR2/7nsTh0pIopBF2tG+mOoaUGjE6L97e3F1
X-Gm-Gg: AYBFou1ERQdrc+joLWoTRfqpJilVnpTDA4VX7gK1bUer5xdFQLcMl2EJIS70t5/JEwk
	aSBu9Be9kYqr4GGwWWOdHge47WVhcrvFwF0clpgCkdmhI2pr2iX9Kga8Uq+JbZwShzcxTRrJeoo
	FgXZdMVt/Oa8rri3P1c1EjzlcGigOex1xEvbabla47GdkyzLE0nyxcO8SpntJj+mClPv4EK/NHH
	FyrTziLhOU/oYDkFt38T8Ue38qWmlYiCYLas6V4NKr2Qxx37JiWBpjBaQLguBwDDf5+/K1fbq2F
	7/abZCKOaWKmBmUpD3oCpx6xvLQRxVQOuazByqzLHYsJIJwrz0DlBHSuUokFfXAiL/vWErAyBeJ
	vzDdzk6R3sfWzHSN68XTRG48OJlf062unanTzmJ7RahNAK0mBrKmv9YqaUR4p75a/PR2/7hdmda
	+kM7/1Nu6nLLaLdFSPI6siNH1u/DVyeY/DT4ZKXR09OV1TSIxuRyNWz+yU9RSfGcObMKwOTvgDC
	bsXDVizvHYSwg==
X-Received: by 2002:a17:90b:4c4f:b0:3ac:9c37:9432 with SMTP id 98e67ed59e1d1-3ac9c379a8amr1529817a91.53.1792053395834;
        Thu, 15 Oct 2026 01:36:35 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm3217317a91.16.2026.10.15.01.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 01:36:35 -0700 (PDT)
Message-ID: <e6550ed3-351c-451e-8740-f9f449e98402@gmail.com>
Date: Thu, 15 Oct 2026 14:06:30 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] ci: drop unused "linux-clang" logic
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
 <20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/26 12:27, Patrick Steinhardt wrote:
> In d88d727143 (ci: drop linux-clang job, 2023-06-01) we have dropped the
> "linux-clang" job because another job already uses Clang anyway. But we
> forgot to also drop the logic in "ci/run-build-and-tests.sh", so we now
> have some unused logic in there.
> 
> Drop it.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   ci/run-build-and-tests.sh | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index bc5058c917..23e87cbbd6 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -37,10 +37,6 @@ linux-TEST-vars)
>   	export GIT_TEST_CHECKOUT_WORKERS=2
>   	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
>   	;;
> -linux-clang)
> -	export NO_RUST=UnfortunatelyYes
> -	export GIT_TEST_DEFAULT_HASH=sha1
> -	;;

I know we're removing this only because we lost the job already 3 years 
ago. I just wanted to check a bit more on seeing the job had a NO_RUST 
flag on.

On some digging, it seems that 32d5b90590 (Enable Rust by default, 
2026-04-09) flipped Rust flags of CI jobs and retained NO_RUST only for 
this job and the linux-musl-meson jobs. That means, we've been having 
the NO_RUST flag on a Makefile based job that never existed in the first 
place which is a bit sad. I wonder if we need to fix the intention at 
least now and slip the NO_RUST flag into one of the other Makefile based 
jobs? linux-feature-testbed? Or have a separate job for this?

Of course, this is not really a problem with this series per se. So, we 
can handle it separately if that's preferred.

Happy to hear thoughts either way.

-- 
Sivaraam

