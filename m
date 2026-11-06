Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996212;
	b=vIgVB5lnH2tc9MBFh00DppHtuJxfkBKeLo/qFKl+3grq0BOhGH+wNmMlL3DNhAgj6+bS
	 0OzcLVxz+VaifPFnfiWo5836KPIbTnkJGj6au0uZeXfw/XmUSkm96S+01InJnewortbxJ
	 7lQUr6FKHYD3U+6pFYLmeAIhTmMX0bo7EvNZd3VMe0ke/0Y/iXY70JwnDOPn+905rfWkt
	 snaeZ3LjsS4Lo6ciCLZ0LhJckECnVZ5HsuJXgvooMS3wm/21gy4uT9jk2D1jN6I64wtGa
	 zjrRYXzfHCokmSWRIjq+0hHl4tT+o8Rntemk4m+nhwP58HdTeO08zHZ5iNJw3qBTWkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996212;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tT8VbCFUBmkTjzPTGrwO7Mq5AzdnAks0O1jOledUx3E=;
	b=ZgEAImLz9bBkem1mqb2/hRnSY51y2/1TnHJYRvEMqte4p87Z3gYCZ95rvLVY7Hj046iI
	 3eg9ITxClqxx7Bw9abaT3hfd6DMMQDurp9mJYVG8nmqXhnYmtxKmhAdiZQvNfO8lX/2aH
	 7YoiR6o2ctz0cmftHhAJLaclEC4LBekfzfnKEWj//1bv0Xy/wpwng7BXcP1yK0DeK/vsJ
	 xBA08cq6WEa7ZJPxh1HIh9UxqFhQsSPiPvL92qM4tlQmjBEFVRiGD4B1Jwm88eLxKo5nD
	 3NiiBOebLlCQIa0waZ0OmlARtrb13muZ+JN65nejTBS7YzzE6qYKic5S41mPByWTuJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hIriJGiz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N14lwrhu;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75483606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75483606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hIriJGiz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N14lwrhu
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C014EEC008E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:16:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 06 Nov 2026 15:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793996210; x=1794082610; bh=tT8VbCFUBm
	kTjzPTGrwO7Mq5AzdnAks0O1jOledUx3E=; b=hIriJGizeYfUsK5n399EZWf+aK
	0LlPpu6i04S74fAN5wOsb6q/CdMjBKZ086p+FPUUASxcZrlcPZ6a419rf0A0vNoT
	tFPB6aq42APEHHsNaIQ846QWfFV0oVoud7OutS5GwMplkpWY3TokUfesJLknng3/
	aeNtjsbHCu4nW471WbJWQZJSKvfiuoeh3LyURoeiobXyoJ2vLKtHgyQ2UMxEQTTK
	D3F96HOQDJ+TGXDYFdoDWQANujx454Y01gstZ5ThdbZ96SiXw2SAYNqF/YyDivih
	WcTgUZ7vRCYJrrpdIU00WXRpc0f3MOF0z4ssPtl6I+Bn7FMIgI2mD2ZxJ1Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793996210; x=1794082610; bh=tT8VbCFUBmkTjzPTGrwO7Mq5AzdnAks0O1j
	OledUx3E=; b=N14lwrhu9MgNud8L6F6xBOXexDmjbxuLftQgBIidg97uqGPCU5o
	j9WApWVkMntN7L8sTDDKuKxF9Ei8D0U2dmcdGeZ1IGpwGxV+7M3g+wLHydkj6FSA
	i0SPOKNm8ty/KMnOK7+r0a9fS05lNndtKYo273i+0CZJJVTye6Oc9Pwss+aEt5mK
	RCTGyt1PPPS9X6oXS3dwDmP1ogljWRmuA/FRGKC0KyEWvXtAjLGqVbBvFKEsKYcK
	8nFd6Qhptvw9+b4hz6lzKBIOPwn93Is3FtgjhZjbl+sa1zW9mhIC5PYWfYZIcahU
	ikbL0yvE8hPs6ncsY6aM+gHAQsvsAFf0W1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793996210; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QyC4Q3ubC1/F/66SLHEEhz6sdJ/3eE6hy0G1yQlsCLXwMER
	0Lt8Ua2KJHs7OlB1eZfyPywQ/Nd/adM4IemClulY/pozxuOibp+O/nBer82Pw5YN
	7WiE0VvWaE9KyuTV+2+I7iXutg6iZWyULXQNNAXtoLAjth2YisSTuwsfwy7tQpzZ
	ojPLKoczlRxth9aApLr3tbd7CyHJPou4pt4FOGzXVkm9YkkjHdJZfiDb76cMOMwF
	V7RB9kZCX5gTJobv70BhtD9IaDUQyNk32VIaUbIXSxlLFCNyp1bfSWNbJ8vwwUbX
	D6n/HsLrnZI+TJDYoC5j7oaZNB6J5lzNaE7QsvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aGUkkZaIxfTQVAICZk7eUpPQZ4QsLrYDyKVp4rKZ9xA=:xJPH1lUS7ozSFjcttDqXaY0xd0cmGu/ysPlMUqthKNA=;
