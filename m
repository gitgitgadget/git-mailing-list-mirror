Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A434C900D
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602856; cv=pass; b=GbZcmf2042CmCfzppm9hgMM/pgIA3DlXUthCAxeMPcispDMk2EfB2tiHlF4rZZH+CAMWPHecNFmxyNl4WX7CR0tvod09KJ92SfQGcXU9IrZzm1mYRKv/DhxC9sYw5swxi8UsbmU/xv9zYx5X0b9FvmOmy/5+NWf4yqBMb0JduNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602856; c=relaxed/simple;
	bh=4ISxq6YSI62gxGhzWUZnubpYM5AcV1z0tVrrcMahKHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufENS4batWHz0Oezc2jXDx0bNgQVjTQTwYa4Kha+mxj6wZMpEZIYwfQbMvHnLFV4rEDWnSZp9nl5oQUn/4xP4xBBjEZhP+/K1fJ5foXPvyaSm8L9GtDQa/ja7rZSVVjjLiDmkB57nf4HRHzBzuhC/Ole15aWrCABQliZXKc3t8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWNcA61M; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWNcA61M"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so5104105c88.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602853; cv=none;
        d=google.com; s=arc-20260327;
        b=mIC1HhH6z0jmB3McWE/7sBbjHYpMILf895+4yWVBrz3LCgMO3b7Y0lDnxwn4J02qj6
         yOs15Toy+DENia+EddIM8LBDjOY6G+6OQv1KZCcVVgQLqHn1dbaA/1R17GSO5PeW35hU
         06+3kweI/X3Zu59ZwSPAhoNJoKS0c5ttyBi3j0eVGSKVAEpCeH6woYrtbZxLojon1bGl
         O3Dqrk6lHC7+hUnwFB1wQX1JyRMN05SChvmyOlEOZSs+t16Qlciw1nrOavu9xDLdINCu
         tc0jHcMBaP2n60X21HXJamvj6eAoXxy1g6L6sDaH81g5ZkIWCwzxXRIKgVawwnc7xork
         UEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IRFT1byyy30nMikRdpAX30FixkywEpnNqYlOutDCMA=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=I6l3Tr/on3IPccxu+Ee7WLNQYdI5q4nVgyhRqjdKhQKjnWUXPYRWUaUYpQzadiJNCn
         P4r6rJKJzGogaSYeHxjlGwH8/exjAQqVYVunbDig6mZOjaJd11kcYwUbFFOzaHMisbrn
         46aNWWHwV4EvcyK+ypuJgSpChGU+6WSrT8tN+lDX8IR8XXMe2ltNnLGWyy9AlZiR80cp
         8OTb67+bfsqemqN7kGMkqCbsGAi3dNXbvYvjZe4iltzis9F8JN6BqW9JXKe/+l1fX/JN
         8hA6BHu/aGG/M6SAmnnoJPt68BybwIaTOrvW7Bn0yZVO31j9eyRnGEAbhAdsVzpxVK7S
         ykAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602853; x=1791207653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7IRFT1byyy30nMikRdpAX30FixkywEpnNqYlOutDCMA=;
        b=bWNcA61MIiy78g6P1oGNTs1UGgTvZcH639PRL4fpM3TGpwdUE8vdjM8Hv2NWZPB2zu
         sMghmYHT8zBGpcGdip18hUDk+YrkNoyxO1riJgG2yprn8ODT1Z73MbAtUoyV185tDlvl
         imo15WaldbFKcwnfCjxQrg0g/Rrlht3b3IeEHIvLoAMnbkAdGZ0g4wW3zBtjvQX/V3AE
         1WvV3WNv0RQkNvE3Wq0ub+w9YlIdh+vGkjcc0hq38i8avJsCb0K7AYmOZh2099eHUSq8
         FlTX2tTXPWskHnpYHx3sf20Mcl28G5Zw0rcW9gz4HxisRD/uX7Uu4m25Jj8GlEQoyC+y
         dONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602853; x=1791207653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IRFT1byyy30nMikRdpAX30FixkywEpnNqYlOutDCMA=;
        b=d/wHwcLgmKS0y3V6h1I2RiVER5V6EcMvcIKZtLMWlCJphyPa5gnMtS5UsYg2gUyZlA
         26zh5bnZVBJVL70wyEMQsLTnGXkDgs9jvr3Q0pWm36XQBdHSPkkH3L5QCN3JiZp3aH4i
         f9L5zGbnoE0yzRIsOzzMC9x6XWtJ5UzZx5tRMRe1ixr4+7qvYfQ7MoYeOLiAKgFDUQhq
         PffSt0jabaQONMrMDRrMav+XhSgNi62WtgU+RC6IHkXHS3COdzIFKTkQl5RwbEh8SnuV
         iLoSVYau0M3HAtZvlKcB9CjCQAYjyUF50XxqcBG59Q+wiQ3MDmNyvLF4T7i89j735Bhu
         EJFg==
