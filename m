Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4B175A6D
	for <git@vger.kernel.org>; Sun,  3 May 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777806466; cv=pass; b=kEnkbnIlRpbrCR/3HPhgxWSLO9LvVLYl9SFmtqaHmkLsan/ooObVw3N52DjleEao/RhIfen1qpVNY2VTyPyc+SdCwj5bNqKwqZflbChkzmbGoZE6H1aX0bUnFHkrFvGjvCGQg90AJ6Oj+9pc9bmzjv25jdW8+hsDLX3sHF/xKW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777806466; c=relaxed/simple;
	bh=3nxNlJOLC5KdOYwl9fCLsCraqHpE8U0jLCm8Tld3eSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSxKmA74oHSrIrAbaXgBwIClMd3eeLBaFuYiQ1CYwPDn6dcHx+nE3ojvuUePIqel/TD7Bg4jE+3iWc0KKkE9J83dfh0bcW3Sqp/t7fLrCEwDVxCvhJsDZtGoQjy3YQsteX3hICL5kVpz5C/A8CUJ7Mx6j4ebhiapbtTSe7kTZaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyci58u9; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyci58u9"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a46ebe2beso29946887b3.2
        for <git@vger.kernel.org>; Sun, 03 May 2026 04:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777806464; cv=none;
        d=google.com; s=arc-20240605;
        b=RdSWlqioht8QFHEYYG1vXTzXHYgemxNZnGIdj4ETd1IjuVUwYXkbcsclN2JHNN7Tb7
         pWTk4EWbtcCS/qE8Ybouvo9vEfeKnQcewBv0RxAhF/JGYL+aA6+V5xO9PmJIxXVOicZn
         VZoujS8hSRQI6AJnxh4Khb5W5v1hqOw1hOwkaE90HPn8scXeOVV+EbfvAW4Yml7sx2gm
         /+Ws6VlcmjmeLfvbENkIB1jLMgbsehYxVVGhjsTkY4kanq4a0Ts0OAmcNTiYL+MC7oHM
         qnm5vuRVUVcTzG4/CfacbK4vM5SRjz5HKkhgKExGWfqOQ5UTCbp7goIgsyPdAFYURxCI
         caXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQkb8ZZ3DP4mzHA/hPkoipNAnElmmNQfAaI0rbefm6c=;
        fh=OIENVGo3LrU6+dU4yJj4SzzJANsaF4c5HQiv8W+uV80=;
        b=XfDp4+uNZ6sIKCHVHFjRt8Y7EeUGsvjkcGb4E3fO6tAQaXU/P5wBHRd5DBoWKHS2Mh
         eH9mEWhYZzMxzpD2juzG5+4Udf2NrKma/FvgsJqNVV1eK8pK+kjM4g1dDg4sCYR1uxJ3
         /cyptyg9e6Iu+h14DuMmVlmsHffk3V3h589aRR29SNl1FGABACIZ8ovH9LoTFhKzaS0e
         3ljj6C8SHhVvvMxmr/PD1vn2ga76CFLvSRvxkRyAVpvoKQu9RtvCJCNzbEwh9O8o5B6q
         G7F9N6EUS4Sq/S7SkurmZoU4J0D+IWXujA9rirbnR1RwT/NvG8gwD7SqUPuAvx2mzEFK
         4Smw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777806464; x=1778411264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQkb8ZZ3DP4mzHA/hPkoipNAnElmmNQfAaI0rbefm6c=;
        b=Iyci58u9GLJI+8tmpf4eTJXJdHfRn+2Oe32281MBbAZCxfIG1xxOy5+u/GiXIplERH
         DOJiORQOY9PMHTlmN8fs3/ydgl2TjbFp7CjOD0bQgOoOwozA46q4VWY1PAtvy/X85uUk
         FZLOA+GL565Z7Z9oPR4hwKCMEqhTrBci+uHOXqPvV2zd1rmwQ63rqE2o0Z3/ZLCAzgvC
         tCipTDlxiYg9/TiDm9x0L+yb1SZH/e2+ci6o45xeo+SNdxQrWRknDEAO2n6XD1vPMhkc
         3o4jIMBg3gFFq6r+nRxx3LgCX/WZQxKqpeo35vDqYzyGOl3zRyvlYl909NR10r1/P9Uu
         M5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777806464; x=1778411264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQkb8ZZ3DP4mzHA/hPkoipNAnElmmNQfAaI0rbefm6c=;
        b=nEr2rO+qAakoyr7v4N2P8RGRYLzfskk2FFc6DXlHvgutaLmDGd7R1+ibHl2QUSleaU
         bbw7kAgf+FD89h0FwJKocGF45DLKCG5eh01N/MybQXH/Pk8+aZ6PKRoRqedakmKULby3
         fPXNpziuXDIxHOcgR8VIP3w0MdbGXEYFHlriOXD4DC5HCt6aonXeklavbk67x9PKXE81
         bud34RQ58c5SgfXIW60fl3mozc0iRWpMq3k2RHKwBF5pGpM1D3/INausGWgssMBzzEyJ
         UlJfg5XIsPDZKsJ4c4QeVjKSgSpeyxfEtEeXH3ZI6GaSkZ875gg7+q2AEkHkfIRuBznd
         VRJA==
