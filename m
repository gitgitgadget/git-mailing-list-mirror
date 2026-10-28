Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793226304;
	b=4h+2uA/W6Gs4/Bu38Fm452G9YwfwrvWbAqd9tQ6HpS6mdpahbp05jFfoiSxXvGWeweMo
	 Li2QkGpvFt3+/Sw2TtO7apU7qOdhtJ9tUPPng88KgSykbTljuYJYyTl2Nf7Ydv/92qnZC
	 wm1I/ho5kgP08n0zYuYDu4dMAGM8QWrcTxb9aEHZmIF6AnzoXMxJ1I69b7e4ux90uMjuK
	 zww9otpxx4k3GWMfDIvGGwXNNi+M4KBG5lZoHOTdGsF5A0xdvcVpHOcZsa8E4577e6luz
	 Ev9ewxfOJVm5D0FXua4U7gfEAvC/NTR+TnU9lDxd/4mxkTLuJLHicmseku0rQzkwrRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7uxc2T0TlvVMtM+z3NhNfugDPhZRH7Gm4PAr/PAh7XA=;
	b=LfxEBFUzgqJf5+5YUrn4QQL6ek9T4wbyGcBkv5AzIhIux0HrPFWx7ROk/aerhGRQbm6w
	 pqHeClzz2I/n/ck2YWR36QZYGHXMN4p92J160y0OKi+MgsuJU7lk91fDxZ+/dryutnzyO
	 o8M3TUcHBuwaPHU+DVRK3FNWdgfp0LvmSyU12puYnJigPOzM2wfIAIoA4eZMh5pxrB+Mj
	 O6SdfIPRxO3rnWG49BO5D1F3MEfosDoNCLG4FB1WpcAjQ/OMlhXewusQdbWOCdvjv+9lj
	 NDwyOuO5MYmJPlEzatj8GJbCmu+/liRCLok3h1H/Ynj4cblmc9KXWt0fQrzx3fYCFvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mkOZJ/0O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B826606A329
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 22:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B826606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkOZJ/0O
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1127009b3a.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793226303; cv=none;
        d=google.com; s=arc-20260327;
        b=j109U+un3+girlLoje0yg7NvTb36FR9l8FbgLD2q+2y2tcAv1klFa7Y0mCRp9JtOLN
         A7u5PnG167ciYCnPijBHZ9nKNsMGcgYOoyyajn8oMgYkshi24g0eNNZnuU8zCoFI3W8y
         J3uoq+lz/w7QH5HJjvAmst7tF0AX9Imca4Pw9t2n9g1obKswIjgxEnCssOqPW+HNa4XO
         ov0DezFtcKTHSelVzJYhpFk3MLxuA9e3KInKs+PY2tAJR/Cap+UhGXNlYk0HFjSN4j4G
         Fxw5KWFk1bj4/axOihHLxgxfxzi3s4rU0QFvqjrWYUucXa63gzxyz7ZO9GaSxJG4DCki
         /qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7uxc2T0TlvVMtM+z3NhNfugDPhZRH7Gm4PAr/PAh7XA=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=S30dAxQ7Wnj/Ny00LrxwcachK/YUIyo36nxmHG+1Xf3/o9N5Ejf+TZZ+mN0C61c+R/
         qtOW4dYWlZ6pgHt9mG3LWvkAu5VmyHw92NLZvX/DmPlAfNuvQ30qPu63wnsnd2zicp4y
         ICYdnduTC0EM+NEnbGf+OIS4d3Rcz7Lxsh4iQyZDY4JuFIOHJUW/Htu0BA3Ml0iIjyBO
         3jUmfgmlw999wYiMSXGRRLE1jzdEs0kbwZgrPmC84FI+ycmgNNExs6IvrHyEvNbHIW4N
         JRE++rf3qgfOODy3n9xMn8NguqCDJKnWjSNnUPgOGWQH1EdU5CFQkbsSK6DFf4wgyx11
         V7ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793226303; x=1793831103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7uxc2T0TlvVMtM+z3NhNfugDPhZRH7Gm4PAr/PAh7XA=;
        b=mkOZJ/0Os613ks56qzRR503/8QgpasDZTfVubCA0hWDcCJe26oJIdbtaaL0ZNdyjeU
         tN+8VbXe/DD139yoLfFjKg1fBj+zOy9PRO/k4bq0tm9NyTkZOIMZa0FYb53tO3kjw8sO
         Hdd5AxEE0iHjO/h6aET1dYrKnGnKV6Of9cobmsVDeqaO/DwFXCzxRa9wXxcnTkq0z48e
         WYJLY35ZNTeRLVIUU++iOVGf08MAKSWrjffED4A7tCXSWcxqDwyBgwua/v72lq1kTTbE
         P0+ynd30FnqeWwwP8P5ljxfAKqf0Run93CogiXvqrRQm4wJeOazbUpySQl2draybEMXa
         jTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793226303; x=1793831103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7uxc2T0TlvVMtM+z3NhNfugDPhZRH7Gm4PAr/PAh7XA=;
        b=t8SmLDWipUR2Z3dboukRx/yziSNjZUYfOl1QZIpeQrWkSn4u/gjC9UzD0odZzR2EN9
         SImC1rhfMsIUDGvLjUutURZFDZjqXkbS1oF0d/udOKBkrOEzQx+Ss487lc/s/dDZs8tv
         d3q8076H5OGZEPGzIKoVhmsj9m0H5Kexi9NYV+Iu/KDmxfdLngN21bTFxZcwHk/cncF5
         aBudbcPfvULpvymp234XbdqF+s9ILxBDUHPmwAjlwDox2FxwRm98WcW8xuZpULsiGycO
         i+NcJfr/zK8EQPqFxS62leaCNDBvDL9DON/0x2ad8YDE2OXPA1exQ/O/blBXKdrYeX/k
         UlIw==
