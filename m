Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131197478
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474724; cv=pass; b=RZrfUxTi8bklMf2kQ0aKWatGEcjzWRVzgGfqaAMpY7bF7swCwRGTE+SKnRp8Mz9yA1/9FE/zFZglfaQTTcB+5LMyupiXYGsrTMQbdWzpiaIYBwSYhpJmVcjKEzS4rwa+dU7ETUV0Ak6hrOF7Ql5paQAFUawaVxdSmkF8pJtX05Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474724; c=relaxed/simple;
	bh=Mu/eO8BLYE1TdkjPZbhiocOtgxOEgRlv2XK1oaPhUsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/+CDljMc9B/0eBURwholntr8VSk9hozd4umA9PgdemITGyyw4bCk6rSvQ5iophz0+0V8Wqf40fDWm+pI3DQ65Niuusi1LnlSyIZ9d/pThTq01RqE4t5TLGG1jBytE9sHi/cgDTw5A9LNn4ZewX7yHHbQejujcYbhx/OPu4THhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5zfFyu4; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5zfFyu4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f943870baso335690b3a.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 18:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776474722; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+F+GPx9LkPW85vij03owUdgslUpd1mgCNkSg3l2uIWCQDA+9W9fcu25yYHb8NHrl8
         EHoY4Mcv5VdfObtOStsdzdA0C+uv//I6Q20QOBhL8kfb9DRCl8tRP3upf3Di8A1bMCtY
         K+U8KQFIIukkhaJt58RwF+XV8rND+isShVQr4ISC8r1L5hpGIa9Hje6k5IVL1eof1A3B
         LmS7PKF8XER07h1CHyhS4wBGgO0c9QYFxewzw0HYTwggC0XhDYlm8IuoRn4bsPluCkzV
         +RojhYtyrbrtQuodh8iJ2N8aRYLDrLP0k4KOm6FJ3vTbnP5HJqzq3YnX8jTOGjAJLA7o
         fcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CbKoGLLcogYijGsUJXehejf5FQx+Co1PY+5prU5L290=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=N4DnsikDBohv4zXsigs/2Q9kW2gOfhMoKP7B4UMiU9C4qz5W1uiIdFgkmNYQymY3MF
         dXfrQR891sY8gtUDwncfQaSp9wLpKgP9+Gb3BqieND5Ae8QClPwgq6iM04/A8XYiT+OL
         D8IY7/70t93bWhtdPJHYK9kH+4pTVZ+6ZifmXU1U+u5yXTZ910foLyh34v7iFw6rdbom
         RV67Pc/3OfA2Z9EMNYd5KRpocC2XFcAZL4MuL72IlbpEVPKcL9Ugb9cRso+eFo+PAO/A
         t6clR5SvaZgi7tNtOCZF/7utOHEqfQmZzsmqLHJa6Y+vWiO4bCnsKp8JSJo9k5ybZdKO
         yjnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776474722; x=1777079522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbKoGLLcogYijGsUJXehejf5FQx+Co1PY+5prU5L290=;
        b=L5zfFyu4OguqQj/+993ydKBuPvfUCW6lwmYRCrYZx4fkuXpdfXP1wPRgfgt9aOCk08
         OVOgbIUpf1WOcTdDsGJMwUeVTf8p34hQMATUR9iKs7i4lNuOW6ijkAJdJMlO/GgBpKZb
         lDWTUR4azQkOpujWRKLprfyNSPzG31f6UFyw8DaHAoGh1MUSDFLec9UEW14OdsA50lMd
         Ku8lZG9//V0YaltRFJzPY5R1RYKJWPdPwNDEJhTmm4x0bvNs2rQWtFZ5fXZIY+5ZgYis
         MlAipnd0qCvugTSshmNSSftyK/gyqUKYwd7JjcwQ9FB+24g2tYiq6xkSMLBGW/PBh1fp
         4eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776474722; x=1777079522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbKoGLLcogYijGsUJXehejf5FQx+Co1PY+5prU5L290=;
        b=TTFkyVZm1L4/dO+Kd2Mg3nDhZam48DXOKK8+o42t7ZJjTo7oO1nuIjBHdY0CV9lETt
         uIQysj/ASqI4o4tjQIIiPpgAEhk3d+wrz3KDabBgeEuxGhWvXzlAmMRktu1qF/a1TZar
         UIe1jXgT1AKy99N7Pzlsnym35lUMFFgvaorCP2acKpOAt3kxAFLpTySXYqZDHwzkUupV
         JnJPxuyRWI2eWrygtVuGMHmkvXBoZjkcl1t2jtrfEEG9nxEig6lwzfv0j8jIAC3YchQA
         SqP7OC9DcZgm5hnpHyw133e/i4vQ6am4U3KjDsAXJqeoWbQAvC4qOCwZ6teDvmX2eGsR
         0jRQ==
