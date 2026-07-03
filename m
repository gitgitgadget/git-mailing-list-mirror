Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D03D9558
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074760; cv=none; b=XksuzMwA8kW2ewMGLUDIzb9gj1x9DRTTv/fILSg/euLd3QWKGIRzePnf0vIG4xtpd7KtLgGSaDjXY/ztaRLY4UYPvVzW7YL5+tqXDb4I7MG0h6yXCEr2vNCMrJV42uyqFmf0LTiYLzir224sw6q5Y2pJXz5kRXishpxYCTrHWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074760; c=relaxed/simple;
	bh=vFq2OhytTHEZOj4vm41hi0NInC+87olm5JdDsUVCc40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGS19LXfJgXQztlJgpaS+KN7ZlPKERhH7PUI0WzVCTLE2sbfGq7mWgu7AgV3OpbqOpSzCZhrVw6LDTeZTkzG2sAfwhFxPtqruKSm/xnWv4kVE/nr2CPblcbHziaYMAEjlkr8K30eo5W4UP39zTdgcSIV4qtfyvI7qdB65WdkMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgg30I5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrXCEW9v; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgg30I5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrXCEW9v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C83F37A0051;
	Fri,  3 Jul 2026 06:32:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 06:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783074757; x=1783161157; bh=fmaLJ3Y92C
	Z863QQQQy/urVtZmHL04MTW0q+nLeI4LA=; b=lgg30I5jZx823N/htsmLntMme2
	KmFXjQukR4ee5S8nVPdfc1Z021f5LsKniJGIQeBCMfBGgt4jpsDEJ3E5AeH1MZK3
	xg9aD2nfy9FSNLlTB7iwGqDZyhmsmQhmHHRJ8ZQOAygqsnKHu+XZ/z3lxA/Y0vj9
	oZbQTU9ivn1D9U9mnwUvHWOwqkNTD+KRQiwH6ED//Pcp43pTA9E9xgNStcxtjNjC
	Jau1e8elsl/iOW9cGpxXvvIZGfXjrHjmEqW2B3feGQB7DrwyTLFBYAHHCYF64fOg
	d39Zd6EO7HDkbRhCdB1OuWhQPDB03d1ooungMjt6MkcnnB/QrLDGN6rRxQzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783074757; x=1783161157; bh=fmaLJ3Y92CZ863QQQQy/urVtZmHL04MTW0q
	+nLeI4LA=; b=hrXCEW9v/5gFv0SpuziiadFEh0k3wCkWkGG68Lv1ISmHddH436k
	Ibd2r1EHzHtSQCmdq6NC0WNoUdONO1+Y92BbOTHgQrevtOpTmtOI4UXHKCP+NpUb
	7LzEWcxIiZUlM6tN25QXmXyfABLak9ncr7HZflv/mDc0KHWwlGoGos7Ka4OQ7IGJ
	UDqLuo90MBdZIKy6DP+Bt86oF85050RdoyMfBLQW1TyRMIFgHfdO8ascIM5DqZJB
	BkKafh1Tz9LNQ4ObRbkB8rxX+rj7TfNHm60CmsJs7B7QJ/1YhqdW6Pu6gewBvPz1
	KBnXyNMR4/bWdtagseGbT8oS6P67zrOjlNQ==
X-ME-Sender: <xms:xY9HanuAJBwIsId0Lfo_N0H5Pc7JFkTvpXv5duOYlZ0FFopDBu7qGA>
    <xme:xY9Havf2i0VRlUkbGOWU4p0LqVbwkvsHUnv1TDBEBetsXOd2vlrbM6aOhcVKCIt_L
    iL6wgVBWpbJpJO_nb1iIZgXDdJbCIum60003PccwJ7zCARhXL2z>
X-ME-Received: <xmr:xY9HavweGKjPwGheYqUHPv6eOgmibQzHSDQcVIURcRf_Q0gm6X_tLj0w1FMsblQTX9ih42i5yTGjJDAg7lQI4ivPLZccHNeKY1hiU2aYNw>
X-ME-Proxy-Cause: dmFkZTEhaPcHP/ath3uhFEM0I03jSPWzE5L3fe1dSar9XXnCSvywDhmj3oKLmCL4pTRV0Y
    XjEbbRmh5woZAPN/QZTkTVB/Xcb0CoF2PlvRfMoYKN0joGlqsBGhRPfZKA7bZkMUwFwk6D
    RKR7TwCVn8wJT0kpqEAewqj13u5aKZJb6LW2Lavii211B3s+kBhzXWLbXvJw6qqWAC/+tP
    wqVxCgwNZ2GKhPcC+mtwNvwZjGNA4ZCwCGe5/eIeyfks3k5OK1YPRPEx48QTuHJpsnP3iq
    M8OWIblZokePs+wzeDq7qEJBzE385K81XkIFWgecz+tzeGYHVuokXKHH+BD0yN1gBV5WaX
    1WzxxGu9NHxpeCsVcx4H1cgGc8yG3m5o7sePeGmbEvRHDctW52kqHVtazctfzg3kxkigbu
    gkSryE+jXJW637c9RIfnBzU9i31qJe313d3yMNFzN0AZDUqNIxGCrAs4X5eQC3xXl3NyFw
    SAQSP4M21JxMvxzEXlO/o8QL+TwqlN2JspMSpaJop3ux5ElMjMmr3m0A7qfVa/R3ASy8Ap
    ZpGoB6PYJLsM13lH4R4HKI3WTpuWLI7rhP6HWUolVyRqk8n24q0cVWw+j3B5dH6U0U/tXI
    IiMLNeMxdmOqfGPrhAajT9LL3XWP0divOUpJrQZGcoPJbwRTrBdAeqkhpzvQ
