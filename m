Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CE2571D8
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996427; cv=none; b=fM4TXFLP4XisuoGMI7A14wC6+mIn9VDH199bV5qYMYNx7fRqrFK4lvoo5LvXOwsesrANIWQACOyi9m8svRQh+h2qDia4HxGdDceyRgr09wr94h/e9IkktatX4EHVtfCb/RzS8QnS8bbX0/OENdfktVLFSDxtoAh+TGNM0k7zqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996427; c=relaxed/simple;
	bh=5GCHCN+nGnZlDg7euHGbyOwpaCdEod3Is1nIYAfs+Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk6r005m2jpF1aKJ7pfaM0pp3DpBKHIcphuEjpj0v279ljhKkUArBit/pTYSKR+kD1R5Ah5V5UPJ5Wcz9lsWOvUyhgcXByMTM8mA6RKxF9EtDrRlMWatH8hxOvxMMIrQ6VZjOgx9TrNjouA1YmcRe0dtlVmAnxNmPAQRgPUHJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTJNXLwK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTJNXLwK"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-33216091f46so1718891fa.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996424; x=1754601224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL49pke4EKsVstI1XlJh5xUTDpj54eA4tDHWv1fNtnY=;
        b=nTJNXLwKFW6bz9tOQ8DmsxYIW60FMpthxGdnwYtPNsihzDGR6rWJ4VuG89uAEkNU0g
         qOgN4wJNzMbHA8Il/jA4Eh2IhZpFLytKfVUDsPliQRKPWroplHSwnG23nQ6WMc20voZg
         K0Dz0ejcm6z8U4KWE8Pz5Y0iyYkGj87iZ/1muqNbOo9S8cMQkpIDuYkA8gThp0S2LnI9
         R2lX/q5akP7wWEOvLNnzHhaPVXaQDlxuv1MyZcNXo0PkyY1tlPePxiOn9bWL5RZGdNdF
         jINUQd3imncZLol2m+UYPUCQ/ksF/oFKlwZkOSnqscUG3WHuH88ulXZMP7z0uli6paMJ
         VryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996424; x=1754601224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL49pke4EKsVstI1XlJh5xUTDpj54eA4tDHWv1fNtnY=;
        b=N5G6fDqmvAlmyACok89Erav0VpDkcY1L0vioWsl0OgLnoHqoq7vEGcPEVyciRD7QXU
         k7Ag9ufK6FdYfKgYVlb8TIjwfuQeR1zcp5OYLF5xwh6f2WMMZeTYqGSGvZ9rnPkmxCW9
         aDH9VwA43IHc/HliSh0o40gDDNkXkFPDrnb4jRwL1I/DkJlGEBVNgtOC+f1t07ZOt49e
         I0d8rwe7AzKfoK533X/qnjqyonuW3XD2ZopNoNBlaGiZxnd+2DYglDep9HOzYK+ebA8N
         amvV0yXoAghA2jyXnSgTXmdkZEWiKs2VVC9WYAF6ClRwBjbHHR5jUHrjaqK5kTawOWz2
         hhFg==
X-Forwarded-Encrypted: i=1; AJvYcCUbnTKgcsvycUpkxjUUhf858clAWe3fXUw42IrLeuaF16t/KzKa7As3/usrlaUahdUG02I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qx3pSCPBbrXqXXB1suOWM6hQDs9pX4p0XQ8wG8PpYxCyHyte
	ppqwZMlUSI54FMi+BzUySMtmCHtTHxgfRkvXVt7TR+SaEqaUriLwnE+aLKb38ZxXvxaOY3y6F3n
	UXJsox4GYtVI5rfmSd+hjPOldMFaNNFQ=
X-Gm-Gg: ASbGncs5PYoYB3atpO0AGw5wtnRMtVPihL6dcbY0FTpXsOEHMp+GRsPhAZx5kUobUBg
	1gMl3neFvdLQSRByeMq7COg0GiX1cmQu5jPwmgO9u9SPfr1UtsarsFG5o1FNigQt5InAROh6meZ
	dNTTfLNu1Gen1fMJfhiZjW7MZjP1Xz7MPDWJB7+xbNmmD0M17VPar6dNnQzX6j9Li5nZpNKYGUZ
	9wl7bTC
