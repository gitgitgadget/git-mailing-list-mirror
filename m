Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515053;
	b=XKZuaoxqBjTB7oWNss1XQepUYA+X52Ah427wjruI1i1uB9DgcV2XKwRMQhHb4xkunJoR
	 9AymPfTdMNaNwRzv6EsDKJFthVhsRr9/D06vYbanR5+6hinoxlRjvtvMIvV4Ij8T+eMui
	 6/Zgiwe83TnSa+bbnylrVQwdJSfW1mLzB8sqKnAATezbgaZCtWGyB4sKKRTRQNU0rKe0N
	 +AvDctuJ+KoBOdZZaJO1RJj/a61dqkF4+ig9Fo3SL2sGMS3zulwPpaCTFd9k9pb3QTdy5
	 tcw+J2XyRf0HNhIzwzgmFHiPx/i08FSsajgqQojDuNKnTbfL0Gr8w7ubH3GQzclRPRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515053;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fkIF5XbE9eMcMxZULB5THz9lnxS6CM/8hGK80bP7P9E=;
	b=vgB19sNSyIVztMCVGpDnqc5ANaYTi0ADMMrc8R9KW8l8C3Hqst0geRNPF2u02Y87pXb+
	 NFdv2TYIJFgeZQ1U29XWjn/norMuPF8XCWDfUDKXv0JTtnMjqyB+HLGgOJOkqJw/IBOjJ
	 9CR+vWEM5+c8zlTePcX7IDMY53BD/vq4TLQS98K6/gUWUNMh8mJYGzdol95Vdc2XqmNBN
	 edFJEOZRaMJwiYlg/bY0x7yE/nPtTM58ycO5BofZJrGCKlY1NYDN9Mg2bhdpC1CHjI/BG
	 kp5IPSCgDvtfvx8FzY8jHI1EF4WmU2AbimMYMl5dE3OkQochn1C5slJ9HOk0HhRJ9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cbqGBUdw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BqtpP6af;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE2606A327
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 06:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8EE2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cbqGBUdw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BqtpP6af
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 107051400277
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 01:37:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 01:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793515052; x=1793601452; bh=fkIF5XbE9e
	McMxZULB5THz9lnxS6CM/8hGK80bP7P9E=; b=cbqGBUdwp7SkeczQZW0SA47CNG
	tBXKrFP6QwVI4PGPtCqkUZ0NJ2D5faP1enK+7/XGxD/Hy37fSIiQwv+1rBCm/Yhc
	Y6JYnLesv/mbDrhXHg5YoPD9CQSvi0q+O4vAfTXbBfwZF8df5TvQZ2Ju90HJyUqN
	vODH4wsbygwl1Qfu7FehmsRvmen6OauJ+50wpuutaNyLbvIzqUg263qeiY4NTfVg
	lQg20DiaYs5mGfN/1W3C4emjBixmZ/FhntkBind1DyTZVNeOtUILnPd8wwBFN0d0
	4ATTXEpxxitCTf+2abtLiZxB1/ZcrKAV7vkTDmeCeaGmqJgiulV5oKsrupeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793515052; x=1793601452; bh=fkIF5XbE9eMcMxZULB5THz9lnxS6CM/8hGK
	80bP7P9E=; b=BqtpP6afN/3SlXb/rcdhmzNfsn5jfAS7BjRVwo5bPy2SAT/BinD
	WeiuNz9boPCDRUzR4V1kG69iwGwTxgvQCNxEb7+07L4UOd7A4vCk/ws2GF0jXOAx
	icBJGLpD+Rm90mUUMO1pOnfl8OeM9/WbPxGbsfSQi6b0vQqzCUHEXofT0Vq2b3Jx
	EFjg7/ArSGuxcmPqn3VZJ5jmjs/R7V18/iO9g7WUqgMGn6r2E1Oa1hP18nNer7aE
	DYjTTtDYXBiPBLo1gKMRCLxMcXOUDu/qPod70LWmGAV31z3RytJznHgd8qM2ryc+
	EW55CXRQaweqdfxHIGethktR1/js5P4zpvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793515052; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oqfcODEGnI7tH2WO3otOYfrekpfb0bKH4chipgH7sVFNuJv
	tbssdyuiZZT+AT9lIEXX0KuC0lqLgu6S8jcMXoajUDCufy8xmc97Dh0+a8/oZaZ5
	D7QnoJWr0krM5/TV9aq+c98gg2T81rdlF+bI9lspbph0u8FNdl8dPzdRFSpmViiQ
	1S5yTeQj0NatKm1jV405Co9nwlIOC4Xp6bGGNnNFNTDigZgi1jz82fpuWVLfDKFx
	n/cgbUt+W3v1SmJXOPqhyfKCY+T2xMflcr7DJIwdDyPSuA8HW60HuT0oMkxHAcu1
	w2nqh+w6hhb4Nigi05pKhdvKxBxWbAWNSwXaWnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0Cd21ftuHeROjAcvfapxrcVS91jivm9MBj4GMiTd0s0=:fkIF5XbE9eMcMxZULB5THz9lnxS6CM/8hGK80bP7P9E=;
