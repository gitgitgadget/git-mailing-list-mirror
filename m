Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3812CD96
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967741; cv=none; b=sy3h84UTbyFrOTksiPNoEkvrJOjyWW4bUIhgei7y1X+r0hdnvA3V5HPAQm3N1v55qbVwbeGNteriyrNd1RXIlO2BylYprEdp18cbFRDTOFyFby/kywAzmKlgZkHSuQK/eR9vfGutRBDVUB6DS6Ycr4cZcVfpAyuWZvc8PKzhou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967741; c=relaxed/simple;
	bh=60XzTBOmh818EJGbovoS4RiJR6JkSNEB8UJpKJ8f/Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV65+pfvgn0gZ3wcWPA5wfTdQMHSH//qADAHh8cimbdNx3XMsP73KbnFewAHQyyuHziRjztqy+Kfum4oknQHQ6MoZOT3nSaznj6y4dOaJCc3M/IZ/uLARQULh1z9zuXnMGEC7k+O1dCGtfodsrVUapuIqgDeFdVz2xhvgYyMYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV+br8fa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV+br8fa"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso4296146a12.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708967738; x=1709572538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgrO6uyzsOlkwtowYZhkUci/T3S8jz7bBHSYakcLAhk=;
        b=jV+br8fadOC6Os+q7AIvHzHbaSHKPcg7WHhXJC0nT2Gd3gz1mO2r9Xh64kWgQIb99l
         T9C4k4SjVrNbm6QKilq598TG+0xDTIRY2SPVs8Jj4mgsCp3bi8La9wB17YDBNoxv6asZ
         8iBtcAK8BqKvDLEOAJM2mRvOsUDixoUFvOOZ2L3R0Ao/ArmKx+FzXb9RlYuw1jMXa347
         rROFe+XOmWgQ51Kduvzd1t/EpCJK3xy+eJpXgAPcpv6goMpfdQQEghIf8tUSipUmxc23
         4sNvTwfraUxYPAtUKoxAgLaPUvoojUyegNxnQUKMR0oklYPDdjwYNMsj9Q7JSdA+84c6
         fxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967738; x=1709572538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgrO6uyzsOlkwtowYZhkUci/T3S8jz7bBHSYakcLAhk=;
        b=HXI6RSiM62KjSToGuDmEfYeegb3OMLRi8+MPv3/S0pBenqUbBIl8aNBaSFVyNcP786
         JxT9OaoBcSCmLJwMVtV5RkB/3vtxuCv7BZAP1hJETwGhwW7XknjJSwET/6OCAd+iMNDS
         fj6PP5AjDlFBnMXlj82xXZoW2pWmkckUeVD3LAMD+Zk5fKOnie29rS4i4OGcdetKZifz
         pIv6+kvFJP87iVsCUpIxEvLvKoMTGzX031VwUjjKFBuMXb+3opMsICQ4leq6jHwcBbAS
         KzCsINgi+ZIKuUivxDKoLM5RpvJ9+HUBjoPY81cYPSe+K0Ad4uFuDGMOEBZxdNRFGjYN
         3j1w==
X-Forwarded-Encrypted: i=1; AJvYcCWqW3NWUimloIPN3mUxHEFoCyfZRA0FUGsunIsxS7oi5LsAdqFoBVM62p17yvO+65Z6HnDvKn5N5oh/wNnD4PJMNSA1
X-Gm-Message-State: AOJu0YwqReo1S8l25NIvy71UafW1wxmeYcvnqwcKoKogzRGZWgMXD/69
	UWE7Gr8bjwhX+rEknepta1/xu2vglnj6yvN9zZTl3lVe0Qb8M2a8pJgB5ahJWXgP9zYze6m3MB8
	Tpx7xwlL1A22zN+ErkhXpKpSZ1HdDxG8FP1E=
X-Google-Smtp-Source: AGHT+IF4wSlj/KIU+TlqzHlfWvVVmaHmqKhUYsaZ62E15CRyUiqcb7S5BlHxMw/RJ7lNzDLezyZIABFKTjiJcVHXKko=
X-Received: by 2002:a17:906:66d9:b0:a3f:c3bc:f6db with SMTP id
 k25-20020a17090666d900b00a3fc3bcf6dbmr5300966ejp.76.1708967737519; Mon, 26
 Feb 2024 09:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226143350.3596-1-ach.lumap@gmail.com> <xmqqil2bdvsy.fsf@gitster.g>
In-Reply-To: <xmqqil2bdvsy.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 Feb 2024 18:15:25 +0100
Message-ID: <CAP8UFD0Qhy78=v9+hCekMJPkcH2KmeZeQ0xUx8kqrByQ4PO3Xg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 1/2] strbuf: introduce strbuf_addstrings() to
 repeatedly add a string
To: Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Achu Luma <ach.lumap@gmail.com> writes:
>
> > In a following commit we are going to port code from
> > "t/helper/test-sha256.c", t/helper/test-hash.c and "t/t0015-hash.sh" to
> > a new "t/unit-tests/t-hash.c" file using the recently added unit test
> > framework.
> >
> > To port code like: perl -e "$| =3D 1; print q{aaaaaaaaaa} for 1..100000=
;"
> > we are going to need a new strbuf_addstrings() function that repeatedly
> > adds the same string a number of times to a buffer.
>
> We do not need to call such a function "addstrings", though.  The
> name on the subject line made me expect a varargs function:
>
>  (bad)  strbuf_addstrings(&sb, "foo", "bar", "baz", NULL);
>
> It would have been clearer if the name hinted what it does, clearer
> than just a single "s" that says it is talking about plural.  What
> would be a good name that hints "n times add a single same string"?
> I dunno.
>
> I also would have expected that the order of parameters are
> repeat-count followed by what gets repeated.
>
> Having said all of the above, we already have "addchars" that is
> equally strange, so let's let it pass ;-).

Yeah, we thought about naming it strbuf_repeatstr() first, but then
seeing addchars() I thought it would be better to imitate it.

> > diff --git a/strbuf.c b/strbuf.c
> > index 7827178d8e..eb2b3299ce 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -302,6 +302,17 @@ void strbuf_add(struct strbuf *sb, const void *dat=
a, size_t len)
> >       strbuf_setlen(sb, sb->len + len);
> >  }
> >
> > +void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
> > +{
> > +     size_t len =3D strlen(s);
>
> Let's have a blank line here to separate decls from the first
> statement.

Yeah, right.

> > +     if (unsigned_mult_overflows(len, n))
> > +             die("you want to use way too much memory");
> > +     strbuf_grow(sb, len * n);
>
> The error message given by
>
>         strbuf_grow(sb, st_mult(len, n));
>
> would be equally informative and takes only a single line.

It seems that the pattern in strbuf.c, for example in strbuf_splice()
and strbuf_vinsertf(), is to do a check first using an *_overflows()
function, die if the check fails, and only then call strbuf_grow(). So
we did the same. I am fine with using your suggestion though.

> > +     for (size_t i =3D 0; i < n; i++)
> > +             memcpy(sb->buf + sb->len + len * i, s, len);
>
> Wouldn't it be sufficient to run strbuf_add() n times at this point,
> as we have already called strbuf_grow() to avoid repeated
> reallocation?

Unfortunately strbuf_add() calls strbuf_grow() itself which is not
needed as we have already called strbuf_grow() to avoid repeated
reallocation.

>  Repeated manual memcpy() that involves manual offset
> computation makes me nervous.

I would have prefered to avoid it too, but didn't find a good way to do it.

> > +     strbuf_setlen(sb, sb->len + len * n);
> > +}
