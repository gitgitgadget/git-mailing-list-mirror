Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18031DED63
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377866; cv=pass; b=MPt1ydVPIJ+qJAltvAZQ1XKx3XgB9AgnHfb4dGDuKIUF9+ndld78+iCh03XPSiaSG94brEvxkQxD21WYVHUYpoIjkghnjbQhfTcrFNGxryeY0mQtolcHTyh3f0HnUZ0TkegpVAk0LioHBOpSB++u67+qxcP7RNwy1udnu9AtTWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377866; c=relaxed/simple;
	bh=QAJKSCzCkcXNosaPNO8eBy9UTqyQzDt/mlrTPt+8e6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYqTJgiJIZKyLJqAgBqb4uKNY8PYWDDayMJLxnXHMruAMzFzj8POsqNmIY1kGLagYtBj5l9TMUowdKnrN8V2UkxDFOUpyW73JzezrDVGhmByJhx/LmTmBT3Aru500Z4Onjju+RL8Py7CGI1OWWEjIRMXd2zJsom0RdZpHFNgGIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvzhdKMF; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvzhdKMF"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so6638811a91.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 05:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377864; cv=none;
        d=google.com; s=arc-20260327;
        b=AmwXIAdFkaaut6nPnPxLg2xld/K7k+szBqvDxFsYDTBIUvvflSjFVYN6RTzJmjEur0
         s2jikjX0xvkaUhzqQ7GlR/pPV92t+JYZS9LxPpKTfYpktdvYutsxwN7YRrzTezFMs5Y4
         WskOYD/tn9z2giA979Vm/JffY1vpIIGIrWiWOejh8igTqiMBwJKlFiu8WublZqru5li7
         Q+11MBljHwCMMsS/dXSrVENJwrSN9APkA7AcLDXZfuzwyn/5XaLIY0fY6dhFxlHPvfmc
         sN3tI2YYPLGSnRgEiP9KlqA0SiD1lo2aj/1JvDJFMxtZODPciWAfVzsKbGqMD76v01nE
         +Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZgIa2nvlAYASx0A3Vy396EFcyG+Ae8Xu0EszFJ8wQ0M=;
        fh=rFiNvNQNxUrLN5f3zmV2oTcIFmz47YHTSOdr52yHbjE=;
        b=N7et3MxtSZwIyxkcKs5D+h8cS/rcZQ6za/jIrq1hePuYUBjc1RiJGuuqCNS8Efmnnv
         QmdiKZuHzNdq7eO7qbXlZfIHKorw0HAOuJmRGYpJxpedVRtZ0kX69VsAozKdUD7c1r80
         /+kKMQcLj6PYzTSR8QbbMqrnhc3kyCkzpuLfe72Cw+5BdAdwW53kKOoZjUQR9iPmRJfz
         CENNphURl4PDBGK7MGBIfA3v7dX2CLlbClptqZAz9q8Zrb0sXEw42yyP0CPom0RfghRe
         /JgBD4k7obrmrB15Y3K0xBi8yoD4A7HC4jq23HHzYy+GlsqFmEa/KsXSf/uxxBTHF2LT
         QzOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377864; x=1784982664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgIa2nvlAYASx0A3Vy396EFcyG+Ae8Xu0EszFJ8wQ0M=;
        b=BvzhdKMFWVbkr7jgdWYmDcNMCdIVsLh8ImGzsjcoYz+pwcgpoy6trp/oIFx0/3Od1F
         UZOpl/86pmCJssA6dSM0QLewtg0ADWCu25HYBebB2e34/o4mj4OUWiYdR63DC1vv9icx
         6e+tZ6Hbj7MDX7dDNbdYBTFc+WW7MaJs92cY7vQ46UoKA9488AEMaReOw9Q5iAmijbdm
         KTgiWh4u0GkY+DGRgoZe3Iskwg3RJ7zKGGlBkoA6dcX/9RTX6R+qtlKJuGDxlmEhLCt7
         I9OCdQkg4wyXfmavAurdZobM2YsJQLc9GZgccjaNNJa2RikvZnQw1i0/Nh6L50gstC2D
         1O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377864; x=1784982664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgIa2nvlAYASx0A3Vy396EFcyG+Ae8Xu0EszFJ8wQ0M=;
        b=GAIB3t+3x89RapUJSLTAhMmTVryG21B8809at/M5VcVbSvBw0YXU7SaP0h4UoPH/yW
         LLEB8bbWu2qv5BA9KFuG1lfGADdwiGJKbs5bDD+1Ty7PTUIN0vzy5FbDarqJLmfT7aIm
         NeyjJkCDyfX9Jhe/Us817IwydU2t0AYpkE9j7P8Jb1VgsFjdjrcoDPwZkPBYda22q3Ag
         do+huqg+7LhZff4Yvk/pEzqIIV+3Ton/OnLaiJ1CUzsjwoEvnrz0W7dbY0uUF6TcXScm
         +pNx0ibS1e0CDybYWPytr290dNQQ7xND/B68u9KlHFVwZWXlOQhTkFkEV1dDO360aV8u
         CmvA==
