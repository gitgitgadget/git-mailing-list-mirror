Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D351F4199
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064634; cv=none; b=XGS2SPkRkjNp7zj5f3Mz46GqFG3rWTwFNk0nXc1GPFEtSfGfg3yXk2gsPLXZ8ML5Xz2x7YZlNZOYyrzVjpHGA6n0bjjMZQ6Uw7X4VZmhmMs+X2Wc7VK13zu6dgNDx8EMqg0URohbkvP7vmamw08oP3s3HDuGHe3Tj0jzJusTlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064634; c=relaxed/simple;
	bh=dbu9TYcgQj4Jvc0mWWKUnLxD06vSyUq+Z1K7UA3HDJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBBeLnqrX4KpTr2BZRVFx0x4ECivxoouuYSR4Yw5dvC/bhlnQkMA0o2ivq+TSR5I2AqPo2E8sHREAQEQwEfy8AX0FzgDolIhn1tlqaPalgSQ8X/n7BNzaeYU4aDIMo25lycABmjyeZrt9/bWW4ZNN3++N+w6SWAR2O8v9B4Qa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDw5GS6P; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDw5GS6P"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b40c7d608so423961739f.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744064631; x=1744669431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5WCRjBPTnX/wC694W+zBsnBIOhT5zBA/M4Ab5qNU88=;
        b=eDw5GS6PNbRCHgjAs72sqLTEvw7Ro0yBg0Lo3SjwdDwhC+xI8Ag6i4Ukt+qGED1NoN
         euS+Wxq334LQbkEBnN9cFWc/MlurVUFaRNPfyZPGoU6GU3MskHHerooC6L3xj9U9yvHX
         3CnC6vL7NPaoP1sWXluJCYkG7+jHBr2ZXC4y8+k5d82/IRnMfypI1NfmuTHRW/hFP/mm
         S3x12wEh/Ip+iKgqqYZqnNE07M4nJMs3/OpfqIl1P31vgmmQRlpjLjsCpJkOHSCiTRrI
         pd0P5PTpPXl8BkakhatVmIoXzEhuIXREn8OCQQxSTBhb3xojKBuQZOy8reTugoK9M23e
         /7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744064631; x=1744669431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5WCRjBPTnX/wC694W+zBsnBIOhT5zBA/M4Ab5qNU88=;
        b=k+vc0EJh3G5fnignvZ8zYPrZocDfDKdT+qWZugDvRK4Xf9LmuiBg4bp4hJ4X0NfNTO
         tG6k3ONgRdnUjP9tLcoTORDkfG/gbaQfDZmPuja+Awe66fjRZIFdHUabQoJHxfAFduuj
         Fm+XyVsujijgTe0RkzxkN24vzhmhru0LJu+3/30CN7FHaX9R/jUbuqXEQ8iPLqEezTh+
         X5jyn6iIgyKMqtANm5vEuAnXAmVQXzSlM8A3DHwz8t9fXJq3BJ3Lq+n+i0bKOF7qUNRE
         lgbLiJYoqubzMBe9nW012p4MkOp9JDH/y8M5sC+Jw6VN1G2Tmv+MjBPRDJrBZInLi5LO
         FgMA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0mc5qLZ8ybkCfqBV8dmC4l11OUZJrCkjxw3PLyXLtyyO2MS+fjk8CZlJsT6DHIFEh5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfj1udSHFd2ygBJDShV2sDELg+zOKI6X+rSqCzt9Ik9utm04V8
	vgwEsgNAqXYOGY0Bnftm091U1QYSSNyWLhkRM813gEc23UWBvOhMtnqt3Ut3MZiMwz1JT7yHo1k
	LLs2WDy59TYK0FaNMn+Oz5/UOMP++yaU+
X-Gm-Gg: ASbGncsqXu/x7ivfU90ylrP8g5htnonYbNa1bcGzT+sJVICcaI3UM7SmhaBMcU7U2Cj
	ekPwhxFzZSOCjkMrjsHTy1mcZthWGTy6wu2l4r1ebQFJxeUCTplYpIwnruoy1OtN9P5KYEBCH2j
	5KFpAp39NWeMUIzysecaGtJOChL8JWIE8xrHNW09qDICq7cQbH5JcO5Anq2AM=
X-Google-Smtp-Source: AGHT+IFkON5BheoH22xtYWkqGa6RUL8xkDKChemH+oSQ0KypsxpA99FQ49rPn10JMubaqe0eyUgsH+04OXPu9JU0bQM=
X-Received: by 2002:a05:6602:379b:b0:85b:3fbc:e55f with SMTP id
 ca18e2360f4ac-8612aa3080amr1415824039f.4.1744064631494; Mon, 07 Apr 2025
 15:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
 <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com> <xmqqiknfn36y.fsf@gitster.g>
In-Reply-To: <xmqqiknfn36y.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 7 Apr 2025 15:23:40 -0700
X-Gm-Features: ATxdqUErz9aJRretM6fiYMDBvicTRVpio1fCH5We41llrSTUposWut7hb7Kj3JY
Message-ID: <CABPp-BGN2JCt9BJ0wQqtgNLhD6Qf19PMzYWpjgpJ6O2OcyRCXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Debug merge-recursive.[ch]
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 1:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series does some preparation, then moves the code shared between
> > merge-recursive and merge-ort from the former to the latter, and then d=
ebugs
> > the remainder of merge-recursive.[ch].
>
> Help unconfusing me.

It was an attempt at humor, which importantly relied on the sentence
you stripped out immediately before this part you quoted, namely:

> > As a wise man once told me, "Deleted code is debugged code!"

With this sentence as context, "debug the code" was a funny way of
saying "delete the code".  Because if it's deleted, we are no longer
affected by any bugs contained within it (and that'd be true for both
known bugs and latent ones we hadn't triggered yet).

> I've already named the topic with "debug" in its name while queuing
> the original iteration of this series, as I was on vacation and did
> not want to spend more than minimum braincycles on naming, but now I
> am back, I sense that the use of the word, and the proposed log
> message for 6/8, are overly suboptimal.  If you are referring to
> fixing remaining bugs, "Debug the remainder of merge-recursive.[ch]"
> is not how we usually describe our fixes.
>
> I suspect that the overall sentiment behind this series is ...
>
>         Such and such bugs existed in the older backend, but now the
>         newer backend is used when the older one is asked, and the
>         newer backend does not share these bugs, we can simply
>         remove the buggy code specific to the older backend.

I'd say the sentiment is more:

   merge-ort was always meant to be a replacement for merge-recursive
   (and has various advantages -- worktree-less and index-less
   operation, faster, fixes some bugs); let's convert the rest of the
   callers over and then clean up by deleting merge-recursive (as
   well as removing the extra test scaffolding added long ago to aid
   in the conversion).

In other words the bug fixes, while real, were not the thrust of the
story.  I showed a handful of people my existing commit message and
cover letter, all of whom found it a humorous way of stating that
we're finally replacing merge-recursive.  But, since this intent
wasn't obvious to everyone, I can re-roll with some clarification.
