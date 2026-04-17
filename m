Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3C36EA9E
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463227; cv=pass; b=B8GwTh3Z/+17CMbcD3w3yKZYO7yfND8UB0RThwhgrhoicaFErH6ROdBByVM94HKS/ptj7upyb0bcLiqRe9Gszj2EnowflIUgaEsUR2akqAfGFnhlkW7TCwiDAkvQzYEHC7TmZ5jT43YlyMmuPq1F5epn8xqve5Vlu60Hkv+p0bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463227; c=relaxed/simple;
	bh=by7jVGazQje/u8l+tkDUszXrtiPZSFllLoWK93B4OCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dND+q8qPesEwc0eOtU2rTENvGYWee1k2GmXfl8MhHKGyCAmnhWT3dg8CX16OxMTefxcKdLFjWVaejauigTYb3HFr+Apb5nProflpETqbt2mzUJtQHm8oei73OFxmE+3r1WuxXUFBh0uNOF6oY3rZ3CbX99Jzf++RsWO1qjVOhpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWh3Ai6u; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWh3Ai6u"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6841e6a5e51so652004eaf.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 15:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776463224; cv=none;
        d=google.com; s=arc-20240605;
        b=TT5+k245ZQg0hsd/mxvTu22wr6CQFpZh4O9UeV5dfKXBBTSRVJxkKYWQCVoyVoqZsE
         LsiUtx7/d7qL8zWRXRwQOv/tBVjh7gbj8mjz83d07BCLdBQkuD4JqNtJ9B7lYlNHo30h
         k1sFMytRmLseHJD7fT234fEJio2aF+risJ++QQc8xlxlwu+2QqsuYqzu9t4ek/MwY0nC
         l4hcoNzK7RupgqROKE3kzPMifCyL2dTJxCcr/+o3Fe7pTQKVZHimy/Slro5wYs5XAiWs
         R+ppN6+7DE05uyj8wrkx2irdoxBSm2hNdiJOv7+jXZLi7O9mRCtpx3e/4NHjBwMhWM2x
         Jc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zn5JXvYH+QurtjgipmQVX/la0gRD9o5WuPj09AKzzr0=;
        fh=JS5hasdbbtU89+Go7xUAVy6AMzF8n6khdYdib+RE1Zs=;
        b=eAvWputdojbasU9i1n6GwABtb89tMUeLo6zFAJILTnEvbkRDit5bYUJwNc0+O4Njof
         WYYIB8MkpYiSmKcXzG24IOC7q/8vMRkGj/rweH2GmV4MwWQC4A+rLDpQG3VemsxLlOLy
         Mr85mAP1uRl0c25iwlD/ajO1WHW+a/BDKCqYgY/+WbfvJ/M4BrX3udfwi9x730KdqKs/
         fZoqdcszZOjK523ghezk8A+LpMC2JZ5uxuWyTL2uKsQM1JhCo1fET3GipAJYJ6SLuv2L
         BuVnrQeNEYTZHyYiKyD/asdXjmnsbc4zQOsA13jJqkMEscYuYqNSr1dZwaT2w+PTy5qN
         ES3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776463224; x=1777068024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn5JXvYH+QurtjgipmQVX/la0gRD9o5WuPj09AKzzr0=;
        b=IWh3Ai6uQ9Asz2hxMIYFdTkNT0aSotMokChKOEJvKEryTAz+UD7thYDKxabnM1oOkR
         5BiNf2gYFNideN8zKLwBG97FmbmAaOwzx5ybNNdxjvqDlrJmh9r75Kaeb4lOvdevojTi
         5RhGoSf655kW9SSLaUPLz8BfwjoSvPKi17yYjFbJX/mb2q1r4WHXEfNOJrx/e9G/6O+l
         0Bt2lR1WSaW/kI8t6oLTHAQG/w6HbFCfwPmk8WKKeqOMn4ppeYNnEay2o3tniNv2L2KT
         vN5CRecEBKpgHFogAOqqhSCwFbMKXlLpptwhiEQOjhv91rnIsSLsFLhBZ5Ijs3CD1op4
         Ya/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463224; x=1777068024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zn5JXvYH+QurtjgipmQVX/la0gRD9o5WuPj09AKzzr0=;
        b=Ckr4KZG1JGRvcBQsjF2YO6rTcPw7432LM1Af4daJqWGz49clHJLFgL1QC+brzAmLKj
         vGjj39cu8dSUt+ECGkNY+XitPdy+fkUgbXoMYxNP58272eEhQuQWVAFjKc9dZWTmI3Ev
         cFCuZuGyQtRMrSuGhDDkYIKReyeVs2YAfsti0TTR0kC/CUIi/kpwXkbzbWOl+jJ2NQI+
         Sxsc0mERUhV7bc62CjPM0i94KHrYO4L0/FNv/avlnDTKWXRKv3onVECB/IDok16ovNtS
         Kw1rrpF20tdf848sIKANtqRQYJfzkFWQuZagqR6+2yz4mXMd4ksOz0NNrRtm9/SMtzop
         RIqw==
