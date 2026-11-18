Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003542;
	b=JL+ULTsTuUQh5ENlfD7qCfsty9UvlkUCK3U3WV2CtD4sQ0dpfKgQpiCA4zQLUc3JC0Uz
	 3P0dmB5Y/2XMS/s2rrV9JPc5OV75P5hnA6K0mJBHWzxxnga2iphP4CdbFC+3cyrjjGh/w
	 xbejtimGmQcNby3ogRHHbZ1Y70OyN1TB7683Gu0r7h9GC9hr/QL/6rcAecMchzjVfsd3P
	 Bxg3NiHSoqZgD/aRHHVSAp0X/4ZOSEqVYJR7XkwQ3vg/rnktze+3cDbvlzFxvxFrSPozx
	 K8Wspm3cpTi12K/P2mavQJGlTbq1dHST9dMq51qMDV0PlW+m09B0OBUw3eyyJddC2kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003542;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aEgZsXfts+TLOZasYNusPdNzUiN8M049TzzQftA61Os=;
	b=YRnWekj82f6mZU3B76noSiSAGXqAZTOEF3tyecXi7wIznMOVZcTN7Gk5VtPSgMuFDR5o
	 REH3A9YWUqf4BBPf63zVqs91xCzt6w7xIsjsllVHoxA94q+O8i9sNL3IrbnfSe3/dF1/9
	 SjOKQoOwvxjB8OVwdKHyGeBUZm+uUqaIJXZ+uk5fYFkAKc4khrdrxLTE7HKuR9A6gCA7K
	 pTLcnOvECyljSGOTQ2PG0i97Stn5qAWusZH4bgjWc4hgSnu8RXmlrS0sM8+weZY/5Wp3A
	 yBPCyimH/m4YcM77Q6cUEFS8UzNWBIE7gMcZoCVD3GHj5lVgCL07RfnUgxUfOHx2MAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=lra3mZU1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SDvJEaOz;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B8606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 763B8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=lra3mZU1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SDvJEaOz
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FB651400026
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:05:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 18 Nov 2026 07:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003540; x=1795089940; bh=aEgZsXfts+
	TLOZasYNusPdNzUiN8M049TzzQftA61Os=; b=lra3mZU1/9I3+dlGF7CrdHsf+g
	X4JyzvVZ9Pqw6ENWBnKELaKolhJvoN/xnW3Bo432qNl5aj6mfX4g+mTq23YDOHEn
	K1aIBIndsAKiFtWtV7LjCn/OFDOANXJ7Iw8YUm0y9zm3v38M7BW1eULRoAivLk0I
	uygha10Qfw0xhXKkJ0VDdvvjk3tsoQPYP+n3GsqR2bP7JfOx2yuRuBT0NQDoUbQS
	yUbqq6tuYUFhO1m32kBeZZ2xEzQ9dcGoB0Q6HP1iq4/YFBy+DV8CNLqsWqNfZbgg
	BJfuH9V44sw3RkbpJq+WuPGg7lMG+svqObpM5wQKTHyIYfZHCGsmAUT13vwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003540; x=1795089940; bh=aEgZsXfts+TLOZasYNusPdNzUiN8M049Tzz
	QftA61Os=; b=SDvJEaOzF5vkEEr50RAERhxohFgiJY0JO6TUBTccn8S9aSfP3q3
	X2psBPkuXZWwC18ithoSOp31suQpEmzz0Kjv4S1PWToKo5NE8UUtj5I35ybWCkuD
	R0mlLm3bm5thzHyU7FeUt0iWpCe43bZYH+u9C+AkySPqwu0kSzqmviOey1JghNq4
	yRbJ/vmjeDr0vosVwtCxvi7nHFLsWxfHBMyMoChAnFr87iVZclbU7155fF+bZboR
	eiG2hXPqg9hohFq8aSS2xe0sD7E/llMkOssYCePKbMGi1zlfslCXjv1PAjgP+JDG
	AYgW8Lf8ppL/xbONXQbM0ylImgBN314RQ7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003540; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bbjPQxd/8OdBSoy7zPNnNo7d/Ar0yGlOZwRbCiMhWyBernr
	z3tMvurjkNJKBjkzS4mtFvXYN3QVhEx/tA27bjVScVWXnhooUWkqKTVh7XOkem1I
	BN+KFp1JJL3ghf0g/frxD1ixIuSKOnIw+CSr3EmNitcEwdqr19Ly45QgBb7yg6bE
	/A740HdbxVUoIIBMNU2PIiRouc0Ald6AS2xSvs5vC+fJmHXIL4IvgWJTm5J+LUUC
	zZ9wo02x23QsvmJUmqgxQkXg3xv6fBD+WgYiIXRumrSjLJFqpu4UynHXG1oS5qSd
	1t5EyFBQZHlyPxOmnpBaXZls6UfS53+zqNajoOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4n3wXDRyA+49eWVBq3wJtJFbhOu4P2EDANA5ml2Kys8=:oQevjj0ROI/kYx/M9q9vs9eNF5T/btv8arXVY79sgvE=;