X-Gm-Message-State: AOJu0YxOGqvwxTNO9ATDyzVLojl0BK933AE3X4uLYI7WEvG4nMDetL5y
	rnX+NWn/oGFECp79bsEaDJsvDYBQXlEXauWiNqvKavf/5hSkppwlzXbQaQC8yZeu7hRuhFW/MgS
	f8b+ewxukftrJ5eUBQjQsr6aUX/+L3cZcY301
X-Gm-Gg: AfdE7ckbsLmg4UVsaIS73sinVFtoyHXuxyaGdu16C/+JqTyLjvYdeJ/1XM2aoj0UXTy
	MzXJYBjLTI1Ijub6h8PYi/ZJoMFjZb2o6+Tu8VLccgV+/uYMstR3s5+Gocrk1Ndro5o+Xzeq/8o
	lMdxmOwrG3brsFCwKbRVbcq5Hig6tJhPyVcPnPy5/oDfgVMuze4FqjvmWpETqj0t1omW/43nu65
	PXVMlR+yqfniKK9lcR9phZp+3iezgS7YtVSi97xbv+JIuUhMLv3wE00vELjGHN0TB8XjUaSyJCD
	N8Hi4g75pRcxeg5d8ie4xl6QixBgXA7IwRE/k7MQ62R2DYs=
X-Received: by 2002:a17:90b:3942:b0:387:e0bb:57ff with SMTP id
 98e67ed59e1d1-38e4b5d99a6mr6926716a91.38.1784377864036; Sat, 18 Jul 2026
 05:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com> <20260716132848.95982-2-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260716132848.95982-2-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 18 Jul 2026 14:30:52 +0200
X-Gm-Features: AUfX_mxXIMKaNPbPvLMNcMe0D984olxjVOPB_9Bx-XLlW46RaIZ-lCknhJOez3o
Message-ID: <CAP8UFD2ZNmWh4fjh+vFvKCihfebg2yif9=xLjqpKZFgF-O0RSg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] builtin/repack.c: add --drop-filtered and
 --dry-run options
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	me@ttaylorr.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:29=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
>
> Add two new command-line options to 'git-repack':
>
>   --drop-filtered: intended to eventually delete objects that match
>                    the filter specification. Requires --filter and -a,
>                    and is incompatible with --filter-to.
>   --dry-run: show which objects would be dropped without making any
>              changes. Only meaningful with --drop-filtered.

An alternative would be `--drop-filtered[=3Ddry-run]`, which might be
extended with other `--drop-filtered` specific options later.

I think separating `--dry-run` from `--drop-filtered` like this patch
does makes sense though if we think that `--dry-run` could be useful
later without `--drop-filtered`. The fact that a number of other
commands already have a `--dry-run` option might be a good sign.

Anyway it would be nice if the commit message explained a bit the
choice to have a separate `--dry-run` option.
