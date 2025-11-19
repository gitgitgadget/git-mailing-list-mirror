Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E912256C70
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537555; cv=none; b=NLnLbRVJLfIspeD5SlBJ1+KpjL6kAKo/8YPvBBLvhLMazPOveKY58JdepX8dC+1Co9VelC/bYQd4nqi0Mw2wkbUt7XYo/A7yg4D8NowsOkPT6pYuxH4TQyK+I23XcmQexh3fqtEMNsJ22K35o4ZqrT4cDEA4B7ra8Y1uN28hAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537555; c=relaxed/simple;
	bh=0VFxCnZwPsTD0zbOWZBbkcjeWHTNjx/ZNkd+7beR5sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trwIdvcTd9pAIj1x4PvUVPvR3Yph6bFLYEqXvEcIQKyaDiVg3GngR0Vm8Vu6aMFASqbGlGqFJIW1gPv9Lv3wOpOcrhkmAOCrnRL164oxmdJNjRUC8vHYl1eLL4sT6+zBQxQPDOKnrMTKX634adMkDS6+E3JdjWTtuL6SUTcZiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2dec6115bso23531185a.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537553; x=1764142353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hM//Z6yx8asLVynPhYBUefs5fR8HLSkLCXpkxmQ2w+s=;
        b=XZ5grvNDzJdw5UNoqbTPtUl6sAyOIpkWr6n003IIrEEu9AS/+4W9pmuya5xDBOAaiv
         gY4dMj/gH+S5/Bvt18xS7iVs7nO9zvzqzjmjlUJvA4Xuy5Pstu6bgLcrJisMcwecPdCD
         ubXu0zRlB46PwB6rZi8+BDrtCzYtzTog37uVaQ5prmLoxPFsvXkpdrVujjrLYM4lFs6i
         rtsBl6MEcO5PGDqiZqWQX022Q/uaurbgJnUCYMa0iE1bn119lsrEF2ORnX06+afq27op
         /aeDYuCZpxLFD1tVs90NRp0Qk7p7E6Ln6YEYhFwpp8M0do7CdMW1kAxJiKnAz/7CjtWh
         HNdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQsZaFY1Kkp1MWlYItEPTU0U4mstY3BjnrmAYawUjhQay9JNn7en1iBqjF8XWlSLCTQQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlG2X7iFljkF5w/R3dEHPbFRQFYJLovMm17HWk+lbLZr8VK/G4
	A+/CtIkOJ1FItJEUXo3Xi6hTv9yzN/zoUWyISeuMu9DxtDmg1sPwG4C05jMiSobLc0DDPUvfp48
	/vH43VvEi3LY/wF76ENWXHRIaxLNZXc99w/As
X-Gm-Gg: ASbGnctfOs1PUksBLV4pCG456htyIrN7RQPm3ynAfvEk/ge2lOgSB8JobB3VZ+b33p9
	1VAQkEyc30ynnnz2VzDG5gnuqBOQYPsGt7Rk/d5/Gov8kEfo9cHkzSY5oua5JRbAG0yyMrgEp9h
	eSiXH9PwAfsMUi7HHO4OmhjcUBrzmCGG5783bZsIz5MsNHlR0AudafWBI1YI1EcfrMp+l0c8e0Q
	SpSqONtnkTtmQTcx47cf9trXq35iO7poepYXZZpv1tgH9pLuwmdOZ/CZsQOfuejzD/6nsZ1789p
	Tq3w+Btb5cfi0hsl2he++dKV/RY=
X-Google-Smtp-Source: AGHT+IGhBx2fnuk5YIB6fkQJl4ukcXGRJijhQ76xlccOkFUCp0+P4B6zfPWDAo2xRv+YFJKG4/IfgW0N7/sSoWFJLpk=
X-Received: by 2002:a05:622a:1894:b0:4eb:9cb1:c290 with SMTP id
 d75a77b69052e-4ee3140e186mr55599851cf.4.1763537553255; Tue, 18 Nov 2025
 23:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-1-lucasseikioshiro@gmail.com> <20251117151844.14802-3-lucasseikioshiro@gmail.com>
 <xmqqh5usiizp.fsf@gitster.g>
In-Reply-To: <xmqqh5usiizp.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 02:32:22 -0500
X-Gm-Features: AWmQ_bnEGbqNs-K4_jENVXEt0yLv3qmZn951KnSlzrg5VenvPmiAMmraVJ8uAIU
Message-ID: <CAPig+cSMOEWUZPfLQJBWpAgK-cvAUMgD1t2KsVVAMWn30ngwiw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] repo: add --all to git-repo-info
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 1:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> > +     if (all_keys) {
> > +             if (argc)
> > +                     die(_("--all and <key> cannot be used together"))=
;
> > +
> > +             print_all_fields(repo, format);
> > +             return 0;
> > +     }
> >       return print_fields(argc, argv, repo, format);
>
> This would work, but the symmetry between a list of keys vs the
> "--all" option is lost.
>
> I'd rather see something like the following after a #leftoverbits
> clean-up commit:
>
>         if (all_keys && argc)
>                 die(_("--all and <key> cannot be used together"));
>
>         if (all_keys)
>                 return print_all_fields(repo, format);
>         else
>                 return print_fields(argc, argv, repo, format);

For what it's worth, I had the same reaction when reviewing the
previous version, and thought about proposing the same rewrite but
figured that such a comment might fall into the "too subjective"
category, thus omitted it from my review.
