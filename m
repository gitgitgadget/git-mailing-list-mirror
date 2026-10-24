Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860645;
	b=irdONbX+GjuvB8jUmsF0ZwPDuhGc+qIHR8q4jZuixTfo4QvX+VhxuAkH5ep/bjoVIbAf
	 ijyHnoqPAqp/Pn20zwB+E+EhgtWv+wD+kG/aDmp+IMEKfyOwu5oXOXIqIfOD195UtSZoZ
	 PJkgnUOssDzmymeIHo8LAjtartluzLNpdZKGmZEIsEyu9x5sBAjrA5O9H0Le5OP6UKPos
	 eCSH4cXdmicxG5bZLOi53xv2rYVfEkEUyP9++0UZWwRdd3uLDm1ZCpzHZui+tcBBaZ9lA
	 AxBIxxbqSrWzcas5kwhy+giJR7rcrAYf45+4P+dsCtR61OAcGhrvbarx9MqOg7rypmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860645;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=GwjeToV4FBMA0hSxfrPsopIN9RbHlpNW7WqoB7vrnI8=;
	b=U29qSCsakV/ljX3s4jfT8YEx9f52xKbY4XypHgVWajkrwe0bSEae6N3x5hJH7/t+1P4b
	 Ee0YktMhfRuNeUljBF5becSCg/tqNyoYHUUkeTQg1GKz/kNoZyMyCI8Bhe7A8uzOJ7upv
	 zm0Ney1gvYEbs9uJhJt6WPO5mwnGkbEGK9POFBqzfc2wsqTu1rDppDLL5g1IJ9DNBiCFu
	 kfDQghnSkQN8fV9xwXD2/wKuEyKiHIJx/IGtTkSgL703VZcAZpcan/usq6zX9itS4RC45
	 nEhHBM0g7hZwEnKcLe6BYR1VYbpO7RN+saE2v6VHnA5waJ8Gjvm6SFlGMz0a9b583zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=MgsBhRPB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rmMgIiMf;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F0606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=MgsBhRPB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rmMgIiMf
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C79514000DD
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:50:43 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 24 Oct 2026 12:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792860641;
	 x=1792947041; bh=GwjeToV4FBMA0hSxfrPsopIN9RbHlpNW7WqoB7vrnI8=; b=
	MgsBhRPBhDKNACMFUp24ZTfnkvnedRjxDKvxo9x8nKcW2RTGLG7hWf5aC6Uat+aF
	XCZh02kfCKxJ3LrUeVpkhp3m0Au+qUwGB+liXsdwgaNaUbDglHhL+Thp1RwYdY2R
	3F80oryN0X+qJ1ovKVK5CI+9UPQzQyHzEj3LRCXNfaO/XvkiIhUHgef8Rwhlkwvp
	yNDhLbNmuTLKXXTAOhEMFVrpyAeHfiRMXfuGYtOghwue5chL3x1kktJ4XWKygB6W
	I0ZvJP1IG9tqMvbiOMUfZulNNBaUPypTNgtyH8XkrinBuzXuCHe0d9sRYtkuvjck
	DHXzeg8pmUW9LO6zXyKOsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792860641; x=
	1792947041; bh=GwjeToV4FBMA0hSxfrPsopIN9RbHlpNW7WqoB7vrnI8=; b=r
	mMgIiMfwHl3wLAn2v+Ns8t5jo631lUe9o0XDx+YzDG9gnW7s+RBj3zLNvlDZ/ACh
	XwlQpGAR3m6T2Vf8pPYFmKleNkFNKj15SDSoJCX8Toc0w7Exgl+ZWRpOxRPIg557
	/lKP0FxZKH875GrWJorJIo6E8+/VY3bq8C+Mwk6gnBHsKya0bYTLxud2+w7rZ7ul
	WM8viLJMgGHzuaTNWAIRFZrhQCnvxZ8ETegPzxzjbNe6PoXOdd9bYmIzJmCfksr3
	ySXphTb6zu1BJWWEIr2BFfFCh7jd4BDL9cVWcYWYdZUoAmjuqn7rVF95k3oEcJ9M
	yLCuNKYFucZag4fFtF7IA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792860641; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BrSRDHXetlhU/hnlTejJpIfrefKlomQEDJI2GUoBOwnpwxE
	MEK9Bts7gEswtjcGPetnvIJiyX4GFoWd5bxsfjVp8D9lv+D0tW/rryQqRHJTemTy
	F3aLVGMNNRF7gO7NdVuS7hFWaFmIBm9KfVP+4yPLFWt8SavTKi8w+W1089YbeJru
	0JrZfL1OL6AEVDDfygYHrCJh89UiPBLzhlGZY18c0GFQLXtucFIZ//G2/o76BwUm
	rb5jCe49eDPBSFpMalagTwNN/5iy6Yp5tmuPJlZOGPmpY0Jal0P+Vth9QQNsi9DN
	Eih5JA7fOM8mFye+/YEOe6N389u4DlybVTCmB2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J1NZ1dUMMpD9Yvmp3C7C/qr1zaH1X7RfbuuQQ7Qo+Zk=:GwjeToV4FBMA0hSxfrPsopIN9RbHlpNW7WqoB7vrnI8=;
