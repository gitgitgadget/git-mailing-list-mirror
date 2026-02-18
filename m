Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6311F91D6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410468; cv=pass; b=MW+fpa21RIjHGjzYgR+Gz0VG0fn5Qz5fghEcUKuFQHTgPpil+DtDaZ1oG3ZjoJKWN46hFfLahuesVY/Gx92ZH9M27aIPzvyl2dG17AQEqp/yfeS6nNZLpF9CWB3dr0KdNEoFYBrrcLhcMxXNehA1E2y7d5spJIkC9qy1Sk5Qp8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410468; c=relaxed/simple;
	bh=5tUV6Kr5L1uJ/rxuVKeXOweQbWzGu0LLlYc49SBYyQ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja49oQcfDtwHFtnWSiL31IEbmfz5FbcZDvC8DF4reG8OY+/yZafof7TKNsfTaPLiQQSYxg2s7xFkVv0iu26HFqD+c4hwSSgYEmf5wotcruKaTCr3c7TQiKpDIlKr+CSqo81gQsxWtbBaqH5R9BA91rnRFGuNkXarMO0Irw+5iIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRD9oALz; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRD9oALz"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-948a378b9deso1103321241.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 02:27:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771410466; cv=none;
        d=google.com; s=arc-20240605;
        b=SEYkvkp4iZStzefGrVEZkDwJmVt7fE4YUvoQSMkcnzfQ8w9zo13Gxc/0iJHWI59ew7
         gNAVHZWc3gqTa0KWM2TN1qYX5OsuOYEg6Pp2UYY0q66vZzDknSRn7bZnJCfzdfiY9E18
         f8JY8FDE05zRv97/oHgeO/52mtXIj5qmhfkMTQ7GRW2lGfOuTH2IfCUtgY7iOb+ZptcC
         E92aj02rHq7gedl0sYTSjPUjMeGLFJZW+Lpzsomn16uazza+oMVGsYDCj+3PBA2R9O4/
         BB8QJ8jCl+PblIUdDcA2xMoFQ/ucPwLogIRfhieLJCXfv3FWSVm+OMVzr282a+bJkQGu
         obAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9PE4qShQtiTK33Kj0d1OwT63HJEWTsLp+CHaIr2ENeM=;
        fh=wiMDZIgwBeisiUVkX+mX7dSQYenVFK0DX3VVQzENGKo=;
        b=hjJ5QtmkbG/f6H+hzlLIfTCOmrn0o+rST2R+REd2/IaLMs3rZjAqCy+igFXzWmPlkm
         5PJZJGuchb/GoHMqg3wRqMOTPJMx2hTnEiWOeA7zPepfqafpBFzj+7UjQOB62OxoiTxM
         CCLdu948rhsSVbW/8zOn+g2+AnoAWd4SYiKYXbFPQZKkSvW+vpgYN7srXhyj4D0vcL1t
         CDNlln2INvacqhY90pgW5CRv9UF32oepeBESLjdhRzPCggFt76UKdBWmKCXefDGb+pYq
         z/R0XCaKay4BzrBfhN1o1W8HYtoUIeC4okMb+u6TgLGhuLmstTul2xjML+XsyeEVgSpi
         9ZOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771410466; x=1772015266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PE4qShQtiTK33Kj0d1OwT63HJEWTsLp+CHaIr2ENeM=;
        b=dRD9oALzvXjhFZlqT/U8rgcW7i6b7Jv1LO7bk5Se+GcfbrNAwgLN+sEcjRWrnP635J
         0NrCsNRw/72kG7CibVISl4HGDhjS07tuiPtw+uuJua9S8DA2BiGxd7M8PrAos/lBovSh
         xGaZE1Jv3xs2RdRbjp506XAGtrgghQbbMg0Pxa6PiHA9eRX/ZHU/M+I97eePFSzA0b8q
         XpqwfoyMv2VLXmDSgAEV6E2CAJgKy97maTK272jpiLEetBi9Aok6/wEocKbK/SEb7M7p
         CR1sXg2OrwxrHIEsIJrDIHsCr8bKGEQ3gAznrkS3IhTMvYPMKwJQnDbxFVlJNHmm54Vx
         BuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771410466; x=1772015266;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PE4qShQtiTK33Kj0d1OwT63HJEWTsLp+CHaIr2ENeM=;
        b=XfinXA2HjAokzhPdJYOddaNw4GhQXz66A7fk/vU6NEGvDgqxdggn+F7GHfLasnietK
         Q1goiwzpdy7t18eR5p77MDrQS9jpTUqX3ilGmimPoPmWFSRq7ZeCPodVj6wsEwWXdpjb
         a0CWu/wR+Kb3/QQdu23Heo43Kk0SoOK8uAPrHKYfTHg3arvalbgCmMm6dqx8xww/W1YK
         lZNPkNIxzAyKdYNMAz7hxCi3aexqcxZ1OV5JOf/Qv7QcwN4vkU4gqz4nNrg3tH+bO0KU
         Di+5m97nCn5/su68SUFC/lBUax8uf79NPb5n/jtFKLrdO6GPmQGT1OpR4EsRiHobjQSP
         flNw==
X-Forwarded-Encrypted: i=1; AJvYcCURP9anvtPHHwpWfIu8Cy+ir67MvfOOtFnSyor0pVSArefk9u/DAgw8xIK1HQs59ONN+uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21pKXIxdwdAUoJhURQYSAfQFOQXHQaly5C9imvwIiErn39OrS
	RJ5hf3XhnhDdcGSqQpiThC4g85MAOZ5MRSHGlacEB429Gq0xmqhoQaekQW6YaSwG6yNodUL6n4a
	m1mBuxpiqgoP1EWWrDMZWAd/ymlfJVjctWA==
