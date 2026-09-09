Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804501DA62E
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941414; cv=none; b=PGp+QRnUeoLl/Ky1rN3ilgQyM8wHb3BZ41fOWNDr8HjaqiL5VExTiWOTzjcxdNWB8YEXvPuj3f7IW/LA3djtqnF0xt/97lU6znETDfoqIjCc8bTHmUlhMMcqEEKMCaHli0GqyRxcBd+fESKxeRIOeOtGSuplRgNUhq0kvGLtKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941414; c=relaxed/simple;
	bh=4J+hCXofvDtN5Y2YEyO2TggXCTiNnI/QaBifIr2KF/4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CkWw7F1Y+72dw2UBUt1n36CSVY9ZNTIO09Ee0VCXstCqn/5e8NXrNNFm8YeWdB4t/7Tp2njWTKJkTBs3JERwYhHQGr+p79UZtT+L6CCmsWbVt7nM6iU2R4fDO1kDhMaw60WbLocoiAgFJRUYl/uGbo+72jY1vwOSueZG03uxGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS4fKMlB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS4fKMlB"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964e480f76so6458303a91.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788941413; x=1789546213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNHVonp66pLLjPEfIzyuw2IHWx+dwA9+JqXQp3rUd8s=;
        b=fS4fKMlB8/IyyukHQ8H0RwZ0e8fZ2ydCYfEW3alcoXkgYW+RBygIU3UwTckdm/84BU
         7FdjlWQC/nbVJ/o8ITTP90k6EAYP77hvbJKHbiLwfpS17UWhgdavSCuGJ39QpfEc9m6z
         2yKq/l1BSEk4dBzXua4GXYNS6DVMbmTJaNDYJEg7/uQC5cYzn24JofHCiDQQt5A+Qmxh
         mMEe3/KwePeaZ7wETqZY2k1EkfINqci/oUJDxetua2dj9bCvqcPfzCNS9Aq4PACknqCj
         BAef/W+NsVVTc9V1qp7YijeHdvbbFM5jFXpnls1/5Vf3mFBDAqW97GSsYnpYBl+340hJ
         nOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941413; x=1789546213;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNHVonp66pLLjPEfIzyuw2IHWx+dwA9+JqXQp3rUd8s=;
        b=Ku7k1tiz71D8QMvxjiQsN/c8tba2WL3EiocONH2FGlLb4oLUa2f5HZFKY6YX823mzT
         65O/8rf3cP5FgGGtWCIH1ReNjaFmFMjqrzPTxVXMH6mu0jl3Yp7mZKVYb8J+jqO1spE+
         FSpIE1nPMiA1PR7L53NnXbvgcwjQhVka1NQoV6WFjY9hHeFsR7ifLa5A+PLmiZ++Rw1m
         8c3ZSeUvi8NqaAjN55lBJ6meZKp56X47Daw/F+wYJywzlj1I2AEr5Ly8TaVntrc5sGHK
         lFGO4Rpp06UHq1iIDzf1gLTXgLrTgxDUOAwJ+u9lBfl3e2f2y+BDeaHJVZGQbKQNqweM
         +MsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlGdHlajFp1ieLe2CihFL8ZbDEDCXgtdfMjx0iLzmXEusKc4YVB1ECod9kRYPT9siaIA8=@vger.kernel.org
X-Gm-Message-State: AFuF++nwsThGYbHuHRRF6RuX+CXDFZiYR3bqYoW1kpF9xpWzD5lxzqN5
	azNzMJ7pPYHz6Bg1OI+V/TpHBquE/zDdC6xboJESAlEtLdWBTysF5c5Ewpw5ycQZE7g=
X-Gm-Gg: AYBFou2e8GOPphqEej2jNBtnylwDKf6aWKqwwg5gruCIet3zmQlTZ7sjsqJtwg/lNLT
	GKLAsuoGdHBBhFuhfkgq1jWij2OcgRTE5IbwCNkawuUFfuEFp3q1eb/psRqzs6sk54Xk5AKzwzS
	3kikaMEMI3VrR58hkdqz//BC2mBHn6P3tzA77fM69c2GUc76BMyb+kp+PKWzAvVW4B+ZTOEsAsZ
	NhM3WgC0uLr2MFGuLDaqgOjKapehrtTh+5snLV65IB5nPnryH2mD3hrbta2buaAz5BnP5EZw5gu
	+NgOB8UCIgYcvkr7UhIlfJuUN0VQKUuAyqe27IN9fbWmejcBjuyYcIzXd+FYsXTtCwcR/fr1nib
	ZY/WeEJfi1oz5QF2lMdsttim53j8+4zoOKlLUMl6Yr6QLfLIkx+9O2Y6yN41ltL2UJNVreJyEto
	CAK2K4Nm2ooePrF6Ak+NQw/o0pyKcmWyckHeRKIzZrIQ01rUqOjEjxrX0Na5NHicHOU2N31Hc5w
	itRViZ8QJTVt71o/BzYZNPLgvcyuUtfhIsA63xWrAQQsnthUmg+AlWg0tiAfhfMPQ==
