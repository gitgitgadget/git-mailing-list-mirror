Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E63221DA6;
	Wed, 26 Feb 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596998; cv=none; b=owO9EceigBbMO5lUtEzqTfjOY06k8qo7Rpl3QeBaQRFoR3LB7vbD0B8ahOGkOfAsV/qD/Lr5PjqQaNEir3B6BBoEkfabdV0Rvtj8Z6oCo1NQG30tarXqfDItiEzS6SPTUbKK9HJpTWTwxl6firW+D1l01NAuJydrO3rr2XbLF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596998; c=relaxed/simple;
	bh=joCuhhOYS2Sn9Aaa0t4iV6f8I+xKpxEsgbXvDhwqOsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b28KbZe6pmGh3d3D3P7idL2nc0AB/3s4xXWAaIXr7EWT6pJESBD3ACvblwnNl2H3NaKLcxiN24QtbT0ha/kUIe7v4VLHePdwqccIh14KDeo9q8nEroxs9K4ahyJf8fLTs88At/tPq74ooRpQYYhPRfTW9PcQfayIT2R9yDk0MGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEyb2Nnz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEyb2Nnz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abee50621ecso17153066b.0;
        Wed, 26 Feb 2025 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740596995; x=1741201795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kJCzq0wYyRIYa5yNPxR2YOHZUPtvvyvn3GQSUif21c=;
        b=mEyb2NnzozQgftyOftQTGIqsMI/yi+mLEZBwm/AlcqdGHaTeJWy+yItmQ8A8ymPu35
         vqRB2Dnt/yaHBzDJCBfNaINC2TQ8XfAeAPABSJsctQVDSopbFrGuB/cz/chISca9kGh7
         pNFkHyr8sypbVfp0ekuf5nWBhW8cISE5KK4TkfV3uushOnAF1TlVGY7uJ77J9xjpvIl/
         mmlDZE6s23kFdnDw/L2g4t696iKKqpPmDaIZHqhugIeqOLIC5AokHvHEWXvBALXuB7ad
         JV+UMatB+NlhD/H6BPHCN2+DMu4FE8dl43HaKDPFtMedIBeAycNf6h5jdSTQ8OzoBdKL
         48Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596995; x=1741201795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kJCzq0wYyRIYa5yNPxR2YOHZUPtvvyvn3GQSUif21c=;
        b=cxSIXtfVjINseWVbv+aNllXz/njL33N09Uo3B8bxotXsqkQAjrUZ+L/lIY5qqlAWUc
         FvDMKOfF6Tz+IhUJwISky/eT9jxQIMKjp6zyTpVnH0T5g8Mc8FuSQp0qVfLE9nCyGhbU
         aMq5yN4qLkJ0v+2GeNtKlho/IVzHOq1jROwe98zc0+spgwBq2p3bltpksFqy0k/Oh3ZU
         rXZd8AwzaOt8n6Uh3koPg8igYduhjzGvwPdKVRVSuBkp76pa1wVSB6+PiPPBH+rD8Ixp
         Mf9/ZTMoGDNgHW3tdzszm+HMmdlIrHa0NwCSRihZU6+FmBKk4Obj7DlGoTMgli8EFt8y
         b8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXY9ORepgBRaNda6/EGZ/7OqvTv4xAtw8s2lvfoKWp8V1JdeJs+fRCiVD2LVj/6nA9Q9yyvIdq/NbHXfxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISru8akfgXuLYKB10Cw58d5ZD6Eypt9PLJNrU4gGnbyV6Bf+1
	sRg20mscOyxk1Zm97IGw3tvWeAKPSp9X1mKOfVgKyL2VEQj0QLuoTtP/AFGtigJy5e/4EPDQH8H
	7QcE81Sw7nY/Axm8AT/spzB7VjC5nkmUG
X-Gm-Gg: ASbGnct+1RT5SrIvcjv2TCe8tvLQB2RxECBmgf+IdUJd3x8l5C8ksAga4097qGX/7jK
	vbQFviFPaWWnGHMbFnp3E0wrA391qclbcQsWZheRpSA8FZuviswwClGja3nPDHvXSq2HWxykgLR
	P1iohuSuv7g+F8q9GlvD1KNSAg4VePXFjmKCt4W0o=
X-Google-Smtp-Source: AGHT+IE1aKKUq2MGlrPUmRUm3ES2LJ/+73dK5u7I0GUnLtrE2yxhDfB/Kmdc99o4UNeUiXRpDgWD3Vc0qO1IjpjcXbw=
X-Received: by 2002:a17:907:7758:b0:abe:c031:eea2 with SMTP id
 a640c23a62f3a-abeeee6fe73mr526160266b.24.1740596994987; Wed, 26 Feb 2025
 11:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqzfi8bljk.fsf@gitster.g>
In-Reply-To: <xmqqzfi8bljk.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 26 Feb 2025 14:09:43 -0500
X-Gm-Features: AQ5f1JoEzY-EhdgY0PERm5MDEz6GcHVj28u_85d8OzgIw_25ZHctgSyl6wVX3es
Message-ID: <CALnO6CA5tw9DNo9U8Fu95Y27DBiRaRDsz75MHwm64iW0TBkxDw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.49.0-rc0
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, 
	git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Git v2.49 Release Notes (draft)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> UI, Workflows & Features
> ------------------------
>
[snip]
>
>  * "[help] autocorrect =3D 1" used to be a way to say "please wait for

Slight nit: we appear slightly inconsistent in the way RelNotes refers
to config vars. Compare

    rg '\W\[\w+\] \w' Documentation/RelNotes
with
    rg '[[:alpha:]]+\.[[:alpha:]]+' Documentation/RelNotes

It seems "help.autocorrect" style is _usually_ preferred, but there
are a handful of "[section] key" style. (I don't have a preference,
just something I noticed.)

--=20
D. Ben Knoble
