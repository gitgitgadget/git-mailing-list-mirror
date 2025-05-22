Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B81A0BFE
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936834; cv=none; b=YomPz8MRbR/MRKZKBjNMVoUZYXPNd52mC0YWTyIc9pXpQUFCPBG4gQ456aSeRwEeJQqxJq3ho5VhbELsOEhx+KH82pB/rqyGcpOXNRzqVWFcK+tK/YfS+D8COAKu+4NTur0IG1/bJUJ599Q6N6ObkICnp3ZnDqmRg1rbiDrPLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936834; c=relaxed/simple;
	bh=oa4gclDMaS6goWC4SLCdSMBIOYBbNNX9YilIPpODQZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrSgsaOVDsatiCoqot3YTJoF23T4vzxt7gbXMGgzAf8GK1fAWiCUQ/iLUqJwRI4LpYkJG8j42MhU2P+mpIvdh9cf2xB26m1i/YBr2hQ0mYfu79b0bc4TDlUaM16Pi8wHq/LUx0rgOF5+o1egCAVujWOua7i2tzT3C7z+UkJ2KJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eeceb05894so10995846d6.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 11:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747936831; x=1748541631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5QjEk2eXlZDm0KPMeW1yQKx/5/hGlw58uka6jJEc7g=;
        b=LI/RzkDqs9Y9XtK10+LkOARjWu1rT6NKp8Ont+gssMrNm9MjspGkMoWQ1678F71lx/
         VO7KuJHVMgiebi6op9+WDv++zsgAxziYX+FUHt4JWidtlDQOs9bLD0EjAdzPW1EJYdqG
         jo5qPpFHw7N1IyxHsWl6cWAeNUvj2wBkx39/X41/c0aKQxCXWx2K8NXB8tHfb1rxpy+Q
         a3Zcyk1sibciguYJyZPrElaRVK2CPONRDdshqhYVHsaAc1KikTGvRcZC9mFWlMkvSewb
         jmFk4Zhsc3+/0D5e7akHmm91J28n2/Gl9Rlv8B2MCtkXYWR4zyMDgCmLEz3SLHDuz0XM
         sEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgw2bhTYuhwp6ZqrcNyZPrBHUT72Bb5iCLudA7X67mXJ+vPIfdCl/+FOJXxEj3lmFxGpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4xe8ElTbHOJw5qCEvNCswb7/PMSkX06+PPDC/Xnmg9IokYYR
	Cy1nvwMoNngUv8GTnOOw8wXtH3gB0ZzAw2rm5xWjrhnvezCYTzf0zTp3ZkRqTKrU8LsVd4CECR6
	FRHIxy43T4bjVm3Gu0XQzU8Ax9SiOQVw=
X-Gm-Gg: ASbGncszDXJJ5Dgk5bWjfmi/HWnTN502Oh5f73shVwntRSjqB/2Adcg01GFp1JM/hOC
	PNqrvYddMPZFVuU7C3h5B+bPi8a3zSJMRhGEyTCQnfmqWuDguxCIWL9LQOe33IpgYAQkn323Rrr
	yqbUKGgE1rfrj+3EmUpEezFYALotZLvbvK/ZvDIHj/hYH/pMGPQaDLcJ1n7VfLVrQ=
X-Google-Smtp-Source: AGHT+IFr+F6O1YlzGrzqtE7g58ACIGqZml062ciMBCMZd2jmGNH2lx/pbLzhK7CCoursIrCtDQEOV91FZ3BBQUkcEjk=
X-Received: by 2002:ad4:5f8e:0:b0:6f2:b095:a79b with SMTP id
 6a1803df08f44-6f8b0847d1cmr141939466d6.3.1747936829340; Thu, 22 May 2025
 11:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 22 May 2025 14:00:18 -0400
X-Gm-Features: AX0GCFv9HCHdvBWzruH30MZf_GWv-QuOXkThr3G7ETtljUEfhpmqs66fsQQ3Egw
Message-ID: <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>, 
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:29=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
> Upon setting up imap-send config file, I encountered the very first bug.
> An error showing "no imap store specified" was being displayed on the
> terminal. Upon investigating further, in static int git_imap_config,
> cfg->folder was being incorrectly set to NULL in case imap.user, imap.pas=
s,
> imap.tunnel and imap.authmethod were defined, and the values that these c=
onfigs
> intended to set were not being set at all. Because of this, git imap-send=
 was
> basically not usable at all. The bug seems to be there for quite a while,=
 and
> has not yet been detected, likely due to better options like git send-ema=
il
> being available.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> diff --git a/imap-send.c b/imap-send.c
> @@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const=
 char *val,
>                 FREE_AND_NULL(cfg->folder);
>                 return git_config_string(&cfg->folder, var, val);
>         } else if (!strcmp("imap.user", var)) {
> -               FREE_AND_NULL(cfg->folder);
> +               FREE_AND_NULL(cfg->user);
>                 return git_config_string(&cfg->user, var, val);
>         } else if (!strcmp("imap.pass", var)) {
> -               FREE_AND_NULL(cfg->folder);
> +               FREE_AND_NULL(cfg->pass);
>                 return git_config_string(&cfg->pass, var, val);
>         } else if (!strcmp("imap.tunnel", var)) {
> -               FREE_AND_NULL(cfg->folder);
> +               FREE_AND_NULL(cfg->tunnel);
>                 return git_config_string(&cfg->tunnel, var, val);
>         } else if (!strcmp("imap.authmethod", var)) {
> -               FREE_AND_NULL(cfg->folder);
> +               FREE_AND_NULL(cfg->auth_method);
>                 return git_config_string(&cfg->auth_method, var, val);

Okay, makes sense. It might be worth mentioning in the commit message
that these copy/paste bugs were introduced by 6d1f198f34 (imap-send:
fix leaking memory in `imap_server_conf`, 2024-06-07).

Squinting at the code a bit more, am I correct in thinking that
6d1f198f34 missed a case and that the function is still leaking
`cfg->host` in the "imap.host" conditional? I haven't traced the code
or all the callers, but I wonder if server_fill_credential() in the
same file may also be leaky. In any event, the `cfg->host` and the
possible server_fill_credential() leaks are outside the scope of this
bug-fix patch.
