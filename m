Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772816;
	b=mYdQ7luMn4PtprMnTQDKllxxQDmd5X5uapuJ+9iNC4wcc3zDHg0jBWtl9o2geWuJ+4Jy
	 g6R+xT/sJqtTd/JwVxL8vsmvRc3AikPmWK3Yg6y54ejYfLPBjUPByjVWmT+ZZLRCJvc+T
	 VjUkEDunNOqztqlv1fvxaGtZIV05QjZFfQsNwNw3X5k82waIVIVjQRmDndsEgoMknUlNy
	 Tla7aWyMYpojoEUZMvnLuXJ6h2n5PHRbC7L7IHvQF/yq9vPab58Cm1Joztmwy3x9CG2u8
	 4c+d9qd8j8z91fM7+hu2Yufl1cYxcegUMfGZcwx69s0g3S6/hvKShVWNFh6Ltc+K9Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772816;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XAxq/iHHP6qAEeSXu5Rx5jIwnmuzwGh9ROvEGYZKBzc=;
	b=wNG56LL4UQWMxHTRfIAtNNvhUXkORa4giO29+10rnKRLUbyxvW1/Eg7t7O4Mb4BLrCHX
	 Q068YoNP8EVDW9o9o2c4gGdIzEUnTSYGPOdsHNDxQqspZ7E0+gVFSTrvd8PHKPKw0X+/y
	 TXALDow9hXWrsWmGsHNnyJ7vmsPOQmZbfczVpFFmlqkT39IqRaVLGx6l67ocRpM4Jefwk
	 +PLgA+9yU6WuoVFxjOPKILKmEFSaNU+tnzxebiDOlkhptbDU/oVuy6a8IwEJ/z4S+1/20
	 s1SUZitshYUhvS8YosYCg5M7ugh4ZM3ug65S6+adkbqYrRSMb4dbzrKl7JT4XC0Sa5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UcnXlKRG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HTjU6VpS;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15755606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15755606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UcnXlKRG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HTjU6VpS
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4210AEC0173
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:26:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 12:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792772815;
	 x=1792859215; bh=XAxq/iHHP6qAEeSXu5Rx5jIwnmuzwGh9ROvEGYZKBzc=; b=
	UcnXlKRGP8/zxduI7sQTZcMaWBBs5tsadZXUZbBMLxMuvDvhGWOjNk1kts02BytN
	K/g9xF3/K2pqy4MhyiXD3PUOHjY283V48exPxrAURg0jchi9zP/FKn2Odsn9L1hr
	Krx15rErAPNrxGCkqQ4okjZk9hTiALtENI3kh/ltORSPJmOl7HNak+FNdMYBPvzI
	HGsv+sgEqfm3/d2CRGHJwKUWcDjysk9361UWSNqw9E2vc1HIiCj8GjtFFxRR/dil
	Hla4hCunDdT9D5QWWIsfWdbcAtt/d+3dx4+aYZlQuVR+wW+z61eSZJO1WtS7/0TA
	I1hmdoJLIa7aifAmUNZzrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792772815; x=
	1792859215; bh=XAxq/iHHP6qAEeSXu5Rx5jIwnmuzwGh9ROvEGYZKBzc=; b=H
	TjU6VpSruY/4ps7HApA9EcAtQg79pbIPD2f5WPLX8vbylHVf0al43f/LeoSQFTYH
	POmd1E65ikWX81l8dmyKnayNBWQ3/0vJOkiyjjV1UncPS4l4TLxNDN2UyUjFzTmK
	RxMe2A9qA9BSGF7Ah7+enNvotDrD6d+3ptdWRG5R1OnTozWJOO+3emn8wN7y9aqf
	QFPt7AnHEz5AAPf2aZWuvdOedfsujAKzNTO26kptaqYJ4VRGfOmZ2igbvhZjwUiZ
	NbiSxmTp5G1bPxgbvjMs3FNsleMhEPFjvPpg+AHQtf+W95rjdZuc4Vv8X35HxuzJ
	ryq6k7aFmIPE/C/0+4ayg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792772815; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VaHFGVbbssXXunwhB0umUhwx0PYkZ1s8sYzev1im06RWRnB
	yqO16dDzzhoMaPZcCHUR+7rZwArX8dNBwZlFwgAEMXS60FDgBCcMX7reSrYJDBIC
	VHYB5sbimL6LASlReqWWjA+ltONWT/IRQmC2vQxWzluouk3bgEDJ14+1vFdv4HjC
	0w6666SqJQQNHcbJd+y76PQcJ3sUtCuN7empLyXNF7Z/6jEwqeL1CXTKAcpfyRFB
	xmwa2gwj2BOlVWu6B+F4umeZuS0bKPtcL9EiMQRLo9gR8XFdx535so5UWjU9hJSi
	xSlNf+Lbh389wx3Zhbli5FN9JZXJG0Fm33grROw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:8VsvEQuJroztJ+ELNPkPJPR4v7lwRNbakArl7ftfNIw=:XAxq/iHHP6qAEeSXu5Rx5jIwnmuzwGh9ROvEGYZKBzc=;
