Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002276;
	b=xZqaiCjAJE7exZcjjpR8aj0lhbxBYmG6ECVo1VULaPHqRY+uHJVvGSbOJupXt08KJ/qO
	 BonUUcHvzGTVOS/fgpGSkv288IxP726WeFI+xT9X0lX5Fj+zDl4bJCpmoVQU+XRME0HX/
	 ZanW97rcLNyXXYf9LnHQaEkZNX2l+Qv2xW2EQVd0UZs9W3s+4qI8EENPPTsFRTDC+cpeC
	 DYy28VUVqomibsbR/StM//TU33L1A8PqFQC1kF4KObkCMJONKAezRHJ/YKNAemLvODEcv
	 2xgsUwNfP5YOqPuNZgCFzCDo9zfsKRfrcJeCjii+6eLwqbdFfKPdhKT5++W4ruOSnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002276;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gz1c1QGdHxmdwEU0q4ktXNZqFRoRrFK21RHU9OM4uzg=;
	b=vVRXglXA+I21YQI/3xkCQ/rO8JMb1kZ/iPXQWabmBCPn2lHsKLRtjwoUqquJOC7AETL8
	 Am2RwydjSZfmR5JZPQ/ZFDsKyyVULREEwYhscUqefPBQL5owiyijhn6fXj+qr9gxRvyDY
	 bLzI3pCV0oFJn88w7gHwEXuDPfNgnVawRyZM6HNiAfweyoqFMQcOvu0NV8ekBakr50ks1
	 65NomDg5U81cTib4SHiD8XTw15/AQuJuGpplgfOZ/wSZeJqP+07n1gXw2BqZ/a48JMt+J
	 vm12QqLrGGChTreoxRahv3onitVIDYVaGYGi3e6HjGU63xolkYVqwWwLynWGIeWb95A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=X3PwxceT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gBTjce0w;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C6606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=X3PwxceT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gBTjce0w
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 352DF7A01C5
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:11:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 04:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793002275; x=1793088675; bh=Gz1c1QGdHx
	mdwEU0q4ktXNZqFRoRrFK21RHU9OM4uzg=; b=X3PwxceTPmbtsjf7WVeHs7GKv+
	mJeLHZDwu1+XFhRY9fUPe5ltgeJ4/6rvzgh5zsxHTkOS5wPgm7sEmQwQpsA47Wme
	MDl9iFT3DKf1UO3ytMUwbWn4P6Nx9L+z8qKnnCLchibCxsyIHhAoyZTUxKiwAPeD
	5zxKjsdz/2GauDwl8slI0/zk4pkOP1BCfbqRrVVPqkfj838V1owkcKyFiR/o4bi1
	nZTxwmcVe/9/+GSV0LIjIjVnAeLFRpQFzvKpBdriT8E9rmYVszzypJoHvcKtqo2L
	d9aPX+D1BQBhqN2lYToJhNxXeyDmDCqatsSxZaySRi4SPV17eOy2xnbMc/aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793002275; x=1793088675; bh=Gz1c1QGdHxmdwEU0q4ktXNZqFRoRrFK21RH
	U9OM4uzg=; b=gBTjce0wvCRZsBBaSr9ZnFTBbxbNPgwK2g7kYoAVW043In1IsD7
	msULDbVjoQba3+ykEN0hNKaVaXtBlZChKigCVs7DsmHWf1fQmRULKkT11vvNhE1K
	EK7NhtwgTSe1u+2P7ENqCrKYOU2C4OPFe7Ae2uVZFuCp3/+Ogem2PkuSOk3Fac25
	iajh1cQS0atszo9WrrMrcCB+JXAw968Y+RErF9VMDNY5EcCEdCi2LPJx/klo87aO
	yHuveJYdn959WTZ3zI7WO2pb0G+IZiIWtEmAKRj4lViEU/a1XrzX4AhJWaEhjU/p
	iKeVwa9rONZzj9QoHng83sZQTE3mfLYpcZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793002275; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Qg62PfxE2FXFLrC7Bu+VoE9MA3jD8tsU5xSOwOttgotnmIe
	/8D8kpPc0lSHcVi81rVQ8HcmXPYWYRXLGYsKKBbZ76nPn/2nmAjFSqZqc6WSMhRF
	2mfJ2Jbi8LYHhs2JfWIjf4eSYEGb8zEmxzGFy9ka1a7f0J8zY2GzdzU+0uHOdij7
	bRlFgbsaMgKMkxjrEcxsgVT+RLQwOAz4r5gkpLCHVJlH533bDt4C6GCccAWs242n
	C/Edav/4d+LZaJ+Q674CJvyxJxYncg9emmxf3ZS2opWtjN//0BFa46PEbuFDxF9T
	YH0GMT9vjNqCn+XXc6WnCo5mSssxmtZtKqsqYKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a0OEeUxgfNHd10akbYvRKXVxcl+pzyZpaU1U7QlVLmw=:Mj3ZmAhQ1vYrXN3cOqsDsqDnMPLhXcUWe3cHWYkim7U=;
