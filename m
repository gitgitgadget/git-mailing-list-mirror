Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816996;
	b=xfsg6B/9mfBBS5GY4hWd8rLBTwBfvSQKvMFHIwpbiHnMZ2dfrtwMjRcQfkLlLnnJ0k2a
	 PNYNB6L8sskPjWOWfdbdkCQYuHyFm3SWZwTiMxSCtQsjnVi2fkRAYjd1AFPB9EPBj6Knr
	 amCvJ9K2cqnSDn3J4r79v4h4HNxj/I+uJsqON1NEtJBzS/irOxNxDDTm1NOUHH6vv5Op/
	 79uTDBd01W7Vl5Q8Iw90ZWrWLFRtVjfd/9bg9HN3QrILILSEmqVv3W8PqtR4jDdxmz3EZ
	 Q8sf5c/tX9dyZ8w5MZ3qc4M454GAf0DF5LQCZNm0THYpg/EVvWBxCEtdtiqt4HI1v0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816996;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZQ9koZW3Pug3/spACbLDASoS/db6YF1Lyra9jew81fU=;
	b=FsWPtp2mF91xc2dbENHSuTyRtZasAZ8SrL0xP/BugnbK2mWyEKQm1nZL7raq9UpsSNee
	 cK0ag7coLGWQlEK2+tlp9JdI9cgnKV80vN8cnUuf+H2yYfJFzbo32c1wOuFr1PwsM8e/+
	 zV9aEOijl5+U1zqgpozWZruwsCYFeIAY9Mn3tH3rF04+soSPKgmFJqEX3+Y+X7b4ycbc6
	 YNZr6iANj+JReaUR2BZx7Ngg7eNw/B3OqaDHTv4fJNBvRTwN0MHiMywOoNnoXPg6R1VCs
	 kU4HgNBd6a38/GSH2++swCrMezwph8j4BdGhJBz2WzgDNp/QqUKeWOlejbTSjHU+d2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NKDCmDBW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B7nLAjtc;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F7606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NKDCmDBW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B7nLAjtc
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EE751D000DE
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:16:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 03:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794816994; x=1794903394; bh=ZQ9koZW3Pu
	g3/spACbLDASoS/db6YF1Lyra9jew81fU=; b=NKDCmDBW5HOjacYa1YbZP5OBI4
	oiI3QBYEZQEtyRQLYSu6cPsNBcGVf92idc4Nxsv5aGtbdxX/a8XzmGHjRaAyL7x9
	IRnNdog5koccqhj4iUj1so3TEyhs+/8ftV5Xs7Qe24g1ri5tQgcTjz1Pv/QrMXxu
	BtkSQPIgaWwF/8yUAgCDT1SFoasPW2L76kLt1IN0XxIckjEJmi7gtxVZe1mev/cx
	QKLXR/Hwgt6CwVMeZAc+992Szj6vAVZ0yMYucOlCg1OoUfpnqyHf6xlQkVpVCo6U
	LuUdHxeinX8pG0lKzxXhrr5zhU/X1MkMSmEL1T90seiC7ZHr49PRPW0tTgYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794816994; x=1794903394; bh=ZQ9koZW3Pug3/spACbLDASoS/db6YF1Lyra
	9jew81fU=; b=B7nLAjtc40R99AUTK0TujVvuyn+W8ewDUNeC123xZ+he/8mlXrL
	BGyLb6EN9rj40L3DTDhPsAeCf2hy3xcQITrdBmPio4H04owNpL+NjItrgyFPCKKB
	mRzD3cScMYtxkhzjuQ0uU/ECAISGCyezpIZEXE/VnpXGEkFP+l8zrIou2ZCRlQdm
	GA6D+l3LK2HkK2+KoeJmN6RVemU2CG9+VMek1y8GYxMtKqzadKvl8INQpemQLAS0
	gsQSQV3/j87gQQttm/iCit8DFdH5Fv0iwILd6P1DmPuWEkvwSz/QCDmAjrpr6VvV
	bFhVMSo48bR6RCOcizrRD+1nO04735dF4ug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794816994; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:lIBAKitlQwxv45gTeD/rG2JSS9jiXYDNJ5nd+88Cbhuknxq
	6FasxIY8jjM7g+WhhAEzr8tmkA8FM9x4TGkZO2irSGdYnn+85LHrhcVC+1F4meo2
	ghWAzcK8r8X/+Qr78JAP3JfhEc6+e+WAUi1CjHI6TKfXbma77O+m0w8utvBroCJC
	K+Xcl2MTXd4nI1NrLlNTI9kefDjnWXqLojjAN2YmZN+sQudFMtiRLqfcjw+2c5or
	ZXlpUUeTm1WfGMjcOr6YKYxtZ1TmcFLC+lERGmzeY6dl9gfla99kDySqXjXSYE97
	5Vv3J1RGKE0Os9+tTrUAl1cGmm3uieDtSm3zGDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rxj9Ameu+/y/lgIaW05HWbZ1jq7psv0+fEEJDH24MqM=:XixN4XY1Qp04NSEL7Tkr3N9sXFyq27W0/7JnccE1ksI=;
X-ME-Sender: <xms:4rv6av7SA1rQd0n6plAdCPP7e_rIgvG-OJl0PBUwLrgGroc2F9MdaA>
    <xme:4rv6ar7Kh-zHuUFGOe-qm7RraKFqSDg5mV_5ShSObOsypm8fmmoIQ1RkZ1cctO26z
    wGfIdBEEeVQ7_3ao9iFk5D5Gw0dF4QRa3A7B-4TKn0Hp6ABxrBrXYux>
