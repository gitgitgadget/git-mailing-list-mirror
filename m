Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726421;
	b=rPPtxkyDeJriZ9MS9hqP4egFtmMe4GmceexwZeA1/KF+hfTpxzg3aQzagEySVEt0ndRY
	 1DsBi8NEvpQ91nPZOlykljLxqjCJfoRfdtF5qpvAebk++3QQG0SiJXoxbjn2tz5sgUXML
	 fSCuY/QVIcpaeQ2FoojOVto4aE2C3WM9n2dJYnG31LvLrv5USsWz38N1yPJBK/Br26FUn
	 KBGu6nM0oPRJYCTZTil9aXsmg7e6Vs6H9VHvf0oU7BTJu8A9qn+OSbUuQ590N90ysPsfN
	 QYc14KSZEGxVYj6lmOB/3ysL9sAenL0CxIkcGM89XnoPpI5ATKLhqroF8tY9GSWa5sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726421;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vpojMrrxuRRT0l923Rqm1EE1c2F60pRfCzRPWb3LQQ8=;
	b=tMBCH5Ook9bpb9iA/9pYSSYPbSPI19XjJzdKjkJ29GKTdYdGhCIaBRFZQN+B06PWUU+a
	 6ZEx0ZQHsEkWpzuQd1Pbn8fSESk7aHhB4akTQSW6gssKVQncbN0M7QJvMe++9yg4xG9Ac
	 9DEMnDPYH+rF0hKUyuus4DASai5U7BFptGpbDwndmceuj3yrSSKrbMgwvrNg0wAk+M1GP
	 J4vRlb6PdWAShDLZP9tqgbyiRttAREufPXiQsjYB6QechYv2zkt/NLK3Vb3hBp62eaY0r
	 bfhDVkqgYqG3sKvMMjJJSWIR6MrwWF4vvzDZQJsWfcE6WT8OgnybM1i0VPbXXr5991g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="PJFkC/ou";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2EIk8P5z;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DC606A32C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 188DC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PJFkC/ou;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2EIk8P5z
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 433FBEC00A5
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:20:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 12:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793726420; x=1793812820; bh=vpojMrrxuR
	RT0l923Rqm1EE1c2F60pRfCzRPWb3LQQ8=; b=PJFkC/ouGsQ3Pno0QkVZvFG5Rm
	pnKumAwU8yzUjTskn+d/78VnW5wWPcgfiWBDoPhhZut9395AsbeErWrIzo9wcIxq
	eisy+yEbaed/wAyctzQMMf3pTOBl/gGcSuTOlY6cb57Mu0LVUAKk+kz+NbhgyzOY
	T6Gk5tuiqP9qRpPwk3Wo0tbfuCVljm5gyGPXfj6L8++F7lH/VLjPOgh3mKIINnkk
	of8AlbGH2UDB12iMMBIk6gJ98uAbmwdDeJ8BU0PVF/dZe0CmfDojkPajP3ZZ3DB5
	5r0yOBCpGnbu3Wl24z5MPK++2kaanlnsuQ48Fys6z8HdS5v8lZR711JlbkOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793726420; x=1793812820; bh=vpojMrrxuRRT0l923Rqm1EE1c2F60pRfCzR
	PWb3LQQ8=; b=2EIk8P5z9w7ykZiwKpjIK4CCvpdqRNWyT6ieX5dDu5DjidNv0W/
	BiHLHcVRLFvEtT8HEKWMvqKKRBDWgrBbxZjzM4j78qt+pL3JpT3pU+muz44UlPal
	GCIDI84Tzi28cP1k3sFArUG9UTT6DGzSSgC5YbA9xq0irS39MDUvjRuDVnxaMA/e
	3pJXEb0wlGAI0B3ztV+Nsj3BN7JZfEOX5ztPau60ycMS6xwJLroh2b2c18sd9HLc
	XTpNwyiEXppFas4RQhqoFFDv7BdOpqnn2iEcjEB8U6XDUEYpes5GqfHwYN0NikpM
	OsE5Dc1DYGlq/4K+JfF1O3vV46Sk38sREtg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793726420; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:E9Mrpddc3AhZxDs5LaoCNDGWeJgImq1ydkQ6W4dWeZiO4No
	pwTXS5LEkSqL2zN/381LAsFT7It7UMUJqsKNs12dw8wF4V1fuPZRoi0epHyeoOY8
	cNhZMjM6XqA0mV3rWTF26c3JwuLvK2zFfCVQkENwRnmEpoa44nQf6deAR7qfq0KL
	P77k6iwCNDRcra9nZ8EyukWNbnoNFiqNmFmrW0QghcXm+rHN2KpJNpuEjK9tQnnA
	9nfh9r/5HCkdmkTM/RtYa8Z0JJh+ZZMUtos9D/4UDsbNBxvS8U+LmHU1ef6AOX33
	RJ1JZO2AJh1t4OW7YziQItGvLLy/OkQKqiosI7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oU0OiyG8pJcwR+Ofz9y/9EAC++V7PBn3IJZFDIBjTis=:0e4rIEc9DkvKvCKzF4F1xGkdzoJOB41PHCLhlTK+P8k=;
