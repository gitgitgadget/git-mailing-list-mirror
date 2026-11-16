Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843837;
	b=zNckkeCwxMpSEMq7oYuWXE8m8ZsXKb9eHfEQgKKa9C/MOZoJNp7pqxbNwwm7syJ+eqmn
	 KQmkywPBmTeqpYLG9JkAevFLktJWPZiRfRSI+XIM3ylLP73oamohBpa4cqfbokPcM7eBZ
	 qAW/nOKI2+jq3PffbgrPxeom5JvmByAVTtWzKS5kUvFDZ2Tg9fQ8f6mUCvwVQ3w7pvdEt
	 XVU0ZNRVSFBjDT5mQy41LRTxkQq2dfVZ3DdgVqy+b42WjL0dp2g7G8t4BXLkxnHPXU927
	 PzSlTEvw8kyL1U6rlCb52Vfp7te9+TrIgY/19ULNIW2QoY2jltrL5wRccLUFCVQJr0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843837;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ywuTfpdN8TxIkSU0ybKmzAJbuWOAeHf8rCdRdQrKtqo=;
	b=GfcQMU0YlgyhO1aJMeoXHuv8Q7KEI54w+0GJGjRvC1ggJgtGntAe5/7LsCQsv3ghxdaR
	 Qj6ru7R+r/g770qfemLg556urQbZyXr96pGUMFsY8NM8KPFf6ZXTb32UUhQh9BmL82R43
	 QYSuXl+E6Xkt1XXfsObYte6btEBLZKuMBykImLCL01rP2cv4DB6ax27dqj8uU2EUBMKZ1
	 gkqHypwfFy7nu5RF68z0YRSIxmpepitWbcWY6n9fOrHr54XrEji0RmRwnFMUC/Z/v5jwO
	 GatwTV99pcHpXa3lLa/jbRZw3a4S7L1Df61S0botL3QX8baKQhNBg1vQ34bRZNY1gTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Oe4Q7VSd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VD1O00q3;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906A606A322
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 15:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D906A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Oe4Q7VSd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VD1O00q3
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E7EB5EC00FF
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 10:43:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 10:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794843835; x=1794930235; bh=ywuTfpdN8T
	xIkSU0ybKmzAJbuWOAeHf8rCdRdQrKtqo=; b=Oe4Q7VSdELWeNSEbkkViQefOBc
	xx7vk7RPwJybIQbIAwvuNYYU4dQyqGejr+PSlueF5GWXLbTy9mQBou+hwL1RqtJx
	tymu7kOdMTUlmfBsf+GgNIHiuJbeNyoCFTG/TDnGADheP4ZqNBbTGuyuHDwCbyVw
	OsUQ/9pxfvz64uotu088uJPnwU2su0vVaVzPN42ojRd0673dunx+FkP+7PPXUb/P
	NpvjKrRuJQPRaMaS+T3SeVFk0gWYz5fcwkrGt5tEkPEp4Jxz80kUNWNAk44ue3nB
	S45mK6ncaYGWPQTlMqip+GhEaPVedntkC/zJUHIh9krLu7wKEiwO0L7W5Icw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794843835; x=1794930235; bh=ywuTfpdN8TxIkSU0ybKmzAJbuWOAeHf8rCd
	RdQrKtqo=; b=VD1O00q3UQLDDe3el9QdyTfObAPe7lHNR9QzU0idMpoi9m/lO2+
	KH6COoPsgHyraque94CbjHaQquO7ZlUc/+MFAClhVdEroySDog5x5es/77X02xNF
	aQjIHgOerpmMSERBlYJoitO2knXbKcS6Soy6Z3mrqskxUKfUbHjBGJVkQOrOEsx2
	Pj7N5luhVTk+ob333bsioTarJGe0IOFWDBeDii3fK1tM4xF5Gvhih8EGz7Z2CXEz
	CrC85M92KmoBU8fRNt7xuMwE/dsjujH+naCZMJgZC8C5qizR658I2rusHIsHX83q
	2W+LLtDnAfBBbJG+lHSaRxLXPBmuMgvvBOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794843835; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mx333lA1HxGJ4UOjd2fc9Fg4IjIXArk9gbbJcp6dP+P1jGd
	ijiem2WoZ7PdrLuAXzSDTj0B7a8OjeHSBj60DdTzMHRlIvJGR0fhpYfaKFUegkyJ
	o/qhKcIunlLDQYYp0nykKWB2mKNAcOZEDx4KU2W4OLn5/y5T4atjjSY4weqThHUc
	zx9BUeEhqhwniGDpzKIO5DC6G/V9VBjEsuhf+UJMKOYKXBeRNc+Rr/mVyHah9gsk
	fQE/Uf9V3d0l94AiXAKrSDTWprbNJAfTb0k37ggTScMM16WaDZ5BGJ4ZikNxLCEJ
	swx7ILlGwA3NaV+WRC1cGZnKivqad4EBXDz3qPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dLB357z/VlR99VulVXZt8Uy2CacIlUKVhj62PG8MYRY=:Ji8ZeZb1QEESDMfnrkRiz9HgpLh2psA7PUqzNgOoEw4=;
