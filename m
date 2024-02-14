Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B741B7E2
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943763; cv=none; b=HFPfU0r8FQ5F2OWxVfYCEKKW1cni4Zq67IxRCpDUQ8xOqAdzrO//kFPFyo/HHCkhPQfxuifdEuw7vmHrnqeTcdCRs0+qIoiXS9WW1o25JDZKJjlHpnGOcKWeyx/VDH6XcVFG4/coSL7onscuTM3nsPpaozBDovdsyw31IjE/zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943763; c=relaxed/simple;
	bh=MoCL+5yyi5Cg8eaPEsxYHxb1JJXsEqljEOxSeZwzEPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AhW+RHJzppNUfoe/aw5SZuAGrrtAywqpRkeSDQks42YM1UH5tXSMyGp2DLNWB3NcvOYIPNhstry6W6Oec2rFDUulwFVIsRR0gLE5dqCNJO9Ps20b6e/y1TLp8Bp5k0tNW09Anm+I7GkvEyz8qR6WnPRfrHX6J0Y9uBcAePGl0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkyPioR4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkyPioR4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso220838a12.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 12:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707943760; x=1708548560; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqfh+pSLv/htm0CyG6hhL+pZz9oT1yX0l/CHU3RW6lA=;
        b=fkyPioR4PI/t1O4IADR+7rEkunK99eDQayI4cndNieLLA4LBwOh6qgFSMXQYl9KFp2
         wbyNMoQi4tOVkPmqJzddxFdSdb0NXgdQHUdP/XjCmWBOYBsAQyI7BYe1CPYWivfULTph
         2L7XbomtwllfvXaxFnUJbXILyDoWGr/ZyBjUd0WkmOEBgyfznZx5gknjKhLm1UIoeaw/
         os22Iz2IGsL6RRyBe9aGTdCpN69WpM/+m1pkpEnHAtLmtlP4RCLWg2aNzPlUL0CI3mCn
         z4mvn9esBqYa2FeiF6rPeBylDhiqNEZlJiz71p1x/XJpK5ImZ3DyjRfveACdbEEQPJg6
         YJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707943760; x=1708548560;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqfh+pSLv/htm0CyG6hhL+pZz9oT1yX0l/CHU3RW6lA=;
        b=pMwCgb0druumqzT66QPhXVnS6ECMFa6l9XTLgqkdm9iaHwb4N6GnojUjpRadtLTR1A
         eqljhhnPlu7HqbWiIcNFpsME5YsHVhZNzKDwgB+fFDzKSpik2i2CVkffpAvSRshNw3Ch
         45zbjD7K9uoDJMKHscEz0fqOXWO1zIkzGVa48arfrpKyqfnHj+uPs+cX7cPfYTZF0AZP
         sHaCa14DGjB9Jb4vXO7nwRJ2Oy91q/Kb0mA1ZNCRMplBpCO6XaY63OQuXdO3J7ShLMAq
         l/CNtcsHjpd/bqs9THASw/lD3JRASTP7VgvjMayWdYp367TLBIAmHsHNm1J8cNWTGFg2
         ya/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2MLRFyRcOeKM3cN6TNW9Q+jYLW936YSKvYjlcMPFJnWvlTJRLjOUap6ZxU1weEVu6NGdf4ujRJxHozmrhyX5THhoP
X-Gm-Message-State: AOJu0YysYQRYFn1THz2Wq/Dkjg2d1g+jnQyR43/WK3M7SsBdVuZgQLtq
	IgTpdFBBeugL9+/x8yChJ7KxwWL23+RMhrWvQjhlif3y7xekkZVmsmmq/kFd3FSiNKuKpinTB7J
	4iJGvYhMMDmzutG+V0gC4YtD5+vfx4Hxc
X-Google-Smtp-Source: AGHT+IGJkw3swXROijeq52EGheZLlhhXzp3WOehbyTQq5Lvfle9H9XEnxg2FpZOGVMIK4nOgA4CUBboxGgQUaj2O8cg=
X-Received: by 2002:a17:906:1107:b0:a3d:7d6b:60c1 with SMTP id
 h7-20020a170906110700b00a3d7d6b60c1mr270173eja.61.1707943759729; Wed, 14 Feb
 2024 12:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
 <20240109010830.458775-1-britton.kerin@gmail.com> <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
 <ZcSJaRczdHApmnVi@tanuki>
In-Reply-To: <ZcSJaRczdHApmnVi@tanuki>
From: Britton Kerin <britton.kerin@gmail.com>
Date: Wed, 14 Feb 2024 11:49:08 -0900
Message-ID: <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] completion: don't complete revs when --no-format-patch
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:57=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Jan 08, 2024 at 04:08:30PM -0900, Britton Leo Kerin wrote:
> > In this case the user has specifically said they don't want send-email
> > to run format-patch so revs aren't valid argument completions (and it's
> > likely revs and dirs do have some same names or prefixes as in
> > Documentation/MyFirstContribution.txt 'psuh').
> >
> > Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index 185b47d802..c983f3b2ab 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1242,10 +1242,12 @@ __git_find_last_on_cmdline ()
> >       while test $# -gt 1; do
> >               case "$1" in
> >               --show-idx)     show_idx=3Dy ;;
> > +             --)             shift && break ;;
> >               *)              return 1 ;;
> >               esac
> >               shift
> >       done
> > +     [ $# -eq 1 ] || return 1   # return 1 if we got wrong # of non-op=
ts
> >       local wordlist=3D"$1"
> >
> >       while [ $c -gt "$__git_cmd_idx" ]; do
> > @@ -2429,7 +2431,9 @@ _git_send_email ()
> >               return
> >               ;;
> >       esac
> > -     __git_complete_revlist
> > +     if [ "$(__git_find_last_on_cmdline -- "--format-patch --no-format=
-patch")" !=3D "--no-format-patch" ]; then
> > +             __git_complete_revlist
> > +     fi
> >  }
>
> While this second hunk here makes perfect sense to me, there is no
> explanation why we need to change `__git_find_last_on_cmdline ()`. It's
> already used with "--guess --no-guess" in another place, so I would
> think that it ought to work alright for this usecase, too. Or is it that
> the existing callsite of this function is buggy, too? If so, we should
> likely fix that in a separate patch together with a test.
>
> Also, adding a test for git-send-email that exercises this new behaviour
> would be very much welcome, too.

I'll look this one over again and add some tests eventually.

Britton
