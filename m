Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3C42BE82
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935114; cv=pass; b=Hpp3Yu9c1O4j3tVGiGkSf9j2v4h59zvgoj4AmBi8Ah2eRtjEElfKfBAXVsMci+1tG9kGQ2Jj6jm9NvV8QMiVT0BBriZrqauHOZRykXbQ73tu1imntgn87k+xsZoC0e9PuNBwmKCyoC69xHPzuSWy5uiA7XimXkblejt6xeguF1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935114; c=relaxed/simple;
	bh=i71L77tJ6SsTzxmFVsrCL4uqHH+jZ0emCApyoKNEm/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSCdGgZrnWM/dV79DPHA34mmw7xEeg0GzvzXl/q1gv/tTvE28BhZm37ahxnOqfkYEG3evhcdLLp45ZUMsF5+y0HAGxXJhKlzPj/FbowCXjnGp7j341JHosTWOSujW9Bnn7jL8J4CsGj4aQjZSmCvpYmrsP5+AAZrOZqstu/a6YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsL7DrV+; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsL7DrV+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e88b60121so760460a91.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 06:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785935113; cv=none;
        d=google.com; s=arc-20260327;
        b=WD5lJw0kZHIfXFU/TdeVznMQcDlJYtm2P4SPfxjft4MdEFaF+IvFb8W5aBLJR+N7ZY
         mEmcN3fJOP8wPISgSkVlr1sp8H/4FgPvgb8vGSwCjUVdeDTigjoamV4nlviY2oXFzEE7
         hIXcO0826WHyq/EiUbnyIz1BQqH8qKGLlpLcKB4fMQ9bVBdkulnReDl2DkI0hIxVcUD6
         AHRiB+trfzUoLAqEix3qFwdpIbe9dkk1g5tc97KqSAHHxmqZHw9esw1nWcxLh2cjJFP2
         sSGG6bqRxLWOuE8yYEl8LrTNtTjl8ZHjk73d+i8jp/W2Jnee6OMGJEBG1mGy444+F9VB
         kJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i71L77tJ6SsTzxmFVsrCL4uqHH+jZ0emCApyoKNEm/o=;
        fh=wUgEknPp8cMGGcnnUefzzyTbZRYTECnVN2FzkNvzZ70=;
        b=Jhb4TAAnyPgAvqpRMLcHwkLnci/8bjJ0uJW8dCK3RoMNVJM2v9P3zKnpcJMdEcQ4Cj
         nJojedAaRiG8dRFU6onoGZ5Vz+F4y7pJ7uItT+Wl75hnD99Jn12xnUOKiCQGDkDhoDW6
         Pp1ZWm5oD1bMTxX0//p3C2q/KcmqR9GWNLLrSLa9Iaipcg3b1hZUZTlhEwBJWc8n33uB
         CSBAzNMmKQTrYgMwQmEMl5auenGd4BQv+Kse3WmxPUqXgrZFzvWB3YCBRNrsbzB/pCnE
         qSDfTB/yoSgma29TzGLiRniDTYKWXOPcisx7DC+biSUqLTXqzYwdFVnaQAutK6Vcy1Zb
         XTyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935113; x=1786539913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i71L77tJ6SsTzxmFVsrCL4uqHH+jZ0emCApyoKNEm/o=;
        b=RsL7DrV+SeoryYd8lkRgGwmk7BuKSTB7RFKGmagmwGJCRPPrqu7ERQo3i6Tg5ipr6I
         H0p3eN0aw8yA01cYTMwMt0TbijzaUWhVf7TpQw2qMAukgI1Thsm674s1rb/I6VC6rT9Z
         5oN1NkU6J7fFkOZPV8akVWJRzi+4mmK8HJTF/vGE7HNS984uilYpLSeraGkcHSDmfSKB
         I/dL7dd72Y1ucwh2Sa4W+bgFE91nmv09VJzorqlo73J4OdePWAWBhRnefFuhaCKGEuWb
         hjFdnnVphM3Ran0KAEfl7y6knOGTjppwRYCmGRz8S+NwIU8XpCkxGeWUoH7+sQ++7s90
         8L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935113; x=1786539913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i71L77tJ6SsTzxmFVsrCL4uqHH+jZ0emCApyoKNEm/o=;
        b=ILpB5L+kkFPlaEr0X2O99Gap0AtuM1Rik3qakWLIPPM1cknHP7QTFxQ6Z3h8+VIhm6
         aDLFx4JXQwUAXZoXsvjvOM6kvkqR+0YOgZDfdePxtigN3t+vBvEpc96UxLyldUwU1jkN
         awRaId5yu9uoEBEp+Kqp8NbJ4b8sHt3xZHOag4vcpFmczT78zHwsHaKqiyZRuI3EgCSA
         XUx2QshGRUHX3UuF+6DuVNgQvq19Xhcio9/EWbqlaFcFe6KZVMdDJEttzO7sfBIrqa1V
         N+fQh9qEtTOImWr8JbOygXr8s+mEnK0cv//a7ru/WNyl1Fl1HiPIIa1ie9bpxdwyVyvI
         5LBg==
