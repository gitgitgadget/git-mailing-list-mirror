Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494912D0625
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490618; cv=pass; b=ZE84Yi+ANm0v4jwumwQMlh/xH5/eCTjBaY4H4qfoodomQgGQviPlAc5BTIJU+AaVn4vXMwnXhrLEjxKbbpgVgNT/y2rBgWczC/hYX03Y6q4Y4X/jhHfNN+qfHFjKoGyvb5e7LJk/JsfnAzFBbE1pMGf/VI09pfauuUJycTB/rV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490618; c=relaxed/simple;
	bh=gj3W1Izy93UeQSk9wpb8E2Ta4UEUv5buJxzFoN7q52A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzC4NDl5H7j6amff53Idt2RP1TurTu9JIpDYC6SZp1YwcRdIZFqscFvpTtE945wDSa2h/enlMe5dSn0c81WZ+53pvkLHF32LfqWpH+otvqhyzmqT8R+d7x/HKhyRwTtR91jHxEgIEHutyfXgYf571KSuHuB/5OiNxHXO5wkNUsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQLvXzK6; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQLvXzK6"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59cfbfe64baso1555239e0c.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 05:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780490616; cv=none;
        d=google.com; s=arc-20240605;
        b=PRqkqkFw7EjdHaKbDieF+ouUmFYuOqm6qOtpRPnrasjNBAjyjdj3dJXbjm7nUeHt6V
         OkSKV5TIj/AhI96iBiATMVJeg1VZ6Xie8Hn2SImU6h12LmsF6XxmVFYDZkJjO+TbGybj
         y/igx2nn2smxIPq98p8k7OntcWOXdWWS41wp8FsNPj2FjeG0ZluWNRBcAsRUR/aJ5pqQ
         CvUbHuQdBQBHY3nAW9vML3Wd0vrOdLq+7WXpxxZS4e4ZCD47uu/MZrJWlMOwMNvxNgVz
         v8HdmCTWtD+u6czw/BItCHTRyf5EAivhWHOhyu5Hb9oIvT5kI62r6psEF5jUl7BqhTmY
         pHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xvtE+EM+o4N7Wnh+h3lEbCla0ubTmGmktI2dPaSrRTc=;
        fh=CZlHFEOrUGRxukjjtZ2tBy9vcLvUSCSdxs5HrxYxupI=;
        b=X5hvh7u9VhNxK7zHnCfsljXS8ZmZKSDV6ha4HmF8+vFq8v1/YzLZvfrKrbvAFbjQRb
         zJB9WN3CVg2Fh5JxHLMF1rquUPQ3f7T+T1IJB4/j8+VSJPIdV+tlG3weTU5L4IqG4R0k
         X1WUAz1xmvZZ1pREZ+3e09ThPHsZb2TuvepiuYwGEN4u1IAAJa8VZpMMW+PUGv4HppgI
         BRHI1jbBzTDSYNc163r53RP20x6c202I2u7a4TWUdTOhDkblo8dBR0OkxMPwfFROIGab
         dJbTFs4pT2AsB0GX7TDEyzy28hu9ycmboECVsdPvvja3TY1Qo+eN9vOoV7xeQfjhEV0O
         hbEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490616; x=1781095416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvtE+EM+o4N7Wnh+h3lEbCla0ubTmGmktI2dPaSrRTc=;
        b=pQLvXzK6KqZhUwXM778wxFMVUr7jQ5CcoyjHbK5/O8uN2sy0Ach6I3ngQ64npNvgs+
         QFiRWvoaPEqnVSLEOldUiC5qikh2jDSknAIgDTXp0rDdm0BszZsbheZvJX8qlonFesjp
         lEXkHdVt3PLEslEJFAC02DoJ5zc2qSTAWdJCeg4JbD6YrIA3N9FBQusLI+zA19r/9K6y
         oHkKtyV2Lf64oaMu/bnsUPP8woB/GTqPEC8LL6qI+BAMad0raYDwIQWw1lLLAaKMMwHv
         NrS7R8sd87Og/gXFLTF2aB+2SfODu/EVoXHbKeIx+ocP/ST+9IDa1M8TWmv0MaNTeEPR
         R4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490616; x=1781095416;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvtE+EM+o4N7Wnh+h3lEbCla0ubTmGmktI2dPaSrRTc=;
        b=ThJDIFd8Ir2S5xh9fyCJqNyeb8MevhTJry2/eeW785NdKwWncCIEgCM920S88Sf2Mn
         lxXYwXIXpxbE8opXkWNFMxWlbqWrJaspUyW+FuvWLqSzDbOF4O5K7F/TuNqFzlTPY/vm
         jWLitoyVKBt0y9u1pSsYFMPlS37gBPnq9TAOd5lPsh2+BElWG4/+YgzDEjFB1u7aui3W
         MY8+wl5S1RyywU6/Tdrp4oNwaDDRNtIixdiPtCwUJ3Q+pjj6jicu+W5LunLu7o/9A+QH
         XoVsVINe/FFmbcZf9GpRh2IJZEPZq7mUTxW24iqgmALifwslPqsRoS5jljxLoUC1WY/T
         AOyg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ak21pk8KcHdPseTkZZYHEsb/394K6igiA1TOm40lPxczsOnCS1GTudLR7DfU4WBltQfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9qXkju6mIPttpJbVHhyiKnZWJGnlFoolkq3kMlRQUoWxjLyD
	43oBjQUxYPg7Zw64HR/eO1CxCbgDyxjK5BOgiEnXM8KriiClYWaPN8dxmPD0tO/fUhTNCsKMIFM
	FNUIP6Dw6kB3tQ+9AxYEMNC7xV26EumY=
