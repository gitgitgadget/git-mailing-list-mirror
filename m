Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691801;
	b=nAuoLZY5gpCYpC1CvlNBuSFBgGi/1+wlJjEtJwYTz1FmBp+P/zBMRhq+cd3nZ0pamaHz
	 UeTWYlBbvugRUZEtnAR7xKMmNu11CraK5Jx/j2t7TUKzEbidlFRSj1zWyHAJGp57xTtt9
	 gmhgwLb8gvU8vjbStAgWhQFHb9fhEuC6mxlaZjT1x9rIzQ1oqXupCNlnyPrtkI5PA2STR
	 wnxcfwHJC/7xt2nc1n3kFN0qvITGGMYjukn3OeWLmmQ+0eo+KXh/QxN+QwAjL/KpQXooX
	 Gdl6liQKiP6+55NQQASeJEcK+/NkHYWRaii1EDyslRbLmW6AkOPckdE6TWEAaakY+Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691801;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UImbUz/VCU+XH/XXsad2fHXO4eDKmX6hwXdewO2lNWI=;
	b=wM9SQUUgIu4+xAqHT8z5G0/xdnEY5EM82A6svMh6Aefzv11ieLhO7tCznEybBfGyRSE6
	 vJE4pNuy8yCZmP1ppyyb57QQcYvQ/x3pDZopiRU4/nM+h11R7Y7fW1MdPFJD8kQkWCXIV
	 qUsgg1TV9+sX9v30iiZNXgJ9ONneHfYNvwwur5lFW29NVXHzVHheOYn/spJT4dDIgiZQh
	 4jCIctgJ92UzDUVWj03u4gNMcUyEghzJdITZAf2x47+79QHjoZGWs4MQxFRk23MsfcZvd
	 yX4sfSRQeSgrlCBDs8URe2Nb7lbqxzxD32y3n3V6uPrjtkHpKu92mkbhGgJnrqaN2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UuIsmguw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SCUSLHeT;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A76F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UuIsmguw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SCUSLHeT
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B1A97A018F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:56:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 13:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792691799; x=1792778199; bh=UImbUz/VCU
	+XH/XXsad2fHXO4eDKmX6hwXdewO2lNWI=; b=UuIsmguwyx0DY9lgvOYoQu16i+
	kIf4mh2XXWGi6vg+wSInhdF5DQTMgxuRlwcphf1uUPPewYNrxOaj85Lh4L69Mh37
	ITFN5eo2/EWJKnQKFM/LFHI4Y2lewuaFKFTO8I0EtEKec+AGS4aj/OG1/x55r/xJ
	vLk9qAq/pwJYhsPmxHX4e9hskqpFpYVRPHsvMkeLOeLCAgc+pwj4jQDauXbVZnN/
	CBRoitNR5gO9Gn9PDsWwKrQJ56cLhnfDmVptpznqSgdDJY7lHQCjPwJUXSrsTH+Q
	1So/wKqYv0nlQ8kAnLSU/+xvnVqiuI1v4nVmZk943/2GC2FoZof/7m8jwwbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792691799; x=1792778199; bh=UImbUz/VCU+XH/XXsad2fHXO4eDKmX6hwXd
	ewO2lNWI=; b=SCUSLHeTuluPYqEWmkSJhKiZ3yVKjUwmz66l+rzWF7PFSP0+FZM
	oysYM8HNG2ndTlTMVIk7V4dlUVQaYjuqVAUg6unyUVUpRW9KcgLBRDD+tXW4PJv1
	TtQX2B0L7S2lPMzaYhKjCf6jrDda2VcGJWNIrtQupiUmzMAcDGxb2ILZGasoEJfN
	suVSupbrxIdBaid885oQ/x7qfkUA+jerzMQj6YW7yWz0nS2IqZ93LiDdX2jmYFbm
	sWd33RmuY7kWKsgY2iprGF/IA2K/C0DurSMeKnF+/fQvbTftExNMhK0JkUNepMo+
	eIYa3VkBL0LH4WpFIkq8qcMvvSVeYj0azuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792691799; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NmE+xbxz+kOpGBkYXCOmh9WDMl0rcvcKU0hVVMxkmbhB4KD
	nFHwQs0zDcC6vKl6Z9Srd2rJnq/KBGGfLWWla/D48BgiFBqNpVakKswwL1nEuGdk
	N896ykZ6PuPSENRZPxLgBZGZ2MggndVgC1kZ5MfbRvWjUwTgVIjp4kUn5pVeWeIM
	RU0ry8iC19+jJsA7ll0rnqDqvT08S37X6wQR4vAWLZQZm2RK3fFq1ZVrJU+vcnGZ
	mcuwKXbDWqBMaWQHWozXvRFD+47B1nBwUAz7f0FtkxzRlumvZHBQEYdHwVJ6gSWu
	xo1roHHifSBnsaera8b0QIIMa9XHIYT8jy5ooig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aMkY6o+HJekKketJftf2k+yGaJV/xPEKhCE17cdE4jY=:93P62ou9FM/J8DMpJdtnyLyWtlUHIT/xldd1XY0DxYs=;
