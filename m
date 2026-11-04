Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817063;
	b=ZmcftiOgmBxPuDcGezDAwtUis8i3V9w5g9ZkXiS5el75jfkwIODOpZFzv9C2egl/ZnOn
	 qIOHmd6s2Q2Qva3d3jSVT+XlDfQcQAn5h9dcKRqm3CZTmmyqYvbW2+5/7e7Yi/GrNxX8+
	 vXqkcvficHsW5FlYN93OpZ3McocaYoOW8nM/h89vJWoEVlLlSxrGKRyjSvNk78A10ZlC9
	 hVLaVyO/ApLE/NoulK3tiC29EsGxGEEJKhKPAnnGQCBahcEsQxzl1S2B/Zy7w1CC2qrTL
	 d3A0IzSaRLXpq5hYtfONztr+NpY1lzPdlEASzR1SDqx+oZWowkYtU3DQSLdfX5fuD9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817063;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=n1zlz1QAWidqRwdA2vFmUEoSuS1i9Ge4GMiZ81m9dKs=;
	b=OtpIXP2HwQ7Shc8ctrOaK/EV0g7gjLgclTLtikymjTDzqW+fFieDLSpHAFEAytUaE4fq
	 J/CrNhT3zQnr+XHOmA8Ykij2TpmwMpVvGSBYyLKU8YSQdKMLCoZE0aRwgaMfzg4KVDLO9
	 Fx1Y1aZrU2ripuMsfq0MjHqjVcrP21K9ZG0IOvlmHvAr+dqKjL3ia/tdPJeT/VQV3Uy+u
	 zsdHzF9/CF/NVYRgmC2omoT52UjigfAdSyFX1j7jE/zv5iYi7tGaT+Bd0KLapm+V3Vb8M
	 0qum5M1usImRUQSP7dj24LneGakPNXZ2XVZgfhWnbhvzZB7JWZKfCS1bFUMXD+YGjEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FMxIe5fs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WrOe0o1l;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA4606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0CA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FMxIe5fs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WrOe0o1l
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 214CAEC200A
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:31:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Nov 2026 13:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793817062; x=1793903462; bh=n1zlz1QAWi
	dqRwdA2vFmUEoSuS1i9Ge4GMiZ81m9dKs=; b=FMxIe5fsE2Ek8XotyqiMpU3QoP
	jvfe4HAVn9wDO2QaKeqNVzY/Ob2ICoxOxFDg1dm51GU0FR6U9nmWARVG7EAjW0Wv
	4qt8882qFJywLNJRurpoy+eVaTwYFfrCsBPAKGT6DeK0ClZTqTo9xlJlsxbDxK7F
	CugTrUxVEtC9sYFH6J7aXpfGL1oiWPkkFEXu7EneuXCUzAEY6y4yBJZPxVcA/NW/
	I6nU430TiOJTTKKXP84ljx9KJa3IXaewJ+XNE/8H2xHmCwm6/q37sRmD+cV+UA2a
	B6yHTI4ZJ+LgEC2tuIRPWJCXyIQarrYQnj2Xjz+X3Erdmxrmr4lSs8ioAKQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793817062; x=1793903462; bh=n1zlz1QAWidqRwdA2vFmUEoSuS1i9Ge4GMi
	Z81m9dKs=; b=WrOe0o1lUBtWs7y+1S6Wq5ZdOwzSXMTgPioj43wcnU0tu3WBZ1M
	iHW+1KWNUuDniLtdRJQY9mScx/j/TOKkLj3DQDkwRpcQaX1L1zHiksHxyYxTEE5f
	ph9sTiszDU1YDU8QkxzfVuNtZ6DFFfL7VTnTVXB6f5LD1gu5dD5gH9wEA8BarvyE
	0phIqMxz/sL2fBy5yCU+IWfQrgrq6hVXkrgTkkrHvFCwvrnqUHjBW9C3Uml9mnfp
	aracHFZaOKfkIgPzo3GrU3aNmSkfayeB5ifbWNaM9MF8VHY+kjLRU5Y6Vm2voTHz
	majzioMMLxIa5xzDYQHAQu0hsh030YOODew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793817062; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VuBvhUJq9hahNVwuQJCQ6z/20qX2TMp2t7U1I61YtDYIQ1X
	AyLty49CfI9Tp+4d7vlNyT8f3jF219ODOsh5m2aI1/3J3/pAgs56joO/uONHqydC
	AtZulUlHnkpZVOqFz3eXhi+CVotzHrcLmL3apFb3hpn3HN1E6G8reRl5Xj6JJbOX
	TA3FVWUT4KBKuHBRbpOW6n/RzWiOrNR2c7K3ltOiFe5YRQMLecwOkJumr1NQ9sIQ
	HB0BT/1lzfpdexS5nVlsul42nUsKQ0SfmT8UM/P3mrPUF/VuQxLVauI/lcNnRVhL
	qka7WVJgrPunp5ZH0xjR3Ud32JXF7inZPlolQKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8BULtOfyhR9QgUx2jGuKXfCkfcLZwS+VqSIxcgz2cLg=:RxWzZFB0y5A4RCX1A1EIB+TLD3ClEjJvDGU+V2/7wHI=;
