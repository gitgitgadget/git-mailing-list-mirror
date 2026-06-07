Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACE17D6
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848480; cv=pass; b=BBAe2HWDokesMZLNN9Vz5AJDTV/AiE61UkI6UqMAzfVdjSLgIRnKRkpXhjZTS8e3NlmjlkmRJUx/v9FJHTbF3JDi6glfbeR7+cpjAWbdhk/g8IfFpMaaWX3VvwOXJer8yQIuEPQchARt78H7jL++5TJ40wPMh2So1ZB1twOwWJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848480; c=relaxed/simple;
	bh=NspCop2zm4ZT3njeM0+5Ssq9/J/5sxBbK+EFjJtXEV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPrON1S1M9ppYptmlKTtm5z/ZlR9bMZlUYhxez2++LxLBrrIwCLKkFrnWcfHKevIuoLeu2apc6LPN0k9OKjtiWuz1lFFRHolHKiKBFQeX75h3fgnaSJ66WHO6H/VUHC6tlivAhWQSw6DuKTb6wqTyaaEpl7g02SBp/bSWU05MpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGkLkWJp; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGkLkWJp"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39676d82b7fso34581641fa.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 09:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780848478; cv=none;
        d=google.com; s=arc-20240605;
        b=fBHDlkE/i35GdDpc6TIO+46RdPXO0i4vNeJd7efiDLNMOMuF835Fa/KhseYIoyLONg
         UvlltyuYgxqPkFx+/ZcIKQpmwt9jOVqZB7M6xBwnsIPebP8VMftPZkyOos9kFDmuyFcT
         zs83FTxkDKVh58vpICdM+6rzdG3kO4AEB0PG12RUgduZYEotpVkjH3QHf8i9msnbRyFy
         mNaoJ/WJTAAQIX4QO9ymPy3MnxCUuS6tlefiWNtsAtc/cv6ug4EMSX3k5pCAoczzcMjh
         7gDaSgZJVGoiMG9Khv0kgCyokAd4oD3Zg87FF4t9T5U6urZXN+FtyliQEsOzPiV1XlpK
         3paA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6BDeKF7Teh1n4j9nu+KRySlZb7+IH9k4WGvVGtcloso=;
        fh=1SP2px6+A6w50wzykHi6UtvgdCVkDYKf5xEn4bI4XRU=;
        b=AUsJnLC1Y1WxKLT+kh125d4x25TIJfimLq5q2TQMz/wjsB8AdB9W/H+sqDFnEF4h45
         VBrRNCXz0U5C8uncUvBmZ0tO2Z9YHUwE8ZCiZjmuxuVNxYLCuZign4dQ1kO6NVrv3Tu0
         pIwrOMWDHdBAmzHIKQD2biL4yTPT3vCVp3IeYLUWwijL3K0z1jPiDhBjqoNMx985rcGA
         AGBNrU2KIYbXYBN4faRm7tZtir/46E4+wy4W5kgR6ErxMzKigFAdL5i5sVkvAYptunFj
         9keswkK77PL4rRKw7ntzPNPDTxHi8JAAFs+nfExYWihzo5l3PApoPcNbJCjg83l29HA4
         15Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780848478; x=1781453278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BDeKF7Teh1n4j9nu+KRySlZb7+IH9k4WGvVGtcloso=;
        b=oGkLkWJprGJmTnc2mfSS/NBSfqUGHF7KY5pjPXlHCySRgAgON7RVdIVNUfY9I4KzVd
         XQN9pE1ffQGDM8A8qoiVjD8DnYvG5tcjPlTK4s5ptZL21dD/jdPyGAMr6FpNmgVa3lID
         X8QaIUvmq7TKXo1Ak2ihemiXvwZq+uZuCH9aLyK95YSBy/DOOqT8oE2US5XuWBhfDO8P
         rgRo0vdUvBA0HeGVp3evCCgUEy/qd4BWTd3Ui89NBqjqqJoral6GgkOx97V5Vgq6ib4C
         jGJW+LCy8cwHI+94kuT19rW/l1u6eSwWg868GrDZwGJf2b7VVPGf7wiKeXYMQMjlpxIj
         fI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780848478; x=1781453278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BDeKF7Teh1n4j9nu+KRySlZb7+IH9k4WGvVGtcloso=;
        b=pWbMCjpDJ0zmsniwLsCgTvDTaOggzRQgxsDtDo2XsDkPUB5VghTbis59gDJebesL4l
         ouzegocPJDUvmFDglF5pZEsj+zYEX2R3DTMCPlzpw9WWEwVhHQifFwntFXsNbLUuXPb9
         PV2wYywcOaoI0ePE3Ed54VReYgMCN7FzYmOHqG31lVPupq1arR5qerIDbTPGs7Uh3eg6
         /H76BZhTTmF71u7tSNa+Y63o5CV3j+bqnpiXn6IFhxpS43u1uIzZkO/CjeKOm7y2sATj
         SPg884h+6NA1+8bcqvG9VGYaeExpOvWDHgY8mcb//i6DOafTNpKRfxH6UCDcT5r5wLC8
         tI7Q==
