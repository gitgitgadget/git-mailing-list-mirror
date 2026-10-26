Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023100;
	b=UdBmvOSePkowFXU9TBAXA41NDp2VNXWxgn4n2Op+9houL2cSQQ9fjrdLzHwnU2kRp7eW
	 5ZTQdZqWDRFzVcT8U4GpJA1qxAmpqpyky5biIlC5c3P4CAlc2yJ9j8wYe7ZKMoIdxTcPv
	 CfFrR81tWC2IU3kbmjjZwLdUphcEZhlPUfSECuSWIzeKNsmlI74LDsvHE7M4LtC2rh3T1
	 nX14A8gjsJWeATWfdOlXW6qzVJRdERsZAPdJ6v/IY4zCWpkMoi/UEmWyOtOOtIimVGej+
	 QnWcSBDxoMkgrcCR51dN42B7Apkaw9MY1FVxL+GuPr1dEXFg7Lz/Qu0InAQ5sBaVd3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023100;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=2iVf//d/YJCcxg7/9tbArd8SInjfeOCA8yVcYyrozg0=;
	b=O+MXGrz7J3e+hhSY1632N3rDP4CBg0jkqJyd0UCJUcyzp7Y7oBakwM75MnbnJD9n/dFd
	 hyW/ze3SSeHvkL2gLQLk06ypA0YAjakVQ17oJHSr7gLKCJ3z/0XlD7x4Jddq4YhEmsmvx
	 tKdOQ5X3ML3TVCM1WGv9lxAUH7SS61qN9GMCc+yY40l1u/LKCQRV/5/xgHnxogk1sYC6H
	 M7k8HyRg+fE0GgNmkGjq6dr1X5KBLLcIy7zuD8RAvL5iGBtHLbI4824NbqBasD+rosGCv
	 SdLl8kdVCPNeXTyFsOxJZa0a/LPgcca4SDGc4SXSbB5eK3y61Wo5DRSnYmuNMjA+syg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=TnnQLH4Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GYrbAloJ;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AA606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E44AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=TnnQLH4Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GYrbAloJ
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 20C4DEC0A69
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:58:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 09:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793023099;
	 x=1793109499; bh=2iVf//d/YJCcxg7/9tbArd8SInjfeOCA8yVcYyrozg0=; b=
	TnnQLH4Qq9E54qi+gEsVv9M6guApoGPXViYvv7YYRo//teaTYn6NhX4w7vTjDUMT
	fboMmEcCQCQbBgzvsD9rEQH0a9MxyM3SE0JssA7EBdlLtTAmxSZGG+vjNY/MzyFY
	tYcu6dgQr0QPmIpaKWLwLE3O5SHS9c/pkHynYpgIWigS3l8ELoYKV3mhThPuqAX0
	6Ei/BriqGYHUA11sBj9O4DzqbvqBnr4OR69Xs0nhTZmKuZ8n32XRCN4QwA5q6klE
	RhFgDHhI7IRUzxKHFfHBLOxZeoNYL3c3TnzCK+mMBQPKx0wfkNmLGMnwLuC3Jwbn
	hjDq0XAR8I3a1ddrNyJVOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793023099; x=
	1793109499; bh=2iVf//d/YJCcxg7/9tbArd8SInjfeOCA8yVcYyrozg0=; b=G
	YrbAloJy+Gtzm19aDPeX6pLdAW3mLqhM9p30zXXtqM8olekBtunMnQFXmqRwmTJt
	0kwHyAEKzgiDWb8J8YLf5Gvy4QvEaktcez3NdRcdnDfjUwtMM7fv77ejUuYSSu4L
	alFQravxcIEXFV/0mkEqOhi7ZtJXXZTW+FMya9xPBG91V8cgdLiUtAkUEQI1jhyc
	EeTyPUU/+MhouBRnz/MyVE1BMbeeVMsS7vMXcex9x3GlnC6G3aomCsAbzgR5iBNA
	ABajlQnqjzyNGs/vX8B3bFen3QDDm7c7/JdyovhuCOcKMjGi4mx5Sa6mMDk13Yg9
	YqPnMYBImcy7AsJrYWxtg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793023099; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:L0mOEwhdchn0MvIuAxuiEiXqb+KPw+kzILKbxN92P7Uh55G
	OTawsQLfJ2sCJ2C6B5837gfh1Akl8YwC2COPFP6N3w+wtz/mtaZVocSYpAcFXAzk
	UZIYfIHyu8d211QLQnb1eunUuOSU4SY2AOrF/d3aKaGm0EOZ8unY0BdGidO8GSK0
	CFpjS5OfvxDx3AkNOICWXX24W/cbYx7eJ/HCzw4kg6LY8t3vPKcTjURUO2CLOIfx
	GbLLZlqTUQiR2YL1tg3Ky0GdMGbgMxDBOcJ1koctGyfA0dJsIboPBZByajB5qZMO
	4eLrfiSLOtG7aJUnIRvat502LXP2B7NA8WB7t5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BmCKTbMxjuIPVYJbwyHp7SEAidl1nVuhTugwMf4+vNQ=:+qIcRjqEwRCUyS3yHpDNXNcCW9hkRrWeAiQl6wkI+W4=;