X-ME-Sender: <xms:5nnraiZ3UjdreYF8kl6aB9A9sSCwqGVI_80hzGMGDQjp48WPn0B2sA>
    <xme:5nnrasTFXYtTA73pj4kx4yZ95TnnWgAKcYUZkmdyRhn8q8_WV899pniIg6AK7q4GL
    OVnepBHu7xW3Misw10DNwdBl1gPwEqGuOL-lWFXhL-JYz8dEyiitQ>
X-ME-Received: <xmr:5nnralTfXYJd6e40tdskN0n1l5w-8w4iXDSituHrnaBb169S8p-OquQ94Cr5hYiscizSou5mZn3FCX7aTuR3YHlU1KBKqykCJ7aV>
X-ME-Proxy-Cause: dmFkZTFELUjwRDtNS8nHlFHYd/1QOg6lrwDfEscotWX1L26yP8itY/Mc9EHSI9N4dP31Br
    iC7drhboE688DyvhGxbzg914z5z/hXUckp8UWRo629LBHDghmwv9DIaHQhb+1qaU0xNrLn
    EbqqpywKcLzd3zBqYuuFITzKpOi/jGuff3NoExjAIk1n4S4Ac7lRKkAsTyr6HMdhKZ9opd
    QcNAzEV2jX6qN4mephg/luNk89zNwm9LU65JzGFVwiqxqnSBhweASVg29YukCZxof02Jmx
    muXJgzO9HgHlr1rBA0PVDBOSDvGT7Biqrj1sbdZ89MBqEIWu/WnjTLym4X1HhP/8tgsHFM
    rV/MUOPOv3Xwh5ADTWM2/Pj0guvdBdapIzE7stDXb3CDIvDto5XBRtvxeOjIUZkk2Sh2rR
    5Qg5W1wt++kcdE1pxDFAJhy3S/ua8JjttxUWTdlclWWfmhGVOHv6fcHHJtLKxVV/8PFI/i
    g+0phVgtdOFAFP2+vu+Bd+xa2jbTxmYpxxksM2SHBtA49uDYsUj9Gle7TMop9L0e3M2gNr
    fVoY+LjoPVxZRAJCKrXrnoarI7dOYnTql+LSEt+FIcSflXGFz8QDP0XdMurHde7Mgp3YTf
    JfyOw9budeDLfOgQTzV3qVQrzEcZ6m5p7ORbR6bMvmm/x9VwS7pzVA+kd+Jg
X-ME-Proxy: <xmx:5nnragS5rhfqLwHJSDUnUDfCtMSKb2F9tpqF7njyRzZhOa57Cu4Idg>
    <xmx:5nnraq4bZEzSyQOwME-a8mhOPCFUnw-5Ns7LPlAmkYyOGo5Vx_-H6w>
    <xmx:5nnras124uN-WO1TSI1zgyQE7ZBnztpLFzN8UX2VC8YTXaDTh3c1-Q>
    <xmx:5nnralALXh8uAou6OBi7oZDnKqno9izpCPxoBqtvWuGbVCMcxI6VmA>
    <xmx:5nnratsf1-xk3j-IqoWRRdWaP8G77LV4F_9nIVSeSXlgr1BiUwzOyTVm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:31:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>,  Rahul
 Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
In-Reply-To: <20261104062701.GB1763458@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 4 Nov 2026 01:27:01 -0500")
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
	<xmqq8q60u82x.fsf@gitster.g> <xmqqbjarowvi.fsf@gitster.g>
	<xmqqwlqvmxa5.fsf@gitster.g>
	<20261104062701.GB1763458@coredump.intra.peff.net>
Date: Wed, 04 Nov 2026 10:31:00 -0800
Message-ID: <xmqqmrro1maj.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> On Mon, Nov 02, 2026 at 12:51:14AM -0800, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Junio C Hamano <gitster@pobox.com> writes:
>> >
>> >> For those of you who are watching from the sidelines, this v2 lacks
>> >> the threading history.
>> >>
>> >> The v1 is at https://lore.kernel.org/git/20260602161150.1527493-1-aplattner@nvidia.com/
>> >
>> > Any takers?  It should be quite easy to be more interested and be a
>> > better reviewer in the http transfer codepaths than I am.
>> 
>> Second call.  Anybody?
>> 
>> Unless we see some volunteers to give it a review in a few weeks, I
>> will discard the topic out of my tree, as 'seen' has been crowded
>> with topics that have been collecting dust without getting many
>> reviews.
>
> I gave it a review. In short, I think the patch is OK as-is, though I had a
> few small suggestions for the code (and it might be worth describing the
> "why is this safe" part in the commit message).
>
> I think one of the reasons it didn't get much review is that the wwwauth
> is not well understood by other folks who work on HTTP, and the original
> author of the feature wasn't cc'd (I did in my review, though he's not
> super active these days, so I also wouldn't hold my breath).

I see there were a few responses to your review.  Let's see how
Aaron responds---perhaps this time we see a small update to move it
beyond the finish line ;-).

Thanks.
