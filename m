Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6652E11C7
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783456; cv=none; b=Om33wGNCMZp7GQVq3N00Ua8VMF2KnWHyyUrpwpsrefUqkFjPNDWCR66dIdKe9CmyC9DDE+Suaj9BF7loK9XKF5JeN3Uxdl/HjM9wloLuyMrqHb5Nps8CFZhNb8hrhTCzIdfYUb6E0yL2zLn1Va1o7u+G+OpzH4+IoDuzBGbYKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783456; c=relaxed/simple;
	bh=U5CHocMhvuS17uVjZEywGOwGt3KHUK3OyyQPlSDbVns=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bb5ulweANpifAZjVdu64tFt8eVwwVWgv4o5x7bPxAiphvUZodcx7gPAaObrY87eXgDidcKTWlNkSveWmautVbOk0O3GHRFHtPC/6MnhxOTq/pDKZm+LfJsIHjI+zhM8l4ZEaq9F/upb0F6A4yGEzJp3BeJ1XEFZnDt6+T65Rc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpGlWKJn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpGlWKJn"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso15148245e9.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783454; x=1784388254; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cx4sLRi3FtEselUwKxi8VVI/mX9XNVt22arZzeCQ2nc=;
        b=lpGlWKJnagpYzasZQ5YSmfSyLoKnETQutCl045C3jfVxkLTDOd5/p7E+AtoPBVePAJ
         pgTnm1mkehMghjlwPNLsFRH1+NWv0fJIGKYKNb3fjFfpTstuGwiudt5aTfmEXl2B74gm
         k6ac3hK0tQPGfViGclyP46oEBoTrUar6tWYRr5iBn57jId0ajNCGHjAU38W+FD8QQ2iV
         IlVJ58ezAbPH7qEotYSw1r1cGrgDE5gyWTdpZ1mJl5qg9N7fDfYEZUFV+nIpfQJmVHnX
         YJ4mAaraAGciF3QzLD9YRSzG5Wd9wf0//OAT8NhOD4Hduewv3UroWTDs0mpSubi3daf2
         aHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783454; x=1784388254;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cx4sLRi3FtEselUwKxi8VVI/mX9XNVt22arZzeCQ2nc=;
        b=mJUv5obOlAwVB1L8RQTSn1cWKWzqvTW4fBgVs8r3HmLYg0F/Gc6v02ml57HWOjDEqc
         Eppe2noItrKm37/t7tSBprg3RwqJmWSnJWVrpTQwjdAhEdOaMewkrbbw1CN7jLTOh9ge
         +QfJn08sx79X/wIoefk58lq1HnLA3/1FkUjQCJwPwZk6xXG7vYXGja5wIVdxGjoc9YkB
         GgJ9+I3JZngqPjlfvR7yZ5zpGvW/qJ7bLLpt3Ptn2bPpMCZbjC4RXPO3HiOt092mtHbJ
         LBV8HJds6yTaK2QyIZoOyxMSJrimRZpYIl0UMCWwmhSjQ+Pser5Kbb7p7cdqAX6TBGgc
         Tm5A==
X-Forwarded-Encrypted: i=1; AHgh+Rof6hAHL+au9Fo7xjVPLiTCaB5O9ijCU+u+Asr1f9W/k7EWqu1lGr7/q6UuZ7K/rMO4nVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFdaSyRIXnCgJLGF42DV6NJ89NJPD4sG7BbFNYKsxTpuDa0AQ
	cKRoCPqhLNozEG7mHZEglTmok5SLAngNiT9TxF7DDRodJZkrdlljK9hI
