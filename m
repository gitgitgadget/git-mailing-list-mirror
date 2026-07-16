Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA839A7F0
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240110; cv=pass; b=q+OEIZm3rlc5O8q8TGRg7vulujY34qgWwV8+tArzJIXY9+Ca8gt1DcJtFuPDuNK8e9vMdrozAjoteW5WvhZPZFCgaOlyKUrXPEBVIl3z5TG4VsgD/X3ZK3+pLUA6eFNnwa10owTycNbryK1TexZ8tlJy6HRoXq/MKO7HgvTsZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240110; c=relaxed/simple;
	bh=v1e1EOHcVjcVImeIdMifHRv2O2kqr76GhjaevJkHhV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McczA7phPij1Z4ZYJNq5gNwJ9gUHZ1xr5yrh+jC3c9LJD/8UbBsdJ+Mp8dfZN9Dc/wfpamxSNKx2UQ8MFPorjIIPluqgt5vb6PJT5cKQoNPU+T6id/NrbsDD//WSc8KfGew4di9/WG8WBgReQjaPuhl59owhOMl8z77Zg3vnifk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2QmIu8D; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2QmIu8D"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8484a0b998fso5906739b3a.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 15:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240108; cv=none;
        d=google.com; s=arc-20260327;
        b=DkN4HHWbHzzr5pYB+FGEcru5y253ONf8IFJlk45hg2dpgqAf9MrDN1uhE/qCr2O4r8
         PnBiAygMJK3dID2Cm5ByVtYgtHWyRqWyZgtoJSzUyi/fIEqMU/ihtp/OBlTiH+VcAaAy
         ywvMn4i1TzRiB8Bw37jwxdrQTa4d/Q+KOy7QXv2i2yzNeZ9vV1ZFwNXPVUDIX6jCz/2E
         HTSr6D6zkO5Jp0sQviLGH9rL7VF0I2/c7hgROM5fN9HO+sKF3RRZtci57sPzoUG2gav/
         0CW2MoHTlW9O+PQh8ItFtcEPKig5Dk8uEo3jVuPFGIeRuG5hk5HBXsV99sSDnp/QWSld
         DQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ajigXMvlNlpTsvbGm5Z3IYux9JOXAfq3AVkbMCf/Hao=;
        fh=8Ua7hT5GGazIJmWZ2/sgmUOiHotJOz4TVxiPkwVfGac=;
        b=ek5sQXwz43FArQ88o/5HuEa/1/wSfMWE05ymYiL8V8hB0mtgBUfgr/Ztp/zyHa9XD4
         P/PKAmSppLnNkmVrGoSvIkD1OLeNpZn8tyeVKVczfF1swQO7J9XJ0c08U6SN3bG5hZYu
         jqG/+kLj9qLI7uDpRdAOj5d0mC/+80brHs9T0o9b0tUz6p8sjyBaIxj3VeuyQcrSGUNk
         IHlUKXP2LGFiO9/ZSfVUifTz8KRqYCB7ODGYQDs9qSdSK+VGuTIIkmm+tZ3ErPimCAfx
         E94Jwp34cdcktYfYOgPXnChmwXIvHxnr/RxJtn0TN9Gm2Demsz8weuY5dug33HfqCMPC
         LQCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240108; x=1784844908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ajigXMvlNlpTsvbGm5Z3IYux9JOXAfq3AVkbMCf/Hao=;
        b=Z2QmIu8DCRwHGNleFGIJSBYC0hnG+t03KKqBA/noFDLD/i2OzDLw0cOYFyoqHWS71i
         A4WR5ugn823f4UDCMjPTvm2KqO6xUdhlHXHq+HQFQYZzE9jU8F99qMfJgVkUydGp3T6j
         1JElFAHUmEMfh3Qq/IPZrG22IqxZogrPwh02Mt3Ailga6dT0ETLIX1skNcRaKF8BupPf
         FK2Wy7ox54qdg144GOK0FEtU1bruB5c4oxZOrnY4qPCbqO5XNJjxwiyiNch/4JpKRw1f
         5Rcw0dkg7vgNWp940qBmLqIMarlY0VtZVXeII+caCvZAoHf9LSxxLkPFsJlrbVc4pS5/
         CLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240108; x=1784844908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ajigXMvlNlpTsvbGm5Z3IYux9JOXAfq3AVkbMCf/Hao=;
        b=AqNfxXP0R9ymFtH3UDQpOD76h21uI56IXIlwUQu3QbvJV8EoyXHX9aniKyKKpezpEt
         WEHvK7WCbWUlVrHLnVM/aXo1rVP8AL5MRmufSZZct5drM1D0ak8/RyjRhWH7HVxfGmLX
         gmjeDQbddXV/zAZ5rReVIUSpKZDcn8uXtIwxW4alJ2KezWqGymRsZQmuVX/cu8AJ2BCI
         1FPmRjVWn3SbMu06lQ/Jdaf9wrmjNFlQDk6kZJ3FPh0hTyZujwE9UZJZ4GqPEaJ/3P1R
         vNXOeT7DEZeNN+zZHyOEDDmW0or+Zh/fjHVsmP00MPlojbfSmwVoVt0DRm3ja4CEfMR0
         gHhg==
