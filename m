Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89D225401
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448838; cv=none; b=HNnNBiW9u+4eMVmrEdx7cNGdAuVxuWDo55B43Ydv/A+Xs+YXoZvaEeVfCLLOZRpacY6nj4rUKAJShHkS0rxBfQIbysX6lBGq5B5JKeELqQDAZUf9APSKMJY6fulixjdmyKyHZM3kRAybOt23gJ9hoyV+IsobcpmH7w7MCgc9Ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448838; c=relaxed/simple;
	bh=spgcmsJHaRZALBsMpj6oXrQ1r8A4iZC43GmkJ7qlR/g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn5z6xABCx1EVWE5bKw/j9YeGrvv9fZjImtV/kMHL6uYpbwsDJZwI5ba/BOkJxy/xICeXAPXHrlq9LNq+G8vt1x7as7g2fiCpIEUJJxi3vy47VbDo5e/tq5onXMjg9qox6Tz/ChaHgsbvQ4W0fTTb3oHfg0eE4c1cRaozylaXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=decentsoftwa.re; spf=pass smtp.mailfrom=decentsoftwa.re; dkim=pass (2048-bit key) header.d=decentsoftwa.re header.i=@decentsoftwa.re header.b=dIL6eQVL; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=decentsoftwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentsoftwa.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentsoftwa.re header.i=@decentsoftwa.re header.b="dIL6eQVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=decentsoftwa.re;
	s=protonmail3; t=1760448819; x=1760708019;
	bh=spgcmsJHaRZALBsMpj6oXrQ1r8A4iZC43GmkJ7qlR/g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dIL6eQVL6YrWwkrEu67H0pzEqVurU759mon9Dnli5axSj5SJqIoGZ3frYTDHI0KMj
	 gIvZzBzc8zrPTS9PLaML9lIIKTF3uThOqRMrQulpBzB4bvG/wJxF2Dp8+SRZe9biTl
	 INgRV91BR7lS6Sokq36bvHTSanAL2k/AvMn4iA8bqoDdcOejHS2iKJe+3ay4x54FsC
	 kyXLfbSASqTLzxZJhLWiHhPR2qCtjybdsTV6erGGPxyUMgBhptspn8v21HpXQG7HB6
	 KB28UjDW+xptiaAV951b8snnk6XY/zRI4/HfPsvMUFxx+ItyqZg+rzJMV+c29tvCJ3
	 r0T4+5olM14cw==
Date: Tue, 14 Oct 2025 13:33:33 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Philip Patsch <philip@decentsoftwa.re>
Cc: git@vger.kernel.org, =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: Re: [PATCH 1/1] docs/git-blame: describe sourceline and resultline
Message-ID: <lxqjvC-77mAgt6TyBUP9hPJuB8E579EkO0iEDkGRrQvSLvWVtivu-0_nCSY_z8fRbOBG0XZNPveSQlY2Lm_2gJLI4If7N_oD65VH_l0Kc_M=@decentsoftwa.re>
In-Reply-To: <xmqq7bx28rpr.fsf@gitster.g>
References: <20251010152204.815520-1-philip@decentsoftwa.re> <20251010152204.815520-2-philip@decentsoftwa.re> <xmqqldli8vr5.fsf@gitster.g> <xmqq7bx28rpr.fsf@gitster.g>
Feedback-ID: 113716443:user:proton
X-Pm-Message-ID: eb1850e7d4bb3ff6f3dec6cd8bafd8324d20e43f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Friday, October 10th, 2025 at 9:46 PM, Junio C Hamano <gitster@pobox.com=
> wrote:

>=20
>=20
> Junio C Hamano gitster@pobox.com writes:
=20
> > - the line number in the file, where the line is found in the
> > stating <rev>;
>=20
>=20
> Sorry; "starting <rev>" was what I meant.

Now that I look at it again, we never in the manpage define what a plain `<=
rev>` means if it is given? Am I missing something here?

We have `--reverse`, but e.g. neither `--since` nor `<rev>` appear in the l=
ist of options (`--since` is mentioned further down in `SPECIFYING RANGES`)
