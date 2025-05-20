Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EB4B1E7B
	for <git@vger.kernel.org>; Tue, 20 May 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776043; cv=none; b=nGEBX2bF6lX4J1OB+nZGS2nyGvmgo7/+6Eqkrv5TjiYrOYtg1gu9ujyO9wGM7SfLvDMNGsOreDcxusdCTMQNk3PbOb53FumY9BUxKBBNzl4OSmT+hKAtdQIjlcWJLQ5FteP+bnel+PHegeivGwODeLRZjblPMZN01p9FzVRlgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776043; c=relaxed/simple;
	bh=tBpV5NpRSDXp+3QXyF9FeLZUoGrNNmtFCgao5BKf790=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRnucPXWUG6vZX+p7dcBU6/85u7Qk/LRh0qPQ2SAYK3+y4YnjlGJTNV53ZEGrgY/7GUnny1gYNVWJigwvdzCEMtjyNIA0Q5RH1caJ44YOKtltE68iWNb7SEVt39wYJ+uL6Z93/phD4fun/GErvMIJXOlhgBybRbOyLP1QdvIf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckNKMWn2; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckNKMWn2"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2da14a6f89aso1895601fac.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747776041; x=1748380841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpHMbpoGZXxWnLzVqOyy+5bn2w+Y+PU42U+TtzgB6N8=;
        b=ckNKMWn2KDkmQxWYulSHJYxmjV3n5Rh1H+hpu9lEhyuCQTLfuKBgWi3LkBYf0thxSM
         Pg/zXMbclJJrgF/wQMQw0LFUSKqMYGtR6i4dZ8EfsLpuGzAR3VaQHYvTucMw6JphbLmB
         4fxBr0KdlFG4iRmDqirVYFCOW8aOendT8pn05q2hwkRMKaOLf2EN01+K8wC78hIRcUbo
         PrvpA1J/MrZVJeH1pKKqHysBBHxx7GrxQ9ZCvMde9AO2NJYnmEUQgYfK/sxTCbPtFBji
         OBNim0zNTkoetBijODy7K1x44eWf0pQlc/kyk6kisQrqvcMOEmZQiKc4bDcmD/Dsn5pN
         DInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776041; x=1748380841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpHMbpoGZXxWnLzVqOyy+5bn2w+Y+PU42U+TtzgB6N8=;
        b=g9YQCbQmzVT1qCuRkmQJQyiECvb7jS0e/IezV4UNTWZn7MKJkrfPAMnGl6+uYzLfBf
         41vnhapqmOymhf4RzzZKFjGRbO89cgmvL801q1tlw2+R71gpxGwOZpxQ7byW+qJcM1hP
         2Zf53vFEW9pN2EKmRiVdsPFMKyeaiwZF0WHKsxMDr/dwtIbSl1WFOPHDLQvPRUDmf7ty
         n6xEpkpWSk8SPNAKbTZreH6DyWAw1JS9D2FaZ46UnUMINSUrfvJtedchSM+7g30ciLKK
         2i+wW6l0yjvcXV2U5SbeGvePqQfAdv+hDiQeUkCAa9rivhC7ZKdj6+d7yCTlTCHsJT8y
         69Gg==
X-Gm-Message-State: AOJu0YwogkL/mKJmXDRQ5V/5ng+FnNvSM5EU4Brqc2dYIjPpPqysNwqp
	g9X7P0g+cj1MySztMtCQccUn1hgBH4mNJkFbn+KVYiCMxmzNFwgwecFj8FqFtC3s
X-Gm-Gg: ASbGnctjbPboePz+QuQWCwLLZqIyIlilmih+BM85QOj6wSUqiTZ11LgUPkndMsq46pZ
	Y01cn0I5ii4Xu3ElAygDLpxnbnZjHzsfTn1WI0azbj8QynGzkkneJH1mHomuGONOfIkbh5TpMDl
	FSrDM4BpsRcifDSYi/FztYgxuDGDUe2e4S7QlYus/R+Th26Z8IQQ24v06TuM4pL9ZXOfy941VIk
	rxIl8QUHh9loDMXR0h00bvcVD3MFYlX4T/SqoXlG6SkqNXWPk69V8qdNLtDyn3jVD3CPXemNVgc
	bSqFLdlcDeWW7YGMvVDP3YunaV4e3VaHUxcs2ktSACdZ
X-Google-Smtp-Source: AGHT+IE2uobZYVOT3LndsgVUdDCTe+eBOsdS4m/jtIEpweFO7VQTq3rAPmigUHguijuGeiAmSTuLqQ==
X-Received: by 2002:a05:6871:6281:b0:29e:5de2:cffb with SMTP id 586e51a60fabf-2e3c1c8d8bemr10893031fac.17.1747776040893;
        Tue, 20 May 2025 14:20:40 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c060c502sm2392883fac.2.2025.05.20.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:20:40 -0700 (PDT)
Date: Tue, 20 May 2025 16:16:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] t: remove unexpected SANITIZE_LEAK variables
Message-ID: <dw57mhszlyk3s4rvitdthpbaoiicjnnraq24e6uxaeu2kze26d@xpiouvxmhowr>
References: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>

On 25/05/20 04:40PM, Karthik Nayak wrote:
> As of 1fc7ddf35b (test-lib: unconditionally enable leak checking,
> 2024-11-20), both the `GIT_TEST_PASSING_SANITIZE_LEAK` and
> `TEST_PASSES_SANITIZE_LEAK` variables no longer have any meaning, the
> leak checks are enabled by default. However, some newly added tests
> include them by mistake. Let's clean this up.

Indeed, both `GIT_TEST_PASSING_SANITIZE_LEAK` and
`TEST_PASSES_SANITIZE_LEAK` appear not have any purpose anymore.
Removing all remaining instances where they appear makes sense and from
a quick search it looks like this patch got them all. So this looks good
to me.

-Justin

> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  t/perf/p5313-pack-objects.sh | 3 ---
>  t/perf/p5314-name-hash.sh    | 3 ---
>  t/t6601-path-walk.sh         | 2 --
>  3 files changed, 8 deletions(-)
> 
> diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
> index be5229a0ec..786a2c1c6f 100755
> --- a/t/perf/p5313-pack-objects.sh
> +++ b/t/perf/p5313-pack-objects.sh
> @@ -3,9 +3,6 @@
>  test_description='Tests pack performance using bitmaps'
>  . ./perf-lib.sh
>  
> -GIT_TEST_PASSING_SANITIZE_LEAK=0
> -export GIT_TEST_PASSING_SANITIZE_LEAK
> -
>  test_perf_large_repo
>  
>  test_expect_success 'create rev input' '
> diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
> index 4ef0ba7711..235cdfc824 100755
> --- a/t/perf/p5314-name-hash.sh
> +++ b/t/perf/p5314-name-hash.sh
> @@ -3,9 +3,6 @@
>  test_description='Tests pack performance using bitmaps'
>  . ./perf-lib.sh
>  
> -GIT_TEST_PASSING_SANITIZE_LEAK=0
> -export GIT_TEST_PASSING_SANITIZE_LEAK
> -
>  test_perf_large_repo
>  
>  test_size 'paths at head' '
> diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
> index c89b0f1e19..8d187f7279 100755
> --- a/t/t6601-path-walk.sh
> +++ b/t/t6601-path-walk.sh
> @@ -1,7 +1,5 @@
>  #!/bin/sh
>  
> -TEST_PASSES_SANITIZE_LEAK=true
> -
>  test_description='direct path-walk API tests'
>  
>  . ./test-lib.sh
> 
> 
> 
> 
