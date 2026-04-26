Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFFA9463
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777163491; cv=pass; b=ZgytUMqFJPXGLKJZfQnLu6AsRx3Iz9UftUVdeQDQeUdv7PNxhEuzXKsIJlSEdfkmTAZvtO9LNrqsThKEP52V13HwCnyybX/gXchGHcemJSoiGdZT4wFowAAuVevM/WSDxyYl8Eq96OMjpdnrR3nCykGhXEKeHFS69gNVMuABty8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777163491; c=relaxed/simple;
	bh=MiXpo3FjjtibNMrYqtVUVnV3S1X0jICzrfrN3VeNfu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VluXQOkYsSY5BGq3l+xgPpTVNY1izcnXo79HVVA1wKVCE/E5UyWW1tol+Q3LCvTkRMSxwJw7O1FFzpCbbTM9cT5M2jn8UxPyI2e3vmlCBl1gNByCbokaOL0Z1o1LJv9qbzAVTAfUGY/kypaFBG+Kb2IFl97xZz/fT4wUgSF0Oik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/sSq5Wb; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/sSq5Wb"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c637089ccso11361630c88.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777163490; cv=none;
        d=google.com; s=arc-20240605;
        b=hC9PezBAwKu1UM93LIs81Q11jhO2VZTWnXzYnaFaceLFIhHAaq7OI+y1vHgOruC4t/
         6AdOhsXYbDRZCWR4fNYw/q2hnf4w/+wV65bT2Al5wZYaS31wFsngZW2Dj8IDKuzjhayU
         DYu2g0CL75bWqXFRDzjZrPtxatvdQE/X0LzyXd9Kh5twBmF1YXAqjMrOPX6Sz0IrMGmr
         mKGDkRqn5N5BrqEev73IecJkFw/kd5zEwIkLDrbE+4XhY8HiqHGI4fQibtJGeyn5zeKo
         F7ur8WK5njr0ZACRyCTckHSo/grWRMDPw3n13IYSTbhtFN9rz9U4JEeM+P8hkbyM6/JA
         +TdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Ixf4g6T5bzfSNy1nRsWPmC/WRZN53CFS0QYCnJBzUI=;
        fh=qyiaoRet1mjgCCb49ByhAOLsBSgbW8QVyPM/CpqYfuA=;
        b=jxy6mtb3vFVHGNKCKKflgFLpOXj4vPygykkmWT7uvJn6hFB5YcWl8rMc0Irhrk90J7
         NN034mGPWYRR6Kc1QzicaBscd51X8F5mf/YqPDhl9YmdymH9udr5iWQ54LUhjpLffsrk
         FWSDH9PNc1UioFP2PZrn/EygaunZnTfHjC73L8Q8YEi69rJmunHGghdv1AJIecj5r24/
         9Lm4+qfoSDAo5nT4It1W6QTjT/Nj5/OEdMISSMkjlmCZYWhRvjuYImKrW4sLblHKVdYR
         faysEggs6ZUQSm/uxpqP+Zqug1qc/aItaRkppP1ITCT4tsr0Uj9m6WfVMGtZQscJwUh5
         mI+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777163490; x=1777768290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ixf4g6T5bzfSNy1nRsWPmC/WRZN53CFS0QYCnJBzUI=;
        b=G/sSq5WbPauiNPKl1zSBtY6WIZJOlY0pMKXn56XKtWVZba0/jEN9cYCzuavTZXavDN
         Du0+FhDHJGvMdskoOh0RVqkgu2BLx9XDXjbYUR3k3XEZtVg2eGyjata6oAgEISxGVJ2U
         i5aIg/brUwiTC6Mg/XQg3VzSwRkddVFIDoJNqpDvEwNrgGmUqfgS4cqMmnH1hBfinGUn
         uALflZ83lEi97mxx+DUPSncOvAnbSLZy1qTdrGOtnNGmm9rADYIlTmrFzJcMFdXiJaLe
         /fVVlZxMBZH4K3v+ryGQJGFlXR9Uxbri1m1XTdIxN6R3vqM0bpsS2zdEDaeFnCQSp111
         ehXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777163490; x=1777768290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Ixf4g6T5bzfSNy1nRsWPmC/WRZN53CFS0QYCnJBzUI=;
        b=ZtNGyJvChQ6k2EDFoiSGBXIwIu0M5gy71SKIezgD5DlodWOHthPUIDoRYhfRgrU+p4
         45i/p1yfFJ7ES6eOhsXs/zRhA/tgBursvOSR2Vu3dCAY1AmgsAIz9rRvyIOoSsneIDi0
         6DAp7FJxbZclJhGeOkoTwcAEVyVNaXyaBwwonhGdUQhk4A2ZmF4iICK7AnOAbpReMkmE
         LSAJ52bgWhSpWV+Lbqx4UQHNlxejOAF9JQ+CfSVmExri/Cuumh0y8Pjf3LDJiU3gqGc3
         IH9vv7aZe5njtKB6NAu9krXr5eYfqNtR0THrkAbyE5D3jCeaB9UL7S00IxZU/2M4HxcN
         EoSw==
