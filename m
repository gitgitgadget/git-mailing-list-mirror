Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AC1BD9D0
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678978; cv=none; b=h07aB5PQbi2S790goaeYC25MB0q5QA9T9/GToL7Os6gybNilSe4Y3YblyjoR9hJJkgRED0IMHPU/lo4R7ZxDb3tf5/7CUIOAugXnsAp7dVJaEMeW4qYZuiAUwtn5P2e8ql3PfQikeGPvCAqnHNgCl95prE4vHx62ZahIINHpaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678978; c=relaxed/simple;
	bh=JgskVnlZ4oR6IL9LJk3feOrcjAIAsg0RDiuf2QQJtDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zd9WkkEVhvLsxDKvXN/90ilGEzmXdCDdUgvwoM+acW3LxhebX3bFRET6WVRCEqTVUwGtydXFUynUAqL54/EmGyHblnB92mFBz1DJl3+8TYxBGDBY+xs2NIz+oAgoKBbN5Sr9KJmolVhJkdohovuC3IWIgGu5WjR2kLvHb9i5Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCiYiuJN; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCiYiuJN"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51eb1a6954cso518741e0c.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740678973; x=1741283773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL/VLfzg1w0nbUYKgUMvrlValcDFOdfQDqlQz8iBjjI=;
        b=bCiYiuJNKWR2+NxfR4LMTXjYb/96WGA0mblpiGIjDwUGGLxvnO2JptltkRhHeUU4/5
         ZnWz3wJVR3m6HfAvXqwgiffCXyxMq7wFzrI6O8t49EdZtX/vO0hUMVGPfcFLk+7N/oxJ
         wiNr5Y1Sd+YgeBkOq9FPu1KnmdFCh1MDs6ds3y+dyxUFs7b34AvMgrunGbHlpLNXCIRN
         NtVQlEQ0ZF35hz/SsdGqCOp4EYLQArX7QDfgbyLBjuwmVwXh72U3zQbA9EDzStGj3vNX
         5amO6YwhaO31CYYsdMHpuJ8byDz76W5l+LJpd7bPfz06UYF67w2bRFHU0JPZPL9Ha8v5
         s4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678973; x=1741283773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL/VLfzg1w0nbUYKgUMvrlValcDFOdfQDqlQz8iBjjI=;
        b=Im0GBjX9Wb/SEy6n8ZjZJQ4hSqcp+12miH/R+mvr2Zlmftdjkuh6KcyPsB5A2DW68s
         4KU5VtsftI+6BMJ3BriKwjRc+yv1pUpKTKDlQC5G0pKOBs5fT7gSaNoEaqOxMEzgS7Zh
         +1sYIlF/jJiHUcZcXTEziorxf+ELiEdrgk2uf9ey17kJslqsWkPdjLxnFCs2tUt43KOq
         Jqvp7FalL/grQBGhxlNeK+2Lh7uj12LSG/dbHtXy1hYKarPzySDbfdjNdDBuZvx6fIYm
         iQJeeqSFwKk0G7sYlPSZB2HOAbb6dsSWllbR3N84aLiDHpmH3h/UpcjH6ayt6ubql3oX
         IbzA==
X-Forwarded-Encrypted: i=1; AJvYcCXJkHYlXH62SZqr/gFAKHV/YWmYfATJ6co8ZiTSXuUgyKq2fv7g+CwP/q5UXFFzsOKyK9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGevsssnRWVlI324Past5FXqOagw5gU4ZqWvZU989zkel0Q5O
	Ofw8aYiNjU1aPhY3aPJoxQvcQKKzhFhrl525J6LkMLQR+s0h+6nnrnkeX9O/jfkxowkS30SWM4n
	qVHX3TcCbvu4uqVcKlKj12diL+HA=
