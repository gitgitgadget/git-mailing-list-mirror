Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F958B6B7
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885979; cv=pass; b=i/gKglSLDG8A07wA38bX06JbmbVpgWmP0fXFe6iALmmKwYXArWECuQYLP05R39PkflRNVPV8VdL08Kx75410eIoWw7r3OZMHoUhU/4wNAg1pm9fMnaKtubcDJjcRB1TrHfGN+TrfrDFx6ztWdMwdetZjFAVtIeodtD+t6GclB4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885979; c=relaxed/simple;
	bh=m9MWu0iIBFgFEsc7XfNKpJynwpgLnksXLlI9UaxjmTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfzMIg1ropom6zCgnP33zduhxDRha57D/wSffriCgwjVS1egL1/e/PFNp6t0X80kP0lxo+HDfNnlZlFxJc/LR1sr23Rrc6NEDvM1jYIjT0/ZTZDmGXgU7wpRswUAlqbOQhUPFpIEThcxIOlks8WZw2LrzLcLkrZQ2mJgM1tBbls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8V5QCOC; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8V5QCOC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso3710373a12.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788885977; cv=none;
        d=google.com; s=arc-20260327;
        b=ob76LPoHZmR0j3LZka9gxJ5uAlf1hks79r5B40yUp24sjZam+UUlEYu+ihX9K/aPur
         f0v6jolPj7bMk/nfG5Bhb1JM24DFOXcTKV+NGVDKftWrfmBgsnABx2hxuFSWzc8s45jy
         TkAooAxST1PI5DsPXgh+fOh6ZftXbcUdIeAf0tNsp8NAJLPtX2S81ALipuPQ95L6Pev6
         vkt3JiLaXO9iHbUSFdHHSN/zpFFQXYb19jErqozFqTwgDek5DrGR7bsYx8PWEUKF61ny
         WoTnmTyUz6/BfAT6kTknVmh2sZWBZXO4BFmsZEQk6kv2Bv60qJBIF22XgyCbYoK7LRqi
         bbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w9YzwHM5LzayjTAvD81JRWSZCsVP/KTRCFMEh4myCzY=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=qMdRTB5Rm4Ndr2gVx+0NoMws+oDh3JZ+GFmODWlg/gK+x6EYwujcC+6kQMTRyCuYzm
         DbaK2lutItZatm9uQaFA8lPDtChxqzecbO9vYx6nT+MqPH+OEvSh3AVFc5HCxE9y0hoj
         SI/inG7PHsCmKwD1FcNsKDsokmx0m/C283wJ8RhrzRSNw1uFPzkvc2rhBl+M4aGShegt
         Eis87bShSSqCURTsmKcmA75N0OkMneFrf/2KPldGLcynbiukC6PbHNg47RRzTZ/qvVr7
         q8Zi8c2rRok89UesEFJSh5rYtr9vXJLataI84s+WdqxTSUgjOFdAgT9CPBfE/T6qTH+X
         +/5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885977; x=1789490777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w9YzwHM5LzayjTAvD81JRWSZCsVP/KTRCFMEh4myCzY=;
        b=s8V5QCOCrDp+0ymDX3fWzWnYEWeebws5GZ+mQhzir2my4q0Xq0d7cyAmC1sSLwyRlE
         Q8axQ/RR6jFOq6LZaXUcyGZB7dJWWvXF3AfCaFBX9Cv7f3f5ArGD+TWQjkPFypYe+LNZ
         6nVhmrmkcd8xRkrQiGgPBR0LTo8X4OgBPFoLtoH1bhFCsfRvIEeLttfmi4YJbPr42JsF
         2426rlM3m4km/XvsBabrlFxmLr7cRhCC8b4KT8TouW3nibyq5kwN8WF6Rug5lDKP9kU8
         lGqPvIshfeqoF/aqkhRadQAVulHN1+qLMADLjJZQDfTdAQb7x3s462eGswsB/sT7O/jp
         ZKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885977; x=1789490777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9YzwHM5LzayjTAvD81JRWSZCsVP/KTRCFMEh4myCzY=;
        b=bKh8kVvN3zh/0tAUJCOEdBPHEtIlG5PNPiRvEuiq2B+kUCGg6YpxVqcWuJyaMMa+b7
         n81YNEUhPCMII9Ov8xyzYWNz/hqspL+MAxAru7jmEcZuOziT1KNWMfjsGXJE0ZlhsZC0
         6cR55bkC8SPwAKmxYF/iok5YUAvtereKo932LYsOCI4bpB/kPKpTQBk6UqFtvjwmgc9E
         XVyBoq8XB7ax5tkCtAoe1J7ttNPydgH1oGEE6lLN+AsGXHqrg7s5IEu+bj25hs6zWwap
         m5zhZNpE7x3ytYWDaOIsN1HEgDmyxtKgFWLdacthBf9yK1d0ecKP65aMJQjg7eNK0AB/
         IAZA==
