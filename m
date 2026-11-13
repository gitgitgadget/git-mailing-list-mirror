Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536722;
	b=4t05dAUlKS4ZhxZnkICeIBFk0/5Ko3y7pWYPC0oUas/X/kDscaDh5bsJIMuFOSMqs/lV
	 RC8i719BT0+gI6jYpFxG5h77Gj9NSjcV9PtkLABbRORn5yUdkI3Q7+2b2eFGNHwQfNd6d
	 z0meO74eCMPUqpwYhPitMRrWfnRzUer/gxPWB5d7ScbQ7VBDCH4v5XuYdMnWGMdfLgJKi
	 vLder3wBCGaA3av240+P7yk+SYoBj7LKlxTOtcPKaQB3T1QBsSuIvBicuW7GtjFXM11S3
	 LnnClHUE7aSRn28ZSKj8y2LNeNI0LY72tXw6ZCz0z2yw0iG20oLFcCh/DE4xRldJe5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536722;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PO+9xj6y4SzDuXuluS/wTO2yHB2hcivGxdWzlLYvOkE=;
	b=4VeK9P1kljvvewQjLXVWv9QKGUsGe7VlznUpYnbDJlwDLGtb7kk2GS97LdU9+qj1GbIg
	 3sG5wA68TXtF1Dgc8H8Btrv1Tnz9vTmOPHrfbUkoB4H0b5D5tkaGV6jvd5JWUDu6ZGiQu
	 eP2NB4uz6EDIOMoQGjQU/q8Ax6SlZNHjjlt75eTTObY/lasu4//no6gIYPhZa0LBKVA5M
	 s3us+tPp56c2rWW1xNrIBnQkzuXdNYSATp/DQs5aSPSArEtqeQ4cjox6TSX4cCT3/zhFt
	 NJUtdoHXJJewQUJsD8rjjzr5mlhMmGOxU77UYmsCulMrvvktTkGGs1iFeEkuPUE183g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eC0ydgV1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zWjT6z8N;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBB606A333
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADBB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eC0ydgV1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zWjT6z8N
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B4A49EC074E
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 21:25:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 21:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794536720;
	 x=1794623120; bh=PO+9xj6y4SzDuXuluS/wTO2yHB2hcivGxdWzlLYvOkE=; b=
	eC0ydgV1k/VcynYF/N9H/nOXppP/+eNz8+NwpJCahPCI7lsyG2vlcmnRvmG7vKla
	NQF0txM9Yap0bWSGZVHuoZYl3zrT/6AfL1hb3+42nKbHDzAdo9OwRvM+FWbB2X4L
	WcIQd991XbRb3FGJJg/C785DXM/6iKjBSgXdbiuFezQMPT4S/WEZ4MMa1uOonkml
	mJ/aY+zDk0d2rvBHxylyESnLdvVo+UNmuVQSaJC94c0HEk8IIPDGH5G0qDGKwqG3
	TgY4IK0j+jq3Zq4i3qkTLDu3bKUC6osMEPlQTPAsa8fVr1VIvozdhczpf3ys5IB2
	NaewcxZOR/dKI6dNoR2bjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794536720; x=
	1794623120; bh=PO+9xj6y4SzDuXuluS/wTO2yHB2hcivGxdWzlLYvOkE=; b=z
	WjT6z8N0/uMdDjo8Un9BVDdc6Yu9Sv7ZhfH2rP8L1ec9axjc5VXUU9g00pgLYRfE
	b3JwWTGgb1lqwkei31RToikm9FfDX1ATyO4f7vaoffrWckkvqpGAxd2nZ6mduEom
	Wv0+WdZbIG8XLrjpSTZDihGEhmdbLC1bJAws49iC+lDxnZMemCdrCDOkUqCn9y5W
	cqvcAYEn7A3DPwnsDx520++zB7vk30DukrozxKT8ZeBLNT/H1advYIpCNhXyYDYM
	fSNSLTXZuQDOYQOI2ltmPZvZSG0mxNSgX+unVgJ5EqYrNKfivhNNTU+FSrQYSEHb
	Vo7vcu1zFUGk3i8krhS6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794536720; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mbg5S8Sk7I8vx7e2jXUgWI3SIcPH9YDK3JAMR4WtAGX8IMR
	VSdM7DDy5izNePC2ruphM2BmXn+0x8PyaBLEiCGEbeauYJR4mZbhJk3o8NCxVntC
	4bJC9moYziC7Q1t1zbQdRKkRUBu6f4UuOyN4gyTBEJ64sY+I7XYIOtKZ/DgY5Oxl
	/3/MijjmQBWAJBLlNScVHhcnAaqJXKBrfJNx3uuUIIsasV+9ORzvjTghHeAE8wQt
	dYtntD44eigLpVjQld5BmS4XnTl+fd2q+v6xFOPwdcdqyGUIEzSij4J8txICr/lz
	RAwhqlvohTdXnQK52C5L0LrZcoZo6y8Uiw9+pUw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:fXtUVBCLpiCyHYxZZmlEkQUf618No8KxXfU2L/ualpQ=:ljk30mtK0pPeTKZF1zd2LK4eNzVCR78ulbXrwik0fpI=;
