Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FE3A5E85
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563066; cv=pass; b=MgKB5yc1e2pmJmvplahlmGgJfdu4OlD3joWv58y3iZBXZkhyjrrYS6VWemCpWG+PkTfc5frKPSs4Eok2zum2Wm/jI6aEE6ISUWAZlQQrGG33dT+6QT5S9L38ncPPBupcKmlAjCc6LlIlrrThxn2buCBZBCJ1iz8cvE9hD1U4Mbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563066; c=relaxed/simple;
	bh=rzw/twTOk0jBlGlaZOJmSNRxxAvy/aJI01cJWzY6e5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb2MebpchHAsdeyoLMEXT+Qior5cKzxFHeDspmhiQEr6BZfnPW5wHvGOMJUZH+H8hjNAKvp8s4VaRjOKS0QId17Dpj4KYACyMlUBMPC8bJegP6vJ1BNUy6d39NixPvsJKvLZ7GTRfLukBL4z/kEMs3rvF8cVWcHTPn1itET6he0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc5ogwsj; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc5ogwsj"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so12390c88.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775563065; cv=none;
        d=google.com; s=arc-20240605;
        b=U1jHk+8JxmecyLP0WO4mtRcBOKoFRy8mkuE9xamjyhQAY+Zu+LngwumW6lCgEJb14b
         7qnDgKG7KLieOOy7pCzONqaMNEvoTeOGeJajFtH+jo6uJooscMsasI9yrdWYF9IudSNr
         NRx9Atx2YzXfNpYFYnTPU8COzYn7HblDnQo/3zvW6F8g+LuLKLHQrYiur7JhCFc8xzkX
         L+5MuxF779/k3tDwIbLX5Beqj/ydPOflCvzXXrH+Z64A6GjucwZq1ZvQLcLGgiIQMrBv
         3bi4mccW6HZRxcUT7vR7rRBunVrPUCN/5S+Lq5o04VuFq1oYS/6wDoggp0tvcrSiZg53
         w8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ytdE4e1FSobQjnrY1mwKHM7CZOOp2Rv78FNC9GhVOc=;
        fh=5KTaWn1yth0H7OQMdtt+ZvdAAPCKPa29tvFSRge+7+M=;
        b=FXe0M2ci+Tz6wz6zb9SLuivQ912wYjPZIchUZtokigYnsUyEYi2uKldxTMTrMbXTxN
         2xj750oBrSWPg+XhJEb0qPiSdQe2f7J40M0pelZ5lCwFe2/65Y8NXV3Fv/IlsT7fILfm
         uzriJIckHL+xHhNMTRSwl2fTCAMRK2D1pGFsB2oKgtK+NazaqFHacH1NNwEcxqZP9+5D
         DAgovULVZjVPe/CFlgdEj8IT4ceFCPE6mt4mmDidES2BbH7UP1DTUqZZTr2Ykm/oad2z
         C6P2+OAwEbhpij54vqgYJ5NX8yCTfCGb+fKCZMv1tfilUGDRnGkwfmYVvqBzgmtookys
         8q1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775563065; x=1776167865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ytdE4e1FSobQjnrY1mwKHM7CZOOp2Rv78FNC9GhVOc=;
        b=Tc5ogwsjlwlawhPveas3OKRG43ejKryRLk0XQ99ovTCb41E7HN4tYmn8TO0fZoG7Wh
         nX9ZtC/8QTKm+Y0n0xqZvMNxnqr57lwczAZaKK4du3rnv57HP1lIF6/893yeu9TKoY4m
         e02ISeX7fMQNLAF782ANEGXNx5looC8pRR0VpxMDFx6xt24DfwI46Xe971ACVv5BSPYY
         Q503OZPqTVf9CLDNeA3hmj2FBCbV4RMTnBtywfv/k10uQe3HfKsSVy4eaYwCvcRPTkNk
         OXnEMsWIGPrt592RlsshTSd3LobYMq4WkuVt5L5Wt3eZWxXLPc1KgNZlkhVoxjJrIVwm
         Ft9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563065; x=1776167865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ytdE4e1FSobQjnrY1mwKHM7CZOOp2Rv78FNC9GhVOc=;
        b=qrPRv7Tn406UXgpAmTvSnHflSEx9fbaMSp9SQb8KCFYuhua8BrRKApHWVJhTF8qVss
         ch/C63IRspNijuwvFAV6EL9LuLlChbJMNeOM1bldtuOwYDRaE6r30ZLqiuZm/hRdJeXj
         bKCAIDafqzyRaOceFrFOz08UgD3170jD/uxF9+tBmToa6iZihZuUOimaOevJkISTFRfQ
         YhePiz4UobvbFLclZhUcpSslzfDLndO5YshSsM1BnFOAi+6lDiSHiD+SpS7qdtpvDjam
         qiyks23h5Y+agsRD5TtKtWR6tuucXJL6j0hJ90ysCD/f3FGf73jE9U/uAAD08glWztyQ
         Cf0g==
