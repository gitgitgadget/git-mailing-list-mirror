Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EC38F9C
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 05:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774761840; cv=pass; b=B08sM7cPrrg0pP9ZubrGrT1Mwef9YExGbnzO+ksTqmnGLXN013eB1eC/u0ocHR3fz3ZIGAMRCcQCNjj4SnBm0+MlsaRkk7mVS4Dtq//r75T6N3omgg7+C5ZWhznmUH99OaWNtgUC8NZMgyppT0ySjhRBcuS8+LjouY45tA+Uhs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774761840; c=relaxed/simple;
	bh=IgiH+/4ud1OiYcKwbuw1d1fr4J1a9kuYskviy/r+6V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKSuP5aNQ+xlQr1n+opXJx+LmiB6rMLfohUs4F3MqDItI+ibRXe2i1k4h1UopTL4H+s70WRjpdDVFu8ZS26jaw8dPP58EWB/eylJnOoDDsgAgft52EDrlzouTmJO0lfxb8adQV4ekQ5SawGPXuLyNk2uDAOwlX/scbLJncUFUk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12714f01940so268191c88.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 22:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774761838; cv=none;
        d=google.com; s=arc-20240605;
        b=RRTuFenMOT6JT1bLJjw3ewyCj+wZAzQ3RMYXlhZbQuE500UNmINPFk7IWGAlGrL4My
         hDp7OVnrucbcTAzQAl+i5Zohqo3/di3PFrjHukE3dLevrF+HosfFDvdgm6tZF9kJzMzX
         aj6hXR1xueqfek+daltvH1imZ629iybxjRqLbGJE2rqoJl2bBEEZRjh9bvc00KRR8GAH
         Wb4QcNCgG1govkBe1omqjFf18wpc8OUuYjTJwz43fFOVdbFkJAneHezDLbWDmy/JVrjk
         Gth4Zh8/31gKKSDyrR+HnseVXTT0KWlhd1IszNWOFqa8Y5rRJB5aoqcyZr9BUkOGi+hH
         hBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Sb0RnyzqvFeUqkuvw1ZJ2VaPgJoH4dSapsrj2kkJhXA=;
        fh=t8YpH709c3wSibd8BcbrKw+BLNNwQB+E/lqdyjFu22U=;
        b=dQ0JR+z9maCF//syytpQ1RhLd+3jfhBIZIX5TG/ATIeSI3AgCgB0iKRkBAXx0VVCti
         e9+SfPNE+EMKqpzrurGVIFayIUzqqwFIfxU43sAoslGnjhLpnB2xP4Dq2NJHc3e8wLAs
         zb/XcWB3L0upjXY3SAkM39YgmSv+jD4ZErkKdIicpAsPs/LMxzDyTM9uNHfNIuiRynND
         KLrpe7j+eNI4jUALmimWP0ev0BPe5Hq5YGWteJ/WVBzhYL5EHG502ei5Qt1jZ+ikoqZK
         SMdXSbL6aIqyXHDE91JTX38enZDePwVHXgjIPrvfJfxgJLZ6YJAGD6O1/prRLkgcE4Vy
         apIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774761838; x=1775366638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sb0RnyzqvFeUqkuvw1ZJ2VaPgJoH4dSapsrj2kkJhXA=;
        b=fhDX3jPktB/ZS3uX3jbg7PQaGpWvpqG8eLZsrtFukiyJ/f/mkYy0Dps0xatZxtkmw2
         CVTpIne5k0Rq0gtAfM4sbE4k+BH/1C1cBaHhw+bZ2oaFR4We806eshvDXU7u1z47Kq0U
         5NarMwS8BwwmRrIzF3ONh5LEhu30KPglPeWMlAbfv0+2ZSG6Unq1UXFi9f9s8UZZRaXw
         n4btgm+vXeJKKF/M+rlGqFNqF1KVIw+w95crf06jopRnhcZy473UJ184H12IrN1CvM16
         ESfcozb/NUn4mRAOuCmAzQRCClaHdH92lQXmQj+NilxQLqfSR09zww0wf9cuaS3qxTkt
         4axQ==
