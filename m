Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FB1C5D59
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340326; cv=none; b=HtWD2+yay19wQ3OanpL/Kh6FBL4OvdpXlBTZrMhqrd5mBlMinDHhKBcVtfXhp+xT2J2k8Qq+HfUpaAMntM1JC/AY3mxowIVsS909IQZhLssXtd3mcJvDjVqV8XYgkSjidw34Ytw7ufoznZv1Tbo6WcPIzK+Pc38kM4Si9ZhU+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340326; c=relaxed/simple;
	bh=7WHdMb0MM2sCBRHYXgPiH3gq7W5IKpJEOIXKDv42AqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtxNMtsODrcaGyPmCx4Mgoy0RFAGxs2Tb4GxTjjghZq6zqBVC16Xe+do8Yl8Uufc7Umg8iOvXC/YcwcqjM1HCSuQ41AFpsjULloi+rb23pdC6fYL+7H0EDAsEzPBB9JLGAGEmokVT0t3DynpF4wcFitgQuR0Gddkh+82Dq6nxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S6cQvT2K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A73EiBgg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S6cQvT2K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A73EiBgg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7EA19EC00A9;
	Mon, 10 Aug 2026 01:38:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 01:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786340324; x=1786426724; bh=CMRTSVn7qF
	Fbr7FvwiE3KeepXrwhPIr/bq0nynWoiUc=; b=S6cQvT2Kp4JPAcZEpBC/LNFDAi
	hnROGDyOdMLUHWt1B+v+TsG2pRP0g3u4fAT6esqPASFdxqazr6xQvmRGfJmh19SE
	jIYAJJ2Qbmi+HK7ZMehmsmyPpXdjFGwi/CSWe0BJkh+oUlXq4VEQ76/aO9JpV7me
	3/iLK768yTZlEiqotWtcOzy6KmUxkr5RU7KrAMArXks/cmJNLT3lpOWYpT3HGFes
	ga9TPGoR4YZSHXlfpak4RQB/hRb8wUMb6rhxUw56OBvc5fqIiJWS80LdPPFAZj1J
	M20BPxkzeDkPCMs2FU0ci0Ceh+zoKMIjAbPlIotmhtayfEprvQ6PBv6lJTYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786340324; x=1786426724; bh=CMRTSVn7qFFbr7FvwiE3KeepXrwhPIr/bq0
	nynWoiUc=; b=A73EiBggexhc8OV+BpSkdO7qlYwBG7mDtdyQvH4jPD52IbH7leK
	4jF2LMncZC1A4sABBq+uPzz+yjRsR0aTqM7TBiD/k04fSu0xlw9Iy9ACblrA1c0Y
	+Xfr/8R671Ov7xRsp9FHv3QEig9SGhg3mrQOWgPYbA3rnVexEzJGgU6Z2cPWON13
	cb+PG4ndBNXJ8DWwG3WJAyLn0/0iAYfpP8XXNbr6h78akBViZ706MD2tlDTn/pyv
	Kalk4H+RUypc0xFuvrhptGVffMxeTPN7nRaEnrW1LxBdaKVAsqsvbqSQELrMWQbp
	b7OvBebIIC2oBNmnMftUNcsLzGFIuypgf0g==
X-ME-Sender: <xms:5GN5ascRgtHkdelq5IC5Qt7GuKdqjc7kKQE8CayexeGZHacf1jIanw>
    <xme:5GN5ah6dP_3k7QQ9KfSnUgbAAKDSTXqM2kUBzUr4FVHLzsS-7SHXh26Pr2Oap1SqI
    OuYLu19GMXE24Ff215L-8Hdxk0OBPH0hnm-AlirYdtOSOovthOfy-o>
