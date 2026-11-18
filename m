Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003273;
	b=U3Yrlol4ZlMwQBrIJVWmwTRCFvCJ2A5jWSw311sXoBOpLgix3/85scl4rReqB/esaMri
	 dEQLmw+I1LUgSVdETAlHkCPDUdrNz+8D/Xuudc5rJjnrbQK6MNI410PMswGvrPzyegwzG
	 fCB0d12aVU59Uzn5wdvDzQrZkDpTVCSvmTRlT2tnrPoZhG/le/t7/PLKrsaDx6sFKLbt5
	 ViYPUow5fqDrgBc9C/VCJtU5Clgtcym7S6/S7nXF2yusjo+TFW+hHwyrYzw7PrdcLfiHz
	 UUcN+1w6SL5QfbpQDqSMqrbhPs3QqGFSi5c8dpKmyRIOCM3btgtRnTOE4g5M76TXUSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003273;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7p61INrAxNAhnaDCObS4TU+SsKRenFDqXaMC4Z8J7dc=;
	b=44E7q7iCz/v0YOHsRFUN5dsGSgOHa+bYOG9GpDsJcW2ncUe1CSAKq1CgkR7xN8J2N4ab
	 dDClWBa5rEjBFCW5L/03QoBqxUlAy7iCD4IDvr7/+icyZM+s7R8JV0d4K4ZDt+zn62QRd
	 RPk+TkWY3yKWNaxTwSkUcQfyXWoJiwsM1NjIFkjfTNUYnQwcxqcdqEQ2cQbgWn8hBPX/7
	 qZovzaV6Fey19KvCRUfOygww42+UJ0+45rDFV14F24eEvITal4diDaLrA0TNIz5BvB7Ab
	 UDiJGvFXBo5RcUWOR7Y79YLOZkhn6aUK9PlUmK6i+dYdGzF5CnX8jhG+t/9ZugP9H1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=p6fsgfci;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZhVQFV6p;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B960A2600
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419B960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=p6fsgfci;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZhVQFV6p
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 792A11400162
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:01:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 07:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003272; x=1795089672; bh=7p61INrAxN
	AhnaDCObS4TU+SsKRenFDqXaMC4Z8J7dc=; b=p6fsgfcieNGp97ZNP33S4in77m
	KPfpwQGxA2IDD5AVD4EU/MODdGjWMHWdPx17KrhdhvEU0hCD0XzaeTW9DILU8zz6
	Zh2hSVq0f2H+pjtqPoYYO7kS7LtCN8/I0Yu4lWHVvlRvoenx0UlvyTlflwNWYNKV
	KknEoycJ9BD2xsQgXl4/Nr+SnHr4JfM/jN9yr1lFen9VsxqPeHSLF2BpAXVdJaaR
	WkwL52qdwL4xm+i/WrvueiR3s/LNaL5BaIdEEBJlR7P+5Zu23Q4WNDFKZ91VtvzS
	6CQdyEvhcfre4UyA9XM1iqiH0Bv9lv1TzwkyD2hT/gw41A3s06jSb2/cP0CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003272; x=1795089672; bh=7p61INrAxNAhnaDCObS4TU+SsKRenFDqXaM
	C4Z8J7dc=; b=ZhVQFV6pJCl3TjZ7qPp5St/nO/d9aOkePsuRF2c2p+B4N20oAKq
	bc5wYSw1lTXeBhSChpacMsZzg/MJ6EoRzOdpEbHNa5B5DXM/DMHaBMTRMEAAiuoh
	1ZqLPSULA7tU/nrQ3i+0Q3TxE3iCt6B5gOh78G3ul1pcPkOW5sWTr90t8oh7C5fe
	W3sjkBXlG89GkD5ayLNx0wgMkuXTjjkbWClafIut96iOonSaQccKGqyk4Mk889Mr
	p3kcsj2wofUhhYH0srXOPURoiYh48v97fERqYxSIm+8L/I2VjudNJwYbGeUjrDNJ
	R83esKiGSqaH7ivxGP9bsKnuStGf3OHjfzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003272; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:g6ci3RaE2OwQ6fKjUOc2B5tmaxWno4PA9CUkNrZSEldS97x
	CP3yOW0ehp8Rp+1sk4dPU191lDqCMgZHujyWIJvmiRp+jSKx6Y11IUIffzq0SL6/
	WHY0TDFMpqQUAwhFJdSRbAIQqACw6GhGeIC4DKO75UOfM7P6U3vO1KsWMXpJo178
	MDnN+x6av6C+mMlIeOKE0kq5hkNPS35bQKFzcHyaXUCKiYPO9jcIPc8boPp/JDvN
	MpkLXs73eSFajqJ9HtBAHYBAtQxBmvz/Oz7VwIBoYhlIZNh/uXKzm4+3jGpn785x
	9yAuKevDpRZsqV0KSkpYGIH8MbBPszXDkfilpaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/klOyhfmj3rYajlLnRzUJvhv0MRzYkBF5uDW5IzihEs=:mXnFkf2najNkACFRccKSJ2UoO6UN7eHcblNQLoa+4AE=;