X-Forwarded-Encrypted: i=1; AFNElJ+uowBUCzidotZukvKDHktS1XhHHkZYXl9jnXZ710fWbdy/nZyJjWMlntQi8F+7ztiz2AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcUzzHIOP7/u+d6bKPNpn1y1pZE8uVt0Vo6G0BPWZ0IDYYtcX
	VWrWCom88UhQKEXTHoMu/qti1MLDCdCwIziwAN3F/zAsMJch/EACosobKURQM/7mjuF9T8QQgKu
	NRXKF6p3ItcrTmucPXDDO9Z2htQFGHEc=
X-Gm-Gg: AeBDiev1mYT5CRCUFNQjn03afkXLv/0db+fhVpgAKdh2f+ECnSJfx8xsg+2wND/wg0i
	Cs7Le+vQW7ZQCzIGUZ+bMlwjYw3WA9ylURJdFMMrrDACyAzq9DGsHohqhjssweIwOtD5GghE0dH
	mX2eePKQycPa02CGZKFL38f+vs2vzMfmVbdkFb57WQ2XBhIZQO7M/GmyATiAt/sk9dXSNsQQEaT
	UNtK4nQgm0/U0yOOmoehDcM3upjYPXcTPbvrJYNEMw8KAnApupeLTHBw0V5XwWUCXkc0fbBsF0X
	TYCd+ROeSzX1e8h2VL6vIkDIMrA1U0ooJuuUeZHIFKknMpW32BhcmTXg2NCEjbTWGhiRZIIfquQ
	2FiwXxkVt2BbAQe8iyAX05rQsaP8Bu7btNyvwFn8p3ULqW1Y=
X-Received: by 2002:a05:6820:162a:b0:68d:6e03:551c with SMTP id
 006d021491bc7-69462e8af30mr2858670eaf.27.1776463224370; Fri, 17 Apr 2026
 15:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2093.git.1776443163041.gitgitgadget@gmail.com> <xmqqv7dpwfy5.fsf@gitster.g>
In-Reply-To: <xmqqv7dpwfy5.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 15:00:11 -0700
X-Gm-Features: AQROBzApBQ2sUFKctiQZbrEcCuim4YiHYSYd6lF8XMkjBeWeyGTA6sCqG7CUBtQ
Message-ID: <CABPp-BHt-O=CCnGHjoXBOHCe5CbD7beyrd_gX51g9Xg7cn_eFg@mail.gmail.com>
Subject: Re: [PATCH] diff: fix out-of-bounds reads and NULL deref in diffstat
 UTF-8 truncation
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 12:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
> > UTF-8 chars, 2024-10-27) introduced a loop in show_stats() that calls
> > utf8_width() repeatedly to skip leading characters until the displayed
> > width fits.
>
> A tangent, but I get a datestamp for the same f85b49f3 (diff:
> improve scaling of filenames in diffstat to handle UTF-8 chars,
> 2026-01-16) that is different from what you showed above.  Did you
> find a bug in "git show -s --pretty=3Dreference"?

Hmm, indeed I get 2026-01-16 as well; I'm not sure what happened there.

> > diff --git a/diff.c b/diff.c
> > index 397e38b41c..7b27241733 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3093,8 +3093,17 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
> >                       if (len < 0)
> >                               len =3D 0;
> >
> > -                     while (name_len > len)
> > -                             name_len -=3D utf8_width((const char**)&n=
ame, NULL);
> > +                     while (name_len > len && *name) {
>
>
>
> > +                             int w =3D utf8_width((const char **)&name=
, NULL);
> > +                             if (!name) { /* Invalid UTF-8 */
> > +                                     name =3D file->print_name;
> > +                                     name_len =3D utf8_strwidth(name);
> > +                                     break;
> > +                             }
>
> IOW, we punt on "scaling" and instead use the full string?  I was
> wondering if we can punt on only this segment by replacing this
> segment with just "..." and resync at the next slash.

Good point.  Alternatively, perhaps I could just add a wrapper around
utf8_width() which never sets name to NULL and never returns a
negative value, and then use the original loop as-is other than
calling the new function?

>
> > +                             if (w < 0)  /* control character */
> > +                                     break;
>
> When we have a control characer, we instead chomp immediately before
> that byte, which sounds good.  But then wouldn't the loop that found
> an Invalid UTF-8 sequence in the middle of a name want to do the
> same, i.e., take the good bits found so far and chomp at the broken
> byte?

Makes sense, though I think my simpler alternative might be easier.
I'll send in a re-roll.

>
> > +                             name_len -=3D w;
> > +                     }
> >
> >                       slash =3D strchr(name, '/');
> >                       if (slash)
>
> Thanks.
