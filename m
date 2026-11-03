Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738338;
	b=AUwtg44dEx8PB/7qZoaGbb8Pa/UZX3DIj2qk+SLmJ4PZ1C9yA3SfMS8/So7jxQG4YwWt
	 I3i2SWXf4NOjXoMY0O7kndWobNxzjDbLbrTzWXOe8xV3kU8y0i3RumRmPDT2R7a/UIbt8
	 0YRv7FcMa8UotQrxAUp+c1XDpE82++VJA5sjGiF680RrxmynC4bp/Fm4dxLSuGlH8wimH
	 RPEaA5LSYydn0KHrzuRCt2u8EqSXt5t1TUd/IWPOC2asAcBrJObKnFyDwJ5aCy8zBkZX+
	 05eOKBd/Ypee2juYfYuKLo/hjE8D9O7jWkAx6KYtlDGue9oKt4D9cXW2ybnEKWyjqsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738338;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0QDewXXrgeLN9agI6YKcvjaYsBRk8hKmN5yKvVlpvxc=;
	b=XXGQqdaiD/XuRuTmXQmwXMp3XZmRPTT8F70+oOymQdbDjuVyINJ0e1Knto4m+VE3GNtW
	 wOaPrRPBUHTatCnHci1niKKPOQYAOTHM72dyqBscwKM9978s+1ltH7+5TnetEs8dwC+lB
	 rUSd2Lt/lBP0jTdDR1emzKFWiKLxUawMTMMNJndIAUl5ROeDJYkuoRG4x05jnUoFC5+If
	 zNuTY1nw777PvScuqiZY7IOlXbkpxB5FU92q4Xqz6id1dZEK0xRx/KjHF64jXtKtI18+F
	 vPkwV/JPdjYThdqeJGESEC0PQorLw8vH3O8G5ymIJmB9MdrHY56xht104j1HA0MqIhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CasCt9FA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=26i7Th5r;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23092606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 20:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23092606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CasCt9FA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=26i7Th5r
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 320B9EC07F3
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:38:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 15:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793738335; x=1793824735; bh=0QDewXXrge
	LN9agI6YKcvjaYsBRk8hKmN5yKvVlpvxc=; b=CasCt9FAFFY6djf2tpqWR4PZp2
	E98kzu4RHoyumI3D0ksg9a6rffDdWRHuGoiyZYER4xEwzHrsUTh2kAbph5dn7Y3F
	obIIUms4jSUDpNVpyc58TzbJzqSPWUq/l5kvR5Ra/3LIzElr1vLs1RNDM4hJf4xv
	dcQy13Dl8X1BkJ+Ntj2QAsEym7lGBO+qKNIT/dT6oOy7Bc+QInGl2GM7gVDCC+z+
	bAVqR0WXODBUlhlVszUDX2gE1M7zsesN3T9MW3uYf1VDvf98RhrpuO8SbGDmLtjV
	3TU+n2DRt8viXdwYw3CQa9VqS/RrgSnjLqH45AEsIvkN4ULwnFLLq9tYioPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793738335; x=1793824735; bh=0QDewXXrgeLN9agI6YKcvjaYsBRk8hKmN5y
	KvVlpvxc=; b=26i7Th5r5MXm+pwbmNIDaqTTre++yfgvWB0lzp8hsjpFvi0hVAY
	ICuVWpBo7v+hEl/DakV4XRn1LGYyzT4V3MTeCRu6gqsNqNJJ5ySB8w55jxC4vzM5
	mF0Wv/P0Ddis/65QzlqNvkjp40JS7+IfZqyCO2brPTopqcedihOeYCGdWA0Qnei4
	MGd2ITRlL4gMTKtJPlwohd/WC/fmzJW+miIbfhP87ID6Karxtha5fcwXhBgIddV1
	fc9od+bBaUfATbloxJ6Tkmwc3YmWO1i2T5WGJZSreopu6Yi6ReClLjoukVUWvsKP
	OCm7kMbjWwgYEH2YFNmz8/dXjGldpW5ZiHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793738335; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SWHfST4LEZw2qsYZs9AQeZhic09H1F5NfrbNqo6MH/PzUrQ
	KK4hUbdyjinxZYWzVM7BPccsHINst8Giz+788xeGckKNOfTEawO6synUiKOKgN+J
	fhAXPgBBuCoEMJ5EGxClWDt40CvCBADo4xOt2CYR6tW6Dz8y9HphCMv+zkjwAp3G
	OSo+lqIfoIRB0HHsGUh7tCZSc/y2Vi6TVwZctYPi0niSGdEOcRXBaLtAtQ+jD0j8
	CDQtQ/b+sHe49FTVwyxON5pDd7Wwssdfmkk/yD8d3ioq3UOyLkczzADj7T/zZ6vq
	DHjJS+Byp2rmH5V+7pk8xXT2vrM1T11vx6jtvEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ah7gDWwbzIgRDbKOnujrYXbjIJagx+5Y9TgkGbPwnko=:540nnmf7STJZfpJTkUWraNhf7jl1nYO9ugDtK7I3Zqs=;
