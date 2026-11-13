Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554846;
	b=kIZBWIaQ29rPy56KIhTkudOUcLBNgphHPgqXw0BOLNacvfdaYeRIdzav4hHo7vpL6X8p
	 xluTSHSw1V6Q+h8rAJMqPuc+5THjYfPD4YLK8VUaVkjdxzuoOZ+eIwuG2LjX8VGDyo96P
	 TqC8/MteD/m+9vUE+sdK0yxr0mnBE4AkBNsQCpHjamisl+NzqSrgwdR1H6zAPxkr7pa4O
	 VU5rsFPyP0TkCrU388gYCr9nzLthzF4xv7xVYYm6mg3sP5IXrG5N+huaPXPyQte/iqZjG
	 I5pplMq229Qo43L4Bi41unX5ykfTLcuuiiUO9i0kH5Gwtl8oNMnuii9G2nvrnLNFZJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J813LGorZv0N+ScpY7w32zu7qbD1gPlJn1zcUJrQ0Io=;
	b=vKqHKBX3jv0GIZxAwQlUp7fThOw025Ynhg5mWxATERmEXxRFm7bZwuZENIZr/9oRdwAI
	 nvtQkfcH2jx7erII1ELrwGBEPzITuVCOZE8C9wgnE0VPDBTBEeygt8HH5iifCZEtz6VZn
	 tKnNHWRicGoqDQGL8/5oR51C32bGrM9PtFn9QJ/Ipu6BEc+Tg+Y1kq9EDfOO7Hk1h+SYX
	 9c4Ws/P6UQzRFCRqgKCriGNCOHvrnH9uKVBTTCjBFK/GVQYKxA2/q+UEQyy21YDSp8nGr
	 DeHszacq2cuhoir3Br93Vtr64XMF05Sw4XSd0ulckyXh0HmasSLpjs93Kc537tf2gkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ct8MadJS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4L+D2h8u;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF986606A321
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF986606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ct8MadJS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4L+D2h8u
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CFCBB1D00324
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:27:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 02:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794554844; x=1794641244; bh=J813LGorZv
	0N+ScpY7w32zu7qbD1gPlJn1zcUJrQ0Io=; b=ct8MadJSdAoWw6yedo171dtswu
	/otZqHeMRP2Jhqc+P6qLIiGsSpsD5G2pLS9C1YXJNPNbExgkSPF8v1ffahRpkmQs
	wFiyZhNYVJcPu9uyNv397m9NGPCW+9t0UqMKUZmo4iR8hoYeewjjDJq2twMZbV+a
	7mxWH93b+Z2FHchtxKCaG1rpkJBsh5s6tAJOLMXvGClg+NM7G1E9pwxzNDjRoGxw
	/T1yZEINwCvGu+Q+NoE8D6JrdomFSzHN0ZMIlWgC/7OEFkYg2ennGqRphjZKz4VV
	n3I6eqeRDcl4UZgpcWd8XCXHOH6j48R3B93ODUvobSzYm+Qdw9Oa2bTDI/wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794554844; x=1794641244; bh=J813LGorZv0N+ScpY7w32zu7qbD1gPlJn1z
	cUJrQ0Io=; b=4L+D2h8usDuVpPAbOxQIC8kzvYa3jWOsPiBum6sNB9hB4VZ0erS
	56mzpiMwmzwcVBq036AFYpefTr3wCFg2f5KVOfs9yCzxXy6q0oxOwJvwkJoAydzk
	YerwmM6Rjrr1JvzxAUR7/azXig+ItRWSy7tyCGQTE2bjrbFxLojBadlPYCPeAk6K
	bqL7J4LInvdrq0VD/FK4hKVspWsEDuMCh3hdFOZhaWRT1YmLi8peAqbofoIfTr9Y
	amQKHGUzdtKkMXjYicgaO6XxmaXb66+pYMygjfliNa1P9jrGzMf/OU7Ah0B9MAdq
	L/aONWciFHO73uQDOw5vbr2v84TCFx1aKWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794554844; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:GMyu1Ll5Q8mA8XGhqmM6ttA8xxszUiso9OepyVLqugyNkE1
	F1VY6Xl1NSQll7vuSvF2FVafZAG/rHtHpHFO7AwOK/9I5VQeehvqa+dVNLuvER9R
	xFj4QfyebNaFMi1ZYQDXa0uSdMAQY4jnydrM6jTwaOC0W68b9HLEEwjJ55MzGYiq
	4v4STo/x0MV2xWjR3HtzQ4j3nxcD2opAPlCWRK6ng5GKVkbtou749qVc3dH9SSYh
	XJgihU7etlq0plXGuzR2q+9w6qPSRqVf7wJqn0PMoOUiZgsMLu56uokwpW+SkWol
	0/ETeLxDyBZCcaEtGE7BylrLrxLBDOl9+PAnBTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KOxP3XnM6etFAkbItdBv7Zvpgk7XVDQ+avSNkfoO0zE=:J813LGorZv0N+ScpY7w32zu7qbD1gPlJn1zcUJrQ0Io=;
