Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188958;
	b=ZEPQsgko6x3uO0c4HQG560EbMlxCp0BwvZFTnJvr7K+GvKNILVMfgmAq3QkRjUhhSNhb
	 gYf0LfX6U4ecglU4nUenZrxT54HSJZaoGVPc3pBq4oLc6+rgotUwycdMj0DcWHrq6w3od
	 9pbWVGQaOaYAL6dDnWBx7iPSUaZ16gMNd0SqYmfw2rURcgKglgs3CvZDE6VeokJiwy4sQ
	 YkDCXswx4NDD7kLevCow2AiDXlySL4fWdj/imm/SgaetIJJ7Ok8s2o70zZaRccTHxDPeh
	 DlgMCP/VwHrk3qprzp0Z7tFMWRT3EfOPMd3ukbgF/QtAXmnqfAVUyoSF74K/7lXY6uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188958;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=koV9JYjgA7gv/XGVKnAsTDyOrSmWRsawEfkKIgQyKr4=;
	b=tpDs0thrpUNfyukIIffbX9csN/ckpvWWFBL29YapX04tYs2K4kkV6nk9X1PUABFQWf9Q
	 GI/4rcTpe5Sokh9jv2VFqfWrVa9t/i2+vEwEYn8ZWtWAZAoRnebEw1C12v60ywbTKvM2h
	 9CUsIzoxaKJSmJlqGU0F4s3KRVCzjanu908pUilbrcnwNmP1jG37C03DlwzGOLTT2b52B
	 3cTaqGZO+/YLotagw5HfBADoMk37/6qgawMn45e3FR3TOlBXNbXboQ8+P4d8Y/NBj99PG
	 uOzLyvbp7RRIwp6140fO9YdSqY26nmUbSG5M84aKvcWL/r33EaAp+jyVg3ZDZ9Tn63w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=mBeiffqp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Wsh1d4mo;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C2606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=mBeiffqp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Wsh1d4mo
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39F051400144
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 28 Oct 2026 08:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793188957; x=1793275357; bh=koV9JYjgA7
	gv/XGVKnAsTDyOrSmWRsawEfkKIgQyKr4=; b=mBeiffqpowBwIdUwpALWHm3Uu6
	tXPC0sSpXAvX1Jl5Bx+pOeZxXpMRWefDIW5OXlKz6tfXinmIj7vWLdVN7JitS4ws
	45ulQfaRCtb2/s7pT/kSBYMKQOmJivcfjZbBSBhvjTHfOAJi4tRrRoF+WHjHrFzk
	p41JgewwVPO8cJLT/0CwEr68rTwu6Thd7zBLVrOk+hobVrU2bZTzrUt63WyTYL73
	Xmpc7E8t0b0/wLBBeLHopz6R81Edc4ngxfapxBtTx0IM33jwLRjuRLa0JAYGCPR3
	nk+NwS+dtsJwv0rbGvG3HxihZrjEDfFy+r25JShqhoAYS5x0qigL+EcH5E6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793188957; x=1793275357; bh=koV9JYjgA7gv/XGVKnAsTDyOrSmW
	RsawEfkKIgQyKr4=; b=Wsh1d4moUNtxNJiZoLNJnYdlJHMqTMJfePNZkdqRn3GJ
	4t7qOkFNHHFRGlvdN7WelNX3fkqUD6GY/wZ0rVQmbhVYCFESLIxvs/w0geFRp00r
	ESZApdQK0L8D9g9cqEvLPEox8cEftS3vl5Dk6azQj+1Ijx3N4bkeg40VdeZl0Xc+
	XHbagSjJDmc2IdHEh0gLv8uiO0iVDVhOFAHSyHmujAWKlunyeF1jSKRcVMnq/XSI
	4pAOHQcd5W0r5iWdyN/APdltGcVPz18RYg0Y/C9QiGczaDJLQ+uUmqLHpkUnxheh
	HLk1iywVNhLuPPblX9qXSvANkThXo6UI0QR2YS2F6g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188957; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:E/lV9Thlp3x8Lx2/kHIbdOX4xdgFhDIqzngaGlyrD1zda2M
	H6ts5hHf8xVIP7g1e51Ub6asDch1els53DXhYj2NfXZh3/cYEItHdY1gCR8NvZH+
	5VEZiMrlQplHggNXL6QxaPd3uVCP1DceB2RUZS76r7Q/BOaa0SsHV7svnuqauumk
	PiF3wQQ7ufbGPz5c5qKHVhkIi3fszOEoaKGRxC9TWyvP6jV8DOn9ceoXwNMZk7Q1
	HmXH/qn9ivabu6MYceEoknlM0tXf9bazcF6z7inaW8jNemt0y/8Dtgnh4OCUxr9r
	RZxLMnL/DAwkhNsA06aBkcc12XA0Ggftt7I1PLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:HYq2lqRsVdMxpVYNIyV9MQnYi8u1epwinHSTMG9iivI=:SpbxnZtVoMMEFf3QEvqJpsWShh2yLD5E/aX+6EFsLTg=;
