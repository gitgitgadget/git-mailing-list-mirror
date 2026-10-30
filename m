Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393544;
	b=jFFzGFDMpxG+Z8Y5ZXP1QZS3eokGsYyaWt3jmViCHuqh/9FKz9W8aZZq9QDWSJ/OA5+U
	 7+6MLXWefSI0+srpUhuVxdkFFeTVZ5ydTgFzKcDZLhFvjCsxlN6Gf8gWG8XtI/g04+hjI
	 2BE3FaQl9Go50hcWele+qTbvQololUhDjIg1pArHs6duwEuxlViWHW4Ltrk2GhWggptV3
	 jS7Y/gL0wrEHPNUjsbsJFatcG9Kq+VvMK+2AJgu8K327hKAdYUh9KedATcJ7pBK0ibCpH
	 UufDlZ05F0cXmXvuqs6FjYOX1swJTHcYmfAtWeJexxwUj2OyTPPpwxuOfxfJFvqI2zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393544;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=FCyJUIEV5zzNUzExDt1Z/BoTWIYIg6xtZGyYHF4Fno0=;
	b=cUKl1tj5NVjVdo68U7d8b3bLVWDqxhG0befBcYxJfggkSsz6z3Oyhwk+JqsfiNdoXAnw
	 F1+TC4t+T1FEwPXBlD7k4z2oPmoe4V2Roz3u0gYtTOdTPZYcljExcyFWEsUz4hQ0YWUh8
	 XTt4CQn8hslrh+E7ZjdGn1ZPq/ydRD7TJF7xqndRU61+bUnX7lIkA2upN809DyuF3UD1Z
	 zQ7Xf9Oaed6T3eK6GwVv1BU3gjxA4va1hAhDEFAcR3M1ckT7cO1XUzh/9eMPdXicQFcLn
	 6QkaiMgci4Y4BA0raN8WJlCeagDIvVBca4OFoqMiLQxXa6NdWSPfTdxX+xm12zmmudw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=KR6JqkAm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QgWw6VMn;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786A606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B786A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=KR6JqkAm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QgWw6VMn
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 256657A00D7
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:52:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 16:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793393542;
	 x=1793479942; bh=FCyJUIEV5zzNUzExDt1Z/BoTWIYIg6xtZGyYHF4Fno0=; b=
	KR6JqkAmJf4IWUvkewyFY0QWrVypi80+WYTI/dkOqCynTd4rdSv3oQaNVIVReI5E
	b/Wy3yrJRR6T+2bhSwPgjF2D50QbSvLEE12JfdYYrwrwKlrr1qkzUxFwRkPUs86S
	kIVSCjG51kDtPRtpkBfBQlZfvaFyeP6zWNgL9mlT3/58gfajzvVzrwA8HtfXs+n/
	hHt9SiTkvqpwbe3hMGDFV0vg3SFHafBIfmYomjJapn/3YDD/vq5CAgya5ix4w5Y/
	mi0foNtnvRbTrbZVjuOKDmyPPAFGRORE/s8zj+1D5WQssRTS5y9c1FHe13rD76jC
	e+Fd6pb52xSFuUhEPbmqMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793393542; x=
	1793479942; bh=FCyJUIEV5zzNUzExDt1Z/BoTWIYIg6xtZGyYHF4Fno0=; b=Q
	gWw6VMnfaGQbFmPOjvDhyeJQ9BGZ0BlhqhLY0P7C3hlQi4/+MRkghxdSzCUdoX1S
	RMxAB80CC7adl9GxNB3m9McWp8AVMP3UkhU4fCjhpEEKEidqYONixYw6RtrThjdp
	tNHUGuaCBr663wQFgbXsvL0DEWqYHXkngd3vM4Ubp5goYvtNk3S3RWHasFkf7jvi
	9XuC28a48dLl62LqnjZ08+ldVM4lRI8TcZirlPhx0ZLhe9h+FV1yDrf0OMk5oRl+
	JEJfBm+NWwNJ0S320LTA9pgjPixwxp2mhylHWf+mapwQEN+gi0iDQPrY9BgxID1w
	UKvBYgK1zgqpiGNWbqy9w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793393542; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DJVFhBUKG3mOLfnTRrjvv518lr9DmCp3MYRdRDhlwuDACGf
	FzEGJzZsrfKvxP6ZQUoXsAgCQ2SEj0uUb+3LumsogKoKOOTyp4BCVamjIGLdoobS
	8ltOop1+yAiM9IRrYPWTKbVoWcHlKacNu7c9avSb46XbtQ51v20LHq7hXj2PzcD+
	BYPE7h9MoqfSy0USBzXjNmPi6XpKrgCkAB6iy5hN106faDuFB1jwjPnZi2PDw0vS
	hGyrzMRBa8hh/956N63q+6aDg4VnwAdVuBFDSxH38AEP++PasGzojJqs9M+/D4eC
	UYggq7IHAPWDDkJHetuSzOU8vWHp5ONV5z91drw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CqrHtwu5QelLyaySAM6uvPM946VxI7JwFW+FeRJrrV8=:vX1xa00ssxpZiYH4sNGhaWzgyWk6qnGz9oOpwWahc5A=;
