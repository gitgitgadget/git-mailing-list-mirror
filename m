Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECF183CB0
	for <git@vger.kernel.org>; Tue, 13 May 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099297; cv=none; b=f+r717fHewigFVL5LI4otcvt4Pbs78R8aDYW9dsW0MLD3NwDTZr5ZFmnJQv6WY6pO4L8+KeGlRnHiADl+PU1ZjjBUOhgMPO1Xi6erZzJwpD740lsMPjt5vFyB7Udf17W6uSt7CSGyCVAiuHc9viNOUp4XRj3Y1QrpayTCRRMmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099297; c=relaxed/simple;
	bh=0jusc0JNZcWHgKawUuhzgsh3UXXsJPMLZxxbf4+K5oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaQ+a/NcO3QYlmdhFyjXf3FL4SoWhH0bzgHiksOII8s2L9FIGpWbmfmS4yXYvq5cko7bTl1h/JGCEg3rNf35QwMJIUYmcKOyb0UVUryVZMi245Nwi846+tQzeSOOOYuqq+aFDu1aqxWH/KJI/PTurt2cNiELh6PsAWep0chlpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhItjXK/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhItjXK/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-477296dce8dso58259621cf.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 18:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747099294; x=1747704094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUuGBjAUs/Z/P0gwTt9XYnq01yTwy5yiCY9tSvvMzZg=;
        b=AhItjXK/g/sr5SYtP+h1Xcb0EWICkfhjklPRP7KyHL6E9s/Nc36jUSSwMELPojBc/b
         p5DNeLOlnIuCAoAYnJJm/Ill32axbh/aQbg/wYtwlTxgEYOglq2CEQsoxpnjO3z+PyWV
         zTmPZGGze3qEE2Xg7mo06m5ia82QngD2PJzOTd1Ihc5MFV0FmHopFLVze1Ujp4b0+OGn
         Uw9Aum4aosYLJAOdTl82xxmJp2pQbGL5SgwCqTavR/Iil7WfMaa1/laGhWKa6Uiecyle
         m+ld1etOq80OayLF8bzh+OuMI+yWeLbtdV8aGfxCnO1qT2pIU/XyEuSQaxFuWGsbO8Wo
         nDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747099294; x=1747704094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUuGBjAUs/Z/P0gwTt9XYnq01yTwy5yiCY9tSvvMzZg=;
        b=DF82L7Uhjv4MfAsnK4mvZ+EI98vo+231TCQ52gMcDmJ+/o+T04Q3WFzxRKP4rA0cxb
         9FrXP4SO6e2KerXhq7gEYEvG/jcpzoR67HJ1s4gMC9SW0iYymgk6KDcB20q6frhOfno7
         9FBbAQEXSqS20+7CtI9XIFYjPMQUQuW5/13P4z4m2Ckxkkv00bWQP4d1N4EHuxuSvSi3
         Anm9LtMCqM2K0CovBwWxGviLY9ElE2ULv0NzYwrC5QwExXBR222D2/HDa8gqgGuLnxf7
         Zhm4uz0arnB3f+RAS9kyNmvU8QGHIBHJgIJ/ahKIBbE8jTxGCJyQ1LFaaGBNdjINNswJ
         jp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiybSfAx3/uTM9lv7ndQ0QF7eBtmW3UwL5EACVtd+Q3SbIGVqpfNIj52rH6PVzEdY90LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMXtpHJna9khzRXnHDBybDzyS3K8uvT6NBiBiFa4IUzDQz/D3
	z4JPlQ1Rhkimt/sLLxTKwNJwez/tpnVaFngywD1gWl0cmcBvg0eGD0cuodEXZnkqRbFQooy+iyu
	LGOHtENzAshSgQpTCzHXzgzUUpQM=
X-Gm-Gg: ASbGncvnQPpQUBshB5CsncPYAl1+NYdTa4vvY4vPWmJusPzh5TTweqBWVYEHRohfv9T
	RermW5KhXxESBgTzatVzSBE5zEhwZJ1jIjhuN60mwzbJNJFpbeUJLAv27HSG0aEynHrq4vmwlBy
	iS8tCl8LVeK4cZhcCuEjzEALUirP4JQtRLSDCwgwZIazR1iLCaIaB6PgTcCqRnoCUg
X-Google-Smtp-Source: AGHT+IGHePGfYqCtsOIb/9UGW4S3EJVXhNqAZR6OH2K+DE6jBJSRwLR75RAodR41lc6l18FgVmdUeF452lxLFrSB+1U=
X-Received: by 2002:a05:622a:191c:b0:494:7515:7260 with SMTP id
 d75a77b69052e-49475157279mr97779881cf.34.1747099294227; Mon, 12 May 2025
 18:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
 <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqtt5psor5.fsf@gitster.g> <CAPig+cSbwGdhq66tSk_A5oNGXqpbqFA=ZO5GS1E-ENb+_rY70A@mail.gmail.com>
In-Reply-To: <CAPig+cSbwGdhq66tSk_A5oNGXqpbqFA=ZO5GS1E-ENb+_rY70A@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 13 May 2025 06:51:22 +0530
X-Gm-Features: AX0GCFvzaQvdEC7Ua-XX2caYVNuvDIzqocJU261s_LQB9n83hQHt8GtNZEV7waU
Message-ID: <CA+rGoLfpV7XLB01-5evp=qNX3g9-=za9zH33ceBRnzYe3Og=uA@mail.gmail.com>
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, smacdonald@kaimaging.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:24=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Mon, May 12, 2025 at 1:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
> > > @@ -1404,11 +1405,20 @@ static int do_create_stash(const struct paths=
pec *ps, struct strbuf *stash_msg_b
> > > +     if (flags & REF_ISSYMREF) {
> > > +             const char *tmp =3D NULL;
> > > +             if (skip_prefix(branch_ref, "refs/heads/", &tmp))
> > > +                     branch_name_buf =3D xstrdup(tmp);
> > > +     }
> > > +             if (branch_name_buf)
> > > +                     branch_name =3D branch_name_buf;
> > > +             else
> > > +                     branch_name =3D "(no branch)";
> > > +
> > > +             head_short_sha1 =3D repo_find_unique_abbrev(the_reposit=
ory,
> > > +                                                     &head_commit->o=
bject.oid,
> > > +                                                     DEFAULT_ABBREV)=
;
> > >       strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
> > >       pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
> >
> > Funny indentation, and branch_name_buf needs to be free'ed after use
> > but other than that, nice digging!
>
> This change should also be accompanied by a new test to verify the
> fixed behavior, right?

I will be writing a patch series after checking CI and include tests,
the only reason I sent this patch was
if the bug reporter needed an immediate fix.
Will send a new patch with test case and improved indentation

Thanks for pointing it out

-Jayatheerth