X-ME-Sender: <xms:sjXuamgecvEtVY3EMAj1XwuDkQWrVHXzHnEloarOc8pye83yPg287w>
    <xme:sjXuapRmlotzhSz3zQtaOe8dAGRNtaOWynzyNRi7V_SBRwiG7h7TSt-WMG55JNCaU
    ySs1bO4vRkHI1xzPTLQNmjhU-OQy-TD6V0J6hHFHilNg_e1bmw4Dw>
X-ME-Received: <xmr:sjXuagWB5mKc4fj-Ftg0DF4L7xhDqyO5nHdc05bkVcALt0jqOTtmAze3BeaSRTHTqoMuLVuIwrG_ymdZfnXLivCgkK4BSomNrrtl>
X-ME-Proxy-Cause: dmFkZTGnDsq1nUPWDB3VwWS+bTlTsWOlb2VR52wQyUsgCw0qMrI+u2q40ttVHqlldSVoJt
    lmb5ymln2pmLjhNY/aUAF083Ua2xFtl53JvJ8bGdB4hDiEKDUSlpkv+3A2JS5tAh1jnufP
    Bxc0Su/5IslQ/ghu8qu8BOJ38DBeImTKkwebRAriq0q8y7mKLE+AaEsNy7KaG9LxOyimj3
    GpLZiAQx5hcnwavvn9l6IuXYFv26wnne8sAnFs43aqYLD5DC+vPGaCW9h1uXhxdr74z/fo
    pUH/0q7ry78hN8mM+CfjfHegcpjJRrMMSi1hCV7xVtAagjng+LKnLLc86Dy8be9ynA0RBB
    0tues2x0fr37J7UredFX5+o1GXG0Kv4VNJ3GFe6vUj4jMWWNt+l3lWKrWaJBM3bHgyfDj7
    MmGOm/vOEfzQ903HY6+JBZxN+YTVZKivDDlN1tU72oMgyXGhCdN1kOB0Kpq+pCMh4cnZwO
    1ig9cFxDbx7UuqH/lVR4/cWi7sloXEROWjWFMZSDE+bn+4xwJ9mzO3JFhvJ7PGCoAY3W3i
    V/CK+kopVOSLgcHv3H9AsIOUstd9A2wjtRF0fgFeEpBhiLf4ZR/B+qxEPfujK5inDaUl83
    NFOsSNn3eFUtLAgmqUfjVSYNKpD6eTflgg0GxN5DbotT69HjVK15hpsKdz+Q
X-ME-Proxy: <xmx:sjXualTbWgm7dkT3CrwXaZvF2TOJuRJrdJjQ8WDRHQJpKlKyHtrZpA>
    <xmx:sjXuaimv4e06hf1JGXPiCVrvOe2_keJ35SfXF7PVNexvhH44S5s8Zg>
    <xmx:sjXuaj7Kj2a5QYPHPPWiJFBc4e_U0e38HDn-RtI5EW2jar6qSLaFlQ>
    <xmx:sjXuaggs74O3vEzHf91nl-kzheuLBXusfPhcfPCdXNUsOZf71jrxxg>
    <xmx:sjXuagSbTAM9vYLaeZohTCp1ZJ676nl_8a99DnTXLIB8rw3zGPmoQA_q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 15:16:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alejandro Colomar <alx+git@kernel.org>
Cc: Ben Knoble <ben.knoble@gmail.com>,  git@vger.kernel.org,  Andy
 Shevchenko <andy@kernel.org>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
In-Reply-To: <au4rmQRjRtIv1Oru@debian> (Alejandro Colomar's message of "Fri, 6
	Nov 2026 20:36:31 +0100")
References: <au3lu4jYwZ5hBZSy@devuan>
	<AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>
	<au4rmQRjRtIv1Oru@debian>
Date: Fri, 06 Nov 2026 12:16:48 -0800
Message-ID: <xmqqeccxhg0f.fsf@gitster.g>
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

Alejandro Colomar <alx+git@kernel.org> writes:

>> > With -z it becomes a bit tedious:
>> > 
>> >    $ git ls-files -z --format='%(objectmode) %(path)' \
>> >    | grep -zv ^120000 \
>> >    | sed -z 's/^.* //' \
>> >    | grep -z '\.[ch]$' \
>> >    | xargs -0 grepc creat;

Shouldn't the grep|sed|grep be doable with a single sed invocation?

>> > I expect git-ls-files(1) could make this much simpler, though:
>> > 
>> >    $ git ls-files --type f \
>> >    | grep '\.[ch]$' \
>> >    | xargs grepc creat;

Not really.  Why is "--type" have to be so special?  What would the
next person ask for?  --size?

The "ls-files" plumbing command is designed as a component to build
your own pipeline with.  Don't throw in random unrelated features to
it.  In the longer run, it is not a good substitute for improving
the skill to construct a good pipeline.

Learn the tools available to you that you already have heard of, so
that you can make better uses of them (in this case "sed").  If you
squash the grep|sed|grep pipeline into a single sed

    git ls-files -z -s "*.[ch]" |
    sed -z -n -e '/^120000/d' -e '/^.* 0	/s///p' |
    xargs -r -0 ls -ld

the result does not look too bad.

One unrelated tip for better readability is to end, not begin, your
lines with the "|" pipe characters.  That way you do not have to
sprinkle so many unsightly backslashes ;-).

HTH.
