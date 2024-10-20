Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58F1DA21
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729439014; cv=none; b=PwJXajjty0sbwvEvRtfPf01Ftw83t2me+SZkFNJdkpO9M9g7YVdcRwZ6JE25JWkbXJWirE7IQ3ucCtASruP9y25aggYNpFOFjJE353Y33Ba2sJvxwpIS+r7dWa1FHElShJvQLp5oug6o7U+xELNSLAHaMmgLf7oc7WG+EkHDr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729439014; c=relaxed/simple;
	bh=mOwvL6IEET9fA8aY45qT5CUzyz4/E4ZH2GO6Ue1WXbk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzVSKQiTNFWaJma7NqPY/hlRqwjdIsKfzYm18y0UW9iu4npgh1TY40RZGCU8AZCggoD/Iwqj1b7ad2AmAez8Emfh30zPTytCSFDAohMb9Gvu4Nz3mc0Kzo5jo1ml2BDOr+BvSTINOyYWbkuUwIlH+YG2+2/E4HmOZdhUUw862QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me; spf=pass smtp.mailfrom=kmatsui.me; dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b=s/XfYBGW; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b="s/XfYBGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kmatsui.me;
	s=protonmail2; t=1729438995; x=1729698195;
	bh=vvZX4ZwVJj0905zdCYr/SKhMbyM22iXII5/txvi869o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s/XfYBGW9pu8tkItjc421xwVtVf6bZ//yiyTFBepjbor9ldg+Yb2G6j/8MQ0l7qXI
	 8xHB477YBAVMKu/B9NSK1Hkwkq0P723LGl+MreakWvef/2pb3zL7NUJP3lPPRGrpJZ
	 D91nE/K1dt2CbxsdZ/XyeRDdRELA5ez9cqFlNdcBICTy/J3EWmy5MuR/qfBm2GW5W7
	 1uEOOEdMzopx+Oky5wwjy3tazcdAHqDYfg5osjUPfDdbJoBuCr0uVvXxKvs/2+u4Yf
	 /kSqlnXcvAYz8U8bAqFnKT6zn+HTqrhgT+0yXluyRDmYKjJD0GfnH/npWlA7K2Izi0
	 Ve51+qXty5bQA==
Date: Sun, 20 Oct 2024 15:43:09 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: Ken Matsui <ken@kmatsui.me>
Cc: git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>, Junio C Hamano <gitster@pobox.com>, Jonathan Tan <jonathantanmy@google.com>, Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, Victoria Dye <vdye@github.com>, =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>, Glen Choo <glencbz@gmail.com>
Subject: Re: [PATCH] config: support remote name in includeIf.hasconfig condition
Message-ID: <xalChncOvSTxgRdafL-WiQtTfzneMRmhnIFHbEYeRLFYTHgdghc-Js34ml_XpkMBJQNPk68Jj2Q_aAZR73mhLig_Pmv_DSmweukWWqVDLLM=@kmatsui.me>
In-Reply-To: <2a9a4371-958f-491e-b78b-6d4da51483f2@app.fastmail.com>
References: <20241020152323.90543-1-ken@kmatsui.me> <2a9a4371-958f-491e-b78b-6d4da51483f2@app.fastmail.com>
Feedback-ID: 103884984:user:proton
X-Pm-Message-ID: b1ceeee2b7f09dd359994ccb62288806236ea342
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 20th, 2024 at 11:33 AM, Kristoffer Haugsbakk <kristoffer=
haugsbakk@fastmail.com> wrote:

>=20
>=20
> Hi
>=20
> On Sun, Oct 20, 2024, at 17:23, Ken Matsui wrote:
>=20
> > Before this patch, includeIf.hasconfig only accepted remote.*.url,
>=20
>=20
> The conventional description of the current state of the code, without
> this patch, is the present tense. What the patch does uses the
> imperative mood. E.g.
>=20
> includeIf.hasconfig only accepts remote.*.url
>=20
> See Documentation/SubmittingPatches, =E2=80=9Cpresent-tense=E2=80=9D and
> =E2=80=9Cimperative-mood=E2=80=9D.

Oops, thank you for pointing this out.  I will update the
description and send an updated patch.

>=20
> --
> Kristoffer Haugsbakk
