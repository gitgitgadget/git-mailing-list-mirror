Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143794BA9F6
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858095; cv=none; b=U6gxK8/hCvwT5ySqG8M+GktIz92Nim+8yzfH/dmC7P3rDohJF4CFOqtkDuV3is5yFg7mYEzCaWwv1OzD0wjBW/E/1S+saSjs3Z50+SYe6g2lbMG/rbu5Bj4U6MtEPmLy1i0bPjVKYpxj0+7d6aQfv6GY1+nRgKFiJ6N/p1YYriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858095; c=relaxed/simple;
	bh=5rFt9joCMSZwNVjA3HKKrwtPMZ0WvIW3LkGYVryPhm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGm6eUR9V5XrWMNhzjHGg2VGAIyNe+akAkAdknnG+Gb7RFkbYZRU9C/zHwB9CXBSppmjRAEBEkuEsg0isHuLTgdfxy1Dr+jCmBzXwZXvGa4IcuVCRpN7eJZucC73OE76CyHRu1oDUTxjNuNhF6K5oYkP76hvl9bytScB0f63Nl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDIwK7/K; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDIwK7/K"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f4b94d72acso3638135a34.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788858090; x=1789462890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nO4xjKhbjLjQFUV8MZtpEAUJA2ZRiCM9L+S9nbuXr9A=;
        b=eDIwK7/KLYi4RSijSHoZN9LYkL7O3I7P/rQ+gRp/efAbF/NrOyXysMPwyNC4194eWw
         GYuQWaeXxT9gOrOJ9xzNu9diL3koUnqlXfDGGouG5+9h1Rl85cJ96RMNASsZVndOkS5J
         SW5l2/Twj5kNcSqtUPyyB52uR3dMkSURTF4jmCvECFpvVERgqlYS7Fg3blPd7m8Nbwb+
         QrgFxB9BuSLlYCq8uKs+gPLGKKMWoLZt9R0Bzp0f74IhwfDtFjroKi6jhVK+O0EIPI75
         BMUEIsaScmw7O///8M2rNQZ+Aqiplnld3Hve0trk6euiqAqjZzM74ouUYPmxcVaxAEuK
         ONiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858090; x=1789462890;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nO4xjKhbjLjQFUV8MZtpEAUJA2ZRiCM9L+S9nbuXr9A=;
        b=NOPs+Odd3OaPkJSPWBpVlZtdDmaY1fJoD3de2YL5/iWE39JL/KZCcgwdsziyKFk4kZ
         Z+RaS4mZYfweruzm06HnanbmSuS5zyI3Arp16gzNzIxZg482aUbBv0//yRRq/IaFMcaE
         hMkwAe/2FSYr6WZ6WYmxwdqs9l8BwTYfyXBOD09trZLsdVurYF4lD5VuqMICuVO/NbTd
         HmpXBAaVqIVGzQimruiLSer6rkPJ4UHs22ts2lKVQ/YPUOHsu9sWmgvkBLrbdy2jE0UF
         r2UL1qDhC9p2ICl0j521FyRfv58ubw6/EqQheyirrNZU+Y3bVVq3EqANxUUfs6RzzUq3
         21Pg==
X-Forwarded-Encrypted: i=1; AKwUvBwcL1o90kXxEdOqYqFgXeEaWRjCkqEzSZN14JbYR4qHpBnAn/odkZP9//xTfspNWN9Kdpc=@vger.kernel.org
X-Gm-Message-State: AFuF++mLjdl/d/OAvaUwJChwxWwtbuv0cLudBC5QeP9RNhFp3bbq8X75
	Qed3rVDrb94yfiaql+GDx71BFyxKxqmsEVO5RCoEBUiaesl+ZK1JpY9U