X-Gm-Message-State: AOJu0Yw5tglooS9qvESlSBXG2fXh+YydK1MGRHJcCb86GdE5t7uVmmw0
	E/eMGtZfbhAhmNHavsiXn0aPhOV4uGNlr3x6eRjFQ3vFQrFUrkzqgCyXOEukLjxW2y7QtXdzo9V
	C6fCBHl6RIG/Uvjj+RwNpbgS3hM8Huf4=
X-Gm-Gg: AeBDievoDkklurenwR2WzLKxJUlLbM67NFJ2cUE+uK3HuLRgV5SkZdXWvNrX6BCqEP7
	wWhMbMvtHPqTO+VKOCwreJBu/pQ3LKnwPR3En/Z3hyh4hVJB7Bdoe15HuDXIXAzMt8zSxzbvD5Z
	Q/KuDKoyM+x5F6DxT+TfYlurecWv/ZVi5kVGvYHVhcg5ZbU4Dvvz2lQY0pqTtmNjQhuyvpweGM/
	nOLjlqNCMRgrP3WJQZGZOBN0iEnQFgxG9wFjI3AkeIjEothKyhVjKBOCbLW4QjuLPxDIYut9BtO
	+GncJ2mCifsHLlPC4/XUdtDknpmWUm/c1DBfQprBGJLcSuIR9/8=
X-Received: by 2002:a05:7022:4596:b0:11a:e426:911a with SMTP id
 a92af1059eb24-12c73f75eefmr21910459c88.15.1777163489719; Sat, 25 Apr 2026
 17:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com> <xmqqqzo27fnu.fsf@gitster.g>
In-Reply-To: <xmqqqzo27fnu.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Sun, 26 Apr 2026 01:31:17 +0100
X-Gm-Features: AQROBzCEe71WwVkM19FUL93nsgtWKFZEvP5qJEZbD_87EdvrGzzbYDGv8Ihmc_c
Message-ID: <CAD=f0L8-_3sDGGkCzF4WA0xmUtaY_qiz__3zq5AemLgwTsqvsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] environment: move core config globals into repo_config_values
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 at 01:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > Olamide Caleb Bello (8):
> >   environment: move "trust_ctime" into `struct repo_config_values`
> >   environment: move "check_stat" into `struct repo_config_values`
> >   environment: move `zlib_compression_level` into `struct
> >     repo_config_values`
> >   environment: move "pack_compression_level" into `struct
> >     repo_config_values`
> >   environment: move "precomposed_unicode" into `struct
> >     repo_config_values`
> >   env: move "core_sparse_checkout_cone" into `struct repo_config_values=
`
> >   env: move "sparse_expect_files_outside_of_patterns" into
> >     `repo_config_values`
> >   env: move "warn_on_object_refname_ambiguity" into `struct
> >     repo_config_values`
>
> Are there differences between the ones that start with "environment:"
> vs the ones with "env:"?
>
Hi Junio,

There isn=E2=80=99t any semantic difference intended between
the "environment:" and "env:" prefixes

I shortened some of them to stay within the recommended subject length,
but on a second thought I agree that consistency is more important here.

I=E2=80=99ll standardize them in the next revision.
Thanks.
> >
> >  builtin/cat-file.c        |  7 ++++---
> >  builtin/fast-import.c     |  8 +++++---
> >  builtin/index-pack.c      |  3 ++-
> >  builtin/mv.c              |  2 +-
> >  builtin/pack-objects.c    | 24 +++++++++++++----------
> >  builtin/sparse-checkout.c | 37 +++++++++++++++++++++---------------
> >  compat/precompose_utf8.c  | 20 +++++++++++++-------
> >  diff.c                    |  3 ++-
> >  dir.c                     |  3 ++-
> >  entry.c                   |  3 ++-
> >  environment.c             | 40 +++++++++++++++++++++------------------
> >  environment.h             | 19 ++++++++++---------
> >  http-push.c               |  3 ++-
> >  object-file.c             |  6 ++++--
> >  object-name.c             |  3 ++-
> >  revision.c                |  7 ++++---
> >  sparse-index.c            |  4 ++--
> >  statinfo.c                | 12 +++++++-----
> >  submodule.c               |  7 ++++---
> >  upload-pack.c             |  3 ++-
> >  20 files changed, 126 insertions(+), 88 deletions(-)
