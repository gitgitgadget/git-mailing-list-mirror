Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638121;
	b=4MzltyLzzDT/zMO9XlDlN9A7LP7DnWC/htaJc0pK+8ftwTJHI39rqT4uzCmymk63K6CW
	 EFJ6qk/pMeZUw9wnE/tgEFMPq6EgjdmRc7CDZLOCJWhj7KrAtUemSuZ7h0okdmbFUC++5
	 JmK1TwbYv8Fzq0HtGJH8U0Q1EcQlHq0DcxqKtrBAyNhhYXr6E0BsSiOi/KZnvJHKHweKF
	 gHOrA8oC9dz5QbgRtum2G4yF/lWBnvpVk1Hlc6jQavsS5idGugvuOkuVl9O5ZILNxnopF
	 OfHjGIrQTlySVe67JR0aw7c7mWt0P96InB2Fm3iZNPeZTju3r9eH7LxOtBVmpudCMOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638121;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6GCr0pTwt4EasNmHpLFNQLRMgOTu/KKJ5Vd3utOj+Ro=;
	b=p5sSR+3lB+fd4yTy+EF2TDJDHedsm4/0/FT2CnNVR8UJHNyJU6WAjwQa63D4JKTy12JI
	 56FEi7yfbJlaa1bSRmLVxbOqmYzeXc7bFPg7PMRaErvDO5vvqDbXpD2T0BswSBv1vHSFt
	 UC7FSUUaeNQCWUYYtLt+p0bULh3CkR4fzjZbZwyooniBqCAi7gcHh7uPY70z75l7fEmw3
	 kf6MzejA+ie1hykUm7bwsO6HcfUWNW8qca2WDRW3G/j4wvIjGMTnAOqGTQME6aLqMqJoh
	 9z9GDzYsrjP++iv4AZ+C3mUptE7QQhwh6djbdRJH0O+2CF/0TB2VaLwgywp4hwBPsAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GjJqmCwG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=q5lHZi2t;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76298606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76298606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GjJqmCwG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=q5lHZi2t
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 997B814003B5
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:21:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 15:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795638119; x=1795724519; bh=6GCr0pTwt4
	EasNmHpLFNQLRMgOTu/KKJ5Vd3utOj+Ro=; b=GjJqmCwG7+javEooNeTxETyiri
	kH8XeOYA8x5ujd/rJ/1DRSgAx+JO3qtpjsqdQxJIM4ulXSCupVbxNg91mwh9zmt+
	qICYNKHrW+RnAb1iIDkDLqi+1T/9cbZyQnFUYowYAkzsxg/uR2SvrzZdr8IfnH6E
	k4gtrVOHSnBxBrM6s4+UF9S3tyiho6dl46HkVk4SgLwaPKF4/mrzsygFvErPE3uS
	QB0xICX57DAlqWtyG/H/ahyhumb9Mn0zN7pTHkP2w6wtuon7N6bfk8FYXglBb7Qx
	FS7qjTKx2C1LXnXOTFyRfQsObbbOTzf4sEZ4YEc8zJ5E/iwOB5jmAFcCRkhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795638119; x=1795724519; bh=6GCr0pTwt4EasNmHpLFNQLRMgOTu/KKJ5Vd
	3utOj+Ro=; b=q5lHZi2td+394FarCUGNunbX4KsLVrFWWw7CFFKvrL5FEfzDEVK
	5GofV2dgbiaSLdJImYfMoIW5Vj5LIDjfBpvJAzIcfmyvT28UteUYcJXc5TXYQaEI
	cO05HpkO1g3RbS2KYWhdCedkKJFgHI2LrRt/tbEYbNR0qYkgUeQEMtbNPPtQ9Paq
	2OX8qEl9WS++SFlC7GzZqaoXra4QjfI7K+LLpTyMiORVsZz6Gur1v3q1v5SZDyay
	WQ2BBc/Oqznb2fsKSxfAFlwNBb4cSuBsqxhIfMSIdwpKFKToH2F6oLr1nfjGs1+h
	FnNeb8kxSDVvFGdf6qCtUBjLAX/on25Pu3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795638119; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z4C/gxQoLoKtx5K56xsRsMYot6b9VEbbotOJUGvK9Y+1QCt
	eFYQ1ZemVG9YIpmBb+5cdnGmUddpSxwiz0O2pJVfSmEPyyPhmeDixUpB6EDaRWEe
	ZnH81/fzP5+3ZZn0IZ9kPhY/KgDhnABLO7WEqQwU4KO43S+0Jsin+gp/qIDWbBl6
	kudjgoKqR1zGXttrxcdlkLp2osy5I6PCSiAh6lt/aOHa28WKbiSF6vp/dz18VStU
	rOuPLXr5Qz882yMZpfM+HWs7zoOj9JKQ+q6fbrDOuuJ6QJmnfFySEoMWYhNCL/GA
	ufRSie8IK1AcVUEiH1bcw7evl3uKbtfgwx4dSKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:POKmIWY+k+anLIkoM/Au8gG9CJoAZD6gGy3nrBMnm0o=:sxk9oRgcodpZvsAgMbpoYXZWAXMVIGrLtBa9/MD0/js=;