X-Gm-Message-State: AOJu0YyxR7irwwG6udExuZVo0RQKGVuMs3CBc8IN66d7zX2l3Mb5wxO7
	MHwSfW812P4HIbHvysfEzwRaXL6QOpgUYQblPSZ8dXZ8gl7GDO3unQQkLX0mkgCSe3XK+PvO3CP
	NUbEXxOwntziDqyzzC1j7kmQf17vvYEE=
X-Gm-Gg: AeBDieuBsuZwJV98fLVQ7nQ26LuCzOskBqMhPUqdx/zh9vHdw8gd4Z3nMmgyPihC3Q+
	KQwPlWhMyzn/PUbFFEdNZLOS50kIB9Yl/jy90PGP8y5Sf/T7vj9E1BdJ7pF7GW8wRgEu13CJ7uq
	BqANik6mzQjYyVZpGkyc+uqd4ZiNaLg/bknR9dJuCnrE+zj+MgiVXaGOQZmwpbHuw5schHpnR0B
	1MI3ARLiHTJeLoqZygVbGqQKwgF8ORdP2XdcoyOCCC4xjWFZhA/BI4leizN2CmlhYZ0NMayTPks
	JyXZYGA/q+2jm3hpdDDsVjDN8XXAezhnydn976OyQJfAUEY3lzm2tpnWcJYAl6hpQTUL
X-Received: by 2002:a05:7022:ec17:b0:12b:ebb8:e421 with SMTP id
 a92af1059eb24-12bfb777fc2mr8200782c88.35.1775563064639; Tue, 07 Apr 2026
 04:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402070613.85934-1-christian.couder@gmail.com> <xmqq5x69qkcg.fsf@gitster.g>
In-Reply-To: <xmqq5x69qkcg.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 7 Apr 2026 13:57:33 +0200
X-Gm-Features: AQROBzCSdDAHLN50tPZkQrQU1neUQD3DLIklGuuG7zu83R56FejL96xQ6-NNWiI
Message-ID: <CAP8UFD22qtZk-WmkCnRN4Ws-pTe_9DYFeFC7xxj8e6hBk=yJ2A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Prepare for advertised remotes auto-configure via
 URL allowlist
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 8:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > Range-diff
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Sorry, no range-diff as I don't think it would be quite useful because
> > the number and order of commits has changed a lot.
>
> When comparing against 16-patch series from the previous round, 6 of
> the old patches will have no corresponding patch in this round,
> which is expected.  But for the remaining 10 commits, the command
> seems to do a decent job matching up the corresponding patches from
> the previous round.

Yeah, the range-diff is actually better than I expected.

>  It is especially pleasing to see that the first
> one from each round are matched up and showing that its tests are
> moderately extended.

Yeah, I followed Patrick's previous suggestion about adding tests.
Maybe I should have mentioned it somewhere in the cover letter.