X-ME-Sender: <xms:V07aakIW1GR3RQ32dVk8uqs6YYeZjQk7QMf8YSPkRP0jjTyiDwkr0A>
    <xme:V07aajPBjcki2XTgg2GO27HoQQ0d1-Q-OJwwfMAA0s_itvHOn82n4L5rPdnAiRuaJ
    vYPXyE38nxenCj-go6mqsbHTDER6w_yn_my2KIzzGMmpiXLPizfMcA>
X-ME-Received: <xmr:V07aaq7SfxXbXevINlZSoa-1gAG9aWRLUURvugxp3MrJt7Umh7ouAx02ZYy31Q1KVIAOFqkMfEwjcVJtneaiLO2n73tKe1WWPRiY>
X-ME-Proxy-Cause: dmFkZTEKD6lFowxdDQ4bNFTtCLqDzj7f2olr4gjj7aWxZoGstkhusKzXkB7X35dUuyofgQ
    bhzOARTVF3QXjGT9qzI9jeNw/DD1gvHYUHFDBLNJ91QVe0iqUqWUaqg6eklYhAYJbPf0qZ
    tu1M7PrjvfdxwOBK0VzffMz9TI+YE/ZY3uTFpO+T8dPvYXVPCYKZohyiwTRhv8uY0b2PwV
    fhoP6oYTxj/aRloUVmwwP00q7ezFz/bHrQU5Wd9ViZTxdJu5C2T3iLByNvDXSFzErSKQ2G
    7We3C1sfGNr3LyOfOatKE4EBjEsX2cOgrRAika+Nbp1vZ+MhadvOv0E9jiaF/ntHvn3yjd
    IVzZLc7Bq3qRRNOzxG1bSLCO4B19BCxpxMukLp5rahOp+TP6OZmF9MfZGSLFN/PGIPdBEK
    dTOKwh8KMF0Bi9xaOjk2YYS2MOiRAD9fJITQ8xw46/XZhBByFwS1lCltDfhqaiEWjGPCPk
    3bf/gm4KAM7YZIzhyyfOzfol+PqELPW3cSjUNhWuVlR6RKbIN/i4FAniD0HstuMtKGYRr2
    vmpRVpWkA1AX9nW8OYUMws+4Ha1Ex/IeJz+DP5wCTTDr+DReVdwGE52kacZXVTt8lNomJh
    b5LaTY42zl1Z51B2t/CbXwTAsS90+sWtmE4M6o9kuL8aDvUijSHHI0NftI4Q
X-ME-Proxy: <xmx:V07aat4lBpBJDa6UQGwx_F445SGN89rq6ucbewkbK84PX2V0VZFMMw>
    <xmx:V07aagEiim1AMNWznrPRej4WL63CdaS08hti2r9r-lu1XO4N-ardOw>
    <xmx:V07aalVeAdY0aeoLWW1LN-B2jQKuB8GBkIttxOmwmplKhAdDTvpEyA>
    <xmx:V07aasXYdIiuiArAdhC43Q6-snnJSTtxbX64dOjFDc6LgH3pmchj_Q>
    <xmx:V07aagMTpSkMozvPoEdGx8ycZvfpD876qPT80b0nV2eWGXVf-ain13Bi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 13:56:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: haraldnordgren@gmail.com,  gitgitgadget@gmail.com,  git@vger.kernel.org,
  kristofferhaugsbakk@fastmail.com,  ben.knoble@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <20261022174429.81186-1-me@jaspermayone.com> (Jasper Mayone's
	message of "Thu, 22 Oct 2026 13:44:29 -0400")
References: <CAHwyqnUWab7AhqJtWkPQzw_dh+OwxiZxt2+1TTC-r+VPx+20Tg@mail.gmail.com>
	<20261022174429.81186-1-me@jaspermayone.com>
Date: Thu, 22 Oct 2026 10:56:38 -0700
Message-ID: <xmqqwlr9fwkp.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> Since the value slot holds the pattern, the level needs its own place.
> One shape that keeps each command line simple:
>
>     git branch --delete-merged <pattern>       # strict, as today
>     git branch --delete-integrated <pattern>   # rebased and squashed too
>
> with a config variable if someone wants the middle step of Junio's
> ladder (merged, then rebased, then squashed) as the meaning of
> --delete-integrated.

I like that without configuration.  Simplicity is the ultimate
sophistication ;-).

