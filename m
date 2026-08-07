Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E40446C1D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084323; cv=pass; b=OFKDDTqYzN9DN+h0I580upjGiNN230cfHfMvN4WTu5d/Ujv1Zn9BzfHqYfmdxhVpw1r4wSJEgebrO5JItG59HwpXCPklsK72Y43wIJehYsA6rVartK8kQ24rS4RTUyEgtREVgmXJ2KDHOe0vFgTVVFZ5tRbMP4b5QPsb3hmTjuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084323; c=relaxed/simple;
	bh=5+UC0+QpjdlkzkkDIrH9p9H4t6r0Qp0Owx90hw1hGnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhCujx+nBPQZKcLPFSp7TBJAa5JtEH/Bd2d9ctW3/nGcjo+PVsaFSifZ4iZl/VyRo4muyxLcPcnvufu8ZbGOquWNhgGQpCi6u7Yv/vsTS8Njsf8wayQR742pOJX6xmuC0DUnz/Qxy3d2bQ+PVZSds7T1p3z3pVeNTqDT31tYxOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM36N0Ks; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM36N0Ks"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb68bdf53aso1241486a34.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 23:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786084321; cv=none;
        d=google.com; s=arc-20260327;
        b=h68V/NUlHHwzrM+1Jqga94U2+cY82pCmFOdk76eM5dgzFteey4I9D0DuFQAt0c2RXs
         uCgjWR9iPNYijJJ6pyrxsZxLNdmU2csgy/RuW/Fc23oUwZJR5KG85FeTRsakOxUcmf6Y
         eZM6sXMqpxRMIo2u0kkfo+azVjVbwL3oU/lYGSRYv3b5fEbCX97c9rtGIuaZaxu1nLEM
         EN6BUPcx0RJFJzwC8hg4eZQgg79MlHvF5qnlP845hmE2ZLKOBVkvUVHeLSzz1Wlcdgkz
         3W6qMffsMrCIdUiPgCSnCMZ10g+HqDNAvXHZY87mCp/QQCc3VAz8jqrCmiZtkeHiq91w
         /nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aDJ+Cadn9zznrSW2cy19wNsy1ZnWDXNiJuwIxt8htjU=;
        fh=K+nwAsTgvJIY4kMWVokCW6lJIm9qzCyizIjWP69oThQ=;
        b=lMg08pM6q+bOd/IxcDf21FWZTMRmHRWG3XIbY4QzvW6cSmaAlKVXKNIILdbcZRjhnb
         K7W0XZKwnqz49ISFa95VTPsh+V/La5jDnzYo4Puv2pJ+/ik5aMLf4EgeualmQjR4EFm9
         iY3IiMTIb21Lb30i0+wzAfDTVNUwYAc83YIca5gXcaFNW3F4PkZb4aujbtaAp6PW27a9
         3GdzcigdSWkK0EP0Fhg1QFuAfwMg88bTwoh66dGXAFigeDEicKlLeD/pv9YAVC1BnYQ/
         yOe5hojzHpoaajdgvfnrme+pe3Ki8PB8cbuL6RD3TgRZwuk+m5sxhY78m5Oz0+hgJwYf
         WKjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786084321; x=1786689121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aDJ+Cadn9zznrSW2cy19wNsy1ZnWDXNiJuwIxt8htjU=;
        b=OM36N0KsZeQ5hVdbQloBpYTUU1K3URELqV7bfNlxdmSz+EIT32L+OvzZgNfSU5NI2j
         7s4Hc4+zr4YeR/6y/emh+SOeE3eReIj7BJidm/8I4wG24Cm0TZ93TtdZJabZ2rT3bBbq
         phMGOK+iGkXYzXcSL05IiZM4EnBopfPfsVDK3+pf/VwmhEbBy4a8qWNY/ZADhMXA2cQ9
         asiosHGY3b7U6TkaeQwEckyC5S8KAO4A8oUKU6Xo0WXRAecrw/bn8ttXqRtdvnO5boik
         XDpiWB+LcKjNdAmg8xz2MZJauSA4/vC5tKlaxaPiwcDZZAQ4aA9VZqH5u+9pHJF8wjYK
         d75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786084321; x=1786689121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDJ+Cadn9zznrSW2cy19wNsy1ZnWDXNiJuwIxt8htjU=;
        b=jTFXgYzFWCqHbsiYf4drvhggGQXVkoSGNhQ9Sp39T/L5wOln7ASyeJqd1yk2My13Dg
         x7bTe6q1Whvy9eLBXbx9syuBiu8y0w1M/ssUIYx+l9zL6qLHoWbquZVBDzzVdfpaTPJb
         RLCU43McK58p8Dr/NJkWUUYSE77gEmKdOMMwDLUowt2nTEG8TlOVjjCkO/WiFYkOk1au
         tVKEO6FflvA+Wdhmx2+5YZ6Qlu6eerN6XYjD7m1VgeFKGSt5xOjU7ypNFjr5zpgdxcub
         1cCPdvfdBE7MGAZahSGGIWHvgUwQgCroo2qB9Ej895ZpyzLxsSy5wEqsHUyhzx4a55vt
         JDvA==
