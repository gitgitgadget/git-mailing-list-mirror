Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701631;
	b=GJE9jXZ0EAovT4HUNgTqMYXUJ2p2dtwjo/TzrrIvmHzyN4LHurF9/5py1KexcdRwvf0i
	 5FAaC7x0xM71M4+UeOr+Dyd+XonIwaOjT6528GSx11jZUjqpQhYuEiHlS/T4iGfrcD/B2
	 I1PCvIzko4jzl5MkkFKn0E7ZU8A8DGKxlyky/bol0c0bL/w/gEYvvMqS+MfxL+84f8m7d
	 rW725TgjJOuRR/uvJAYPw83xOk/YbGm89xDkI6mfDzken5IWYS70T+kNDh2tH6hkTC7QV
	 paSt7AzCdMLc3jaVMWnOLR4xO3vjwDcNLsqZuX8f+bqQONvON3I+gCzr6qlErMhuK4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701631;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ERSIu5KfuhxtX18SND87GTIqy7b9M2dtCAMcWbhS/fQ=;
	b=NLVB5miRhDmwpuecnEpi2GCWHL7Ep3E/erwO2D4cgVWTVvdTIFpwNlIxQ35PgUdcDL0M
	 ChXrVW3T3HmcUMXnyyO3X6xz2t0zeqmunnwRIsrGcQA8yVMIsJf1449izrUtrWYAoBi/M
	 MMMIxru71pIdt9LahLt08E2WEV/prJj9nnAzhGIMAmwaAmIEZiv+obYYq9uLHYfESc48p
	 Ov+QvGauT/Dy52WU0T9wRXF61DOdgGpPskrjHySmTuS+vGD8rXmUHIWm7HDpUEIHo56rB
	 AT68UTfS+jT8/njKBH5D5jzdULnsp+3T5RNLlKJyRQ3OoH0FCNvymkoh7uJlMuEpqHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="cVQXH/Yr";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZphOYIfN;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E160736C6
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C51E160736C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=cVQXH/Yr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZphOYIfN
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 376487A015E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:27:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 03 Nov 2026 05:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793701629; x=1793788029; bh=ERSIu5Kfuh
	xtX18SND87GTIqy7b9M2dtCAMcWbhS/fQ=; b=cVQXH/YrZYHK3xAdTVleVh890m
	fMyI2GCTZB8APlTCM8LAufBnGO3YTV88NxKtY4WZyW4shO4YoibCobk+Dq3fSjFn
	xP0+cL1aeKRK9uGYruDorZu3Gq9NnKTefP2/66ES1Ps1Ilx9iB3NQRWhh3TsHS6j
	q9CwLqyRBpaSiWFuwQwG0ItK32P80lcf33YlOGq4W4TWVjJSx18kyD9tfwMLgkgs
	xA5T8nVUJUX7UJt0fgoTZUSLG8ltNwE1OQTRVeRYlQ8DuShK8ToxF3N2IOXy408F
	+oa5eNBN6NIdnrPStKgiGj5SUSpJJ3DtVTws0E8I6ivM3ujRu1KVI9+z1/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793701629; x=1793788029; bh=ERSIu5KfuhxtX18SND87GTIqy7b9M2dtCAM
	cWbhS/fQ=; b=ZphOYIfN4/SXj3LySA4p3SirYHqUf3OGoGR0ZqV6ZLfCkbrPwK6
	1VnMKLL/LRBBKieHv69+Hlo3otPOKerEpw9U99GeuDsumONgKNRH5X7doPllZqu3
	kYb9t0pZNsxKYyf1QwnAc9XWZjUkTqAA4LHDQnalS3dyyNkP5wPTCI6mtZjumD+Z
	8hBkderUPwMjXTjWFMkmb8EIngvsIh4tzXrzy7diSKL7FSJZSCIlLLJswvwttouq
	4yYAC1WPj1eEQxiVNc9GPo5vKnVgiXWV4Vhm/crm9rJKgAx/Me1F48lqFUK7SgqO
	L7UcmRioxzvsV0c0XO/WV1yWeE6QsFD1iXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793701629; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CG3dpB3Lrzg8HzsVQ+h9EWYiAkFdlb3hNUiLiCHwAvvdLjY
	oB06JaHEbw8k4b6asQJ66GeUsb5yLF9xenzPQrbK8y+UKqx1VteDKICihC7SXqai
	x68HNsYbH5WO6V9mkQutFO9qHKXTbu4J+rheDcW/38lbgPaezL2nu4aZoLrxTr2w
	vEaODBhFCfRg4R0dlS2bsx1ZdAnOevZuCWDWaShBTsLKdzCjlss/mGaXUX9YApqC
	ACtP2lcRDb+PBaHn9O4Fc7FUHdiLKEbFQys8B/bkNDGM/+STxvEZUAin9rVSSkdg
	GYbmY4xG0nuUqPqUZpBOV1pgRtTmSUDToL2WR0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:unIWI+FfrMSHKWSIIvoO2iZNz/8e34XUxgG6nQ97MeU=:ETvyPbtwvW7RKoqUpJrvwEnVN8OjnPaIwNrc//1sdXc=;
