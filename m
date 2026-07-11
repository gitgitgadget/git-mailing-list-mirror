Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D82F1FD0
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798240; cv=none; b=VB6guUCbPU5U9GnNCuzElKKKKsSY0UQrM96A09QhguD2/KU+5JlqceTXSZxCENXmrhOAc+99olrkz5AWyRPND3BnRZE6MHVuWDruH/Jcs6AyUCK2k2cN6sAJgd4MpjOhkiRroiyY9H4qxBm20OqlrhVTz11LDrWAwJXY34ZME+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798240; c=relaxed/simple;
	bh=+9boAuej7vVuhjUPVlo0xvIfVIJ3LKbUBvQhHIbNPb4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cfUHh4x15xEnQYyg0tcxwkXKnZ1xeTgSqv/VJwGYDeK/0aE7QDRd5g/TBuIxUXLEViClTdTgMZp8xs80W1vt+Yrc8GbYsoSA2uxZ3170A6Sfo7CHmWvu8Alvs94qfFWIBfWeE1FbYjpt7PUN7bRcx5umKso8LzQOfXDEaUWnpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YomzFHI/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YomzFHI/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so9669485e9.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783798237; x=1784403037; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KsIOPlA1c3xs48jeAP/LcAQl+R1B26cGmGxyOtSFI+s=;
        b=YomzFHI/iXJarLYi6/lgR/IznC86AW69jpPxrKTIbjwkdJjtY05q5Beuc3HEs5thBh
         nJr1xm91RIqyHDb6LaS//4U9evrTgZaZ37LP4kGTfeua465uTBuG8o0FzaKLqIghQ/GG
         lUDskhh/vw2VPsyMM7xol32aqNBfVqhEGXWfzsQfJtsS42m0kF93vAuBXCwotJSQUJgk
         GGLyQg96ZPPS83XkW5ebThcw0yyyAyhIAnFF4KazhG89/3URJ62hXenQ4CbiYbeAlY3S
         7zHqLXhYfcnMrX6etuvPCz6Q6GqnUrLl0Nynk4eWEeazu5Uar0AtyBrNFy1v+qBgrSBb
         ar3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783798237; x=1784403037;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsIOPlA1c3xs48jeAP/LcAQl+R1B26cGmGxyOtSFI+s=;
        b=YV3LHYUztePKVlFz6ZJT8PYzDdRa9stD0sDwjYCxJAsNggEErYwZyj6lRacOPznPvh
         MIvh1xkWrkgyudk1sOH00CU+h6GzqvvWZE3sy/O8iV0cr3eSm97NMVPRz23ijOKnxGzi
         j7ZqTqNtogQiQl7JMS6DzFJJtgx5P8brUnvyesEDstnt0w/yR2GYWVU62CWxRgMOHJYv
         ZAwuK7PLZ3Pn8qxftjJg0S16ZEkwU1nTzE0XTOPtL5Coxnx+E6yZuMcNeR5WQoQ5fGWr
         CCIQ613wzHju5yr+zZiBWV9SKSA2pQS268gzU+1gUw2e0QpJfAfFJVPzhmmK+14MZDru
         7SNA==
X-Forwarded-Encrypted: i=1; AHgh+RqMRFyZ9mLRJoZi+/ribPO0ej3oJ6AasYV9UlPbEIY2VHCFmVyIyPMh3OK+AoxcEpQaC9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEqFMVSg3ELw9wjUJTxU2czMvVeknZz4cK2dbAhgou1aGSCCn
	7X7AGOJlPRP4h7tPcdCK1LYQ9FDBIoNG6uTY9yrckYomOF8yvYVmv4eYeEXfM60A
X-Gm-Gg: AfdE7clD+xDhot8Nu3Ddkr5BTWZEo+x2YEPrmNTQBBO8HLOa80JK8ir+dSxfKXYKsiX
	sRdqGd3NAukgUNqYOVB04Y4/bgHD54MOkw0WNU38srAYZPQnXr2gHSokDHnRj0sSNPdodkrJtZn
	ALkc4r5kAMSisUt481UrgFwsG3Uoy1TpyUFq5BOaC1Hep+8As4NIO0hOYiFVWD/byepiWHshuBZ
	6kVgeHuXxvSVOgXR7aczfVZmOdxhKGhKN+dLlx+3c1yOIiBp8fNCuH7RmBeAWlcDWOeGJwuXCai
	cD1Zd5kZVoQJapS0Djzz/SkmBlnZwkdJy0CmO/hcyFxsZEVGpJ/3UtDnvmXVgfJzTYzo+l0se5o
	Q66FK1+8PPkj7ZWuCr5hCZU35YD4ywY39NObhSFiQGXT19DWPRRBlkpze3RSJecWwXiKRcHseL0
	cgHXJQRmUIspz0pD9AQsjEjkn8sJvQDy4XyZ4B4qD+1zE8R2l5Z89nqf94lhuGm8Rvo4hJGYKws
	1A/R8/yrfDuYmdq/yLlk1UANoaKE6k/9aVPaj82XXkGqUoUumqVZvi5ieSB1QRKBuCNuSqBsPu+
	iTU/7WGTOr2EB16s/mSsHoRMtv7/Z4FgmQF+luPiTUZuem9HY0KenjqulIq59gp06DXrQA==
