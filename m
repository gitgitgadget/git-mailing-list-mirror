Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907891C5D67
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091975; cv=none; b=AzSuQpJOlsBfyevlVVn5ffAlaDUXz2oAVatJdPPVrWMaBtRirtRpQvVr7luiAV987mTo/DhzYjIEtP6uJ3MRQxG+U0yQT6M4IyMd8hcZ9WO5DhWXlaed3ZEOp+bUer7uR8XJo/ZCJ5Gv4B+x1kdSOJ/wn+sYrVTZ0i8AFEaty+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091975; c=relaxed/simple;
	bh=M0TeRaicBcmMTORhwqA1OVYKBkmF1Smn8l6FPMeh+dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw29BWesi4aZ+8AwnEDdAGDzw1zULqmLaOjjtwNNjEv1SEtUauuoFMVVbU3Znu1TNgGnSHHvY7Vi5GRVRLilwwEgA0CfZV8j7LriOBva9nwVUsgqXajvGaMO4McFc2wbOwWTIvvg+eUt9o0K10YuzVvuRbU1ZqgPApQZUOh3PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtYz16iu; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtYz16iu"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f77b9e0a34so10820177b3.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740091972; x=1740696772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGjzG8DSwDO5OfNhy8dFMpr7p4VXeBNXvmrKvNZrTkk=;
        b=XtYz16iuVsGSGBzXfEdsT5CuWNvgelfhtTwuceQdULPXPIkh0ZpF4ClDabRp/1BVdj
         3TAoSRa/HNmGdUpSFXNbOsnZKl56OJsOgJM2czNuCMP4I3+Egrj0qz+PUfnf+fir1VPS
         fXikST5GM4R6TkthsqI5tGepWf4NOAfb7SlKAlt9PZsLYYzcsfZ5V+KLz7A7X645qq6r
         +Zj50SF9OGfxFNqitWkeNR8+IXfQ9pjFalRQawjLrHtbRAyKKknBpunVEJa0aaIhrsg9
         Hd/GyzkTULaH/z/5mcVZ7sKlkuzOCvCOqES4qTAdwc7Mng79JrrsIqbDFTgfV2fqMkeg
         5V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091972; x=1740696772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGjzG8DSwDO5OfNhy8dFMpr7p4VXeBNXvmrKvNZrTkk=;
        b=NwOt00nncfTzp50RH4Jt9WVw0Ix5jB6ucTd5Uq26P9P8tA0mpOYm2CQvG2+FglvUF5
         837hjZ/nmQpX39f78Bdj6pETbu2BnabhthjfoQkbHgfyf/3yPnbX8+OT0gjTdJHylF2u
         HUEDKp1GFQ//pft3OqpEctTU8MoHdatWJuTSwAcgQqNx00ZjlnztLr5mElGkiGXVEKYR
         HbnDoYpcRY8uI8ZdjYRpRGYocMMnvcBBCHDcdD3kIqPRo6+fn+eu4GLES3crzIgfDBiu
         o6w2t89+9RKRZDK2uXSfiBo73kjqrhha28neADszZUNY1UL4kJmDwaiD6fz3izuOjnGJ
         gNmA==
X-Gm-Message-State: AOJu0YyexKYFgraB547QcvVCOENuue4AdN/pj303MWOlH9R+zRhyd9OJ
	fYr2ZalQH1bEtWO1EEWLs3Qt2g1bBXok5PzuwV1NCsgoUAPZ31pSZ2U75ENk9glOh8GQNgpLjUZ
	Rbrj7PetESrnKt2b5j2XUAV7Ff6Y=
X-Gm-Gg: ASbGncvJWZMJ2ilJXGxdTWyTvrumWgYw5/16vdlYiDe1aS7i4/UDMsNNs4RYmT7euwm
	+t5XxcSNRkYG34Da0P8K9dgiEtof9Mc1NqfXi5vmQMOeJhhXQYqpaA8CPvvWaZQa6vdpxJM2n
X-Google-Smtp-Source: AGHT+IGz/jIZ3kXuJy7MuWnFoYm78vAXw8/OZntysRc7Q0gF8cOdKVPOa9Blhf/z8StfPvkV43xgF7awAsyjmbSqL5M=
X-Received: by 2002:a05:690c:4512:b0:6ef:57ad:9d6e with SMTP id
 00721157ae682-6fbcc235ce9mr8725297b3.15.1740091972522; Thu, 20 Feb 2025
 14:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com> <20250114021502.41499-8-eric.peijian@gmail.com>
 <20250201020806.GA4081995@coredump.intra.peff.net>
In-Reply-To: <20250201020806.GA4081995@coredump.intra.peff.net>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Thu, 20 Feb 2025 17:52:40 -0500
X-Gm-Features: AWEUYZm3dXCM8JQb0UAWRVoG8WOBpXtj7SOBdW_UxF4YaFDsJh-ac8u9_KRyza4
Message-ID: <CAN2LT1Dxd6e1q_iE7_M_yf3aAyTwasX4ehRwEK_86YPJa8bkqw@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] transport: add client support for object-info
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 9:08=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 13, 2025 at 09:14:59PM -0500, Eric Ju wrote:
>
> > @@ -464,8 +465,33 @@ static int fetch_refs_via_pack(struct transport *t=
ransport,
> >       args.server_options =3D transport->server_options;
> >       args.negotiation_tips =3D data->options.negotiation_tips;
> >       args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> > +     args.object_info =3D transport->smart_options->object_info;
> > +
> > +     if (transport->smart_options && transport->smart_options->object_=
info
>
> Coverity complains about the check for a NULL transport->smart_options
> here. If it's NULL we'd already have segfaulted a few lines above when
> we look at the reject_shallow flag.
>
> Not sure if that's an existing bug in the earlier code or not. ;) Your
> extra check can't hurt anything, in the sense that it's just being
> overly defensive, but it does make puzzling out the expected value of
> smart_options harder.
>
> -Peff

Thank you Jeff. Sorry for the late response.

I will remove the extra check. transport->smart_options will not be
NULL when it reaches
`args.reject_shallow_remote =3D transport->smart_options->reject_shallow;`

The call sequence is like this

get_remote_info() in cat-file.c  =3D=3D>  transport_fetch_refs() =3D=3D>
transport->vtable->fetch_refs =3D=3D> fetch_refs_via_pack()

in get_remote_info(), we already have a check for NULL:

if (gtransport->smart_options) {
  ...
}  else {
        retval =3D -1;
}
