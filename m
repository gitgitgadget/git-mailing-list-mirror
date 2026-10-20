Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503101;
	b=cX63kuuTvhmw3b4rkwV3wJWUl/uDPkg/ZWyHUzFcfQIVXFbtk6xdcSOhMzaIPfkYWHYo
	 TIJ3r5XJZ4kqHOdlMoOv3yeiecdrEhHytU5ZPcW6Ti9vlgke95ub/JoFF8QoAIcUBsOCw
	 +YQdRtdeg8HHe+9VEB0RhED3bk3uhde2BEpEskrvjqnwzZg/Q+sqKAncnsLsZPiewRcuj
	 xzcBmEWlE3mE47B5RPFFkecVWCDtfXFI7aEEf5My0hm4CPKSRK/Al0wOxm07VaWY3GQGz
	 /0r1fkG3pwmsnBl6hKWliHj+hZEMEa6NkwPlAd1YcjGzo39WnBPICYK2nx41QAW5mlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503101;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=s9jr9FGl4Ndf2hzVb0xm4w2Yz21oK8il2YLrbtdF2js=;
	b=fXfTJWMkHnzf9h3Rwb6D47e9uewzgjYCYzKaEJy9R45kYeJz8rNv+g9xnt8E1ehafc7R
	 v3rMUj2rE0L/c1Ofs4uecjRhZvX5uFc+j0/KNJtUqu5wsLf2lQxNW+Xe44wcfW4s6sNtV
	 j9UHXApy2rFvaoPL1DnDuoLOYlzyYdhIoAJruRSl7MMWkOkceX6uh1ynRZGd3xG/pCgG9
	 EzHodvmh0FluAYDuE/Y34aU5IkEL9hAC/lDx4KdXGM7jbDkj2jbEo6pFT68YtCVcEjKPR
	 /+jHWcLlrQpgCHQIetXjZr9sZhQvmQStnP++1HzY1/J1HTjgXWHiqn5EF4wfXKW+vcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=evQz7DYg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BE7LcI4a;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0B606A325
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C0B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=evQz7DYg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BE7LcI4a
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 5845AEC0184
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:31:39 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 20 Oct 2026 09:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792503097;
	 x=1792589497; bh=s9jr9FGl4Ndf2hzVb0xm4w2Yz21oK8il2YLrbtdF2js=; b=
	evQz7DYg4qj7LiQTjsGPo6B3mVJGJ6Lel1EbWQIx+nBRNn6x/z6S4qql0MXbCDBP
	UOyXMEe9HdjtF7p4wZZaSfmulb+yVnNNaDmd2raYOW6lm5HnuRz+vnTvGSBWu+4Z
	MNPh6bZW1OaOukOwrkVHoa9o1ysdRgRm9gR1WyFRgzSv7xFypOfrXHYwiubzIIKS
	WayN0iTw4Kcun8lsFGapYTDkdC5jeoffOOliJeJ8+zA7BS7bQcFSU2LY4EcOLvw/
	4M5SSAb1gSMpphGmP8IRI5gTYKtNvGaBfxw4YeR3cH1cJUivLH6Eq5kxNoT5g1Tp
	O+GdbJg3b8TKWC0Z2jgs1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792503097; x=
	1792589497; bh=s9jr9FGl4Ndf2hzVb0xm4w2Yz21oK8il2YLrbtdF2js=; b=B
	E7LcI4a206ae9Aqh6CM6bHDUvQzU91sxlqdH3ML2JrNlXuYpBRt++ERuBs1/kE2e
	881+bI138HThQKLfBRkHHvfQK69I1zuA+Q9mb2ac4ut6PfYRHJumSOZ1JQ2qOwvR
	f+rf7SZDhKC6FPq4Xp9RYZ5NFpB5qGyLkIGGMTHRiBf9Q/PO+Ssjj6HDCxfsY+Wq
	f9AaumvGoa+oC2Kfp+DGM5ZDgek5mzSgwOVQk1p3OQz/C0uTot9vIctiwPyLVrRZ
	D70bniWVF+qCHP+7fEdNck9t4GElyLxj4Rx+PvcrGz3c+o6DBBHqFmon7mrgOqDx
	bTEWjvjDjTokckcI9xvYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792503097; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:l0ZrX4VXT7WBcGPnDnUJC4pRA8fUvH7UyV0yG7/A5/VzYoQ
	vI9A+4dSnFGxF8cotz32hFJdvtoDLAlQmj/NAHehoQ6svhaNhViC2FJBRmauosRc
	u3bAIjiPpkVfYAfNdmdMfbSVKohWU1hcRtHv/Eg+ZB5NcKAnBOExiQGto1mn9twi
	lA6Allgz8ykO5Qk5mzvlV2tDuBGAAXpKh0fJlpnllo+3/uJgUqiuTXkzEI7HxB9x
	ADN7Tbpsxk0Z0U6h0WrihwSBwx450EpfzRl70FFlcuu54fyamBtfQraZnpJaWgzK
	IxABNROeTqmosrKj7duA1JAj2U22zMd30NbjuXg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KyvNKwQ1dk/kBCzsKMKVc/KEhXd5YMUJTo4sVBkLZpU=:s9jr9FGl4Ndf2hzVb0xm4w2Yz21oK8il2YLrbtdF2js=;
