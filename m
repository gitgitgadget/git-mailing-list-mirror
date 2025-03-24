Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DB13C81B
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808749; cv=none; b=KaMyc3wOFGiytw5cGMxmMnbcWcc4fmfHaJWDCETkrpv5XANaDieVxr0AxxMPwshJui4lH+oNxM73HyMkSBK1MXGjnxytTUTc7ud2PhTNFFVa8kjFxOrUaX05j7d9GF2VrNuG0j6+YOatJLRpDFWF5znBDM4NbSWekGvrkNCZGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808749; c=relaxed/simple;
	bh=iE+O5FHLhWwO4mLIlYHR4les0osgOCI/qlUaFksJjF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExEv8JIZU9nZAfUb2L8PUwt3q6vEpsu2IJwU9yzdGf37WEm4CADL6mYOIREzpAX541YSAwxn/HCGXoZ0rGoqEprXSPaa59wu4UejsaRKZkyK//HEX2UCsoDyjTeIR44/Jr0RVbVtUH3htaIl/RXo4/kcTCoDfdV2N/XQiFVOwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqjHIaPk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqjHIaPk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso26737355e9.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742808745; x=1743413545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8LvPRgyDrWyw1ZzMaNc4AGookkQP3fadiJiiObzgng=;
        b=dqjHIaPko6Hy8y7BlEVn0FX4U+jwkLC5J1ycmDx80GljI/IJ0W3v6KbmX9R5qNzOHd
         Q243cGrsfFbIByWVXV5ZSvVyaJWmhcWKLJHxd4ySJaRoM4ETsY6QFTS4LTIwd83TZ6/W
         0EobcgVxLEeLFtlTKyZLGhmajZVyChvaJ6mQnlvzQ2ObpPtdHkqDDj3VTbBfx5cSLNS3
         NMfQzXX1d2dtl3tWAyRCWSxEyCf6TVD+/YYDSJRUi5ld29pITLbjWZUCna8icVSvyrpv
         es70xOCAVTnIezxtOjZ/hYnrjWoCsva1+SQsa1wU5RZ8dmjUDegs7aP0i9lG49z/Z11p
         uGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808745; x=1743413545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8LvPRgyDrWyw1ZzMaNc4AGookkQP3fadiJiiObzgng=;
        b=GJFuKip922UXhepZE1BOPxYO6zoNQA7G5JB9JqO9JOvDqX2RJYQ+aFjd/m+JmdWRif
         9sFyrqsPCs54rSgo2GdR5XoozD/pWv0kKzeZlbWEv+Tbwm9rrB+dA+zimQuR1Pk3eHjy
         msE8Ec1H1xyYpzSTEQgwpbicrF9QgN1f1d7kn1NcOaBFmhUSTkJD3ndNAgVxbxZvayTa
         xdJ5FPTOFw8nYO0mbmuKvmp9VTQ890EOFAiSutcbel6vSSj7SiQbYj//PdpwdQiNfyb7
         Amh+NXamdrEH+C58f6nD+ZufAgZoppSc1a9cvJdQXQBRvFoqGnRKObxuoUshGHEnFmTz
         KW6g==
X-Forwarded-Encrypted: i=1; AJvYcCXYZWly5FiyeZsbSmD6G+snI0o9q+3ab2BKbVHTp9OEly4F4VcvYZJBM3UiYdZ2m5b/Yvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/cZ0EY2qi+iMet9KsjFbJq9uvuwZlF5IcDgJsxCaDsni7t+b
	XcjCW+tkpy1E7uaYUd5c3fjRsSlfYUOTF7SUyalP2my7KzWJfxA2