X-ME-Sender: <xms:0xfqaoRX6vlg5LsB_ltSC5tRV_FDhn1JGkKaVRAUjb3KP1tnSGM7Kw>
    <xme:0xfqaledkqIeunitNpOV4bbBSP9mik6VWc6nuMhIjcWUXz8oG57ieZ_Qn0QMta-D3
    zsd5FJL8kvE4zfIhoGRzdWTMaKzttMiLNEW-pOpt4gI9akbPgI9tnkS>
X-ME-Received: <xmr:0xfqaheuddJWgkeBBuwtE79FMUwoF5n_KoC_AIDRUKcGK-uQiWrFp6f6u6FJOVw6Pyx5p0jnOgGLofXdyVc7QHyMiaSAUs06q8Zx>
X-ME-Proxy-Cause: dmFkZTF2e4jvy3YfIPWjnl37u0HF73uXNzI05O/KBz9tGtBGL+yqi/SqKnJ+vE7LGcGvYQ
    F1f0Vdv9BlU4PPZs4YOujGM3XUttStGzHrNY02zszfa7q96b5Ri5qhumPnsKlA5a5mQ6mQ
    K6bW+0y15gRQsQiIPmMQuS8EfIfhiy5wwSkC+UbLHMZ9uFFIziY5ffjghUbJTMhw/VjVQu
    YIaMEBlwtG+7uQ+pgBI1eW6iNPy80Lyef3bPYllJwlfsSjaGX4JjZWqid8oemXiJ6o3ZHm
    /FjUEERwNJfycLj37bqcqCf/LQ/90ivMuVMFrnGqOdDgUX9xAftGal0eXHMA5SZn/0adpq
    yCOcqKucOiGuydSxEvzMeccwuT8L1Rl2aZeapa8XJR1rLb6IBUZvg0TKtINyT0PEZEYqzB
    CTKo7nQhIMq2InJ2WHJqACBBIlkcg9JyDWbJHal5y86mynCxnljGrdcjlrNJ9Z4gLb1tDS
    xq8LCgzBYsxniuPTekxPBPXs16G0G+M+kA48Vh5SwxdsDSAJeRgjlPRpvoSnxYyzK80n6z
    u4aYfLqwavwW+3nFzE9IBAaT/7U/z4/gRaq4knfu5FuQ3bWmYX6wfYaK3tZyzjQ2mNNZCB
    ZcKdl+d6Gb/V/55cm8VraPaI8ePMKlt9NeQpKZ3ZP1RrVrl1VEv047jFSW/w
X-ME-Proxy: <xmx:1Bfqan0NBr3oCZ2MpiIe_J6SOGErCUtTwi2IFJOv3ZiqxJyUoQvVIA>
    <xmx:1Bfqah_f0re3CURZdz4iHe_POEjVI0SnyFyZJg5DXPyRHXRFUkkGLw>
    <xmx:1Bfqak71nRsN_XX9ZUhTWy4H8jjzX8P6EcVTCGSUJzDhCNAzPhzv3g>
    <xmx:1BfqahvxvjEA8jHn8FDFBZ0Dkn3rBOFjV_pVXRw_4ygPMrE4z1mEkQ>
    <xmx:1BfqaqVUcv7DB9Y3YBhPLiVOadNIB6LUm4nEowE4VtsE-vNK6NILyMCb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:20:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Cynthia Uche <herroyalpriestess@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v4 0/4] Standardize early option scanning
In-Reply-To: <faf0b5e6-1c63-4c68-9f23-42a452879854@gmail.com> (Kaartic
	Sivaraam's message of "Tue, 3 Nov 2026 13:24:52 +0530")
References: <20261012074413.337183-1-christian.couder@gmail.com>
	<20261102151447.734680-6-christian.couder@gmail.com>
	<faf0b5e6-1c63-4c68-9f23-42a452879854@gmail.com>
Date: Tue, 03 Nov 2026 09:20:18 -0800
Message-ID: <xmqqv76dal2l.fsf@gitster.g>
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

> On 11/2/26 20:44, Christian Couder wrote:
>> Changes since v3
>> ================
>> 
>> Thanks a lot to Junio, Kaartic and Cynthia who reviewed previous
>> versions.
>> 
>> There are a number of small changes since v3:
>> ...
>
> Thanks! This version looks good to me!

Looking good.  Let me mark the topic for 'next'.  Thanks, all.