X-Gm-Message-State: AFuF++nwFJ+NQhGVrE8XUPu3yZKUKqCjRWj2eTp2LCOvMF7aTQL1Uu1h
	2nWCipqehtIgcrXXgPKYOsYgMfNfoZAzlyn5+Gj5LenYaTNJM/M3J7fkU7aQNvPsBvoPLTlhLWF
	76kpqGAj5UG2Q8itCiJwZMah9Pw4vg+Q=
X-Gm-Gg: AYBFou2l5OKcVMnRTyxAKnfqS88qyihjr5Gw3Bcg9SDDYzOC0ZWd3FN/eHndgXPdlvV
	r+jluCRZR61mkHE6yUITkb96YvmcwpkGlHIy1crdv+3x0Ploig4au+gepC5/DlA0WTwJWvrv6/u
	qZZfFSs3/RbmofcP2OHjuT411VJ7wCRVjcogQP3bQxGFN3R8ptsKKaiD0HDk8TT5eFvHrsn/kNS
	wfURhEXfnTXTKsnnfT0ok5j/d4PwPxXjd0dHTPxfDfo2E3ypizwjR2J5uP1wsSyTWWVVqj9rsQw
	/9STkc5cLj/6jNubCsmKAiy8azmQ4ftJL9M8kjEEueX+18nv9YXYc5MFjEpGVbLOCLYDIgCz/Wu
	503FJuowFQNQsIko017Qzp1c7M/klyxNqPgMqfmzZ9FBTwyemZqGmDxhx0X/1sBcz+BsFRTITBt
	0SS2Jm+JuTER7sP5pq5f0RrpQAGZ7L
X-Received: by 2002:a17:90b:28ce:b0:398:a649:8fa3 with SMTP id
 98e67ed59e1d1-39b08799871mr37191555a91.23.1788885976769; Tue, 08 Sep 2026
 09:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135511.1818458-1-christian.couder@gmail.com>
 <20260813154748.2378747-3-christian.couder@gmail.com> <xmqqecg0oabe.fsf@gitster.g>
In-Reply-To: <xmqqecg0oabe.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Sep 2026 18:46:05 +0200
X-Gm-Features: AcwNN1VjeX-cF9vVolU-fmLEib6tQ97Fe9zTOvKyjxR31FY6QBIXefEZHclThVM
Message-ID: <CAP8UFD0qSA_giG1o8ydwxUOyscQaJ9pSNyngCdC7OEa7G_C5jA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] setup: extract path_allowlist_apply()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > diff --git a/setup.c b/setup.c
> > index 95909e9603..39dfa1cc5f 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1339,6 +1339,64 @@ static int canonicalize_ceiling_entry(struct str=
ing_list_item *item,

[...]

> > +
> > +     if (ends_with(normalized, "/*")) {
> > +             size_t len =3D strlen(normalized);
> > +             if (!fspathncmp(normalized, target_path, len - 1))
> > +                     *is_match =3D 1;
> > +             goto end;
> > +     }
> > +
> > +     if (!fspathcmp(target_path, normalized))
> > +             *is_match =3D 1;
> > +
> > +end:
> > +     free(normalized);
> > +     free(allowed);
> > +}
>
> The name "is_match" somehow feels a bit awkward.  How about calling
> it
>
>     *matches =3D true/false;
>
> instead?

It was `int is_match` to match with `int is_safe` in `struct
safe_directory_data`, as the function is called this way:

path_allowlist_apply(key, value, data->path, &data->is_safe);

But OK, I have changed both `int is_match` and `int is_safe` to `bool
matches` and `bool safe` in the v3 I just sent.

Thanks.
