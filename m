Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680D0133402
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052915; cv=none; b=dD5HYQmf+FCweQEyar0LD31kwSVOOAbiYD36/PHWHphXVajqrSOvBplOlDEo1LT6ZMKL+uEEN6rMF0u7i4MfYyAcvtO4DpU6ehZ9u7K7lNlizKA4RDy36CRA4yksyZh6wZVpf84PtM1mSvuShgt2NAjPx/u1x7eIS/T6HH3NsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052915; c=relaxed/simple;
	bh=H7HfVTBL5bKrevVh1zTOsnBbbPZhhiDwTrhjzPdnivQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3D5F9eA9Vxm6cZADJLFj9h1gML8lvyf6svr13EXopyp2Do/QMX5tZgWn1CBQ5CrF12n6SnX7qxtydxWsYU/oUXBLtV2J8V0/n+SlZLma6cjGgvsM5bI8BAJcNtxURyzQL0OTwrKKnai8R3S0oWzg7zmoDCjGFF4spIeHStc4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm+7JNV9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm+7JNV9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515830dc79cso1615396e87.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052911; x=1711657711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OsPfE5Mn93c7XQMokgo0/APmN0yCdu0rCE/9wtVzBk=;
        b=Zm+7JNV9cGd1nwubup4wb9gUUfNRTqYmW33xDbtNgsw+Ai902pu1lsg3oKob1aakSP
         GdMXyhAwpt78/R/2/cDPsAsxdA28rXtGcZ/3hPcmWzqvjlkVHM51sHV4U8hv8qexMQux
         6xKHr82YceOo4Gt/krWQYzlGAvWAba5JxT8w2UDw+ki0tlnPzZ15UEwV/rxEKVqesyP7
         smVyC6+kc1Y1n053pOCTVdNLzqsPj4j/kJy26Oi/lmcw75I7YAXoELlBgcQKnWDqXSZw
         etwdTRslINfduM3lGQGrNGhaQ6V0H9YLfq/nUJgx5MaCDGNPaXR2N+oPPSpVPFWFQCFC
         QhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052911; x=1711657711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OsPfE5Mn93c7XQMokgo0/APmN0yCdu0rCE/9wtVzBk=;
        b=OrSoDnwA5HMgXPksK6TaGUcnGsYKkfzHOrDBErcVLltvHu0EkjopHaCaEB1MeXWkWW
         hkZYuwt1NFWocpDNOimVOLo+KSsnND6LD0QtgSJYsEEZvS2oALQLkBzUvUKzLKd3tB8b
         gW6hlPeYM0D50jjD+kLsc4wUv4hZI1WMYTs3GcNLnkPaMM0t5szYAXIztYIMu2hXJsbD
         2DXiVadQmSyIs7Cu7BiBHeYSpIWtxx11mDNvo6R8SPH7LHrqX9NN/Goav7uYRdFvY+0W
         le3JuzUGZAK2ucSdWlTVHTlmyLUphKOVyNj20bbFQ8olN3q5QNSAOk3+E3cF/sQJ2nc8
         T0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrmlBYIk81GpTMTnLHdPXswdDXMJMtMuZ31h7Fd+8v//6y9RlvKQzQ9mc8ufsbaGI2IX56ylykhbNiOWN/B5J9BonB
X-Gm-Message-State: AOJu0YwRKm3bzMX7Y93M6Hrld1zrg+K8YY0okzCibDd/6/kEPpGuo5VO
	Z3ASAdlJo1Y/3eIRucYvm63+xZjqxBo1cO5u2VbX4+i8PNHIy4iEUNhCIoqoXtDIi0eZnKXmn/F
	GbdcXiSgih+5yUcin+axgnLETMyU=
X-Google-Smtp-Source: AGHT+IGbqwuJ4uTGzDI1z6loAZUfTWGHHfotLpwHpDQAAYia8UE+AXPodM8yhliWUatbx+6RXCTWR/fQNoGeS83qKK0=
X-Received: by 2002:a19:3846:0:b0:513:c596:713 with SMTP id
 d6-20020a193846000000b00513c5960713mr340527lfj.28.1711052911193; Thu, 21 Mar
 2024 13:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
 <b8d0620d4104106210ecf6a34ada591adf01cff8.1711049963.git.gitgitgadget@gmail.com>
 <CAPig+cRweMree1LJ=qpOJZg7HYvgE9XX8iFvMKcAGYJpAFGFDg@mail.gmail.com>
In-Reply-To: <CAPig+cRweMree1LJ=qpOJZg7HYvgE9XX8iFvMKcAGYJpAFGFDg@mail.gmail.com>
From: Sanchit Jindal <sanchit1053@gmail.com>
Date: Fri, 22 Mar 2024 01:58:21 +0530
Message-ID: <CAN7Jk_3A5c=5E+CNyncaT9qe_d85_p6ZHNzJPd0E5ZSjG1kQng@mail.gmail.com>
Subject: Re: [PATCH 2/2] t9803: update commit messages and description
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sanchit Jindal via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 at 01:22, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, Mar 21, 2024 at 3:39=E2=80=AFPM Sanchit Jindal via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > From: Sanchit Jindal <sanchit1053@gmail.com>
> >
> > replacing `test -e` with test_path_exists,
> >           `test ! -e` with test_path_is_missing
> >           `test -f` with test_path_is_file
> > These helper functions will run the `test` command with the
> > corresponding flags and will echo a message if the assert fails.
> > This will provide better debugging logs for test, instead of the
> > previous method which provided no message
> >
> > Signed-off-by: Sanchit Jindal <sanchit1053@gmail.com>
>
> When rerolling a series to address reviewer comments, you will want
> the fixes applied directly to the patches about which the reviewers
> commented. The way to do this is to use `git rebase -i` to adjust the
> patches as needed. In the case of this simple series, you just want to
> "squash" patches [1/2] and [2/2] into a single patch using the `git
> rebase -i` "squash" command, and adjust the commit message of the
> squashed patch appropriately. Finally, to resubmit it via
> GitGitGadget, force-push the revised series to GitGitGadget (using
> `git push --force <whatever> <whatever>`), and tell GitGitGadget to
> "/submit".
>
> Regarding the commit message, first explain the problem the patch is
> solving, and then explain how the patch solves it. Thus, start by
> explaining that `test` doesn't provide any diagnostic information when
> it fails, which isn't helpful to test authors. Then explain that the
> patch replaces `test` with the test_path_* functions which do provide
> useful diagnostic information.
>
> The From: and Signed-off-by: lines look good in this reroll.

Thank You for the review

I renamed the branch using github as it had a typo which made the
earlier patch to be erased.I am extremely sorry about this.

I have created another patch with a more descriptive commit message,
and after squashing it with the earlier commit. I hope it is satisfactory

I wanted to ask, Is it possible to send the patches created using
`git format-patch` manually using gmail, Or the default headers
applied by `send-email` required.

Regards,
Sanchit Jindal