X-Gm-Message-State: AOJu0YyDWLVzm1+QzZxzZmemjBejwbCLN24LHmLcftwVKJ6pmY96jYZP
	wbkhMiMgdv0Ki5j+UZJz1hzMp6Uh1bNxrkTvA83QXGPzDGBgEM8/IvLRieNExdcbY2zsAqHgt4Y
	FN3+ioGwSHQuSCBGzs6AsCwavw443jTfpdm/UuWU=
X-Gm-Gg: AeBDiet9uh2UyDies+crDm+Ku7233aQOI16TEtg/f35Hcj1DET2u4Gv9VO7tgp+ZOik
	IC35kSjryY/v80wxXrhDElZ9QchYwM9quRsbd9wQxzDkWIKfgvyF16GlPHXzsRjomq8mk66cTeZ
	58EhHMmxp7TzHq8XmevmwSORPxK+wAZV/v4U3QD6ZntJQEbsFJaexc9XzA7m8UuNF4JC1ybpC6W
	1/CslEUbJPlpR40PgcJvTR6RAaj50E3j0xCTQm5YyA7LmAneUEDqn8OlYyZtTIpdabb0pJvFiip
	IQhDRrmFqEaHmRwaA30E2jEUEXNP3VLVLUVU1nsiJL4Q3TKcfXHNVxI/JqIcpI53/jDW+ozlkY2
	tbbb6Q4t3iyBoadyyvVsVS1aKVTl6nUF/y0br/x8Cm64rMgt0ZaVpwLd9qmHPD1Ee5jKkr0tXZ+
	1UBXDsla7mjhMaA4I=
X-Received: by 2002:a05:690c:3:b0:7ba:eefe:9f8d with SMTP id
 00721157ae682-7bd76f7c4b0mr63779657b3.8.1777806464437; Sun, 03 May 2026
 04:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sun, 3 May 2026 13:07:33 +0200
X-Gm-Features: AVHnY4JQ0m3vaK2sQyxKibLJTwtnun_QHGtRWu_fobtyvpKQ_roV1jIEY6u0eh8
Message-ID: <CAN5EUNT27bYwjdXRQTffbtHFpkV68rAajqgXtbKHu6OjhzG_mA@mail.gmail.com>
Subject: Re: [PATCH] submodule-config: fix reading submodule.fetchJobs
To: Saagar Jha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Saagar Jha <saagar@saagarjha.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 3 may 2026 a las 12:14, Saagar Jha via GitGitGadget
(<gitgitgadget@gmail.com>) escribi=C3=B3:
>
> From: Saagar Jha <saagar@saagarjha.com>
>
> Signed-off-by: Saagar Jha <saagar@saagarjha.com>
> ---
>     submodule-config: fix reading submodule.fetchJobs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-228=
7%2Fsaagarjha%2Fmaint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2287/s=
aagarjha/maint-v1
> Pull-Request: https://github.com/git/git/pull/2287
>
>  submodule-config.c          |  2 +-
>  t/t7406-submodule-update.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 1f19fe2077..57b190678e 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -1037,5 +1037,5 @@ static int gitmodules_update_clone_config(const cha=
r *var, const char *value,
>
>  void update_clone_config_from_gitmodules(int *max_jobs)
>  {
> -       config_from_gitmodules(gitmodules_update_clone_config, the_reposi=
tory, &max_jobs);
> +       config_from_gitmodules(gitmodules_update_clone_config, the_reposi=
tory, max_jobs);
>  }
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 3adab12091..234a021fb3 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1055,6 +1055,16 @@ test_expect_success 'submodule update can be run i=
n parallel' '
>         )
>  '
>
> +test_expect_success 'submodule update honors fetch jobs config from .git=
modules' '
> +       test_when_finished "rm -rf super3" &&
> +       git clone cloned super3 &&
> +       (cd super3 &&
> +        git config -f .gitmodules submodule.fetchJobs 67 &&
> +        GIT_TRACE=3D"$(pwd)/trace.out" git submodule update --init &&
> +        grep "67 tasks" trace.out
> +       )
> +'
> +
>  test_expect_success 'git clone passes the parallel jobs config on to sub=
modules' '
>         test_when_finished "rm -rf super4" &&
>         GIT_TRACE=3D$(pwd)/trace.out git clone --recurse-submodules --job=
s 7 . super4 &&
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> gitgitgadget
>

Hi Saagar!

A few hints before this can be reviewable:
- There is no commit body which, not only is a must, it makes it very
hard reviewing because I cannot know what you wanted to do and I have
to imagine it.
- CI tests seem to be failing, but the file that reports fail doesn't
seem to be related with your changes.

About the code, I can understand the 'why': the function above
'fetch_config_from_gitmodules' builds an struct inside and sends the
address &config, 'update_clone_config_from_gitmodules' calls the same
function with &max_jobs but the error would be that max_jobs is
already a pointer so there would be no need to pass by reference
max_jobs.

But this kind of explanation is what should be on the commit body.
Maybe not this technical as the code can be easily seen, but a high
level explanation about what this is.

Looking forward for a v2,
--
Pablo