X-ME-Sender: <xms:zorbaqTvS_Krhm5czgFKPrS9rLr6PRyknkd6Y7xOgNKrUBGenNE2Bw>
    <xme:zorbapHQv2rPI51pySHIusBZyoI7l40YuuEqtuUg7sI2m39Xh2r2TOn0F9JPGy4rW
    eWJjmEWDYPiualj3xu85A5EgfBrzNCGB47gPRDdh3i1mbnG8n2FV1Y>
X-ME-Received: <xmr:zorbavHiLzNA7ECPQc1WlD7NK1jD5xxkrr7QViSPjDofOgp-apHEa0qMITN-uGj7N-RFEWTrEp-YZOF4RE2xsJh9hefmLiSyTNfz>
X-ME-Proxy-Cause: dmFkZTEoT7CZyPL6SqiCYCG/0RvygNrU8EKjefZAIYoSEq86qv7EWYqmrRuX+qchRkBj41
    HsRJCBD9bdlXPEfE2SPrsNZyb7VotlMCEtJSYBzvNF8+NoI8P1ZobR9Xm1MxegYvg/dkfv
    S1Z2IdlYHPX7JiQB71VUJgMaRZNsZc5UXuiOUIyTMq0990zNkdEqYTAuY4sXdMOZMKaeAs
    uRd8HnAhiZoykLI9EttevjifE4U/LSO2bDWOEX9QbX916kYoAfgBp3IKADZyVn0Kowjlhl
    d8erN1StYaImDCWnq/f4lcmQFkjujnsdrfbQ/KMT3av3FVhY8xcZyITPvOqfG1pyp72DLo
    3lmQjcWmCABxkTMMHKx0h9PUgOO4nnKa7CIzHdTd88qGGuq3h/aGAiHgSwQRaL7dNmborM
    NiSyxwlOSKg8Ud3uu+6zmS8fEJgeqmHps7JW+RSMyxmUOldweBzgxClCXGvi1cm3G4W1nd
    z1gK/I1e/FLu/+mlDzFvz9sQcZaDoCHS3ZZVs+UJz88aAvOmVDRYo5FMpdLmcUsYm2vsPq
    Y3rKAQfOQ8/VWjdtiEjcwSJigGSoOwgXFQilFYiImYzelRby5R2xFIUEb+DwE1AgXgU3kF
    giaSv1CkFJgVJbNAUHZVlbtVDgJhEvsL/OAhYAGnfMsiehm3pTcscazS7UlQ
X-ME-Proxy: <xmx:zorbanRFpJRYYXowqLTdaAwzyVYGIICWQtTA7zbzap4QDFEZhxd0yQ>
    <xmx:zorbagJBUI3lbW2b7vl-zqbpeLhxcW9bjMA6X9um-V-n2jehEoDMRA>
    <xmx:zorbaiZ-Oe71Fkhv86F0-DnjCGCMFaOuD_2RoJFwQLv2YIxYZ2au7g>
    <xmx:zorbai-2HEA8v0yQfcQa_6iDrEUUdSyW_-J6iV5ZaxIzEB6_mwUdVQ>
    <xmx:z4rbapqaN1FxSfogykziaR0w4jI9BvVBgN3UJxssy2hNlg24eledCeeE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 12:26:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Emily Shaffer"
 <nasamuffin@google.com>,  git@vger.kernel.org,  "Justin Tobler"
 <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <037a97bb-af3e-4e20-9845-c2d92ed3a2c4@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 23 Oct 2026 16:18:14 +0200")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
	<b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
	<xmqq4iedc99a.fsf@gitster.g>
	<f192e10b-c7d0-45d8-8f67-21383474d16e@gmail.com>
	<037a97bb-af3e-4e20-9845-c2d92ed3a2c4@app.fastmail.com>
Date: Fri, 23 Oct 2026 09:26:53 -0700
Message-ID: <xmqq8q3o9ycy.fsf@gitster.g>
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

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Some people care whether software projects that they use but don’t
> contribute to use GenAI.

Sorry, but I cannot quite parse this to guess what you want to say.