X-Received: by 2002:a17:90a:dfcd:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-39b84cce5a8mr19654937a91.14.1788941412006;
        Wed, 09 Sep 2026 01:10:12 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:e00a:2dbb:bdc9:907c? ([2406:7400:12b:61a6:e00a:2dbb:bdc9:907c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm37884252c88.0.2026.09.09.01.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:10:11 -0700 (PDT)
Message-ID: <57f08562-ecea-4e51-8e5a-ae3aa91b23d1@gmail.com>
Date: Wed, 9 Sep 2026 13:40:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 09/11] setup: rename ref storage format environment
 variables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-9-6733c90ca5b0@pks.im>
Content-Language: en-US
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-9-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:
> 
> diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> index a048f0bddc..f82fcf25e6 100644
> --- a/Documentation/config/init.adoc
> +++ b/Documentation/config/init.adoc
> @@ -16,7 +16,7 @@ endif::[]
>   `init.defaultRefFormat`::
>   	Allows overriding the default ref storage format for new repositories.
>   	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
> -	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
> +	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
>   	precedence over this config.
>   
>   init.defaultSubmodulePathConfig::
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index 23ba65656e..d78e2b5c10 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -590,15 +590,15 @@ double-quotes and respecting backslash escapes. E.g., the value
>   	is always used. The default is "sha1".
>   	See `--object-format` in linkgit:git-init[1].
>   
> -`GIT_DEFAULT_REF_FORMAT`::
> -	If this variable is set, the default reference backend format for new
> +`GIT_DEFAULT_REF_STORAGE_FORMAT`::
> +	If this variable is set, the default ref storage format for new
>   	repositories will be set to this value. The default is "files".
>   	See `--ref-storage-format` in linkgit:git-init[1].
>   
> -`GIT_REFERENCE_BACKEND`::
> -    Specify which reference backend to be used along with its URI.
> -    See `extensions.refStorage` option in linkgit:git-config[1] for more
> -    details. Overrides the config variable when used.
> +`GIT_REF_STORAGE_FORMAT`::
> +	Specify which ref storage format to use along with its URI.
> +	See `extensions.refStorage` option in linkgit:git-config[1] for more
> +	details. Overrides the config variable when used.
>   

Given rationale about retaining the documentation discussed in another 
mail in this thread, I think we could do so here too.

> @@ -2785,19 +2788,21 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>   	 */
>   	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
>   		/* nothing to do */
> -	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
> +	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
> +		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
>   		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
>   		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
>   			die(_("unknown ref storage format specified via %s: '%s'"),
> -			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
> +			    GIT_REF_STORAGE_FORMAT_ENVIRONMENT, env);

We're getting the value from GIT_REFERENCE_BACKEND_ENVIRONMENT as a 
fallback but we are mentioning only GIT_REF_STORAGE_FORMAT_ENVIRONMENT 
in the error message. Would this not be misleading if the value actually 
comes from GIT_REFERENCE_BACKEND_ENVIRONMENT?

>   	} else if (repo_fmt->version >= 0) {
>   		ref_storage_format = repo_fmt->ref_storage_format;
>   		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
> -	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
> +	} else if (((env = getenv("GIT_DEFAULT_REF_STORAGE_FORMAT")) ||
> +		    (env = getenv("GIT_DEFAULT_REF_FORMAT")))) {
>   		ref_storage_format = ref_storage_format_by_name(env);
>   		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
>   			die(_("unknown ref storage format specified via %s: '%s'"),
> -			    "GIT_DEFAULT_REF_FORMAT", env);
> +			    "GIT_DEFAULT_REF_STORAGE_FORMAT", env);

Ditto here.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1f0505e412..60a2179a0a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -575,8 +575,8 @@ export EDITOR
>   GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
>   GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
>   export GIT_DEFAULT_HASH
> -GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
> -export GIT_DEFAULT_REF_FORMAT
> +GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
> +export GIT_DEFAULT_REF_STORAGE_FORMAT
>   

Would it make sense to also rename GIT_TEST_DEFAULT_REF_FORMAT to 
GIT_TEST_DEFAULT_REF_STORAGE_FORMAT for consistency sake?

-- 
Sivaraam

