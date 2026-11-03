Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704013;
	b=hL/hvZP0yZYO+hoS4zha1Sm+9k9wQ/C/BerGchI0xMcSA5VOHRwOzFypdYFwt0+MyNpi
	 BTtH5aBttsxYTxZOYrKuprL+aGidF6TloHsmYpawn4Sa555CVUtnBFF1BACH0FNOPrC5h
	 4Z6JOPKEHCOo3bGRiXCUBgP/5N63gu1q0va4zWoOfuKfWoKvuddAq9Z0i9VfQjvonLQd2
	 JIRDg8lfpDcBW2hnNwOY/MiUH4eLpKIpETp6K0hVNT8FzIAc5ugBf7wpiSuGDOl8MSSV9
	 g/JZetYqUQs0HukIM+kyutzxTLWEHOGX6KYqHTzOqTk9Y/T9d+WSJsYq80+LCTiizgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704013;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mwnKzjy9aNxlhRWoQJ4ppOtkvsyxmQ04+kvbFp5hcGo=;
	b=somySsSQ+fxLk/d+5qbrHVnWTYGQNp//mJW0u+FuBnVkf99myMp85h1TZBHGSag3zWpk
	 CLrNeBE8bI05SAeFcD1cxeq3xU9bUOmZDi58KiPIEuCacjVVX22buBWrtSQG1c0br/rQo
	 H3d/y19D6x/Bqq3rNk72e5mVQQMxDPkT3zJ+zuJp9rpDS+KZyfq4NLkpLFzg5PDfuAdz1
	 bL3Kzr31ZDUtEL6wmwRINYOYov0UloVyYSZez7gO3LwialqUnCMlfMd1F6v/ZScy+Drmb
	 Jg5wgvrkINtHjLtsj6L6PjsqQPALikqTtegfHeYG/XBZLS2dSWp6QFWGZG37VECHTmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=c4B8BYJ7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wC1Gg6lm;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC17607008E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC17607008E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=c4B8BYJ7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wC1Gg6lm
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44C927A00A3
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:06:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 06:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793704012; x=1793790412; bh=mwnKzjy9aN
	xlhRWoQJ4ppOtkvsyxmQ04+kvbFp5hcGo=; b=c4B8BYJ7YcSu8ZKiWS4i4zgJPD
	SaYHvrmzjaSPLjLxyUmvOd87hSBqynHoElb5fpCO0GXL3ndNaeRlNnovK6nRt+Jh
	pw81a7QbABINePN2qlPna9YrWmaN0kqo/59kcAKDyMUHgFYKq70cQVlXWaCptoIJ
	UtMaDH4jIu2JVoyW5w7/NsEvv79td9pBRaan/RZa0bYT/pWPkP0RZepY17RPgQgg
	MGA5ct4umRyff7jJcl8soHdtYY/nUQ//f3aQVAcNXVZU0X/79vPokiPYLP3PCzR3
	JmhYBDGcKTGkQsbLJNAi/7vYJ4dyAOp4440Zb/fhz4wUOB0J+OkX5zidux/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793704012; x=1793790412; bh=mwnKzjy9aNxlhRWoQJ4ppOtkvsyxmQ04+kv
	bFp5hcGo=; b=wC1Gg6lmq9xyKaseGQRGFbN/Qmu4XlAgIdsIkOed1BZr4L0owq1
	F3JGoZKzpnsao8a9tDTX4i0+DiD+0oUBL3eP7iwwzSwkdpQa6H7IKjrEVBmpQo+k
	n/6Xj/i436hwgJgUAWFc6UFNrE8D/aWMAKCB1nGnXsjJzv+nOoWAKsqcch8fiZSg
	mdGVl25mHusY+fCn7iMaKl29iMLBEkgC0JqutoiPzg+davIit0NNHxNJwUsBnap0
	KKbfQYq3PzXNO/A7Wr9eCNqF6JoiH1s3yDZ9GkG3bkzteQZTbJP73Y43/ET29U5r
	NKIL9BqUNd536A8GGWx8itjp2XzG8gDOqUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793704012; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:G4KXW9gN90i3ZVq0TjopfhDdoszMRsHkx/2Ixz+SeRgv6Ka
	xXcRSlx23FVVIuFhpXdrQwvAmXfO9DKlQM7uGa0sVicnFCsK45nDnov8SkLP3JV5
	IF/s7RDFghhGQYsp4U2VCuj0aIsxy7iBtM3/hpON5FiU39bwV8be5eQuvxCnhbO2
	iY06T+VPeoprDp2civUltN0Qf2F4pI7JVaFheXCFRWtUcEkBBnDAAtQaIM2XAF7T
	pZtklIbPs/inPGbyDy/bbHnMewyfSg1xo4Kyj5NnIAK4cT7MKZVOccPF7eEyq09D
	rL1YJOHT/A+ZGvCXaI5XOBBPk+DzyPnI7PVYiow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QNqjqYHsLZouf5/BVV1sc3C6lPoOyOPySqthwhVXtuE=:U+I6fwhgQnj2fEgfaVtGEEyMKdI9BQzar+CIMCOA1hA=;
X-ME-Sender: <xms:S8Dpava8y__9AEHVDjMNhQgOW_yfldljlfQaRczwKFGqCMLfehsmKg>
    <xme:S8Dpal1wHi7lHvTsEGNHk18xNuXWOiFOAbHFXOmva7Ay5GVckHn1gPUmqDLY-K2w_
    Dr-LG4qA063L7gG07ln6n_XnWGqrTRrK0CHwIrHaRuDW23-BGFoDTg>
