Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70563BBFE
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533626; cv=none; b=PCJ9CrHxYicU/92U9YtEg2p5ASGaHV6HD8Y60JapV9z5KZkhE4qWKaZGZjL4lzO4fw/suui+Lx740kltT6+0ztZNbVYkVaESpN3KoEvuOVrH4A+3aTqgnL4KykBulrHXETk0SAurunQz6zpGPMocLzYTQZhpuc2bne8D5mDPwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533626; c=relaxed/simple;
	bh=2/4FjZxElQV7ilkFrBr069Xn9APCJ81UuOJxmNRT9SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSnoA2JnRDzaH9+5TvN3dUUrSkrWRu6WIa7A8qVyqCrTo3P4Jvp38Ye+3oq9ua8536I7nnsMLlTnaDBKlFzLGMnTeVb1vZlw5NKjgwaV+evF/zITPFIrOZpffc5lEvImjOJKgRCKVftIfWt/sWraAipU6Ok1P7mGMg+aGlS8ggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69107859bedso21664916d6.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 16:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712533624; x=1713138424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/4FjZxElQV7ilkFrBr069Xn9APCJ81UuOJxmNRT9SA=;
        b=s5vh5wwLeYZICxMQn/jRPjzagS5Jf0m4FVFHirGCNqyU5ggL+CslQNtBW0Ev5JbFpQ
         Hs3IlPQs1aqQqZxFFOjcEcmorlIVdY1v10AsuHpOXU2i1H4RSfJZtilk0L6LUSXD3Xcx
         /WKcN1wPnl6JgIIQu60TBWZZE+5mqdXWzFbBx4ebdnXWBIWNucCTwz8xnm88mc5wxJeL
         rZaf9vuuT7/kFY0Xek3JaFgyGWQszQ3VH14LUfqm7fp2YyTCNvcST5cJIHbMQd/swOYB
         aWTu07ndLvx0TVIGIr/LdaCBnEY+7QqAFkC8Gaw9hNRIYIVjLJ+REcEQ/PfaigHN7ga+
         +L+w==
X-Forwarded-Encrypted: i=1; AJvYcCXeOaslJeDV/zINa8GEBSTOg01Al3OU96es2j3eQr6eIRZPr4grKLRetMA9ziVs6a2lBvhbl8BMKI2Xod9SG7RgrYV7
X-Gm-Message-State: AOJu0Yw2sjQD0c9zkjWkwjHzmjjPUonmaXgoWacCObzBgJ51d3aWgo9t
	RtB2ozGC8Xy0CQB3wBB9/TJkHnb50Qv8Q5ZUkiHLhiMo302FjQCG8yQKbZdf2/4BAw7CoIKbUXQ
	eEcjZTYaJDwUK1UwvkbQe7miPSmE=
X-Google-Smtp-Source: AGHT+IGtlfBwDQ58nORWbQVImPJ+mojtMDmW4aRcT4FDxo6+kQiCs4usFCqQr7E8191uTEG5Q0D8VdwOlsH9JbJ/kJQ=
X-Received: by 2002:a05:6214:aca:b0:699:3ed0:f303 with SMTP id
 g10-20020a0562140aca00b006993ed0f303mr9874345qvi.60.1712533623700; Sun, 07
 Apr 2024 16:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
 <A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev>
In-Reply-To: <A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Apr 2024 19:46:52 -0400
Message-ID: <CAPig+cSu5dLoDew-efAB-H95B53fteDGNO=_1jc9i_MUqdpw-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fast-import: tighten parsing of paths
To: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:19=E2=80=AFPM Thalia Archibald <thalia@archibald.d=
ev> wrote:
> On Apr 1, 2024, at 02:02, Thalia Archibald wrote:
> >> fast-import has subtle differences in how it parses file paths between=
 each
> >> occurrence of <path> in the grammar. Many errors are suppressed or not=
 checked,
> >> which could lead to silent data corruption. A particularly bad case is=
 when a
> >> front-end sent escapes that Git doesn't recognize (e.g., hex escapes a=
re not
> >> supported), it would be treated as literal bytes instead of a quoted s=
tring.
> >>
> >> Bring path parsing into line with the documented behavior and improve
> >> documentation to fill in missing details.
> >
> > Thanks for the review, Patrick. I've made several changes, which I thin=
k address
> > your feedback. What's the protocol for adding `Reviewed-by`? Since I do=
n't know
> > whether I, you, or Junio add it, I've refrained from attaching your nam=
e to
> > these patches.
>
> Hello! Friendly ping here. It=E2=80=99s been a week since the last emails=
 for this patch
> set, so I=E2=80=99d like to check in on the status.

Pinging is certainly the correct thing to do.

Regarding `Reviewed-by:`: that trailer doesn't mean that someone
merely read and commented on a patch. Instead, it's explicitly _given_
by a reviewer to indicate that the reviewer has thoroughly reviewed
the patch set and is confident that it is ready to be merged into the
project, at which point Junio typically adds the `Reviewed-by:`.

> As a new contributor to the project, I don=E2=80=99t yet have a full view=
 of the
> contribution flow, aside from what I=E2=80=99ve read. I suspect the laten=
cy is because I
> may not have cc=E2=80=99d all the area experts. (When I sent v1, I used s=
eparate Cc
> lines in send-email --compose, but it dropped all but the last. After Pat=
rick
> reviewed it, I figured I could leave the cc list as-is for v2, assuming I=
=E2=80=99d get
> another review.) I=E2=80=99ve now cc=E2=80=99d everyone listed by contrib=
/contacts, as well as
> the maintainer. For anyone not a part of the earlier discussion, the late=
st
> version is at https://lore.kernel.org/git/cover.1711960552.git.thalia@arc=
hibald.dev/.
> If that=E2=80=99s not the problem, I=E2=80=99d be keen to know what I cou=
ld do better.

Lack of response may be due to the series being overlooked, or it
could mean that nobody has any particular interest in the changes
(which is not to say that there is anything wrong with the changes),
or that people are simply busy elsewhere. It could also mean that this
reroll is good enough and reviewers have nothing else to add. So,
cc'ing potentially interested people makes sense.

> I have several more patch sets in the works, that I=E2=80=99ve held back =
on sending
> until this one is finished, in case I=E2=80=99ve been doing something wro=
ng. I want to
> move forward. Thank you for your time.

If the additional patch sets are unrelated to this patch set, then I
don't see a reason to hold them back. Feel free to send them. Even if
they are related to this patch set, you may still want to send them.
After all, doing so may get the ball rolling again on this patch set.