X-ME-Sender: <xms:lJT9ajiaVOjLUmuPgyjUwMi1CDYkQbwmPnNDPYxoyISBuU0x_5tmzw>
    <xme:lJT9amCZx4IfkaggwKeKhNOfdouJvEB-r7oS9BAesknTG3ZwJti7muXAJ1BdquywD
    6psK-GnkSEpKNa1R7eOTXuQT7TQw6_BBxDPZzPEXy2fPHck96Hw9kQ>
X-ME-Received: <xmr:lJT9aguEkdsEpT4JtR-AJDT9156RBYGp0Wj5TCbNZN1vyptxHQcqkQ>
X-ME-Proxy-Cause: dmFkZTFCM5iiH4Kmok8iNlF4BVdAXtMGfHbl+RQzLAFX8ZpxyOOhDVMQb16C5gYhyfZAFY
    hJBRws2VpxcLnMt1ouCejXDt6H+xO0pcffkClEyHNeV9JTP3EHOD2RvhWfBJAM7Ldqz+tT
    slU3UNyBi+BMoTNiBZSFmH3OjFq7+SyvR/MLqATUU56N0alC0OrfOdf3cjtOLisRqRfSDn
    EfcxAysOPB5Z6vO67ILif3Dr8840KZEOfn2C+wm/vIrKLrZPRNdItPubQ9o6W9a/FZO5f5
    U+Dch/miwW1bo4iMWvcmrptfy+3wVBsBHjEaFOfEXHEPigS7U+ffz4ygZQ+bdtdzNkfwJi
    gfSKljUiu1nxPii9nR4fErmr/HYgBw99/sxypk4agXjUWSLQju4zzM2bGhYXQvTAAstygY
    wCpljrnk+UhxviYpEaxxoWpfwvSml9gLnlzBKAETqojD6fkYcVzUsbTzP32bmha959UnzK
    n/YYtQ27fnyjdglqI18TMk12Zw6l52e1HvQoT94Az8iCLH02ENY0iUWU2q5+u85cPnfPHJ
    yUnkdOMTG2HHFjwvhuS2eYu/B8ZDq9/LauRfAXd5ULJIk9+CHJoSDHvS4gnxEN0LZngoTI
    3gnZR1+AgRp1asoDDMocjs1FQtOaesfKLAmP9vk0fKLUKhRdMyKUuBBTiDXA
X-ME-Proxy: <xmx:lJT9arZjlaW6-mLtZ_pKgUPlwdV337IFOi_Nq5shlhaHWxwE0Y-pEA>
    <xmx:lJT9ajV2v2EMKShXvXQpeRDvxy7SAcJodGjLT7jKS6hB_iDvAcM18A>
    <xmx:lJT9av7dLC8ZuiDwN4Vt27CI7YDvbj5YYsZ8bqJfzyb0aX15Qt4uPQ>
    <xmx:lJT9auhrSSue7-Lvza9ThXHLZUABQ3grJqxSAUkrTG6PZGxT6yHoDA>
    <xmx:lJT9arR4eHsHMT4lueZ4mSoWjUqbI8vWxlTqWLTdbz8dPK2lFj3McxEk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:05:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79f0c37b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:05:38 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:05:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] refs/reftable: don't write new table on dry-run
 expire
Message-ID: <av2Ui2uOeUoES0-a@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
 <CAOLa=ZSx=m=5+Jw8JzKXutaYp_mKOWbSsBVTHtMT3rDUk3a=eA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZSx=m=5+Jw8JzKXutaYp_mKOWbSsBVTHtMT3rDUk3a=eA@mail.gmail.com>

On Wed, Nov 18, 2026 at 03:28:25AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 3ba6a9ac0db..4216a18684d 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -2706,6 +2706,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
> >  	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
> >  		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
> >
> > +	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
> > +		ret = 0;
> > +		goto done;
> > +	}
> > +
> >  	arg.refs = refs;
> >  	arg.records = rewritten;
> >  	arg.len = logs_nr;
> > @@ -2720,8 +2725,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
> >  	 * Future improvement: we could skip writing records that were
> >  	 * not changed.
> >  	 */
> 
> This comment doesn't seem to get removed in the following patch.

That's because I don't fully consider this comment to be addressed. If I
understand correctly, this also speaks about the fact that we could drop
rewriting entries in a finer-grained way. All I'm changing is that we
now don't write any entries in case none of them need to be rewritten.

Patrick
