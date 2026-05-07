Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E340221DB3
	for <git@vger.kernel.org>; Thu,  7 May 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148478; cv=pass; b=aZnqxx9/ODzyT+04qQ+BM29odYhg63jQDaYZ09ZcQwVSv/G6QSiBfce5FP2pdS4lJP2sI6RXeebg1rOdRD71a+3BKqOsq6EpAAMiffhYH2f5hN8MTbmJzdZYS89FoI6gD/jsJHXaQGnUaRz3aCthyrSqRdF8Y2sVtmwy+VcV6c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148478; c=relaxed/simple;
	bh=ubXQVOAzOipY+gFnuAECrHhNmQhPd+lPM1//2YTEEHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiaaPT9oqwJd3KDxbUBE1PB45o5ZY+Sx2GoC6hg3KbQV1HNN7X6AuHkSmE0ciPatBAjhlORSuQLm/7c2VJ2mrGKyQ/Sdg6ewPCiaWND94j8j0lU4NGLPLsrj6hHh9klVtYbPA3qn9rkfNxq7bKpcUUtBsmPfb+jWTo92l8e7Zd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0L6oYHS; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0L6oYHS"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c37eafcbeso671370d50.1
        for <git@vger.kernel.org>; Thu, 07 May 2026 03:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778148473; cv=none;
        d=google.com; s=arc-20240605;
        b=Jn5F8nB4zWY0rVYXx93vT5XY3lw4M22dFHlcLhaskrtQhCeEqoOEeMaNBVUTHEvx3n
         dO74YErqH0fTvsBUcuglpfBbFNU95wlWrtA87jGosalNhkt7ECBSxagQD35gu6ailwBh
         +94RcSepeNnrKKqWgeoekWIy7ZtaW4GArcdpMELOhh5R79IGm0lDwEtovwTIBsvpuB7B
         Xp4vi/pbWOpY0X11zTetBpJIyBgjb5B4w8k0DFxT75cEfo8aD6o6iTboBT2wW9z3U9yB
         e86otImyLXNw0ltWBBVZDn5flGKbRCvCIwZx1UIKPNq7xQo+K+OGiuZBh2hMsUlDGnBB
         IuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eqVPNnuE53degUO+YWzbq907aDZPFfAWi2dezUNygYg=;
        fh=+1MRend4nV0HMxc/17vhViVinOugLXiLLAwZD1yMKZM=;
        b=i+rbg2mHA0U5sjAPIq7W6dGOIHz8n0t7B15UT/30hRpLxcZC4RxY1eCZBSCW6M0Xvf
         zbmn4tThcLBac4+svOlagGSJzpJSrGYpUvqsL+1K33RRmmJvlAnYq3fkR9JlNeN2BYEj
         pLHQJo3kUWoEdUCY5K1jIaS7NJhcMN/Zyfyi22QuXN8LTRG5QndxhSPZXYfji3IS5DhG
         MdfaspR9UGRpcfoeFf5FWMuXd5T2sWDreYJjXKROA57K2RLK/3YMigr+ft3GuNgYp/I6
         RgWvy0YcNGwFB+hMIMRgJjkNxGZHA4mHnwlP4Fm3XAvFIGaQhu+YZSG1gqK8AsgjKJ5c
         +GLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778148473; x=1778753273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqVPNnuE53degUO+YWzbq907aDZPFfAWi2dezUNygYg=;
        b=i0L6oYHSae8qdAKVm+HUcERwlM3WXKLvpiCQp6Dz0VdVuwOkbbyDdegHM0c0nLaT1/
         couvcJvqIcG8nTPqhjo9P/REMuihIzbDJclxLP84rrEHDMwGu3S0VAl30lTK4Va+tgev
         T+iNQaByLaAzCp1lv7O2gKSJ3b15FHW2+ZsFJYQiKtA2pVPMrONdlZsg+Y07wVu2wj6W
         nwMpxM4rVXXkPkrRn1BotqMal7LXRnYTTRbRHzMed+9e8ZsZVmLzenXrS5qu93+ise1J
         Xcm6/vSI5ubqZfAT1OX1arhU5tBx+TrGPoGypaw37AFxp2AN4Y5dYxJkMcOLlee5AFKv
         VgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148473; x=1778753273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqVPNnuE53degUO+YWzbq907aDZPFfAWi2dezUNygYg=;
        b=QnYIVR2d4wSQbCEWY4h2li5loI8u7lvjZK1dgBntFGn+Ig6e+egC9tlIyizoE4xE3/
         OgupPr9VtF0bKBHzjvWrNjkuMVtU/Ift2dRnBMOIL83NfmFZTuGmxktLIuUuZsEHBrHH
         qecWsuEsrMfHzQBgm3DT62Fs8LXwFLCRzU5nW16wxqOQIqEeF/jEX2MahWEXBJkGdb1S
         Efrk7m/LU6JAV1A+fyiOBRmcCqG7D7rG6kTJ5WYJdfvWL8JJiMXLKLZU1stVtQcLxp8K
         JamIyjxMNiMIuWs4i4FmTWnqPbsjh1J7TcwTCZfTm1DyHdJvvA8wGJcKkh1YloPdVfdR
         oLvQ==