X-Gm-Message-State: AOJu0Yy1fxYdwcGUnDO8N5QA3arTudveGCSWrV8o/LyMfhIuoj998jiS
	WEZtNzh6bSLWzcmNAp+8ZDfM5TA7l64GprB1GRbmjUZ77jQmpW0CsupKJqrs6Ktto2UA2aKQJpY
	e8LEYPeq/4t8AOvuTXcmVM/gAwip+cFlpxA==
X-Gm-Gg: AeBDievqc5JUKN4uvPfH42nRucu3ZoiJY/i2Ir8kAvMMxvc+5RuPFmcR6t/Co2oZy3S
	r9UpHTHfcPAxqyDThubEV2Rgbu0UuAIaFIp4mkbsmKteDB2Ubr7THj0bu5xOXu6ia/sMC85ShX/
	1RukyT+SjIN/vg71PHYX2oTr5bfPJ4B23iVrLRBkldhyJQ/npV53WL7Z9CMuQS98kAIN21idB7K
	3FK6+M1ZpvPuH4j5nbBJp0NCvWCjliAkPVY8mre0UglRnTZ78EbX87gGGT1ljB2Y+IjFLZiJcIE
	yu9jV8NnwU8ie8U8Hr65pnWd0wEBbIQE9siQGCX6ZXh2+ctUFbG61Ca67lOzaWK5TiL7dVqczHQ
	/BqlYCqm7CmS9maqwgbgmugWrceBykWXdXcXa
X-Received: by 2002:a05:6a00:bd0a:b0:82c:215d:5e9d with SMTP id
 d2e1a72fcca58-82f8c91b61dmr5376067b3a.32.1776474722261; Fri, 17 Apr 2026
 18:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im> <20260330-pks-setup-wo-the-repository-v1-9-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-9-0d2e822837aa@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 18:11:48 -0700
X-Gm-Features: AQROBzCiDmHOLn7D-XEORPtFkKxm3LQ6bls2HXIe0tAnDNmifTtzoSIpv5BMVLA
Message-ID: <CABPp-BHOvDaWXXDnpPsoDTe-En7T4LUaVqcJZ5Jst8zaQ-mrTg@mail.gmail.com>
Subject: Re: [PATCH 09/18] setup: stop using `the_repository` in `setup_work_tree()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Stop using `the_repository` in `setup_work_tree()` and instead accept
> the repository as a parameter. The injection of `the_repository` is thus
> bumped one level higher, where callers now pass it in explicitly.
>
> Note that the function tracks bogus worktree configuration via a global
> variable. If we have bogus configuration, and if later on some caller
> tries to setup a worktree, then we'll die instead.
>
> Of course, tracking this as a global variable doesn't make sense anymore
> now that we can set up worktrees for arbitrary repositories. Move the
> variable into `struct repository` instead.

Okay, we don't want a global, makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>

> diff --git a/setup.c b/setup.c
> index dca32addae..64a030c6cd 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -26,7 +26,6 @@
>  #include "trace2.h"
>  #include "worktree.h"
>
> -static int work_tree_config_is_bogus;

So, we removed this global....

>  enum allowed_bare_repo {
>         ALLOWED_BARE_REPO_EXPLICIT =3D 0,
>         ALLOWED_BARE_REPO_ALL,
> @@ -485,7 +484,7 @@ int is_inside_work_tree(struct repository *repo)
>         return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
>  }
>
> -void setup_work_tree(void)
> +void setup_work_tree(struct repository *repo)
>  {
>         const char *work_tree;
>         static int initialized =3D 0;

...but we left this one...

> @@ -493,10 +492,10 @@ void setup_work_tree(void)
>         if (initialized)
>                 return;

...and because of this other global, we still can only set up one work
tree in the process anyway.  Should 'initialized' also be moved to a
field within repo?