X-ME-Sender: <xms:IwvfaomML_LwazmASLelg7qtJNJOhpWrupQP7UQxjBMkQAoREr3hNw>
    <xme:Iwvfat2LYQuOcZD-zV-KJ9Cpe7Y_Q30EH7NYLdUBzyJrQEVc9qIkEAMxSQcqYBJJM
    qKsSbADJQp6b541PjjsIZZJ53d2YDu5gCEhIbDIqlxWd9V61C0dvAs>
X-ME-Received: <xmr:IwvfakQRNkZhUedkqgaVveXgKSlBXdkcYV42PtWvFnZ9exxm-6Qf2Q>
X-ME-Proxy-Cause: dmFkZTGByGVvteflqZQJOBscxLtkn4gTQLhyBl5nAwtRnOAENVc8TsM0jupHAk/g0qrEGb
    G03eOxuP+Sw31WzfnoAtIYb00OAE1FwmvESHTS3VK6wXAhI0uTf3QZABw7l+xQHBLe+V5s
    681C/18FRClbII2+p2rrst7dGneCXQWOQ/JC3E2PXOYFl7sLhQ1C05EwcL3ckrorzZaHrx
    /NjrMRuzLc749G66sJA6bWLB/YgAQU9BB3QeXY6XiaOtm7w7i/fTQSsdnztuKCJUaiTd0V
    NZzwJMJtYFZkwvYzF4aPEyMg5mx8vXMUOID9020wYZyg4vTp4Yajyr8NJaFZeJN1Z236ln
    LVfADx9JdrrvAoiH7pjSURgeqDrz81bKv8vl6FUJxi6QyVIzv120b15SQQg3oudtmZcIMS
    /MWNL1JfadJGjA3rZnA0zy8MuZ1+WwkafCRyces+LZPrrE8nr0V5+pyIvGdqFAYUqbaz+j
    vz9HZIW6pWFETyrhbJZlVBb+ya7jdWvQUeUal7DKIxr51GDpRccRzQL4omO1jEDB1skHwD
    k7DQhtEeDzp0skvYbksq9PkvAJ+xGg8XJECIjDw3HNTDW8mS1fBQHlRVylLpFyHfXWtjO3
    vzaQ2NpJIyXTQju3QJoV2yl53rfoaKR6MyT69km30l5Ue+KfSGqn95vTrU6g
X-ME-Proxy: <xmx:Iwvfavu6EoMIt30HvL2y3OcgyZlwiW5GcVM5pQOg32DvMxixHO5rMw>
    <xmx:IwvfapacIZZHe6ogim5Zb_ufVE6571Z8xDXAuf0Jujfh5dbkDn1owg>
    <xmx:Iwvfaktb3irjb-bLqHhdR22rmlXccglLVgZNlCIDpigPS8JzMxeimQ>
    <xmx:IwvfarHzahXt572ZFaH93rfBYyS9zsSe7ICgA4dQz3nsj-fqwlLdrg>
    <xmx:IwvfahVoVuHYBqM9OW4BbLs9sRR1GP7gGMqCE7EIjjuodG2P9Styy08e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:11:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dac139bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:11:13 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:11:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Make our clar tests ignore the long-tests argument
Message-ID: <at8LHqyBm9Y0JE-1@pks.im>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
 <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>
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
In-Reply-To: <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>

On Mon, Oct 26, 2026 at 01:01:03PM +0530, Kaartic Sivaraam wrote:
> Changes in v2:
> - Fixed the s/prerequiiste/prerequisite/ typo in the commit message
> 
> - Link to v1: https://lore.kernel.org/r/20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com

Thanks, this version looks good to me.

Patrick
