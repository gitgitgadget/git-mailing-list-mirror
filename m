Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415866;
	b=p1eOBapxE22SoVv+BV98rjkWw2ZdixAOmee/NGVeooocpPjEnfsx3qBO6+9qOAhl+eHy
	 ZpfpautOiN/coY6WTEQ6foWbWdjkb4YonLVSUDt74TPWIPhHMrjXph9pcyi/OJtTCD5RO
	 CndOGMzGon2FpwlWiq4/TsIoQvZj6gkUOLKfce679eNd4AuAIVEXBr5m4O3/jSJ7hFRlP
	 0vICRBBF5iTh4ionfeLL9fqyS9pyJIpboXZ5MPFsY/q/tHC3FwmsCmxGMIQf/Iwi8tGWW
	 sWkV6ST1lCO3nIsd1aVNqcoLwcMeTOv06VOqfW0FV+vtKqyFbmUYC7Ij25skzQSuC4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415866;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=BUzWmHKPPk2OYtKW3MJf/RYePMNO23ci1y01+L5T2BQ=;
	b=V/YLcZkNkOcFjlVSgncV1gKTrGxVUg1Jm1v1HU8svmrrNLxdo1w/vpffwtPMJY0cXUG9
	 i/C5JbfkTX/2FjoHFL74C2NM1hRwOu2Yv9eC5f8tcelH/finDgQeqFr+GaF1XOkurYx3K
	 fUmugKNbl51JAQXiTGEDLEexnkXSkXFqt67FrsZ5g4Cm3wwuA9B474KB3vSB0Xq0Wn8NT
	 Wd0Baw+ivIpsOKpSJ1uVfKUDtcFRSi1iYrNkH3X8+ur0moABKeUSq4vXn+K46HrLQ1xtC
	 D6mqnJsFcrbVo18yurKcUEmdOAQR+n0zHf75wmKexvYA/zo4e/3vkF5orI1hnSTmrOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TminRNrw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WFvAcxLh;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D3606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B43D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TminRNrw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WFvAcxLh
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8D3A1400187
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 11:51:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 11:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794415864; x=1794502264; bh=BUzWmHKPPk
	2OYtKW3MJf/RYePMNO23ci1y01+L5T2BQ=; b=TminRNrwX/BINGFeCRTcSBlOLY
	BqUksqrHg5XxxqC0IalTufe2oUUSQmzUQYeQGliIhiu3UpAJ04iS4XJxETNoOgB0
	a3KRQ9/z+IWgLXJMHYcnQGYWo4GDoj1Hq/x29UXqwlhVP5yNxM+WVBBNCshVCADH
	6IktxmyXF6kbeJhE3AOhLKZAuR2udkcOvmAqQfkW4IrK4r7LiuwyJnrCAiVTZTsn
	1vT/PW9sQ4BMfi88XP0nwEnvykxdGqHpXc3kjZlekiQcmJAdzKS0ANPIAxXcT0+B
	5BHBPg2RRmQbMUnChOE7YBPcNRsz1g3Ctj+N0McPUdG5IYu6XzIBW5fPGueQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794415864; x=1794502264; bh=BUzWmHKPPk2OYtKW3MJf/RYePMNO23ci1y0
	1+L5T2BQ=; b=WFvAcxLhDVFq6a+YwC2wyoVVr/vAGqvvVBbcy4qzkM0e8e2wzDO
	qm99IAXhft3g1P15ntxJyN6rzq/wl1S295COwHk2cK2rDFVmEpc8w8cylwdXbYuC
	nHsVwvneESmFWmDNfSwFPX8lBEgMCdaoYGHk7qnbE77R5WEgYmVHjqhFZkzRLxXV
	7rQgNprM7O1Zmkdh0WqFX4EPJMEw6CskcHDZxMTcy8km0101XNc4cA+DZLQcfFzS
	2fnstmISY7mZD9keVBYCl3eVAsGK4MWap81Lz9+TvA13Mh9BR9LiQ5mFe5SZh0PO
	ldtVsYV3YjIX0lEB6BQSpWYF5uovzTqXozQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794415864; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cn5NEhpXeOwHfTOm3LhjjMW6FkEebMnHDg9uBevuuLRLLSO
	Za4/1VoNAKqOb9u05WI6MV7Oab1OJ4eveDK8TQ/TlQeionF+D/wTonR7++8XrQcq
	VCA6bVMuAIovDNXwMZKOud2+SCnnQZacVuljO+4KCeu/ynRgPCVZarrhlanXCz1L
	0Lg10OEhS0P4H4fQqeZYBF5FDUsvYQWNTEh4K0XqDI+nhJfx3Xie0izUA3JEk13z
	fPDj9bfEU5AF+85jBBkd7D4fZFIup1//qgB5Vxpl63yAHSvJHDd7imMLFmeAWvj1
	hUnGENZCt+MK3rivenTiX3ETjxLBCZ7X3QXIvYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KUKeXC1YNhQ08cclZVAyj4iy+3PRY4YHnlJRbqXWxPc=:eu3sNbkuO1l8erKrCV93KWTkGUPaB5PxhP2RcuabTLc=;
