Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F0182
	for <git@vger.kernel.org>; Sat,  3 May 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746253494; cv=none; b=rTJq13h4mOlKVOdme/xh3Q5odpmOcqKT+BXFGXztcHKUuwurO0u649nh3r0b9do7I42LntE1Q8aY++t2onD4YM3HcE9hx13Kco31T6RkJIBxcMGgX0XAX/VwO7h75PbzXAkcKSYJibsvHDRK1sXPvWomL9FK2UTTXgXj5b4PFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746253494; c=relaxed/simple;
	bh=2iPX5UajUmf8ZHvf1oy//8Mbjmf2qXyLZoc6CTTrZBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igaYT9dfnevNSYtrkRVt3WYdxFxVXBQwd6mIPCjIqdWwRM3fdPpWzQkqjpDGeiHq1sbyo8k9fepY0kAFj8pbg17i3CBl+24Ec9lODG5nwnC4bMhss1lGF1XXRY59tesRW64z+v4WtIsfEKaEJ0c73kykwm1fWd8jYDFWvXY1HYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0v9an2p; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0v9an2p"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476b4c9faa2so42136311cf.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746253492; x=1746858292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsvgkzZjVw8YQqRhdNkVI5hjqIB9/vX1I/s4JYNgMAg=;
        b=K0v9an2pQBulu2YF9t1N1XNn5S3WHlrsKpEpixopTk1T9Q4KVfMtzj86UubDAulbfQ
         bD4O7gPEWn4OLZxMo3ubSzvaiB6NL3s/sP9Wph9u73EhzOZjiBCzA3SizgrvhQY5sBBj
         1pcYhYAyF6BPhjPxwSMD6dyok8034tP5TfGwfsoN3ThiyCoAq0XeRyosb0dGXNihXE+h
         Z2+VPmy+VtjM8MPexkCAF1J3xyDk7f1bfouMYMMc8tvc9/y8su5OFufDo8LbaDzKaQf/
         34EUn/sV5x+Qu3x22INcvnANTB1rqAy8Cb8csSRvvmjX9VAZJ/8iO0jdYMiUYnJq4uP5
         qKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746253492; x=1746858292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsvgkzZjVw8YQqRhdNkVI5hjqIB9/vX1I/s4JYNgMAg=;
        b=a0ZxGIhNDn35/1i/VSYRt9nlI5JnHvTffCr18LPuJsYpOaqSvaNiB6wUGH7kF+Au3D
         KB6wm5qtTyBtsmvGHrNCHuEpJRaEknjd2eC5w0zbzm/q5jAi2HXEjD+Hdz6cnmkBjZ+o
         zRLXvhAll6hyUi2XdKT+6tz+v4BeEf2x1HgWu7UlOcpN1jLMgdo3jhxPEUig5MkWOL4p
         S8Sjqe15jomqUg3NsC0uerBnGeNtJ5yV59EJ9f/98kvZyndrwmUoAlUPaVNCAKIhRP+M
         Evk1mQsgwgKND+pmOrkpYFsVjKgYx1j3MGaJXVmuNnVn5YHaIbju6HCkuCoYosz+3BG6
         tJrw==
X-Gm-Message-State: AOJu0YxndiTxr1mEtCTDQnD8AGN2B5SXlXkTMh/Z26Hpauk+f++XYJMk
	qi1G7zpYP3w6BJlR7JzQl4Cn2eemf77p+/a3slz+eK4YcigzOtw6723WEVwKDb1xFKi2UxgW/9f
	pSgPncXEcAEFybPP56PEwQ1ldJOo=
X-Gm-Gg: ASbGncsObGbY5VMBp+rW7SZORW9bg7gbBoWg1x5/M5w22gYkH+Fu9s71uS2JiSIwx9b
	KO5lXdvCddnQKxPQqSs95sxovueEAvuBo1LMEvep6k6UieKlWskjYNzRyDsHa6tRjkFYIaeB6h7
	/73iMhgPbgKG4XOiS/Dj1rKqeDhrRpjDq3Rw38D1XxCRFqM3F+2v8yfQ==
X-Google-Smtp-Source: AGHT+IEun5hyxZakTUUaPk9v4e8fReVNQY3I4KRfkrXNHoiYHBCugZpaaWgFBAfvpwIbq+BvncVkiN9g3ur7HiNadUE=
X-Received: by 2002:a05:622a:348:b0:477:1ee2:1260 with SMTP id
 d75a77b69052e-48dff3e17ebmr37081cf.1.1746253492016; Fri, 02 May 2025 23:24:52
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqecxk3u5l.fsf@gitster.g> <20250503060736.587286-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250503060736.587286-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 3 May 2025 11:54:40 +0530
X-Gm-Features: ATxdqUH0FOd_6leXd9b8hagAD72GcYEXbWW2B9d-r6o7Jt-bTuO45htE8CP2tFE
Message-ID: <CA+rGoLfFCi-q52ABUr=0O=pu+qSikcomSk1akHWUkfAfSf=pZg@mail.gmail.com>
Subject: Re: [PATCH] dir.c: literal match with wildcard in pathspec should
 still glob
To: gitster@pobox.com
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, peff@peff.net, 
	piotrsiupa@gmail.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 11:37=E2=80=AFAM K Jayatheerth
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> With a path with wildcard characters, e.g. 'f*o', exists in the
> working tree, "git add -- 'f*o'" stops after happily finding
> that there is 'f*o' and adding it to the index, without
> realizing there may be other paths, e.g. 'foooo', that may match
> the given pathspec.
>
> This is because dir.c:do_match_pathspec() disables further
> matches with pathspec when it finds an exact match.
>
> Reported-by: piotrsiupa <piotrsiupa@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  dir.c                                 |   3 +-
>  t/meson.build                         |   1 +
>  t/t6137-pathspec-wildcards-literal.sh | 429 ++++++++++++++++++++++++++
>  3 files changed, 432 insertions(+), 1 deletion(-)
>  create mode 100755 t/t6137-pathspec-wildcards-literal.sh
>
> diff --git a/dir.c b/dir.c
> index 28b0e03feb..9405fee83a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -519,7 +519,8 @@ static int do_match_pathspec(struct index_state *ista=
te,
>                     ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)=
))
>                         continue;
>
> -               if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
> +               if (seen && seen[i] =3D=3D MATCHED_EXACTLY &&
> +                       ps->items[i].nowildcard_len =3D=3D ps->items[i].l=
en)
>                         continue;

For some reason on my computer when I check the formatted patch the
ps-> line
align with the (seen && ...) line perfectly
Again when I send the mail it is shifted forward,
I ensured to use tab space instead of 4 spaces as previously asked.

-Jayatheerth