X-ME-Sender: <xms:X0bqagMiNwtEp3bpyu_u5f9DcMp6dFTEuiuGFw74_MvW6OGgHPQCNg>
    <xme:X0bqauYknvVwj3FzsfXH7MBtkFBRlC0JNPgFDuymox7MgcC-rsE_8ekB2tidZTZZK
    I1ngdMlAoR5pd5V6G_ICBVJxn9dRB3vsyi9jisdQZmHxXHZ9WTJJy4>
X-ME-Received: <xmr:X0bqakpiAlYv6HCHBpvUrcxQuhJcHMrkp6ATZH3uAVjDxYqe-BtSWRT3FuiWKVVNR-AqWBFCaAbnQfdpBPLgj6g9UNak8SlB8csp>
X-ME-Proxy-Cause: dmFkZTEyPFnzIxvyn3JCI+Xgd5bjgIK9a6Y7XEvdhelGSqkQ1W7/PB0uW7f+J8IyetWAWi
    +NpTzb4iisn3zD4rpXFWwmvQp6l6FCvJzK7PGtAlbf/vSEYbeLduHbQ1EdpQHtKTVVUif8
    MEzWSxsL3tHVljX99uwpOU3U5ZeQrTAprBaduFwV1BIk6g5PSIr2A5AnxW3eRy5pdIoGKO
    0nnGnuPuPUbnTLdJr3qpQmu0bSXW28ftnpmOerDhzvfruKcJQWJC5agcfLNoZeAVpizZIa
    x10De9DeiPQ0ilvS4wQt3tp+Kd17V5IRL5wD0cNx/WrlEP7ir9BXx/LeINFOv4S15k0LdK
    3/KidpuRrP8Y4o1fAmnmWYsOej79C6JZjOber5hz81vQeyzkeQ6Mz9mC/cWXCHInDKYGLO
    RL0ZFFLsAFxHm9mIv2UZkrCug1Aiblo4B0VbxxNEwcT5FUAw/ZRbWAWJjFxezK06dHb/fb
    WvLlQBx3a6Ylzw5Z9nzyswZkdZYmOKbPEBJdCssD8B8eueDiwgeUQYcHSmdbRH/Ay/VXc5
    zc+gOcBaIpx3VwcY/sB8fi/dKJM6pbn7JVCx/Yu4A2SBdBRp86OFF+q9AwSvSCTkPkWDnN
    Hsa/b+8r5KTscf5JwXC+fukXy+PuGirf6N6v5cUREwBn2gHf9B+nTlRXCr+A
X-ME-Proxy: <xmx:X0bqaibZVHRf3n1v311QyLIe-u3anQ2a7UTQGjt8BbE6tlROEpMyWQ>
    <xmx:X0bqasQUolAfYUeDYX3zumqerw4Zk2CAaJvERyYBZYlOJ7AiQ0OPuA>
    <xmx:X0bqap5w7BoTFBvXuEBe2pmMMWbt-OvVLQehcpakFrRTmgDd3_xMXg>
    <xmx:X0bqahzxVCel0kaIfZf6ldQKLc9inoYR829nV4T2Iz3NWuwG_aCDng>
    <xmx:X0bqauj9u2iwOzxX8CDhKgqpnR7f0egrF4Pub48wW8IWTtFPYJMzPUrL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 15:38:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: Interaction between pre-commit hook and git commit <pathspec>
In-Reply-To: <de4f4f35-500f-4d82-acfd-ca601444f2d2@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 03 Nov 2026 21:13:37 +0100")
References: <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
	<de4f4f35-500f-4d82-acfd-ca601444f2d2@app.fastmail.com>
Date: Tue, 03 Nov 2026 12:38:53 -0800
Message-ID: <xmqqmrrp646a.fsf@gitster.g>
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

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Reading githooks documentation for pre-commit. To me it reads like
> the use case is validation/checking, not any mutation.

Yes, the hook was written exactly for validation, to preempt an
undesirable commit from being created.

We might want to do two things:

(1) clarify the documentation to say that the hook should not try
    mutation, and

(2) detect and error out when the hook does try to make any
    mutation.

I am not sure if (2) is feasible, though.

Thanks.


