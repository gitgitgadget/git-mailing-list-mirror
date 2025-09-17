Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CC30147F
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094991; cv=none; b=lRfn5UHiyTFuq/ksCb9TDqpg6kRwJLhs+PQf8OcbABabRFnenSHhzd2Np69Je8k4PAyAcOsWBMIJBsJQfdxihmsYd7GuDGCp8udiC61Uu2FAjNPtfzPNpumod2Af6Bq5Kt+YfAPYd34QsW8N62QczFG83EIjHgodO39KZb+Hxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094991; c=relaxed/simple;
	bh=byyUqiOlSoDa1bqr0l4Vfx/mMDIgp+HaXqdZJZfJ3pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoenVITVWO2yF49CzVuUWjq1mbm3T/An6dRmxKzxyYsFBTufjRFWowyJxIC/S2w3qhPfSVlzhOF3iV+HlD3Ku++r0kEBtzgLgCs26VAVfq8Pc7sZS6JoGpNvnH8PmR1LAmME6mRSlcMh9D2fUUTD8s3jOdjld3j4v5HCZPv3clo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-745ade243edso3855536d6.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094988; x=1758699788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eX26KlWPZZMHFelSpx7rBQXlqswclImCDeptfmWDZc=;
        b=VF8TVKOGYSXsEuhXYS21IGxZgjnZ5o3Hs+llU7fjONX5XWz4Hz8JtQqwnjTo1TKg45
         huDZTJqdIJyH9A5jFWMGPs6cFrSuYlufU+LfP19JbqoYRv3BktfZoOzSfh/F0LWVis4c
         L8Cc0+dWJ6HTBDYe9Arbx5mSfq2K+h/hBMi/CUWmYTdQ5hQ1da6M2OHt/Sh5Wchv07Xf
         ju3gLPQ8THJuWCtkjb9c5qRZltTo06XUxJvWq2o+1qHokuNwY1UtmItpeEhmPWqLKb13
         1NOOGIWoOPyymqvV2HaOxUhVSxJHI9V00VgeGSZfCC+13+wDW+AajHH5XWwEJai2B/1H
         CnGg==
X-Gm-Message-State: AOJu0YxLhP2AsZmJPlD4x82Tg/cxbjNFw6MAzftoZFbmMOYReXPqcR9U
	PRGKaCeAhHycH6AnUUrIcQSP1ofAPzSHWOgItHa4lf1Kdnno6mpeYO9i9gpsmu9NrRfuEc1s/wq
	pWlKkD0VnrJiD77b9x7jBfY/ObtD1+gA=
X-Gm-Gg: ASbGncuqKRUBy/15WKg6Xx7izPuxBnlx9BhFzaJhsavvl5QsTb8/ZnH5F3+Ad4AbVY2
	URa68aV//JeAcGGrcsOjct9HhCnChkvD+iYkDa96qqLO1aUJZsL9UQCIPJ1hOuwUwRP463B9eht
	n824ZmUMOwWS2a5lePSLv8/ynZtrITfGoERFTK7c0TSjrqjvBxeFj0IU06zfxGsTp+OyoUaL+SD
	EZ1nhzfP1ztXas3FOrxI4lTkBOEG8Lw8qqrv19s
X-Google-Smtp-Source: AGHT+IG/nt0029jGBZ9m8U+K5hbbiVQP4BjoWgKqEAjfq+Fd0G7A/hf75rseA+f5ys6bKe/zdrJeHN40C1rDb+uB5Go=
X-Received: by 2002:a05:6214:d41:b0:78b:56d8:2aa1 with SMTP id
 6a1803df08f44-78ec9a16f65mr7425286d6.0.1758094988070; Wed, 17 Sep 2025
 00:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <5f77f1bd5d986dc1f8d123919af24dd219e323e8.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <5f77f1bd5d986dc1f8d123919af24dd219e323e8.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 03:42:56 -0400
X-Gm-Features: AS18NWBfUM46WSTEXZfQAoSCXx_NubR2VlQODpSlk3tkyE2nFDMRdAgmqthPHps
Message-ID: <CAPig+cQqKCbGpfp=ppmjKEOe+sDRu6BocDfenzqvQJHSMiKDHQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] cleanup: rename variables that collide with Rust
 primitive type names
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> cleanup: rename variables that collide with Rust primitive type names
>
> Use a regex to find and rename variables that collide with Rust
> primitive integer and float type names:
>
>     git grep -n -E -e '\<([ui](8|16|32|64|size)|(f(32|64)))\>'

This explains what the patch is doing but doesn't explain why we want
this change. Please update the commit message to describe the
problem/issue the patch is trying to address, and then (if necessary)
explain what the patch is doing.

> Matches were reviewed and renamed. The remaining matches don't count
> because:
> - Rust source files:
>   contrib/libgit-rs/src/config.rs
>   contrib/libgit-sys/src/lib.rs
>   t/t4018/rust-impl
>   t/t4018/rust-trait
> - Intentional references:
>   t/helper/test-parse-options.c (prints Rust int names)
>   t/t0040-parse-options.sh (tests the above)
>
> View with --color-words to highlight the variable renames.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> diff --git a/odb.c b/odb.c
> @@ -913,7 +913,7 @@ void *odb_read_object_peeled(struct object_database *=
odb,
>  {
> -       unsigned long isize;
> +       unsigned long isize_;

Nit: It's minor, but I can't say I'm a fan of this approach to
renaming variables. It would be better to come up with a name that is
more meaningful if possible rather than merely appending an
underscore. In this particular case, the original name, "isize",
already fails to convey much meaning, but appears to have been named
this way simply to avoid a collision with the existing function
argument named "size". So, you could just as easily rename "isize" to
"sz" or some such.

Same comment applies to the other renamed variables...

> -               OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integ=
er"),
> +               OPT_UNSIGNED(0, "u16", &u16_, "get a 16 bit unsigned inte=
ger"),

... though with some of them, such as this one, it is admittedly more
difficult to come up with a better name since the original name is
already meaningful.
