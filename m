Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618173;
	b=O2R4PGNikIJbnEHcx0C7ed8RTReTK3rkwSrpb8+EbOoFhNciZzLsv938OJpZMJah59U+
	 lJH8BtvRH21z8qvXjlZ9Ryd8gshlOol08WjQ2RArDJCvaAwB1RBbyrg9mf1p8yQ3N/1Mm
	 xY4aVAfXmCK8FEkDy2JbhhipjaQaDvwCzeyfavKn826akvya8wX+1dQVCq6w/JnZA+vyh
	 Mz89lInDKyqvzdAkKvOhPtJ5vPu9GPNusyvI681QpG5+aSr4PuaHB6dOduezmFyCx77vC
	 rA+Ubo52ngzRwhwc7S+SSpSnlEq1XXu3O0MP78p8FEcphgSDHQsPqRi+ydhV5aVR5Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=caArhNlferGzWEOUYpiP3EwIshwtNJBfkWmju2zF8Q4=;
	b=3YGKmWg2loOaY6xRcldstDLboDeRNusSBnKbBsQS678R6xB3p4XOpBS4ikjvN38QP7a/
	 yAKxuvP+Fky/E5xITBP48BNwXg5Gia2HnomZt1Dtz4B/+qjP25ArKcqh/J6MalT0PR0IK
	 zY5HR0pSUh2d01HrU6fOK8ScZCRsfSwMfpPPHCf6pcYiPOs9qKO/M7rNzL3t9/gokFP0R
	 trorfopqUkHGqYah2O+1FSgOhvIXIZa8Piu2Ci3I1fE4GLxXVDzPFdkSipn+cwd74L+lZ
	 ZeIASeZojo1UCNbltOYr4WKdRdadHglsSIL4a/+Cr23uxsKpBDpkpInbcSVC5Gsbfjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=eGn+0DWQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QN35V7C1;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38502606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38502606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=eGn+0DWQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QN35V7C1
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 827851D001E3
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:16:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 06:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618172;
	 x=1793704572; bh=caArhNlferGzWEOUYpiP3EwIshwtNJBfkWmju2zF8Q4=; b=
	eGn+0DWQ11/fOeBxUKbGMkXhsuRF8OONfWzYu20FQ5EL8aT3VjWbxYA37Hw8CVU0
	doCSeziKHtS1ROGu8mKGQ8V+zeVds1Aog06xMXEL4gKbG6Mhh6u6p1Ri+PZyIyoK
	RY1i6/2xx0uHXBlx35rwdgVVyokK9BfWuwEGJrdxMufNP/53L/k9mxVroH9lLcR1
	CD36LfRdPOEibhHmGliOW3iEbzLN6660CFCMdcapdP9a0FqYTtBPWuSD4NorTq4n
	vqLmSi1k6QLP6bkMzmF6dXeAkuykRoi/gC30NQ2U5SNIED0rDa8gBHxdTLrjhIUX
	5CMZNjIS+MQMgjhKLm2xXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618172; x=
	1793704572; bh=caArhNlferGzWEOUYpiP3EwIshwtNJBfkWmju2zF8Q4=; b=Q
	N35V7C14y7kUkMCxjXvzCYG6+KrRkNGalAXpFyC0oFxYl0SUGdm3elCOStU5Juwi
	2hiGazH1DzCG7/pOYxzWa2sQtdtO2BghW4T73KrxLlsG67UDyZsBrM/Sp9J/84u2
	XKewFaeyPdByHAZV9cDFFnNxoG5rlkoltrfBsbzVAJLaUqYrSiVThyXJTh+q/gWE
	/sLr88nd67aGoFZS7y2s5//ml5mu4Vz9YK0kvjrjmhWLikv43J26pAiNJnxMSqSC
	Cc78KdQIxa4G3Tr0LHE7DpaLJe9u1h42TPjU8lqBAsIzxsRk1ewpzOLjo+5uGkO7
	ivHZP+0JrP1ne3S1je8pg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618172; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eV5tOtWDFNSUA1UTbPBhKWEv3Z0XZggC9N2d1WDJp9xseKn
	rL3iG0sSOKD3CU1j1n1ZD/M5E8d0Tx2HGx3T2OaIsfqP5SMYcXQh55CExp2Tb48S
	uTL/f07kQeNHyv0HHIZafmNTC2+MB4N/vSzkujFyPiznGtFb56ynuODddp+cVJ/s
	5ncmJYDFwa0NhT9TzeHRM0MWtgvs5To6CQVoWTss/M11l+45D9BKDUp7vwWxJeSh
	ER2yQ6ERNgx1dmHH5hbHwGQ9RHLnJg9OsG++3JcmRZFcEpYKTtIFlMbHGp7qnwMT
	p2t4myVMKrzyRJ2dqBAdkUyqjYN77uuUYvgkJqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+whVRh+PdOC44jZU3XP4azePGPvsHDSh+Lr+aU+N1sU=:pPY0glq0MtAM7DHi90bHzTObJaft8X8WUsrogwEIll8=;