X-Forwarded-Encrypted: i=1; AHgh+RrgoEKmpNWis0CmZzibvhtHd+PKM47yq1C77ZFxGfqgECWmso4z7WEQJiZtmv4j6WkJinw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPRHZmcYMGfLuJKpLMDx5n0z8O6TCCSnf9ohRBVUbAN1+/Hfl
	6oE72KNSdihBZAuRFwAYH6WP8Vbuo2y4uby4fnIYwnOojAsLO0U4oLk2u5aa1LPEK8L0GDQecKx
	wriEdmxkWo/BD5A96CBye/DDaO0O3NLc=
X-Gm-Gg: AfdE7cnxNhGh5gbcPb/gj0vg3mswP8HGq/JmwiidYbcHuWJzwwXRIcTLlLcotIdsI8S
	BjjWSKbWebbzeDjZNcn3gfCCUtuObpBD192CRn/E+W4m2To2QnyNd1qNsmCRMfrnwUH2qqrXAI/
	jcNRMIPyejNLPQILq3TmMgYMcjYxdRxJmQbcSvlPaL4I4Va6/D2BHxkneRzkTmvLLSk2vmKCnt6
	NYgxrrNlKc8uPQ9Yd+cgyMYoihp7Vd0fobc3FXtDX30eIaQg0nWThGRlnI5fdPSE7CpHGzgl2K4
	HGe6+avVlOS5RG/JPVZ4wGSBJiMLbE3WhUlmS8qiaCBO7vOBVFkRAT7s2szBmQH7+Y7prmsSiVj
	O2gFflE7K3RKzuv6sdBj3D2RJGa/a5/DUEA==
X-Received: by 2002:a05:6a00:12d4:b0:847:902a:57b5 with SMTP id
 d2e1a72fcca58-84c23704743mr1130115b3a.35.1784240107615; Thu, 16 Jul 2026
 15:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260716165517.433849-2-christian.couder@gmail.com> <xmqqcxwmeiwq.fsf@gitster.g>
In-Reply-To: <xmqqcxwmeiwq.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Jul 2026 18:14:56 -0400
X-Gm-Features: AUfX_myrB9wijyw3d_ySQ7xIozewSz0H9LbUQ7tEhO6ieh_x82k5S2zly6LReqE
Message-ID: <CALnO6CCauJhCmgKjV6QJ44cZD=2ah6=rJaV0+2ZMYTo7ycghEA@mail.gmail.com>
Subject: .mailmap etiquette (was "Re: [PATCH 1/7] parse-options: introduce OPT_HIDDEN_GROUP")
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, Git <git@vger.kernel.org>, 
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Hidden options are not shown by `git <cmd> -h`, but are still shown by
> > `git <cmd> --help-all`. If there are a lot of hidden options or if they
> > don't belong to the same categories as other options, there is
> > currently no way to properly group them.
> >
> > Using `OPT_GROUP("Foo")` means that "Foo" will always be shown which we
> > don't want if that group contains only hidden options.
> >
> > To provide a way to have groups shown only when hidden options are
> > shown, let's implement an OPT_HIDDEN_GROUP macro.
> >
> > To test this new macro, let's also improve `test-tool parse-options`
> > and test its output with `--help-all`.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
>
> We have been doing this for quite some time, but I just noticed
> that the 'From' address your MUA uses ("Christian Couder
> <christian.couder@gmail.com>") does not match your Sign-off.  Could
> you add an in-body 'From:' line if you plan to keep sending your
> patches from the Gmail address?
>
> I suppose nobody has noticed it so far because .mailmap hides the
> discrepancy once the commit lands.
>
> The changes in this step looks alright, though.
>
> Thanks.

Speaking of .mailmap=E2=80=A6 if I were going to send future patches under =
a
new email address, would you prefer

(a) a series with the 1st commit being a .mailmap update (subsequent
commits bearing the new email address, of course, but unrelated to the
.mailmap update)
(b) a one-patch email with a .mailmap update
(c) the same as (b), but only after commits with the new email address
have stabilized in next or master

?

[PS happy to drop anyone from CC who doesn't want this one; list
etiquette is a bit unclear to me on this kind of subject change,
though I would lean towards emptying CC and keeping only Junio=E2=80=A6]

--=20
D. Ben Knoble
