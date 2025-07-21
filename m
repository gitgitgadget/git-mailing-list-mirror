Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4522BE64B
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106976; cv=none; b=aVSb9NaAaru4M3+FTQLdwBPQ/X0g5EnS3C04lNhgLZ55ytCSEn/lKxua2NUb0YVRd7jjjygEPSgg39o/jkzPnkJR9g8CMyf9MAYvJmsAsNyu8YIAPmRCN/VgAdUVdX6ujO+XPgd13hwITiFZMx7yuxvXmnPk4yruiqDcr+ENvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106976; c=relaxed/simple;
	bh=n7BGlVu9vpG/IVLCp1zXebYXaVb0qgR5xwzrDr1ih00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU3fSpTT+VpiPbxVw1a0I9yxQA8rqHivLrwO5A+VRc5DdppjBvCGZmug/FYf+l8aqlWytzgyU2u5PcmNFcE59rJG85R1iC4tv/ysSXgbHNcI8fDrSen8skKAMZmemYWv0EzMB+Aty1CoJfVVF6QQlhqpgE3ENpJ41PO2FIo8XmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKpib4Rv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKpib4Rv"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so707569566b.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753106973; x=1753711773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m4p5e5mIV8mlfrYBCup2IdoHi4tAEGBqQr3F/z5fWU=;
        b=fKpib4Rv7Rl75iu6VIvdjyj/4/VdJ049z+bxZJ+ch4baujUpCNNz7oNWHKBWbPu99+
         jdSMLJsNRk3kiIUFFow2OEXKLx0yTUFfd9oVSWo6r3MBa1ATnH0GhKFed0/KZqv49F3P
         ArepiFCjTaWU4CicqVc8kOPP0n0W+GTax89qXQlEhpxzz/udzIGxQutU9pryVTCteBn0
         bBZ5xKm7M2bSTKqHKIWqThQNhZUl5yOvlbIVXBWIlsy5JyFwzqw/37BR3rBTDzrsxFUu
         f0CXEaELYDw9SI30fHHC1U14FYHD9yqbT5R4tu8CJ+rcyMwq1ZAn58dXhXEsMyQmKlDm
         ZNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106973; x=1753711773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m4p5e5mIV8mlfrYBCup2IdoHi4tAEGBqQr3F/z5fWU=;
        b=DiOb7lhUH1nGF590KSnHM2tssfO89CiXo/0Uddn05G25SUeLTCgX8Vjbaxec5dBwjo
         5VjEHgF1OooorOxOTj9wFzG0G4LV7KSATu4XdBiq5Pk4ZY25+XhKHTI72A9tUrRyYYX8
         cWu6gXaGmjZmjxYB31Q+U7byGq+IhAmSIyZ6SYtTT0Gp/e1J9wQk6Mtz4k3u2Y48M0NV
         KXDJQTFKuv/dygah3MMjrc5MuGqzuocFmq2xPxSdLUbHrpSzN8zzVCXsa8PA0vXyf7wx
         bIhSn+rzkQaWnnAgegx3HPze6wg9h6ECIFw4CU8flEWEj+vnBq2PAGtNNuOsjd3Abc0W
         t1iA==
X-Gm-Message-State: AOJu0Yz6EP+uQgApQ0UrFvKHczKlccJcB7mwqL3jHfvLbWTej8L6lNEw
	s507VUsvqts7JlJBl4gDHebQhrw1uuThZt8wX4XgA06AoggJ1Lvq3wpUhauqYG7n/NGblvoNoIo
	uYfSNv3ni9m68ZFd+JhGhUXpQc9waa4Q=
X-Gm-Gg: ASbGncvXswujoZXWLRb1VtEgQEMG7bHvxXONtxs3y3OwOJb0/Jqb6QRUBlnq0PdIxHh
	xsoEL3H4XIJ9NPtpZijd9dQUJIERiIkK4oBGLevreqNwjG4PTfkBzTgqdNtlwVIPyaVqTtlCz5O
	2KzBzroaJ8yGChyDAaM5LeAadx7W9sp2kpgnjPqkW78astAcqYg/TSeJ7oHQhK/J7HoV0Bk0e14
	fBBqInf4w==
X-Google-Smtp-Source: AGHT+IEQGHLPKoz04MhC/M+kW77Lyen0a4AsDygFEDHBFhg4Sj0LhAOYzcaTAynniebtFvvbhjpMEwZpjYQVhA2Ghp4=
X-Received: by 2002:a17:907:3e14:b0:ae3:6655:410f with SMTP id
 a640c23a62f3a-ae9cddaa601mr2315648366b.7.1753106972628; Mon, 21 Jul 2025
 07:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com> <20250625125055.1375596-3-christian.couder@gmail.com>
 <c49d73de-568a-4584-aa8f-9a9ffd68e4ce@free.fr>