X-ME-Sender: <xms:elzfahhQasDIK1eY8DqmB4jMQVMMX7XUdtWPidRs-D9jgCt6H99MjQ>
    <xme:elzfag1-6PKnNHSBthL3vG7KFurJd_7N7vKTZcIGIxcvn6OTY48OOuvLochHO4o-i
    XuNG97ODzbYw-E0KLVSXIltBqaEmMflnrDXOibPNIAcHV9uRbaimWeC>
X-ME-Proxy-Cause: dmFkZTGQUq2c46S7kiHTSg47u+eGutiW+UKh3oPxqEHHQfLga2NCfHIiYvLPK2PLKYt5lo
    qRmBpFFDyDqFTEjRGvzggUj7CQ9iI4fOQSg4uFLs3gsErsaBtJoakctAxYHwjWZVX7QXxy
    lXHSt2tz7DrDjFQS+ItPwgNzO1sh+52yaf+NTz8K2f43awpPgeCeOpXZDUHRYe9w1g5UEq
    6x0IDUu8lqRV8O7l15+V0QGJ9kfX1Yng1B+MEw3jTSEQPht52DdWoUDbYe9QB+/xHOJs6Y
    ELnsMOTHVreAxCcco8UKQhyYNHNIJ2zu4LHfk4Koa3omDm7hrT6TtRjkbty1CTDKCUabeI
    mwZDr1FHtchzllRcRVEI3PZLoX17l0aNH6OsyOYfMfWSEuzShQKXBSzG5nOFkg290tQEFa
    0XnpkVh6HrAKEC1nahm+pOsUvAfSktSLrukuyBPFkn/ZakejW/vrfsknPvoBkdE4gOFepL
    nJuJnfmXrMVdvmJPlscC8b2GPV7pRhOA/LB8US9AYDdfTc8v7gJ6TVgfjjm+NJXUWOwlRK
    NBVvx7/S9R5Pb9+rjUqHqBguFd0tdTv1F3t3Vblxg7Fa2L+7j7HLEEz3uKF5D8vDhh9As0
    T7rVDqudks2GudHxha/4TpfYD4Jgr9V7PpWwEbcI+pkoongzK/d9PMx6GArg
X-ME-Proxy: <xmx:elzfakIAb0nTpyoiDFrQzyFsf0p3WQa42uD0QzELkstW1D0OMr4kEg>
    <xmx:elzfah92dlD-V8P3GTOa9R_FlL4c6GHIG0Fytw2Wa1nNXXm98GnlCQ>
    <xmx:elzfavJaZSSCvkSlwW4uVXLZp2nD66h4wR5CK4moIOf3N6IfEPPUiw>
    <xmx:elzfaulyi5DAVuJ5jcTlFG59G95rqaSWE6VwIKBYrF6izsjp45jksg>
    <xmx:e1zfaqaCWuIBxNOKGr4qCCVeJjiqu8xEEdFxon_X_V-GsEqKbTF0WO8n>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2F7678273B; Mon, 26 Oct 2026 09:58:18 -0400 (EDT)
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
X-ThreadId: AqO-TNe5d1d7
Date: Mon, 26 Oct 2026 09:57:58 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Tuomas Ahola" <taahol@utu.fi>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <422df6a6-d83e-49d9-b98c-02ecb7308631@app.fastmail.com>
In-Reply-To: <20261026131339.aky08%taahol@utu.fi>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi>
 <26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
 <20261026110008.Rixj1%taahol@utu.fi>
 <85254bd4-19a1-4ce5-b61a-dd3057389c36@app.fastmail.com>
 <20261026131339.aky08%taahol@utu.fi>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Oct 26, 2026, at 9:13 AM, Tuomas Ahola wrote:
> "Julia Evans" <julia@jvns.ca> wrote:
>
>> >> 
>> >> Agreed that we shouldn't advertise an obsolete tutorial. 
>> >> I'll remove it from `command-list.txt` on my branch and submit a v3.
>> >
>
> That is still a good plan.
>
>> 
>> Oh, after I wrote that I realized that gittutorial-2 is actually already removed
>> from. command-list.txt on my branch. 
>> 
>> Or at least that's what I see when I look at the version of this branch in
>> Junio's repo. So I'm not totally sure what the next step is here.
>> 
>> $ git show junio/je/doc-remove-gittutorial-2:command-list.txt | grep tutorial
>> gitcore-tutorial                        guide
>> gittutorial                             guide
>> 
>
> Are you sure your remote-tracking branch isn't stale?  It seems Junio removed
> je/doc-remove-gittutorial-2 some time ago.[1]

I'm not exactly sure what happened but I submitted the new version now.