X-ME-Received: <xmr:4rv6arcUCs8WbPSpvBL-yjG0UzPW34jdJ-Aa5kPkMwTs4Clu5ttXJ9-C0PLpPuYDJZ9Jzig>
X-ME-Proxy-Cause: dmFkZTFfuLKjszTK3K0LMuRYvNXPqdNSePB+aZZcyrHCCPPtNYrZRTkxtvRr1tDArBiibk
    POKtP5qw2wO3rbMjXZjaduKm4WSOE6t/7LZkvfok53SaT/S+CyL1+Caqf4SoxPWrpky8u7
    VEiP0jMFrn0AHMP5KdGocUGVtEmyIdAKvv63IA6Tx9WHicaeSe8uC+MhfrtFtyZ/aIgaNM
    uBuujQbIJv/or/ZAdSRaNLL+O4jzv/dthFVACRGJuMH7hy8QEfSn2jlMCfgYtFRQ66abEU
    kdRxxg4c1xUOmC8dLrtsFBMJ/oJeEAtqD+nV9DR4snrgzeoN8VjetuAz8wVOpFzWuaGPKL
    WI5GxfPKVGgbWGwXfazRjDZZoDisKDfcNUDfhujRtko0G9z2nzAPGHjHcrSpHT2JKfXpmO
    +I6UAtlLSN13G27+1vpSa73AvqQqtCa6a4KmEnd6xEJ4cOaav4VqVPDgO4b4RicgnfzL+5
    eJ+oYB5eQaT/gDIcH5G5Y/EKuMhKJ+vn1vm8n9mXb0thumiOJNCaPm2AJtzS3m1DeLOFM+
    WPj9G4LgE2TwL1Ag+qlF1S4sqAFn9pYZVD8jSLUUTnSQV4JPyUFi2/ynvXtKMlQiNJN/JB
    CXs1l+4gHfnPXTodJTayZ6Rvj8Kg70M4rt1N3X01LyMHXwAdxhLnA4KYj5Tg
X-ME-Proxy: <xmx:4rv6avBJu9myiU8gzvsgFcpYkirTKLkol_N_KAixlFPdcPMvYBF54A>
    <xmx:4rv6au9Qre8OacHEYBbsg3Yem9cXvo7vIrh_xS4eEm9zlIuKoMQnpA>
    <xmx:4rv6aqJ9bPA5_Ejf7fT8Bhed1xdIy0m7ffpv4O-JL-0xm9dSEokZ7Q>
    <xmx:4rv6angdVKyCJRxgEp26GKmSlQ43k3inRNb2VAh0zStFvmLh-J6n7A>
    <xmx:4rv6atYzk5rYwDsdh_EEBLab4ivAiYRPe71Qa3MxWKSVuc7CrF5rdzQx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 03:16:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 658ff273 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 08:16:32 +0000 (UTC)
Date: Mon, 16 Nov 2026 09:16:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
Message-ID: <avq726hUdY38fJS-@pks.im>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
 <20261105194314.GB2898829@coredump.intra.peff.net>
 <au23Hvzp09yrym9s@pks.im>
 <xmqq5wyalzi2.fsf@gitster.g>
 <avHOTt_PEJUKq9Dy@pks.im>
 <20261109185003.GA1322417@coredump.intra.peff.net>
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
In-Reply-To: <20261109185003.GA1322417@coredump.intra.peff.net>

On Mon, Nov 09, 2026 at 01:50:03PM -0500, Jeff King wrote:
> On Mon, Nov 09, 2026 at 02:44:46PM +0100, Patrick Steinhardt wrote:
> 
> > >  	/*
> > >  	 * This is meant for bulk prefetching of missing blobs in a partial
> > >  	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
> > > +	 *
> > > +	 * NEEDSWORK: rethink if QUICK is desired in this context.
> > > +	 * cf. <au23Hvzp09yrym9s@pks.im>
> > >  	 */
> > >  	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
> > >  };
> > 
> > Yeah, that'd probably be sensible. But I wonder whether that comment
> > should rather be applied to `OBJECT_INFO_QUICK` itself, as I think it's
> > way too much of a foot gun and I'm not sure whether it's ever really
> > sensible to use. But I'm fine with either variant.
> 
> If you are going to get rid of QUICK (which is only implied here, but
> which you said more explicitly up-thread), I think you would need to
> check all of the users to see whether original performance problems it
> was addressing still exist.

Oh, definitely, I wasn't proposing to rip this out without having a
deeper look :)

> For instance, 5827a03545 (fetch: use "quick" has_sha1_file for tag
> following, 2016-10-13) reports a 99% speedup. We have made the pack
> re-scan much faster over the last decade or so, so the results now might
> not be so dramatic.
> 
> We should be able to check at least that spot easily. The original
> results were reported on p5550, so here's what I get after un-quicking
> it (patch is below for reference):
> 
>   Test            HEAD^             HEAD
>   ----------------------------------------------------------
>   5550.4: fetch   0.10(0.07+0.03)   1.42(0.98+0.44) +1320.0%
> 
> Not quite as dramatic as the original, but it still makes quite a
> measurable difference. I will note that p5550 is intentionally
> pathological, though, so real world performance might not be as extreme.

Yeah, it's certainly an indicator though that we cannot just drop this
as-is.

But next to the performance question, I think the more interesting one
is whether this particular instance actually performs correct in all
cases with conncurrent repository maintenance and with promisor remotes.
Because if the answer is "no" then that makes the performance win rather
moot.

Anyway, I don't plan to have a deeper look at this for now, but it might
be something to revisit in the not-too-distant future.

Patrick
