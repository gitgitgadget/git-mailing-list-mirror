Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903F2E7374
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550666; cv=pass; b=A+u/0h6gGKuvdCIUYVtF2ErYz06P3sie4Ngjot1DK/ysZQV8RGkazx8VPIhnWX7MiMBZzQibA+ilk8aCJBfg4UZG02C/LWxbnKkPXOPqu8q+zqzpfwY3F1PUHR10LjpcjTfu/pw6ZBnWlUiTi6Bo3ZZ6AvO95agALrjWorjWcn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550666; c=relaxed/simple;
	bh=miFcDkop3SfD9AkD2TiB4ILIX2UrMIO5MAZLrl2Notc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrnFVS+jinAAgikC873xC77dZYpfjkqge0HQsXYkXTzb7RfLMB5MPQKZe+nwQpyYnGkf6JPhQBgiIj01pMUbLjCuUyC4wTbto3icxjqo6qFhGJzXB1e6J4MrBFWlzDxuBAUWCLdUQgYqumQdGaPMNOKZwQmBjfdaaCG0zkxOxF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ0pBb7Y; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ0pBb7Y"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0a5354da1so29551045ad.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781550665; cv=none;
        d=google.com; s=arc-20240605;
        b=i7XaYtoxEZzgiViRL9yFAjyWZtkyD3tWpLaFAMU8HY8TWBZEUzcCi9RnkBAIcL1X/Q
         YS6uZG7xFjtezjjjE4LK9cy+jvzDwIfq/460dz9xJmOsyU5CrhMN9LTxR+KIaH9K8TzJ
         Ffjtw3LVZwDKCZ9/KwjJ1/Yb+P7RE8z+gTXmUl+6lul4OVfXDrgZT0ThZ7xVW+SWBThv
         ac8TMGCvurRWQcdLcqL6Lbd/cGJ35KcpxBa7lQdAULJ2vHUP9JvLVW32g7mQti5HqEga
         pTi1vpv2PrrB4RSFaGSzSCy1ZQiWs8VQijLPcptdPXKlOaJezahw3jDksbkRDO3dLvIK
         Ri0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=miFcDkop3SfD9AkD2TiB4ILIX2UrMIO5MAZLrl2Notc=;
        fh=f+h1iMKJi1P64nc1JtGvSKrsrHCTiXkebaRVSaX9X1E=;
        b=d4qaxu5RkZBPV0HwhDzYAzsscAZwBHxsJYXndJx7j8ACjQeFxpwZLGgWJRpFqhUb7x
         qVzO/OoGj7v3OW8xZwxCmjhUztMNskkAn2Qj8w1bpJUR6lTLaNDKI19e1ilizCZ8wYIt
         OKdsLP01YXOiGzG/wJR9aZxOxECulgTvP9vbBPNFdXG4KvSzaJr0AYfBHteUN1sUIkzE
         8CfvwKxMig7XVy+rYwGS9J1NKzQsiTp2QTI8/WPypDVem6q0FnHm1hiNM7ozNE+u8nrR
         aeekoqea7zoOjpI/JY88e4qczaJH6rr8gVBIOf9DrWmAO4Lho2Es7qAD+hkD5VoyUxdg
         l2Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781550665; x=1782155465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miFcDkop3SfD9AkD2TiB4ILIX2UrMIO5MAZLrl2Notc=;
        b=bQ0pBb7YIHpq7ysrOFVuD+QsVbKde7MAExAKEr+QC8cOmSiGrizOeYO87v1Kyfh9bv
         bSewKG6lgflOm6DceeuFmq6FcMZ4wD2vhU6Bw4ZZTt406sp7Oc2T6nDXkQFMf564a2dX
         rBTDXJnKa2H1e0vr3m4zH5/4xO7vjZWkq0s0IMUBlDSzBvgq8fARmIIuNamdjBV6tWWI
         7w7CPfcTpDnEtVZxuFeNtwCGQhhNRh9os+2EX5h0WwieY0Oyi0ThyQ3/cvlzONnRFRbd
         aRUIPATlfgTG72i81DD7fic3iGJN0XePNTr8elfqAYCrwsLgToF2SU+u6ddfnGgdM1Cj
         +XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781550665; x=1782155465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miFcDkop3SfD9AkD2TiB4ILIX2UrMIO5MAZLrl2Notc=;
        b=AE8vlWO4c1hR3kTcm2gQXnLZQB7XYgzp5OuqeeHE3/mS4+PLLOPXmd68updB6Noblb
         sbjdB45V9JCGcMaqEX7/dp+9M2l24xstJ1fDjh3jlpKdvfHjB/K2uDJrlD1u6Dp8sc3L
         UevLSCtNN96qsocOfq/QHrl5vXXvseip0NDaWBLAb4/JlmU4DdZF+z7uY1BzlrOEmW+K
         JufSbJjc+BfdQ/6g9tgzdkTjDg7ccPtLtrcglrKo47j5qeeqeKypZnF6M+lboXplsX/H
         lbC0o53wr/vcGWEJWqvXBZ4VOaOGJx1fAW02mCR+jvaauGUuXhs9CIB+IEUXQlCaDimK
         y74A==
