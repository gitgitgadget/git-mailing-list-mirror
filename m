Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E419466B08
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368276; cv=pass; b=VnljHRzNyoT52pDnT94JARp5eVwLRzBMBSZztmJyP7vxTlCDsEBXl8igM/6TW6XcjxW/Npm9j3reNWsShg3yJlBaH0n2j5iaGrKnyL4OsxJ44EJJRNWPtvtO37eESFOi9OAOIK8taLOZzrsU3BUISgRNR+9eUx1KuQ7UkogNHr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368276; c=relaxed/simple;
	bh=11XjGqmCW9KL5T5nPDnIpkxLwHjyk77aFZkKfEJsg+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPgWWbS6bmnSE0Z2NrlVMPEeKW3yXRIROPqMWG/wtsmnuHwV3Vthf+hT7syoLZTl6rH9hwAnLOObAD+0VDDjAJUhPBC2tTWOaBRPMMjMRY8wFIavje2L6SpbuJd8n4yUN668QRibjJCHdx+Q8bdhZmIntPYBCVzYzQcoOjTR4co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVVeRjQ6; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVVeRjQ6"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so723727f8f.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790368266; cv=none;
        d=google.com; s=arc-20260327;
        b=DWdv2GWR80GLr7EQxfa9GC8QhJ0qIZRE2lXs6cOVxCTBOceCRSZ7oLW+g/+x/Lx7Au
         qkP0bPlahpvupbaeOlOXV9zqK51sawe45R+FSv/6vaZu0sPurgRyZI7vC5hiCEDdHMYl
         3Gv/KRTRnRbZ9MLowcgXrAOHKL9p8RJN0dwxutmponZyWxiNrZg6LIIhd2OM2y9ZK1Zn
         /RQKBBKw8QaDTENOQyO1BVz+2A4FeGCKJTQN3PzJo4v/vKXokgRrJn4teSAj2mBfChvx
         3aTnF26cF1XSACTEYE6ds7sbe9NvcgFkw1b0T5AeNAg2ntCuifDRp7qpp3b1mrKabOCn
         3YbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z5jKJKaTyUtdOlplpUKws7Oue2FxaDLoPFAaM+bIogw=;
        fh=9lOeBiTeAI+4FIPMHGbUvHErvC4nv37dZNbhm6sOM2g=;
        b=m0IqU/sQr6a0F/7dx4gXLjF1DoqB3HOsjgtJ12OMAjK1Rpj6xpWaRnrGWtZPX+Pgaw
         jf+JseH0MgOYoj3btxRfeCQwszrJ1ApXjvr+ueRR0g0EKXK3IOSlpQqqj9uli8Vn3gas
         Fjoaab7GkUD6yupGZIlQrBkX1ZOpkiiBuh0q7KtJyQIdMV3QNe+62sX+rbRp/8xv8MfZ
         SWspuZfDzlhf84h57ddjg3IuvLHwFnq0Cqkk4wcQGItj/JRsIKpx//89CkEAjq8dX+S6
         GBdQ0ccBWtqvFIFmLZkzi/0iD1eQqBZsCRaY8JgGD3TvW00mfSRA15Xyx+Sd9Y9X/Q8g
         7TQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368266; x=1790973066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z5jKJKaTyUtdOlplpUKws7Oue2FxaDLoPFAaM+bIogw=;
        b=gVVeRjQ6WkSXw+evS1zYz9RrXrGuSPuKl5hQ9d4djsJm712jBze4TuNUGZ1fFeC+mT
         mKyt86HRWOv7Ujn1e46mpicjq8cOuSYmOHk69ZbfSnpnM5U/oaNlfVdygFy6oTiL/veO
         4+Egq2lwuG2ngUyQbgfTef6X6hAwVhPr5O5VMxZyjTZVqC52m0LDxHB/dUiCYAxHOS2/
         vwjkdioE8p14nigg3saLmVOa4LLLe7nBG+Klx9+Kewz+Jgccm0oUcAXrI8MEdI4v/DjK
         4q2AcakbmxX7spIH/8Z+8DKsrN48NL106a5svWpWhJTtQJYF1u1HFFcpgy8jFz/RA2l0
         B9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368266; x=1790973066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5jKJKaTyUtdOlplpUKws7Oue2FxaDLoPFAaM+bIogw=;
        b=nTKV89BfQJUKOq9HeODfhpyYM1tAE3VWSG4jOQopvttg0z3oOiPXnonKqwMXYERRQf
         2jTTfVRBIdqyLhYIvQMLQTtbuDgYRZmuzfaGFiKBQRWVicEcdp9dPKsO0u05+gyDmghJ
         psOv5QnaLg8JxxgwPRDgaeJajvMgo0T9j7I1Qzy8WSxVKpTjrpnUckdKunOnUlJ13M8j
         WCD+Z7+qbTnrrZuUfm7QzulgynEXq92tJYsO92cwV0pwYQ4eU9QclJXrTQX5bfeXn2Fn
         XjvqlNUyfjGUiHj87yBBKEnjFnPvjHKgFHD0y/Zyu3LKCD+GQ8kOMbMUMoXjq4nzh/pC
         f66Q==