X-ME-Received: <xmr:S8DpavVtI2yqNULPb1aP_P3AYkVBoOk5t89YDiyEL2M96U55skgBVw>
X-ME-Proxy-Cause: dmFkZTEtDY8AostULUsBMc2xX3pQFtspHdPmlme8yqEr71koF3yYNXOe9ISy+/Gi7ODyAV
    2eEfLbFkk8FJYJVwH9GPBveBr/O/9IkuoTNl7GhtlCNCE976w0Nu1+Ep3Mpa07YRUuC3DL
    cHPEt1D2vH1lS5bjLLw61ttzLmY4eMtfF6eONGJGdiyj2V8m6lRpqTmQW7cOWr9CEaOJgC
    n8d+LhL3YhMXXEu5L16xjTlu8o2W4n4iOehg4SxQmrYoU+eCqC0BxZh7bVI7jN4nUHSp82
    9xkFswmOBx2zGmAxA6BneSy95SnIOSfYglOyRc5At6PfKskE5DzLHcGcFkOAFyd/oeMQJ9
    uCMczfWXpzu1uPmJzFiTdde0MpGqqJNYjSgRlXD38UyZaGKgPAbgs6rsTKH0PAKo19x2/g
    atD6VB9cU3rOTOhMCeGE2thDnHvVg3ZD3m2e1eOYi63w4oxKuG78ObqQDRHzD7F47iij6o
    5RZx8wmSn+MQU9baTfYD1W4E0K+0iE98N5RW2hp+u00c+knZhdz/cYeeiR4KU0jmN6X/Tg
    CEhMydozhPsZSCtcIS1mQg2glR8LA2qzSzhyKutOUgG2oItRPlHPjG75e8VVpve2ahDO11
    3eutmTKom4kcPfETCuHeLr0XEL8nlwgZYMviVQNW0p21mVm81VfOfTHrPP5w
X-ME-Proxy: <xmx:S8DpavVyhpxJJEnq_LSPJZmRq0V_DffdYVvrn1KlqoGx_OkllzGyAw>
    <xmx:S8DpaueLxEqP2mg4YTNprch3s841T-Lf3HJv0lCIzosX-kH2OFY8rw>
    <xmx:S8DpaoWc5sC1PScOIzNiA7UEoL--7C9Zu7_QBNU9vm35TdPLvuIBTg>
    <xmx:S8DpancsP2Hcia7RpOWgcTN8mCJp22MH1A2JVt2vOIQ9lGWq6okGGw>
    <xmx:TMDpat1QHCjqQoONYD_yCOXr36nq-vL-mf1Oaf66bx2xv8hjRisjYujx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 06:06:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0c383a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 11:06:49 +0000 (UTC)
Date: Tue, 3 Nov 2026 12:06:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Root <rootminus0x1@gmail.com>
Subject: Re: [PATCH 1/3] builtin/grep: read submodule trees via their
 repository
Message-ID: <aunAR67MHppLt--N@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
 <20261030-pks-grep-recurse-submodule-v1-1-d4eb5c87d8fb@pks.im>
 <87fqxnyx3s.fsf@dev.null.iotcl.com.invalid>
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
In-Reply-To: <87fqxnyx3s.fsf@dev.null.iotcl.com.invalid>

On Fri, Oct 30, 2026 at 05:25:11PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `grep_tree()` searches for a specific string recursively in
> > a tree. It can recurse in two different ways:
> >
> >   - It may either see a subtree, in which case it recurses into itself.
> >
> >   - Or it may see a submodule, and in that case it recurses via
> >     `grep_submodule()` which then again calls `grep_tree()`.
> >
> > In the latter case we continue grepping in the submodule repository's
> > object graph. Historically this used to work by linking that submodule's
> > object directory into the main object database. But in 93cd344e34f
> > (builtin/grep: stop registering submodule ODB as source, 2026-09-11) we
> > stopped doing that and instead expect to read submodule objects via the
> > submodule repository.
> >
> > This logic is broken though: while we indeed know to read blobs via the
> > submodule's object database, we didn't adapt trees in the same way. The
> > result is that Git fails to read the object:
> >
> >     $ git grep --recurse-submodules -e hello HEAD
> >     fatal: unable to read tree (935cff11a11f8734cf4e0d40955d1e0e5c12038e)
> >
> > This went unnoticed because our tests only cover submodules that contain
> > files at the top level.
> 
> Should we mention this is a regression in 2.56?

Fair, can do.

> > diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> > index 3d149d34c15..f51c5181805 100755
> > --- a/t/t7814-grep-recurse-submodules.sh
> > +++ b/t/t7814-grep-recurse-submodules.sh
> > @@ -631,4 +631,27 @@ test_expect_success 'check scope of core.useReplaceRefs' '
> >  	git -C base grep --cached --recurse-submodules C
> >  '
> >  
> > +test_expect_success 'grep --recurse-submodules with tree-ish and nested directory' '
> > +	rm -rf sub super &&
> 
> Small nit, shall we use test_when_finished here?

Normally I would, but in this case it would have felt weird to have "rm
-rf sub super && test_when_finished "rm -rf sub super". We have to
delete the old repos because they exist already, so arguably the correct
location to add the `test_when_finished` would have been that preceding
test. But I'd propose that this can be done at a later time?

Patrick
