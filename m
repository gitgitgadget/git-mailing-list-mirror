Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188258;
	b=SqAH9qVSxLCMezsMf+BPgy4p4fH+MFnYJ0RjcxUFH601sacV1fw5caegzv+jwqW241f8
	 b5QH0GNg6Dvj991ihgE4ww9W4Rd2iqeELVgl2ctdaldKEELKJsu4n1PeQunTId/cD/1on
	 TBqSpbvWJ6f/tvkSC8UQM5Pl3WTvPbb/IIENTduBow7jaM/yCzCdridKNSJT8UYRl+0KW
	 QCSFMAirAtDR4TSYZNACCPw3+Xqr2bV1msGUvIBaSJS5EU55opBKgGTZII7pCUK+5AQGc
	 MsNSNjpLuj2pDqzZjekMvURZ1MX5ElcU9MPnw24yE+iKeStEdEMVn7k2TRX1NJIOKIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188258;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2wVIthEHPHHZeW3KGvk6Rwa8YXYYdp5ZFWUDz/i+zi0=;
	b=wuRI9rzqCaiEttBQMcFcXXkN26hCiFmYKfknCu5h8vq851cuKJoSprhOBNxwWUsv/kDB
	 erVaE3+jxF3deVSwnTcwyMk6753pwCPOx39yWoHh8i92ct88tlZfBA7joyHKRIuvrWpe1
	 bIFNoSv1my0Z9cghzh0idnMUEvvjBsI7bwq71EbTH6QddamZlIc+Qsed7Ev4cZVIjwHhb
	 vUo0nxFskkJ6OXkAxXouYL6ZmRdhBoHHhh7dGeHfseC0oEZUUkayetnnIWPRYikuxcnPw
	 7Xk51UVy6Xtj/CiugGZHWSpSwpP6RpKWQbh9x9LOBd9yqI2C7pcRini8bxhlWJXe1ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aQwlEcuM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ynigYb6I;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDD606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92EDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aQwlEcuM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ynigYb6I
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E84CB1D00073
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:50:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793188256; x=1793274656; bh=2wVIthEHPH
	HZeW3KGvk6Rwa8YXYYdp5ZFWUDz/i+zi0=; b=aQwlEcuMzD3ZzL43j3AOySg+FR
	iNJl7UWVCghkU7LdYHmkSOPO8NAo2NYlQz8dMoTmSw2d/w/MBf8hL1IabbZ2tnX+
	NNfoixFXMUX31sxxkuvPQbdf89QctFKzynQUfTXlutEWjSrLBLHFa1qtbGEVum4L
	02rhlgf+7+gm5Dv5Hk9VOgYCJ/rp6bL5p5jEloFDXKRp4AodzUUjuejPRZ4TKYaq
	p5komiKjjJEkJu/UmM9PoCfjT9B9rrwsTXEqwLexl/NtQIMpGdwZDaeeTNTB7mwe
	swUo6i6Sp+dZfARrGm1j2f19uMx+yV9ljJkS6eqJ/cQ/PbEaI6uxA/wcXyvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793188256; x=1793274656; bh=2wVIthEHPHHZeW3KGvk6Rwa8YXYYdp5ZFWU
	Dz/i+zi0=; b=ynigYb6IiOEUZJP9eBoSXxeo3f1H645JpZh3SLzPfne6vgbzSSz
	JogQmMAnR08VEqh54lbwHZzh88aZlQccDeq/JJKzmmbQI10TU3ryhC4UQKLMSwXY
	e6E2dJ+WqLUnTFXXJEtCW20Nv0xDFkq7TlP8nY8JPFbbMxXOp8BxjGTfw3SJ8Eph
	QxoW8Je090IvK2iL3ayP6KFlJb5+uiPqdoMtwb8+4AumPhdFGyh09Oa0nd0FV/mc
	m/Upp8UOX4020B9kRXnO8dsYQKDTL6qwjLJKPMNDXQZ2HFhigiEjjVeURE+N/bwU
	iM8fH+azTULdqs0ILgce1iHoBBf1pHFPC/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188256; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FOXu9ZhYJGuX4k2Yhch2psclQhGUzfueNjRBH4pilt/ThlC
	iik20zM814/LXMFlS+G5eO7QEZXcwkxN/LyhYfx3f7lFjvK+ezJR5rgE0/zlZQkm
	5tFWinxwYP9hOvfAbS85sMCdLWsvwHrB3wfprKLQ9BBXIgLXKaK97EJ2DpWM5tvv
	SlRThdz3Xr6vlrrK/+gdxRk8rnGtI2fSWtuLltSANJ5pRboIcyCmXBuWXPC9/ehu
	cMY0wiEKOKl0MQ42LeQWkbhCnXXbBdBoPvuQIVGh/I45aUJtmfYtKq0bCSQm0gEY
	YgYHfEc8eFO8YgjZbRyxAFynk2Pa0T/6JEJpPWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9/NkmPlWA5QeBNXPvfvIt4dlNfqhGCXN+9oDVDxvaAU=:AZJP8npMo/oWOLu898QGt4TSyCbXpjAkBcEInDPAtWc=;
