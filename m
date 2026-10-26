Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015628;
	b=XiMbzd8yC4/G0xLC1fz7Bix8RN5CgSheTjrznLn4kfLwQrd2FTK/hBMgHdZgs8dK6rat
	 22xI1/39tso3hi/AKEg8xqNseefQL1njaR/cp860GKLEdja9JehMYGxLePEqTgQwZrqKd
	 kQeu7jfkMdHq6YYz3jlYrPZ3JFc8YYlcPPbhyTgm4FvHkSgbnjV1kpKZGlCDyuVyhJ+oV
	 nio3t+4IbxBFEsaqVdLGS5HOPte5KD+yfZuXMt3ihPn3UGb5GqiRxGDrcxGb3iPAzBqAl
	 HYKXgVzi8C+OlrQHhUDBF5ubtCU6hfZdByl55+LR8BYxC+A9rvObl8eGmwd7dVjO46w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015628;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ajlQVDb6P1IRwNBPvDqXtrEPzilXHkeAkYa9AOkgdew=;
	b=R0EHsS1C+COXqGr5hkRQUzrQ+1pkRuefGRyGZ6hE/BPnRW6qKaENmeZ++BNQ4BwPln88
	 ulXnFQjvNGL+rBS051iR6z3ZNHHpo8zunIfWEtPn0fD66OJcGzQXRtBB9VYBXSa7nAKv6
	 cae0dqW7rHtLjDwHF86rgoNVSG9jmN4/yWpRJMChdcZTFTm8D/q0BNDAfxYBj3lLMqCDP
	 23jIFd8pGzpWAGawulcLnu9ggV3dYcKKQdTw2/CwRlhc6pr/C5ApOCxdnCUwEgrOXoq4H
	 I1upmcUpwfdsqbGrLjoE2RZ17FQJqTDSVRlBlBvi2yDcmF8w6mVipFJlRMPpE2EPUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=roDoQaGy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Xa65RUVh;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49D606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC49D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=roDoQaGy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Xa65RUVh
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 355B81D00244
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:53:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 07:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793015626; x=1793102026; bh=ajlQVDb6P1
	IRwNBPvDqXtrEPzilXHkeAkYa9AOkgdew=; b=roDoQaGyqt6DFmUAwrNyQMcfA1
	iR2KvrtSt8oAug3xtxNlrsff6Y8HCB/GT6mxJmXm577Jd6/6XssBp78sbR20Xr+a
	1pSuVSkaWo/70szPrJZeQ8z1zqZpV/B3BKmMwTFky/gGnXeoZqw5qWxGROEAS6qP
	L0480Ki64AVElILxnTaNYpiWsvrOD49RRKfViIdHFzCb66STmjQp70fM2PQBl76i
	pml/e+X1yZxn93lF/xsgoCElrR+9npIlrcRdmYByl9AkWvV6w458YQD6S/ghZf6F
	G63eo0NdJyw+0H/lJR2COM1fxDw7qh8fdNYAsP5O0PNKz6bIjkWHo+9zhavw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793015626; x=1793102026; bh=ajlQVDb6P1IRwNBPvDqXtrEPzilXHkeAkYa
	9AOkgdew=; b=Xa65RUVhgGLRZntYElxPLggDYc9uP/KvKEnaSW8dTTImSJdfcbl
	Hs9awMTgfyHTqQgZJ2GNqLU+iDFLb7oIBrsAIHREhyR9VUqnuXiv0k4oYwLIbvza
	Yuha1Zl+MFjuJTenJzLi9cVS4MPzbNFKtaSNWeoSzrhCN8G8psqcx3fA+73x7BWn
	uXzHmGfgOxFlyYQbYJAriZPWotYDxY+XxNBVez0OH/BIRvpqt2eNQGmYrAXJNMY/
	iACdon7wvuxZ8fYQlAJ9KIoezC9Z8b2YVn0qQZBGKuwgMF8c+NAa/WTg6EDTHffr
	dwqCAohDb9/jsjGP2Sx7F69bdccTlNr0BeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015626; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HQ4X9lUaWlNHpBjuSa98Fxwb29v3L8RutO2KsvECX6JTv87
	KI9ghuwyf2GqSr64C1TsuHfcYbg0mVIBq0GmXObCd9cA1JXUPUM6a3QCNWBqDV2s
	zUVeiYwaszuuh3CiqVRyhSLOL/TvYblc8HFRRtBDb1GtnCnuYNej195VrzHVfuYQ
	I22dDZv9GGMugDULvmcbdTepgrLhyHVte90mUEL7Pmzib3dVx6l8KhcvCwdZyv3c
	Rv3oO4sUgKH5VGG9LXMzN4TtwxzTrb5lw6duXQykBTZPYGl+9vOXmYD4kGF5PzzP
	A8bwPWxJ8aNTW1WbF8Lw+a1/3j0GSZjg0A065vw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yM/6TnOrxkq3AxZ3Nkopt9NzgJlp8RP7iOsR8obrr1s=:H8nLCMP+JbS/EP4AdlUJsnvr8PYtSi7Rpem0nXw/0EA=;
