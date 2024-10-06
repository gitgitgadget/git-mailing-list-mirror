Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD922C853
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728240096; cv=none; b=tIFxR8EN7le3jEtnLjnef3eF2r0ngZB386Tqq6orICZtEgwz6bnMMssKj8u08aaDuc9kxamqMt87gnBrHFv498Bs0hOm8kMgD3+0ec0igpNjxsZD6BTOjdNL42rEZ1fhnSirC0iSRDZphVap+aqQGe3EUYLWhiARV5qot7CVSFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728240096; c=relaxed/simple;
	bh=Vm/RxGpSwOXmg4aL1NI/UBipdUlFpqdSVAxLt7DNxWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpGv4qQEcqQL6YirYM6YQktixdbtPlEwXdF8BQRNJdzhcZWk0AIIzB97zpsKYejKi8FXDY9Hx43Uwmf3iFGfYoZ3FfzdnT+YTfWvfZH8ZUBhOF2Bnwr7TnO+NKGQ6M9X69HGnqHsNuxJJq0r0Wtz6sFQlGmIpVsXDN1cm57Ekgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb36237f28so5357846d6.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 11:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728240093; x=1728844893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf3AUeG9spC6EigSFEP42btK6I2s9tvH3GBrCb20w64=;
        b=GIV3WFYQvds04Tlr0snNYWwP0vHm3/kf07/vjJI9ODj34ZP0AxTYToG5QezK+DPFxA
         V0kJ9UFl8H6zwb9lZb4djLzf/jkvnK/Yfn5RhmrP5NI6lCw+1p72wKhZceon+UpEW0oY
         +W7T6l947c4gkztVY8pflJDoC6CCLXr+nbyVWBqrcMEp6bbOZWTaz1toyJbrOfTHnm1S
         qGOLpp26GxGRt9ZumIfh3jUy0GsvV4fy/3uJ3u+OPLeCLFx3qwa7PSprEdUJ4/35LP2O
         +TITvT+bHQXLutgUREpE7WH1gqaoX3lHs3qCpMq4pqz4DeR8+YCpEfOZjVWSZl0tJdlm
         AdYg==
X-Forwarded-Encrypted: i=1; AJvYcCU9RSweuZ/c4GEyDXsEHEAfdAICgBOPkYa9xnUJeeb1l4p5bXd1zoCVlFjaqm6mrIIVgGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhjDVHE+gtJbb+Q1i0BanMungIgwKQgQoX3aHFig9/22SQC7x
	/v6+XP5nDkYKX6HW7bHRKF0FUKBvjpI/lcAnLKhpPZ/WNL+sDIqaS3AsYIjSNiFxgrelYpdHADp
	LaaCzzYCSWav8FdUuwzPiEpJM1nM=
X-Google-Smtp-Source: AGHT+IFMC4PGtfrcjxecIlolLRntiT5NAhC2CU2g3jeqQF7DG/lXMxaR7HKKgP/9lf1z6YNw76zl9vd9lsNINxQl3/k=
X-Received: by 2002:a05:6214:2262:b0:6cb:2d1d:348d with SMTP id
 6a1803df08f44-6cb9a45511bmr72669776d6.4.1728240093098; Sun, 06 Oct 2024
 11:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me>
 <ZwKoNg-HYGaohvCd@ArchLinux>
In-Reply-To: <ZwKoNg-HYGaohvCd@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 14:41:22 -0400
Message-ID: <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
To: shejialuo <shejialuo@gmail.com>
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 11:09=E2=80=AFAM shejialuo <shejialuo@gmail.com> wro=
te:
> On Sun, Oct 06, 2024 at 06:00:57AM +0000, Caleb White wrote:
> > -     backlink =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf, =
&err));
> > +     git_contents =3D xstrdup_or_null(read_gitfile_gently(realdotgit.b=
uf, &err));
>
> So, we create a new variable "git_contents" here. I suspect this is a
> poor design. In the original logic, we will do the following things for
> "backlink".
>
>   1. Call the "read_gitfile_gently" function. If it encounters error, it
>      will return NULL and the "err" variable will be set to NON-zero.
>   2. If the value of "err" is 0, we would simply execute the
>      "strbuf_addstr(&gitdir, "%s/gitdir", backlink)".
>   3. If not, and the "err" is "READ_GITFILE_ERR_NOT_A_REPO". We will
>      call "infer_backlink" to set the "backlink".
>
> Because now "backlink" is "struct strbuf", we cannot just assign it by
> using "xstrdup_or_null(read_gitfile_gently(...))". So, we create a new
> variable "git_contents" here.
>
> And we will check whether "git_contents" is NULL to set the value for
> the "backlink".

Thanks for thinking through this logic. I have a few additional comments...

> Why not simply do the following things here (I don't think
> "git_contents" is a good name, however I am not familiar with the
> worktree, I cannot give some advice here).

I found the name "git_contents" clear enough and understood its
purpose at-a-glance, so I think it's a reasonably good choice. A
slightly better name might be "gitfile_contents" or perhaps
"dotgit_contents" for consistency with other similarly-named variables
in this function.

>     const char *git_contents;
>     git_contents =3D read_gitfile_gently(...);
>     if (git_contents)
>         strbuf_addstr(&backlink, git_contents);
>
> Even more, we could enhance the logic here.

Upon reading this patch, I had a similar thought about this, that it
would be more reflective of the original code to set "backlink" early
here rather than waiting until the end of the if-else-cascade.
However, upon reflection, I don't mind that setting "backlink" is
delayed until after the if-else-chain, though I think it deserves at
least one change which I will explain below.

> If "git_contents" is not
> NULL, there is no need for us to check the "err" variable.

I'm not sure we would want to change this; the existing logic seems
clear enough.

> >       if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
> >               fn(1, realdotgit.buf, _("unable to locate repository; .gi=
t is not a file"), cb_data);
> >               goto done;
> >       } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
> > -             if (!(backlink =3D infer_backlink(realdotgit.buf))) {
> > +             if (infer_backlink(&backlink, realdotgit.buf)) {
> >                       fn(1, realdotgit.buf, _("unable to locate reposit=
ory; .git file does not reference a repository"), cb_data);
> >                       goto done;
> >               }
> >       } else if (err) {
> >               fn(1, realdotgit.buf, _("unable to locate repository; .gi=
t file broken"), cb_data);
> >               goto done;
> > +     } else if (git_contents) {
> > +             strbuf_addstr(&backlink, git_contents);
> >       }

It certainly makes sense to check whether "git_contents" is NULL
before trying to copy it into the "backlink" strbuf, however, if
"git_contents" is NULL here, then what does that mean? What does it
mean to leave "backlink" empty? The only way (presumably) we get this
far is if read_gitfile_gently() succeeded, so (presumably)
"git_contents" should not be NULL. Thus, rather than conditionally
copying into "backlink", we should instead indicate clearly via BUG()
that it should be impossible for "git_contents" to be NULL. So, rather
than making this part of the existing if-else-cascade, we should do
this as a standalone `if`:

    if (!git_contents)
        BUG(...);
    strbuf_addstr(&backlink, git_contents);
