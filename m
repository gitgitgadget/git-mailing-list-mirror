Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E702772D
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763188423; cv=none; b=f6//sRKD/A7vQp4e95SAFGvqwwOr9lzkeXf4xTGp2MdfGhQwY1Bz0YRxCI834WJIL9FE+6qh+hoAhZNDOxEWSRXo4C2QILgZUl+TcAjqQF6/D4omZjb45S7gOJvIEDIFhN0jVgO1DZ0xpmjifx9nhcnogaOt2m9zUL73XlnzjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763188423; c=relaxed/simple;
	bh=MYrMe0I0hpriEkZVWcqiRk2d4bVjhH3dkngDWTsCHO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9iXcU+1oyA5bBIY9goqksNh0BApf4YPesM6WvEpAljk9pkMfQSeLRqwcgTBpYZjBjEesS9bCzlik8T2MtXaAAYicwK4Anisw1UV/jWPjArYLCOeiMMmw5015a5S66KUeLhuWGq6XDsrDTMra/gNLKV312s9K8uCGLOvo86aMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNZOuIP9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNZOuIP9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7355f6ef12so429100466b.3
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763188420; x=1763793220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfJwRO/a29mbMYZt/xEzeUyz2hhfKwRG8gIqwatcfYU=;
        b=VNZOuIP9Tk3NKkaOcnY8hLGhdrQxkPJYctrhG4zwNR/+D6APV02UWCXTuLr5mI/Lo8
         zIlWqFiX+rpfcBfvovxwVWf191V8YKqimVvoHZfhy83qHJeWdrWHLdKwCEfbO5s2XLeY
         Ic5p/U+e8GvkohRwfKhlL6IgEhjuoHrsxN8thl8ykmnTolYEhJ5FDz/axgleZcrdkJMs
         k7zfXZAQoRmzNXGDNLf0bvkKxzjAJqpGaMGHAdBHpkRtyWtGGqR29ho+UrfJgG6ZYAt1
         PycIHSlp6HYYeWNu07kScI4nAiOZw1kxkNLPfZEY9fVthgiqo+4NEQtuXGDowA+brYFQ
         j5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763188420; x=1763793220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xfJwRO/a29mbMYZt/xEzeUyz2hhfKwRG8gIqwatcfYU=;
        b=mz4UvmfF4/7dO6GhzOvWLG/SfW2jJpMbav/IML9k9NUfTosRCsyoVrbNMwBX3NvSpD
         LBoZWTCMg9Wz3i81G3qCcMFiK0rSIyaByTjXF9A7b9M02B2EqDIteo63iHLjTCCVNWvb
         kPZjwiX7Y5I+Opqkbr376DlnK9yQSSfd0aHnYTXAEs/iPCEPxVQjxfdZ8bmu4Cx9k5wA
         8yGTzulAGyn6YluSqhJjt0mXLuhwm3SQP7lCSdZoYS+iJr+0/h6R2xdh7ghmAK4I/wQK
         4QZYlV/QvbPMl81FSELKggP1v6y6R8XGbf0hlU39sMSo+gwnwT9kNzuVwp80Ih0UeDWS
         BqMA==
X-Forwarded-Encrypted: i=1; AJvYcCVbbnwksLKO2z1YnxgUo/c3n/9BOLb4h0DXRmyTBCy5dQqJ1G2MwWuVlWS7egum1SdxNyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquI68a1ZjFgqqCESJKI4XDL13jU0MsBEVqMopvd2zqnuzMOl8
	osQ/tABG29+NhP4KZul5UvunHWVRWo1HbgCPvDGNfP35kxLdZnQ/XUqGmjrbg+qQBnKjoWI2zYw
	/iRTStQdF9VpfI2SzQe4edxrTEd78qSo=
X-Gm-Gg: ASbGnctoWnLi8f/xN39TwkxHW0nsM0Vak+mmCsZKURYBb8fAFnDsPSktKzQCr364dGq
	FoWV+04XkDUFLwUdKlC4XheFEAbrFtDsvnKCFhW3KuxwA4IWQL9CNGpbvBDAYR5YB0VTTXbHz7S
	Q8HZrkYCcIOxfhwYfXXP1kOF4k6wZjWH3a93i9zVIQA6OhgGqT/4uC0DRUJ3xxZVYQ7fwMEdvtS
	mIAu+hcc6WYgAofowxSprlJTrT1K6w1ylH/0FcTsdYeSYe1wHIL9NEVS3CCXohpF3hM5Glyz0GL
	Eus/dCRBPIcNlxWNtY6STJrF2XNfNNou+Q==
X-Google-Smtp-Source: AGHT+IFCXb3nuZf+J/HuLvdszcVM8kdfvZzb6kqZJIQM7MPxxRUSiZvRmsGhMBiK5ZUt5xkDuVttCCISfanwRL6ZCUY=
X-Received: by 2002:a17:907:26c5:b0:b72:ddfd:bca7 with SMTP id
 a640c23a62f3a-b7367b8db06mr517932066b.35.1763188419657; Fri, 14 Nov 2025
 22:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com>
 <pull.1997.v3.git.1762966535495.gitgitgadget@gmail.com> <xmqqfrajqdv0.fsf@gitster.g>
