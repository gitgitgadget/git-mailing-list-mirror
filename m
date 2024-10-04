Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCC52F76
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020620; cv=none; b=jn/WNfRneHpr7na0RKkJuhIGUIWagfw2k0YaICRtG1NRj/Is1fz0nFaj8aAysNf2MXKyRD9xTKBdBJGYSaYAMX1+7kMifz5Eiktk4cBI2cMtUfv1R3TBwFPK6kMo2/KbR0EHauTG01rHmLf5tJjYQAUxUKpjZic59Hc8ECDgTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020620; c=relaxed/simple;
	bh=6ISv/xeGVmeowVD4c+NzqkQ1OHBplwWngx8Mw96+VOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvUya2tfJK5jrngJ9decubCkBGn8Xyhy92co5qVfB5b4f58SA3kEuMLvnX1KzHI96LAy0szB4betSvS3vWbvCa8K4dxWjoidJ6F/Dkc5+QZIXwoXJTU4ftWOCDRPq0DJkD9kshqBdjKMC2EpXN3Dd9XmC6z9omPiqoeQjQmAA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb22ac1a11so2205556d6.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 22:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728020617; x=1728625417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m41uCW+HU7qM/oqiEpW4vKPf5IQukip5wbUNpc8PasQ=;
        b=iZgZhRQx+tjbfiHWDHATy/X3NeLrkfFVUcH0CqkQf0MEqbzqtzDOLmQa41WrVnVVO4
         6aCfjr2EyuRWyTArzLYU4THvYMtkURZWR8gZKZXLDofB4WGG3gwZFJxOyZddHdf5HnkP
         s3IQnkwLhjHI6X0oqEiw2dq4TG+bJjcn1HKaCVGi4+7EZo+VM29rSnC70MKR6fIjbuaR
         uHd4dgU6Ivk+g5YO5ClRnHg+cI2+c9DXxP4BXcbeRU6BO+xwRpE0A1zIF+cDO3IXcttZ
         UlTckNmyaSGVO8L5Tpr+MMndp3xA2+DFJxdt9WZqwk/1eJTj2RUOYz9mIocjikBNIM7X
         9jFw==
X-Gm-Message-State: AOJu0YwJJjShYtAXeO+4+I9eUjc3LIw6SQQbu9UZTpdbcxQE6MbTHRdj
	J9hE4UjQr52hgrJwXM16E3F1wkVy5fGzZ4/B86QwswUD6sqzi1qimWSOlgSEVySctiSblgKMPOr
	bDiQepK5JvoDplrIWpxGjL90h664EzQ==
X-Google-Smtp-Source: AGHT+IFlKTLcDG85D8ziyDvawDPKwiDgq5U5J+2kVMnytFgXb2B3cTQfuTUmokZmDEXbMxEUCG5+akW9449AvBk1GN4=
X-Received: by 2002:a05:6214:f0b:b0:6c3:6da8:8cb1 with SMTP id
 6a1803df08f44-6cb9a30a398mr13613186d6.5.1728020616586; Thu, 03 Oct 2024
 22:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726489647.git.ps@pks.im> <cover.1727866394.git.ps@pks.im>
 <bdfddbebce9f77959fd9544cd5ba3496d5b9dccf.1727866394.git.ps@pks.im>
 <CAPig+cT7nni11bGmNyYCQZ0P0QZ_HG-izPtsymq==sUOkOn-Lw@mail.gmail.com> <Zv92BRolDugwLuOn@pks.im>
In-Reply-To: <Zv92BRolDugwLuOn@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 4 Oct 2024 01:43:25 -0400
Message-ID: <CAPig+cQA=1nXyinWk736BjvMBYYYKXd6JsRDOf8P2=u7TYvF6A@mail.gmail.com>
Subject: Re: [PATCH v5 05/25] reftable/basics: handle allocation failures in `parse_names()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:59=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Wed, Oct 02, 2024 at 06:07:14PM -0400, Eric Sunshine wrote:
> > Am I reading this correctly? Presumably, `names_len` can be non-zero
> > here, right? And we now check for names=3D=3DNULL to detect an allocati=
on
> > failure...
> > ... and then we potentially index into names[] because `names_len` is
> > non-zero, thus crash because `names` is NULL.
>
> Good catch! I think we should queue something like the below on top of
> what we already have in `next` now.
>
> -- >8 --
>
> Subject: [PATCH] reftable/basics: fix segfault when growing `names` array=
 fails
>
> When growing the `names` array fails we would end up with a `NULL`
> pointer. This causes two problems:
>
>   - We would run into a segfault because we try to free names that we
>     have assigned to the array already.
>
>   - We lose track of the old array and cannot free its contents.
>
> Fix this issue by using a temporary variable. Like this we do not
> clobber the old array that we tried to reallocate, which will remain
> valid when a call to realloc(3P) fails.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/basics.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/reftable/basics.c b/reftable/basics.c
> @@ -152,9 +152,11 @@ char **parse_names(char *buf, int size)
> -                       REFTABLE_ALLOC_GROW(names, names_len + 1, names_c=
ap);
> -                       if (!names)
> -                               goto err;
> +                       char **names_grown =3D names;
> +                       REFTABLE_ALLOC_GROW(names_grown, names_len + 1, n=
ames_cap);
> +                       if (!names_grown)
> +                               goto err;
> +                       names =3D names_grown;

Seems sensible; it covers both problems described by the commit message.
