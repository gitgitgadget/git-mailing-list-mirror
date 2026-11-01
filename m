Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556784;
	b=uTXihNps/ILM/bs4wabixXB7x8ukcD2HDCrgKDnvPFkKZcl7PPXE0W1mFJuGSP3LOS5W
	 ke0/VzEOyV02kNiE0vxwGEJ5yYTnut3YTHs2AvsrkWUpW4im6xXvs5FJXHHLr5LCujebo
	 x9U0pbH60ZuvyW9Y7aTepPwi4DxHs8V3LE9/YLiqdghSD27JmSSwL68QmX0sV17xDhIYn
	 peaQO54ohllQd6K2yNklKW+BRmHGtrr9l4IRh0ifbCmSGEqDnJVJsLBa1w1E5wtsjXftW
	 OJ7mokDTCP3f/qlo61VqwtE0zgyhctyj/5RnvzODN+RdzKxwMgqVwfzC/FbfTlYj8Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556784;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zDqLArkgavOwKqT89UvhKM9gklUkeohBcvVErUGA7JM=;
	b=tR1THHhy+z/TsNnY3nERmWDzAcaeRyXoqVwMjvRn0/nwtILZspLLHuZIOVt7+kDUvyZL
	 q0Hm9NVLQ1vBbl2GUrdN6l1tFyCq1KD8UbiVnHpQmwLXZMSLkLnmO0MgWQPYSJL3DKgRV
	 afhpfqOIkd10JTj3jE36/Tz//nQvUZbtUEGFs2twS3quSMHa7JLv2JnBAl//duP5hrCvM
	 I7Nc++II7gVrMrgttyNBy9ixeklBzEep4S2G27p1NhkTPFg0kY7Ip0A3qi78nS3wtqadq
	 7jxCJF5dF3qt5gpRkV/LCEjKiQ+XGWh/1Ji7wmOvRc1yXZyQ5KlbkiSjtu0g4Zj/qHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=c4R475PY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EvQ4BNJx;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA463606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 18:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA463606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=c4R475PY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EvQ4BNJx
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1C921400199
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 13:13:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 13:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793556782; x=1793643182; bh=zDqLArkgav
	OwKqT89UvhKM9gklUkeohBcvVErUGA7JM=; b=c4R475PYa+V0wHAWvd4+Fc/wRP
	Wy1DFqPn26hxrgejhX2h6qVjcJPlUo6qPzsmRYT3NDvc0u0vMsPfvN3i967aYKkd
	td7xvE1PmqyMlqvwHrlsDVmWa+QttHrgQwIu/9DYZAhEBX1ih0p4HN6550MsF5ue
	dGQ1ctC4xlVH4So4PBRiAhDrM9TSdOp5jC3rQ1Ys31G34YIEgru8Hs2A3jO8BOcD
	0Tk/o/Fhx073JSkrH/h4nhTW5UMmk/n6aYLh/1iXO/ChX4GLyUEJcW4tq9NP+io9
	x0Mp+ozDbpOzo7ODKVVSi6lng4BmRSRKWT0b4/BRS44b2Z9d1JkYrUId+jAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793556782; x=1793643182; bh=zDqLArkgavOwKqT89UvhKM9gklUkeohBcvV
	ErUGA7JM=; b=EvQ4BNJxdbJ0eGgM+lpmLsUpyBFBGmm+3wv5tS9dPemdL6+EJCX
	ev1nP/xFXq8PWHviLzenPm9ieoPYHITORwBpgV/wDyqKAI3qQ17FOAlGxfBdHAJb
	XsSMjFnlKsDHJbsSt7ZZX4RyBJgPZKYE0jWq/gO8itXny4hkT0ejvnjiUd/EvuDN
	ZhkoeRdy+XIo0Xa50SLK8Xgf5L/gshz2GIh7Lq7dWdaGrg7qnC9nleS3wq7HEIGs
	bWNJ3AKZIUynF8Lfdh43YNWFI/HN3t7w/uDk8NRpsh0yHrzOtasBrDP0LY8Dx+3S
	FZ7D+k5+VTnmXvP94AOp9WEcK7pknhiVqkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793556782; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gs384KbayrxzI7XFqVApHwTtJalEVhdiRokB/H+Cf/NLpty
	L7bsUF52l8Cyas97k4N4g4IDOOqE3ARbJa+X4sfdl/d4qQN9lx/+U8L+Cc9F0CtC
	1ILwzUlcw+b+blon9KAhcCx3zbvD9BLZtA20sdrKKWxXnO/OIiiL/xFtBhH5wKjm
	LhYYsB+OYQnaoY8ebSO4SRg/5yjiU0vh7HGTDDaVlPEhFiqMN0gqG5ejRIsSgT35
	rXlKGHpCy3JFab9OnY1INs6ovtxq4qrfmcQ4mLmMu3S9KL1eFqd6/1qBMBk7VGTD
	kS7oVheDKOZHKif+075RiS7Asfx3IqwQjEdskNw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mFnMVaGNDY7kvS7b9VIKuExSpkecgOJVn9KLxrk0900=:ipiQkQlGcPO9rEIvSWcjx00nfIBZ2R9Z/8N15i2HcIA=;
