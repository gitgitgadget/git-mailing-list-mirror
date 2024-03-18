Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF51CD23
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 02:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730109; cv=none; b=Za2MWZaHhgNw2M40cG048LmxAzTXUbnsQVIu/11yD/NTKoUmc5VZ6S6xMGh/zVdYuOk3Ll7BWThXYukSdfevGXizqsb6FCusp4ov6Scu3MeMSSIrmMrdaO65Nm4aQZdkjBmU/XegkFSTOdgdQt/oPnYWMfAVtpw7ftbv7QDHdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730109; c=relaxed/simple;
	bh=CGYStHxH9fV+P34+nWobdENw69/G6BFT0B66h+WCxuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDAmJtJ3NDizgDCwB2gKK9cQ+PqK/nTNnKaeA5UHMrqUsFslrKi59iDfu21EogXoBmW/FmlK4P1ObQqaAzr6fTanyyyFMG0J412WxlH37axqlMA1fEwfAhU1Rh8B/fgc/aRvtMePpT7cgfy1m1VLyeNh4+dGl6uirQWJG5tTsww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430a7497700so24831201cf.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 19:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710730105; x=1711334905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxzs5y1wvqAqoc9nQ/TwFp9Aryu65u2NRxE57LrIMyM=;
        b=Anodw8MDgjlLdOUxm6KbwJUKGIMMhE2HdDQ6Xsz73CwYcdBX+gK13gH9M15Tf1Nk/1
         OJD11IHQBCOplDZJHIur63T6wf2ltBFXKL1ghD10DWNbP6HQONEQhTCnFANbTHw7LoTl
         x95OJL71HgAe5qpZvE2s2aUSblaQzG0bWlsQQ/GEiWWBVsp3vTTgeEyn5ul6eQYm+ev7
         FOjBsdyGUhztR8SYcW8z3T1nHuchDN0+9vOON3K5c9/nNwndr0BZcznQ3sPy4269lzTg
         lqB2wq43jJ9MKqsU+NIxFP3AUFc8wBgH/YbEbgGYmFYOe1uiqdQFFCdmIIYL65h5nB4O
         UF7A==
X-Gm-Message-State: AOJu0YzYk+daepT/hL1LDx1qF5lsgZdiAWeFnp5thQSORmv4nIvSGiXL
	zrbBNsUKw5kTme7syfG9UD3wt3CGMPUpvs0p7bMbFTnPqiItjmx+4aO4FmqkE3QWBpne00AHJzP
	36a87ggoBKY0TNRG06/3DtKGdj14=
X-Google-Smtp-Source: AGHT+IFTl7FjnQEMNHwJFbqqSkuks4RekopS2dqGKT/KDF+b231hBKcj7FuJttc6evLUfxi3O9UeNJyFpL26NByeiqg=
X-Received: by 2002:ad4:5984:0:b0:690:aba2:d1fb with SMTP id
 ek4-20020ad45984000000b00690aba2d1fbmr10059350qvb.16.1710730105566; Sun, 17
 Mar 2024 19:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710646998.git.dsimic@manjaro.org> <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com> <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
In-Reply-To: <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 17 Mar 2024 22:48:14 -0400
Message-ID: <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 12:50=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
> On 2024-03-17 05:21, Eric Sunshine wrote:
> > On Sat, Mar 16, 2024 at 11:48=E2=80=AFPM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> +       x_to_tab >.git/config <<-\EOF
> >> +       [section]
> >> +               Xsolid =3D rock
> >> +               Xsparse =3D big XX blue
> >> +               ...
> >> +       EOF
> >> +'
> >
> > The <<- operator strips all leading TAB characters, so the extra
> > indentation you've placed inside the "[section]" section is stripped
> > off. Thus, what you have above is the same as:
> >
> >     x_to_tab >.git/config <<-\EOF
> >     [section]
> >     Xsolid =3D rock
> >     ...
> >     EOF
>
> Yes, I was already aware that such indentation ends up wasted, but
> having
> it makes the test a bit more readable.  At least in my opinion, but if
> you
> find it better not to have such whitespace, for the sake of consistency,
> I'll happily remove this indentation in the v3.

Readability wasn't my reason for bringing this up. As a reviewer,
every time a question pops into my mind as I'm reading the code, that
indicates that something about the code is unclear or that the commit
message doesn't properly explain why it was done in this way. People
coming across this code in the future may have the same questions but
they won't have the benefit of being able to easily ask you why it was
done this way.

So, the ideal patch is one in which the reviewer reads the code and
simply nods in understanding without having to question any of the
author's choices. And the ideal test is one in which does the bare
minimum to verify that the condition being checked is in fact correct;
there should be no extraneous code or behavior which could mislead the
reader into wondering why it was done that way.

In this particular case, it wasn't clear whether you, as author,
realized that all leading TABs are stripped from the heredoc body, and
whether or not that mattered to you and whether or not you expected it
to be significant to the test's behavior.

> > On a related note, it's not clear why you use 'X' to insert a TAB at
> > the beginning of each line. As I understand it, the configuration file
> > reader does not require such indentation, thus doing so is wasted.
> > Moreover, it confuses readers of this code (and reviewers) into
> > thinking that something unusual is going on, and leads to questions
> > such as this one: Why do you use 'X' to insert a TAB at the beginning
> > of the line?
>
> Well, resorting to always not having such instances of 'X' to provide
> leading indentation in test configuration files may actually make some
> bugs go undetected in some tests.  To me, having leading indentation is
> to be expected in the real configuration files in the field, thus
> providing
> the same indentation in a test configuration feels natural to me,
> despite
> admittedly making the test configuration a bit less readable.
>
> Of course, consistency is good, but variety is also good when it comes
> to automated tests.  I'm not very familiar with the tests in git, so
> please let me know if consistency outweights variety in this case, and
> I'll happily remove the leading "X" indentations in the v3.

My assumption, perhaps incorrectly, was that existing tests already
verified correct behavior of leading whitespace and that the tests
added by this patch were about internal whitespace. If that's not the
case (and perhaps I didn't fully digest the commit message) then my
question about the leading "X" is off the mark.

If these new tests are also checking leading whitespace behavior, then
to improve coverage, would it make sense to have the leading "X" on
some lines but not others?
