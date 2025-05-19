Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301020110B
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663832; cv=none; b=c3XB537mewnMOeivLUunevsNUAN9qBIoJ9QHM050JZnRE9MVsykfdXYIpCmVwjubmB7khXt9hi3ksg3BWWEx7b5+5e282nnVqsOEaN8Iq0mCbQn/ZvqhGnr2QnRQtYF9B0PyqlKuw7B2gS6mvZbrt85bFwgrPBSeOC1mv18Cqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663832; c=relaxed/simple;
	bh=dV33bXtxvz8K7Li9wzD41LUiKyqK3ZILYxboldH11ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po7uaBegYl3AVRFMxpQQKjVz1JdoUK+r8rjdXg0cRKGKT0Nw6qqSouGuIJTO/5wsfQDmLM8ZxVtDCGn2RtHjDzO3Hk2TLum2/OUPy/CxpCOHwYhzDWco+VcsOK/uqrzEovcw9aKujUPvyOuL4+wEHMUQtMxRcFgU+BOG1rtoD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB87osjI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB87osjI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so758487866b.1
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663829; x=1748268629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dK2VBvRHGfKdh90Y34yINDGuf3MnQv+1AuoQUIUH0s=;
        b=dB87osjI27OpD5sIK27AltRSm9bLXGBl5SQZLG1gDMTRreAQ+UInDBusaNdtvth6++
         iMG3171bGpmt+fG/JX8vaUpHOhUi5UtoV72MIC2Op9U/YllZIyjBDZVnMgr5p62jXG17
         e/vPiqj2W5jBXUa7iMJfoAYTgEfXuj6Il4xJYxhqGtUML7BTTHwigemv0f6Q8m1nqJNF
         uc9ZK+PBL/Sh6SpWlidSTauvwh5MYiLAKxHao4zPWeiqUApK1Q7IBFH4/of++BVaH4tM
         cL44NSnGKKvIIs2veLeujdLKFoIWT9Qb95j2pmyIwb2aJQ46EWIA3gV3RnSL5WdmZFtQ
         kWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663829; x=1748268629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dK2VBvRHGfKdh90Y34yINDGuf3MnQv+1AuoQUIUH0s=;
        b=HhSVVQU+9puiqYM1x8B18AxM/O9SepMTaOnsT+68LoqZkBlNxVlz2qaimoz2qTgA1T
         6lQBurhY63cC9/FjhRTY0wsgpLvOPw/IRCd3YUhGe3xi0+Ax+jma1+fL1IvuHN1ePkUK
         VDgMhcuTReyFoHxvCXzpN3cdBkjY+1afTyTUL6kFy3ToOmYjCTgofSJuqHcDGGJ0k2GY
         uBZN8NxX8Wr7ox+2CBP8x5kHAINFEDEH6Dl6fsEAfi0qgsCHNVIt7ukw+ne75k0Ddb6k
         Qzw1UO1Neu62u0YS9HXzXovyd4RTUnohM+EskLaLbMJsdazCbk9e+RGnk6DwwUJryaus
         dzsA==
X-Gm-Message-State: AOJu0Yyh/GKmbaakOE5Smo+XEcGAYQ0t/beFrS3paYY1FeX9HrzM9p+2
	t+j8OPeC/Bn1Wp7tT8PZkFq+251SD7eMhs+oSb8yOo2iaEfqsKobxTCMYWMmXrTLyS6DIo85X00
	FxTlA6xcuyYPQgT3Uy4bUSOTnFPoE7hg=
X-Gm-Gg: ASbGncuo2OnX8gZvxxxLuJE7XYfdG9XmuISmzeJQQUPsokN4u0fVYrcnsups/BSWwbl
	NfzT///rh6pZFLjFAYN2hu2A6feMhDXctDTD3SA84VpVYeB2B4KdY/rxVzFnW3JdqLtdgyf7Znw
	tVZUO5YfPs2uLIz2Y/FiLahBeagYo7DI6078k=
