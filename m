Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C243B6C19
	for <git@vger.kernel.org>; Sun,  3 May 2026 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777813637; cv=pass; b=RK3L5XYT+DlHMjN1syotd5D4nef4BaHgOQBC2AuE1VQBZEBFpfrZEDakrRLR2vVrAYEF8XJG9jKsDDJTQy8LyBw8WYOdXkkhvjLYhzKo/UCaghISgj3IaszdR5KMPXrRbQtjXrrluMZTaRMnzbezOv+LJIIR+bWpRcGwR1Qghms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777813637; c=relaxed/simple;
	bh=4qWbF8RpqOJryosGZaaM7We448souxd8qwePLrLQhOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txSNYgYMMvgHAqdUyxi3uBJmLZjDSlK7KwPUHV5TYHppGjFxNeZAgEhOjehfptASEi9kkSy8iRI3GTng2iqVgB6VJKtOjwpFmguMcuOHsQUz1iIB5QZagqPuT6RnaEg+/8R1dFuYyjjRe8N5yUtgunzSG/dIGm/UxMAMvTtJDTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ5gBjPR; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ5gBjPR"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd6f65c781so16696227b3.1
        for <git@vger.kernel.org>; Sun, 03 May 2026 06:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777813635; cv=none;
        d=google.com; s=arc-20240605;
        b=B2GH75sfQN09c3WtrjzaK6Z44smMgHGiODJVSmTmaFgJZbRNDofifyKQnzfvzAvaoy
         clhc83nFrmq1tsVji0fi9GeWr4UpG3ci1fdAzKPutmuoVxDJtUvZF+MSzqx7JOZr1e14
         zzdwrLXNP575829Xoqe4ILqMZXs9UM0YVy3Z/pu7rwOMYl8eIJWLQellofd0beRrUc6p
         C9XtqX+zjfEV4Uv3bGsNFFTWdYs7SNqCYHxl1hn3ua5geFQBhfPsPKpBKjOgqq4lktvB
         F4hG1+jTPZrZDuhjBnd5LNnpoln2nQYUrtol4bkuTR7noDwO+5QykLYdFDPvTE1i1SsI
         HhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2oLxIJyWnFf6Lriex+CvyaDTVLh7gGTYZ8ZZGVG+iVw=;
        fh=OIENVGo3LrU6+dU4yJj4SzzJANsaF4c5HQiv8W+uV80=;
        b=O8L1PhGlyyL6Ni0OhV8BxIvqIBFN6EJcjBeh36tjciKQ426UqgrtQhL6vlSSjxziw6
         IT+odiSlwUFhLa4hdZJAHCj+YvdidKYu46kcnwWaBQ0oTIZiGGQRxTrhG3A8rEY77/0O
         MjrOa7mx/Ua33BLGozEfRLcbv4VvDzwT1+LpguM8MC+dsLyYH5dSWfdjGyZAgpifGezE
         2g5yq2Z/JT68O43dPLJSKbpZiYjn99A2gy9Wu2dliMxfK9s2aoQlp4LODszD5+6SaLWF
         5JoaGVx4HJAgZusK4pbg4M+oFX0D23apSOg7iLP9Y4EOVEaS1MzJXYCsz+Xd28ibGM46
         Iycg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777813635; x=1778418435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oLxIJyWnFf6Lriex+CvyaDTVLh7gGTYZ8ZZGVG+iVw=;
        b=XQ5gBjPRACKTLtf/QQp0Y76jztCkcfl9IqKLaoiTQfqS0VXmG5r6DQ4HnpBH+FkWNW
         7/IpppQn4x1X3vEB+PK8hKI6cgmYffuaiCu+LL7M2vfuR5KvF6JMackQ241ykJLsAcuZ
         zuhJVsD6io11D21+j7bJE9RTbmto/iaU0dkUEwexJReCtzREhEYxSGOoxTYTqPNzyIA/
         uRN5O1tTb/B//RYzINHnkE5/xdSb/BSUx/ShaozGzh1SzLQiq+trzo2MJONYWaspLkBB
         EPTGsmtKtSOOf2hX/XSFAYd5ZgyX4u0Ea9e4vRaFw4qTH+oDOx0baVgtudkfyaKpHKjD
         hCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777813635; x=1778418435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2oLxIJyWnFf6Lriex+CvyaDTVLh7gGTYZ8ZZGVG+iVw=;
        b=J/Uyq8b+ERmqyC7bb87QNcdWwE8QrFhGP47hgfYGZ/qmbR2cpm9Wq67T0OCi5gt7vl
         zPED2r5iFHcBzR0xdJ2dfDtw9N9V9YyZKyGBcbSHPlqZlGJj8RrJrDfbNihGzgQ/pceV
         C+6lu0LPinWh9MmKk/5PC4FJTqc5wxKZw/dHIfB36OjRb6J9WIXtvcwxhgnuF0E2Dm9C
         fb37s3eXR7XAI7MDM100MXRucD+/DEQEE4Xnr7FhmigxtaysxuKKtW8wYlGiMYO8NtFk
         ldSwBrLcBcdKE9DO6wf+z+LBZlghuQnIT/Qmwh24y8261Z6SivyPUra2fzu6IFVOCiEQ
         4aeQ==
