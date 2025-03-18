Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9ED1DF240
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333820; cv=none; b=KCPa4C4E0B5IeC6g1FOimU/pQQtDiXp/hmC04uy3P1DKu4iYMs1ZcYUH4s1KttlxjDbq+IxwfXPhVSZj5gl9W2TpUm4cFpMuD1PBLQRaB0RXXNcdiOY4xBM1tdCZcZI2ODoMc8mU8hR7xS4upW8nbn2AxWQyJcfAFvCnf9x+sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333820; c=relaxed/simple;
	bh=xBv94V9rCnjagSRoZYgNHtgn3PFV6yNlxXc0POHiMZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVoduUEalMTfjf4xyhhwZQMUkFGjn8sYtDdVrVkqQ7g8VStBPlRFIC113O53EypmXOLGyrWtZTUsSHNY4RJR5WLZLVDmHzogbH3t6DM0QPYM3DYwLKrzFpNQKu1Tfap2GgwtmzFj1jJAqx1qoCa9PKPgdwwjwJOMr5Xn8BWtydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f9c5b09dso3511876d6.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 14:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333817; x=1742938617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmnp2qGGBI6cEkKW7e230++8KwVRlGBAPIBmjLwu7MU=;
        b=IH3oZsQy16k5WON00oTuEuGJWXX6gdrp1GvR89+J2LB+CG1q9gXXGo+xKlu+joWg7O
         IB5yIV/aKClzoT+wbCBWy8fibQXtcqk6lbDYM9m0BdrSqvREYYW46TxrlO7bAw12xfEr
         MUWKbQWaSjgkbc+272aPm9WFas43/ne7dR+56vCzIqhWyD9ZzVKmGX36JasW5hLfdCuZ
         rIwRnPJ0OQDjrz5iAuUroLw2dBV2FOTdRNBDzlZcV6V2TOqHUz33hjH2YViystg+Kdin
         +4WPigVsz1r9kNxeOQj5H/1mjxBNUgbx1DplXQuO/NRjHgeO9ozMbTsUBqUJM4wUaeIf
         V+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXDSiAzEcUNMBTYqqj0bypJRTRP0RubcPtqafgHR18Kwhro/I4t7/A2l51rX5KuUv6P7nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vv/lnOU4HK44Xk++umsGaVp+uQqG/ozq1vWx0OtkoLvFVPni
	LD8YJWvoIyAblWmbZVtCSKUkly67yHkaxLt/KRW7N6zXMbLi8t9643Lvv0yh/uWRnTfYOAVbaZr
	7X3NjzeBPHxKjZBgiZVQZASyKL2o=
X-Gm-Gg: ASbGncvH473Yd5IVUOoyapK9T5e8oO4U9gd275Xtyhje1EGXpdUdTncnvjuKyBxFyXi
	+O15B+ucmKj395C+bP0UY8IlTlZFdZywObrCXh40DWDtBilYXYX2oStQi965CL1mOqgAM7TzNYE
	qqhnAdcdoTdKJXBTGjKmZQ2fP+RfrCBo93Zdl4Rhr/47CvHqM9gVEMIQAjkyc=
X-Google-Smtp-Source: AGHT+IFWX1vc8Ce/RMkhyDw0hyPVAF6cyG+6ZVzMU7IsKX2EeNQtX0bVEbclLQKsboJzOd+lBR/36JJWb9Rv+DfbAmY=
X-Received: by 2002:a05:6214:cc7:b0:6d8:8283:445c with SMTP id
 6a1803df08f44-6eb2928eba8mr2492006d6.4.1742333817435; Tue, 18 Mar 2025
 14:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1918.git.git.1742299111861.gitgitgadget@gmail.com>
 <CAPig+cQrCdtN4+hyZyPWQuvnoetarbcgkwKU7cD-TpzfzK=jzw@mail.gmail.com> <xmqqiko62kw5.fsf@gitster.g>
In-Reply-To: <xmqqiko62kw5.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Mar 2025 17:36:46 -0400
X-Gm-Features: AQ5f1JoXRbEEWi38DS76ZMOUVDu7_mDmpctUazNhOhqnKjQEf-oV1z58KXk4PzE
Message-ID: <CAPig+cRm+sc+Rk-4SuQ5CrPeZLG2Nzz9B7+6OZxCq7tV5mzmBA@mail.gmail.com>
Subject: Re: [PATCH] [GSoC Patch] Modernize Test Path Checking: test -(e|f|d)
To: Junio C Hamano <gitster@pobox.com>
Cc: Sampriyo Guin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Sampriyo Guin <sampriyoguin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Tue, Mar 18, 2025 at 7:58=E2=80=AFAM Sampriyo Guin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>  t/chainlint/chained-subshell.expect | 2 +-
> >>  t/chainlint/chained-subshell.test   | 2 +-
> >
> > Let's not touch any of the "chainlint" files; they are checking
> > validity of a completely separate tool ("chainlint"), and have nothing
> > to do with checking Git itself. Instead, pick one of the t/t???-*.sh
> > files.
>
> Yeah, these changes to make them use test_path_* are not "fixes" but
> something else.  The first step for a contributor is to understand
> why "test_path_*" are preferred over "test -[def]" and in what
> context, but touching these files shows that such understanding is
> missing, unfortunately.
>
> I find the "as specified in Git Microprojects" in the patch
> description the most disturbing,
>
>     A simple fix as specified in Git Microprojects.
>
> as it may be an indication that some introductory write-up is
> misleading potential students in a wrong direction.  Our mentors may
> need a bit more handholding at this early stage of dipping your toes
> in the water step, perhaps?  Or is it up to the aspiring students to
> do their homework?

I'm not sure where the GSoC microproject ideas are maintained these
days, but it may indeed be the case that (at least this microproject)
could be spelled out in more detail to help lead newcomers in the
correct direction. If not already mentioned, at least these
clarifications probably ought to be made:

* only work on t/t????-*.sh scripts

* pick just one script (so as to avoid exhausting the pool for other candid=
ates)

* only convert `test -[def]` instances which semantically are
assertions (i.e. used as part of a &&-chain)
