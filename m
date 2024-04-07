Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874BEDB
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454637; cv=none; b=ULF4c1JGvCmD/yGxcaZZ1yJuk053VuQgb49feIbSUb80x2dO7dX/J/YsV2fSzQYikVfKDriHSWX2aFvIZCZAtVE87j7ieK988/Ju+s2WJBjiI6LS5x++kD+UPbIENVKy5PdwECflJF44i3GWsbNVHAnmSZbAGcHNk3qB2od3o/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454637; c=relaxed/simple;
	bh=W41WD8Pu7QyhGSC0ftQ3kqY2t+OZ0VLJbJoJBezvhuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GINBzqTZ4KEqdFtrX9GE14YDdqlQyj1wkD56ob1AZZQiL5p9SZ3n6rDh3sxSGOz9+EwutnmMJz1ZKw86uq0rFQQKfztvMVZDCeKhe5NIi50I80SBYDfZG4Prv9Xw6gQ5ZOtXETh9ijvb/cVwgZgebIoCtO8qoxpl6WMrSCN89Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b166e4d5bso146086d6.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 18:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712454634; x=1713059434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mosD0M7RIzlXGHQDk6/34jP29Ja1rkQg/xTTn0/rsvk=;
        b=OuABQFGwUN+8q7qY8KUxOIvw7HhuZX9AVMh4fXhHhdBY3E2+8iw5nGq7woCuOEDVLj
         JAvCboAQ8urGDbDGhFd13uTYWm/U0uxp21eQBSscM4PHWhZ6T0C/Z0yzE4+jkgiKQQMT
         q4zDW0/nfbF8kl223WarVFrknY4p1eyuyxSBWlVWDmX+BeRXVm0tfB0aV4lbcBl9Bvq7
         JmizsiLjfNhBRS3oewa1jifuoITtwbqvLZDvHOObQGl34uRzNYOdiGFn9pzhM0NH2SMP
         G4B1VosYa2ZGav/8kkyH0u3sPOYbJD14ZXALUT0Ph1NXwYFFOJCswZe1gILrdfxaWy4Y
         bfrw==
X-Forwarded-Encrypted: i=1; AJvYcCWopqiStHAZLFYp+9h01iMnO6bHet8+k1tGNLutnx3XA3XSP316QZBd84npdn3qs2IY9Jp+PSFmRfsIoGUTfRKyprAX
X-Gm-Message-State: AOJu0Yx3hTOb4b4J+aqbzS5brdWUjSviKYlaE1HVaxi1jWiaR2rcZliH
	6jVwDsYi+3XazsUFnO1CZj7zSvJHg24YHHSV5bXYr+bRxBf8R8GtL6mzxqGeMwXUX4v2RNiTShl
	Ks41BSMtRe7nj/QSSzgyx6oCxHis=
X-Google-Smtp-Source: AGHT+IHTdBiJ6CIRDprlSjQskFh0iVeHi/OgbuASwsMj931Uq2Ny29h4HNsEv8/z8iP69u5iZYe4Umh80PITB8Dk4B4=
X-Received: by 2002:a05:6214:5007:b0:699:29e0:10b4 with SMTP id
 jo7-20020a056214500700b0069929e010b4mr10584537qvb.13.1712454634491; Sat, 06
 Apr 2024 18:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407005656.GA436890@coredump.intra.peff.net> <20240407010037.GC868358@coredump.intra.peff.net>
In-Reply-To: <20240407010037.GC868358@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Apr 2024 21:50:23 -0400
Message-ID: <CAPig+cRyya=hUYtdzoqgFLQq0eEnkgH1ayZTLBGtM2gRrc2yTw@mail.gmail.com>
Subject: Re: [PATCH 03/11] config: prefer git_config_string_dup() for temp variables
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:00=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> In some cases we may use git_config_string() or git_config_pathname() to
> read a value into a temporary variable, and then either hand off memory
> ownership of the new variable or free it. These are not potential leaks,
> since we know that there is no previous value we are overwriting.
>
> However, it's worth converting these to use git_config_string_dup() and
> git_config_pathname_dup(). It makes it easier to audit for leaky cases,
> and possibly we can get rid of the leak-prone functions in the future.
> Plus it lets the const-ness of our variables match their expected memory
> ownership, which avoids some casts when calling free().
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -282,11 +282,11 @@ static int format_config(struct strbuf *buf, const =
char *key_,
> -                       const char *v;
> -                       if (git_config_pathname(&v, key_, value_) < 0)
> +                       char *v =3D NULL;
> +                       if (git_config_pathname_dup(&v, key_, value_) < 0=
)
>                                 return -1;
>                         strbuf_addstr(buf, v);
> -                       free((char *)v);
> +                       free(v);

This revised code implies that git_config_pathname_dup() doesn't
assign allocated memory to `v` in the "failure" case, thus it is safe
to `return` immediately without calling free(v). However, the
documentation for git_config_pathname_dup() and cousins doesn't state
this explicitly, which means the caller needs to peek into the
implementation of git_config_pathname_dup() to verify that it is safe
to write code such as the above. Hence, should the documentation be
updated to explain that `v` won't be modified in the "failure" case?