X-Gm-Gg: AfdE7ckPcxGQjadthIYDMoVDa/FqrA6YQSUoa1VNgjm6EKgzZ+uUuvN7B88qJhmqqjA
	9Tatf/u37MurlnMLvbSo5+lwgqobzRGFQ47pQu7JeneEPj2xpfd1xj3AalpQCPLFW7ri+Gn/Jdj
	lyC0C8SCNfsgjmL++NZUZyRM/ceGbzKnN+MoaDKL4aBfyHymNWeXjw+TT0BhToa5qnNFKPGsypJ
	PVZaoCvIiLq2r5X4xK8zrB/cwvbgILasykgxTb6EsiKVojrOnqlNIcu3gVtFWEXn/ceYf+ruZRN
	PEJURRToj9uPNl1IrZJI3V1nfTXW2vwzqJneb+H5Vji3AVVGalI1W39ggte97REQRIjGBUVufsF
	chUYKyGcRqkClp9CdnYKpb4ujdQqXu73QAO2NbRcUQ2EfssCkFn2gnlHcxXMV9oCvWxkND8B8Zs
	++BIo0SqOOH+qgu4SUFQO8G1n7x62+mgygSJq9hMS0MwB5TfduDEWxvgGHoXe0Onzvnl5J3DjaO
	/zd7n3ng5jnMhMYIbZU0DjAAFK/dqOdvEPAygZC0MhXpVGM26h3GQ207TZI/ezzqqDneEkBZmZ2
	F0rcsfcji1Ns5CHCuz/0HgemncFC3N95yoxNdfT04vkOcQ0DHrB6tZd9Brf/3687BhrufA==
X-Received: by 2002:a05:600c:4ece:b0:493:f0f5:f2d2 with SMTP id 5b1f17b1804b1-493f87dc3f3mr26538755e9.1.1783783453605;
        Sat, 11 Jul 2026 08:24:13 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm120001005e9.13.2026.07.11.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 17:24:12 +0200
Message-Id: <DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com>
Cc: <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>
Subject: Re: [PATCH v9 0/9] migrate more variables into repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
In-Reply-To: <20260709161145.13349-1-cat@malon.dev>

On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
> Hi everyone,
>
> This patch series continues the ongoing libification effort by migrating
> a batch of global configuration variables into struct repo_config_values.
>
> What does this series do:
>
> infrastructure & strings (commits 1-6):
> Introduce 'repo_config_values_clear()' to manage the lifecycle
> of heap-allocated configuration strings. This infrastructure is utilized
> to migrate string variables, including 'excludes_file', 'apply' whitespac=
e
> configs, and external programs including 'editor', 'pager', 'askpass'.
>
> enums (commits 7-9):
> Migrate enumerations 'push_default', 'autorebase', and
> 'object_creation_mode'. Care was taken to make these types available
> to the configuration structure without triggering circular header
> dependencies.
>
> RFC:
>
> Commit 3~5. Is it really necessary to migrate _program variables?
> https://lore.kernel.org/git/8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.co=
m/
>
> Commit 6~9. Previous related discussions on 'git_branch_track'.
> https://lore.kernel.org/git/CAD=3Df0L-mPX+KECUjXk-WBzEbTP7wCa8sB56GySQT0y=
h9mfUOWw@mail.gmail.com/
>
> Note:
>
> Since a new getter 'repo_excludes_file()' is introduced, as previously
> promised, once it is finally merged into 'master', there will be a patch =
to
> update and squash the comments.
>
> Similarly, I've noticed that the classification and sorting of variables =
in
> 'repo_config_values' don't seem to be correct. There will also be a patch
> to fix this, and I think it will form a commit series along with the comm=
ent
> patch?
>
> Change since v8:
>
> Fixed a memory leak in pager.c.
>
> Thanks!
>
> Tian Yuchen (9):
>   repository: introduce repo_config_values_clear()
>   environment: move excludes_file into repo_config_values
>   environment: move editor_program into repo_config_values
>   environment: move pager_program into repo_config_values
>   environment: move askpass_program into repo_config_values
>   environment: migrate apply_default_whitespace and
>     apply_default_ignorewhitespace
>   environment: move push_default into repo_config_values
>   environment: move autorebase into repo_config_values
>   environment: move object_creation_mode into repo_config_values
>
>  apply.c        | 20 +++++++-----
>  branch.c       |  2 +-
>  builtin/push.c |  8 ++---
>  dir.c          |  4 +--
>  editor.c       |  4 +--
>  environment.c  | 87 +++++++++++++++++++++++++++++++++++---------------
>  environment.h  | 75 +++++++++++++++++++++++++++----------------
>  object-file.c  |  2 +-
>  pager.c        | 26 +++++++++------
>  prompt.c       |  3 +-
>  remote.c       |  2 +-
>  repository.c   |  1 +
>  12 files changed, 152 insertions(+), 82 deletions(-)

Hi!

I missed a base-commit to easily apply this locally, could we
add one?

Thanks!
Pablo