X-ME-Sender: <xms:uyT7avdJ50wJIqBui6SzTEsxyk_AFwBX-UrVj70Pz-1vaqLZtvVJDQ>
    <xme:uyT7asFOzwcftdvtf0YMtB6FSjG9ErekmvyXy8GfuA5cMhKzv88Pu-ge211Rau_ub
    kxi18VF6rBBAfI9C5oiyrPKuNe0Cu8NSeRs5KDNVfojTtcDP9vhz58>
X-ME-Received: <xmr:uyT7ag2BBC92aq38p5iIyOvzX6On2hTeEljgi22N4-MpCfmsEznHdpwCMfn8OONpM8tkouYxmHAgWbi1mDs3JO6lrTJ0ldiwSuyB>
X-ME-Proxy-Cause: dmFkZTEIy3TteJmTnh8ohCW9i+91E0p08N59Sk1u/tSt49hLeOxJt1H4U5XG+WfMgz06gS
    93L3bFndQDzT/CG6iTE3m5cYe154S9fpYEqwhj6v6zfPJ9m1cSsXp7rFEZsWEbn7tsDFUk
    V8q0eJoyhKf+MB1zJtE1K91UvUz2ukHd0iTJgo6Fkrk/GKt/SQeLD88aRlYOAor8e0qAhX
    nYlV0v/RvWT17WI9osUqH//U+anJriRt7xpCcOV1mddOojD23f98UGgyDQSoM/eQaYJ/0u
    aTrpXj5sPnufvirf+VCgU9k49/Xcnjrvyil5Z+vF/0CWAs3Naa7Y3eJS3dj6m+MnvLaIhu
    oVS+GUboHhMpBeNGJ9N4BmQjl2OWXqzzAcNODAmtk/A2tCBZ/e2u4ip1uhv+jtUzASKLNs
    8sMXnI9I5DgAwJOKDoBlwprYI/cQ4/LdTfe+McGAemRWImHZ1wV4IYE94HlqaXU/d0cHir
    NVHVN3CCy7Jbgex08kXI+cd+5Isr2p2ZNEJyx92kZzZR0isbaieoeZWhq2BbiTJZFXgSet
    nQarv2KQYeYW8cT5NzbxSSEnknoAkdyBCV92OX2U9+ZIw4YkwIzUf1e+uK+yDk84tdPIql
    /o50OOWjdgpy6QIZbGgyCwjiMScR80p5XacTAijT6Wz5DZZ2I/e5GI9DmAlQ
X-ME-Proxy: <xmx:uyT7asnKedRm5CX7UxAt5fuj9bqnbSTzbfatQ_pd76GeCmTRR5whKA>
    <xmx:uyT7ao-qbVhbgtU6kxi8NXdQcdYJv_2_v7hPfY3Zg67aTs6D5o0MRA>
    <xmx:uyT7appyvm9coH-Pkuyb1_x8Ikp7sdxStFiJlPRzmXtP68Sw74XP1Q>
    <xmx:uyT7aplvPjeNX0McWiIZDENusHBvVo7OCL1SQmp1VCNrxwr3iPQDrQ>
    <xmx:uyT7aj0iTcPRduXYKwZy0AYoMmeGtDI-Lul74XeOSN6lBJUJS8a6Bp5N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 10:43:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
In-Reply-To: <avq3YHb_J8Ww6Kq7@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Nov 2026 08:57:20 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<xmqq7bifponx.fsf@gitster.g> <avq3YHb_J8Ww6Kq7@pks.im>
Date: Mon, 16 Nov 2026 07:43:53 -0800
Message-ID: <xmqqik1wn5mu.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> $ rungit seen rerere --skip-locked gc
>> error: unknown option `skip-locked'
>> usage: git rerere [--[no-]rerere-autoupdate]
>> 
>>     --[no-]rerere-autoupdate
>>                           register clean resolutions in index
>> $ rungit seen rerere gc --skip-locked
>
> Yes, as documented in "builtin/rerere: use `OPT_SUBCOMMAND()`.
>
>   Unfortunately this means that we have a backwards-incompatible change
>   because we no longer accept the "--[no-]rerere-autoupdate" flag for all
>   subcommands. But this was arguably broken and misleading as we ignore
>   this flag for any other subcommand aynway. So we cheat a bit and simply
>   call it a bug that those flags were accepted in the first place.

Ah, I missed that part.

> But yes, the same is true for "--skip-locked". I was expecting more
> review feedback on that specific part, and was a bit surprised to get
> none.

OK.  Let's break it and have the users fix their scripts.
