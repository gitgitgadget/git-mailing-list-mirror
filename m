Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85FCA4E
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768662295; cv=none; b=crgYQ2cW/JGoNDLMWIo5d9UQjogEVeybjtw0UlQtTVsEXLBzDXs8O90fTDHwC1VZ6Kw0rluo2iXyVax4VsPvsK2COuhrgbyeCllTcgLBYnxMxELRWIVpJq4+6p7FOCEUdVE5qUKIdrBH8ALuC/EBItbvaqbaykLr91dY5131W30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768662295; c=relaxed/simple;
	bh=oO7u+BoHV1cb6m961Mb26uyCp+rJmtUraZhUDQyOrgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eED63SWWdSqr5EGiINGn1pJWQOakE3PwwXao6cQFJ8o1O1S719S9RGHaRt/Ms+lW43Xi50bDiG0imQ5VC1sn/rOUiFtbkNcEaDxgLZ2CbV+VxgbGeZDXBr8Gx21rBYcoVB2F+hp2x+AfmE9iVrVlEzOkKbhmO6xJGggDwUbKY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn3Do7By; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn3Do7By"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso26192805e9.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768662292; x=1769267092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VosjSggaw1/Z2v4KDYzQhrEUH2oYsDtwEl6tQ3KxpFA=;
        b=bn3Do7ByIIzd0UUvvvZeB+T7hHkGOs3TsoBY6C+Grf9AVCDiwk7MuoKgT43e5eE/td
         PfZQIZGF+3G7sQUkknzUTPOAUWNq5acxv2pmK2Arm918rPplYNBMeEiNSVPtdP/FpPFS
         rFZM6UMPTajrYKXp+lcFaMqIcfS3xYllGTdHSIFVV2AgAQRhQxY0u+eKpvHw/7P3VEqz
         L67rEh9NAXlfp/kC1hJAs8fZDBjZ3p/+Kcp0aDiNVXjJA03Roma8UMGGCP3i1U+xfXe5
         rUoyD1hMWhXYwhaik5mB3M0JdMApoh70uSCuEHCgZUCxMpMdHrrCDxyxTah4hzUSJOa6
         YZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768662292; x=1769267092;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VosjSggaw1/Z2v4KDYzQhrEUH2oYsDtwEl6tQ3KxpFA=;
        b=a6jbxTGphKuQ+SvKSN8DvhkrNzZOpeg6DWQ3r5XjHd050UpNooxTjuFUFxDo96XuXg
         k0YimFsjcgcKQT1ftHNfd08aY1YfieN9XbVlqgnqYCUuMnLvhnsfJEq4S5aiIGrv9cCk
         xmQiVYFDmuT0TVZH6ceD6Z1v6SL8o0esUIKSfABmC1vghHJi5l5d0Q4z+WXiqF5D85P+
         3N5rHvt8WrztMoxY/TGTorpoQQtjOJIpsQYiJxpzPbG8XG0qmWmUdKhC0MITvr070+nb
         MpptuHcWaP+dkpXF7iQz5q/QLfiwUpyulW/IFksBttBuNHj48SlZn6up1hOBs+pvhOzr
         Cksg==
X-Forwarded-Encrypted: i=1; AJvYcCUNxccPLagXe3xpnss71y7mKiiVAhUDJfpVX1wMRzgxfb07rQKoFzdvdetV44DHTmzA+Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqc0CM4RrjLSIVag7AZmzOd8W/TFCLXUie1omyifwOncwyhhh+
	FbiDAVAUFPEUCckDTA61FgU804SjbCRaWudhpL/tMA2+hbDIp6NJi+BV
X-Gm-Gg: AY/fxX6ceGF7N1tv6pskZQkEAXDni9vRgUVBwaRDX4yHPRT5ZlDKjNwkYUjmdxmTILE
	LWZq5f2VYpTALEZ0XOSjxFeQWuSGFaQitIzVybqRqSJ5J1Lay7RKnr2OsM7HSgIrbzKpcQG1VLE
	yc9gd+6ZuXr2ch+KaIZwnDsXn4OLErBL629P9M2vfj7mk7Brp4FNr/8wZ9pTS0Oobi1nLlOAjbB
	8Km2OwIHeV4Xv4oXaMrhfHoJTpJuk9Aw4Kf227O9W1FKAyziz9eH3dMEnnYnxhjdEFT046ZWkwe
	XyNknCMY8EZkAdhmZ7FQKvrb1xRB07MTsgNboTRuyn8+SakAkHjrXduQ/Ysl5H2JZNlePtg/tBA
	A37F5yI3UPeS3jGhY8IxLwMlPjf7DgZXmB2nqQCekjMQ2e5b7CbqY/cKF3I7kQn3DUx9tS0Z/6M
	SrF8dy/c5zUsd6O5jbIiTLmvjpylF31/5fVfqvIFXDceFr5MSyy8vtaA6D1s7RVAAZWg==
X-Received: by 2002:a05:600c:810b:b0:47e:e78a:c832 with SMTP id 5b1f17b1804b1-4801eb1c65emr51803425e9.37.1768662291947;
        Sat, 17 Jan 2026 07:04:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f3b7a5f94sm163103415e9.0.2026.01.17.07.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 07:04:51 -0800 (PST)
Message-ID: <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com>
Date: Sat, 17 Jan 2026 15:04:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johannes

On 16/01/2026 17:31, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I noticed recently that the leak-checking jobs still take a lot of time,
> and upon analysis, the git-svn tests contribute significantly to this.
> 
> Analyzing a recent CI run, I saw that the Git test suite contains
> 1,017 tests, running for approximately 5¼ hours total. Of these, 65
> git-svn-related tests (~6% of test count) took 42.24 minutes combined,
> accounting for ~13.% of the total runtime. This implies that the git-svn
> tests are roughly twice as expernsive compared to the other tests.

Looking at the CI logs for this PR the p4 and cvs tests account for 
another 24 minutes of test time and I suspect they also offer little in 
the way of extra coverage. Unfortunately there is no equivalent of 
NO_SVN_TESTS to disable them - I wonder if building with NO_PYTHON and 
NO_PERL would make sense for the leak test job?

Either way I like the direction of this patch

Thanks

Phillip

> However, testing git-svn in the leak-checking jobs provides minimal
> value: git-svn is implemented as a Perl script, and leak checking only
> handles C code. While git-svn does call into Git's built-in commands
> that are implemented in C, these are standard Git operations that are
> already thoroughly exercised elsewhere in the test suite. Therefore,
> running the git-svn tests in the leak-checking jobs only adds to the
> overall run time with little value in return.
> 
> Given that the leak-checking jobs are particularly time-intensive and
> these 42+ minutes of SVN tests per job provide no additional leak
> detection value, skip them in the *-leaks jobs to reduce CI runtime.
> 
> Assisted-by: Claude Sonnet 4.5
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      ci(*-leaks): skip the git-svn tests to save time
>      
>      I leaned heavily on AI to implement this patch, in particular when
>      analyzing the logs. That's why I added that trailer talking about Claude
>      Sonnet. If this is undesirable, please let me know.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2031%2Fdscho%2Fskip-svn-and-leak-tests-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2031/dscho/skip-svn-and-leak-tests-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2031
> 
>   ci/lib.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index f561884d40..a165c7f268 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -356,6 +356,7 @@ linux-musl-meson)
>   	;;
>   linux-leaks|linux-reftable-leaks)
>   	export SANITIZE=leak
> +	export NO_SVN_TESTS=LetsSaveSomeTime
>   	;;
>   linux-asan-ubsan)
>   	export SANITIZE=address,undefined
> 
> base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75

