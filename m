Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210913;
	b=Rf6LF6sS87cxdbtYxEVf8vnR3Zdf1fCFPI0ADwqdcfRGLQeUtFZmoaZyCzV3GBWOJuyJ
	 myyKPdgp3SvEFTI/IGD9aC9Nhd/9/s/wGTTV0kFtiL0chGgoN/Iyc7kXhFSAd+bDMoEMh
	 CDgqAeUAXCINZGfLi18o8uNOO22kBfPkPnOnkhjrEJCV17h95Qy4QnH6HegtfGTl+aDQt
	 DRyGO2XXihIr/VbLQaHSSjvdvJVyoapD+MH6bbr9ae+wRA7CIl3B5WpqI76+uPFeFam8l
	 vtBEV+MWkAx/XdUorwVFne7iSO5oRcnPAIy+mPgMHj2F+yDna9YGuKTgk3H91ATw67w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210913;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=815I/fFTle7fJvn7jrhO5rFJoCz8KLRsQqJZ6Ceoz+k=;
	b=bt9zLHEtZAbyoxCfH4OwKUg6Vt+xosPc0RPBDnQ+TBF5/ah4n/wTdUKsXeOkxEoIw6FM
	 raGSZjaJMm611c7Yj6c3fkiSSrGkMbt5eMOlr66x9L8NlKX6cd369Y5vmgx6AjdZTBz/V
	 /P7H8NNI+1+yvIDf6J/dedQLcxbzb8GtuKHYqa6nr78gc2EHslho2jVeTg1D8+Lj2624y
	 EMesmoLqwr+t1qiQtGGm8Prk2Zvo3RhZTgp67/R6CSUTdHhP/U3wdY9NAmyLgaOK/notU
	 PcnrS8tbBPvb2JJ6jhB8wfhM6LR2KPaRGd1Z34SjZSPwcDDUA1hTBm+NF6Z2wR2sdbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=TqJY9zFJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p3+A4IMd;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE2606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3FE2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=TqJY9zFJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p3+A4IMd
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A6781D000D8
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:55:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 02:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794210911; x=1794297311; bh=815I/fFTle
	7fJvn7jrhO5rFJoCz8KLRsQqJZ6Ceoz+k=; b=TqJY9zFJR4hb8VmTpMX6k6BZxJ
	DfNpj3WdyYWHebfzlnAtS33r1NzznVjQgzYRWmWqqJakDFulm560ThXfB1aqSBpX
	aeMVH5FgQpciOOD/dqr3k2Inin3Ie1gy1JdxoA+v6MLMlVPgKP4kksksK2cdvZZG
	RE+BhVIDLrK9WzlVqRZ6/T+T8nLQreLmpRufXwhuSfNKOP/TA6ymtATGuWkbRfkI
	V2PfXD7D39+s47gygYQKA6eLaKBJrZ1dLjkGG+u9prv8Wd35YIxkJpjQsb9Gad5X
	/CMEnE9GiW5b6IBLJ/jylMJRGEVVvdUtp97C/zPyvqm2pDXTE92K3uNOFawA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794210911; x=1794297311; bh=815I/fFTle7fJvn7jrhO5rFJoCz8KLRsQqJ
	Z6Ceoz+k=; b=p3+A4IMdM9ST7fP/Il4CVAs78vCWordWhJsCd2NI7WXj4uflowC
	BmWniH9cPHZdcx8ie8T4WJ590aK+eaMBPbrqdGhuvv+WbHYWJDlJPk0tXxLgCfU4
	GR2WmfdLaJiqUtY0IM7ieockZ/qNTkWGdVI1E08Er2EZkPjgYuA7qllrB/g1m6Kb
	13DrXRGNSL5Rsc1nLtbKhwMvjQqLgzwd1okd+nkDK3eHVsRDbIV1zY6HlQwCekif
	pbF5abg8F/5W05rHvqg8GP4Xh5hyeSK7u73Exf+Jcra3h28nkP4aiVl0m+qaCP/8
	r5LrJtCmg3URqcV1hdUemWgHuwNmqUTGnmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794210911; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:x1lRFnfe6FYrUAMrWU+dyTYnhVi76E2u/s4CuDaD2xnTrSE
	zh65x1ujmLuOjuE6Fvfcnombl400i4kkfIFvgjEPRaB5XJ2uH4RhZGKwuqPUX3pS
	SkCX6UiIC7Yuugpz1uMnLvWO7XcNZLWJHOpo+4YDsPD4u3gbD4I1GGZk66Apnx8+
	dCKWAk6Oc7LLZglMOl9gFt/yBgSdFYMmD4bqxvV21w1Gfm7n6sxusDVR38zI7V/k
	Pup0RkaWafxhTSp/hYo6LF9W8ZGF9ElzOwVGs1zQSDC8KjVa1NBDjgWFJiI3R0uV
	Zvbya0SOLJhZTz/roVHmOznWxliLd0Ya8xHNnKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8NEcEcQVEMTlBcNUDjMQ4jQTvv7Rr9nUD/7iNHPSVpw=:39dMo+mEMfZrc0/n46X9rYOFU0piSZJhFnc4DqI2hH4=;