X-Gm-Gg: AZuq6aINUHSZzMZG/B7URWSt0W4fhKy3f5zMNIo0dPfKEAhgcHYDF1toInpJhD0v/OM
	6dfBO0WkF6SIj66VBUDN0AaFqfV+o2zHNGBIMxBZjbXrfRG6YEXtKdbW1/V3owAZ07v3jF33meV
	/7/kwxXag8IlKfz5mDaJO+t//yIhUtwVeF/FRKLzLBRu52OCHe1e8GuUX33jvKM3jqHx7uo/xle
	O/ewdk9ZylfDAC3WVfj2CxGzbDBb0L+Pi2T6mwvc31ct/+SbtoKPzkallXvhNpb58mpff/a6M6X
	JCfqOg==
X-Received: by 2002:a05:6102:358d:b0:5db:dd12:3d16 with SMTP id
 ada2fe7eead31-5fe2acee575mr4307325137.6.1771410465656; Wed, 18 Feb 2026
 02:27:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Feb 2026 04:27:44 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Feb 2026 04:27:44 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260218051850.164972-3-a3205153416@gmail.com>
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com> <20260218051850.164972-3-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Feb 2026 04:27:44 -0600
X-Gm-Features: AaiRm53wEHPU4eKU5Ik8Kb2s_Sqg1uUJGzW1BFFwwbpRMzQpV_vW1i-MOOuuX5w
Message-ID: <CAOLa=ZSAjDbC5bM+XvNwXW_WLWDiPfzAgaB+gHR6+DwhMW3uEw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] setup: allow cwd/.git to be a symlink to a directory
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000008eb0d2064b16a362"

--0000000000008eb0d2064b16a362
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> Strictly enforcing 'lstat()' prevents valid '.git' symlinks.
>
> Switch 'setup_git_directory_gently_1()' to use 'stat()' to allow
> filesystem resolution.

But we don't really do this no? We were calling `read_gitfile_gently()`
before and continue to do so, so there was no change regards to calling
`stat()` here. Or am I missing something?

>
> Calling the refactored 'read_gitfile_error_die()' to ensure safety:
>
> 1. Happy cases ('ENOENT', 'IS_A_DIR') are ignored automatically;
> 2. Invalid types (like FIFOs and sockets) trigger 'die()' via
>    'NOT_A_FILE'.
>
> Add 't/t0009-git-dir-validation.sh' to verify symlink support and FIFO
> rejection, and register it in 't/meson.build'.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c                       | 18 ++++-----
>  t/meson.build                 |  1 +
>  t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 10 deletions(-)
>  create mode 100755 t/t0009-git-dir-validation.sh
>
> diff --git a/setup.c b/setup.c
> index 0ca129623e..6e6068e5eb 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1590,17 +1590,15 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
>  						NULL : &error_code);
>  		if (!gitdirenv) {
> -			if (die_on_error ||
> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {

Earlier if die_on_error was false and we got any other error, let's say
READ_GITFILE_ERR_INVALID_FORMAT. Then we'd return
GIT_DIR_INVALID_GITFILE from here.

> -				/* NEEDSWORK: fail if .git is not file nor dir */
> -				if (is_git_directory(dir->buf)) {
> -					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> -					gitdir_path = xstrdup(dir->buf);
> -				}
> -			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
> -				return GIT_DIR_INVALID_GITFILE;
> -		} else
> +			if (error_code)
> +				read_gitfile_error_die(error_code, dir->buf, NULL);
> +			if (is_git_directory(dir->buf)) {
> +				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> +				gitdir_path = xstrdup(dir->buf);
> +			}

But now we'd die. Correct? Doesn't that change the expected flow?

> +		} else {
>  			gitfile = xstrdup(dir->buf);
> +		}
>  		/*
>  		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
>  		 * to check that directory for a repository.

[snip]

--0000000000008eb0d2064b16a362
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c665ceba3a5b2657_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVmxCNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEFJQy85WGJ3eUFPSEVnb1ZzaStqclNUSFUwc01YOAptUWN2MGhXMG10
VUxXN1ppNWVDQ1M4Q3pGRG5aV1VRYkkwUUh5NytZY3lnRC9tNWhScjdtVkF2bzhZNk90bHN1CnBl
S3FSRlVvYW9DR2Yza2IyczZPVDE1eHJOcVJKK0ltdUI1dzVLR2dCb2p6M0sxMU9iQW90YytDOXRl
NENUQlcKRkdmbXZuYktXczQxbUdLVlBtdzBBTm5mVUZMdDA1bCtOUkJ2Mi8rRTErVFVSLzFZbllv
MlRNWUJ3RnFRMWJEegozbVlLbmxBbFBNRlEyTzZIN0lTZ3FDTTVPTjdDdHN2Uk16dlVGaFNFVklk
ZysxL3JHQ2ViWncrS0xSTkZZaStmCkhXd1FtVVlwYmtXQ3kycFFZQSsvVTVlZ0VnUWZTRi9WOVFj
QkZQYWpOVGNSZVJWTzRjc3dyR2FZSEUzWmhIWHIKL01ZVmV6QUNWN015bHJaTWM2VjJaTVFKWG5N
MUZaQTd5aHhrK1I5Q0tCRFZ1cEZYVjIwd2JFaEtsTGtHZ0F0TApOWmRlQnU4cXd4cmV6TGxjRDBv
MERobHR3RzNwd1A5Yys1VnZvMlVKSURGQ25jKzNiaStKK0xhdW1ZU2RnQlFpCkRSdEdlV0w2SHJh
R2dIdks3bkZZRWRmTmFhd25MRkUrYjdscUlDVT0KPXhhbEQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008eb0d2064b16a362--