X-Gm-Message-State: AOJu0YyqEmIValM4Bvg+Z56kBfIvCjbdWRjrmtyd2zSv4QAX1CndC7pw
	NF0xXDYWDjJnDXuXX+wxFG6uMP9XPhvTM35WXEsp2W7Nky9yY3soFaMK4f6di6s9Zdom/4XliR3
	gELGFVedGRNyCADBA6rzU5eQPGQezmp8=
X-Gm-Gg: ATEYQzxEWWy+W87YWmE1sluXO9LgzXICDo/9/0c4l8LXvFKszmhDiFXff94WRTIlvwa
	N6RSo0xsahrwmAm95Uc3xHxECTj9GLEm9GQ+0It/ZCk9lHl2yTdmkODOTwGC/61n+QHEUHPPfb/
	wTz1cxbWw0Uq0GTjBZgSTqyI6Q8FmhZV2VtIPwvAT9KxGWZVksEfKA4pqshZxyNu97HBllExc7z
	/c8ygwdwHWDAWIPC/AvGO8d/ROvxr+kU9kmX8hdGt+1D46FIYhHsfMCoYvyH+vkqSwyHwxY1zD4
	4hgeXrduQpZqpRjM8h+mcbPmxRtIUhwaLwXgKTSRGA==
X-Received: by 2002:a05:7022:90f:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-12ab28ed8bbmr2016028c88.5.1774761837577; Sat, 28 Mar 2026
 22:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322065509.5384-1-mateopatinodev@gmail.com>
 <CAPig+cRAsEgeT+OgCSpTuY_Q6dMpXrfadrB=ujkAUyF-ocu2-g@mail.gmail.com>
 <CAFRsFoV+k-8GMf=62GJwxP=o0Fy5RRBGW+h4NqOLjFbU6z96tw@mail.gmail.com>
 <CAPig+cQcLJxxtsH0OeSP2DVUbSg8x95B-7n18fK9BVTJVywEtQ@mail.gmail.com> <CAFRsFoWRRnbrJdp_HVuoW-AEMqz_XjoP5yFAFP73VVN9nhdp2w@mail.gmail.com>
In-Reply-To: <CAFRsFoWRRnbrJdp_HVuoW-AEMqz_XjoP5yFAFP73VVN9nhdp2w@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 29 Mar 2026 01:23:46 -0400
X-Gm-Features: AQROBzBwv_jNb4iI8Dn7ubO93ieK-VjluerGTP-IEh9HdqVrDJu92TdbmpLikho
Message-ID: <CAPig+cTmvu+tmuvb-h+VsA8NL5xJgf6XPZGnERVqh1cp40hV_w@mail.gmail.com>
Subject: Re: [RFC] [GSoC]: STRBUF_INIT_CONST: initialize `strbuf` to constant string
To: Mateo Patino <mateopatinodev@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, ps@pks.im, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 5:41=E2=80=AFPM Mateo Patino <mateopatinodev@gmail.=
com> wrote:
> > [...] So, this suggests a
> > dedicated, simple structure and a few related functions and a macro or
> > two. For instance, something like this:
> >
> >   struct str {
> >     char *s;
> >     int free_me;
> >   };
>
> Thanks for explaining the original problem in such detail, I see I really
> hadn't completely understood what the original problem "X" was.
>
> To clarify, you are imagining this `struct str` more as a "smart pointer"
> than a full string abstraction, correct? I was going to propose including=
 a
> `size_t len` member for this struct, but after some thought, I feel like =
that
> would somewhat transform `struct str` into a string abstraction, which `s=
trbuf`
> already is. The way you're imagining `struct str` could be used around in=
 the