X-ME-Sender: <xms:3-Hcaqvd492kvGo7M6O_n2tO-9O47DOqfGVGki2RhWIy-acM3Q_57MI>
    <xme:3-HcaqTXX7JDZh5MbAkvQzTU8wgNlPb-QzOs3tJxyC_P_ZPN3tcUMsxOulA5GFkzD
    zgdueriK14cEDb1tiKDa29yO7pzP62cDS0eAroaVR9fAc69qS9FpYI>
X-ME-Proxy-Cause: dmFkZTGet5I3BGCaAscaHtaVUQzvQznl7SS5nAdKj3kmnKpcu97OazBtQbgn0njvewUhjP
    QS6uOifyNxZVcxzA5mjei9z/hPyAIdb4l1dBACBnCaLtE2LlFefzLQmh69GGwtBxmzK8CK
    fRhQClDmzLxHZPMMczhWSkZ/2SjqlGV9/b71WqkfXdEuQ+Zd8wF/EFhkcUE5N5WcKvNjnP
    ykTExTMTHwBLHwAyJ/B/QtgRkeEAcWpjJn4ggKWWys8/4gGcxhghVl1loxtWHZ0oykH/5F
    73yrE2aAbXeCUgvIO36ZRg519o29/cwOmhF8ZMt9kOSM5qgnCcJ6zJFmIU+cvTRt+6Dgrp
    ja8k3Yn2gQ0iFczzKvJOhukYBD5hbnU5Tk6PGIHyCyTxh8XrNUMUkG9I/fpeRjmVD8CEbm
    X5F7Mg/2ZU9+eeyGla3szY+SDXBoK5gHvNbBMU0YryGwbTkgNuJaaplPGIZRkqcmjtRFUG
    9q/4Rm53ALTv93YG3VbTdFhyM8BHt40LmLBI0Fydyq1Cuc0qfUR+QFHokiWAn0rhCLLDAP
    xu/0HvcKxLiCBdBKV49gynzCbD9ksJ8uxYIJ4jkXUqISbXobSrDHCI1y+gMf4gC5iITKxy
    qjYBd3LcmCr3YHfW9Y66j9ArVKt4qFQLNVJI5QQhMWMwxourWMcpcpDl1Unw
X-ME-Proxy: <xmx:4OHcampQW5qA8DxlRDvYS_SRPBO4dsQBX68YHvuaFbhLV7_N9I7WRw>
    <xmx:4OHcasb8ork1L1TutABSe13wDqZOhsFCmagq7mXEPeto1NfLjV_kow>
    <xmx:4OHcauT_aJ5EyZz9N7McS7VjN33NWuiS79lsa-j92Q1-5ZBG4ITbEA>
    <xmx:4OHcaj5NXXFHcZt43U8k4_XZN66-DaYCV9HYREcnoigydQjiyvpJBw>
    <xmx:4eHcasBVFOeFJ_J6RR0bUqe_uyxLbVFNH59YP0e8Lu3SuLHjhvlHC_pn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A087722C009C; Sat, 24 Oct 2026 12:50:39 -0400 (EDT)
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
Date: Sat, 24 Oct 2026 18:50:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Johannes Sixt" <j6t@kdbg.org>, "Ralf Habacker" <ralf.habacker@freenet.de>
Cc: git@vger.kernel.org
Message-Id: <5771ee92-7414-496d-97d9-c084f4ee2ec8@app.fastmail.com>
In-Reply-To: <75b5e0d7-9608-4e2f-a60c-d278af5b2e85@kdbg.org>
References: <84e29b80-e219-44ed-b98a-b224d7c264d6@freenet.de>
 <75b5e0d7-9608-4e2f-a60c-d278af5b2e85@kdbg.org>
Subject: Re: [PATCH] gitk: add cherry-pick -x context menu action
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026, at 17:52, Johannes Sixt wrote:
>[snip]
>
> Am 24.10.26 um 11:40 schrieb Ralf Habacker:
>> For example, this command is very useful for cherry-picking
>> commits into a stable branch using a reference=E2=80=94something that
>
> We need an en-dash or em-dash (two or three dashes) between "reference"
> and "something" to give the sentence the correct meaning.

That is an em-dash. I guess 2=E2=80=933 hyphens are
wanted instead since they take up the expected
amount of space in a monospace font.

Personally, I think a comma would work
too in that context.

>[snip]
> -- Hannes

Sent from mobile again