X-Gm-Gg: ASbGncs2aGy81mXPX9zNITg3YvxmDSXijGfycWNYpbrsT230xzGv2hKWG485RA2F/Kx
	ScGJnweGOREwXBB3NCwi7L9hBXnU+8wduyEZXX4Rhmp0v+ZHOWIocpwZi+aXYMfncxr39X2ja6g
	PlMAg07OM=
X-Google-Smtp-Source: AGHT+IEmqOmOGrHJahGglX0VPGCJKgPpuRqf36SZ+vSBhivQghshYBx1OxeRSUOPTV0Crd4j4V+6pEm+M+Ca20c6Qbk=
X-Received: by 2002:a05:6102:512b:b0:4bb:ba51:7d54 with SMTP id
 ada2fe7eead31-4c0448b1c82mr315132137.6.1740678973573; Thu, 27 Feb 2025
 09:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com> <20250219203349.787173-3-usmanakinyemi202@gmail.com>
 <xmqq34g8ei5x.fsf@gitster.g>
In-Reply-To: <xmqq34g8ei5x.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 27 Feb 2025 23:26:02 +0530
X-Gm-Features: AQ5f1Jqb-XZqW41UB_9S0BtvXxcSLkHjCSQVyf_bqb0Qy17naTdFSemVSyPo--o
Message-ID: <CAPSxiM-bOcqEbVNAYxh0oPXKceN7YSrCU_37e7mXAbxwpq3QNQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] builtin/verify-tag: stop using `the_repository`
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, me@ttaylorr.com, 
	chriscool@tuxfamily.org, johncai86@gmail.com, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
Hi Junio.
> > @@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] =3D {
> >  int cmd_verify_tag(int argc,
> >                  const char **argv,
> >                  const char *prefix,
> > -                struct repository *repo UNUSED)
> > +                struct repository *repo)
> >  {
> >       int i =3D 1, verbose =3D 0, had_error =3D 0;
> >       unsigned flags =3D 0;
> > @@ -50,13 +49,13 @@ int cmd_verify_tag(int argc,
> >               flags |=3D GPG_VERIFY_OMIT_STATUS;
> >       }
> >
> > -     git_config(git_default_config, NULL);
> > +     repo_config(repo, git_default_config, NULL);
>
> I seriously think that it is a horrible idea (but the previous step
> of this series is hardly the first one that commits the same sin) to
> move git_config() down only to deal with "repo might be NULL if run
> outside a repository".  We should stop making such changes, and we
> should revert the changes we already made along that line, to solve
> it differently.
>
Yeah, I agree with this after going through your comment on the other
patch. We should look for a better solution.

> Wouldn't it work much better if we teach repo_config() to allow repo
> to be NULL to signal that we are outside any repository, and behave
> the same way the current git_config() works when called outside a
> repository?  Even though the function is called repo_config(), it is
> *NOT* limited to read from $GIT_DIR/config but does read from the
> usual "repository configuration trumps per-user configuration which
> trumps system-side configuration" cascade, so it is natural to skip
> the repository configuration when called outside any repository but
> read the other configuration sources, which should be what happens
> when git_config() is called from outside the repository, no?
Yeah, I was studying the config.c and config.h files to understand better
how all these functions work.

The git_config() when called outside the repository, uses the global
the_repository
variable basically called the repo_config(). It does not necessarily
handle any situation
when the repo was NULL. It always uses the global the_repository variable.
I do not think we want to handle the repo_config() the same as the point of
all these are to reduce/remove the use of the_repository global variable.

While going through the config.c I saw the read_very_early_config()
which read the config
from the system and global settings and does not require any repo
variable. I think, to teach
the repo_config() to allow NULL value, we could call the
read_very_early_config() whenever
the repo is NULL as we know, this happens outside the repository. I
sent a rfc patch for this
and it can viewed here :-
https://public-inbox.org/git/20250227175456.1129840-1-usmanakinyemi202@gmai=
l.com/T/#u

Another approach which I was thinking about is having a local
repository variable inside
the repo_config() whenever the repo variable passed to it is NULL.

What do you think ?

Thanks.
>