X-ME-Proxy: <xmx:xY9HalGniy9XtER-xLlSynVBdTzVCkSsXRqcdV-oYMmp8jx24oK_hQ>
    <xmx:xY9Hajw5tuAUlm3fwBwvEgN_ZGDs4xSixL81Y7AOQ_3fFCrQGpImPw>
    <xmx:xY9HamuU6H7CnpN0qPArsRtYVNuCshLdmHvXiwoOtJBFFV_wY9SLaw>
    <xmx:xY9Hag1n7iIpXSqckH-O3_pygtd56l-NgvT7QUv-lSS--HaW2tlcig>
    <xmx:xY9HajGp1GZG_FjcAjmnrWxEPI_UHmICatsknKK1qJoelmOL_wKr0iIm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 06:32:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5bff87e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 10:32:33 +0000 (UTC)
Date: Fri, 3 Jul 2026 12:32:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, oxsignal <awo@kakao.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 06/12] reftable/block: fix OOB write with bogus
 inflated log size
Message-ID: <akePvoX0j64cRnos@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
 <20260629-pks-reftable-hardening-v2-6-b0228e7d908d@pks.im>
 <871pdk4eau.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pdk4eau.fsf@emacs.iotcl.com>

On Fri, Jul 03, 2026 at 11:23:37AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> > index f4e926ce3a..088162483e 100644
> > --- a/t/unit-tests/u-reftable-block.c
> > +++ b/t/unit-tests/u-reftable-block.c
> > @@ -465,3 +465,35 @@ void test_reftable_block__iterator(void)
> >  	reftable_block_release(&block);
> >  	reftable_buf_release(&data);
> >  }
> > +
> > +void test_reftable_block__corrupt_log_block_size(void)
> > +{
> > +	struct reftable_block_source source = { 0 };
> > +	struct reftable_record rec = {
> > +		.type = REFTABLE_BLOCK_TYPE_LOG,
> > +		.u.log = {
> > +			.refname = (char *) "refs/heads/main",
> > +			.update_index = 1,
> > +			.value_type = REFTABLE_LOG_UPDATE,
> > +		},
> > +	};
> > +	struct reftable_block block = { 0 };
> > +	struct reftable_buf data = REFTABLE_BUF_INIT;
> > +
> > +	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_LOG, &rec, 1);
> > +
> > +	/*
> > +	 * Log blocks store their inflated size as a big-endian 24-bit integer
> > +	 * right after the one-byte block type. Rewrite it to claim a size that
> > +	 * is smaller than the block header.
> > +	 */
> > +	reftable_put_be24((uint8_t *) data.buf + 1, 1);
> 
> Can I suggest to make this test a bit more strict:
> 
> 	/*
> 	 * Log blocks store their inflated size as a big-endian 24-bit integer
> 	 * right after the one-byte block type.
> 	 * First sanity check if the expected value is actually there,
> 	 * then rewrite it to claim a size that is smaller than the block header.
> 	 */
> 	void *p = (uint8_t *) data.buf + 1;
> 	uint32_t block_size = reftable_get_be24(p);
> 	cl_assert_equal_i(block_size, 82);
> 	reftable_put_be24(p, 5);
> 
> So first do a sanity check to see if the current block_size is what we
> expect, this helps us ensure we are actually reading the correct point
> in the buffers. Or does this depend on the architecture?
> 
> Then write a size that's just below what the expected value is. By using
> a value that's just too small, maybe we can avoid off-by-one errors?

That would cause a failure, but it wouldn't catch the out-of-bounds
write that the current test catches. This is because the offset would
still point into the buffer, even though it would point at the wrong
location. The requirement here is that the block size must be smaller
than the header size itself, so it must be between 1 and 3.

So in this case I think it doesn't quite help us to assert the written
block size.

Patrick