X-Gm-Message-State: AOJu0YwrwplcXwahjNRqng1djJA+eun6Byjv3EJB7kdY6RjxwN3YDbFr
	PVnueD8/ntaHFR3vw82f1Gjji7GZqMeiv8Jod4WyA1A8XqxrVVW3a2MGc5hfGOUmhfv+HLsNZuM
	gRy5lbOeyw+HKimwN80qCJV+aYkyYXss=
X-Gm-Gg: AR+sD13XI/Mnkczy9GEtd6oDDcTzw93fw0/nlokw7mILR4vF82Lmz4tOJFfDJ+WWh3M
	6C6cnnIZCRrXFtgs2IPUThykl9e9YnyJi2on1weG7e3EhG9tjTc6QybLUh3VgdfaUweOsMVbCRH
	NcAGbiovd9K5aM0chY0aiEOS8l/GIZre799iUXOC+g415XjsfIbiKkNe/s4YLdDs3w+YkdFPI8Y
	ZN2TeLXecCOWubAIfPA9k9jkhBOhYO25q2Beu0e6eMuOkC4/50SjFFOBHF4PMntWQm2ALsf1m9Y
	4J3SzVC6+Xl119+AsMg9YbZI1RUjavPXWuOV7A5myI2SmRcAKgxZLrk2Ut29ZhOe+X+r/zkiZyP
	+zzLKcq3HhOTUFOzMYcVPMaDgqgkC8UPQrZuIELpcHQymqHqC3Ws3FSD5Sug3LlE=
X-Received: by 2002:a05:6808:e8c:b0:495:db8f:ded8 with SMTP id
 5614622812f47-4afae019077mr11353138b6e.9.1786084321373; Thu, 06 Aug 2026
 23:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260807013830.698340-1-gitster@pobox.com>
In-Reply-To: <20260807013830.698340-1-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 23:31:49 -0700
X-Gm-Features: AUfX_mzmAecV5tpL55VyuzuqA595nRvHUx-YhW4OBWV10FuASZARO4Z-TEHUAIo
Message-ID: <CABPp-BE0WOD1jRT-fVqxP0uaVuV0-Qu4rqCyL63vaRCEiAUmAA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] completion of 'git [-C <dir>] diff'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> The primary motivation for this topic is that the command-line
> completion of 'git diff' does not handle paths (unlike 'git status'
> and 'git add') and instead relies on the default behavior of Bash
> command-line completion, which completes files in $PWD; this does
> not work at all with the '-C <directory>' option.
>
> This series teaches the completion machinery to complete revisions
> (unless '--' exists), then tracked paths, and then untracked paths,
> before letting the Bash default kick in.  This way, we correctly
> complete 'git diff' command line even when '-C <directory>' is in
> effect.

Nice.  :-)

> The tests are the only changes relative to v2.  In the step where
> tracked paths are completed, v2 did not demonstrate that untracked
> ones are *not* completed at the same time.  Now we do by having
> untracked 'file3' next to 'file1' and 'file2' that are tracked.  In
> the last step, we demonstrate untracked paths that do not share
> prefix with refs or tracked paths are completed, with or without the
> "-C <dir>" option.

I found this paragraph slightly hard to parse.  I think this means the same=
 as:

Only the tests changed since v2.  The tracked-paths step now also
shows that untracked paths are not mixed in: an untracked 'file3'
next to tracked 'file1'/'file2' means "git diff f" completes only the
latter two.  The untracked-paths step shows that an untracked path
which shares no prefix with a ref or tracked path still completes,
with or without "-C ".

(Not that it matters, since this is just the cover letter, but...)

>  1/3: completion: no-op refactoring of diff completion
>  2/3: completion: complete tracked paths for 'git diff'
>  3/3: completion: 'git diff' completes untracked paths as a last
>         resort

I found two minor nits in the first two patches, and didn't spot any
issues with the third patch.