X-ME-Sender: <xms:-3DoamwsGEza4XhHX_Sml0ITwLm8r2vxnbtX3cnV3nRUQwbCN4ESew>
    <xme:-3DoajwcZT-T53pXBnr-O4xcSvS3-_N_rpRNKzjeLIkxLgkBeDKvX47wLM6kRyaSv
    6y8JS8PpaXm4kOQwSNgy3oTQFJw0beTNk3Ki2cftFH-SaEWThmWmQE>
X-ME-Received: <xmr:-3Doaoaq0BlcOe-syWBaSBB6kpJFefFrGny7I63WOwntWNXSJK4cbZRvA0ADBA9fYQJDBA>
X-ME-Proxy-Cause: dmFkZTEP2ZmTmsQes2Jbqd1ZJGj64T0CGde+tPA/oGYIFVuynjnXFKlCEWxJ8H+Py5BS2D
    a5tQzStozLSr7YCK36rxLPSo1lOcjT87iydPdTlCzUU+KcsSZQY4On1xSyABHWDvfvXlZ9
    XHvU8hhtLboOd7cBzZDn9CThn0H+5KhzjNk1pZt4bvt801Yr1nqQjhlYyQOZLOjXVROe0U
    GE/7jerCAeC0i3TQfasnuafcQnGn2LcNX2YpaxpaZjTb8Y0rix703vWoIImyKYjtm/kLOr
    vyqq9tdyzPEqm+BGrFvcaCIXt3fEHtNDrUApY7kCz7TP3s0h+T/nDMmm1ocoxE/xsgzNoU
    dYUt/78PcxkRtbsgjlZAqlobN09FRQ5fEA54nAJQQy+/gu4TABrTAGlXJF5bm+keQ8nfou
    UnFUjjLVWCb44QPfU20G5Y8nk6lwJadPZ4oF4ogEtiOkRf4J9Qu+BnJ8MgxwMHzwuSSneK
    R7kUE3LeMq3BOuqthIopsUXJLjqqM+nXJaDHK7UDY6GF6YyvQ54W4RTXRc2oK5ibHmYgTN
    dTca5ijAdrLUHyirNkubBBV6lRjiDTLV6lcJ407S0VOFEndkHCb7PGfGqz58gUtFW5RNui
    G9SeIxXBx5ebaxT/sb6n9Gd2YYM7BiYi658K/By5xKkxInMAfvlYqNC9ZpWQ
X-ME-Proxy: <xmx:-3DoasVYkeJjoLzNFs-x65Ptnbvym0YfwTV74DCRs_8SH3BA9iTlpw>
    <xmx:-3DoaugReQ9O8fAqS5bT7vPB5030AIlKq5yDCAZ3ejl0VB2atvoUHg>
    <xmx:-3DoaitR9AW0CxV__Tfrp1CDXjTIH4iQwHJyy8tIZyirK6EM5LRVGw>
    <xmx:-3Doav6LWnAPLGcSLTuCkq_T9DfCZUSq6ZLLvaI1RXc0lyNrRPMt-Q>
    <xmx:_HDoanJF39Vp9ss0H95PlDgqZDgkee9-X1OqCkWir7okaFwVp3SuaaA1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:16:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c3ed831 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:16:09 +0000 (UTC)
Date: Mon, 2 Nov 2026 12:16:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
Message-ID: <auhw9ft8vVGAHP00@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
 <20261027212349.GA774120@coredump.intra.peff.net>
 <617fa828-387a-4f4a-bc85-099ca691bca4@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <617fa828-387a-4f4a-bc85-099ca691bca4@gmail.com>

On Wed, Oct 28, 2026 at 02:33:15PM +0000, Phillip Wood wrote:
> On 27/10/2026 21:23, Jeff King wrote:
> > 
> > IMHO this whole thing isn't really worth the complexity, but if we are
> > going to do it, should it be "make FEATURE_TESTBED=1", and then that
> > enables the right build knobs, and test-lib.sh respects that variable
> > coming from BUILD-OPTIONS rather than the command line?
> 
> If we want to be able to recreate the CI job locally then I agree a Makefile
> flag is a better solution. I seem to remember Ævar trying to add Makefile
> targets for some of the CI jobs so they could be run locally.

As said elsewhere though this doesn't fit my own use case, which is to
quickly re-run a patch series with these features enabled and disabled.
So I'll just drop this patch altogether.

Thanks!

Patrick
