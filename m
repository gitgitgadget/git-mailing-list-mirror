Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA11402456
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963048; cv=pass; b=hFFaELjS7N0ce2QNMNfoy7nzfD1zS6KjIqLAkd5D++pX4vPwNqwC1QedFgYOtjt3LJ06fYV3HZzL5+BVh1n2RKPErxWI8yZFwEGXAM+x6FF1Gas5rUz46ll0pv+2+SQ2fu4SVL3ankUosWaEUYjAyRK1LesHxSxBRASQkiSi6eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963048; c=relaxed/simple;
	bh=YAiPSgwwuyuz7wNizeOPrSRNIVTarz4+AoY6Me3f520=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRT0jS5rwWvG7/63mOtOiTVpTgXlkfSH74vi64JsNxdeWLaptJZLj5wqmOikswPu0ETC8slC1oql7n4j4phPY5D/v86IwLwMPXsTVuUQXQzzwTvwXTkEnU1L5aB/VAUmtVH8IwlxD7WNZL//IINIEeyz5lPYd/cZ1mRkqFCG/HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGeY48Td; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGeY48Td"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b4915161fso48471f8f.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773963045; cv=none;
        d=google.com; s=arc-20240605;
        b=Zo2p0O8LiUGg4d6yrabUNgFEtdtgpTfPgW5Wv3tYwhmDrYJrabbArqW7/JixcHsiKj
         ZihVJbnMk/bsxhDXSnhLFz5C3NYkdL5Eyi3KvwZkjN05iPwqAJXLDwH2woJ5W8SJ9Gf9
         FlyPk8IsgKrgGalhELLwEnFlrGd91ABdEiMieHiWyRc8IQpZL0c7p1POaALqDuTk4jWY
         HVgb4iJTqlwWWNeiW44JQzLTbfWVjjsICoX8F2sua6Rs7DB9FOFsD0QCeJp1KJF3h1Z0
         K1j/kdR6E8lmEnMBrlS7TzO4Ys4LNeoD8rBR6nN9lYpaVQ6/FPb7std4WG2BnIe/2iED
         9Qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWFzCkfTFYYO1SJt7AzGCWxrmHm6u08vJnuIsNYebxo=;
        fh=M0kOffcjipX+oYlHNbmAmNrMnTlNNU773tCHjjFOfAs=;
        b=gyIHX6+NE66wmrORL6Ag/8bbuBxzAvWkocMhSSjqtbfi0oFbOvR5NVHZir7QxfeK/m
         Ru1j32G95wm2y/TxC22XL7BBtM/zX8jip5aylntWFJ+c+9H48BS96hRl7XycmwgXby5O
         jyt1L6MqOnG9JKo/f0SPDJ8Rdu+C9uRwV0D3nW7CqOqOg5XTIqQmctruoPgidThU5W6Q
         dr+Vrw5fP6FSlQ8o0a0hpT6ALannVpDMTyAHcSgoWoaWq2438+rswxWFtnGQctSJCrt9
         dzK+uxjnmgbdyX8WjUjMEdzS7WuafyI9Qo2UZJgb7K4T8AxfViYjIaMRyCwnCSDDHb0R
         1UMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773963045; x=1774567845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWFzCkfTFYYO1SJt7AzGCWxrmHm6u08vJnuIsNYebxo=;
        b=bGeY48Td6mjnJ3qE04rldlDxM/GqgrishK6FHimfDC8STRCWPmZOL6as33S/OK9sT+
         T8KJbEWF4k+Xl8k7xyv8Oze5K2YQUpOPr/bPKjRM0Ruj7QfblBGK5IM2OiKZiqaHksj/
         qmEvvHYCoggFuDh9bh9s61FldpsyfGv03e7o20e51+m+kJdiEnIRwsEAwrAzaDCyrVYp
         UFcw9j1X1JqJUhgvuHJITnbigrRsPqdO2bwTi1/T7IfgvfD42zcD3gpqzkPEBW/qIm9Z
         J4aacQKE/kIWP2YTrQXllJwxdweRwPn+dCNlLeG0ABeG9kosCw2ZK5Bh9Vh9SUZ5jHQ/
         g22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963045; x=1774567845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWFzCkfTFYYO1SJt7AzGCWxrmHm6u08vJnuIsNYebxo=;
        b=n9CIqoc3myLQFk9w1vAU/xIttQRWYHRT51E31HdjEdKi9RS1uHJnz/GxuXS+Ok6nj8
         2FMvnR2DoFrpi57a0Y9Q5D7oT6cf+3NvqeJ0UWsm7kEL0uk1GCZ4uxnZ9MV7p7NQOs8t
         7ZK1zkXv2extblKYCYwuApehDXdnTY2ZGT1MTPD+GDeYBLtTVn61aVhHSWx+Hbj4NF9d
         KLFThPJs8IuBnMXmv7cqwFjseC2gg9MMjBn8IRSqIh+O1q5g8J7fmq48tVBY87+u+yLD
         fnSD+UAA45/MnvpT05Lbf8i7zQuNaOZ7CpKhWDYdHt5Fc2dQTNMk6Nm82I/fPZIMFGDW
         JeVw==