X-Gm-Message-State: AOJu0YywI8OezaZzmuAIn0rvW77f+CR//DON8y9gxd/Kit5HByeBQb7D
	obKtXQyPLsIQjNQO+PuHU+yY1XSWyvd8+DERB/YeyxOQC8vmvCA5tiU/x4bsGlxMVkz4vRd+6cM
	c4Oy7R7f7KyA5+JgnBY+L5LNbQBFP4mM=
X-Gm-Gg: AeBDiesqo4abRqHqloX3XQy2TkEGSUqcCLFK6epMO4UAyOxAlioQLTNl7DEcoy6LCjB
	jLDBr7dBi9MEIUxXj66C4H33fPnU1RzBvTFd+oGz5sFp5KeS4vT16VNiAuMU9E/QrjkSkuKFBb7
	anH7Q1N0Fo4GdD+F2xOWPoKIF/B2jC3jSRuq6+reURuuxLdw3O0H5MYosvEbziXUYPFxN5bVaSZ
	5ALMNyIr/+owXPQ7XTXfSgjaOpdRnQ+0Ifna6jtQ4MXKm8VHOsd398T68zi8eLBKUOOPjlScCGI
	aaJKaXJHFZQ4ZJU7RGDnRTAWV9IVuuRBFJMArSbJ/BWTz2/QVIoSOvV4jG+UeiQ7/IUk1F+7pYQ
	/VoL/gL1fJt0fblnhcQ24mq8QxOMJA0RCcsOvM4+44WgG5io29AnoShhA4K1i8Q9nU1uvlmrsbp
	vUaitLU+hz2MIbPPkn8lkmIsz6MKQ=
X-Received: by 2002:a05:690e:4390:b0:650:1bae:2f7e with SMTP id
 956f58d0204a3-65c7993e274mr5526953d50.24.1778148472765; Thu, 07 May 2026
 03:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2291.git.git.1778120192298.gitgitgadget@gmail.com>
In-Reply-To: <pull.2291.git.git.1778120192298.gitgitgadget@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 7 May 2026 12:07:39 +0200
X-Gm-Features: AVHnY4JiTwJ4SBitj1Dt9iioKw9Cs0TzDQk6zMlFSg57V8keLIljjLYgPOVLUtQ
Message-ID: <CAN5EUNRn+SqALbGR3KE9zUKxUfuJrqvK+XJcq-t=biTw56m8kg@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: suppress C11 extension warning for Clang
 on Linux
To: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Shnatu <snatu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 7 may 2026 a las 4:16, Shardul Natu via GitGitGadget
(<gitgitgadget@gmail.com>) escribi=C3=B3:
>
> From: Shnatu <snatu@google.com>
>
> When building Git with Clang on Linux with DEVELOPER=3D1, the build fails
> because Clang treats C11 features used in glibc headers as extensions
> and raises errors due to -std=3Dgnu99, -pedantic, and -Werror.

Hi Shnatu!
This is already being discussed at:
https://lore.kernel.org/git/20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-=
5786386fe512@pks.im/T/#u

You might want to check out that thread.

Hope this helps,

--
Pablo

>
> Specifically, glibc's string.h uses _Generic (a C11 feature) in macros
> like strchr. When these macros are expanded in Git's C files, Clang
> warns about them being C11 extensions.
>
> GCC does not exhibit this behavior because it suppresses pedantic
> warnings for macros defined in system headers.
>
> To fix this, add -Wno-c11-extensions to DEVELOPER_CFLAGS when using
> Clang, but restrict it to Linux (uname_S =3D=3D Linux). This suppresses
> the warning for glibc headers while keeping the build strict on other
> platforms (like macOS) to catch accidental C11 usage in Git's own code.
>
> Signed-off-by: Shnatu <snatu@google.com>
> ---
>     config.mak.dev: suppress C11 extension warning for Clang on Linux
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-229=
1%2Fkiranani%2Fnext-2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2291/k=
iranani/next-2-v1
> Pull-Request: https://github.com/git/git/pull/2291
>
>  config.mak.dev | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index c8dcf78779..f1dcf4329a 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -87,6 +87,9 @@ endif
>  # The bug was fixed in Apple clang 12.
>  #
>  ifneq ($(filter clang1,$(COMPILER_FEATURES)),)     # if we are using cla=
ng
> +ifeq ($(uname_S),Linux)
> +DEVELOPER_CFLAGS +=3D -Wno-c11-extensions
> +endif
>  ifeq ($(uname_S),Darwin)                           # if we are on darwin
>  ifeq ($(filter clang12,$(COMPILER_FEATURES)),)     # if version < 12
>  DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>
> base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2
> --
> gitgitgadget
>
