Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D03939A4
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200996; cv=pass; b=SbpVbr4wyuEszcVeVTut5mxeRRLrtnA5DMsWm5ZPN9P8xIEXQ3norGjynwFSDPf7bFJ5IGLx8sPdVNMLuwheJvLYKU+6eopSV3yRNq7hrLqHf2CoQCgyCZYbJlHBOmgxYrzCY70/lXFFFKaSeB8NZ2FGZ8m69SOSxrPo8dZaOeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200996; c=relaxed/simple;
	bh=DF8YKkEs4a3WY253Mrd5FQJJb02xK/2Je7va70shwZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAbw7nep51Rj38Us8Zqloshd4qqkO93EM0VQNCeiBNaLXwEqkvwyOOQn+5zZ5a0UG2FNV3DB4s+cQ9O8CKi00HnDbSdx7XzoDMZRlHQiFZJrkaJKX83ux5rZD6HDaOSfPqZtKD0NogxT9D9huH1guJ4bQSdGcxpoXGy2fZ4vIPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQlKWYj4; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQlKWYj4"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124899ee9d3so576118c88.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200995; cv=none;
        d=google.com; s=arc-20240605;
        b=ZARjDxdMVxMFUmnQouzyQwWq9O61JFC8pFsqbaRfsVHEsNgma8NiMYJ48NpLszMy0j
         u0cfGnfIFR+qcHNSeEz0RKH658iKip1AYHJi7WXLV+jgNVhLTUOT6nzOO7LUSQWS9m03
         b5UG7Dui+E5hC9+SPf0/ArJOIRiWQMA8Etr6HvcdPWjbT49SYmaUpGlLOn50si/9X4qV
         NL36TjE2JpyUGGLMPxLyFCwwkQNFKUNoZ8cVNsQk6eArk45pJ/HXv8GAv7AApjlnJri3
         bIMxamaSSv4lhJ72TLyGMGvNEI7TcmN2ESowBOeZeQEdL2ZhPbGk8Mwq3BIWHeMx2XzP
         c5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=orvGgqftwGRFZahGcWI0xpq6B+6HQaSNtDzYeOFacgU=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=QdY5othVrMDM+J/rM7Z1iRQa/cs4OPaIPX6mhlAFATR0/McVwQWZAB1ThNeZk5N5Sv
         9tDwRXcscvtvu/HKoBNzjXA2wAue6vePbOibg+JWqSqDZHsqcY4o6ugfYZeSZJZRS05e
         O0A2WgwmB35wzAJ/6eRYKkxDBN2GiZqtq1ymIvPR7/vVBqoNycPCn86/eUvchWH6oklu
         Zc5pgPvg1zdFyWP0+WXBYwXIIBm+Hl8YYfx4EXQ+V/bFDEy2FUMgiJMpPe7Xhqu8cSGs
         6IRFBoqwc2qysvtPXpreU5JVntlFy0wR9xVQFTJTP/6QYOxmJVz2XaUj86f3nRFW7jSH
         tprw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200995; x=1770805795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orvGgqftwGRFZahGcWI0xpq6B+6HQaSNtDzYeOFacgU=;
        b=JQlKWYj4xitiYUlmmnrj46A3zuLBgYoRipug1LF+HEEvp2eJoT1f/+hxm0UVNUcpqK
         gPUz9q0TA8/r++0qOyX5/HWSNTGtn/STr7vzjwn761Wd1GTOH+VKM9gPj8EGmWSRWmev
         VyT6XxuE0i3NwKtoKKg0xDTHpoAWQ/G727qX/TPGG4sZblb5CbAeXkn7NciAT0DIWwud
         Q9+zsV+g5WvfZrHRmmHE6mExdfW+vQUGA+2dvwdT7tv9cS9ejXeq0jLm16chVP3398lk
         S2E1TWi0u9DwqmJum3Tma2jR1EE56cff+zKFP5ie7rMr02flBPVN94jwUh331Q7n7Oyu
         dK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200995; x=1770805795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=orvGgqftwGRFZahGcWI0xpq6B+6HQaSNtDzYeOFacgU=;
        b=FxGpML9ScEripabJxWbl0Qqq85ui/fv1n88DXBTBlrz5vRVpuw1pTebqdFhr0p6S7H
         fVGnUUEHb/gxNUbpotY0rkeS6ZXVEMA97lEPWsGQuhVTOkkuTptVsImyft5Oo6dD5LK4
         4ulN8dsERaAr48+51AN1R7t0yNjq9U2SBZUX05rRUr2IB+N1gnCqVdBp3u94A/F5M7YC
         mQs98SPK8NfCuiz1zmyOxOkQpXeBRW+mzdSHzgLzV6rZ9b4UDwSEvhZ7DNIhB020RVh0
         +yWEHiAs7WbyqFErnSe3ECfTEPxrIGbp43Kf9qdLxmsktbdpCot9kjmoiyEkIwqexf+e
         o+gw==
X-Gm-Message-State: AOJu0YwvakiC9pjz8KS6/jJswPlu/9ibxSDdK9aRJAM8x0LNRhuPhuHi
	UYxrTRINysL0gVWZG2GDzHactRj1gR82oEaXS311P8TiZSTws30QNtf0hd4F581dqtKn1XnFV7m
	lhMePkFX6N+7EgZr6xmLVuUuCpxp6V0Q=