X-ME-Sender: <xms:_bbpakC55jNl7k5umz2bTDnvJjPBTboDRa-UVvktabg14yANA--dkA>
    <xme:_bbpaoxkeqml5ke7q24-4R5EcnyaqPbHIgin9jLdT8mlbjtgh-IrdpWnyF5dcWHA2
    rvGSMT40BeN7PK5oHfnSH1L3axVEP4nag3DHaz9KVC_y28kMOeb4Dg>
X-ME-Received: <xmr:_bbpap1zxiNpGGZKHW1nHwZ6aW3qRmC-u6wmlo3v9Cww8T46e3F7EA>
X-ME-Proxy-Cause: dmFkZTE16ldJBBbpPtJaH6QFwguifPKJV2z5jFDw4BCqRE2Fj8YEPTSP3V3XXuKR5nWpmv
    A1FBRbnRHiealV7n18T+IN9z3D9Lrzk2GolKBnXiDS4csJ2VwDc0i1y02lZfihbv2Tzjht
    qVFITBEmIJ/D9pw4vBW7qhjtEk5XO1EhewaIBb+/hOHmIkFJ/vhEQBmrKMvzmJ+5Oy+Suf
    4zPcY4KdRQgAnNmly6zxhKDDAG7CkEloGw6w6Gw69xQq5O+fX66AzLi4RghXjPpwuiTl0O
    lP2czi3WH2Hn1+LsgxLkVRGgTUPR/8dgC10BWCyQBCrQcoxrktlhgEPGn6+mDTsfGhKlXY
    8UdCU6kJK37pyvJmdeYwtTaS9i4cmbJHKoKtfVvMeJ5QMIm/23URLCXcNVHj0aq1PfGWW3
    i6+sB0T1OthPuejpCvn1NAp4Xgsi5A2xX1rrjq9gLki6O+LRszItExTMGv+Js/VqhcRWYv
    vATes1/Mhz6iER/ll93NPIK1vHtjfZNL831FJ+xqeOTN83gyYvT8/esRwqhBWdCEEUoR0m
    j8gpnYc7Q7Or/+ZjRKmuiu4H81Nro/zHHo5XN5ZcyRfLj2APzbXM5DZVKDc7ZpOyG1ammn
    WnJtN4gQepItN08YvcUgzexGymUsFLNEN0c8eTXY/e8vjK4o5vXozJxfTKyw
X-ME-Proxy: <xmx:_bbpagy2ydC9bA2mQgEJjGhQ-EGxG4yNFVxeirvq74NlaS8LMsfghw>
    <xmx:_bbpaoEfNqIXw53rgRi5IH_G7Kx6jpAdJ6RARP8UsYRWFxhoZ4PKng>
    <xmx:_bbparavkuxIG4uM5XV2WMOuDGvNOgioKhCrlQIDzMqI-oQMyAJqlw>
    <xmx:_bbpaiCw9MdIwa8f_-4jlxCIeH1pamcyNbiqIAAH1EamU1O62XY6Ug>
    <xmx:_bbpavR-TPbl8TzLNBMePjifpzLHfMcPCFa-lqhJOSqSDF0VlNY8VZbu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:27:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d955fd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:27:07 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:27:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2 0/2] notes-utils: stop using the_repository
Message-ID: <aum29zvhcsj41yHz@pks.im>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
 <20261103084930.15532-1-okhuomonajayi54@gmail.com>
 <CAOLa=ZTAEVcKj-Y5QCGsAFAMUSh665E1fmQrEnuuufTLLbn3Wg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTAEVcKj-Y5QCGsAFAMUSh665E1fmQrEnuuufTLLbn3Wg@mail.gmail.com>

On Tue, Nov 03, 2026 at 03:48:01AM -0600, Karthik Nayak wrote:
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
> 
> > This series removes the_repository from notes-utils.c.
> >
> > Changes since v1:
> > - Add patch 2, which passes a repository to
> >   init_copy_notes_for_rewrite() and drops USE_THE_REPOSITORY_VARIABLE
> >   from notes-utils.c, as Patrick suggested. v1 stopped one step short
> >   of that.
> >
> > The callers in builtin/am.c and builtin/notes.c pass the_repository,
> > as those files still use it everywhere. copy() in builtin/notes.c
> > does receive a repo that could be passed down instead, if that is
> > preferred.
> >
> > Thanks, Patrick, for the review.
> >
> 
> Overall the patches look good to me.

Agreed, the patches look good to me, too.

Patrick