X-Received: by 2002:a05:600c:608e:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493f8820806mr32259135e9.19.1783798236703;
        Sat, 11 Jul 2026 12:30:36 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e0eff1sm101147045e9.0.2026.07.11.12.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 12:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 21:30:35 +0200
Message-Id: <DJVZP8E2GS7C.1X325XFFFZ6WR@gmail.com>
Cc: <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Ayush Chandekar" <ayu.chandekar@gmail.com>,
 "Olamide Caleb Bello" <belkid98@gmail.com>
Subject: Re: [PATCH v9 3/9] environment: move editor_program into
 repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
 <20260709161145.13349-4-cat@malon.dev>
In-Reply-To: <20260709161145.13349-4-cat@malon.dev>

[Resending review against v9, I accidentally sent the review in-reply-to
v7. The patch seems to not have changed and it applies to v9 as well.]

On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
> The global variable 'editor_program' holds the path to the user's
> preferred editor. Move 'editor_program' into
> 'struct repo_config_values' to continue the libification effort.
>
> There have been discussions on whether external programs like
> editors truly need to be configured on a per-repository basis within
> the same process. While a single process might rarely invoke
> different editors, this migration is necessary for two reasons:
>
> 1. Developers frequently use different toolchains for different
>    projects. Per-repo configuration respects this.
>
> 2. Moving this string into 'repo_config_values' eliminates mutable
>    global state. As the codebase moves toward becoming a long-running
>    processes managing multiple repositories concurrently must
>    not overwrite each other's program configurations.

Nit:
"As the codebase moves toward becoming long-running processes, managing
multiple repositories concurrently must not overwrite each other's
program configurations"

>
> No standalone getter function is introduced. Callers directly access
> the field via 'repo_config_values()'. Heap memory is safely reclaimed
> in 'repo_config_values_clear()'.

Why no getter function here? in patch 2/9 repo_excludes_file() is
introduced and also access the field via repo_config_values().

Super nit: on a previous commit you used backquotes for
repo_config_values_clear() but now you're using single quotes.

>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  editor.c      | 4 ++--
>  environment.c | 7 ++++---
>  environment.h | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/editor.c b/editor.c
> index fd174e6a03..07d264cba0 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -29,8 +29,8 @@ const char *git_editor(void)
>  	const char *editor =3D getenv("GIT_EDITOR");
>  	int terminal_is_dumb =3D is_terminal_dumb();
>
> -	if (!editor && editor_program)
> -		editor =3D editor_program;
> +	if (!editor && repo_config_values(the_repository)->editor_program)
> +		editor =3D repo_config_values(the_repository)->editor_program;

Same as the previous patch, we can store repo_config_values() and avoid
re-calling the function.
Also, do we need the right-side condition?

>  	if (!editor && !terminal_is_dumb)
>  		editor =3D getenv("VISUAL");
>  	if (!editor)
> diff --git a/environment.c b/environment.c
> index 5950592d63..0a01f4761a 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -55,7 +55,6 @@ int fsync_object_files =3D -1;
>  int use_fsync =3D -1;
>  enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
>  enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
> -char *editor_program;
>  char *askpass_program;
>  enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
>  enum eol core_eol =3D EOL_UNSET;
> @@ -435,8 +434,8 @@ int git_default_core_config(const char *var, const ch=
ar *value,
>  	}
>
>  	if (!strcmp(var, "core.editor")) {
> -		FREE_AND_NULL(editor_program);
> -		return git_config_string(&editor_program, var, value);
> +		FREE_AND_NULL(cfg->editor_program);
> +		return git_config_string(&cfg->editor_program, var, value);
>  	}
>
>  	if (!strcmp(var, "core.commentchar") ||
> @@ -723,6 +722,7 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  {
>  	cfg->attributes_file =3D NULL;
>  	cfg->excludes_file =3D NULL;
> +	cfg->editor_program =3D NULL;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> @@ -753,4 +753,5 @@ void repo_config_values_clear(struct repository *repo=
)
>
>  	FREE_AND_NULL(cfg->attributes_file);
>  	FREE_AND_NULL(cfg->excludes_file);
> +	FREE_AND_NULL(cfg->editor_program);
>  }
> diff --git a/environment.h b/environment.h
> index 2e8352de7f..1ec19149cb 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -91,6 +91,7 @@ struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;
>  	char *excludes_file;
> +	char *editor_program;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> @@ -218,7 +219,6 @@ const char *get_commit_output_encoding(void);
>  extern char *git_commit_encoding;
>  extern char *git_log_output_encoding;
>
> -extern char *editor_program;
>  extern char *askpass_program;
>
>  /*

Regards,
Pablo