X-Gm-Gg: AYBFou1V1/Oy3M3tF3Oj4SSlz3bw6ltoL/qLp79mWv15ZbcLimjhGuUMWb9akgIPGLS
	fEOr70GCzjDkSUjNG1GRvzrCkRcVTVqA4Pj9zaWHPKm+5J6yCNSuMImY269v8wQgBuOdLC2bD2n
	s5Yn1xlQb8Uczu7WV4uHFYua4+jX7p9157U6KZ2Trrf+t8mwGx0kz9eeAqnI2jR3+zaBXnNtJbm
	nwm00MnM2EYn4vttEXtMicnVVNTdzynvYO814QCtbVRm2rIhQpJ0rGEPcRLpNWmy7klSAfVBU0V
	kUndqKzxwefEB0pGN7UvMiyuTRpBh846jArBEdNpHDxYIgTDOkQpIPDkALb+wvWv4r1JzEJ6D+Z
	naui46ruufs+Sz+PQFKFMl9rnbpTpHWCBx/uLkaaRq2hmdEeJxCzbqCa5zM5wTXbIzw1Xc0SMNS
	LmB17r55WEVIM9N/6QBOWlZ4oFbTuVBv/Egc7RMKpzgci9tynVDxZWOJRlq5gAyJUi+t9+HSuNP
	5qu
X-Received: by 2002:a05:6820:60b:b0:6b7:46fc:1d3 with SMTP id 006d021491bc7-6b746fc0241mr14496692eaf.50.1788858089656;
        Tue, 08 Sep 2026 02:01:29 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm34563144eec.26.2026.09.08.02.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:01:28 -0700 (PDT)
Message-ID: <aacc3fcb-43e6-4f62-b083-5fbabaa9f494@gmail.com>
Date: Tue, 8 Sep 2026 14:31:22 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] builtin/init: rename "--ref-format=" to
 "--ref-storage-format="
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-1-6733c90ca5b0@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-1-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:

> Instead, this and subsequent patches will fix the mess by consistently
> referring to the ref storage format as such throughout all options,
> environment variables and config settings. This new name much more
> closely indicates that it is about how we store data and finally brings
> consistency into this area. We will keep the old names working of course
> for the sake of backwards compatibility.
> 

Just a doubt regarding the old option. At the moment, the patch appears 
to introduce the new name alongside the old name. Do we not plan on 
deprecating the old one and issue a warning to users when it is used so 
that we could eventually retire it at some point?

> ---
>   Documentation/config/init.adoc         |  2 +-
>   Documentation/git-init.adoc            |  4 ++--
>   Documentation/git.adoc                 |  2 +-
>   builtin/init-db.c                      | 16 ++++++++-------
>   t/perf/p1401-ref-store-tombstones.sh   |  4 ++--
>   t/perf/perf-lib.sh                     |  2 +-
>   t/t0001-init.sh                        | 24 +++++++++++------------
>   t/t0610-reftable-basics.sh             | 14 ++++++-------
>   t/t0611-reftable-httpd.sh              |  2 +-
>   t/t1400-update-ref.sh                  |  2 +-
>   t/t1423-ref-backend.sh                 |  6 +++---
>   t/t1460-refs-migrate.sh                | 36 +++++++++++++++++-----------------
>   t/t1900-repo-info.sh                   |  6 +++---
>   t/t5510-fetch.sh                       |  8 ++++----
>   t/t7424-submodule-mixed-ref-formats.sh |  2 +-
>   15 files changed, 66 insertions(+), 64 deletions(-)
> 
> diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> index 7b4abdaf8b..a048f0bddc 100644
> --- a/Documentation/config/init.adoc
> +++ b/Documentation/config/init.adoc
> @@ -15,7 +15,7 @@ endif::[]
>   	this config.
>   `init.defaultRefFormat`::
>   	Allows overriding the default ref storage format for new repositories.
> -	See `--ref-format=` in linkgit:git-init[1]. Both the command line
> +	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
>   	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
>   	precedence over this config.

Relevant only if we are deprecating the old option: we need to mention 
that the old one is deprecated in the documentation so that users are 
aware of the same.

> diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
> index bab99b9b47..7e407d3ef1 100644
> --- a/Documentation/git-init.adoc
> +++ b/Documentation/git-init.adoc
> @@ -11,7 +11,7 @@ SYNOPSIS
>   [synopsis]
>   git init [-q | --quiet] [--bare] [--template=<template-directory>]
>   	 [--separate-git-dir <git-dir>] [--object-format=<format>]
> -	 [--ref-format=<format>]
> +	 [--ref-storage-format=<format>]
>   	 [-b <branch-name> | --initial-branch=<branch-name>]
>   	 [--shared[=<permissions>]] [<directory>]
>   
> @@ -57,7 +57,7 @@ values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
>   +
>   include::object-format-disclaimer.adoc[]
>   
> -`--ref-format=<format>`::
> +`--ref-storage-format=<format>`::
>   Specify the given ref storage _<format>_ for the repository. The valid values are:
>   +
>   include::ref-storage-format.adoc[]
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index 8a5cdd3b3d..23ba65656e 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -593,7 +593,7 @@ double-quotes and respecting backslash escapes. E.g., the value
>   `GIT_DEFAULT_REF_FORMAT`::
>   	If this variable is set, the default reference backend format for new
>   	repositories will be set to this value. The default is "files".
> -	See `--ref-format` in linkgit:git-init[1].
> +	See `--ref-storage-format` in linkgit:git-init[1].
>   
>   `GIT_REFERENCE_BACKEND`::
>       Specify which reference backend to be used along with its URI.
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index e96b1283b7..63f33154c0 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -57,7 +57,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
>   static const char *const init_db_usage[] = {
>   	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
>   	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
> -	   "         [--ref-format=<format>]\n"
> +	   "         [--ref-storage-format=<format>]\n"
>   	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
>   	   "         [--shared[=<permissions>]] [<directory>]"),
>   	NULL
> @@ -83,7 +83,7 @@ int cmd_init_db(int argc,
>   	unsigned int flags = 0;
>   	int bare = startup_info->force_bare_repository ? 1 : -1;
>   	const char *object_format = NULL;
> -	const char *ref_format = NULL;
> +	const char *ref_storage_format_str = NULL;
>   	const char *initial_branch = NULL;
>   	int hash_algo = GIT_HASH_UNKNOWN;
>   	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
> @@ -109,8 +109,10 @@ int cmd_init_db(int argc,
>   			   N_("override the name of the initial branch")),
>   		OPT_STRING(0, "object-format", &object_format, N_("hash"),
>   			   N_("specify the hash algorithm to use")),
> -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
> -			   N_("specify the reference format to use")),
> +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
> +			   N_("specify the reference storage format to use")),
> +		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
> +			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),

Relevant only if we are deprecating the old option: We could change the 
description of the old option to convey that it is deprecated so that it 
could be easily distinguished by anyone reading through. I suggest this 
by noting a similar pattern in `builtin/name-rev.c` for the `--stdin` 
argument.

If we don't plan to deprecate, I suppose we could use OPT_ALIAS to 
clarify that `ref-format` is an alias of `ref-storage-format` similar to 
how `recursive` is marked as an alias of `recurse-submodules` in 
`builtin/clone.c`.

> diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
> index 559713b607..1ca245c732 100755
> --- a/t/t7424-submodule-mixed-ref-formats.sh
> +++ b/t/t7424-submodule-mixed-ref-formats.sh
> @@ -31,7 +31,7 @@ test_expect_success 'add existing repository with different ref storage format'
>   	(
>   		cd parent &&
>   		test_commit parent &&
> -		git init --ref-format=$OTHER_FORMAT submodule &&
> +		git init --ref-storage-format=$OTHER_FORMAT submodule &&
>   		test_commit -C submodule submodule &&
>   		git submodule add ./submodule
>   	)
> 

Rest of the patch looks fine to me.

--
Sivaraam