X-Forwarded-Encrypted: i=1; AJvYcCX30GLwlPtMSsc1cS4Qh1m3XKWmg1pEyBhqWNJA/ubNIov+nwHi2jkzC4Wz8Lqo/lujx98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iU5Uf8ze+fBuGWeOYy73sEFUkXsFx547dUZe/k/jtUv6NxKL
	c2VzAwv9tS9nwytuMLjEXciaL+HdA5Wf4XXyVj4msyEbYarSlRDaB2PGu3qZmPYrD/ykFHaQl15
	WC542f7SM1wwUd8EM8AQ2aKAHhZ7px0RdMr9a
X-Gm-Gg: ATEYQzzT/PSzfouAugaBzIZliKX9h2f1Oo6BAskIB5tyFbjpQbj7JTI5GlHrY2+0g4u
	rMwskuMn0mXKoWbeo/VxuFjjRaleDf0/dmyF4v6mFhJVoEbPun3HiBWIXMXcMYYlUrReKrt8T3p
	3Xz4J2nuIwrEcKWLfHPS9Lzav8UwXUONu+19QF8Rw0wB5+tJIy0kro3rx5PEHjgQjR2qs3IsJ3b
	YKeE4CHX0AeKtqbF/CX4LM8v/cXi1Eona9LNgA3L6oYa+hTEOInisKSS7niQyQm2JU+NdA++WVl
	m5Ftc6g=
X-Received: by 2002:a05:6000:2484:b0:43b:4396:674c with SMTP id
 ffacd0b85a97d-43b6427d7a6mr1773688f8f.55.1773963044824; Thu, 19 Mar 2026
 16:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <pull.2120.v2.git.git.1772463265865.gitgitgadget@gmail.com>
 <xmqqikb08ax3.fsf@gitster.g> <016df393-a36f-4e5e-ab6a-eb661f5c84cc@gmail.com>
In-Reply-To: <016df393-a36f-4e5e-ab6a-eb661f5c84cc@gmail.com>
From: Yee Cheng Chin <ychin.git@gmail.com>
Date: Thu, 19 Mar 2026 16:30:08 -0700
X-Gm-Features: AaiRm50afVcqImpzPdw-KdCZUntZ1jgFgJ9SVZa6QkcM83D70Q-DL3djpDUSHrc
Message-ID: <CAHTeOx_edyC_nvXd7cU5o1498K6K9FVky1PG3ArDrWKrZ87pjQ@mail.gmail.com>
Subject: Re: [PATCH v2] xdiff: re-diff shifted change groups when using
 histogram algorithm
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great. Sounds good, thanks!


On Fri, Mar 13, 2026 at 3:23=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 13/03/2026 07:07, Junio C Hamano wrote:
> > "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> From: Yee Cheng Chin <ychin.git@gmail.com>
> >>
> >> After a diff algorithm has been run, the compaction phase
> >> (xdl_change_compact()) shifts and merges change groups to produce a
> >> cleaner output. However, this shifting could create a new matched grou=
p
> >> where both sides now have matching lines. This results in a
> >> wrong-looking diff output which contains redundant lines that are the
> >> same on both files.
> >>
> >> Fix this by detecting this situation, and re-diff the texts on each si=
de
> >> to find similar lines, using the fall-back Myer's diff. Only do this f=
or
> >> histogram diff as it's the only algorithm where this is relevant. Belo=
w
> >> contains an example, and more details.
> >> ...
> >> This issue is rare in a normal repository. Below is a table of
> >> repositories (`git log --no-merges -p --histogram -1000`), showing how
> >> many times a re-diff was done and how many times it resulted in findin=
g
> >> matching lines (therefore addressing this issue) with the fix. In
> >> general it is fewer than 1% of diff's that exhibit this offending
> >> behavior:
> >>
> >> | Repo (1k commits)  | Re-diff | Found matching lines |
> >> |--------------------|---------|----------------------|
> >> | llvm-project       |  45     | 11                   |
> >> | vim                | 110     |  9                   |
> >> | git                |  18     |  2                   |
> >> | WebKit             | 168     |  1                   |
> >> | ripgrep            |  22     |  1                   |
> >> | cpython            |  32     |  0                   |
> >> | vscode             |  13     |  0                   |
> >>
> >> Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
> >> ---
> >
> > Thanks for the updated patch, and sorry for nobody responding to the
> > patch for over a week.
>
> Yes, sorry for the slow response. I agree with Junio that this is
> explained well and looks good
>
> Thanks
>
> Phillip
>
> > The detailed explanation of the issue and the inclusion of the
> > repository analysis results are very helpful; they clearly show that
> > while this is a rare edge case, it significantly improves the
> > quality of histogram diffs when it does occur.
> >
> >   - The removal of go_orig is correct since g and go are kept in sync
> >     throughout the slide loops.
> >
> >   - Clearing the algorithm mask while preserving other flags ensures th=
at
> >     user-provided options like --ignore-all-space are correctly applied
> >     during the re-diff.
> >
> >   - While ignore_regex and anchors are not passed to the sub-diff, they
> >     aren't currently available to xdl_change_compact anyway. Given that
> >     compaction happens before regex filtering in the main pipeline, thi=
s
> >     is OK, I guess.
> >
> > Let me mark the topic for 'next'.
> >
>
