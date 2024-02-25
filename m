Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87118AE0
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886504; cv=none; b=gdjhF0fBLFtyco766tp8uUpP49Hkvk3gh+iGuImS/jBADX2JaqJ04n5i0OOkkx+FMBnJt3MTUQjuWeJIJi/BwbCY+6AOXfPdakjsz5BanBB/pp5kpISlsRWyVy/+z4m76LLe0aHeujxOfy3n5TizvggdsfrBiixDy7j+Dcc6h5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886504; c=relaxed/simple;
	bh=y4OgptrnUIM73IJwJoiN+IxaHnfbDBBkFog38k7u40A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipjewyJbIIqAX/szyTo8GrhOnQPdQtw1rITridpP1QvuENepJP07qYUi2eFEjxXu5IAOs/moMXpsqtXl0SdjZKrUn7MlD6kYY20B8s7kJnqj0HITQ0mScLgX4oH6ZkLJRfw8LGGw0sK9VxB23qfvu1Lpb9pJoESOtEe4NeTedxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68ff609f233so6385876d6.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 10:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708886501; x=1709491301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sbw3HXwy1b3Fm+mD+KxYeTr79te2+/VtEWCPf3oOLkk=;
        b=VST2+NaTivosc3DllrBs3wUohFSg6geQ7GalPILkNmqNoOTQjvq0Ou1bUfns3EPYZk
         V5sH+69dHcH3mw5/Z97ix2/InWbkVRESJ3krWIZlq1aqFJoyjhOJ+wo5bY+Fvt7WJEth
         xIRGPoJ0BHAoSK17rg0VxhzFFiDd60nIeBcziQ6NSR0SqmPW1yNYSttyQvT69w+HJFgB
         dxDWic3/1kKzFrxFbB94wk/RHRTK6/+EZZjnXHRZW5E6zGqL77CLIgvMtuSAW2e3QM8U
         pwKmbW7Yebi3E8xNlu1zz87A5cXPqTmfKXebpZloUO21prLZEau/W6CbT4hH7aSsClap
         6PyQ==
X-Gm-Message-State: AOJu0Yyq1nAf23U+kHV6dZuydPedlR64mLzAKMEruZ97fUr7JsjA5lwv
	adKd+MBAi9LBka24BvWoKlRhW2IwaVs32Q4NT/PWH5fX8RRvcwolhnFic8c9oGXPGx7Wp11G/j8
	7O4xEBbXSD8ZVmFyJ29I82DZyboaI67Hv8XE=
X-Google-Smtp-Source: AGHT+IGZGA+vUGh4sdi/uW+CB0DaFC5jYe39wnPZpLxpBXVqq9fDNcD77gSZ3TBFtjKHoIIQHFYlrbbUMky5EXInk60=
X-Received: by 2002:a05:6214:3381:b0:68f:8c21:dfbc with SMTP id
 mv1-20020a056214338100b0068f8c21dfbcmr9145657qvb.18.1708886501446; Sun, 25
 Feb 2024 10:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240225112722.89221-2-l.s.r@web.de>
 <CAPig+cTvs7Ckg=k1T+N3N=yT840xM2DYf3LV9NZhii8+c1nkbw@mail.gmail.com> <5dea0535-4b21-483a-a10a-bfa8e9e85650@web.de>
In-Reply-To: <5dea0535-4b21-483a-a10a-bfa8e9e85650@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 25 Feb 2024 13:41:30 -0500
Message-ID: <CAPig+cThAYjf4DU40dY9jCnjL0FsVpYFhcsj9YdvW2Q=c=ZDBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t-ctype: allow NUL anywhere in the specification string
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 1:28=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
> Am 25.02.24 um 19:05 schrieb Eric Sunshine:
> > On Sun, Feb 25, 2024 at 6:27=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de=
> wrote:
> >> Getting the string size using sizeof only works in a macro and with a
> >> string constant, but that's exactly what we have and I don't see it
> >> changing anytime soon.
> >>
> >>  /* Macro to test a character type */
> >>  #define TEST_CTYPE_FUNC(func, string) \
> >
> > Taking into consideration the commit message warning about string
> > constants, would it make sense to update the comment to mention that
> > limitation?
> >
> >     /* Test a character type. (Only use with string constants.) */
> >     #define TEST_CTYPE_FUNC(func, string) \
> >>  static void test_ctype_##func(void) { \
> >>         for (int i =3D 0; i < 256; i++) { \
> >> +               int expect =3D !!memchr(string, i, sizeof(string) - 1)=
; \
>
> I think the temptation to pass a string pointer is low -- if only
> because there aren't any in this file.  But adding such a warning
> can't hurt, so yeah, why not?

The patch just posted[1] by SZEDER reminded me that, on this project,
we assume that the compiler is smart enough to replace
`strlen("string-literal")` with the constant `15`, so rather than
worrying about updating comment to mention the sizeof() limitation,
you could perhaps just use `strlen(string)` instead of
`sizeof(string)-1`?

[1]: https://lore.kernel.org/git/20240225183452.1939334-1-szeder.dev@gmail.=
com/
