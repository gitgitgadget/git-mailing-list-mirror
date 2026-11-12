Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511516;
	b=XMqY4zw8KzPELdUk10mNr5HvIENcivVarnH7C/nYXCppJEroXtmwIuMCBrZ1R6+nIieH
	 azzMcnqGBMJrPhAoeC1L6SPiv/3q59neQbdve8MppnYxgck0Kh3wnpvpAp8KHeYRrwvGl
	 phUiJJh27EhcEWeC8qNGoxxqhIbJ7wZ4t0LUdzS5wr/iXm4smEA27sJmZhF5RE4NUeC2h
	 PkUjg7h5Y4TYxrXJXtgHH/+mKa+fKao7ECjIcug+iWwsD+o0MkQafTjaqoYuLdFQzSu7d
	 y7J4SCkqobHO4Y6w/lrgtY/TeIRp4oLashBKItVSAGI38vHgdjnawwoqF4SvjYHukSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511516;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Sbukg2MtKRBS4RjbqNULoHAglxCZuR2X8RfgbqptNAo=;
	b=PEu+z+QCtkMZS72iRJG6ZOt7tVYW3dEuaw3Wki0lmAJTW/EaJVHM31ti9M9FvpK8uxmb
	 BMa6uH1i5Vv8aJM6hPGDZvqztsJ2cLn389/sOpAgWgdPObRmzQC/tAO80cY+BikAnbjln
	 J+nJbKWq0VbZSrGR3aNnHPCeyhu6UmoiaVLG94YgeyiDyqu6J3B5XLmyz1Y461JVa5LW/
	 KwVatXZ/u3WDyghKkF+5UCDvwNyiQqNtU+zw0Ehl6yQNWb08l2YzZSR8Bqm3xum3menNs
	 jAvEjHMdCi/bGgGPJSwyCJrZcy1Y8rz/JqRgFDYDvoyo4mTmpdUfFfANXMbDbCk278w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DfIFv49n;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RuK4l20M;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43513606A323
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43513606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DfIFv49n;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RuK4l20M
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 96DE61D00364
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:25:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 14:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794511515; x=1794597915; bh=Sbukg2MtKR
	BS4RjbqNULoHAglxCZuR2X8RfgbqptNAo=; b=DfIFv49nQ0+l0Q9bn5c8C1hLH7
	9uDl7EMDMzE2R/8yiFOqhnTqw3FpNu2/wjwsZEnY3oc368U2sFqhVUQ02igRsouQ
	fbPViH/sZX5XrJBRO5uAVmNO3C/x6oHpq+3UkOM5/Tot27VLx/5qxxzQip3lXygg
	okoZbrvQ+QAIUr31qr0+OcQuo7BGpqZO2vAh6mKA9rEZJQ8XrR5BccLowDBoQL1F
	K9MCa/k9MxhWItstTzf6b0qEuUQckooT3h2wEFzQLFcwUQscY52DtjivdoyIffff
	kkAZRgymVYmePTxMP71WFLEqcLmlv7O5FAo/GV7vgqSPJKxMIRUc0yvv8/7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794511515; x=1794597915; bh=Sbukg2MtKRBS4RjbqNULoHAglxCZuR2X8Rf
	gbqptNAo=; b=RuK4l20MjAhp68YUjbfAh4ZMLb6EzVajrAnB0XatoYgfvlgkxM+
	MVV8LCml+yFcU8i7AtkB3ojDEWT88gHMHkIi9hL1V3PIOrHGs2MfppdSpl8dbTOm
	vwYIjNIZ/HZ8VsT3AqSq4LUpGeaH/9x/pWCFUAeom2AL/cNm+GOZyv7qHO2hsxYo
	o4AiVWo3WLM8XK6jjY/FNQzCaZukq0G2zxbG88lEwQ4PJ0CKkngpVzIov7ds8PIP
	IsHT0trxm3op2jtyNR431xrwiD2xvyggX75zcs7rNZ99/KMsqy+m1gcPZllPm6yy
	jDwZsjVRgHp6VXCYHkrma+0hSAuvCbTK8tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794511515; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CW6j7+Uxb9Jmk3nT5J5jk0gc8HHyuurVBcOUXFqUkApUrxz
	+Z6mz89YwU1bWT9tOvQMLJQLKsUb2zgIz8UNSJ8qymlUhJ17z1ohV0+GfjHB92MB
	+2erfRSm8XGPumsv6WpjhqPEIcGMOYmnWKsgoYE4xHwY+bFM4OOMS5sl15zBb8hw
	YZL8w/m/uPGHuVLV1IRTRDXZjbADMvWIDELuZJpBiYPnPVfJesYO9sx0nPI982qT
	TSzL1DaGybtuejgZ6Sfvqcrs0mh2UYOwuSSYh+l8I4+5SGW1GwvV2gde0Dz6CG/F
	F04lQ9+PXztjL857MHVKd/tbixOMHHZf+Peg46g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UPXw/riAAiPFTZ5QCi34Z+LcgyIedLGZB4C70cg+Ubg=:LIFRh55OvPPIK/F4qjh2XKGmrCPFIqMGF+513ZqL4dY=;
