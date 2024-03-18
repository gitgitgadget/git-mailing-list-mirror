Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772858201
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789690; cv=none; b=cQWHVWQdLBAxzrejYW5OqveO5IUmLnqURIWq8ty74P0EImsa5h5ES25J4Kwq4L4JfHynCtQv+5zakQYWTspABTqoIOO3zxNn8cgQXt6DMfJ9hPFBkA02lZkgvUseTegMQO0y93IHXvx0opEqjiJ9VJ/23iZ9ttbFqGlYmgiO/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789690; c=relaxed/simple;
	bh=PWVNxpHvVB3APmdef/ll6hpLITVzsx7UIhxHRwtMf50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XG+KSiPfDYx6Q0sS+q/UfDBvs+u3uPCubGxaQJsUISOONMR6QMmh3T9oG/TzkkLTXZnO16lP81RxqAJlgNmaTR0efKAbJFAQLV9POOAdGaimtdxevYwAjrf0Q30lt4wp3fPDXHAZt+Fa1GTDu9uf2IGXp529UEFOCbc6QudGLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-696315c9da5so89366d6.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 12:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789687; x=1711394487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fCe1ZaVPiqRXIfHuGNo/pLNcbiJanry3Zkqj+ndXcA=;
        b=jZ8LKJT6az6sLYPZ0cTQV34Dd2KIs0TsyU8QdwAK4J9ue+0eSfRpk0FrggKhHojZZ1
         Xn1PRkt3jiCy8pVVhbGXJK+vLY+90NckckkOr9rlzNXkbsAmqP5bQFFHgp1QMpm8bEMo
         8nedOzhoFvMiP3ilsfSVYHyuVzEV2ufgUn38BDD6XiPK3clsDKi5cZQv1qtGueJ0qVtC
         xQ3aB2zi4QyPgLR+hQuBrvZtjUQime70AtMgdvaDPWBdjB9m9rNGj8KQhwRfWU0m3mhq
         N1g/Nq1cRBj5LX0Ef0xNA9tM4/krgJOouSNrizKOzE/jS1Zh+4IZCwc868Bp46ay2xai
         UNpw==
X-Forwarded-Encrypted: i=1; AJvYcCUP7YHXLJ258/0aCfpH7t9uVIbpb1J5cYM18pLM6jXMSo1gqYHCOzJC5JsBb1AKOW+VVuXaM4iN+TSSXaJZZWQkvpbQ
X-Gm-Message-State: AOJu0YzDV41xMGrsOCOWsBLKHLQ7iiVkq3z2atdZP5WlhvPLl3z2BJG9
	KSFXlwPsDWoHXRhVKoWWhwCVkc68xreQD97IrmKy4hvbxDVgLuqHOYMTDzaXxMqYLerU2o2B7cL
	U0kVFDC3Z22RwGXDQqrKyeBVeN6o=
X-Google-Smtp-Source: AGHT+IEQK2LezjTn91zu0Qn5a9hSRpBudvT5McQtl26O702qbtCj9KMUbneA5of82WdYUxPjuknM7cOLyyjDEDJG3Xw=
X-Received: by 2002:a0c:fe0d:0:b0:696:22f1:cd1f with SMTP id
 x13-20020a0cfe0d000000b0069622f1cd1fmr2346385qvr.40.1710789686895; Mon, 18
 Mar 2024 12:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710646998.git.dsimic@manjaro.org> <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
 <9996af464aabe2bf594c63c237d7a6e0@manjaro.org> <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
 <xmqqttl4kvch.fsf@gitster.g> <62a4ec0dace46d7c56e75dac9c42c297@manjaro.org>
In-Reply-To: <62a4ec0dace46d7c56e75dac9c42c297@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 18 Mar 2024 15:21:16 -0400
Message-ID: <CAPig+cQgejS5dFpOYkMT49kwn5zvn5ihvyFqViFwHhEmtr9mqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:37=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-03-18 05:38, Junio C Hamano wrote:
> >       sed -e 's/^|//' -e 's/Q/   /g' >.git/config <<-\EOF
> >       |[section]
> >       |       solid =3D rock
> >       |       sparse =3D big QQ blue
> >       |       ...
> >       EOF
> >
> This looks quite neat.  Furthermore, I think we should also consider
> the already existing tests in the t1300 that contain such indentation.
> As I already explained in my earlier response to Eric, [1] the choice
> of including the indentation or not seems random to me, so we should
> perhaps consider taking some broader approach.
>
> How about this as a plan for moving forward:
>
> 1) Sprinkle a couple of tests onto the t1300, which try to be
>     focused on the verification of the indentation-handling logic;
>     maybe those additional tests could be even seen as redundant,
>     but I think they can only help with the test coverage
>
> 2) Create a new helper function that uses the logic you described
>     above, to make it simpler to include the indentation into configs
>
> 3) Finally, propagate the use of this new helper function into the
>     new test and the already existing tests in the t1300 that already
>     include the indentation
>
> I'd be happy to implement all of the above-proposed steps in the next
> couple of days.  Sure, it would be quite time-consuming, especially the
> third proposed step, but it should be worth it in the long run.

As noted in my other response, while such cleanups may be nice in the
long-run, the bug-fix patch series under discussion should not be held
hostage by an ever-increasing set of potential cleanups. Let's focus
on landing the current series; these tangential cleanups can be done
in a separate series.