In-Reply-To: <c49d73de-568a-4584-aa8f-9a9ffd68e4ce@free.fr>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 21 Jul 2025 16:09:19 +0200
X-Gm-Features: Ac12FXyOpfAsaW8D6W6PiizergL5RSEMBbW4m_rj1EDrhZNqeRubShud1rN16x8
Message-ID: <CAP8UFD1vZoSVnPK+wF2w0pb47JzWp8=hk9D4T_OcwGRR+m=qPg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] promisor-remote: allow a server to advertise more fields
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 8:48=E2=80=AFPM Jean-No=C3=ABl Avila <jn.avila@free=
.fr> wrote:
>
> Le 25/06/2025 =C3=A0 14:50, Christian Couder a =C3=A9crit :

> > +promisor.sendFields::
> > +     A comma or space separated list of additional remote related
> > +     field names. A server will send these field names and the
> > +     associated field values from its configuration when
> > +     advertising its promisor remotes using the "promisor-remote"
> > +     capability, see linkgit:gitprotocol-v2[5]. Currently, only the
> > +     "partialCloneFilter" and "token" field names are supported.
> > ++
> > +* "partialCloneFilter": contains the partial clone filter
> > +  used for the remote.
> > ++
> > +* "token": contains an authentication token for the remote.
> > ++
>
> This kind of text structure calls a description list instead and you can
> already use backquotes:
>
> `partialCloneFilter`:: contains the partial clone filter
> > +  used for the remote.
> > ++
> > +`token`:: contains an authentication token for the remote.

Thanks for the suggestion. I have used that in v6.

> > +When a field name is part of this list and a corresponding
> > +"remote.foo.<field name>" config variable is set on the server to a
>
> Please no space in placeholders: <field-name>
>
> > +non-empty value, then the field name and value will be sent when
> > +advertising the promisor remote "foo".
> > ++
> > +This list has no effect unless the "promisor.advertise" config
> > +variable is set to "true", and the "name" and "url" fields are always
> > +advertised regardless of this setting.
> > +
>
> More generally, I am a bit annoyed by the usage of the "will" auxiliary
> when not expressing a true future. For an international audience, this
> can be misleading. The plain language[1] philosophy mandates to not use
> auxiliaries other than where they are required (no convoluted sentences).

I have removed some usage of "will" in the patches in v6. I haven't
changed the existing documentation in this file though.

> Would it make sense to start a style guide to help writing consistent
> documentation that targets people whose first language is not English?
> Being an non native speaker, I often find our docs too literate, with
> lengthy sentences.
>
> [1] https://en.wikipedia.org/wiki/Plain_language

I think it's a separate discussion, and I am not sure I want to
participate in it.

> >  promisor.acceptFromServer::
> >       If set to "all", a client will accept all the promisor remotes
> >       a server might advertise using the "promisor-remote"
> > diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitproto=
col-v2.adoc
> > index 9a57005d77..0583fafa09 100644
> > --- a/Documentation/gitprotocol-v2.adoc
> > +++ b/Documentation/gitprotocol-v2.adoc
> > @@ -785,33 +785,59 @@ retrieving the header from a bundle at the indica=
ted URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > -promisor-remote=3D<pr-infos>
> > +promisor-remote=3D<pr-info>
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Be careful to adjust the length of the underline to the one of the title

I have adjusted it in v6. Thanks.

[...]

> > +After these mandatory fields, the server MAY advertise the following
> > +optional fields in any order:
> > +
> > +- "partialCloneFilter": The filter specification used by the remote.
> > +Clients can use this to determine if the remote's filtering strategy
> > +is compatible with their needs (e.g., checking if both use "blob:none"=
).
> > +It corresponds to the "remote.<name>.partialCloneFilter" config settin=
g.
> > +
> > +- "token": An authentication token that clients can use when
> > +connecting to the remote. It corresponds to the "remote.<name>.token"
> > +config setting.
> > +
>
> This list can be turned into a description list.

Done.

> > +No other fields are defined by the protocol at this time. Clients MUST
> > +ignore fields they don't recognize to allow for future protocol
> > +extensions.
> > +
> > +For now, the client can only use information transmitted through these
> > +fields to decide if it accepts the advertised promisor remote. In the
> > +future that information might be used for other purposes though.
> > +
> > +Field values MUST be urlencoded.
> > +
> > +If the client decides to use one or more promisor remotes the server
> > +advertised, it can reply with "promisor-remote=3D<pr-names>" where
> > +<pr-names> should be of the form:
> > +
> > +     pr-names =3D pr-name | pr-names ";" pr-names
>
> Here the syntax used is not compatible with synopsis. Would it make
> sense to uniformize it, or is BNF ok?

I am not sure what you call the "synopsis". Is it "promisor-remote=3D<pr-in=
fo>"?

If yes, then I think  "promisor-remote=3D<pr-names>" where

    pr-names =3D pr-name | pr-names ";" pr-name

(which is what I have currently) should be considered compatible. Or
do you have another suggestion?

Thanks for your review,
Christian.