X-ME-Sender: <xms:mhL2alwn_JTb-k8BF0QBjch2Oy5kmrTJtwwrLbBHm9T7SBtt-pyAzA>
    <xme:mhL2ao-r-gLyq0i40JleM07E4N1SEh9-SwP4I4-9LjzNF8zJZWqlMK2Ix5hrmkPwS
    bzpqiDVVYjJe0-KokGFAwVnM3t58mYmoI_ppwzLNE278FKZtwP_-Q>
X-ME-Received: <xmr:mhL2apLgdO3Yy5yAR4kdic5k63adWBy0Yk3YcRExTTJtSc5fL9AsmJpXWIwvMWN7yzsbPJjCSC8lhQmA-kuF6PFeogVh78q8B6ju>
X-ME-Proxy-Cause: dmFkZTEUGLahXWUO3LJeYRa258nOvbeDUU7zFDfAQ0kNRjLp7/XL7F1znvjiUPkIG9VgsK
    i35zVCUUI1r5iosuDVsVw0RyWLV2LcNeQ2gtV8+xwpQwRiPC7/5LwEth2+xSM7yll8vXPE
    eZXyTnVyUcLRXhNmlKbQZMoEEgeXNn5EpECFUO3YsDv4XeUuXnp8BYFY4GqeEDckXkVpHg
    5ljPXmP22+M4yfkNSFZdovRwXPWd51F/ly2t8yr0G9YNUtPqXc9smjLXv40nK3ag7oSBy7
    j2vXlklSvBG9FHs3Vqphx+Y+cgKI8wmxHzt5xTBhzYcr1lGj92lBwoWK7XM+hQfmpOe2iZ
    0jtDTVPg8tMZmlF+2FIZytktClDRDHFahUe5DdA6j5UJOia1YW6kV9Q6OY+ybbKvRphrrX
    2lykQRRdOWRHpgqGzSwc57VCaIegOFSOOid9ZJ+yz33E9pj1RihHCPY7qlADryUkF4Q8bm
    5mSM54FXyBnMYFtH89RV5BwH8/eai436bdM8LSW3tTRAmCM04h0bVC5wXCQCQx9RFivhYw
    njz51lTYus2ionWil6XlX1pkWD3lvObXMrhzK8+vs8w9SfVvV4yiXu5Hi9/JlGY7HO8E5B
    ZNea3YD0SgTvwpOb6sYkxqfm4/rKLsyVRTjALQ3OMlsYYAC5hTFU4T7nyMmA
X-ME-Proxy: <xmx:mhL2auc5DKMFA6gYb_2HMYgfAsNq0IBsPxl6981nzbnkYaMLxrlwLw>
    <xmx:mhL2ao8ApIGEX3WtYDpX6kq1b3ZBuqDEOKEeta-XBl7_iOnPq3zhaw>
    <xmx:mhL2arrVWKCszVnTwswxGeS3T7Hd_wDKBUAMQZUudvREiw5aq407BQ>
    <xmx:mhL2atCSWHdCm7_KSybHHdm1sRy0lsG_MZNn23cs1xF17y0tiwINMQ>
    <xmx:mxL2anVNTxMOLt_J_432KnpVjj7rHV-LAc6h0fps7cjhdE1AR-bBH-OX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:25:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca> (Julia Evans's
	message of "Thu, 12 Nov 2026 11:37:35 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
	<xmqq5wy2kqhl.fsf@gitster.g>
	<931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
Date: Thu, 12 Nov 2026 11:25:13 -0800
Message-ID: <xmqqik21j1ie.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

>> I guess it requires a developer's mindset and imagination to
>> appreciate why detached HEAD is useful while spelunking.  We often
>> phrase the act of visiting random commits (often older ones) as
>> "sight-seeing", but in reality, even when you are mostly looking,
>> you do want to futz with things you see there.
>
> I'm not sure what you mean by "it requires a developer's mindset", in my 
> time working as a developer using Git I never ran into a case where I 
> would have needed to clobber a branch in this way :)

Sightseeing is not just going to look and see, but touching and
breaking things.  That kind of curiosity was what I meant by a
developer's mindset.

And of course, I never ran into a case where I needed to clobber a
branch, either.  That is why I do not work on other people's topic
branches to begin with, and make use of detached HEAD instead.

In any case, now we have a shared better understanding of where
"where your current work started" and "will be the parent of your
next commit" came from.  Hopefully the next iteration will become
clearer on these points?  I think the central difference is that you
seem to consider detached HEAD state is only about pure sightseeing
while it was designed to allow touching and breaking.  If the user
is not making any changes, of course it does not make sense to talk
about "your current changes" or "next commit".  But detached HEAD is
not limited to such a world view.

Thanks.