X-Gm-Message-State: AFq9FYK3VyoKcR3FAaTKpQaCbSJr4p3wiNrLUKnV3bnC/2Pr8T5I6iQw
	rw2FfB/ijhVRRVKM7jLn18/MKrAXQtiDop7l6maRPwdDwbfKAzvHjpgtWI34aFmvsMHiULG6UZC
	V4PqgLM6iVCk8AGOoumi0CPxMTN2zuEU=
X-Gm-Gg: AYBFou1x2xN18esi35W2w9qSmuEC7to+cZIZBPtaB7q7uIhSECQfYCbIY3lGxHa3Lf+
	XwlgxKxvQFSjCAv4bPV+Mut9YVxTnEiD0XVHO4JsyxWhG62axXo3982Uaf6rgjlFs20J9eCp8LZ
	+QkHHRgcNqGyrUBHoZB4j80f2C0kVhYzRYU4wvSM3NyuLOoKH8fRdmNhy9PXeVTcfQs+jYIsFGS
	f+03QEbYya9H5FWwGIHYVAiCWNCkLI2VEaHGj2tkW+zeOLaxptEu40I3AWKPJhVg5EH3DoVUVz1
	c6/GCz2OYn6YUqKuO6Zrg94GAoc3W66EXuDj1+HyztxvY1KRA/dQhxKDjbCcyBywORPwGQNWygf
	p5z5eV47xJe5ju6RZfR+U3vO4OwMZz9ust4XNXC3RhCcz4CB5UPKii0h3/co0OkH1APZo0AGUif
	e1LP8EGfP666ZM5BVjTQptSUL3PinCs6T1ysY+QtWjulW3DTV1bzKfjZfN6Idhv7JurPnjrhmTk
	cPMj9tuRdPPB50=
X-Received: by 2002:a05:6a00:ad3:b0:882:359f:ef17 with SMTP id
 d2e1a72fcca58-8a6e6346ce5mr3045810b3a.12.1793226303327; Wed, 28 Oct 2026
 15:25:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
In-Reply-To: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 28 Oct 2026 18:24:51 -0400
X-Gm-Features: AclHuK83Mgf3bHuTaQFuftPHXia41z7hU_go5C_JWOE_WgJ3FeE2NNIzziQZvrg
Message-ID: <CALnO6CBxMrv01NMqEPCLbGbCPXX9T2Jgjax-L5s2z9s-eUpNDQ@mail.gmail.com>
Subject: Re: [PATCH] remote: resolve "simple" @{push} when pushing to another remote
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 8:48=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> With push.default left at "simple", a branch whose upstream is on one
> remote and whose push remote is another gets pushed by "git push" to a
> branch of the same name on the push remote. But @{push} for that
> branch fails with "cannot resolve 'simple' push to a single
> destination".

At first I was a bit confused about the need for a different push
remote, but then I realized: simple's documentation says that if the
push and pull remote are the *same* you need the upstream to have the
same name! So in the differing case, it might behave quite differently
than I'm used to.

> "git push" learned to handle "simple" this way in ed2b18292b (push:
> change `simple` to accommodate triangular workflows, 2013-06-19). When
> @{push} was added in e291c75a95 (remote.c: add branch_get_push,
> 2015-05-21), its "simple" case only covered pushing back to the remote
> the branch is fetched from, where the upstream must have the same name.
>
> Make @{push} follow "git push". When the push remote is not the remote
> of the branch, resolve to the branch of the same name on the push
> remote, as "current" does.

Whatever else we do, making @{push} work in more scenarios seems good
to me so we can be consistent.

> The test added in 9bf9eed093 (remote: fix leak in branch_get_push_1()
> with invalid "simple" config, 2026-01-19) relied on a different push
> remote being invalid for "simple". Use an upstream with a different
> name on the same remote instead, so that it still exercises the error
> path.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     remote: resolve "simple" @{push} when pushing to another remote
>
>     With push.default=3Dsimple and remote.pushDefault pointing at a fork,=
 git
>     push pushes the branch to the fork, but @{push} fails with "cannot
>     resolve 'simple' push to a single destination".
>
>     So git status cannot compare the branch with where it was pushed. Mak=
e
>     @{push} resolve to where git push goes.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-246=
6%2FHaraldNordgren%2Fat-push-simple-triangular-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2466/H=
araldNordgren/at-push-simple-triangular-v1
> Pull-Request: https://github.com/git/git/pull/2466
>
>  remote.c                  |  4 ++++
>  t/for-each-ref-tests.sh   |  4 +++-
>  t/t1514-rev-parse-push.sh | 11 +++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 49ee2ea318..fd434a3a10 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2016,6 +2016,10 @@ static char *branch_get_push_1(struct repository *=
repo,
>                         const char *up;
>                         char *cur;
>
> +                       if (strcmp(remote->name,
> +                                  remotes_remote_for_branch(remote_state=
, branch, NULL)))
> +                               return tracking_for_push_dest(repo, remot=
e, branch->refname, err);

This certainly matches the logic described in the log message, and I
think it's probably right based on that description. One thing I can't
decide is whether it should come before or after the current set of
cases, and I'm undecided. On one hand, it's a new case, so I would
think it should come after. OTOH, it's a fairly straightforward case,
and I usually like discharging those early so I can focus on the
complex stuff.

So, I would say this is probably fine as-is?

[Skipping the tests for now]
