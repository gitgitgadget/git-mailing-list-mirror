Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9647280331
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116817; cv=pass; b=Gh3qMZbqzUtpBcfZLoaUBlP++s8xDEtzlwtAo6O0jWqbnNKvHT9rgNpn3cY9CuYxNPxxJgWiIelJV5ytatQeEArt+jaOth11MzjkvZcakKgj21lQZYtuUYGKAHkHA5dpy7HntqOgqdXxm5avSpDOEotZ7BuKzrpvccKMI9HDmtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116817; c=relaxed/simple;
	bh=ntQZfoqt6YRMQtO4iFAYbJARhhnUk6DQsfLLTqlQCPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfRkoOaYiFG4Wgp9VtEhiOoB6fjuidUd8OUOpeCObJeEbtnRZP8FVPp3c1oT73o/drKc6HYgY1kp559S6R3EyaaXTcZOLsJiNGo2MzS76+58WOAnDP+0GXA904xsT3VGlF0SKnsBQLkKRm4duqCE6mvMI1O80SDoiauYs47c5UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYKE9wzM; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYKE9wzM"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-456f7012050so1762536fac.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786116814; cv=none;
        d=google.com; s=arc-20260327;
        b=j9nbgnNqbZ3PXUyn2aET5U83jX63iEALPh7AwKquJWQqYmVmXJ4vJeqX3C+Qhk1wGM
         9/MaKWwO78ocaPPX49azMkwDbpuMDgpZkFGDyxZ1VtY0xu5UHFU3TT2MPUcINGeqccGm
         VYOELINCO5MDkUBQNq9C9IHJrPfImF3PK5nsEqlBixSAE7Ab7JOXuKgDvbXAfUdx4Tka
         IFMpHERuQdh1DBm24gSdtWx3TeeRGvjAGXcbpvPs7lC3I5c9icssBZVws2yxcILICl15
         8n8kyJIB/AxJDblHr7acTFsz0X7swIqM0whkajGyHoU6Sn00d+VI5NuuvT5n8feH57GR
         Fypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ga4d6UG9770Httjkf36V7b+ujUnuVg+hiB6Dcld22ec=;
        fh=euL+wxaGGjBW4xTZbmmY4PM5MI9XSlhvJbT45YaBhE8=;
        b=rO2kdOZWKJPcf8Kxr6zXwsT+kfiQilt6PvzoTcr5v6lIVVuy8XYF3G1bnA8N0rHhbw
         wp3+Fj0tajFaDHqt662kuQlWO70Q/LRbSi/HTf2poWsrVuf6mnw5IBjXzjyVyg83eU+O
         z0Iugj1Dnaq4XK/u4BCBGevSIyuzlhDy8zhIQ2hVLJAub2xTDBCq0rygoFzLkEAerERK
         i2UAxzOOJRwFWEGejHiYUYsB8Rz06fb4GCKUEud8vVUpcAx8vy7aWmBQZRWfnKpBfICZ
         kZ61xOiEhUEtrw5ar1KtW7W8GshOa6RoiBoX8oJRik5/PxMPNQutgVV2LSvtaXrbsAni
         UgsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116814; x=1786721614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ga4d6UG9770Httjkf36V7b+ujUnuVg+hiB6Dcld22ec=;
        b=YYKE9wzMantMD1EBCE8eC1I9mXvttIXHoH4aGdDe92AS019W8ZzaPi2wtLfe0hjsDg
         2e6sya1+D58U/L1PtaoO2IYYYOa9ayrU8q80XdrdBdUM74mfr0s14XaFPacjWLZtd6P7
         bNuydc0iHxKytEYCeY2Ys6h6r5vvtpdlNFFsCRAgLPIdCjR//dPQB7xUjaMQKUbue0D/
         FLJgBHW1kJ2sxuGusVa0jHohYz3l+bGcdhPcrm44WhFXWWllgUFxB0sqlElZhJMdwEd9
         cC3G7QDfZ9Yk0v/kszWr9//Q09geHj4tUS7djBBK74Nb+l7S2H4LSi2AZfmO47Nwj+VB
         YmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116814; x=1786721614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ga4d6UG9770Httjkf36V7b+ujUnuVg+hiB6Dcld22ec=;
        b=BAdwIVrvmYWpFUvEtaVLUBzSnErUJma1IkTQlDoakkUTi0hVCoPq+ITEiDgHI81M8r
         LNibOgpIv5JYaKHNF3/tzi4Yctetn7LjMjVrBxssIM7g9MvKEoJ0KtvqEo57XnSUcqBz
         AzVVRG+zxsagDF0yUI49kJJ8jDZlbH5v+3gCeIVk+vgmXz81ETtuz/3ziWVaRyPWxXRf
         TxzgOu7gVtdCo7Q+HdVsTHMzrYZJiYvioJWLJfmY6rkKY9z8l7M+rZTnlc0Z0EPu14Qd
         3UITXTeOOrRCsixQWw1MLA4KKSC6yCQvqV5Yf3Shl8ocjtGUvXUfouAdzjNJ2opTxGvs
         DwfA==
