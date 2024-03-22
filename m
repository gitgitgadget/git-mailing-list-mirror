Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAB82D6B
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148973; cv=none; b=DCZBc8gHK+q2XGkofCqTB0GDoYb+iQUieSPcneyUv7uykDSU0gROixhhfToEELNKdZJ6SHg3Z+tCqnkgWNvW0BwWCAnL/CH9PNBhRkB3+i4QZ7XUVpCh94YDXRPTOhWTiJy6sqI9PM418BQKuvZoOEWJfb9w81s4BaFoNmP+Hx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148973; c=relaxed/simple;
	bh=YXwa5me//u9AO7l8qeQ/nk9Ig7fRN4939kDxs43yGmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZHenltxE66NhCSA2o1fwQPZFaVBjmszCNm0U4qUkZFvfewYVM58W6Dr9DQHuRimHOeaPwIp1YK7sCF5KhAF/vNjhHcTmzQNa6icKHSYWyqtAz4GB6aN4SYO147finhENRuCX0jFe35+UiMFLU2lJWWRi+WCjW+szIYtCJs5aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-696315c9da5so20798856d6.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 16:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711148969; x=1711753769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYc5KyqGcR8fbeSm/YuMEBJDAJzLEsBeYwoSkJIWNGo=;
        b=OFC0SdDxIY2/Ka+vgXyAw9saZoq8pC8IsKtgvSY310gnUbEP4n+AD+vLrfxhUsEg01
         8vfH2vuSeLmDk4GrjER6D+r5iseudamxuZh8ysasIwYNAJFBijIk6wabb1V+wIc0I6wl
         IlrrvBs0hyqwA6DPz8H9x+dtzNIlK6mSlF5rAMZPrOnejniKT+VUocDacBFtMLvXCvMg
         RZ8Qt+5tx5jR7F1vVTg3LLAg692tfn2BEU2L3deuJwTbbZIk7qXSGr3L3b2eWZAwkK2S
         E4sWrccnDYMweuci4Ajnc6jBfjZwrRS6ZYfg7m9T3YVxiTuYDKC2lPptiRXTACt8Y2jP
         rBzw==
X-Gm-Message-State: AOJu0YwQmcVi9kT5IEFtxg/EIX9PsZ665d3MxZtTS5o3mQmYHSXspLFZ
	7oNExFDtQM+fSQ+yxsEXcke6qcQCuLk3jR8hJ9aJzrmSgUxTqkFyT8E4AX+cJuj7Z5jlYgkgW4m
	wOew+LXlHIdLAVAJjqYrGiYegYwYrdVAi
X-Google-Smtp-Source: AGHT+IER3b6PjMqmyP+Ug991BKQUPmiqNSR1dUauUfr1veQX9yzCjB9zSbx1vXCMsAKMplxNqWlUm/LN26lPj8Ws894=
X-Received: by 2002:a05:6214:1308:b0:696:42f7:142e with SMTP id
 pn8-20020a056214130800b0069642f7142emr872848qvb.47.1711148969577; Fri, 22 Mar
 2024 16:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322221327.12204-1-mg@max.gautier.name> <20240322221327.12204-4-mg@max.gautier.name>
In-Reply-To: <20240322221327.12204-4-mg@max.gautier.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 22 Mar 2024 19:09:18 -0400
Message-ID: <CAPig+cTeXMw8pTS9on_CSJraPDYKSLaFd82LEtWjFgOBzH4=yg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] maintenance: simplify systemctl calls
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>, 
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 6:13=E2=80=AFPM Max Gautier <mg@max.gautier.name> w=
rote:
> The systemctl invocation to enable or disable the git maintenance timers
> is needlessly complicated:
> - systemctl does not mind at all enabling already enabled units, nor
>   disabling already disabled units.

Has systemctl behavior changed...

> Use only one systemctl invocation per `git maintenance start/stop`.
> Transparently pass its status and output.
> Add the --force option to override conflicting symlinks to previous
> instances of our units files which lived in $XDG_CONFIG_HOME.
>
> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -2303,70 +2303,35 @@ static int is_systemd_timer_available(void)
> -        * Disabling the systemd unit while it is already disabled makes
> -        * systemctl print an error.
> -        * Let's ignore it since it means we already are in the expected =
state:
> -        * the unit is disabled.

... since this and...

> -                * Disabling an already disabled systemd unit makes
> -                * systemctl fail.
> -                * Let's ignore this failure.

... this were written?

If so, do we still need to worry about older systems in which
systemctl prints errors and/or fails outright?