X-Gm-Gg: Acq92OH9814vltRIxsQQoKZm0arygnRVdU5ayoLHfvqQJpUhLnXfAvdiLIe/ap+A3FL
	8sgF+cHgRHcb29QPaZ+lLisP4BoyE8z9uUeHCvYAmcJrNfEvJvEeRAZyU5l2caGdnXOg8TYBU5A
	M09QaI3zWYxOprUlC2mDgpGO+oEWqMsVM7LpUNrGWVEcC2WL0oCJ6Y99nFaCacEKskmIKZz34CM
	YAEOMiqt5bl59TAdwWYruQYXmcFrSPEkh6xWkGoMg0wbFDVnT1WHiBmCTKjOX1/W7sKhsLvMPLk
	PsUeux+1yYHkcY32DDzIrulL6y5A1yuFSBLOG1sHudS86Fm4GZ2lu2mPkOHDaxC2LiSIrLmmcG2
	osZU7lzBk
X-Received: by 2002:a05:6122:3c4c:b0:5a0:1bcb:acd1 with SMTP id
 71dfb90a1353d-5a6e59ef2c9mr1488858e0c.5.1780490616162; Wed, 03 Jun 2026
 05:43:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:43:34 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:43:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-3-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-3-2fa5b385c13e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 05:43:34 -0700
X-Gm-Features: AVHnY4IEWha4y-pqoaKiULwEGd6JtPDERycxgW1nZIHWCKqCoxuPh4bQSSe4tL4
Message-ID: <CAOLa=ZSnDz1+C8y7ozFDdv68vqLFk-E+FsXhAnhwbm2D6a1Fng@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] setup: deduplicate logic to apply repository format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b3f613065358c67d"

--000000000000b3f613065358c67d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> After having discovered the repository format we then apply it to the
> repository so that it knows to use the proper repository extensions. The
> logic to apply the format is duplicated across three callsites, which
> makes it rather painfull to add new extensions.
>
> Introduce a new function `apply_repository_format()` that takes a repo
> and applies a given format to it and adapt all callsites to use it.
> While at it, rename `check_repository_format()` to clarify that it
> doesn't only _check_ the format, but that it also applies it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repository.c | 31 +++++++-------------
>  setup.c      | 93 ++++++++++++++++++++++++++++++++----------------------------
>  setup.h      |  9 ++++++
>  3 files changed, 70 insertions(+), 63 deletions(-)
>
> diff --git a/repository.c b/repository.c
> index db57b8308b..58a13f7c4f 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -262,8 +262,8 @@ void repo_set_worktree(struct repository *repo, const char *path)
>  	trace2_def_repo(repo);
>  }
>
> -static int read_and_verify_repository_format(struct repository_format *format,
> -					     const char *commondir)
> +static int read_repository_format_from_commondir(struct repository_format *format,
> +						 const char *commondir)

Nit: The commit explicitly calls out one rename, but this one wasn't.