X-Gm-Gg: AZuq6aJ81WOPzBoD2/7sZi5lsm8A2jppAouAC69U66bTI0Z3LyjtxTpA/jkXtF9bAjk
	XNH5awByxns1ClCYRWBEW7YYgdVhAMHHe8PEpQ/nastzXQCKgF1k5TJOfXQeuDUJbZO8dh7vUza
	mX3i0XdyCZm9YmUZlMrawrvJiQQFdNV6ec5q965wt+wmP6D0f3ZMLTqw+AQGW9wKnxFxXHd5n6C
	rO3c4LM9Vr5tdAJpLwBluleR4w92ElAUwfo1cOBDxKJXb+HZBBrhK1d49OZVA0IedTKhXJi805s
	q8WUKXQkTs9+JRvwI+YVdC1B5PAEem9IvNJN3LRfOjO0WedwhqcKtKHg
X-Received: by 2002:a05:7022:2524:b0:124:9acd:2d1e with SMTP id
 a92af1059eb24-126f48ec029mr971940c88.23.1770200995172; Wed, 04 Feb 2026
 02:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-8-christian.couder@gmail.com> <aV4v8HCe6CLqXJ-1@pks.im>
In-Reply-To: <aV4v8HCe6CLqXJ-1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 4 Feb 2026 11:29:43 +0100
X-Gm-Features: AZwV_QhD1ZVVpV9dPwvyd1JHHv28dVoqVghsa36Buzix-vw-OTDICdy710ngLnU
Message-ID: <CAP8UFD0iBxn6cPFKLAkSW7O3To1ago60MWYwV7YxjxOVxni1Kw@mail.gmail.com>
Subject: Re: [PATCH 7/9] list-objects-filter-options: implement auto filter resolution
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Dec 23, 2025 at 12:11:11PM +0100, Christian Couder wrote:
> > In a following commit, we will need to aggregate filters from multiple
> > accepted promisor remotes into a single filter.
>
> Ah, interesting. I was always operating under the assumption that when
> the server advertises multiple promisors, the client will pick only one
> of them. And that made me wonder how the client knows which one to pick
> in the first place.
>
> But of course it's possible to just pick _all_ of them by combining the
> filter.

Yeah, that's the idea.

> > diff --git a/list-objects-filter-options.c b/list-objects-filter-option=
s.c
> > index f13ae5caeb..4a9c1991c1 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> > @@ -230,6 +230,41 @@ static void filter_spec_append_urlencode(
> >                    filter->filter_spec.buf + orig_len);
> >  }
> >
> > +char *list_objects_filter_combine(const struct string_list *specs)
> > +{
> > +     struct strbuf buf =3D STRBUF_INIT;
> > +
> > +     if (!specs->nr)
> > +             return NULL;
> > +
> > +     if (specs->nr =3D=3D 1)
> > +             return xstrdup(specs->items[0].string);
> > +
> > +     strbuf_addstr(&buf, "combine:");
> > +
> > +     for (size_t i =3D 0; i < specs->nr; i++) {
> > +             const char *spec =3D specs->items[i].string;
> > +             if (i > 0)
> > +                     strbuf_addch(&buf, '+');
> > +
> > +             strbuf_addstr_urlencode(&buf, spec, allow_unencoded);
>
> Shouldn't we use `filter_spec_append_urlencode()` to do this?

Yeah, probably, see below.

> > +     }
> > +
> > +     return strbuf_detach(&buf, NULL);
> > +}
>
> I'm surprised we didn't have such a function yet.

I have refactored the code so that we use a temporary `struct
list_objects_filter_options` and `gently_parse_list_objects_filter()`
to construct a combined filter in the next commit instead of this
function.

This also takes care of your comment above about
`strbuf_addstr_urlencode()` vs `filter_spec_append_urlencode()`.

> > +void list_objects_filter_resolve_auto(struct list_objects_filter_optio=
ns *filter_options,
> > +     char *new_filter, struct strbuf *errbuf)
> > +{
> > +     if (filter_options->choice !=3D LOFC_AUTO)
> > +             return;
>
> I wonder whether we should rather `BUG()` in case the filter is not an
> "auto" filter. Otherwise it's easy to get the callsite wrong, as the
> user may expect that the filter gets resolved tdo the new filter, but
> it's actually not because the original filter wasn't an "auto" filter in
> the first place.

Actually the list_objects_filter_resolve_auto() function is not very
useful, so I have just removed it too in the v2 I will send.

This way this whole patch is not necessary and has been removed in v2.

> > +     list_objects_filter_release(filter_options);
> > +
> > +     if (new_filter)
> > +             gently_parse_list_objects_filter(filter_options, new_filt=
er, errbuf);
> > +}
>
> So as menitoned in a preceding commit `list_objects_filter_release()`,
> will retain the `allow_auto` option. But when resolving "auto" filters
> I'd expect us to not accept "auto" in the resolved filter anymore.
> Otherwise, if `new_filter` was "auto", we'd still end up with an auto
> filter, wouldn't we? I'd rather expect us to abort in that case.

Right, I have fixed this by adding the following in the next commit:

         /* The result of resolving an 'auto' filter must not be 'auto' */
         args->filter_options.allow_auto_filter =3D 0;

Thanks!
