Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457851DA31
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgRXX3UV"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dde173384aso2248708a34.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 22:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705039954; x=1705644754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHVRlzAmOfPxeWoPqHvljG/8fXfHQyz7Di/gB6SOXwE=;
        b=wgRXX3UVP1mCTI4Z1Nn91n0+YKAglUh3Dyf1toE+tb7ChUfTAlDXPm3HVZET2ZBJZV
         p72EWS3RnE8aHo+NRqhZWDbRtf8f4Bz/CAXPlZmLpg6tMI1Te51Kgv0+hGFCtQvaXsR0
         Xa3ehmIDF9sMMMn1Lt4oLo79Zi/4oN4Lo9rmh7y+RWh2ju4fJWktKMSIVKU4FnPhtucS
         qj+dfNOxKhAdt6xMyY+zw4ZUZmb2NxyE/fXiAsaA6L+9WJP8ScyvPxCfkZ9iBngi7Q3t
         Ke/6vSeIP6Eohg6xCgmCM4FGKTqRT2BEJxeSxXOnOCIrOY7VbZyTfZYOKJO4JJ2A1bO3
         P4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705039954; x=1705644754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHVRlzAmOfPxeWoPqHvljG/8fXfHQyz7Di/gB6SOXwE=;
        b=f8mPo9SXUhp9Pc/ksndJdG5X29fDcrgY9BLz0tZsvgdpCBVKQKzyat0Qrdlc6Pf4Fk
         WGxUNnk6GtYEOEDq30gzgx99Z1ls2usxOosLN/toqdaxMdC+dyhvE9NGfywZ45SDlI8B
         W1goBMpKgH7QlHR+S0OIL4vTSd09I34zGBijfh/c5RBrmWGTWFlx3yuMV8+FuRhm970d
         9XFAZfuuBUb+hXMryAVzhBateWjJRp5LZ4v1WdwPu+28Lg8hVshwVDUpyfd3V8IK6Gm6
         dVZdCnhWYV9WxvzgcuZ3/eq7hn3W/8NxO0pwzkS4CXBzQqmApemWeuKN0DR9QYncJB66
         f7GA==
X-Gm-Message-State: AOJu0YzwJLlJ7YZ4sD68x3tVrnrnwyzyc+pJPr4WPIvkNZDTVRVYC+Ih
	XaykxDwrGXD6Duq003faW+DdvzSYMTWiXtmxpgfIremPbWzM
X-Google-Smtp-Source: AGHT+IFqiQw9hEWaPb3sUpe5xWsYt+HuL7PArSUR3C7zMphjyv8IaxQNOAT0HX3FSE6k+j6kDzjEMqm8MclFvNa2VYg=
X-Received: by 2002:a05:6871:798c:b0:1fb:1b2:fc93 with SMTP id
 pb12-20020a056871798c00b001fb01b2fc93mr1107570oac.22.1705039954021; Thu, 11
 Jan 2024 22:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqttpmtnn5.fsf@gitster.g> <20231116054437.2343549-1-jojwang@google.com>
 <xmqqsf56ql14.fsf@gitster.g> <xmqqil62qfvr.fsf@gitster.g> <CAMmZTi-U_ufzoBLCDWKbrf=3GZzGszxnM1_Pu6ufBeoYjj7Gdw@mail.gmail.com>
 <xmqqedfrovsb.fsf@gitster.g> <xmqq5y0ssknj.fsf@gitster.g>
In-Reply-To: <xmqq5y0ssknj.fsf@gitster.g>
From: Joanna Wang <jojwang@google.com>
Date: Fri, 12 Jan 2024 14:12:21 +0800
Message-ID: <CAMmZTi_W6Di3xQnEuiVYc+eL8pOPbqnoJm_OuhwLQ6vLVy=PLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I was out all month.) Thank you for the additional fixes.


On Thu, Dec 21, 2023 at 4:07=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > The attached is one possible way to plug the leak; I am not sure if
> > it is the best one, though.  One thing I like about the solution is
> > that the approach makes sure that the mode attributes we would ever
> > return are very tightly controlled and does not allow a buggy code
> > to come up with "mode" to be passed to this new helper function to
> > pass random and unsupported mode bits without triggering the BUG().
> >
> >  attr.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
>
> Anybody who want to propose a better leakfix (we cannot afford to do
> with UNLEAK() as the number of leaked mode string will be unbounded)?
>
> Otherwise, I'll squash it in to Jonanna's patch and merge it down to
> 'next'.
>
> Thanks.
>
> > diff --git c/attr.c w/attr.c
> > index b03c20f768..679e42258c 100644
> > --- c/attr.c
> > +++ w/attr.c
> > @@ -1250,10 +1250,34 @@ static struct object_id *default_attr_source(vo=
id)
> >       return &attr_source;
> >  }
> >
> > +static const char *interned_mode_string(unsigned int mode)
> > +{
> > +     static struct {
> > +             unsigned int val;
> > +             char str[7];
> > +     } mode_string[] =3D {
> > +             { .val =3D 0040000 },
> > +             { .val =3D 0100644 },
> > +             { .val =3D 0100755 },
> > +             { .val =3D 0120000 },
> > +             { .val =3D 0160000 },
> > +     };
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(mode_string); i++) {
> > +             if (mode_string[i].val !=3D mode)
> > +                     continue;
> > +             if (!*mode_string[i].str)
> > +                     snprintf(mode_string[i].str, sizeof(mode_string[i=
].str),
> > +                              "%06o", mode);
> > +             return mode_string[i].str;
> > +     }
> > +     BUG("Unsupported mode 0%o", mode);
> > +}
> > +
> >  static const char *builtin_object_mode_attr(struct index_state *istate=
, const char *path)
> >  {
> >       unsigned int mode;
> > -     struct strbuf sb =3D STRBUF_INIT;
> >
> >       if (direction =3D=3D GIT_ATTR_CHECKIN) {
> >               struct object_id oid;
> > @@ -1287,8 +1311,8 @@ static const char *builtin_object_mode_attr(struc=
t index_state *istate, const ch
> >               else
> >                       return ATTR__UNSET;
> >       }
> > -     strbuf_addf(&sb, "%06o", mode);
> > -     return strbuf_detach(&sb, NULL);
> > +
> > +     return interned_mode_string(mode);
> >  }
> >
> >