>  {
>  	int ret = 0;
>  	struct strbuf sb = STRBUF_INIT;
> @@ -272,11 +272,6 @@ static int read_and_verify_repository_format(struct repository_format *format,
>  	read_repository_format(format, sb.buf);
>  	strbuf_reset(&sb);
>
> -	if (verify_repository_format(format, &sb) < 0) {
> -		warning("%s", sb.buf);
> -		ret = -1;
> -	}
> -

So we remove this, so that the callee would independently verify the
format I assume.

Edit: seems like we call verify_repository_format() within
apply_repository_format() and the latter is called by the callee.

>  	strbuf_release(&sb);
>  	return ret;
>  }
> @@ -290,6 +285,8 @@ int repo_init(struct repository *repo,
>  	      const char *worktree)
>  {
>  	struct repository_format format = REPOSITORY_FORMAT_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +
>  	memset(repo, 0, sizeof(*repo));
>
>  	initialize_repository(repo);
> @@ -297,21 +294,13 @@ int repo_init(struct repository *repo,
>  	if (repo_init_gitdir(repo, gitdir))
>  		goto error;
>
> -	if (read_and_verify_repository_format(&format, repo->commondir))
> +	if (read_repository_format_from_commondir(&format, repo->commondir))
>  		goto error;
>
> -	repo_set_hash_algo(repo, format.hash_algo);
> -	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
> -	repo_set_ref_storage_format(repo, format.ref_storage_format,
> -				    format.ref_storage_payload);
> -	repo->repository_format_worktree_config = format.worktree_config;
> -	repo->repository_format_relative_worktrees = format.relative_worktrees;
> -	repo->repository_format_precious_objects = format.precious_objects;
> -	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
> -
> -	/* take ownership of format.partial_clone */

I see that we now do an xstrdup for format.partial_clone, meaning we
have our own memory segment to care about. Do we have to worry about
format.partial_clone not being free'd?

> -	repo->repository_format_partial_clone = format.partial_clone;
> -	format.partial_clone = NULL;
> +	if (apply_repository_format(repo, &format, &err) < 0) {
> +		warning("%s", err.buf);
> +		goto error;
> +	}
>
>  	if (worktree)
>  		repo_set_worktree(repo, worktree);

[snip]

> diff --git a/setup.h b/setup.h
> index 9409326fe4..5ed92f53fa 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
>  int verify_repository_format(const struct repository_format *format,
>  			     struct strbuf *err);
>
> +/*
> + * Apply the given repository format to the repo. This initializes extensions
> + * and basic data structures required for normal operation. Returns 0 on
> + * success, a negative error code otherwise.
> + */

Nit: perhaps we should also mention that we verify the format?

> +int apply_repository_format(struct repository *repo,
> +			    const struct repository_format *format,
> +			    struct strbuf *err);
> +
>  const char *get_template_dir(const char *option_template);
>
>  #define INIT_DB_QUIET      (1 << 0)
>
> --
> 2.54.0.926.g75ba10bac6.dirty
p

--000000000000b3f613065358c67d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 51374a8f14fbb8dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ0lYUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXk4Qy85TnlGcXJ6ZkhkMGFBZnBuUlloYW5DZktEagpLdmpvR2IzejR6
ZjNXTVIyendxR0crdm1kRVNVYzFReGlkeHJGVmtoMFovY25PYUdYVFZMeWJxUkFXd3NPejZxCjdr
UmVlUzNCN3lhVXEreVpYZEVSSVZaSFpNZjVNYU9PeEIzVEMvNThHdTB4R09DTXh3OUhpSklBNXU5
WjZBY2YKQWZ0T1RxWC9XL3lkMG1wWjZSYlNLdGh2aERiMGF2MU5Oa1BZckY3Wkg0elRsYkNFQXBi
eVltd0ovY1BUblNnVQpzNExqZ2l5QU40OU5EOVo2Szl5bmJ6UWJTRHlBZWFwR2VNbUZHQ2ZESGRQ
M1ovMXRQOENIMHhMd3A4VFNkd2MrCnFuamtsdHRCRHpiTmRSVCt3ZlR0ejFLWk1mTnFOMFB3OUp0
aHNIcmxVbjN5RUVvcmRIVUJ0YTNxREM3cnhweDAKVE9MT3ZjTXZzYXFlR2VRdGhNdjQ2T1FMdFJ1
MXJlT2pMcnVFV2lPbk9TcWNZVkY3cTMvZ2ZkR1RWM3Aza0lqNwo5V3N4UFhCUDRKMkpqZUNrOFVB
MFVoeVAvQ2FNS3pwczl2MVR4NmRSbk9JTEF5S1JiWDZicDFBd0U2SUVMWHViClhLa2dlMVBqUlNh
SVpMWHVDcktFQnJSK1NzVjRzM1ZCSERMRnN6dz0KPVhUQ2sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b3f613065358c67d--
