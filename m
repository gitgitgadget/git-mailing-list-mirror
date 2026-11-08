Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103011;
	b=5ajCddrjQe+mupykPMonyOdK8On7PvgZ3WRo+SnXUntILVaBnNU0u+/5NPqa+bw4dow8
	 HwSg6Qzoh3O5pc+39hhILV5tusCPHknXGO+t0zvbo2l8TuT0U5mUxZqcdnJuvFl1KpyRJ
	 h7PqLLhiaZCl9TIlMcZLKVAUliYqsxxF+KVq9nO9er+HNJlDofg4mLUsF5066RBp+OB8w
	 bfPwVOz12FCsuVFGGJ6QwgpTp+fYRJFmG+tJSvdvWVR7Zl3Dl8CA1bpCsBga823DDK7FL
	 e8/fOoOZDBAJVaDmRvaSzKhk3557FHCqjgnYPpVU3Z9RanCg6WkxzfYf9AnoKgvGiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103011;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mS7+9ymYdAh6ux+UMsV011nCgXwnv6TrvsEEom9LMXE=;
	b=1osUT5qZ7QotNxANLDUWNc2N1qkL5781Rq6nPqlMjjs+KC7dwC/9usVAA8pT4QLjyF2X
	 1dVCmN4QQDx90ZFsY8tBdZ6tSNBuYUhCxOBOVhBWYB0k/NCmuPZ817TjdsOIEmentwxPx
	 GQr7t7fnEpB8aWGCatAGezV1B7N0hU93+05erjmD2VwKZLVQnBFHu0+dunHoqDYK1+MMK
	 TilO5Rfyw4VRrWj3agDhv1Inry43NcrwukRmYu6NnrWUCkXDcDbv2jOGXSRnsBed7trUO
	 iLz1CWBT02HvKfExrCbeDAv/3WStEMe0YyiHQOJijd7VCIYMVmkrYvbT8w8+S2qzeug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JWDhA+7O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vgRlx+91;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7D606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 01:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JWDhA+7O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vgRlx+91
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAA397A00D9
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 20:56:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 20:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794103009; x=1794189409; bh=mS7+9ymYdA
	h6ux+UMsV011nCgXwnv6TrvsEEom9LMXE=; b=JWDhA+7Oeyac+WGEqKYfr+yH0g
	XK33XsPUfLoeUSonTjsnY/ZGZn7nz3lVaDdzR93JBkuwLzLXg/yFTRcqFrtRrNEd
	YhHx0B1BmepPEANOfRHwJSLluVmBjd6Vx2kHCKkG8ERmP1TNcbEYRsXUH0N88h1f
	3T1zR/XHEJMOJIookwFqHHzoxkiVURo3yYWrXsWFKdGVH+2BFBH39AdjrPrfA0Qa
	/HQFFoEshBV8WbCu36S35NGLeFrvl7PclqplP6suOTIwvNsXwOX5uwHZTMQ1Jdqu
	ss0Gs98qnzuQHjeDDEZVik05H/JiAUIdp9GTGHW549ORhYNSEHe1gMiHc3xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794103009; x=1794189409; bh=mS7+9ymYdAh6ux+UMsV011nCgXwnv6TrvsE
	Eom9LMXE=; b=vgRlx+91JfMrWMgZKMW3K2LdLo8KJlJOhUbKhcqPc4mhHQFnlMB
	1YmL/Ft80WBsqkCCwC50nhUEITApSDa6mgaLNn4lgSGDIoPwCCVNsVn/db3sPW6O
	42ahHX7o1vgGpEndPMH28G5j1NWwoESmaGZ05qTjbGwSuYWskzQALaqaNFMaJ3oI
	9BgJMr2tsJWYgcDXmVxsduy6iwx+9yECDhXm2Zey060LIZhxotzo+uqWJcQ3YVbW
	mWGRKuCBZCTCoIxbip6o96PZIKNb8o6zR15FHZtumZ/c0pmBVUK7rAjTOUSb9vzu
	NgSv/yHRxobFLCa5dkc7aZK9OvWQksyH3uA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794103009; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IA/UiD0eME77pfMnLT04HitbS5+m23HM5d8tcqkf4IlIPGk
	8K6wj4jwawpqQb5NCT11c4CuZ1K0ZpTBqgoR6xA4iQzsjBX8J1K8fwPuOMeKgFwe
	PJVyuCI0GYxkVPwrr3LIQvwmCDkWHEqMCRRxvmTR/+SEwSy1G9iXlBA7+jvMxL64
	yvQlSM7o0Zctb29lsoRRXUbZs45uwWL4Jg8U6UgiMxhB2kYk3nFgc1NthcK7d4Sy
	jL2glwfA13cjAvCA2dQ5sv4vtOJMWjaC2VwHNmYk9uXzHw8WeEwkDoeaXGdRe8JK
	8JNplQbDcVw8E1BHEigZe7tsVmTfv1Yj2ruu0UA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LaE0RWwC+A7GABz6clrRjLr++4akyPwE2g0jH3Fb+JQ=:uYkiEHitCSUfflVAg6svYUikxhLNAi+G/yLTHrl78SY=;