X-ME-Sender: <xms:Sj_far-MXaeBDF2MiThqDIWiLHQlhBAtYUFxQKdRx2xN4eVN65byBg>
    <xme:Sj_fatsm8IlnPs0t7xJNZ_p4qMRlGLcu_fU03Z6Ng1jtSXXYMAdiCl88dupAodk_n
    xRWLE7gvMkgJCkMYvM8wprMjhC9c4NrSgpegNXixkEwgUlIbTwej80>
X-ME-Received: <xmr:Sj_fampDVm5e6CFsGn-lRgY1Hh_4Wz7ygRXn6EHg_3g_CzjiLICaUA>
X-ME-Proxy-Cause: dmFkZTFQyGe68v2nS+vjgxA8BdeRszjM8hkuPDSQGwbR0mu/i1SQvLHGiZRXdTfPUSko0y
    O0Mfc/+WkyQdhIntnXyGAEguU5LSho5V1hnNZjGkgDwIl4oHcWxwdcKB1XbMjMEMtg41Um
    wH9NFZWwGzEuxbTXm3cn9EAogzkmRtuhxRmkufc0f0Ukes5+p+shOAUCouLWrUpwSfcmUo
    62sW6Ul/uS6MlQU2GIDdEHoXB425hfAktM+vNMqXTfnWj/ooTiLfIsWwmG2jk0EEPSmL61
    CddPvv5h2gtC/VEmTD0M1xKifF4n3QFwX7hoou4siuKNuFDkee2l2AG9dbF2qWOu44WyCx
    7xZ09lkmv1O0FH5lTbGP9jHlLx2ZjYkFJzaHG9DYPAsmFPCDYTox04plRIy7FWtFnGuqA2
    q6O+A4uf1JH1C6NbsIqWAzAFMfL+Q4FtBYfeXM/YcG7QeJbVt20Gq2y1E2p6NuN3rvlEm7
    T06lVtYZRwPp1LJg52NKMFE/ekl2TiZtSVwVZOfOWBpjbsTGuLrgUwS/yx+uZvMCC5W3Ab
    pKLtU9au5JVyC5S1EktyGcr/KQpceTvzQt5HN5BjrzNeoqwGbCVnkguBG10i9KMGY+VMKs
    ZsXwNJ/BQJgkxYK5Uds0YTR/1ZLB9y/WB1ealN8JEpn7QcZnrtDxcZWwsp7A
X-ME-Proxy: <xmx:Sj_faik53rSQt_pKsmYslk_N8YklRzjUjgNS-yShB2AIdL3IO0ZtAg>
    <xmx:Sj_faiyqi9N-BaumjS_zbDifZFsLGDs4sK4TBDKF2HUdyLn0LeEs5g>
    <xmx:Sj_fainogjP7fqiIKnj6h-GInF8k0TG3lDjvzljO9qE0xwiBCpI_Nw>
    <xmx:Sj_fajdisvpoHgVCBzxQgBEE1EBJEWmwLtt54cjDuK5F8eghIkQ9XA>
    <xmx:Sj_faqv7JlZfu0VTJVXfjas5kEi1NJc3PoyVoM_XlCJyLJaBIEnkcAGd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:53:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a21e587 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:53:45 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:53:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/7] setup: introduce object storage extension
Message-ID: <at8_RyoMSePPIUyb@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
 <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>
 <CAOLa=ZTwedYbV+vFJcrACohX+epp4hUXSFXYvRTZ1tJPSNaj9A@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTwedYbV+vFJcrACohX+epp4hUXSFXYvRTZ1tJPSNaj9A@mail.gmail.com>

On Mon, Oct 26, 2026 at 04:22:38AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index 98c5c862f5..0649622bc6 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -27,6 +27,42 @@
> >  #include "trace2.h"
> >  #include "write-or-die.h"
> >
> > +static const char * const object_storage_name_by_format[] = {
> > +	[OBJECT_STORAGE_FORMAT_UNKNOWN] = "unknown",
> > +	[OBJECT_STORAGE_FORMAT_FILES] = "files",
> > +};
> > +
> 
> Super Nit: I would have dropped from this, as that is the default, this
> makes it seem like it is one of the backends. Feel free to ignore
> though.

Hm. I need the `OBJECT_STORAGE_FORMAT_UNKNOWN` enum value anyway, so if
I were to drop that backend above I'd have to add another special case
to handle the case where its value is `NULL`. So I'd prefer to keep this
as-is.

> > diff --git a/repository.h b/repository.h
> > index 2a348012e8..8c4437762e 100644
> > --- a/repository.h
> > +++ b/repository.h
> > @@ -694,6 +708,7 @@ static enum extension_result handle_extension(const char *var,
> >  		data->submodule_path_cfg = git_config_bool(var, value);
> >  		return EXTENSION_OK;
> >  	}
> > +
> 
> Nit: stray newline addition

I was confused at first because you snipped to the wrong diff header --
this is in "setup.c", not in "repository.h". Fixed now.

Patrick