X-Gm-Message-State: AOJu0Yyb5/3qQ21DBX+yVzgGhZeMyo7xYDzVBMInLB4qssZw+47W4tiQ
	Cv1C+n3NOH4iFjBNJEZoTMXIN3DlYVe+cXuacZHlkWJtgLtzW1X/PRZzQxVTjuzvAYwh2nbxdPy
	TzGGJSgbyGDpA6GoaC7nE7VDYnm0D0jc=
X-Gm-Gg: Acq92OEMagRf//6D9TsuIZhIdgLpEwcMbkWvzgwOK5gryr/YEPCZb5UY/X/hsgd539m
	CzeJ0UduM0o8RHRsntBB2rIQm/BBkHxsLYO/Dmc3zFaZWybFzyoZOBOAM/h+LFxD1K7fMk4cVZT
	Y6KMqa/5I8yzS0cU5QVC60TAAb8FtVX8vZ7sBVXhjPApzXOS3gLot2HTyL8IoxS1pHCkv6t0eRl
	vXXcS5xOofivDnX1FPGKGMuXGM7M9xQz/dGQMk8DcTC3nqrPPsLx2sZoY/I5031+yzP/7gOYFuB
	egXaZ5V4q1a7MxO0MzTZmLxGAxrw55bGJ8MrvMFv47q7/LUtvSYuZHGXR3IqEPjVzERTmtuDtlm
	mJZyMKdpl1WYQwge8UukExIHBVoLL1Lm25KHGsUUnvwFbJm0usNNd/viAsAnvbZiKwgfW0pWVDL
	A=
X-Received: by 2002:a2e:b108:0:b0:396:9a5c:3357 with SMTP id
 38308e7fff4ca-396d08a7afemr23392661fa.22.1780848477464; Sun, 07 Jun 2026
 09:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com> <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com>
In-Reply-To: <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 7 Jun 2026 12:07:21 -0400
X-Gm-Features: AVVi8CfHLrgnvMn61ddyE4uVDau_77mDgRskVhcXKDhMIlzKMt2u9m4Kn3tgjew
Message-ID: <CAJ-ks9nXybntsa5FCJVWSQ2u+hzxaMdrfCdL3D+vmzjO4e21kQ@mail.gmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 12:02=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Jun 7, 2026, at 17:40, Tamir Duberstein wrote:
> >[snip]
> > Assisted-by: Codex gpt-5.5
>
> This is more of a Git for Windows trailer. The Git project doesn=E2=80=99=
t
> document its use.
>
> An aside here but these trailers attributing specific LLMs feels like
> etching =E2=80=9CPeter was here=E2=80=9D under some table. What benefit f=
or the project
> does knowing that it was this version of Codex or Claude or something?
> A link to the prompt/conversation would provide provenance and show how
> the LLM was used. But three years from now, what information beyond the
> fact that an LLM was involved (any of them) does this offer?
>
> I can understand the benefit for the companies behind these LLMs to have
> these attributions in OSS projects.
>
> I have done the same thing in our company repo, crediting <LLM> for
> authoring or co-authoring or helping with a specific thing. Using a
> =E2=80=9Cpeople=E2=80=9D trailer. But the intent was just to show how som=
e LLM was
> involved. So I think I am going to switch to the following trailer for
> our company repo.
>
>     LLM: Yes

This all sounds reasonable to me. The kernel has started asking for
this trailer (https://github.com/torvalds/linux/commit/78d979db6cef557c171d=
6059cbce06c3db89c7ee)
and I saw precedent in Git as recently as last month
(https://github.com/git/git/commit/7a094d68a27e321a99c8ab6b700909e503904bd9=
)
so I erred on the side of caution.

I am also OK with this trailer being dropped or replaced on apply.