X-Gm-Message-State: AFuF++n1Ov7NcHsq2S+3MUHwLtb0Y30QVdzqHbHLAIcQRB1di4hTW52m
	eazK2m7ZSZiW9T21/O1qA5ymu0VKPYAeE/r7D/8p/BxjxFqjVX42+i/rP8Dy0EGFE94bhKeiz/T
	JvsueHOFrJssc9domSF4za4zwDL/Tviw=
X-Gm-Gg: AYBFou3g6QFOEUjuygOMiMXTw1Ilp8N0fElnGjpXrcBHbQoz0SdKyCC98Uz/HzCwb4c
	gxCSoCG2PltcIHrDtFM1ZbSU29NHHVEQcMEHy1Hv9DYo0+MEluY2eZTFaCaijtaROmDkONwHXxv
	CBI8Ggjd2/NXmtTN2cEZFbD9QhEiwCQdlGdXA9Ku/h6Bdi0q8sZZ1JGd0ZgQDPT8pIyXKPdqMH3
	s9aeW6OBVlgQbImCXk27S8gwLVP9+ZvTBAIOYSmTaNL/j/osUZaeBOGV2ZFZawcF0JD/aHd7jRC
	eHAHst8c5CIoUQLKWyLHbl7o/H7WZXd4tCQ5yrtYKhEE5T5j1FKRY+uw
X-Received: by 2002:adf:e198:0:b0:486:e5c6:cab with SMTP id
 ffacd0b85a97d-4887174b7ffmr11224066f8f.32.1790368265900; Fri, 25 Sep 2026
 13:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
 <20260925192658.1166-1-colinlewishinton@gmail.com> <xmqqo6dlt906.fsf@gitster.g>
In-Reply-To: <xmqqo6dlt906.fsf@gitster.g>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Fri, 25 Sep 2026 13:30:54 -0700
X-Gm-Features: AclHuK9kpRnopLBy4mjUlH0_S796h0TDHN--LQUDfq5d_a4hX1QM4lTfNSQTVRw
Message-ID: <CAHeTm9Pb-fb-ZS_m4UVNZxfp+ENQwBUGDvP1E24dEDTZy5RFFw@mail.gmail.com>
Subject: Re: [PATCH v2] fetch.c: defer fetch.followRemoteHEAD validation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, m@lfurio.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Colin Hinton <colinlewishinton@gmail.com> writes:
>
> >  struct fetch_config {
> >       enum display_format display_format;
> > -     enum follow_remote_head_settings follow_remote_head;
> > +     char *follow_remote_head_raw;
> >       int all;
> >       int prune;
> >       int prune_tags;
> > @@ -176,24 +176,31 @@ static int git_fetch_config(const char *k, const =
char *v,
> >       }
> >
> >       if (!strcmp(k, "fetch.followremotehead")) {
> > -             if (!v)
> > -                     return config_error_nonbool(k);
> > -             else if (!strcmp(v, "never"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_NEVER;
> > -             else if (!strcmp(v, "create"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_CREATE;
> > -             else if (!strcmp(v, "warn"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_WARN;
> > -             else if (!strcmp(v, "always"))
> > -                     fetch_config->follow_remote_head =3D FOLLOW_REMOT=
E_ALWAYS;
> > -             else
> > -                     warning(_("unrecognized fetch.followRemoteHEAD va=
lue '%s' ignored"), v);
> > +             free(fetch_config->follow_remote_head_raw);
> > +             fetch_config->follow_remote_head_raw =3D xstrdup(v);
>
> This will segfault when !v, so
>
>         fetch_config->follow_remote_head_raw =3D xstrdup_or_null(v);

Will change shortly.
>
> With that change,
>
> > +static enum follow_remote_head_settings get_follow_remote_head(const c=
har *setting)
> > +{
> > +     if (!setting)
> > +             die(_("missing value for 'fetch.followRemoteHEAD'"));
> > +     else if (!strcmp(setting, "never"))
> > +             return FOLLOW_REMOTE_NEVER;
> > +     else if (!strcmp(setting, "create"))
> > +             return FOLLOW_REMOTE_CREATE;
> > +     else if (!strcmp(setting, "warn"))
> > +             return FOLLOW_REMOTE_WARN;
> > +     else if (!strcmp(setting, "always"))
> > +             return FOLLOW_REMOTE_ALWAYS;
> > +     warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored=
"), setting);
> > +     return FOLLOW_REMOTE_UNCONFIGURED;
> > +}
>
> This would do a reasonable job.
>
> We should do something similar to what remote.c parses for
> consistency, but other than that, it seems this topic is moving in
> the right direction.
>
> Thanks.

The only critical difference I see in the configuration parse between
remote.c and fetch.c is the case for "warn-if-not-$branch". From
reading the git-config manpage, this is only a setting for a remote
and not for fetch directly so I do not see a reason to check this in
fetch.c. Perhaps I am missing something else to make this more
consistent, or perhaps there is an argument to support the
configuration for fetch to "warn-if-not-$branch" in which case can be
added to this patch.

-Colin Hinton
