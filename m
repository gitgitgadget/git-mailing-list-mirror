Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D6D657CD
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336056; cv=none; b=P6mVQ99PREhoMS1llgvcGFVmieivnz0TFhkk49D1F2GqcNURqzH7sUfp91i+auCm/VFJp3F2SBNmxb6fOiPmngkYSzyu/nrB/JPkAbhkNJhqnCpauSwW2GNPrSwgpUtfWxjZJnuc8O6OIaawt657zOI0uHcJacFy+78tB74ywn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336056; c=relaxed/simple;
	bh=0Yt1WbPUcAMeCM+6ohHk+aUoJAPnVqeyAJrK/iniJVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr6N+tHR/npdIw87Ye0Srnxo32hETFV7SHykD4FZjmwXnLK4lqp9uKa38i5dBDrmkjFP2d7cMFZn2H8CCA4gaWZleYqWqyfb+PRHDrpXeog2y28nnHgF/mrSt7AEb1PEVMMrKGExNRHYE3Q9dwTWRzRQUvbLNpW17+jfFuYnbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78edc3e7cd9so227100685a.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713336053; x=1713940853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfOpYk6x6PVZk9wyn0aTqnIfuSIKcKRgqoA5/gpUs7k=;
        b=I1KoTjQbksMCDEI8oHbKfCzvxsm7WRB/lAQg0Un0811GHams1pQvSop0gtP7J61Zw2
         sCDjXIDTzcQgUEwydFqeGUdv3Abg4gizMMEEOCtFXpc9+YoDS/AtpVZfoH73N4vRg0ST
         fJ4+tbnsGX0XkWhlt3exmyT+zg+knAGnmH79vHuWmNiSFXH6VYAjNZF0Z4WPJjvOySaM
         kVViYYqvFU7FOkTZNNupIQhqku2TtvTQ8qJHgX5Cebse1VKLjUocy0IkAgpQ4ojo6Yu/
         UyhBnq5kisLBZTEkrss9zBcWwtopA59Fl0MNh6V1qHuLKE3tTdRVdd/JHzmYIK4Y/Rsk
         r4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVrQ2kaYEFSbS6MdcjVb8jOjlgh5qKLvTK2OqQ/HGofr7b+6IVazN5uTJ1Ha0AVSZT7vHbyFfGOKqvX9b+AfhNKLtEL
X-Gm-Message-State: AOJu0YyG54QazA26xzVi6jBGr5TgmF1YbWPk39opNZXViIm8Lgx1QdOp
	4hbXf/BbKzBEJpJmrXCa8LH78T7FI4BLAV/4vkJbpk+qnqp2LLZr0DuQOGYn9HQ8TZX8wo7BTtJ
	D0z3jvGCiD8GURiPmLnZF0YGZ/YkyBS1f
X-Google-Smtp-Source: AGHT+IHRD2up06Ust2dxucLsBXa7PFEXaD6nOmdoLCT2cEhaUAi0+WrI5/EvlGzKwi35eZre44KHNHl04yST1H1KyMM=
X-Received: by 2002:a0c:d804:0:b0:69b:7eb7:a6ac with SMTP id
 h4-20020a0cd804000000b0069b7eb7a6acmr6341802qvj.51.1713336053212; Tue, 16 Apr
 2024 23:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
In-Reply-To: <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 02:40:42 -0400
Message-ID: <CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com>
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:34=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
> > Fix a bug that allows --rfc and -k options to be specified together whe=
n
> > executing "git format-patch".  This bug was introduced back in the comm=
it
> > e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
> > about eight months ago, but it has remained undetected so far, presumab=
ly
> > because of no associated test coverage.
>
> I don=E2=80=99t think speculating on why the bug is still there improves =
the
> commit message.
>
> This paragraph could perhaps be rewritten to
>
>   =E2=80=9C Fix a bug from e0d7db7423a (format-patch: --rfc honors what
>     --subject-prefix sets, 2023-08-30) that allows --rfc and -k options
>     to be specified together when executing "git format-patch".
>
> The extra sentence in the original doesn=E2=80=99t really explain anythin=
g more
> about the commit. Except the =E2=80=9Ceight months ago=E2=80=9D, but here=
 I=E2=80=99ve used the
> =E2=80=9Creference=E2=80=9D style (not the Linux-style) which contains th=
e date.
> > @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char
> > -     if (rfc)
> > +     /* Also mark the subject prefix as modified, for later checks */
>
> I think the code speaks for itself in this case.

Apparently we're thinking along the same lines since we both said
essentially the same things in our reviews.

> > +test_expect_success '--rfc and -k cannot be used together' '
> > +     test_must_fail git format-patch -1 --stdout --rfc -k >patch
>
> I don=E2=80=99t understand why you redirect to `patch` if you only check =
the
> exit code. (I don=E2=80=99t expect any stdout since it will fail.)

I had the same question but left it unwritten since I noticed that
this new test is modelled after the test immediately following it in
the script, and the existing test also redirects to "patch"
unnecessarily. So, if it's done this way for consistency with existing
tests, I don't mind letting it slide.
