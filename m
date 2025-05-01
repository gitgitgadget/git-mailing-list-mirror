Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982501A0728
	for <git@vger.kernel.org>; Thu,  1 May 2025 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746139440; cv=none; b=HbViNB0bNx+Cpv+NwaxTdBX34z2/6DLG5QmJ9H6SojFL6pdkelRNC7ptEDKD226JEzNw0nkuzkBTkJWvg2eWDtwlupcvCA+lIPlxEc9g24ekYJ5udihIz7ifjUy7D/OMkFOdIp1vEWZasnp23ErE9Glz/dHcwtBLyRV1+QKD8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746139440; c=relaxed/simple;
	bh=ZzM5kJwx+wZOtHRvj0wu1B8zrcRMMpTEk82TEVeQHKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5rU9M7aEgckXeSyHrpgD0iuGfdQ1meqzz0wFkOUDDOZI6phAaAtDhoiVuQZGD9rVrznvWaydY+eB0RL8kZMr7yQHvUdeA2E4Eee3ymWDcBbwYsiP/Wmkz4po7OhZk8vluinj1y4ymXTIxYsX4Vg4nyNL+BUojuL/8dDL8nFKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769a9055e6so752931cf.0
        for <git@vger.kernel.org>; Thu, 01 May 2025 15:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746139437; x=1746744237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoT/LmIzAlKyEY+mhaQPuG7yJUTuGJ0PQIC2Y43qkw0=;
        b=vaYTMA1AlzLx3exV+U4bc1ovRLMUUtEymFOxb5cMgUgEDVeN46ObsLwqCxT+aZHrCW
         EFTTbta88MO7ViJYyTCvyR/JXkAksnoblUFSe8P5Izw3Haumq5p7ffsWtTRrvWIhZJmk
         icP5JMypkxm2ArP3NdqOdFoFNefvrfHE9eHuBFPxUHcuHvD2um61KUVMT9gL6IWBQ8HC
         KB3VIhr0tGNJYDSYWiiXxndA3OuC1HXmj9gdhYJ+x4YMEm+YhGih5cKCIfD6RLQVE5Sf
         g1opwJY7P5sQ+3UbUD0gbEUMJ5Q5nLNE0Lb7d9kTmbSFbvEWpFFQasejcvJJT07dUbVX
         JpvQ==
X-Gm-Message-State: AOJu0Yw/EhtGkxXtU/kR2/+FlEWs0J0FnT6YRsvXvu0EqBIjrU7ZdoGC
	n4ff/0xa5R0kGriKcAgHnWsgnGLmhzP5QXXpLzx/b35U6lLizp9y6HWZw6FqnJgyAwEyiWE+fzF
	L4vY03Z3CIHdUEEDuSLHpyxtnekYHAQ==
X-Gm-Gg: ASbGncvcuTaVSJkjw6IbBMkD6Ndgl/ba1Aq7g1OM26RNU5DXUcjzhZstYJKPjNTjB8H
	r5gstdViWdrxYBAEYTqPjz62VVSq7vOuAN56BxN1wtPnrjN7W5BRrcbO+m4S3QH5e0f3ctbqd6F
	oEHXZfYxw8NPYHUh1QQU9mWHKZTZhMc+TsSpBWimj7nge5ZWsrAtvxBI0=
X-Google-Smtp-Source: AGHT+IErXa+yisSNLREalIWcMpWCFlpFeqU++SgxgpHR/hMtB3CYQr2CZGFSef+94bGwT+R1c+kH3GpuNvgnt2G4iTo=
X-Received: by 2002:a05:6214:2129:b0:6d8:e6be:50fc with SMTP id
 6a1803df08f44-6f5155e9fb7mr5972036d6.6.1746139437501; Thu, 01 May 2025
 15:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501213414.370514-1-gitster@pobox.com> <20250501213414.370514-2-gitster@pobox.com>
In-Reply-To: <20250501213414.370514-2-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 May 2025 18:43:46 -0400
X-Gm-Features: ATxdqUE7dAosskwIF-7qqxtIbf9VdsAJti1JHU4PITPtyPeyQV0Gm_rfIFjS9rs
Message-ID: <CAPig+cR-mbtwvUZBdhVCKsimVCETKdWHNG14hXDO77qMWMwVkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-verify-* doc: update mark-up of synopsis option descriptions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 5:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> To unify mark-up used in our documentation to a newer convention,
> started by 22293895 (doc: apply synopsis simplification on git-clone
> and git-init, 2024-09-24), update the documentation pages for 'git
> verify-commit', 'git verify-tag', and 'git verify-pack' to
>
>  * use [synopsis], not [verse] in the SYNOPSIS section
>  * enclose `--option=3D<value>` in backquotes
>  * do not describe non-option arguments in the OPTIONS section
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git-verify-commit.adoc b/Documentation/git-ver=
ify-commit.adoc
> @@ -7,26 +7,24 @@ git-verify-commit - Check the GPG signature of commits
> -Validates the GPG signature created by 'git commit -S'.
> +Validates the GPG signature created by `git commit -S`
> +on the commit objects given on the command line.

Taking note of the casing of GPG (all uppercase)...

> diff --git a/Documentation/git-verify-pack.adoc b/Documentation/git-verif=
y-pack.adoc
> @@ -8,43 +8,39 @@ git-verify-pack - Validate packed Git archive files
> -Reads given idx file for packed Git archive created with the
> -'git pack-objects' command and verifies the idx file and the
> -corresponding pack file.
> +Read each idx file for packed Git archive given on the command line,
> +and verify the idx file and the corresponding pack file.

Okay, rewrite seems reasonable. Do we want to backtick "idx" and "pack"?

>  OUTPUT FORMAT
>  -------------
> -When specifying the -v option the format used is:
> +When specifying the `-v` option the format used is:
>
> -       SHA-1 type size size-in-packfile offset-in-packfile
> +       object-name type size size-in-packfile offset-in-packfile

Do we not typically call this object-ID (OID) rather than object-name?

> diff --git a/Documentation/git-verify-tag.adoc b/Documentation/git-verify=
-tag.adoc
> @@ -7,26 +7,24 @@ git-verify-tag - Check the GPG signature of tags

...all uppercase GPG...

> -Validates the gpg signature created by 'git tag'.
> +Validates the gpg signature created by 'git tag' in the tag
> +objects listed on the command line.

...since this is being rewritten anyhow, it probably would make sense
to employ consistent casing of GPG.
