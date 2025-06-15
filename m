Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CB2E11CC
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749948547; cv=none; b=tqFxeW4QnBw/Y13qVTyFlLii8v0N1aJGYyu/tIRv4ds3OEExVuWtPuEzMpZjuSBNA0kwXu6L7fkxZuM2ht/8bI3+GyL3SF3RaPFgqfuDXiAwOCzqSU+eIgSI1QjsRAT+bKAtzMc35eOJj82KjFjvq6gNrppEYdkZOkHluN29jLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749948547; c=relaxed/simple;
	bh=p0xWtoLLsYBLGAjYBw7mO14Yo9RlNnj316IYghCnKWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvP2UNsg4bLpeQt3P3b51+gqtqRWxR6zIhODHtG1kDRAg2/r3c5HArpK27WIIL6JoyTr6R4ZfnBe8dVJPdjkBSx5B+3Ir0RGytsqNRT0vnQGbwmvgur096GkSwmTdtpXTca/zVIG+C/KrFwbbXzmn/saqBfcvuPyFJnfe4tmgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvIeeAEF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvIeeAEF"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a44b0ed780so48463341cf.3
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749948544; x=1750553344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EhWLzqXqsMVxUQiP49OxLZ7ccIkG27bVnpO93/OPjw=;
        b=MvIeeAEFqDOhAWDrdlnR7A4ki4TK7wl9WHmiCJ+olES0aFdqFYKOTJtXoartP5XaoG
         +IKQGDN4O4QGQa8CIkGxbMPbwfeRFRzwV9TleVXeRr6/Sye81sjmIjgccOOLFnSqfhM/
         cJFMl9A2c/a6mEupc2+uM5IvgVaSX644SQGwCMbue2Id1VfI4naXuktm3UuURVOCKzQj
         HC2/na2bTVFZk8odRCTPq6qzR68m6IPdIAg0/swdEyrMEZ/YZjCwXMBn+rUmUuWsAMKF
         05sv+6y6jUs3IVPCxWigD1eUeZ2/k9zXzDsZDi+dTkkwvJZglWKvPsnajhSTo0b/C+5d
         j0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749948544; x=1750553344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EhWLzqXqsMVxUQiP49OxLZ7ccIkG27bVnpO93/OPjw=;
        b=ok/hMBxBG4+/lbkx9DUIZdyKnNPWW66HtCroBKaff/2ihbO87JgpyNV3JfJrpI0GVY
         m1rgi16Y8ZKy+sLnTDTvptjcrdlh8kSYTWrPVnKZ+CTQ377VEmUA2e3twOUXL1KxUgwf
         9LJ/I44sgBJKQqF/tFFOLDJuSb35Wlop2dyJYWP4yATNW6gouCzMxsSqKNHiLqBosWoL
         MZZyyMVKfYQudSZe6MQ4SvG937Tl1J2FlcXC1aoBE25ks+hu903Z4oZeGOX0cduehzHD
         fk/XDFtR3+tkxx5uWbHFg6v1qalzzb156pZanTnCUrxo9f8/4DfKGI6OmpXuV3uEPtSf
         EtCw==
X-Gm-Message-State: AOJu0YysaCuqGW5Ryq1W4qEmrvYf+txjQg5lm2j+IypT3adQ/x35BMpS
	Va/b7FtilqC+ZZpcm8TWwPv+0BhMe5aAlX3yudd4AV7M0XJTqS8j/UE8drmpfZSnrtUraSNhukU
	dfLDSp/C1OIgjS/kixXcwlrwirmkmHHMCRQ==
X-Gm-Gg: ASbGncsM3twx8QyZ/2L1AjzLBYqR/9whXKG24ry+Kr35lEaWbJO/2I+pmD7HKABwU7j
	Fin8PxZcUoxsCTVm9bqld4rVy4SDOy5vA3Njemy+7pKUDHICBMtTi5X8aYh9hbTketgdBWRzYdP
	7F+SJnffk46TG5ZAATk6kmL5ApcmNQHQgV/IpaOOGh74W4vANc85SUXk9r05juNj/3tQPaXQb7W
	XM=
X-Google-Smtp-Source: AGHT+IGaIi+ClFKG/q5o7g0+rHXpgNQXRsh0NLOZNJIIV0gVS0zW4uTHNLyAGpupV/9W/qtMEy2JemY9Uqmpmgx5N2c=
X-Received: by 2002:ac8:57ce:0:b0:4a4:3d27:77a8 with SMTP id
 d75a77b69052e-4a73c4fd5afmr65557431cf.6.1749948544389; Sat, 14 Jun 2025
 17:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
 <xmqq8qlu72hz.fsf@gitster.g> <CA+rGoLehMUWPMBrZ1hOk-GBQBCvSY0_ivFCn1w1C-V_bGTDgZg@mail.gmail.com>
 <xmqqldpt6dht.fsf@gitster.g>
In-Reply-To: <xmqqldpt6dht.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 15 Jun 2025 06:18:53 +0530
X-Gm-Features: AX0GCFsotSYVrbVVeVszKKc-jqD9ObZrZ-ZKWpHg_cd4jFeHo0OlyDxc0yxdcUs
Message-ID: <CA+rGoLcsuhhSOVJoK2vEV3m7PgH+8hpfpdih2furnyim=0gP+A@mail.gmail.com>
Subject: Re: Question: regarding understanding code base
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 6:13=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > What I meant was:
> > You previously suggested that one good way to understand Git is to
> > start from the initial commit of the Git repo and move forward
> > chronologically through the commits.
>
> Not at all.  I only suggested to study the initial one.  It is more
> like biology students learning the common principles that apply to
> all kinds of life by studying a lot simpler organism as a model,
> instead of studying a lot higher order ones like mammals.
>
> Moving forward is all your invention or hallucination ;-)
>

Fair enough I have read your biology metaphor
into a full evolutionary theory.