X-ME-Sender: <xms:N23Xaq36hSzmW8KeUBzGpUSn-K2n4yC1mpodg7Qn2XaiKgq8DJG95YY>
    <xme:N23Xan79TU1WHhXBilInCxo7JmBt8pP37Fu7dDGZD5BwcEOO-uQ674yvIUWUAGk2A
    HdFm_xytTn437prnCfXNeAmC39MvUulOLAStTvwt1QGyctzqskZYA8>
X-ME-Proxy-Cause: dmFkZTGbLVRgWD0YUttL9+/VSVJM4OXtDfjO3+XF9XFX+fnyVddHJxbC6I9Dz27YQcEhik
    gNqj1rfF3x9M9mifl1rHXlyT8ICgXaGFIvL1IZqlG1aqHMn14S4gBpkTIOX9KtxM1gyyLS
    IZTwzy39sFVcZJQLCXVAFO0WsP7iWgg5mKQaVZTXzHR9WnqzKMJmro/K6e9P/c4OkhjFTz
    t//iCBmBOvwIBOLtv/VgUHEg2lGyNRQRT8Un1g7eHAnijBGQe2nIxj4zmdj+dN6Guu8btm
    Tfp3eyZttzibtZksFLlbDQhhNQ75GDEU1OrHlu8yIjyX7W5Tpnwz9pVCXLev8cP8XinlP0
    Y7BdCTvp8r9HtRSYm6J/wrb1mEm8MP1Fd0YysPK0c1OfrM5IT8UaVmYh/cpghehzCVI68/
    1BLbSIm/oiZaec0YK3zFXJO1TDeThriERpqovtXC4Yzq+3cPWpde9aEfBJE9qek2FrCjRP
    zbN25+79AoanPJy4Ue/b6ZH+2oMrVAYPm0xyM0Z7dIlPGQpN7O7QWm+bOGP6lWSNpMd5r3
    LakRMncPamASbK0xI3MqJDhpZ0IMl8LPbFEkWSleNMF6AwqFOBav/W3WH5nlu1GqsAfw9Q
    An/whxZFl6g7KniDpPFNaL6nma2WWTjtY4HslxQ78xfXKUmqeNpLipzy7XUw
X-ME-Proxy: <xmx:OG3Xatz1WuyS1hyNMAMqGW8K6aQzddHq6orPTzRKyXroQ329fooZEw>
    <xmx:OG3XalDaOLO-EmfUO3lLfH801gPayN_9LZ2NPQIJQl0tx3-AecDzKg>
    <xmx:OG3XaqZPem-Vdxs1MSieX_zLWe8hYRiGjqlfTVwKvhtDvL1dvMz6YQ>
    <xmx:OG3XatiOPMYFrLMx_aW5NRT0nIUtiTwxu66JMz0aqLdsAILYIzx1FQ>
    <xmx:OW3XamKGS_3iGvkIS2Qn4ZgCvqFbKc1hy-9336NFVjoQ3stIqeB5JImY>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5E2D722C00A0; Tue, 20 Oct 2026 09:31:35 -0400 (EDT)
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
X-ThreadId: AB9N__B7nd93
Date: Tue, 20 Oct 2026 15:31:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
In-Reply-To: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 8, 2026, at 21:27, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: kh/doc-gitbreaking-changes7
>
> Topic summary: Move BreakingChanges document to a manpage for easier
> visibility.
>
>[snip]

Is there any interest in continuing this series?