X-Google-Smtp-Source: AGHT+IFOD7fJf1GafxguXIDtoZUOk76HB+T9idwYSaS4SXs++gvj/r5JhOewHj+THb4Qj9sb9/baeb7b40Ch6fTXbKc=
X-Received: by 2002:a17:906:3402:b0:ad4:d136:ede7 with SMTP id
 a640c23a62f3a-ad536b7c504mr812375866b.19.1747663828925; Mon, 19 May 2025
 07:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-2-christian.couder@gmail.com>
 <aBsZAKmaA_uGPgk2@pks.im>
In-Reply-To: <aBsZAKmaA_uGPgk2@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 May 2025 16:10:16 +0200
X-Gm-Features: AX0GCFtNGp10Zil3RfKhdjkcdIiReSOASlGxzh274zFu0nzmCe_xt3jQL5EUTOY
Message-ID: <CAP8UFD0c+LfCoHzvMyGYkmNmFd4PApEgmt65-TzLBvdap3LvdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] promisor-remote: refactor to get rid of 'struct strvec'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Apr 29, 2025 at 04:52:41PM +0200, Christian Couder wrote:

> > +/*
> > + * Linked list for promisor remotes involved in the "promisor-remote"
> > + * protocol capability.
> > + *
> > + * 'fields' contains a defined set of field name/value pairs for
> > + * each promisor remote. Field names are stored in the 'string'
> > + * member, and values in the 'util' member.
> > + *
> > + * Currently supported field names:
> > + * - "name": The name of the promisor remote.
> > + * - "url": The URL of the promisor remote.
> > + *
> > + * Except for "name", each "<field_name>/<field_value>" pair should
> > + * correspond to a "remote.<name>.<field_name>" config variable set to
> > + * <field_value> where "<name>" is a promisor remote name.
> > + *
> > + * 'fields' should not be sorted, as we will rely on the order we put
> > + * things into it. So, for example, 'string_list_append()' should be
> > + * used instead of 'string_list_insert()'.
> > + */
> > +struct promisor_info {
> > +     struct promisor_info *next;
> > +     struct string_list fields;
>
> Now that we have a restricted set of accepted fields, wouldn't it be
> easier to store those as individual members of this struct directly?

I have done so in the v3. The struct now looks like this at the end of
the series:

struct promisor_info {
    struct promisor_info *next;
    const char *name;
    const char *url;
    const char *filter;
    const char *token;
};

> [snip]
> >  /*
> > - * Find first index of 'nicks' where there is 'nick'. 'nick' is
> > - * compared case sensitively to the strings in 'nicks'. If not found
> > - * 'nicks->nr' is returned.
> > + * Find first element of 'p' where the 'name' field is 'nick'. 'nick'
> > + * is compared case sensitively to the strings in 'p'. If not found
> > + * NULL is returned.
> >   */
> > -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
> > +static struct promisor_info *remote_nick_find(struct promisor_info *p,=
 const char *nick)
> >  {
> > -     for (size_t i =3D 0; i < nicks->nr; i++)
> > -             if (!strcmp(nicks->v[i], nick))
> > -                     return i;
> > -     return nicks->nr;
> > +     for (; p; p =3D p->next) {
> > +             if (strcmp(p->fields.items[0].string, "name"))
> > +                     BUG("First field of promisor info should be 'name=
', but was '%s'.",
> > +                         p->fields.items[0].string);
> > +             if (!strcmp(p->fields.items[0].util, nick))
> > +                     return p;
> > +     }
> > +     return NULL;
> >  }
> >
> >  enum accept_promisor {
>
> If so, we could also simplify code like this because we wouldn't have to
> assume any indices anymore.

Yeah, it simplifies things, but on the other hand in some places the
fields cannot be handled in a generic way, so we have things like:

        if (!strcmp(elem, promisor_field_name))
            info->name =3D value;
        else if (!strcmp(elem, promisor_field_url))
            info->url =3D value;
        else if (!strcasecmp(elem, promisor_field_filter))
            info->filter =3D value;
        else if (!strcasecmp(elem, promisor_field_token))
            info->token =3D value;

Anyway I think that it's not too bad.