X-ME-Sender: <xms:EHX2aoYJT5W6wwGUesMHnLVngTakALdN7b0RTYtAgdOju1nwOF0Mvg>
    <xme:EHX2anGzLohBMM10QFAikzofADcdIQJpq4859FdOZwG1gYrBzLO7edd0dd_5Bvre3
    0FKzqLf-dR-eJlgzVM7TVv52qyTBeI29x5JE9pxhf_9sM6Bcfxr6Bo>
X-ME-Received: <xmr:EHX2asxHCaT7zR7kD4HVXauLGeubTi2QLcQ_uBtiKAe13zP4ez35qOjAibp9_1HidbYWqYfSHtukvXWkEBAo44i8j8PAkoCFx18y>
X-ME-Proxy-Cause: dmFkZTEgB9euDwliOgVPkATrXx3cCa0JCtR8ZmH2rjwLUtsI9x5r5Z9r+j+myVEXRGuAnA
    ePIX9KBb/YsVw4z1PWwyjU2F9WWm/TTRZxDWJezD4CbzjFAEPpBiSA9ab4IAq3T0oH+YRD
    88yTLljrxo6qhOpTxfeTs2o0pe7iYTY83VKKQC3SAU62x0ZdRDO6JE20mFoODZ1sDagt3j
    KYBNpaPP2O6AfrteQjhnEwlv4mNUW1ZICeojgkVfQKM3KFs3INz7LSXf4cko+YxdaT7Ekk
    nFjECy3okV8hPDwd4nHCBWG9XdRuWkhTfmX3ccZg0DpjE3BNMXymzTFULxjphbXmAy3khT
    LFSz2fnN/50BCWWOlAfpiDJ6zAicuIJQT2ZNE3B9woGI+wBNDoez+N64tKszYuGa233Jnp
    1JQqfplCdpOfsu3APKSR5Oj9oPHNd3XvSkzaC5bBZbdTmKtjXj7d03AWFgejSiFClLZpaa
    BE3FIV0wlj3NMUyZaD8oqUcgEJKqWh4+9kg6o5Gvj/yZ7kSCLaVXnpVRGZcEF8+nNUm1YR
    kved9TTSv0zCqOh4qlaFBdKWADhSMpFNIDdElvYD4KmASI/UdLHqqk87gIVYHkRhDSSDyJ
    uQy9UDDTRNvwcghg0odOvxPbIRD54oDcG6TE6Q65jFtXK5TV1TsH1GeMJEDQ
X-ME-Proxy: <xmx:EHX2aplJcipJ0Z90w6uQZS3EdkmvtCJTvvkOLJj-mPUJSUB54O5lmw>
    <xmx:EHX2almbSq57_PzhLRPQelMGFxu-3E27-aE5R0GXSc_D_45SWxvEdg>
    <xmx:EHX2arw5kjC5DwWXLDSNV4-1pYbRuT2xRCa8sTL0JgF1u4_8EwnTLw>
    <xmx:EHX2aqrzeV0YxX3Bj1WisO8gDh_DZW4fnDgKVXNZtXB48GpSjj4RIg>
    <xmx:EHX2ar-ILWsnnxqtw5wxfKmFYD4kwcbQr0NkrwwiuSlcWV-Tq5JeTprP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 21:25:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca> (Julia Evans's
	message of "Thu, 12 Nov 2026 17:45:07 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
	<xmqq5wy2kqhl.fsf@gitster.g>
	<931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
	<xmqqik21j1ie.fsf@gitster.g>
	<4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca>
Date: Thu, 12 Nov 2026 18:25:18 -0800
Message-ID: <xmqqfqx5foxd.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

>> I think the central difference is that you
>> seem to consider detached HEAD state is only about pure sightseeing
>> while it was designed to allow touching and breaking.  If the user
>> is not making any changes, of course it does not make sense to talk
>> about "your current changes" or "next commit".  But detached HEAD is
>> not limited to such a world view.
>
> We say very clearly that you can make commits while in detached HEAD 
> state so I don't think there's any danger of readers not realizing 
> that's possible.
>
>    But it's important to know that if you create new commits while in
>    detached HEAD state, those commits won't be on a branch.

Yeah, but that isn't the purpose of mentioning "next commit" etc. to
make readers realize that.  So I am not sure what you want to say
with that.

The mention of "your current work" (started at the HEAD) and "next
commit" is to lay groundwork to explain what happens when they make
that commit, and how it is different when they are on detached HEAD,
in contrast to when they are on a branch.  After all, what we were
discusssing is an improved explanation on detached HEAD, and your
commits not affecting any of your branch *is* the most important
aspect of what detached HEAD gives you.