X-Gm-Message-State: AOJu0YzVk65EjSt06vj0ylUdaejO1nZFq9OLROV6MQFG6QdldbMMfVjg
	a5PN6XCKmrN4xtYpgbTX4on+G/9qD03t7T/xPxxd4MQXdjVJnf2hXzIHCmYSxsqg3SfJbmYDLsd
	BpcjlA4L8+qye8mzrxLbFcH25Oht0Ru4=
X-Gm-Gg: AeBDieu9k0z3E9/6+HOccUyNM0eWJ/AoDv6S9iS5HuqH0NKKtCD3mdXeuV4aLATKQ+i
	+I5fINx+oqtzbuoRatB9RUL+b/ARHODi3XbMrGPFB4z5H3tQcxWMXbDh+ljBpWvp5gaCwb5zLeU
	M6lWKmau4DJvvdaKbCUAqUnYX81tQhdY6+MKGo8tO85G/RU9cN8y6T8NGuAFT2jhAz68E06Wd4p
	xKcZclY13G6wGQlGMP/52pr46PMWclxVap4Co0zZEmJv9If3B0OdDR+wxkKPNnI0lkoIcd1rGnZ
	mNPVT5CRvdQRPCbO/JmQpm6Hy9mtm1J2hOulHTkvhdpxj/h0kUwrOj+mqbnW2RRuKFIKISziFS5
	20s57tOkzfx818h+YiZ1zgBIAzcwR4gQzwuu+/vy3emKX5PoY0wyB5bcpkkfvEk0QSheBTLECXK
	b/A9MdQk4HJEj1VBw=
X-Received: by 2002:a05:690c:110:b0:7bd:77a7:8292 with SMTP id
 00721157ae682-7bd77a78b77mr45846757b3.7.1777813634932; Sun, 03 May 2026
 06:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com> <pull.2287.v2.git.git.1777809430925.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v2.git.git.1777809430925.gitgitgadget@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sun, 3 May 2026 15:07:04 +0200
X-Gm-Features: AVHnY4KusqcowlJChDW9FZ8u1itXouKVmEeziL9CPbdUDoTCpCAfejawceMSOS0
Message-ID: <CAN5EUNTPiu7p=M8CZB_3Rcbsn34eEZC6YeiA3NW2zM7zSS42HQ@mail.gmail.com>
Subject: Re: [PATCH v2] submodule-config: fix reading submodule.fetchJobs
To: Saagar Jha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Saagar Jha <saagar@saagarjha.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 3 may 2026 a las 13:57, Saagar Jha via GitGitGadget
(<gitgitgadget@gmail.com>) escribi=C3=B3:
>
> From: Saagar Jha <saagar@saagarjha.com>
>
> The old code accidentally passed &max_jobs rather than max_jobs into
> config_from_gitmodules, which caused the setting to be written to the
> wrong place and dropped.

Better, but we can improve this, following
Documentation/SubmittingPatches [1], it is better to write in present
tense something like:

  update_clone_config_from_gitmodules() passes &max_jobs to
  config_from_gitmodules(), but max_jobs is already a pointer.
  This causes the config value to be written to the wrong address
  and dropped.

  Pass max_jobs directly.

I recommend reading Documentation/SubmittingPatches:
  [1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatch=
es

>
> Signed-off-by: Saagar Jha <saagar@saagarjha.com>
> ---
>     submodule-config: fix reading submodule.fetchJobs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-228=
7%2Fsaagarjha%2Fmaint-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2287/s=
aagarjha/maint-v2
> Pull-Request: https://github.com/git/git/pull/2287
>
> Range-diff vs v1:
>
>  1:  094c641227 ! 1:  868901f1a6 submodule-config: fix reading submodule.=
fetchJobs
>      @@ Metadata
>        ## Commit message ##
>           submodule-config: fix reading submodule.fetchJobs
>
>      +    The old code accidentally passed &max_jobs rather than max_jobs=
 into
>      +    config_from_gitmodules, which caused the setting to be written =
to the
>      +    wrong place and dropped.
>      +
>           Signed-off-by: Saagar Jha <saagar@saagarjha.com>
>
>        ## submodule-config.c ##
>
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