X-ME-Sender: <xms:-Jz0alWslgTuoRXH72nmhZVBfGou1hU4tL6bdJG-Z32cVPR7yYdN5Q>
    <xme:-Jz0atC1KZl9bdqc91ql-FqXqp2tQWAYwXWneTAmZfAiLAmhgkzaCjLv6V105mNEK
    z_WOWgxxPMkcbavA6QCcHj7e_qBodrJg1nRmL6zbwxrdqnoSMe3rRw>
X-ME-Received: <xmr:-Jz0auxRWeBuMpZyoKqltuNbQaRV3GYhLzmqEXPBKzcYH6BVf8gqqiqQiwWsPXQc-zDfL75UcVh112-hJ-i49FeyZdkB-soLj4qy>
X-ME-Proxy-Cause: dmFkZTEHGP5q2xWOKF+DYIhayGdzC+roHEuhCfE5cEAgyrBTu1LQ9fWNuJDQ0GKpLW9jkT
    apqsFnEQd2sNzQn9MN7P3FSIYaQ8Ugte0T9Rl6l6ZgBrqQGhBt3D8xJByf/be3aDepg30b
    uUrpsbXl0fNubiIXiZxAgitEgFFFLL/hz2ga87Lyhy5PpS3ktqjGJeZNAdlQX4V/wi7+/b
    ca3YC6awcCcbM6MAEAZpbQZQldLH9BH4VD3qHR+Iq4VfJGxyTofccVSxZXEsaaflA7IvZU
    CAw5NRvQ94jeMFqcvSOdVSDPkzk+KM/WH7e76LI2QGspikYr1sCVnBsFMiay6I8ZdGTeHA
    +UR1k9wdRUxIakyNje8iGMKKaIpYA4s7OweqwY4Jn9/9lr7T2sIHDVQ6DHf2xT4RPYHlEp
    ch85d4wOPU5ww2+1JddM6GoZN1mAzYObgLioqOzTtjf3ewydAM3CIqWHCIlhXm4ATiLfM9
    SVIC/X6c5z79P3RQF9cuhFY5Ecesd7B8S23NF526CciQznj91jMAzRshSq7ng5Z3XxV6sR
    3jbRfo1ff1JuofGY9KcmAcvmEN8eHwYjuHQwGvgL3kVnS4TASSigspUOVUlNqmNmvfUqF1
    6lRP6jFArPhS+HUAwaLRUnbXyJuhtwvf2Junid44APxu5ZHlKgarbEdd287w
X-ME-Proxy: <xmx:-Jz0aiBt_NvWz4d7sLmSOqgWBozFmKODc-h7eD9jxb3WFtQZRFhReQ>
    <xmx:-Jz0ajayZjhuDSaO5AIomB4_RgBFI3Hi_Bp-a2pUlzidPVkWvgwApQ>
    <xmx:-Jz0aijmL3Cf0TmpVbPuLPTno_t7az2yw1dvLGbd_bx1PSmnRWoNhw>
    <xmx:-Jz0at743xeJeMZm5BlpcJkWJJIIs9UTZGQas1BFKxQxgozcJGh74g>
    <xmx:-Jz0ahqgI5G8CwVc8YgrYjeRNl0XwU0D6smgkWO6IvMEzDEwD9-aYdUV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 11:51:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Anders Kaseorg" <andersk@mit.edu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t2401: fix misfiring substitution when path contains w2
In-Reply-To: <20261110-t2401-substitution-v1-1-32f3524f2b92@mit.edu> (Anders
	Kaseorg's message of "Tue, 10 Nov 2026 23:55:58 -0800")
References: <20261110-t2401-substitution-v1-1-32f3524f2b92@mit.edu>
Date: Wed, 11 Nov 2026 08:51:03 -0800
Message-ID: <xmqqjymjnwg8.fsf@gitster.g>
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

"Anders Kaseorg" <andersk@mit.edu> writes:

> -	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
> -	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&

So we used to fabricate a new file by replacing the first substring
"w2" to "w1".  Of course, if that "w2" is not the one we hyave in mind
but came from somewhere before ".../t/trash directory/", it would
not work.  Well spotted.

> +	cp .git/worktrees/w1/gitdir .git/worktrees/w2/gitdir &&

We have created a separate worktree "w1" just next to "w2", so
reusing what its gitdir says would give us the same.  The "correct"
contents of w2/gitdif should point at "w2/.git" (with its full path)
but this "clobbered" file should point at "w1/.git" (which was what
the sed script was trying to do).

Makes sense.

>  	git worktree prune --verbose 2>actual &&
>  	test_i18ngrep "duplicate entry" actual &&
>  	test -d .git/worktrees/w1 &&
>
> ---
> base-commit: da8fb6be5594b4a06ef2cc2ff7a5363a6fac2b5a
> change-id: 20261110-t2401-substitution-3ab4819833a1
>
> Best regards,
> --  
> Anders Kaseorg <andersk@mit.edu>
