Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B734BA4C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133442; cv=none; b=GIVuWntRKkxXWkTzjS7d6gE+IcmT8s1VtVxQLO2uDVrU8VISdAmm1fUIwelUYhRAnqaMSNpRONlBT/zPAORM4NrznUzT6++/IeTUGI4ScS/pPZlqrVVb9UY7l+paBmlUCutLlQvTx69DmAGQimHAk1wr6q/hIar3HaODMik+/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133442; c=relaxed/simple;
	bh=sYOAywuZmPsPTfT938g/GLFLfrj92GeQAsgojnmulak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCoUJu1OMeklSyFBcp36VaTwbMp3PxujL9IjIZZBw7WLBiiC2c/oredqqd4TQCFqU23ZU/jwrxHh034Ue6sewYk1OkRl1JFcjqSaQWeNhO4teWsy4KrqqwlDwMXsdf0jbpVzouZRQf2SlsvuIlt0th/ZdQCdh+zg5zJOJnI4JVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERLsxEH8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERLsxEH8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f28b8e12cso102674a12.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758133439; x=1758738239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+3Dhazi+/rlSLUohaneE6Z/TFi/02oJoyRcx1XW0v0=;
        b=ERLsxEH8LLoA3okcQq1hq2mdGFrBK4um6YvZylPoOx/bL9TrhztsUaW3MTSsgi3czo
         upjl5VH6Hoc9mQz96i2lr8b/77XN9mK57Gk3+SHvnm/SrnFXvS5QLQGij7oUrH46i3Px
         PRvodiqyD+oBfGPvgS1HjOQAdvnEdLefLu4fqqNqUzYAeYIssj/+L56omd2MXzpAPwXj
         M4i8+0elkdEnglEjMcTtFi8nJ3JfWY4QGRPlbIwjdH+sZ0Zk0s82pex1eld6xZrQjw9p
         uPqF/YWAgN8Qw5wOk4k8VOngrjkgi9kaQpBZXK1BACfqJc7GWRX7Qap7nLGlXPsEf+Ml
         Wh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758133439; x=1758738239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+3Dhazi+/rlSLUohaneE6Z/TFi/02oJoyRcx1XW0v0=;
        b=CeNQMH4n3D/MSdI2KeIRSyTzFJYnz6arFmIWKbE2CUYeVADjn02tWHM2nRvrLIasu0
         H0I2G0pDgowT/KEXC21Oxb+xRKnI00EtdFT/0tUQuqPFwb+6ZfRFnUrKrA2kSNfs4jTd
         pFGKK3PY0LADa266aBWF2SnjBo0+lPPO82NI8NJyoeUkC++nnVtIWBSOgp9H9dpDaQzI
         F7Yqz/pqhENU+HL2k3bdxLPSk2NsKoHPfcLFaHZpKe6xn+dvhcCGjreKqHw24dr6ahvf
         qVT06Mo3FDyLCAB82NlX9IxkxwVB4hyZM0qhtTjWZV1VaWmPhkStoj+mT0KVqLA1X3qt
         BExg==
X-Gm-Message-State: AOJu0YxHZD29m0snmXI1IwkTXeMqq4H3uxTRJVVpnBP6M4I+N7M8T1+0
	ZNhpX6f/3HkRTxB4qbPPFyOrhzT4MKbx1idPEfdJ9je4rbJ7u87QDefr8+smLbdur5U1hopk1hK
	a6LV/ABS/yECsFnUkcVJyuDKVi1/rX9Q=
X-Gm-Gg: ASbGnctZI8RadGIFGY61Az+nxTsMIwsFa8qsEiV9/opv8G5JysQPwPS2b7zSgLwjVR7
	ZyhafOFEpMH9hdY0OALOAYMoyuAOzekcNGyLpSxanWXKOynzDWLuEwjpVKMTgtrxm0u6+zWfL/G
	Te7iT0bq61T21nxFci9aAP6kewDfQCd5blgP8RGZNupmwKkFlRQxPTVpwyQGh24oC6AxUjUpyHc
	RIjVlxbj87LpUbXwQ3L
X-Google-Smtp-Source: AGHT+IGSWCgb/cQTxZg7WBaDoZzC8tITwfdjm6r6VEPvq1CXS6JeHLD1P7DesRKui8A0dysu0AoPbHi/UmzOKyOPa6g=
X-Received: by 2002:a05:6402:2103:b0:62f:4192:ffbd with SMTP id
 4fb4d7f45d1cf-62f83a2bd02mr3013352a12.12.1758133438586; Wed, 17 Sep 2025
 11:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912124042.2523683-1-christian.couder@gmail.com>
 <20250912124042.2523683-3-christian.couder@gmail.com> <aMex06JNPVeHaw_d@pks.im>
 <CAP8UFD3-3zjBBHP-Y9nLO-qEyhkWhD_pxFZhk6rzrC31LanDMQ@mail.gmail.com> <aMfw4rboBOemzvr6@pks.im>
In-Reply-To: <aMfw4rboBOemzvr6@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 17 Sep 2025 20:23:46 +0200
X-Gm-Features: AS18NWD8Rg6IQ0W4jEtcuKMMYPaaQs-XAKjyTzlgV0vxRjleRMU26OKqUe5whOw
Message-ID: <CAP8UFD3LNnDfc5KDGZUTvbHoMrHxN=m6KjH_c9GbDztpiUNazQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fast-import: add '--signed-commits=<mode>' option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:56=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Sep 15, 2025 at 12:17:33PM +0200, Christian Couder wrote:
> > On Mon, Sep 15, 2025 at 8:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Fri, Sep 12, 2025 at 02:40:42PM +0200, Christian Couder wrote:

> > > >
> > > > +             switch (signed_commit_mode) {
> > > > +             case SIGN_ABORT:
> > > > +                     BUG("SIGN_ABORT should be handled before call=
ing parse_one_signature()");
> > > > +                     break;
> > >
> > > Let's be defensive and convert this into a `default:` case so that an=
y
> > > unhandled value will cause a BUG.
> >
> > Ok, maybe something like BUG("invalid signed_commit_mode value %d",
> > signed_commit_mode) then?
>
> Yeah, that should do the job.

In the V3 I just sent, I have changed the switch (...) { ... } but
there is a `default: ...` case with the BUG() instruction we
discussed. Hopefully it still does the job.

Thanks.