X-ME-Sender: <xms:iJP9ar5N09PVpMhQP8gfQW05VevJwWPsR4EgqFAR-X7uCeiK893iyQ>
    <xme:iJP9any0JZN3vAi490HDQcgPJ3kPdvKH20MoWaCRO4TxMqtgs7zLWxrxbZKV1dOtU
    jtbbRii5pK4_DmM0eRumCDhchWK8LH0EvWanDkKzFljEuerDgcyFRw>
X-ME-Received: <xmr:iJP9aqzTlxQ3obS5uAy8xiutb1m0bobhYBCYzYQ9ZknAmym0AIJOfA>
X-ME-Proxy-Cause: dmFkZTFMLJQAxD7LZfqUPMykpIPop9K7xM5Mjb0hmIMEseRjNLqQW9i6UJHL187KJM/Vbn
    FPZnqj1eaj9c/Qneq9wzhR7XyQXHnLGupbZ2MDeVInQlPtCvtQXi9NRaJjUDn8LD7kgb+b
    9qCTfkqOS5AE0jBMsrd//2yhkki/nZ7RciWDRztw4FKK73YW5ofdIgk4DYeEV4EzdHCadN
    1ZJoIVTXNx7HON8fhB3+HWXlje5cqMAj73NpIo65ahLwD+G8cAhuLHdHZ5qB9ciC+j/m5e
    F1kK00iGsOYjadPm7sCSgybn3VJ7cCtxDSyipDetQ6yPn9JN2/XbnhHBEiC05hB3Ov94lk
    m0eX65vcrWUtaK8Umsgo/d3N7LfzSxTGzQ+ltk7aX9upZE55UkeZhpoMaEXLccZMRAD9Jv
    SWdVsm0ebusry3H+0Nuvn9llnwYzlrZFq/FgCuJ9QeGQSeznNYYUGh+hN8Q3VY1xjkKjmk
    I9kbuJdFVayLY7aUFKL8neFRbhVPRixFWsaKSdcE2SX6poEBL/g4/+WLyHNTqUReStr0ES
    Niaszx+JSy8t5B1mTFraln8HAabYt9cxVRSphnKakdZ7ZqiG5zMZBPi5gjszgphHtkTAoe
    hOU+4pRmeaaPGTCzuwTcZiajcNbt6yj79bgyyWGQAl2S6N5WoFsnhT7vUWNg
X-ME-Proxy: <xmx:iJP9anzSAv3WQzCVKDC0Lbit-yYjEXvcF4qRrcGomzHczHuSTi2Cgg>
    <xmx:iJP9asbDtAqQS4Nd__Bm9Md_gxw_Cj49YGaDgGEtJnLyOz96ao5JBA>
    <xmx:iJP9agWZXylr0T3iJLHBu3PoW9r9ZGzG47S8mn_PweYJWkSYtJqyrw>
    <xmx:iJP9aijtAz5aIatUpHYjtn3LKbY3fKqw9I_hgDgKQsJvcSbRtCA7Xw>
    <xmx:iJP9akTgEJQ2XTxuV3rx_5GW2bKJztPvYSwf9q0LsHgvcsr2c_lZNsuW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:01:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6cd9377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:01:10 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:01:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v3 4/5] remote-curl: retry transient HTTP errors in
 post_rpc()
Message-ID: <av2TgYegy1w-Wi8t@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
 <786964ff00368648e5bd0fd4c5889f7c105d0a51.1794022836.git.gitgitgadget@gmail.com>
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
In-Reply-To: <786964ff00368648e5bd0fd4c5889f7c105d0a51.1794022836.git.gitgitgadget@gmail.com>

On Sat, Nov 07, 2026 at 03:40:35AM +0000, Ravi Mistry via GitGitGadget wrote:
> From: Ravi Mistry <rmistry@google.com>
> 
> Git's existing retry logic only covers HTTP GET requests. However, the
> actual data transfer during fetch and clone, as well as on-demand blob
> downloads in partial clones, are sent as HTTP POST requests via
> post_rpc(), which only retries authentication and immediately aborts on
> 429 or 5xx.
> 
> Extract the retry wait logic from http_request_recoverable() into a
> shared http_retry_wait() helper and use it to retry transient HTTP
> errors in probe_rpc() and post_rpc(). Also defer reporting RPC errors
> until retries are exhausted, and re-attach the "Content-Encoding: gzip"
> header when retrying a compressed request.

But the POST requests aren't necessarily idempotent, are they? We for
example also use `post_rpc()` in `push_git()` to POST data when reaching
out to git-receive-pack(1). I don't think we can assume that it's safe
to retry requests there.

So I think we'll have to adapt this so that we only do this for some
request types.

Patrick