X-Gm-Message-State: AOJu0YxLOIorA5E6rq7D1ZtJPLZm+dfMpQVHWZ+h8VBtbUFlkM17noVy
	a/lJNQV8AonPBI24dfbVFajFSuY34dCnf2vYOiq3gtCuha+bCkNVGWgCIzd6GV0LlZdyOrNIL43
	ApfZWLAnoQCck0db+O5nPwXF2U4NkRls=
X-Gm-Gg: Acq92OEtZ7AxRM8ouj+8nItzjjF3I+n7iugfeiiF7/92ypuZJourEjCzFX4XwQpMqAA
	04eRhP5D9LDK610FJMMaZM0zoKZl0g5BxOm1whw8VEcWSqEbiTKPgE0zfQn4vvx3xYw+ND78AXW
	JAoik5A6CiMzY8oTl+VHYARhsTqez8yFvG/t6hkufmEboP2/BkSqiPve9f+BYB5Nh1OISH+TuS4
	FMjfSuJgDZ6PUix1oMcyy0EEpYx4Dr/CN3FtdhglhA1XHtHdSJuuFaZdKQIqNkBfncljNZOSFNd
	5CX8j3pe9P1b8VUKCiA4dKLxev10JiblxFOqGNfiHyNc8S7iOIkJhxwxzxnTnaDqRZ+DscoI5SI
	+0dLG
X-Received: by 2002:a17:902:d4c2:b0:2c0:af09:f3d4 with SMTP id
 d9443c01a7336-2c699bb64f3mr5268615ad.27.1781550664931; Mon, 15 Jun 2026
 12:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>
 <20260615171416.GC91269@coredump.intra.peff.net>
In-Reply-To: <20260615171416.GC91269@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 15 Jun 2026 15:10:53 -0400
X-Gm-Features: AVVi8Cc_TxKUSnnpg0eKGBdVaGlFYosIC7_tzeKaHh2mOwQAUgTlvXKZ1NG3qWQ
Message-ID: <CALnO6CDfs7uODE16HkvUfcqmv90okUjrCtGKOn0dae=Cd0j8Bw@mail.gmail.com>
Subject: Re: [PATCH] doc: fix a small, old release notes typo
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 1:14=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sun, Jun 14, 2026 at 01:28:31PM -0400, D. Ben Knoble wrote:
>
> > No harm done if you choose not to keep this, I think. Stumbled upon it =
when
> > trying to understand Elijah's message [1] about timestamp_t overflowing=
 in 2106
> > (I though 32-bit time_t overflowed in 2038, but timestamp_t is somethin=
g
> > different=E2=80=A6 except maybe when it's not? Anyway=E2=80=A6)
>
> Leaving aside the patch for a moment, the answer to your timestamp
> question is: signed 32-bit takes us to 2038 (and back to 1902), but
> unsigned goes to 2106 (but only back to 1970).
>
> Usually time_t is signed, but our timestamp_t is not, mostly for
> historical reasons. And timestamp_t itself is our local invention
> because we have no control over the definition of time_t (but we still
> end up needing it to call system date functions).

Doh, that's the difference I missed. Thanks!

> I have some patches to allow negative timestamps, but I ran into
> portability issues. IIRC, Windows gmtime() chokes on negative
> timestamps.
>
> It hasn't been a big deal in practice since new commits made today will
> always have a positive epoch. But negative timestamps would allow
> importing some historical projects (like Apollo mission code), as well
> as weird (ab)uses of Git to store historical documents (like legal code
> going back centuries).
>
> -Peff

Reminded me of https://williamzujkowski.github.io/posts/2026-04-02-building=
-us-code-tracker-law-as-git-history/

Thanks again,
Ben
