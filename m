Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96E12E75
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536371; cv=none; b=g8y82SDoL7UtIEZBVbKnRef3VyO5ZSeB9QfnTqZb1nFbF1oQWUGkOXiDyDbXG6Qvsi4VNm0Ku61xCuNV7qvYlD2NYeJaj+Gt9X2CsPYHLZC6TeziVvbmDBDbQq9xP05NeSVzzRaw10WD8+esv/AgdmKoUcMWVxbQbDSiXhPPZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536371; c=relaxed/simple;
	bh=ziL5tirPuaOwbpEsL6XeRraOGK3BTcCvSFnQR0dAEhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXu2WTgI9PMClVnaF47QlktbWOg48RMnj1D/+lynS4V3Ibi4yj+0sX+TrtGLPB2oXPeJM6ot8KPrVLHBIvhlwlS6NJ1J6zdArIYP9KtdUn/nnK2rnSDvEy0SzECt3vNJraSXzfDsyXzXBZhQzdA+yzCCyiE9/kKe6U3lZk6ghb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqBmpQoS; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqBmpQoS"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f38da3800aso1906839f.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 17:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719536369; x=1720141169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olox7o5kpC3yd/PLc8GkTBF01hIokdadVDIR0vnOoEw=;
        b=aqBmpQoSACf0BJtBkL3gTS2eJEl8gErKa1TcmupiX4D6gmgtIooWTT4EevjYKs86lZ
         aacSl6yx3DnmA/Qg6kp0cyiFrJzKXZvoiIgo4Cq3uW+xecVwndKkje+75XyVhHuHc6ZT
         IHCWQnGKnOdlqpSvXo4GmdJdX+FGC8+p9uxwyO1wM4VhL7AD/kedLaIVv27Ljrg2EIuD
         iDNhSpujJhhyqRoIuGeEH6bSJbHuf5TztsAz1AtZNRxisLKOhn8QPsMurcdIA5yfAwV6
         2518ZNcVR5btqynEVFLAOk2KrYHsweTygtgG+1Q1wfXt6HoX4PO/IlmKRmstny/YvJTB
         Otvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536369; x=1720141169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olox7o5kpC3yd/PLc8GkTBF01hIokdadVDIR0vnOoEw=;
        b=QrjpchaCeUSgL0wR+87+rcZn4z/JUXJMX8CnDI1Ej+mz0nBvyqlp/7GhA8f2yos1CE
         sZEhy5/T4HBdgHBmj2mxjfn5BGddyPVmQIv6ibUwcRePCbL6ehFTRrukUqGsSi5tdX8Y
         6szKrGuiWn4MMojEF9incbCK+v5wMeWnaKXWhZeRWsz8bWMG4L9M8txEFWZUAZIMU5wk
         /N+dN9o1NzxgRjwaKdvVt7dVhRA5NlfNFNbQf78D0aCd913U+Q+3a1pZi/8kO0t2urPr
         FwmMdgMCCGuFXiNLlWPK7L9umbIX2XT3fC+oHmuOF4w2mkwCVn0t1oHt4q3MdI7LgtKV
         ceNA==
X-Forwarded-Encrypted: i=1; AJvYcCWK2qAoruJnFlcY008pmkf6QdIE98WSsUavlaH2wiRsFYrXndpUOm81SFk5xu4HZHrNMwolqEWBXGtJdFrfWmMaf3LH
X-Gm-Message-State: AOJu0YzqBqSFk+4bQtFZtdyLqs6+J/+KN5lm04YmXS2LDTq3vScr/EUy
	37TDlObhPf9tB43Se68u5kguZFmorBrxctGpTK+aUwTjaLWYjA2fI30F5AURjzZx1NwMnGTVowQ
	xcqktQ7y+iGaDTuSdTYKvCjGFSaY=
X-Google-Smtp-Source: AGHT+IF/8Mqs1ZKRyeY5cHnM90ez/+94evSgKFwr2X30QZQBBMPAmhjLHOzKHvbSH/AVBZ9d04RzEuYdzi+DGWgQovM=
X-Received: by 2002:a05:6602:6d15:b0:7eb:865d:a69 with SMTP id
 ca18e2360f4ac-7f3a75a3c9emr2151139139f.5.1719536368946; Thu, 27 Jun 2024
 17:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com> <xmqqv81uqcsi.fsf@gitster.g>
In-Reply-To: <xmqqv81uqcsi.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Jun 2024 17:59:00 -0700
Message-ID: <CABPp-BFLGrPmUq-rhz7K-G5b__U2jeq8SPdfFDrSa6QkjPMnWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] sparse-index: improve clear_skip_worktree_from_present_files()
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Updates in v2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Thanks to Elijah for a thorough review, leading to valuable improvement=
s.
> >
> >  * I was mistaken that the sparse index was required for this logic to
> >    happen. This has changed several descriptions across the commit mess=
ages.
> >  * The final lstat() in path_found() was not needed, so is removed in v=
2.
> >    This saves even more time and lstat() calls, updating the stats.
> >  * Elijah created a particularly nasty example for testing, which I inc=
lude
> >    in my final patch. He gets a "Helped-by" credit for this.
> >  * Several comments, variables, and other improvements based on Elijah'=
s
> >    recommendations.
> >
> > Thanks, Stolee
>
> Thanks, both.  This round was a pleasant read.
>
> Let's mark it for 'next' soonish.

Yeah, this version looks pretty good.  There was a possible further
improvement you suggested, but I think that wouldn't need to hold up
this series.

However, there is one paragraph from the commit message of 1/5 that
I'd like to see stricken first (or rewritten).  Once that's done, I
think this series is ready for next.