X-ME-Sender: <xms:3Lv2aoP_nRhskrlQ0doCYMWUhbJ4dKoDlqBqa8nNtKkdCv0qn_4sEg>
    <xme:3Lv2ahOBZ5TRJYfMrNbayar1Glc8JiR8p0jxB4BPjKJhopcc_i9n6jBRUYRitNuz4
    88WbD66g4NsI1_ZVXQ7TrN_34xWNbOYjD5IhP-bsa5J9zE9YInMZ8E>
X-ME-Received: <xmr:3Lv2ahjj0JC6ON_sFqT6YXR1rfcpZeaYo9cU_YVhmA3ru0ThfaynuA>
X-ME-Proxy-Cause: dmFkZTGEP4L7qeGcFQyuwXPyuoOCJ3oqSyAaIzMzmmp976t1CAkfm4Q3FycWA6hAMus3ol
    Bh7gTftvVj7WSg52znrzROnnqAtOYG3/rQh10ioy62+4tCV1A+p+KYXV0WXkuk94+xsUSr
    eXbnEkCL8V6VBgCe6hZFp0MpjjzJeT+WCuITWveycExvOQtAXrNTsVICPx8TFd+kWJaR+N
    hvzaxwBfZUKe0QSW6pu/+SAuVuqoJSyLbgqaV62mnJz+HCqmKtcDDUiHh8uxFF55YnQzoU
    2wXQAf2InHE3syjMJsigp7NFJ3aaGmWhrhUswMvV2w/FFA/o7+NdzxsSCJ194guK5N5oa2
    hgoLSPWKsUjpPo3I3Oqb57030LCy+9x6WSlpsox5oLQYu7hQg04uOyYiTDBzvvQkjQTdq0
    9leZiSXHL3nux6RrJ0eNFOwhTDWwqRTryxl/4xDqm7NSeT66SlC7og7n8dHN0WrOOrMed3
    fs7tUFkD/klC2WYSFSI7eeXq36rj/YhzAViN2ImR1JU6LsaO11LIV1S7hyDf2hdopiWPDT
    xUkcwgnz3D696Icq26gFIAtiuEgXtdMOgtYFpVUcM5IaN91vwpJGgZE+IrKgBZYN1fB/3e
    3JwCQwnUUX4MsJd81CoQrNtXXWR7DID++EvBZEBE1bre04GcVBGIHCtOg5JQ
X-ME-Proxy: <xmx:3Lv2amuvxw35OukzWT5NiqBVlS-p8URnNWTvz50-lEDzsegK15FlZA>
    <xmx:3Lv2avSm-A3IYlYOKBYFqCDZxlnDP6QEEbLhdHjybJrQgnSGmY7jRA>
    <xmx:3Lv2aq2tGywBB6E5DbYZr9o60JivOQtax8zlN3d0bUmZnbBLe9BN7w>
    <xmx:3Lv2aku8KDvUhC9tQ_wmyq6EKlO9gr8rLQXUuj7pdLM2T2e83fO89A>
    <xmx:3Lv2al_Dz8_Pfe69YGN4GzKt0cO9S9utjo8ghjL1Fo_RHqzMkk0vJYqG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:27:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b75f2a14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Nov 2026 07:27:22 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:27:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] ls-remote: add --show-object-format
Message-ID: <ava7178U9hXzPy1Y@pks.im>
References: <20261105104541.790881-1-adrian.ratiu@collabora.com>
 <20261112085205.452463-1-adrian.ratiu@collabora.com>
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
In-Reply-To: <20261112085205.452463-1-adrian.ratiu@collabora.com>

On Thu, Nov 12, 2026 at 10:52:05AM +0200, Adrian Ratiu wrote:
> Changes between v1 -> v2:
> * Print "object-format: <format>" instead of just "<format>". (Patrick)
> * Reworded the --show-object-format documentation. (Patrick)
> * Test helper now takes the expected format as an arg. (Patrick)
> * Combined the sha1/sha256 tests in a single loop. (Patrick)
> * Minor typo fix.

Thanks, I'm happy with this version.

Patrick