X-ME-Sender: <xms:X3zxan8mFX2dL2HCZtiOEiTMbpOGT4ybPvlTv1r8CdTE2Vts0U-Fng>
    <xme:X3zxal-CeeCxEJGHH_FXCJRXrU3hjKEtZ-OOAeEfSb-7xiO4PvezRzxlY-yxNrR20
    qPmzLfnuVhrNDL5JdoB-IPY8qfXRVEt3HUmPJdsg9KSJOGvvAOAwQ>
X-ME-Received: <xmr:X3zxanS4tTtQlxw8jc3ZH2V1O6XcLtoqC_imyWnJIwYTfyg9mg9rKYihH7tjNiyapeuRmMA>
X-ME-Proxy-Cause: dmFkZTFSVZTHWwaNhma5sLmOQKqy6Po5E2cau6YcS7ABoTZpSQkg9hzCLBE7LpfONyho4v
    syKr+7Qm+8Tn+QcpZDwNmDgYYOyJ3ConcBtObHx7jZRE8AwmXvbs18/JzNG78/4YTXWgtP
    1B3gumB70q1dOiFm4wM65bBxuQrN113o8vA1/OAZ5lx7My/nTCbtIA715tsA61E8JRkO0q
    Xa+54AWyiKQ+MsMIpOE66Cuo7ejs/Jq677uexo6Hby/eXWIpslBsQWFiLVcuhMPZJLRMlf
    9QK1Nudn3ixv7f3Z7lBu3XevrRKQOLkk734tmrSyfRhQkSRUsT6NPzl7z6DoBpvrdsfCgU
    hu7bLpcqq6FrRP1fIAWFG6N1s2bAxOYc6j6yxS8ketxzup2CMJwTPxPRLbINgYysHX8pap
    tib9GAazcwR+5kHXFfZmNKZuWhn2tBK9lEjBYynq2q+J1KC7h9ymmeqj7H8CG385zOqI9G
    OGnJoKRPus8GbX40i4/1AqE+Zyr44jqbjxKwYcsFdIQCJrXqFpcu88UZr9f7yQIHYwDTu3
    T/sWR/Z45BpnVF517Rg5zsordYYboWGmzwr030DFqeb0F4IZdrFcWiGIWCMiQbuNZvTHzg
    thv3RrGsipojQBzP38S3pOvG6XRBamA5ILNF328D6ZKBV6Sc/TresQefTPug
X-ME-Proxy: <xmx:X3zxapcvt-F_bE1p-brEtIWRfQEA-tNprxBcVeNiwwDjwFKZvp0REg>
    <xmx:X3zxarDBqchMrdc8RNd1nD5EIy5LTOgJHyp6LAc7iclisGFW0OtF6A>
    <xmx:X3zxarn32HSwibdv3edcd1bAlbqBvgrniTDt8N5CLDEUgm7Ct1xoyg>
    <xmx:X3zxamcLWO_nBwmQNR0kdcS1hwZHIxVP9egTgr-XpVh1b5Op4125wA>
    <xmx:X3zxatzqdG3_3tGvxxLKflsjFoAyyLYnb-SuCGR5bN_WPrThHdhKUJB9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 02:55:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d70f65c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 07:55:08 +0000 (UTC)
Date: Mon, 9 Nov 2026 08:55:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 1/3] credential-cache--daemon: do not apply
 core.sharedRepository
Message-ID: <avF8WVT1W4o27CzG@pks.im>
References: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
 <20261104-fz-credential-cache-race-v2-1-ddccd0831eba@gmail.com>
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
In-Reply-To: <20261104-fz-credential-cache-race-v2-1-ddccd0831eba@gmail.com>

On Wed, Nov 04, 2026 at 11:53:14AM -0800, Farid Zakaria wrote:
> init_socket_directory() creates the leading directories of the socket
> path with safe_create_leading_directories_const(). That function
> honors "core.sharedRepository", which is meant for files inside the
> git directory. The socket lives in the user's home directory, e.g.
> "~/.cache/git/credential", and the repository the daemon happens to be
> started from has no say over its permissions.
> 
> Use safe_create_leading_directories_no_share_const() instead, which
> ignores "core.sharedRepository".

Yup, makes sense, and the patch is obviously correct.

Patrick