X-ME-Sender: <xms:XeThaqb9zZWr2XFEetFvho5DYqcwXfHVx5WG2PJaBBulOwtw0lgmHw>
    <xme:XeThakU4QEpGpXu0kZGOSoY-9bzng7EecKkYDhTYjFEDt8KbnL76r5MFXGJQ5kL7j
    XNW0ohItvfk0HteJpj7Xq5lFljlexCUv9Sr0FgyBhcPOYRvDlNcmT7N>
X-ME-Received: <xmr:XeThaqlepIEPcO6L5zGUW0TdVdgIXem5LERwbBl0g3HKXk3uvI9dHQ>
X-ME-Proxy-Cause: dmFkZTFQgGH4PqajQwZX+JzzIMFHHZ8ogiF7166tdwYiK2KtQ2U9tDiUIlPgyjsm5TqZaw
    MfxSKzWlcaS2rYg4zeTVojS/3RB0OWz5Rp7Y0SmwCs95TlaQJu9WvGJUbXFeIMtl9LKbpQ
    2MyDYcw+pSo53WgDs30SqBJFjO4+GDuZxg3/ICao4hjo6bq2rWn/UrHM+xiAY2ayAPsW44
    oyPx2cM1We8T4VYXMnEbyV5ism6ez5tC+YXpFFZSHTxVj/BeVnO9ygVIgZ8g6jZVPjhNcV
    1JHFE0LHOE+N3tspv9lmlpe4HSynOTRucpJncRmG5nb+V33CatnNVw3WEWKcmPk38lfKjE
    wiBrw1X75pz0/LVlN6VtbZbt016oxoP/E2NVAMUbk9hcGKwF2bqq6i9BdnxfAhPcbsLPCb
    0TBg/aCbPK+D7Ya3rj8UJerEYkmMCysUbMdoz0KInJSZhxQNcV8nIDxZnIUpKdsnJ0LTvj
    WWj30hJnjPglgBzA0F8jSFYdyOkxptO8/IoxLRj9SOLMte4jk7gGY91l4fKIlhvReFUPiB
    fNpu5cG2hKFIwsCP4l6tgB5harcHLhuRYSWEOnhLARGJXuHJTbO2hvEoWFEmqOrfl6Q8jt
    giPE/wu3Fr0oOUMPpJ1pOwcqwYomx0mrB0RR5jV/O/FOXYYrzOOPze6mKXBQ
X-ME-Proxy: <xmx:XeThahylSRrL0cJwvZESieoL6kA2RLmRldwqEE3PTIqq7xzbFm3kPQ>
    <xmx:XeThalhqp3osqI-lql6HWrL4FNGj2d0JfQ4GoNva7geIUa9gxsrxyQ>
    <xmx:XeThamVEnr0XSxWX7wj1y9sY54pX4NoyIzmQHwkG1QMi-9iQfE8OPA>
    <xmx:XeThan3m8J8vE5DBQa6wpQjbFvVHLxhlW6c9-nla8ZjdVbFcAKavkg>
    <xmx:XeThao5zofI0ZvCE6TDgFkQg-gWvIKinIsEBqwLu4ZoFu3xpnk6lCTVT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e6aca5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] builtin/commit-graph: some small cleanups
Date: Wed, 28 Oct 2026 12:57:52 +0100
Message-Id: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQRCqlVyldxMmo09YYMiqCe
 PemdfkW/++gnIUV7tUOmVdRmWKBvVRAg489o4RicMY11rgbprciTeMoM/bZpwHpwz4uSTHYQLX
 pajZXD6VPmTvZ/u/H87Qu7Ytp/g3hOL7V7S08fQAAAA==
X-Change-ID: 20261028-pks-commit-graph-cleanups-d1dc30f3e05a
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

I'm working into the direction of making commit-graphs pluggable so that
backends can fully control where exactly commit-graphs are written to
and read from. This patch series contains a couple of small preliminary
cleanups.

Most of the patches are rather uncontroversial, I'd assume. The only
one that might raise some eyebrows is where I "fix" git-commit-graph(1)
to only accept "--object-directory=" for subcommands instead of both as
a command-global and subcommand option. I feel like this is quite a weird
outlier, and it got in my way. In any case, I'd appreciate some extra
thoughts on this.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      builtin/commit-graph: rename subcommand functions
      builtin/commit-graph: drop declaration for `read_replace_refs`
      builtin/commit-graph: get rid of `the_repository`
      builtin/commit-graph: drop global "--object-dir=" switch
      builtin/commit-graph: simplify how we wire up common options
      builtin/commit-graph: de-globalize write options handling
      builtin/commit-graph: de-globalize options handling

 builtin/commit-graph.c | 131 +++++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 64 deletions(-)


---
base-commit: 37b3475fb530c14109211faca33716a173db61ed
change-id: 20261028-pks-commit-graph-cleanups-d1dc30f3e05a

