Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53F1C36
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226368; cv=none; b=Dz/skzMsMqW/piGpWg2DT2WkJCMEsVQVKKDLSI30FqkEADumaqlKXT59UcH7UShDZ0YHyI2ahFLGN7kcD8BrDTTbpYo3JPHlixrxsXNI/PXKrPgQdcA/pecOCAbUVP1oJzXzQ1zwvjKhGFDIANcSNHxz0lWhsQDB1gFfe526m6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226368; c=relaxed/simple;
	bh=7/VYDF6dADndLSthu435Dy+6WRFVFa73jQGktWn7BvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6hRYyQA2d1cNNch00GlPYXVMRjuqhMzuddKa3DVlE9gi3nS6UmSoyUEHMsQSdPPIfQh6/LkPomegKHZUg7hXigsyXM0mR/7mSl9UoOfkNcOFQFQC/hmI7HGirZ182lXIn1h1T5WSQOQiMNrzHph7gcgg1/hHvyIrPGN3/BySxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxLbUX4s; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxLbUX4s"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso114759939f.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226366; x=1742831166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As6JI1r882ntL3CnUxsy8VM2B6ZhSRWikuCeFziA2Zs=;
        b=JxLbUX4sRln0CG6AaSzjOxFFJCbhTiEniC1WF1iuckmUkpACSY6frvIJ1hP8Epwju5
         3t4suHWpbWgjLdcD238ihgniOv44hYWR/fP9JZd3MDTgyLqiBLtqcyKeeuYMDF7Qc5y6
         NL6yKBCH6zJzVM17EE8u25SrrlrmxqydPC+bjj0mYlPE5fFfHVo0pelJQMmF57FAzMM7
         VcGOTEGV3k+cv0zcX2GXrZpBJ6JnwPoqXkEszPnVHEIk4hn77leYqqCIWbcyuvqg0KhQ
         mQ74OQ3VhvVD/gINJeNHqVVdVfaYG7wNJ2U0uexSWTQkNnTnZBROcqfEKvDYoPFPmw5Z
         qFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226366; x=1742831166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As6JI1r882ntL3CnUxsy8VM2B6ZhSRWikuCeFziA2Zs=;
        b=miqLBFg/626yPk5LSAXUVR/7ryq9l0xUmfwU1FN2XArY+z97QRHhNqiufWJM3PFk5A
         xF8zn4w6E46fEOpc9IALAOEOt+ifzQ+SGgEe397+da1NQOXVVnJH4emf+wovylzEwUO5
         duDq5FxLOL5aQN8n/7R6sJbO8L0TB50WqP/5lM9MnSoCwnqxuy4UG1OUzrcnIzwq3mp8
         SxfBZJChs6iD65QlLqciT3+fy8p30jRAX9N8PtGBgTvL6O2ntGUOMMVbEZAiR/33FiRd
         2QegO0MqqluDtZ2m8Vc3Vzqp8vRX4/vWFGlkSEZfHQSfw6K27JEEXHLl9eeHagU/fOKn
         9Qbg==
X-Forwarded-Encrypted: i=1; AJvYcCXUEQftkArJfIXADEs+oDaAas/Hcr/JGKHJSyn2uBlkoS769JslbSC1TWwWzBoRHb9Fhvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgibnKvvHBZkHlMuUjYCS5BtkePs8PBZ0eKNaYHFafWWlo+WP
	COtfgeGEjl2cvborKUY1jRH+XLJcakrertRBrVIea5bUn+YCufNRt7uFaoBvOYba9kGVIEkbS/V
	LTN+1Cs8Mbkzvg9Qu0WbdqgiIUKV8JA==
X-Gm-Gg: ASbGnctxSGArW5RsDrLUoIyQAhhXBzlCLudR6ZXjrq8JLFtpMB0SRltrnsDTmy9OSUR
	fynDOj0LeuSwjy6ueZePcYJTQJgf7KymqI29F3hdiunVXupWOBwauVjiknOQ8pifU096YLVZsEk
	fs0heSZBBumeLKD2kGu/uxKdc3i9bzKROp9CbNq+4jDxzePGKC52sSi3XJuyU=
X-Google-Smtp-Source: AGHT+IFjE08W8BEMA175BVKnqpaZo9qAcJfw2zuOlfwo52Rzv57AjjLjtfNnHHVBfBgUjLJgTVLxiAURBDWrMUK2cls=
X-Received: by 2002:a05:6e02:1c08:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d57b9b16d9mr3381835ab.2.1742226365491; Mon, 17 Mar 2025
 08:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
 <xmqqy0x8l8tu.fsf@gitster.g> <Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net>
 <xmqqtt7wl85l.fsf@gitster.g> <CABPp-BHRSnNE0zj9kRjrVm4-NXt33tYBT_iSgZU-5JU9Y2vp3w@mail.gmail.com>
 <xmqqa59nh66g.fsf@gitster.g> <CABPp-BF1LgdafW+PHmttuhHL1OOHPTsGpOTVuG_A0SSH5cbfbg@mail.gmail.com>
In-Reply-To: <CABPp-BF1LgdafW+PHmttuhHL1OOHPTsGpOTVuG_A0SSH5cbfbg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 08:45:54 -0700
X-Gm-Features: AQ5f1JqMSbN6Bct9maN2iMO1l5T55u5oLn-WUiAJipPUZPvGOr0ApsksqvCxEHY
Message-ID: <CABPp-BGA+mSbj_n4k8QX3nB6rxox04E-KH6sdBWLUbGex+K5Bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert() calls
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 11:38=E2=80=AFPM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Fri, Mar 14, 2025 at 10:29=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > >> Licensing, mostly, as clever things we see are not necessarily home
> > >> grown.  I know the patch came with DCO sign-off, but it does not
> > >> hurt to double check.
> > >
> > > These two lines:
> > >
> > >> +extern int not_supposed_to_survive;
> > >> +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
> > >
> > > , which serve as the core trick, I had used elsewhere before.
> >
> > It may be arguable that it is too small to be copyrightable and
> > there is no other way to express the idea behind that check, but
> > in any case ...
>
> That's what I had been assuming, but then you, brian, and Taylor all
> pointed out how clever it was making me think otherwise.
>
> > > Anyone got a clever alternative?
> >
> > ... as I cannot unsee your patch, I cannot be the one who comes up
> > with a clever alternative, if we are worried about licensing with
> > what you posted X-<.
>
> Turns out we don't need an alternative.  I contacted the author, who
> responded and placed the two-liner into the public domain with no
> warranty of any kind.  I'll send a re-roll with an updated commit
> message.

And of course, in my excitement to send a re-roll addressing that
issue, I totally spaced fixing the style issues you pointed out.  I'll
wait a couple days for any comments and then send a re-roll with those
fixes.
