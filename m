Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BD23C9
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743208493; cv=none; b=HLZBOdVk5xtTQTcnXhJDJI8FemruodAAzlw4423+ZoxkodGrSLwCQqd1n4+QF0Reu+BNlcCkMVCouYKe3DkFtjKNvrIDfF/GtNL1Vq5FTIdu+1o0abFn+TfRAYI4mBmnviDIPTi+8TME50kZ12HqfciKDnZiiO8+K4YE3agfeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743208493; c=relaxed/simple;
	bh=5V6FT0mA4S0pyG2O1SDrpbxJWWYQ4LZqSzyL1rgRc3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEdoFgG0vUaJrXwpAN97hGdokV+1wsHFfBKKjDfW0b2OkqZpgnkeAIsYbf6Zoo8lqh8pwgpQk0LHwf7KOHkRVtMX3u47WeinPmiCI34MCqfaa41BxNFezcmJOpoNQ5j5W2/4IMrukcSHdXCxhAhV2qf0yNAHbQxAUTix4tdW2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8UYwPqu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8UYwPqu"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so5046238a12.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743208490; x=1743813290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfpLtRzs6aHz+M3VBhMt3P2kPbe4gtIiY0qOh9WswvY=;
        b=C8UYwPquahDckGNEXLN9ds7bCAk1dRd3kpr0GV9smWU7UCy/a90desSfUCUuT+9l97
         oqgEr1TU1HfVY77KcAzDwJ/PLAN74ldMTMqGU7UrKCxPzL2ReCblM72PDuF/r0rIX5vb
         GiI89+AgIxtngmMWSsQsN/c1cM85bDhKcf3cBGU8w1RP9YzZWMT0a6Ed0ugbMQNovTkp
         1MxMRw0SroXsyzOoJTDibmWy6CaNIY6zyY2REMwXD4hh5GJuiCAoxBS1d3nY6J9brDWV
         d+otvRD67inPsKo1+EPwIgNzul2CPgn9TbxdtOKr/UUIbJKYy2TMbrPLwDfHpBJyM0fG
         ZSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743208490; x=1743813290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfpLtRzs6aHz+M3VBhMt3P2kPbe4gtIiY0qOh9WswvY=;
        b=Brd7j3v+LWfCArwRS8zCCB+h+he2af3F9Ys1ukjSMl+ilKhWKtRo6yo/kjH0NluFIW
         lLwdnZt8wHCtppneRLK7B1UlZMA1FozuiU1wkXxKZ0jGBHdVYmc4edyCFWFK29l/6y8/
         b+eOKGLUCZknEjUh9UEkKLAunNWBn8E2JmSzkYq9G3KGdPqGpBbgUzvkSbhUePOSOGp+
         CQlRWnQXqsTs1p2iM9KanGWxr0y66t2zrxmVbXgknEgOpMLmOTUQI6jyuCNf2KVTLhGD
         6IItj6+i8e2FJiJ1c0Ssg1tLUBRDBAG/tzE+aqlpTNPDO0ao226ATwmS/8Lb83mVuLgj
         R3vQ==
X-Gm-Message-State: AOJu0YxLEv1V+ko2KRJMpT1AsLzg1epA0P3qozSZysKsFCuYWdIRjm2x
	G+rwOHmh/Piz8GE6cFGYwEerxiec13xux01hvdvs5fUXW+4KqRZj1U9mPYLYA0mulTNcGISBrsL
	Bk26ml+5o8j4gqUHfL5v0uS9IBPKSHuSn
X-Gm-Gg: ASbGncs0cq71+Ao5ALfES+yJ7XayZbdInC6+FJLr6H2uRRgubiqYf8GKM4r389t63+d
	9WxFr49JcsinuUpfR2rnFBH/GcEmllxB3Tpk8PJ4jCUkvJIJz6RQsUxef9JBCrwUOoizbb1k9sq
	yUxztSkpU6r8ZgGhvVtNKC4VkuCFtNq9n41+m7AsliexPuYbSddixNmzVYKQddVcpaSux+oc0=
X-Google-Smtp-Source: AGHT+IFfGDU6yM7BJf4ERJrATaJynKcuULSk70BeI44HiiuLKfvc5t0PrMdCi4SddKgnwUd/uk340laDf2wcozxoYv4=
X-Received: by 2002:a05:6402:35cd:b0:5e6:23c:a242 with SMTP id
 4fb4d7f45d1cf-5edfcfd4ef6mr1019634a12.18.1743208490104; Fri, 28 Mar 2025
 17:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqiknwhsdz.fsf@gitster.g>
In-Reply-To: <xmqqiknwhsdz.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 28 Mar 2025 20:34:39 -0400
X-Gm-Features: AQ5f1JrRzf34Sr84JXc1qG0S3GjkfMEAbgd99qNOFBWpJ8_cKsattu77SzvLqzM
Message-ID: <CALnO6CCcE0zyqUtFOkBZetj9HCzg_mmnWq=+gOEaRn9Np32UKQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2025, #07; Wed, 26)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 8:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> * ib/diff-S-G-with-longhand (2025-02-12) 10 commits
>  - diff: docs: Use --patch-{grep,modifies} over -G/-S
>  - diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
>  - diff: test: Use --patch-{grep,modifies} over -G/-S
>  - completion: Support --patch-{grep,modifies}
>  - diff: --patch-{grep,modifies} arg names for -G and -S
>  - docs: gitdiffcore: -G and -S: Use regex/string placeholders
>  - diff: short help: Add -G and --pickaxe-grep
>  - diff: short help: Correct -S description
>  - diff: -G description: Correct copy/paste error
>  - t/t4209-log-pickaxe: Naming typo: -G takes a regex
>
>  The commands in the "diff" family learned longhands for "-S" and
>  "-G" options.
>
>  The core part looked mostly good.
>  source: <20250212032657.1807939-1-illia.bobyr@gmail.com>

I'd be interested in seeing this land. I think I can read through
review comments
and split the cleanups from the addition of long-form options (both of whic=
h I
think are generally improvements), but without signoffs in the original com=
mits
I feel like I might be overstepping on the intellectual property---and I
certainly wouldn't want to cause licensing trouble for Git.

What's the usual way to proceed in a case like this?

PS enjoy the vacation Junio---I'm hoping someone else will reply so that yo=
u
don't need to :)

Cheers,
Ben