X-ME-Received: <xmr:5GN5anU0qh-HbQJxYvAUir4TKHdBtDjvKx1styjkIckgIukobteIAAhdFIUQ4OR4n7QI_dJwVJn4inaFhcsF6AlGg3HVhpR2IZV-MgOREg>
X-ME-Proxy-Cause: dmFkZTG2f6u/9xCRZBrQy6DmUYK8Rd1PqSQjKV8RRLMENNDR10DVHjE4TQAyOqehCn6WdB
    vA9nh1WkDDNTheaV6CKcpX8RvM7Eo2rwlj967HnGBAqvzLo0UCgvcY/bkOWOyORl9Ecdd7
    j/nR+y4VfK/S1tBPDPmjhLLaptH2F1cs45adOkzlzvJ6mPrK5Fe6w2XuoSuYPiOiVDaYQo
    HTRU4bqRYZcoMuRMLzjCl9mfhUdzmpPuo4jXjxc1VHyJdxOyor1dLSLhN8lBnLlI4OORxs
    DPq2pyIksBw6xnODbVbJ+jC8JpJEtIWQ0Z7PgqY81UylGITHqfgFs+AdDiBqs5v6T8EPPu
    CSSE7r885DvbRoE/QCde4KzvuXyBHQt6woUkCN0dzLBifA9OLG/xCu4RyBBmW4BSt2R/N+
    yIzUxpTghGQ4hTLtw4oWGeLPhyAU+JOTzvLMLk5XyKd9E2q13cua94vtC0XoeOLDzvshTU
    xt5Qw9bONFrA8Yx0/k8diCTxv4wOJAbvJxKfm1MeYRqrKF+H4U5I3pZmrE22DksAZ+lbFM
    5cbJAx+7c3RRgC8qIV5dhIBjX0g1irKeQjR2flMDVrL84l8pEMSKazzTtjPTahrKYWFrBI
    iBM7c38bap/r7LW1FY+R85YsUFInuekrcsQRgN/W4jYxQsKXxM/nMaCzmk/Q
X-ME-Proxy: <xmx:5GN5ao7jYhyvJXH_tb7_20sgR_zMOYxPXYvu7eAcV3T_3g1DYVyunA>
    <xmx:5GN5aqpG6j8c2eZMdp6_1Qs15RspUGH-86aos5N-2-lR75ADyaWMqQ>
    <xmx:5GN5ajnxJNKbBDDnxyCpVfZNzTJsROpOTqkrX-OLI4fYYKOKPL68cg>
    <xmx:5GN5auNhCIdBl_U52ehw7htQh45csSQQoa4i5W66MUJhekvIHKVXjA>
    <xmx:5GN5arW-an2Xc9VdMrnQu_E2nMWZrke5U-e8KZd9D0CDf0QDaFmEwtfr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 01:38:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16b6b932 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 05:38:41 +0000 (UTC)
Date: Mon, 10 Aug 2026 07:38:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, tnyman@openai.com,
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <anlj3kdAfOh8OnNR@pks.im>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
 <20260726083905.GB3529069@coredump.intra.peff.net>
 <anWyV9Q4Cmsa5AoT@pks.im>
 <xmqq8q6hgb2m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q6hgb2m.fsf@gitster.g>

On Fri, Aug 07, 2026 at 09:16:49AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > They'd of course require a bit of a deeper look, but that could be
> > another way to speed up Coccinelle for us. Even though I cannot say for
> > sure by how much, I didn't give it a test.
> 
> Another benefit is that it would reduce the programmer's burden, as
> it is not immediately apparent which rules are still relevant.
> 
> I wonder if we can easily define the exit criteria when we introduce
> a new rule and document them, immediately next to the rules.
> 
> You said "refs, object_id, the_repository, ... all look like we have
> long done with the migrations"; in retrospect, would it have been
> easily doable for those who introduced these rules to describe how
> we would declare "now migration is done"?  If so, perhaps a good
> step forward may be to update tools/coccinelle/README to add such a
> rule.
> 
>     ... goes and looks ...
> 
> The readme file clearly states that transformations needed for
> migrations are *not* regularly run.  Is it possible that we have
> these rules you mentioned misclassified?

For all I can see, both our Makefile and Meson simply take all
Coccinelle files we have, concatenate and run those rules against our
whole codebase. So I don't see any kind of classification at all?

Ah, no, you're right. We have the ".pending" suffix that we do treat
special. We only have a single one of those with "config_fn_ctx".
Arguably, many of the others should've been classified as pending, too.
But I think it's quite easy to miss that we even treat these kinds of
files special.

Taking a step back, I do have to wonder whether the Cocci files have
been adding any kind of value in the first place. I myself introduced
some of them in contexts where I made sweeping changes to our APIs, so
that any in-flight topics can be trivially adjusted via Coccinelle. But
I very much doubt that anyone ever used those to adapt their in-flight
patch series at all.

So maybe we should just not do that anymore?

Patrick