X-ME-Sender: <xms:4dbvalExPIJK86eu3ZVEJyeosmkuJI2CY_RXH2v5dXhhYBm-_UTtrw>
    <xme:4dbvapbABMsOOn3L9lCiwXHWL23-Qrd3YBYpwRQsHLB5CquVHUzGNbWNpl3nZKkqL
    G5Vj3K0rPI79annwOL6-QAoe0UUaaTAfODV8mxq-CK0y2Fki1wu5Cw>
X-ME-Received: <xmr:4dbvatWB4ecECKPtKLjswnsTl9d5K_6BKgbxGOpipJV6i-peKT5AfjRfq_Ji9VvWGZScUCDMSAgyAlZAJUr3_eqjaisf-qx1EtAm>
X-ME-Proxy-Cause: dmFkZTE0J0xykmgV2pBBnW6ayxdwlW+pRSezdD/IO29uGRB5t/Q3r4b4+n5vn4sESCig1x
    YPPqBJK3jahDfkW9HnA/Re9NA1PZSvJS/c/rjABDtv0ihiCaBa/ISNGPjYCCQxQnz1+iVL
    7xV+ZfZlcg30+OTUhzrXxnKKJhtza9BH240Nwis4p6uG7kX0HZFPkHOnguH5Ab1AJgOrMi
    68JCOCSNPYeOjPBprDpD17diDlKLLsVSAo1cpZkSwVshyZdGgVQoPMkz3PviZYzCB8eQjT
    uce7rHsKu1ojgdQD5wyPdi5IU1OmCwdTgW5lfL+Kx/uy09nbYCjR3ZTomQMuY3gC+UENNG
    lqeZgTsc5p9wZfKeU6z0/BdVUcZQ7j1Vcr3A5gFe8vLowmZD7VLIpCbdh/gBfCw/dcdnZo
    yRTTRCVxAxVO2Lo9YCR4frRitzIosHaJ9BW90SRK3+yFPhljBeVGFcca6C3GiJQyEc0MCm
    XK6rmvQGQuxCvFQQfqIakm2EJ0/2QGILI4ab/lA856k3ramMKKPP4HH5l36yZqTAzZ2vKc
    wiFEF9dXwAH/PRSVjqHTCHYZ/YFyAHYucrj6DnZUgOXrDu4wSZYicZhhCZDo5liFe5erFJ
    uZBQbEa7QJCyXwlQJbsMJqm+zS6F4uET6MshneJuy5RdKe9RZhfDOZLNRGyw
X-ME-Proxy: <xmx:4dbvannD7jDL2qfo9g4gFURX7SdDCrBJYIkI5XT1OsKlo5wv6sQY2g>
    <xmx:4dbvagB_EqMwh5vqSw10_b1ZvZZ_20WmQWYCndDFXfP78WRABwhLwg>
    <xmx:4dbvaugQsgHlCO7fDN54LfN5aUaBGjlVuTAiJtIAwLBmSE2gon_QYw>
    <xmx:4dbvalzzpPxl5M74cdNilgDSKFB-zC8Z3z5wqqnqxnuuJNiAgaRFwQ>
    <xmx:4dbvanSfa9HvI8U5nzgh7Jr9r90Vvvku3qT7n95-PuE4iLNLH0pRF-5U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 20:56:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>
Cc: <git@vger.kernel.org>,  "Jeff King" <peff@peff.net>,  "Patrick
 Steinhardt" <ps@pks.im>,  "M Hickford" <mirth.hickford@gmail.com>,
  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  "Jeff Hostetler"
 <jeffhostetler@github.com>
Subject: Re: [PATCH v2 0/3] credential-cache: fix two races when daemons
 start at once
In-Reply-To: <DMOCMXGWSKK6.13UR9RHCJY3SI@gmail.com> (Farid Zakaria's message
	of "Fri, 06 Nov 2026 10:45:24 -0800")
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
	<20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
	<xmqqik2bybfk.fsf@gitster.g> <DMOCMXGWSKK6.13UR9RHCJY3SI@gmail.com>
Date: Sat, 07 Nov 2026 17:56:47 -0800
Message-ID: <xmqq33tc84rk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Farid Zakaria" <farid.m.zakaria@gmail.com> writes:

> It was not clear to me as someone unfamiliar with the codebase
> whether the complexity of handling it was worth it. It seemed like
> it could only occur during upgrades (old git version).  My comment
> was meant to say: I did not address it but I can if we think it's
> necessary.

I am not sure if I follow your "upgrades (old git version)"
reference.  Doesn't a reasonably serious installation of any
software have a babysitter process to notice a dead daemon to
automatically respawn to keep the service running?

If you are unfamiliar with the codebase, how would you know which of
the careful arrangements the existing code makes can be ignored?  If
it is not important, what would the reason be for reviewers to spend
time and effort to write a message to point it out for you?