X-ME-Sender: <xms:Z0MHa8Tupjso4KSl7w8d_Xc-0sx1UMXbt8hchggjDqk7nscA5uXLOQ>
    <xme:Z0MHa0XPMeN6DtQd26GcYtlDAXmZqngdPVswEOggX2j5PUz2oIr98zboCnuOH0Ne7
    FJSbctXRqg_3Z8ksxsXHKWDMDr0G-jhxh8Gw6ekFBDPQqhnhMY0OFE>
X-ME-Received: <xmr:Z0MHa2ZMKT-4dgwzF4wBaR3o62WjbklqzxJyemYXtwPG6Bz_O9nWKB_GiLq9eelIlelx9iLOUOeGralcyG5WZvwtXwWNML50K3XT23Y>
X-ME-Proxy-Cause: dmFkZTG1JcFt+uIPr7bnLg47YT+1jcaJTeOrEbM10Kl/5Yyaa8qS+H94zDEk5EZS4g8I6g
    E0VoycMghfH/fEKNpUdU9pwi1lwKU+MQ4poxfZ/p2ugSugXHTZ68uHvbU8SMY0a4M63FMT
    9J3IT6y8C+T/1+YPvQYd0d4SKdPJX1ELA8xIziYEGUwen8jlVPUzrRrIGqaaWDqG5KUAV9
    4u90jFnCF8fwjuJ6NMyxjsPVDaFklT4K3FqRa9puUeJpgjNTj1XcBJzH4KtXTDl/FWbjcG
    rha1HJQuUGFXvc+IhwP1vV1J2hgIcEjRB6kdyZzQEFx0zW7ZSjN+ynFysuNM/jlY7BsNEu
    V30SWo1URKd3s8G9zlKPxIevE8w6a9m+bnnkRhqFOMBgQcUkrr0lr8haEOLQP2aA/L6qHC
    8Wd4nHLkPHKv98J3/HvTOgJpQZbkuocK0osNFOkMheJcAGe8cxAmb675pi4pM8wbsTIOo0
    1ztCF5P16AbwIjBV/4NqzVk20HQr8XYgTTHFTtUpcaax2DPqTpaTMNoD2+Us/klb2ne+Ce
    guYYr6noFHre2GZDI3ibLLvXkF05m26murzKvBhYpv6fTBxmVYiUqaAJCUyPrC4fZfZinR
    ErNSxLzYFtr1Y44nhXBeN+CEEIo69iAtrFYvKnfY+n/bOfXoXdi8LS7u0t3w
X-ME-Proxy: <xmx:Z0MHay1hgo6sswwF0TifA6saVL9DkNlOQS3AWDgfbyaGNoQkgFfcGQ>
    <xmx:Z0MHawgc5Lqysdg-h9fqRfSHSEfBrZkC0Lk0kt6KLV3A3En62KToFg>
    <xmx:Z0MHa-YymtPG1m81rPJGrHAaJbDOCm9nh4EhJ3tPQ7yrCPgZEa1TZA>
    <xmx:Z0MHa4Q2lx2E28KbjlmVvLoxXTBUCQB5gzSK8J0fEYqz4hNeuV1rkg>
    <xmx:Z0MHa7C1R63BFdi70wRNZ17Lve9ZOQhyQ-37sRupMUvYV4GFlrM1PfZi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 15:21:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
In-Reply-To: <781ae43f-7831-4aa7-a7a0-aee069950eac@gmail.com> (Kaartic
	Sivaraam's message of "Tue, 24 Nov 2026 19:04:41 +0530")
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
	<20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
	<xmqqpkw0rp8i.fsf@gitster.g>
	<781ae43f-7831-4aa7-a7a0-aee069950eac@gmail.com>
Date: Wed, 25 Nov 2026 12:21:58 -0800
Message-ID: <xmqq8q2g1x21.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> That's a good catch. I suppose setting the have_expensive_lock_ variable 
> before writing the pid to the file, the issue should be sufficiently 
> averted. That's because release_expensive_lock_ would proceed with 
> removal of the directory even if we fail to write the pid file.
> ...
> I'm not sure if we need to go down the rabbit hold of fixing those too 
> without actually facing those issues. I suppose it may be better to get 
> the jobs running with a version of the patch that includes the above 
> changes and look into further changes as we notice any more issues. I 
> would love to hear your thoughts.

If we open ourselves to a possible deadlock, then it will be a serious
regression.  If our locking is leaky or buggy and allows multiple
processes to run simultaneously, that is the same as the status quo, so
as long as we kill the deadlock this proposed version introduces in the
updated version, I will be happy.

Thanks.