In-Reply-To: <xmqqfrajqdv0.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Sat, 15 Nov 2025 14:33:28 +0800
X-Gm-Features: AWmQ_bngmmBBQz81nZvR_fy0TJUXqbafLgxHLFLouj6Mp6yuciCnCy7zx5C_SSU
Message-ID: <CAOLTT8SfLGnov2ZT5s7fz+DiN0fW-VFjFDVzv0J5GuwevMX2Kw@mail.gmail.com>
Subject: Re: [PATCH v3] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:56=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +`--committer=3D<committer>`::
> > +     Override the committer for the commit. Specify an explicit commit=
ter using the
>
> Isn't "set" or "use" more appropirate verb to use here?
>
> We already take the committer identity from multiple plases, like
> user.{name,email}, or GIT_COMMITTER_{NAME,EMAIL} configuration, and
> with the patch we also take it from a command line option, with the
> usual precedence order (i.e., command line trumps environment which
> trumps configuration).
>

Since both `--author=3D<author>` and `--date=3D<date>` use the
"Override the *" phrasing,  `--committer` uses "Override the" just
to maintain consistency, though changing it to "Set the" would
also be acceptable.

> > -static void determine_author_info(struct strbuf *author_ident)
> > +static void determine_identity(struct strbuf *ident_str, int is_author=
)
>
> "is_author" does not sound grammatical for this case; if you are
> giving an ident of an unknown kind to this function and supplying
> another parameter to let it know which kind, "is_author" may make
> sense, but not here.
>
> As you will convert it into WANT_{AUTHOR,COMMITTER}_IDENT before
> using anyway, why not let the caller use the "enum want_ident" to
> tell this function what to do?
>

Ok, will change.

> >  {
> >       char *name, *email, *date;
> > -     struct ident_split author;
> > -
> > -     name =3D xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
> > -     email =3D xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
> > -     date =3D xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
> > -
> > -     if (author_message) {
> > -             struct ident_split ident;
> > +     struct ident_split ident;
> > +     const char *env_name =3D is_author ? "GIT_AUTHOR_NAME" : "GIT_COM=
MITTER_NAME";
> > +     const char *env_email =3D is_author ? "GIT_AUTHOR_EMAIL" : "GIT_C=
OMMITTER_EMAIL";
> > +     const char *env_date =3D is_author ? "GIT_AUTHOR_DATE" : "GIT_COM=
MITTER_DATE";
> > +     const char *force_ident =3D is_author ? force_author : force_comm=
itter;
> > +     const char *param_name =3D is_author ? "--author" : "--committer"=
;
> > +     int ident_flag =3D is_author ? WANT_AUTHOR_IDENT : WANT_COMMITTER=
_IDENT;
> > +
> > +     name =3D xstrdup_or_null(getenv(env_name));
> > +     email =3D xstrdup_or_null(getenv(env_email));
> > +     date =3D xstrdup_or_null(getenv(env_date));
> > +
> > +     if (is_author && author_message) {
> > +             struct ident_split msg_ident;
> >               size_t len;
> >               const char *a;
> >
> >               a =3D find_commit_header(author_message_buffer, "author",=
 &len);
> >               if (!a)
> >                       die(_("commit '%s' lacks author header"), author_=
message);
> > -             if (split_ident_line(&ident, a, len) < 0)
> > +             if (split_ident_line(&msg_ident, a, len) < 0)
> >                       die(_("commit '%s' has malformed author line"), a=
uthor_message);
> >
> > -             set_ident_var(&name, xmemdupz(ident.name_begin, ident.nam=
e_end - ident.name_begin));
> > -             set_ident_var(&email, xmemdupz(ident.mail_begin, ident.ma=
il_end - ident.mail_begin));
> > +             set_ident_var(&name, xmemdupz(msg_ident.name_begin, msg_i=
dent.name_end - msg_ident.name_begin));
> > +             set_ident_var(&email, xmemdupz(msg_ident.mail_begin, msg_=
ident.mail_end - msg_ident.mail_begin));
> >
> > -             if (ident.date_begin) {
> > +             if (msg_ident.date_begin) {
> >                       struct strbuf date_buf =3D STRBUF_INIT;
> >                       strbuf_addch(&date_buf, '@');
> > -                     strbuf_add(&date_buf, ident.date_begin, ident.dat=
e_end - ident.date_begin);
> > +                     strbuf_add(&date_buf, msg_ident.date_begin, msg_i=
dent.date_end - msg_ident.date_begin);
> >                       strbuf_addch(&date_buf, ' ');
> > -                     strbuf_add(&date_buf, ident.tz_begin, ident.tz_en=
d - ident.tz_begin);
> > +                     strbuf_add(&date_buf, msg_ident.tz_begin, msg_ide=
nt.tz_end - msg_ident.tz_begin);
> >                       set_ident_var(&date, strbuf_detach(&date_buf, NUL=
L));
> >               }
> >       }
>
> The helper tries to be generic between both kinds of ident, but we
> still need conditional that says "this part of the function is only
> when we are looking for author", which is rather unsatisfactory.
>

Indeed, some specific logic should be moved to
determine_author_info()/determine_committer_info().

> Also why do we need this much patch noise, only because you renamed
> one variable?  I wonder if it would make it cleaner to move the body
> of this if() {} statement into a separate helper function, leaving
> only
>
>         if (whose_ident =3D=3D WANT_AUTHOR_IDENT)
>                 set_author_from_message(&name, &email, &date);
>

Ok.

> or something simple here?