X-Google-Smtp-Source: AGHT+IE2i9iaLaDTqyI8icrbVQiFrA0MMy11D8jU9ARqrZreTQ6rOcr9xIF4ZPq4pzwSrsVGAdu5/szFOxXY58vVMnU=
X-Received: by 2002:a2e:a71e:0:b0:32a:8035:3f65 with SMTP id
 38308e7fff4ca-33224c086e4mr19592261fa.36.1753996424305; Thu, 31 Jul 2025
 14:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <xmqqzfd12ujv.fsf@gitster.g>
In-Reply-To: <xmqqzfd12ujv.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 31 Jul 2025 15:13:33 -0600
X-Gm-Features: Ac12FXzAM3db7mlSkEWt4R5iYXErSPweF_82Q2zGwUSxIz8UIFrw7MnS_cG6qWA
Message-ID: <CAH=ZcbA-OWxbLJoqf1EtDetnXwAieXQjBr5Jmf+G4GiQsTv-hA@mail.gmail.com>
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of xxhash
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +extern u64 xxh3_64(u8 const* ptr, usize size);
> > +
> > +
> >  static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec=
, xpparam_t const *xpp,
> >                          xdlclassifier_t *cf, xdfile_t *xdf) {
> >       unsigned long *ha;
> > @@ -175,14 +178,26 @@ static int xdl_prepare_ctx(unsigned int pass, mmf=
ile_t *mf, long narec, xpparam_
> >
> >       xdl_parse_lines(mf, narec, xdf);
> >
> > +     if ((xpp->flags & XDF_WHITESPACE_FLAGS) =3D=3D 0) {
> > +             for (usize i =3D 0; i < (usize) xdf->nrec; i++) {
> > +                     xrecord_t *rec =3D xdf->recs[i];
> > +                     rec->ha =3D xxh3_64(rec->ptr, rec->size);
> > +             }
> > +     } else {
> > +             for (usize i =3D 0; i < (usize) xdf->nrec; i++) {
> > +                     xrecord_t *rec =3D xdf->recs[i];
> > +                     char const* dump =3D (char const*) rec->ptr;
> > +                     rec->ha =3D xdl_hash_record(&dump, (char const*) =
(rec->ptr + rec->size), xpp->flags);
> > +             }
> > +     }
>
> As a technology demonstration and proof of concept patch, this is
> very nice, but to be upstreamed for real, we'd want a variant of
> xxhash that can work with the contents with whitespace squashed to
> be usable with various whitespace ignoring modes of operation.  When
> that happens, and when the result turns out to be more performant,
> we can lose the xdl_hash_record() and require only the xxhash, which
> would be great.
>
> And that variant of xxhash that understands whitespace squashing can
> of course be written in Rust as a part of this effort when the
> series loses its RFC status.  At the same time, those who want to
> use our xdiff code in third-party software (like libgit2 and vim)
> may want to reimplement it in C in their copy.
>
> Thanks.

What is the git precedent for replacement code that is easier to read
and maintain while also being more secure, but is slower? I think
hashing with whitespace handling in Rust might fall in that category.

As far as I can tell the Rust code for dealing with whitespace is
going to be slower than the C code because xdiff used a hash algorithm
(DJB2a) that can operate 1 byte at a time and combined hashing with
determining the length. Xxhash requires that the length be known
beforehand and the memory to be contiguous or to hash it in chunks.
Hashing 1 byte at a time with Xxhash is VERY slow since it's just
copying to an internal buffer until a full block is ready.

On a broader note. How do I show the mailing list the changes that
I've made to this branch/patch series? I'm not sure what the proper
procedure is or even how to do it. What commands would I run, or web
browser steps would I take to show my newest commits?