X-Gm-Message-State: AOJu0Yxo3NZt33xJI4njNOzKKbViGvYyfMojj8cBL7QGJuVxYCFO2ZBU
	IWcRG3MvOQcc5ZakHbo2yJz7pqo4A8rEcC0vLibPBh1FRrqSUfUN7KMgfoL+0EytA4jMJrnzSSa
	UnrJamJFIB5thetUpvCTPcvsgTmKOmrI=
X-Gm-Gg: AR+sD11dRTzqMvZW05yYXVFopv2GAGa5u4W6U+ziy99X62yxFBJdepl8DrNbPHfQQUX
	gEX92269n27gyQ7TDuAtpAqIRgPXJ4A9Tc9v2Hx0lRRu9AFyu0lqkw/TP4FNnnQSx8SrbJjyIRc
	/fNOT+px9462/BkEdRp9WRbgh06cSozPYqBT7QJLgMjowcmbfYuxHQEI9f1/owjJRvNQ3j904sT
	R5RMe1vnJsKCA/T+arzcmrOrZ2N6raBbSSRpMF5IIIrelDUSt/vZH9F5UtqbpBonKiQy33rZJ7n
	d2hCACVx4g/k6BH+BViAKxw2eJ1a64kUFyzI155LP+6y6EC5zY/rTsGwY7lAXYQadmEfkWYJ6vR
	EZI3sG/GhWBduJ6CLQCc7GxjNsuh4z9WV/ckjgSSveJOTiiNQzM/vydqQq5Yl8lj7z6he+HA64o
	s=
X-Received: by 2002:a05:6820:f033:b0:6b0:16d3:fc8a with SMTP id
 006d021491bc7-6b016d40c4bmr6073079eaf.14.1786116814510; Fri, 07 Aug 2026
 08:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802212826.1090943-1-sahityajb@gmail.com> <CABPp-BGYuQA_ngR3xS-_Mndzf_ubkn7rSc25CJG=UbLCVGdnyg@mail.gmail.com>
 <CAP=WS+sp74WQ=xndQ+2a6W-qP3Zz8=bVnEymgVpS+gwMv1Dh7g@mail.gmail.com>
In-Reply-To: <CAP=WS+sp74WQ=xndQ+2a6W-qP3Zz8=bVnEymgVpS+gwMv1Dh7g@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 08:33:23 -0700
X-Gm-Features: AUfX_myC4bzWmn7NNd8eQn5gqLoB7fZrgfbo0ukY-pa1auKzV1ytnBrKDbEQyd0
Message-ID: <CABPp-BHLaW6_CxMdPQURN7zMK1p7dEkihFMAkyWvcd2+j7gJqw@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid sparse-index expansion for unborn HEAD
To: Sahitya Chandra <sahityajb@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:05=E2=80=AFAM Sahitya Chandra <sahityajb@gmail.com=
> wrote:
>
> On Fri, Aug 7, 2026 at 12:17=E2=80=AFPM Elijah Newren <newren@gmail.com> =
wrote:
> >
> > This explains what, but not why. It feels like a pedagogical exercise
> > with no actual utility.
>
> You are right, I found this through the TODO comment and do not have a
> concrete user bug report or use case driving it.
>
> > Why would someone with an unborn HEAD be using a sparse index? [...]
>
> I do not have a good answer to that. My thinking was simply that
> removing the special-case fallback still has some value: it deletes a
> long-standing TODO, unifies the unborn-branch path with the normal diff
> path, and removes an ensure_full_index() call that future readers would
> need to reason about.

Ah, thanks for looking through the code for TODOs and trying to clean
them up.  That's noble.

If you submit a v2, it's probably worth just being upfront about this
in the commit message -- that we don't expect this to be used in
practice, but it makes sense both (a) to remove one more TODO, and (b)
because it provides a net reduction in lines of code in read-cache.c.

> > This seems to presume a single dirty file, otherwise wouldn't the
> > printing look pretty odd?
>
> I agree that "dirty=3D%s" looks wrong when multiple paths are
> present. I can fix that in v2.

:-)

I'm curious if the unittesting harness could help here and avoid the
need for the test helper changes.  Is that possible?  (I don't
actually know much about the unittesting harness abilities, so I'm
genuinely curious).

> Thanks for the review.

Thanks for contributing!