X-Gm-Message-State: AFuF++lST40JkzsEa3Qk1qeCuTPfqKOQ0KeXWmhOtGYoz0tecNoWwcJz
	RkT46f9ZjJGIOofqEMbCdpL+dWmuji81pfuw+97Y9bvMn2sfiMWPdysSnBneAJRv/l/Uf8yuNcH
	+Y5eEZvkVAYFmKsiNV/629LruytyQ4PM=
X-Gm-Gg: AYBFou0GDov2YyemPJtpN7qmtViSUKineTOJn9aAG0ClSNXNyL/uZUZWyqNxJXiqeRo
	eHrvd8ComOpYU0D0tX4IYSk3khb9ItgxeDaP421Oj8ZvmQb+AwMUu+y0GE0O5tOFzFDKsE+QDgZ
	shw5ip8SQSVgRlbgB+YRok9/TGfIi1mvRkxiiDOTPkgI0M8yKZohp+o/ID10r3Lr6K8+AK17I51
	Ecwq1EK1z5J0FpvNCbdnYK0hgunNn9Mrsh1NhyNRFeR9/ZCg5Juy9YGZln4wyTuOZEvvepyc3+f
	zo/3hA+omTGhiJp36UL1HAZdwBKTAplT+TFA7ORE87nkOII2t98kAWxJr1DZsi16hIzy9XcmSJM
	e+80eBp43vs8nNgtEsG91YceZfB85fA1foVvarg08i1B/bAZaIEorhNEZzxcSn+++BlQvuumB+b
	DyBFKDBEf/FwleTdOic1E+NgxTbaMHMBkS6kMTU0g=
X-Received: by 2002:a05:701b:281c:b0:143:7330:7fbc with SMTP id
 a92af1059eb24-146cee37b69mr9414039c88.21.1790602852514; Mon, 28 Sep 2026
 06:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com> <20260908164129.560396-3-christian.couder@gmail.com>
 <xmqq33vjy6qz.fsf@gitster.g>
In-Reply-To: <xmqq33vjy6qz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 28 Sep 2026 15:40:40 +0200
X-Gm-Features: AclHuK-nKniVcxjZKol7OE6673z4t29-Z75jarOSyKUL_QZLGT5RBGPxRQkXE7Y
Message-ID: <CAP8UFD0da+K3FLVAgmds8CUr3aFrLjsmG7qO3mYX4foNLMYrMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] setup: extract path_allowlist_apply()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > For clarity, let's change the `int is_safe` to `bool safe` in
> > `struct safe_directory_data`.
>
> I am not sure if this clarifies, though.

The change is now explained in the following way:

    +    As the new path_allowlist_apply() function reports its result thro=
ugh
    +    a `bool *matches` argument, let's also change the `int is_safe` me=
mber
    +    of `struct safe_directory_data` to a `bool`, so that its address c=
an
    +    be passed as that argument.

and only the type of the variable is changed in v4. The "is_safe"
original name is kept.

> > diff --git a/setup.c b/setup.c
> > index dfe05d9a03..366a7dc5c0 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1338,67 +1338,105 @@ static int canonicalize_ceiling_entry(struct s=
tring_list_item *item,
> >       }
> >  }
> >
> > +void path_allowlist_apply(const char *allowed, const char *target_path=
,
> > +                       bool *matches,
> > +                       bool (*allow_path)(const char *path, void *cbda=
ta),
> > +                       void *allow_path_cbdata)
> > +{
> > +     char *normalized =3D NULL;
> > +
> > +     if (!allowed || !*allowed) {
> > +             *matches =3D false;
> > +             return;
> > +     }
> > +
> > +     if (!strcmp(allowed, "*")) {
> > +             *matches =3D true;
> > +             return;
> > +     }
> > +
> > +     if (!allow_path(allowed, allow_path_cbdata))
> > +             return;
> > +
> > +     /*
> > +      * A .gitconfig in $HOME may be shared across different
> > +      * machines and the config variable entries may or may not
> > +      * exist as paths on all of these machines.  In other words,
> > +      * it is not a warning worthy event when there is no such path
> > +      * on this machine---the entry may be useful elsewhere.
> > +      */
>
> This is inherited from the preimage and not something you would want
> to fix in this patch, but I do not think ignoring missing path like
> this is healthy.  You do not know if the path given is missing by
> design (i.e., the set of paths is union of paths that could exist)
> or if it is missing due to an error (i.e., a filesystem that should
> have been mounted is not mounted).  In the latter case, ignoring it
> may make the system behave in a way that the user did not intend to.

In dc0edbb01c (safe.directory: normalize the configured path,
2024-07-30) you say:

     - A configured safe.directory may be coming from .gitignore in the
       home directory that may be shared across machines.  The path
       meant to match with an entry may not necessarily exist on all of
       such machines, so not being able to convert them to real path on
       this machine is *not* a condition that is worthy of warning.
       Hence, we ignore a path that cannot be converted to a real path.

So I don't know what is the right thing to do. Maybe it's safer to
warn by default but have a config option to not warn? Or maybe we
should remember the unresolvable entries, and mention them only when
the overall check fails?

Anyway I can add a NEEDSWORK here for now in a separate patch in this
series or maybe in a followup series. In v4 nothing was changed
regarding this.
