Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80B27456
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630279; cv=none; b=mOjdJsWgYOZem1PVnlD5ZUNrDuUUlACVoCWP9ev0SqxCdZ3lWlUqHjb1bETpaiw5Fza44cNoUgBHFbrUbqjwpNFElPy/e7rN32dwcBK7YzPhkLb7fdlfZEuEQh5rCK+7mWwJA/YZOIejEQisgMgb7kBVD/KxRyUISk6Z9bNkeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630279; c=relaxed/simple;
	bh=JlY9BrONeNE9u5sekOMzoRn90IhF46mjBvSaRjFOOBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gQMnO4f0k6N5UAeNLful5GWkabot6FaHPTlWRD5CnhJjhADV9w7YcfOB1vN7th+gMHyauTSEcEhBmYhEg4B8Uzpj/TCXemodeeFwdCz7d8Cvle2p4BuUZ/Yt15LsKYPMHbB+lA0d2r0dIExJYpg42sby1EA3Itj+6RWS8Xlr3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFWyTvGP; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFWyTvGP"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a8690dcb35so1597897fac.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 16:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630276; x=1739235076; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlY9BrONeNE9u5sekOMzoRn90IhF46mjBvSaRjFOOBM=;
        b=HFWyTvGPdotqmZ5uiK84LnazSBLlIMQoZ7YbsUWCcrBPkO5QhAoOfekLOvKhyHkDsX
         aMvWet+3aP7QMrV/CWFFkDfyRFcvTHDFK9xZhUsStGmaDHp+vLIbTcJzYEfjCquZxK3w
         aDEjboR3mIwY0WYrB8Dh0dfagi+PYtgKcS+fDtpcDdfRxXxNGXp+2pK9wYLvJVopHREh
         8vugp1DXlWkxmQs8EiNlox/YhoXvTGx6GQkWy76z08YZTBv0To8TTFn4165a+9eIAUNM
         cW/d+JT2dxBRhKWRtzAuEI/vOKwsvYlXM+A2cutmtGw+hDTXbArQEWQyMt0uTeLWx71V
         4oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630276; x=1739235076;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlY9BrONeNE9u5sekOMzoRn90IhF46mjBvSaRjFOOBM=;
        b=GtQfIefMj1dNKrEfEkvKoihYejuBsA381deB0mdasbJsGx94ODpS2esbwmuA743kNx
         9zfae6Tt5WMs2D/Jy+9M/Fd/oLNSoV0OZQTX3szRlg9/ri7gFbdkN7NIMYoyWVgRYVoS
         3JA/LV789KB0ogNHxuoechVmYmnwzMQXZy5x7kPAB+0uLqfiMsNZlPDrRG5bPHusNNOe
         3NmkfmkOpPslcvgJD+OWm8Q7ecusKjZD/IdNbVsojWykNhEbwbHDDAllxThJJaH/XRnN
         rjKdcdOXchOxG0zkRC0FjqjQXpPB7xrfB/tRrIMdupEievBGxp9lXdN2YAdm2igxYTrK
         Uuew==
X-Gm-Message-State: AOJu0Yx0YJt7UhI6gQdrwT3uTZPoIo5herOaVWwx/qS4ftlc7hx/H5Jv
	5ImQCa/vthG8UDnr+EvVo+Sp23Fb6tchCdzXKMG4OU6yaxP1kveXAbagvosyC5CGHPCLZ0+aOPl
	OaWkbav0Mroaz4CIkhmLP2N5s1tnKRQ==
X-Gm-Gg: ASbGncu8WBN54UX4q8yexDS04Z2YZabWVaOJ/kmkl18Q3opfghg9OqLJjpKt2L+/bHi
	otjJ5hla4zZJ+s6v+B0Ir6VLN1WsYeB/HYWxoXiqROyZAr7OyZY92mS1zjMwVWoESFVctYR1HYA
	==
X-Google-Smtp-Source: AGHT+IEd8FJje88RuKx0OLNUh6btzuaFs9ZH8WZVfeJF04FSk/6VQGKF4C8MVhxEMm1OOq9ocRAtM5Q94i1baODYU6g=
X-Received: by 2002:a05:6871:4e8f:b0:29f:9d70:f4eb with SMTP id
 586e51a60fabf-2b32f1327a9mr13458164fac.19.1738630276394; Mon, 03 Feb 2025
 16:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g> <CAMoUM6+9SHybvWVp3SKDD4RWesruh=nmMacXn_oL893CPCn39g@mail.gmail.com>
 <CAPx1GveyP4+yn5NMgvO3JpbOwPRT5=tb9YBx7U1Ufvae7gFnHQ@mail.gmail.com> <CAMoUM6LstYx3PJcx-Sz3Dfs-1BxF1uP373MO8+eknbO7j-S01Q@mail.gmail.com>
In-Reply-To: <CAMoUM6LstYx3PJcx-Sz3Dfs-1BxF1uP373MO8+eknbO7j-S01Q@mail.gmail.com>
Reply-To: bram@van-oosterhout.org
From: Bram van Oosterhout <adriaanbram0712@gmail.com>
Date: Tue, 4 Feb 2025 11:51:04 +1100
X-Gm-Features: AWEUYZl2pyQW8nnaFnDXzgGm00vcYBfmo9w8OD8yw8XF_hn2j7_YxIuSC-UoQ0Q
Message-ID: <CAMoUM6Kfa4eoK7bvYRgSN4KWh8XRqE2itjM7wDgJ0AZY75KSfQ@mail.gmail.com>
Subject: Fwd: Usability issue: "Your branch is up to date"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Bram van Oosterhout <adriaanbram0712@gmail.com>
Date: Tue, Feb 4, 2025 at 11:47=E2=80=AFAM
Subject: Re: Usability issue: "Your branch is up to date"
To: Chris Torek <chris.torek@gmail.com>


On Tue, Feb 4, 2025 at 11:32=E2=80=AFAM Chris Torek <chris.torek@gmail.com>=
 wrote:
>
> On Mon, Feb 3, 2025 at 4:28=E2=80=AFPM Bram van Oosterhout
> <adriaanbram0712@gmail.com> wrote:
> > Ahhhh, this thread explains my confusion when, even though git locally
> > tells me my branch is "up to date", a fetch demonstrates the branch is
> > not up to date.
> >
> > Which begs the question: Why does git say: "Your branch is up to date
> > ..." if at best it can say: "Your
> > branch MIGHT BE up to date with ..."?
>

(resend: I perpetuated the reply/reply all mistake)
> Perhaps a small wording change is in order, to say "your branch is
> up to date as of the most recent information I have from git fetch".

Or perhaps: "Your local branch is unchanged since your last fetch from ..."=
.
That says that I have not made any changes since I last fetched the
branch and suggests there could be changes in the remote branch.

Bram