X-ME-Sender: <xms:hQPlagSBQzEvTnckMljimUpnjHnQawcht9gi2jNh-ijej3hXcbsaGA>
    <xme:hQPlaola5uLjRT_fvLtHv383nBUG4DpLWWVpJqYqvv66A5o9xShEWREzyu99WbCXS
    6p74vgc8cBhHbgq4YR_Mgnre9AoeZ4UqkTs7QmepGFj-NmzkKA6O8jz>
X-ME-Proxy-Cause: dmFkZTFh5dEXcef9CCd8q/pWNGCv7GvT3/utGRIyQuuZDrSFUhhCXhseozcVsiRelK8rDw
    ToS0udqLpoU5MLAjXCS1vnEn64406jIGEyEd5QRzA2IkybBbeLEbFz6XAvURvj9Pkp8ZQM
    3kASjdSlBlu/ii7C77bAayAXBJYTzIxAQflAfsyII+cDyp7L5oke17iwEf111sPPsbzKrd
    cgxvT31laqCvEARBcADqxc8NCz0PFuJEzCcwMpsIjDj1jLvYnVcaQ+awfE8KmktBwt3lzj
    GQwuICf0rAr1OqTX6Ml/EU3VBnlN+lot1mF1NJ5gYmKUXmSdwazOiyJFxByd9d4qQwdHjY
    DxrdHHJ2nhBs6sFI/vI3VQh/EiwKave27h+ATY5BtLHkm6xfjsQGHfhg5LDADwCWD51moi
    38K4QEi6/g8R2/lqBidz/gKGUHJZXM4mkebU/wAlB2DdpyD4BBm5Fxmbx9jpxjzGpb0Jp0
    aDEChJAzH34yA6OqlS6t80yUJ0cJCQsTpCENhU8/AsfOkCj1ZJrxFdw5QhfOxOyirS1ngn
    2MF/ATGIuCAOj/XaPK2OHpRpXKhblmAb0qt0ArIFBmEO9qgHDNthe//q49Io6xuMS3Tkj6
    pj8tzL9dh17UJ7uwXBCG6gCCG9A8hIMA0gOloehExCTB2l3J4e6yodVrFJOA
X-ME-Proxy: <xmx:hQPlaj_UlX42AgRZdiwvyQmgc3sdzqM_Gg0uCqfnp32u9p0UXJ0l8w>
    <xmx:hQPlapBofbJi527SweGMPHHmwYhYmGOPkmxxv3evAqMgi4P95C5J6w>
    <xmx:hQPlaoS0jFYn3SCkRkKAUyqRlEOP-SXaLRDscKXBVFezwSjkzWcUFQ>
    <xmx:hQPlaguT97QKAWwuTk7NkI2ZfkQ0DBZ1xr9xZwgc9T-Qdg6o1W_yEA>
    <xmx:hgPlauZfPGzO8twUBJVZSy4vxkkSn3GoscL8_lov24Znw4g8OR1YVWpO>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95A17782738; Fri, 30 Oct 2026 16:52:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AOKiOg8RUAPV
Date: Fri, 30 Oct 2026 16:52:01 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Tuomas Ahola" <taahol@utu.fi>, "Richard Kerry" <richard.kerry@atos.ai>
Message-Id: <9e07da3c-0e75-41d2-8769-1347b3827ba6@app.fastmail.com>
In-Reply-To: <xmqqh5i5aemi.fsf@gitster.g>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
 <64d9811539b531104d01ae4382c90230eea01c61.1793198687.git.gitgitgadget@gmail.com>
 <xmqqh5i5aemi.fsf@gitster.g>
Subject: Re: [PATCH v4 1/2] doc: remove gittutorial
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 28, 2026, at 2:01 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julia Evans <julia@jvns.ca>
>>
>> The next commit replaces it with a new tutorial.
>>
>> Do this as a remove/add instead of just replacing the file in a single
>> commit to make the patches easier to read on the mailing list, since the
>> existing content isn't being reused.
>>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>>  Documentation/gittutorial.adoc | 671 ---------------------------------
>>  1 file changed, 671 deletions(-)
>>  delete mode 100644 Documentation/gittutorial.adoc
>
> Strictly speaking, this step alone would break "make check-docs"
> because it fails to remove the reference to the removed document
> that is in Documentation/git.adoc file.  To be peanticly correct,
> this step must remove the reference from there, and then the next
> step must add it back, to make sure each and every step of the patch
> series builds and tests correctly.
>
> $ make check-docs
> ...
>     LINT GITLINK git.adoc
> git.adoc:1211: error: gittutorial[7]: link outside of our own docs, 
> shown with 'HERE' below:
> git.adoc:1211:  'linkgit:gittutorial[7]' <-- HERE
>
> I personally am too busy to worry about the "each and every step
> must correctly build and test" rule while flipping 100+ topics in
> 'seen' myself, so I'll update this topic in 'seen' as-is, but if we
> ever need rerolling this series, then we may want to remember
> cleaning it up.

I tried to fix this, but there are quite a few references to the tutorial
(including in `git.adoc`) and removing all of them would
cause some merge conflicts which I believe would cause more
work for you. I can remove them if you think that's best though.

> Having said all that, it seems to me that this version is now in a
> pretty good shape to be merged to 'next'?
>
> Thanks.
