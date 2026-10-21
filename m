Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550006;
	b=Gp8mFlxqqUCa4Y6CRMVWKd69P2KTLLeVF64uIoPhGFgAMFJg8lsc9N1Aziatt+T8DRPF
	 LJmkaCfAi3AgyStXxoHwku5q5SALF6wwLBCGhHznn8xMHEN4azBipu8awTEp5GqTz2gQu
	 Sg2sRJ1JbO4Ybtb+pEfaiFPwLFOm9v8nnn+Ph1IjKJ/e+mk26nPfXGoSJULD8JBxeJ7/d
	 Tyhi5gCOPdIRjiXlxKS/IrOC1yr11K2OiNyU2yNTDQRs48RH2OwJx2ivydGhVSx4ysLOz
	 UuFXYVGYI9V7npZUkR4MTYeJb692baizLyqNp5+nByZD/v1Ymfi30uvRqU+60OkSPgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550006;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SFZkvlL8hvymQulXPk5baN2mc2oHL/8+L3VFUY4GP08=;
	b=s/rgaRGvSyY0x2aC888YIqRnHeB5fKYafH2yuGl9OuZhFk1tz4/OWsG+1B/oSQoOEmBK
	 bj6OrhfAu3oG1BqNQ6gdSgO4cxI2O13ygp+GUfYcPMJMLAhgb3H4Fcs2+VNBQRPXC9v5U
	 ZI2KN5sjv+flH3C0XFpQA2Y15YQmXvsiIt0hhI0ut7AMy43Ce/Ec3zQS9cYUeF0Q5e/UV
	 dO69Kgjs/0XEsoAkAVfO/HOLg3pQqJRUCNanlFqTatrQWj8hM0TlVgmcF8QPxjqfeIwFN
	 Nn6FGWmK1cqCJrvBZfkAscmU0nqfqCJ8DBkw/x6C5Amc8XM77NDkVeIHYtCQpOBKo9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=jSYcki5o;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Sp+k9bXx;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9398606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9398606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=jSYcki5o;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Sp+k9bXx
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C821EC01A4
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:33:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 22:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792550004;
	 x=1792636404; bh=SFZkvlL8hvymQulXPk5baN2mc2oHL/8+L3VFUY4GP08=; b=
	jSYcki5oZDJzWW7K1CFsYlTg1ieDespfHtGsKuSzDiMyIc/RR6s/ITALdQDtDu7N
	9lLGMM0xdxDXbeDfAHpHC2HZRIlEuUY0f4BU+9KMsr2XbF4iD8A3O2C7fRHCFHMU
	N/rmHYkV4eHB2BSAohMAsqgZxi5ntxu34SzerJ57z2cVpGzBQ7c9hJm1EKwmJ93p
	QWnywyROtmpyGJ/AkHbpluyvVwclAXjH+WA6HkDcfx9wNm68lndHIHZssOee/hX4
	zMSQjg4VkHkcWiJbNzxSgT9MBUUk08gvxZUmHk69zHbGbmd08Z/dyyItxHML15GR
	uE55W6Fn9LSe5hM187fSaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792550004; x=
	1792636404; bh=SFZkvlL8hvymQulXPk5baN2mc2oHL/8+L3VFUY4GP08=; b=S
	p+k9bXxYgVniYFhbOqXvmq6yxRuQdPX7hIS+UpXzfK9k/Au2hnMGbc7twzG7aNoc
	qs7RZ3/5wJCTBgy/oVBBUbEXbuK1Mb3pRS3LHsBjq/V7uTt/0z4g+ARN5LoyZPln
	Tuy+gfSZFDX17sv+VFx1gHqg+7mrW8lRvmU/Pq/e0VC+MRhN2zX5q/uI30bydNR0
	q1a4VqHH9PG+/QIPETEaqF8oGpPBy/TULnBz+Yh7sc8s4ZYfSkMgKPm2p2XlksEd
	22XWsAvQZeMEs8zcNl+OrsuCu6c5XSTlGBIGVbX1wEHk1ZoBrhCO9YFVpDMj6Pgr
	1KuwpJXfu/1dboXxqOjHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792550004; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KOJOP5Hs2Yk4tEUbcgAx7Sz2qzIsSj9AgfDueMnyfrpZAPQ
	yg7rN6WcZyGufkh2US3fv92CJs3qZDtHg5bDqn+YRMHyeACBm5L/OppNzfDBqEkK
	EwZegVazyuHfLqGLZSgYI0/wE1G7oejnz7qvgH8+bT8uTH+SwkNxuv0vy0Sya4eT
	X/pZK8FrDYSSpz/6OFU69oFIk19CefGWpDj32PCpsMKov6/6CAGRLWEVBIVVj5MI
	PhWLcGoDhEtgaZjkDGJWWaAXYScCVv/4fSemtoA86SFsmu5P+UcgThCudlwv1IIu
	Pcc5smEPKnxzBXX61pEk2Lt/ZBRgS2mJwGDnOGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:lCdng3UtSBO/vsCeeIkTqYsVQwTnuguUuYSCH6eZqcI=:w4iKPnEz6jOgn0UYV4R1xHoChgDhAFbkdodgvzynShk=;