X-ME-Sender: <xms:oOHhavtb3GyaD102MR12lEsQe26KOiUpZ7L6z9vaShwroZIo8jN47w>
    <xme:oOHhan6jrHscRYYN-VAh6Y-ekG-uqVqNQf8JROzfBw4cV90ea8EMttoIX7chRdHmE
    JihH1I1b9wuXqYMbjDyg3qoVZ6Ycbso8EdlpCkQq3OkldrJf1vLfg>
X-ME-Received: <xmr:oOHhagLZCvSsjbaSWO9fNrOXqEiwxVZ2wkeinuXYxW79iz67n3YSiQ>
X-ME-Proxy-Cause: dmFkZTFTX5RhpsHLa2/RMXqHNgOWLYg7z1jgxvd3ZY0B81Utv1B4qwHJhNCwX3O8HGa5Pu
    cuNHufUtx7koN2tz7t/nvw6GFzhqQCwF9ZZjTHoGV02fT9lw2iUcG2qE+hFV8CeOQOcCdr
    2EUfir/PWrALscACiyatWrdQ9I5UY7yerhqGd1addJ5aLr8irfymLZSjRzHk114ApgRTiL
    vruvD2HLJZvmD5X+kvT5dxMOHLftPmenscO+g+fr3fyYVeT6t/X42gAdjrMbgg2WN9cFEH
    JvS2K+jYBZtj1rxGkDwPvE0g58nWmM4v8BtTo0uJUFeljqbPD1awJZTkdqXRwLZamQoiHn
    N4qAPzkxSigj4I1FGU+cuEIaXUKm2vu2CDP/NaQn+ia3AD7QL04pYX69sQntlYCZ/RE3RT
    IK5NWwdOm+++rZFr6dJ9AX1X7tTNfxd4j6/g9q9HMPxl3akmIrOgfd8jYReJDGpoehlFdx
    fB6NAn4DttJbafRIaKrWoByHOxiIe8UueWywtSBzAJOvIlL3ssgyoQ4Ya9nQrX4aLTzeyZ
    xUvlQWCTh2EqMvWwrMKk7RgSdBfQu1NQx2rd0btY//dB6aH1+5hiSBlsWUdG2XQCcP71W9
    5LDf2V6jyWUynzfc0OoHGcJwUyzeZTuzzA2VSjapc3LDJ2Q11aGOJkmI8Pcg
X-ME-Proxy: <xmx:oOHhan61OFoYQBCVumyMya2celBIw4pD-G8RSX_50Vm3ZUh9loEVOA>
    <xmx:oOHhajz2vVuNIfuwBpJC81H2ugW_U03Woje1AnWB7bzrKCMfCOjSvA>
    <xmx:oOHharZA_cx4Vm26rd2weZaUIQEod-RKGcD7pTzEi_FLrv9IC59x7g>
    <xmx:oOHhalQbk7k3nyz47Hc_Ywly2Oibi3eJRZ2BjnnBdvidSJsEQnTZlA>
    <xmx:oOHhaj5XfNgDFbtFkxfjVdlxGSND9E4SW8SPacPJrDaRCcj1Vp4bM0pf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 07:50:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fab7852 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 11:50:54 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:50:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Daniel Zoghalchali <daniel@latchkey.dev>
Subject: Re: [PATCH] pack-objects: handle missing objects when excluding
 promisor objects
Message-ID: <auHhm1NAL_dRnp1c@pks.im>
References: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
 <xmqq7bj2e0o1.fsf@gitster.g>
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
In-Reply-To: <xmqq7bj2e0o1.fsf@gitster.g>

On Wed, Oct 28, 2026 at 12:37:02AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this patch fixes the issue reported in [1]. Thanks!
> >  builtin/pack-objects.c   |  3 ++-
> >  t/t5616-partial-clone.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index ca3a891dfbc..d6caed16d97 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -5085,7 +5085,8 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
> >  	};
> >  
> >  	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
> > -		BUG("should_include_obj should only be called on existing objects");
> > +		/* Missing; assume it is a promisor object */
> > +		return 0;
> 
> It is not entirely the fault of this patch, but the code relies on
> .fetch_if_missing being set to 0 elsewhere.  While that is not wrong
> per se, shouldn't this call to odb_read_object_info_extended() pass
> the OBJECT_INFO_SKIP_FETCH_OBJECT bit explicitly for clarity?

Yeah. This is fine in practice because we always unset
`fetch_if_missing` with "--exclude-promisor-objects[-best-effort]", but
adding the flag explicitly for clarity feels sensible to me.

Patrick
