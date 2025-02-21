Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D211FBC99
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179233; cv=none; b=RLyOmYfP6umplZsptsQIVUq4P/I7cyP60KoZMdgC8dC68FsDnr6xVa4j4DLkYBjdLCvSz55WO3MUyEgQ7D8IyT4Fv4VFoSoivz17ThjJr54Bc6Grjx0NilVK1B+BC1Cor7ZLGdCr1k1d2SPVWbMl/XfZsx+SthESWVQ4CRnJfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179233; c=relaxed/simple;
	bh=lP79ETGgzGBeTBSbj6A5RUMrfgY40vYdfebHMg9VLOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jd/HLyMKOBWxReCp/fxbDRFQkGbbhBtGTMT911oOVl6GSE0fkl5RSZeLZrC1f4y6295Xy9qQaIXWOL9+BHZW5abVd9lC/2285KiACgjxhdcVldl160nyCKIdH35SdhjnplCdPWC1LP6KNdzxPlj8yrEOSUYumK8tJh3UFKbmnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq2XzU5V; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq2XzU5V"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso3764783a12.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740179230; x=1740784030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSV+U0a/irl1Srz8EDL9cJ6DAJ22Ef55uybXoaF5ZsQ=;
        b=Fq2XzU5VJDKbGzlIC0ihQy8ooEiJUsq+jAUK1EsIlZTOOt7y0f6XTP45+fyw/Yb9jC
         SIdAv+qwusRGYjFq1FkrwRT0rVWmBY7vWy0RRM8DKmk6eAavwJVdipUFqLSJPehIAowy
         QkJB3J5umeKMv7xMBwu7KCHqF9YURdzqbOsb7aJs9HTyVUm1uBtV+WhmscdUxY3ZTugL
         ut/nTXuw9cuGS1ITMlF3GPXdSYG/WZKxSjP6Ru43Tx9hPHJLXRRbpOgRIgCay6gAj+E4
         j0O2PnMljuRsLzuNJKPfQnR+TMTET7aacgOu3cU4rNMEY2wUYXbqjsHb+HilAqwZ5Qv1
         ctWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740179230; x=1740784030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSV+U0a/irl1Srz8EDL9cJ6DAJ22Ef55uybXoaF5ZsQ=;
        b=Ug1SAJOLZG6tZ5IEYymoClKd3ZoIGBIqNvLvVs2if6lrGXvMRPVAOY24X5U7bigoGa
         Sjsl4Sw+LPdIaFM6RJPJY6xn43E6PHwhCT5/sg2vfwJxMZJRCDMUQlRE2NvDeixTpg5s
         fhJdwJC0FJ/OQEe3wrGVZMqDp7D/plwTEio5YIxXCwR4EoczHQFNZaf0CDaw92MWj9a+
         2K8xmYYWmWNwctyk0s/KRdd2sO3C8FOyxoc6YtDEqZxDftPMIfYnRAIyYu7CkeqIo3mN
         0Fg6ubjgw+p0ADmq0Bhc0u/Z96zNuDZbbYt3oOzMYMdl62LqdVFgAA+AHrGA8PI56TTr
         TeAg==
X-Gm-Message-State: AOJu0YwjogcUccmt4OKLijuRwQhBcHnr2gSmHCpPj0JtPFAuteQHjpiP
	f91mIkBV6NoVV99FcL07NNZVrriE8xgSs+nOO3tICUo+FzZVwyBWXO0j4eaob2T9mgznuZKhCWR
	gpR7yTIDUIkMaLL4k4ga//EPRtQA=
X-Gm-Gg: ASbGncvD45n/66wGVQgsq30NRQtezATxjwHF/yHzjVwogsjLUZKm2HQl5iZI1bPDdsK
	qMMSdJ/Cw9LbfRH8qmPM2k/uu3cVZC3WjuSmnfsxysD1jyLdlHK57BI/S58uQXGndM+ZB4wH27a
	uajBoZF/5xsw==
X-Google-Smtp-Source: AGHT+IGHZ2hyOhPCbozRwlZmUGk/fy8/e993OolbylQUlcEmZ+sy/AsaGSWWOVoApaVNPhnQVOiWK/BUAkdLKALtrQQ=
X-Received: by 2002:a05:6402:2688:b0:5d1:f009:925e with SMTP id
 4fb4d7f45d1cf-5e0b7104037mr4843828a12.16.1740179230213; Fri, 21 Feb 2025
 15:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
 <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
 <xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g> <CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
 <xmqqcyfbb35h.fsf@gitster.g> <CAP8UFD3EpwK3edfBfqRWmcncRFG--Q-yHR=K1wZnDHJs56ZipA@mail.gmail.com>
In-Reply-To: <CAP8UFD3EpwK3edfBfqRWmcncRFG--Q-yHR=K1wZnDHJs56ZipA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 22 Feb 2025 00:06:56 +0100
X-Gm-Features: AWEUYZl-un9rZ_jP7b4vuJ3n3dqoo8i8DIsGfJGAWoPQ4VCTBozdLlt1t2f7k2s
Message-ID: <CAP8UFD0xsZWDnH9kLJ4eWfzq4nvAm+qMHcdbZSf0d4-yPG9+5g@mail.gmail.com>
Subject: Re: first bisection step takes quite a while
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:24=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Feb 21, 2025 at 6:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:

> > >>  * The "this is good enough" logic currently allows us to be within
> > >>    0.1% of the real halfway point.  Until the candidate set becomes
> > >>    small enough, we could loosen the criteria to allow larger, say
> > >>    3%, slack.  This code is written but not enabled (with "0 &&").
> >
> > The above follows the same reasoning why we chose "division by 1024"
> > in the first place.  The illustration patch postulates that we could
> > be way more aggressive than 0.1% while the set is large by dividing
> > 64, without wanting to loosen the criteria near the end of the
> > bisection session when the remaining set is reasonably small like
> > 1000 commits.  So we cannot rely on integer division truncating.
>
> The code you posted above uses 10000 as the threshold, not 1000:
>
> 10000 < nr && abs(diff) < nr / 64) || abs(diff) < nr / 1024)

Also if "division by 1024" means within 0.1% of the real halfway
point, then division by 64 means 0.1 * 1024 / 64 =3D 1.6 % not 3%.