X-ME-Sender: <xms:dCTYah_Eb9h8D9uMZbAnMuF4y4byo-kh_B4g2OVaV8UlCtuIm7B-hw>
    <xme:dCTYatJSMPKq8vu6SYY5sbS42vgl1jQlpP3E0mNypDiXeEHrs93D-wUiM-9N_Qb4M
    IfCE1Dnq3uSNQaeEONamYUFS_ybKYV-ZyMaW6xOP2Dkv5d3q0KvHG8>
X-ME-Received: <xmr:dCTYasb3ETNlHnqshc_OONVeM7OvdnkIF4ZtSUkJvEq7dskj_i3kWpvDHHsea5qvlPziCol0ZfXN0MTYGBD0kUJvrIqXBDBf7_r->
X-ME-Proxy-Cause: dmFkZTG18YxvlyWzhLohS4Yrc+nG23QYTP/+0g4bUYQrPF7BzTSuFYlfz7hpk2sHsbUNyj
    2ikFqdcsB5yvzq26WmrEY53/7NMyZ2iU8QJJMnDBYSDM1vOqFyAk63ZAcywBp+jr20LmW6
    QEScJMg/Jdqlb4GDVSUe52duUgMn3Uuo9uCv5Shr582MWubVgLPl44eWEdxIRaCDy7fCJG
    5e1i8nWYaxaBXlbLZGoaZWFNpfNq8CpiJ4yhr+12F/OjC3C4vAQrUcQ5klxgMYiQ1wAHOB
    vWTlcVcPvxUFt5NYXMwLxi0dIcRYwzNhDh/JrLbxJftzBY3TlBOgl4TJkFUStVflFCpUkZ
    0DNy4F14hR5o0FmyDaNh58Jd5SFddxuLc1Sj9/CaXIwdpC8wNizaQA3TQ6n9bfYvRUCxhg
    PIFJ2JBD4GHDYL5OtPzM8mjuPwemnJL93WOb8AQ0a7XVI5SLlvisM+VrZWYnvw35f4/ni7
    WNHTWM3F9rs8cuSLX9aHkdK+F3uKUNFkWBF1UeYMek5jZzSMKbHLLg4kq5ok2xR+jw/fuy
    k2TCv7PI3JD/uNJJvPFngCtUQbpOaWz2l2W1sedeAYCK++2u5/UMS1lq2FDIIhsdVQ0NE6
    tcfSklWDliZyavsSQMDAV2Gaw5iLD3ej/H4AS79roiVAwsMHpOoLPlPUNsyw
X-ME-Proxy: <xmx:dCTYavLmlOrf_Oh-mDbLfex-qDuGHLr35TqQ9Lw8cb0v-8hEk6U6Wg>
    <xmx:dCTYaqA8XdaUoueylUrAoxjtaUPSNzosIxiDEurJ-euMjQ00SoAGiQ>
    <xmx:dCTYakoRPLi-7gzmsNW1AygorvzKllJuYNwHCHqeye4STZ40wI7X2Q>
    <xmx:dCTYaljiJvMp-gOQ3H-qHtjBWYgq-4vgXjNL_1lUgJM1rr0B83WVXQ>
    <xmx:dCTYapL34Mrbt7yLIqNq2BZFMMhiC1MCw9riY2b1qDWM7GwDL6s0Y4Ca>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 22:33:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: switch/checkout stops halfway when it fails to write tracking
 config
In-Reply-To: <CAP8tz2JNxfOZC1W4gvGSJ-=AzY7iBADj_KtzWb4sawyqjQ0hHw@mail.gmail.com>
	(=?utf-8?B?IuS6leS4iuWPuCIncw==?= message of "Tue, 20 Oct 2026 15:33:51
 +0900")
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
	<xmqq8q3typsg.fsf@gitster.g>
	<CAP8tz2JNxfOZC1W4gvGSJ-=AzY7iBADj_KtzWb4sawyqjQ0hHw@mail.gmail.com>
Date: Tue, 20 Oct 2026 19:33:23 -0700
Message-ID: <xmqqecdjsryk.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

井上司 <inoue.tsukasa.4@gmail.com> writes:

> Thanks for the reply.
>
> I agree with your point. However, implementing full atomicity now would
> be a large change, for two reasons:
>
> - push -u, clone and fetch continue even when writing the tracking config
>   fails, but setup_tracking() calls exit() and aborts the process.
> - For full atomicity, we would need to undo the worktree, the ref and the
>   config. We would also need to handle the die() calls in checkout.
>
> So I propose to make setup_tracking() return an error instead of calling
> exit(), so that switch and checkout can behave like the other callers,
> and to leave full atomicity as a separate topic.

Sounds like a good direction to go.