> Git codebase is as a wrapper whose only purpose is to inform clients of
> a string's ownership, correct?

You're correct that I'm not proposing a full string abstraction;
however, I wouldn't exactly call it a smart-pointer or say that it
"informs" clients of a string's ownership. It's just a tool which
makes it simple for clients to reassign the string without having to
worry about the ownership.

Whether or not it would be generally helpful throughout the Git
codebase remains to be seen.

> >   /* initialize `str` from a literal string (i.e. "foo") */
> >   #define STR_INIT(X) { .s =3D (char *)(X), .free_me =3D 0 }
> >
> >   void str_release(str *x) {
> >     if (x.free_me)
> >       FREE_AND_NULL(x.s);
> >     x.free_me =3D 0;
> >   }
> >
> >   /* take ownership of a heap-allocated string */
> >   void str_take(str *x, char * s) {
> >     str_release(x);
> >     x.s =3D s;
> >     x.free_me =3D 1;
> >   }
> >
> >   /* assign a string literal (i.e. "foo") */
> >   void str_assign(str *x, const char *s) {
> >     str_release(x);
> >     x.s =3D (char *)s;
> >     x.free_me =3D 0;
> >   }

By the way, the above example using the "free_me" member was just for
illustration purposes since "free_me" makes the ownership concerns
obvious. However, in practice, a better approach would be to employ
the "to_free" idiom which is used elsewhere in the Git codebase since
it avoids all the ugly casts. Something like this:

  struct str {
    const char *s;
    char *to_free; /* private */
  };

  /* initialize `str` from a literal string (i.e. "foo") */
  #define STR_INIT(X) { .s =3D (X), .to_free =3D NULL }

  void str_release(struct str *x) {
    x.s =3D NULL;
    FREE_AND_NULL(x.to_free);
  }

  /* take ownership of a heap-allocated string */
  void str_take(struct str *x, char *s) {
    str_release(x);
    x.s =3D s;
    x.to_free =3D s;
  }

  /* assign a string literal (i.e. "foo") */
  void str_assign(struct str *x, const char *s) {
    str_release(x);
    x.s =3D s;
  }

> > Clients which need the value simply access the `.s` member directly.
> > And there is no need to have any functions to morph the string in any
> > way. If a client needs that functionality, it is easy enough to create
> > and populate a proper `strbuf` from the `.s` member.
>
> So if we were to make this into a patch, would we implement this as a loc=
al
> helper in config.c, where the original problem started? I imagine this sm=
all
> ownership interface could likely be used in multiple places around the co=
debase,
> so my first instinct would be to not restrict it to config.c. Would it be
> too premature to give this `struct str` its own module? If so, then how w=
ould an
> idea of this sort be first presented to the community as a patch?

My gut feeling is that it would make sense first to introduce such a
utility locally in `config.c` where it is needed. If it becomes
apparent that it has value outside of `config.c`, then it could be
extracted into a reusable component. However, others may feel
differently, and even I don't feel strongly about it.

One reason I hesitate to suggest that this would be generally useful
is that the existing "to_free" idiom employed in Git is already about
as simple as it gets, and I don't think the proposed "str" utility
would necessarily make it any simpler or improve code quality. For
instance, a typical use of "to_free" might be something like this:

  const char *name =3D "default";
  char *to_free =3D NULL;
  ...do stuff...
  if (some_condition)
    name =3D to_free =3D xstrdup(some_str_var);
  ...do stuff...
  free(to_free);

Changing this to take advantage of the proposed "str" might result in:

  struct str name =3D STR_INIT("default");
  ...do stuff...
  if (some_condition)
    str_take(&name, xstrdup(some_str_var));
  ...do stuff...
  str_release(&name);

which is only one line shorter, and not necessarily any clearer or
less noisy. So, there isn't a strong reason (outside of `config.c`) to
convert such code to use "str", and any such conversion just for the
sake of conversion would probably be unwanted churn.