X-ME-Sender: <xms:LoHnajkx-UsqF8cKVAEE-J3sgDjdjxvxUCx8LA1CQZVKHFfIQAdUZw>
    <xme:LoHnatsRDCXSmytU3-SP9qcuvUvOuVR3gTiA7ynKkIWVoSEtq9WcmBbBGb3-1q4yw
    ypWzQvlSpQYXt5IyuyQwRZGJr9Ld11Op6dx9ymDwdeNNh79oudxVBU>
X-ME-Received: <xmr:LoHnah_vJKEmqoIeJEfcka31JzzwB9Gj6ad6Weqo3nxk35g8X_xJE1jhrzwIpfzsrZUY5hCt05XziMz7d9B3mr4F4yovfggKj4y1>
X-ME-Proxy-Cause: dmFkZTFZfW9HwwWSPtxnn3twb4eaNRPfL0zh0IIkVvkzP47H8rbyIhZliwgxm15PalyLO1
    klSSNdDns1hFfuhC9ErnZq34C75i/sbX3IVFY0tw3NTGFrf4lytAwWPpOpH8Fd7IdGotD9
    reaa1RGmYYsE4f5PG4V58iNH1Di2rjx8pr1EH9vCFFuzjp5KxNh31S+8qe1fm7nH0XGl4j
    X6WjqPcqJ+qmB99y4/zyZMETT9SIaEsYh1mwvL9nYMfjP64p6vxiDEwIw3RHn6d3ElTvaV
    rYgkQUlNekllPsNt8ap1DLYo+VaVYcZ8q/iis/mMXpU6A1a5Ir3AUsG0z4JZ+l/gaH+WUZ
    yALxOg65SabeAJ5SpfOGaO7R6YuvcsQgjS3TMpxQ6L10EsPQJvqV478K4vd+qSp91aJ8qL
    ZaVaKM4ipXgcDSff/cZ+G5PPowEHGAHJFSSLmOtZU255nMksm3GTgyOy2Tm3FMgW/iYI51
    QzelD8FG5R6UWdNi+nunwVq49LYPxqWF5Tt03vDv8YoftOLV4sbbnC4e/eDL2IenBNx5MM
    ZTb+Ztga9Klkla0gyJXLFs8/9s9gfHOK5Yit5N1Gvr69wHzQF26ESfl2m9CbQBc6ClXEpq
    45LGPq0tyNVLA0j2adxafThCw3FhfsAv04jQnVxsGFroxBbzAM9czkzqJovg
X-ME-Proxy: <xmx:LoHnanPUxKNGzauDJeRhxpb4bzfgsXSqYqETHR9jk_vPN3P0aEMyEQ>
    <xmx:LoHnavGDx1qNfomX-Do24jcJYpOiozzcQdceIMt74f29PyayGuTQbw>
    <xmx:LoHnalQNpouWvsM046kA2wFawXf04UWJkEzRxrIT5tZu3TYolyZdDQ>
    <xmx:LoHnastsVh26xQjWhLuKGAy9MYR8Vg6pKyuGnRFHpr-Syn6rrG778A>
    <xmx:LoHnagqdwcZnPTkR-CzY0Ok5vuaR0YyPx5PrwMytEyk8iYcC5StZMM6a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 13:13:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Linus Torvalds <torvalds@kernel.org>,  <git@vger.kernel.org>,  Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
In-Reply-To: <20261101094653.NKAEk%taahol@utu.fi> (Tuomas Ahola's message of
	"Sun, 1 Nov 2026 11:46:53 +0200")
References: <20261031065525.19883-2-torvalds@kernel.org>
	<20261031123149.yxap3%taahol@utu.fi> <xmqqa4nt2wch.fsf@gitster.g>
	<20261101094653.NKAEk%taahol@utu.fi>
Date: Sun, 01 Nov 2026 10:12:59 -0800
Message-ID: <xmqq5wyg1kus.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Hmm, only in Bash---something I forgot to test.  This of course fails properly:
>
> 	$ make -C t/ SHELL=bash t6120-describe.sh 

It is more like "we must not use anything that relies on
test_when_finished in a subshell in any shell, and we wanted to
detect such mistaken use of test_config and its friends, but that
unfortunately was something we couldn't do portably".  It would be
great if you can make the check available to other shells ;-) but
that would be a completely separate topic.

In any case, let's pick up this patch and move it forward.

Thanks, all.