X-Gm-Gg: ASbGncsZRc7vQCi/RT+mvkKxZkd3HQGTxuI4aDqwTwcMOYTZD0L0/5dVhxzFeCvrVqG
	EC80nAM8uz2UtbM7OsCMNEfqpC9ESfBSJode4BHQjrX48si4YveN2yJ+0SsMNu0ICbG/15KkE+v
	k0Zk8DUhmMFks+IDBg0X1b342NKmCXEN3rmVxERLfg/mJdsGgZ/Puemj9vuBxgAnsah/dLD0cKe
	v8xI6V4oDJmKiyvDBGssicwYMHo3kUcZkoAhoyjOFRCApTSdvvaGMtirr6Ia/J/kuMg5w5av2Sm
	mTA9oVZz9sTZ3cqPoPYLkaLzp+8g54p8ZcIDJCBIT1xwedclHP1e/suSDCaXA2Q2sUeKRRY4sNh
	pTcDrvOWAqOb60Uj6Wc/FHA3QTeo6pqg=
X-Google-Smtp-Source: AGHT+IGAPAjLCbvqHoCi/YomFCuvejzrHD4ypEFTN41L3saxENeR88JaOv/2IXxV9xkKCP9eGjPfyg==
X-Received: by 2002:a05:600c:3516:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-43d50a52671mr113914555e9.31.1742808745052;
        Mon, 24 Mar 2025 02:32:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd17cfesm114920275e9.10.2025.03.24.02.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 02:32:24 -0700 (PDT)
Message-ID: <16a8af3d-151b-489d-a693-3cd2658c45ef@gmail.com>
Date: Mon, 24 Mar 2025 09:32:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] advice: allow disabling default branch name advice
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, alan@norbauer.com
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
 <20250321231639.180762-4-jltobler@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250321231639.180762-4-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 21/03/2025 23:16, Justin Tobler wrote:
> The default branch name advice message is displayed when
> `repo_default_branch_name()` is invoked and the `init.defaultBranch`
> config is not set. In this scenario, the advice message is always shown
> even if the `--no-advice` option is used.
> 
> Adapt `repo_default_branch_name()` to allow the default branch name
> advice message to be disabled with the `--no-advice` option and
> corresponding configuration.

Thanks for adding this, it has always bothered me that the only way to 
silence this hint was by setting a default branch name, rather than 
being able to just accept git's default by setting the appropiate advice 
variable. The patch looks good to me

Best Wishes

Phillip

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>   advice.c        | 1 +
>   advice.h        | 1 +
>   refs.c          | 3 ++-
>   t/t0001-init.sh | 8 ++++++++
>   4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/advice.c b/advice.c
> index 1df43b7536..e5f0ff8449 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -51,6 +51,7 @@ static struct {
>   	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
>   	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
>   	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
> +	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
>   	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
>   	[ADVICE_DIVERGING]				= { "diverging" },
>   	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
> diff --git a/advice.h b/advice.h
> index d233cfc693..727dcecf4a 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -18,6 +18,7 @@ enum advice_type {
>   	ADVICE_AM_WORK_DIR,
>   	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
>   	ADVICE_COMMIT_BEFORE_MERGE,
> +	ADVICE_DEFAULT_BRANCH_NAME,
>   	ADVICE_DETACHED_HEAD,
>   	ADVICE_DIVERGING,
>   	ADVICE_FETCH_SET_HEAD_WARN,
> diff --git a/refs.c b/refs.c
> index 118465271d..bf9a40d6af 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -664,7 +664,8 @@ char *repo_default_branch_name(struct repository *r, int quiet)
>   	if (!ret) {
>   		ret = xstrdup("master");
>   		if (!quiet)
> -			advise(_(default_branch_name_advice), ret);
> +			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
> +					  _(default_branch_name_advice), ret);
>   	}
>   
>   	full_ref = xstrfmt("refs/heads/%s", ret);
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index c49d9e0d38..f11a40811f 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -830,6 +830,14 @@ test_expect_success 'advice on unconfigured init.defaultBranch' '
>   	test_grep "<YELLOW>hint: " decoded
>   '
>   
> +test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
> +	test_when_finished "rm -rf no-advice" &&
> +
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +		git -c advice.defaultBranchName=false init no-advice 2>err &&
> +	test_grep ! "hint: " err
> +'
> +
>   test_expect_success 'overridden default main branch name (env)' '
>   	test_config_global init.defaultBranch nmb &&
>   	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&