X-Forwarded-Encrypted: i=1; AHgh+RqgVC/vLwF3J8/g2Ae89wb+u8EPdpraHoSdrofoTRH7Qxj2sLde04Fu2HBF5uaxVvDvnl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIKWMchqagYqlvc7GVlOi826qkhBs2OoY9AuFlIRTCZaGXNIM
	GGN43r0jhnIxz55YvHeKxIRhZU6vWnN0/cHbuoN0Botkgxp8kE1hy13kVIqHUVdAtuFV/yy/8Vy
	tpB4Wyi1jD1dIxQ7h9n+lNodfHx3zuHRaz2MR+34=
X-Gm-Gg: AR+sD12ZY0tvUiA5kO8Wv0gRGkXN2fyZpj1K7mTJ7Fb1vAUi+Vrnmh0VpjPkz0Sskwf
	JmsUuXgNHYLByuReDY8exNndkPxJicxuG98RULODyy0p9xWdBWuiNficUY3fZyvjVz53OkuJhEC
	1kgmxd5VOQbaaRYgeKIBlwkyLSkM0C3PbaoolHx+gSHXbf+nd6XGYKT6IUbPZX9hznE1lwjEDdz
	poDKDhNGrw1UrpYG6J1sWldTkQtkC0eIpCBDQHFBDAPNrpAaInvVyjK/QyiZycNQjAqbjj+Ymlt
	OJEjuhd+Ag/9bGcfe+h6jLligsLBDoWjZhGXNJTTS1h70NrUU/uSwt9OghMQ1jl4+R7ujXTKDUF
	DQpIvd34TBYa252+At1CzFc1bU3059kV89GGX85MK4E2xy4s3ym4dOfmFie99jU+MHYzNOlZFpI
	AX7pcedHFonVgeGS//4ZR8DxJXj0ZH
X-Received: by 2002:a17:90b:2dca:b0:38c:e9e9:e7ce with SMTP id
 98e67ed59e1d1-3903c559283mr7382561a91.3.1785935112871; Wed, 05 Aug 2026
 06:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
 <anLXz2vos4zbIciW@pks.im> <CALnO6CDtihFytS1dhfZPDA7jUL3bvAt=zYOH9Wi=naEoC58B1Q@mail.gmail.com>
 <975a0661-945c-4a03-bad1-14db929c8d97@gmail.com>
In-Reply-To: <975a0661-945c-4a03-bad1-14db929c8d97@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 5 Aug 2026 09:05:00 -0400
X-Gm-Features: AUfX_mxxSdwJId0szciL3_73vvAxDLhtMokBjL0fno0DzS7Livt_PV0rtPgnZKo
Message-ID: <CALnO6CAxr2+SV-1YrJBsb2LPqmzxnRSiPYXPqRQs384bwUO+mg@mail.gmail.com>
Subject: Re: git-replay/git-history lose notes
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:00=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 05/08/2026 12:39, D. Ben Knoble wrote:
> > On Wed, Aug 5, 2026 at 2:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >>
> >> Hi,
> >>
> >> On Tue, Aug 04, 2026 at 04:06:38PM -0400, D. Ben Knoble wrote:
[snip]
> >>> Are notes out of scope for replay and history, or is this just a
> >>> "nobody's gotten around to it yet"?
> >>
> >> For git-replay(1) I'm not too sure, as I consider that command to be
> >> part of plumbing. But git-history(1) is a user-facing command, and
> >> because of that I think it should handle notes automatically for the
> >> user.
> >
> > I can't speak for replay, although I do use it as a convenient "rebase
> > a bunch of local branches that have conflicts without checking each
> > one out"=E2=80=A6 but the history part makes sense to me.
>
> I think having a command line option for replay to turn on note copying
> would be useful (and as a plumbing command we may not want the behavior
> changing via config). The implementation will probably want to live in
> the shared code anyway.

See also notes.rewrite.<command>, perhaps? Although your point about
config makes sense.

--=20
D. Ben Knoble