X-ME-Sender: <xms:K97mavKpOFUFcu0M9xHSkKQFMx0x3VDJN-VPPxHMmC8QeICfv7Y75A>
    <xme:K97maiPDUEct-jMfGiF0VLekIz6jKkQS5fDTIrFr8lZIK7XvFCjI93nwnCNFtMg4R
    TIJN8ISH0NIdG-3QpU7WZMhq08nR3FXWJR4M664ANiApp31vFMY>
X-ME-Received: <xmr:K97mat5Fhb6ysV2Xc7gh7IK55LqJecuCP_Tu3iUaK-l_EFkQUDdW-5C8cqQ_HwiSHnL3F6QVVcYjwzpgK68ZzNzsvneFLCpdqiIO>
X-ME-Proxy-Cause: dmFkZTFToRdqofbpnq7E8BqOgQm5hkvf7dmEmpt9m3VNEP4QGP16C/2fCCCX2dNMIcpYQM
    f24vi02FJJTuwkOTpzIpCjwc00q8+VZQRWh6BYW9pgHCMEa1tnujfEnFyOV73HqAwlwlNX
    UKWrcG9YqIQmCqcljEBcasl4ofpcqG311UhwHRVti9w3DBZJEysX+lm1zw0r35z+BnizTj
    2OYhphYDIYuRA2wiRPgylp+AKBoJU/SAZUQJ7VizYtbrVsvDh4KM8QCHqOLLUH5+9rADQV
    OwWk3QmHBECv3Co26o7MO15suTtto+TW1Np81Drwe2hvut7YXzlsEcZkIP8Z6gSeBZyPk0
    M265I8HYuwYqdcQlF4dyo9OqjgjbsGsNg2Qj1A6U+vlc8g08qLWwEyjZgI3QgHVQYQVoke
    a/pkF/MpoTpCJXLjUvptgT8l0HKsLHHmFVqvud90VFWIWJ9cs35XO+hsPlpUcrnNh5fQNX
    DmkxpD4L/sXQT1p3lwlGw6nAl+GWyrPdjo2YBKKr7zuARRfxHcIu17oveXWfk7hwghS6ZX
    4m9v8cSQz7e6jNLo0GOJtuv5Hm104+L4lbwSPXzwxwc5FLI7xOKK6ySHN5yYaReTHimSkS
    onLQ08Wx1E180TAgllS+T6F8yItkH0fD/K6E23uS3J2EqWYtEtEi10r7Tirg
X-ME-Proxy: <xmx:K97mak5RFT0u83IbKJV8ftD2lHsYKL3OvAvJXl6Kx3QHFJVNpIL8aA>
    <xmx:K97marFARunedmlg3CLqEMaeR9a8Ddx1QXwhoFzWmVO-QqCwxYkD_Q>
    <xmx:K97makWP7HJY2eWwWCO55CH0XdwDKhO4x3U1FLVJtqtz6IX_WT9bNw>
    <xmx:K97mavVO0ONGIrTyQfRWoThQZ0mmsVHvzjH9CdDbzY4oRb1YfPvujg>
    <xmx:LN7masps5cJxs2GsHIqlhUz3Mk3g6vdTFdsXq3iMNvYDuD9NQ2Yoth8Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 01:37:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Simon Richter <Simon.Richter@hogyros.de>,  Patrick Steinhardt
 <ps@pks.im>,  Olamide Caleb Bello <belkid98@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2] pack-objects: use size_t for streamed large blobs
In-Reply-To: <20261031183748.273957-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Sat, 31 Oct 2026 19:37:48 +0100")
References: <20261031180411.257932-1-gitter.spiros@gmail.com>
	<20261031183748.273957-1-gitter.spiros@gmail.com>
Date: Sat, 31 Oct 2026 23:37:30 -0700
Message-ID: <xmqqse1l12hh.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> In builtin/pack-objects.c, write_no_reuse_object() handles blobs
> exceeding core.bigFileThreshold by writing them in a streaming path. It
> takes the size from st->size (size_t) and assigns it to an "unsigned
> long" variable, which is then written to the pack object header, and
> write_large_blob_data() adds up the compressed length in an "unsigned
> long" as well.
>
> On platforms where "long" is 32 bits, handling a blob of 4GiB or more

On 32-bit boxes, replacing ulong with size_t would not fix anything,
which you already had an discussion.

Please rewrite the above to stress that you are talking about
platforms where "long" is 32 bits but "size_t" is larger than that,
so that the next person do not have to be puzzled by thinking this
is about 32-bit boxes.
