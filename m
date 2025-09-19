Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2963B9
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312045; cv=none; b=nB8jj9pr4k+aQ0CTCJ1UnGIVVcYrIBxiaqTXXWNzC9O8BRQjWxgLjl2F5as2FtVgkI16TM3kfilZWsI7HjOQianSvgqjGX27gCCNojdNV15K1N/BSmptXsNuFA3MM6VQpPKusFADE2A4j5IjJ8ZuZoQKqE7MXMqB6xJfVfr++kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312045; c=relaxed/simple;
	bh=mDAnQK9cORmHLxuuR+Q1oK1fZQsip+zHYHoL7k1AIC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+41vMTwNlIE7zc8alEx0lY54UGUKcooRGHYgp7vJeRxt7/e85RWPx8qyQV2MaFbDa/cyzLDmKvNMb6yk136RdRlIGPL6ZL9LBYmydTHpEYIbksMHuYeo4J3hR4InmKxRXm8as78SgjiAndu08CfkWTDU3F5zqfuKQ/9iMRbFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Ev4Sd+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Ev4Sd+"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3618e9ef33bso20933571fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758312042; x=1758916842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgb9oZ+Iv6DJ70bZF2MeHcgL2I9585rB/sruzDFp9tE=;
        b=D4Ev4Sd+TtbR8O3veL1s71f6DuZl8UvLA2c6yIPz8roKrC5RpKDTgBdDOIWYW80WoL
         8ZownPDg6erXTqEse/eoWjsMnNHZCYntxMlX3aVX9sYSGJ1oHvhxC+A2HJ+X/hVFlg7O
         AntnYULNwKDS2HYBqHr6Yedb7Vs+pVZ7Hnd4cy1Vs9zaT3+lNpxeCPv/tvRQ/jgqMSMo
         lwelLl/fegslyx0WvRlKjn6Kh1Oxiwn2rzzSPS10ojF7Bq1ktn8+W8nZMLtypQigqwgq
         ptDrCGZi+SISjOq/bwbCNv8LCG0YWFd+EzZx1T2pF646qyXNhuhAgr5n/TS8wzZldUGY
         XVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312042; x=1758916842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgb9oZ+Iv6DJ70bZF2MeHcgL2I9585rB/sruzDFp9tE=;
        b=Y/NbbPyR88Be024jmi45e9JcrGHO+ku1qcJobq0xzLGPFRQupmu7aeBjHxZWOS2plw
         qxBE5KcO3Og+2DBdDcP/ZWfWGEG7ivdD3DwV4VVyVBf/K+PfPXe2M8WsWPzGMazb7yVB
         YywqLoA1bK8TRsFgJ+3xYfse7reNgd0z5LIrzdriR0mtYwaHmQmxBJXwIY6d+KFKOQNl
         HaR9C3u0Ra+mQ4QnTdESFFYMnxhMydMGORpjtgaDf2GgVENr55aPiqM8RGvfmkcXZmYr
         QlKJ6K7DVA3EmCRNKNDP0TRVsxCzX4ylsjEliakfQrFtlmSOQWp8Zo8d700VPKmIQ8ZU
         7OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKb28dej5yCpV4kLjlbmOZZWJCP9IMgjQez2c92BP0U7shSmZ+YbX+01VHwK8vi4baTS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrXgnT+ZbgtL03AhZ2+GY+KdNoPowOcoBLMUah4O1MBVvjTWu
	fwug+pZkF02df6W41VuKLp6BoEtu9794jYBs4IuwzF18Qdweqr0Lvh3nHqn+hOqrCdbZw90JX5G
	gJMuI5n/g7RUHxgrg/aIW4W/6GYyC+mI=
X-Gm-Gg: ASbGncsK6wrsjCHdjIrdHhkYwWIlZ/F/Doq1eWsZwSmXC82CRPnp6pC8M/qBKoOJ3SR
	TWWmttCFScBV5o5TtY2VecJt6Ovnwt48HRiL0y/hcze81LIu4WJw6hatGrc1tNsYCb13ktWEJ2q
	1t2AdnCPu5ipZPxbQokIHp+FH6+h7jEq3gxcGzpjWh1zMaz7WmvN/cHS7mnHE7+h7B7N+sSv1Gs
	ST+g6Z6
X-Google-Smtp-Source: AGHT+IGEWltVKrtarJDzrYhZW+KgQrQJeg3gFgwzWXiUmJ/Pu4h5ksLFMMrZOY4C+dpCGY55e0XykMx25tFpM7ZFEKA=
X-Received: by 2002:a2e:b8c7:0:b0:336:9d4e:6b8b with SMTP id
 38308e7fff4ca-36175291176mr28244261fa.20.1758312041652; Fri, 19 Sep 2025
 13:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
 <xmqq348i5kqx.fsf@gitster.g>
In-Reply-To: <xmqq348i5kqx.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 14:00:30 -0600
X-Gm-Features: AS18NWD4PCiFn5NmfNA7qq4P_yyQ-khwPSoBpbRGbpMeD8K5q8EmxcuMGlMHjO0
Message-ID: <CAH=ZcbCRzGGR1RFTWV1Zo7bm+DScx=zOJ=Ov-WkaQNrDN9w1Nw@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] make: merge reftable lib into libgit.a
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Aside from the comment already given about the fact that the
> proposed log message does not explain any reason why these change
> are necessary, this step and the previous step are fairly hostile to
> merging the topic to play well with other topics, especially given
> that there would be topics in flight that may want to add, remove,
> or reorder these two existing lists.
>
> I wonder if these could have been arranged like the following instead?
>
>  * Drop "REFTABLE_LIB =3D reftable/libreftable.a" and the target that
>    runs "ar" to mantain that archive.
>
>  * Leave "REFTABLE_OBJS +=3D $objects.o" lines alone.
>
>  * Add them into LIB_OBJS so that they are included in libgit.a,
>    perhaps a single line like this:
>
>         LIB_OBJS +=3D $(REFTABLE_OBJS)
>
> Wouldn't that have worked equally well for the (unstated) purpose of
> these two patches without incurring unnecessary risk of mismerges?
>
> Similar arrangement for xdiff.

Like the previous two commits; This one continues the effort to get
the Rust compiler to link against libgit.a. Meson already includes the
reftable in its libgit.a, but Makefile does not.

The reason why I was trying to get the Rust compiler to link against
libgit.a is because I wanted to get Rusts unit testing to work. If the
Rust code calls a C function from Git then 'cargo test' needs to know
about it.

However I think I'll drop these 3 commits since 'cargo test' doesn't
need to be part of the introduction of Rust. It would be nice for make
to be able to run Rust unit tests at some point though.
