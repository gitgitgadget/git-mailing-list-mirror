Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691947;
	b=su4eQItZEM7/qbKRLT/qPHF9aqHeIbB8OmEHCPCKhTi8kApKD5mbF7XoOi29Qg0NLZB7
	 d9sYxPLWYm5rIkt1reFDg4BaCBWFD1LG0KipGMDp2ib2Avj/HeuBN0S3uxlbhMlF6Cdxr
	 SPep5GxvkKrwn7MFTkVqGS5/W+6yi/OZBik13+rIp6cPCceSWdUzh20lBTjYpRlfz0rAN
	 Z2eu7bQ61NzTD6+tn4OXjN9DCdOcrAyT16uIJkXvxY/Vd9wQvMNwA2VdQ/jkgM2c/XJDE
	 2benMTFm+HnIWNb4QHqpE65ru+yppd8iRge0uf74XE/pikszKBYAZp5LivAxNv/NFrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691947;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=8LgXatbv9QUVoKgjBlNRdX9VSbp3mHgQMBnBEHsQJPM=;
	b=y+A7VQ6Ccjt5FCNoZEr0HnDn5JaYhjPooj7skIEpk6f/BHe2En9boAJOi7WKQSFo5jaL
	 n7E5PU2QfZtyZ86mhLAhnZoEruF/S86nJ5nSW2933hk/wm2QDOaSj8oubmlv4OjJ65FqZ
	 mdTcdE79dSC63HBkHq6ez/6IMsphM1QIVVfPjqRSuoeBZGbAuMGFy5+6OLkmJ8yZjtoQq
	 PoIGqa3fPAumC6JDfi70yGXSxHiWyaK2WrmSr0IdYk9TUQxflaebb/iBiMLKxWbHwRnAV
	 zpbWSRKbeobj6cDzVlmAUtzFalCCghqf5ahR8bqWmkAPBz61Vie2p3XuUvsZdynkUJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=V4wKXBXB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="FALe/m91";
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E621606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E621606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=V4wKXBXB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FALe/m91
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 55411EC012B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:59:05 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 22 Oct 2026 13:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792691942;
	 x=1792778342; bh=8LgXatbv9QUVoKgjBlNRdX9VSbp3mHgQMBnBEHsQJPM=; b=
	V4wKXBXBtKZs03LqLpPd7lRyxOcyuiw76A9NMALhYJdYTyN1IZL06jHPgGwDJJXV
	sSU0yKmO8ibCgv5+BothCg2UYsEQLENNUdgwcU2hpjFE58xJZ3378yB6PeeUPE/F
	uKPct+BH4z3vyHjlKpPgF/wVAi2YkeS6nncKuOXw0ADjb0KY7C3ppKA25i6K7YAL
	cN2pycwnS4R4O1YZ35d3wD52WHQ/LzqWt4uIDkTqOfUCiG52j6c+qzkF/LMob42v
	rCZ9w+IneipCkSk8dAD02FoYRYXYBeozGgBSyQTF6j4SL4NftdZb5TvV/1Qpg7XP
	DsDxgakwqvkLWu0unDWXtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792691942; x=
	1792778342; bh=8LgXatbv9QUVoKgjBlNRdX9VSbp3mHgQMBnBEHsQJPM=; b=F
	ALe/m91/rIDouMZa59cijoP4BWH0WwHpNtN3XIolaGi9KJGJpnk+otJn43dy8GxH
	JWxFJNX3+jNE4BeAd1YSqIFXqZQacMPUQWIttoP6wpQH6aQmjhrW7YOq95i1gGHs
	S/WgUBTA2/eajpxhutk+UqFcmI35dKtcI1Uv+z4e8WHZ5GW6JU68BQNm+TClvYX8
	BYf3Xfbc+ntQOQBwy1tzDeVPnpJwBsRC8R0yIjGuNb10ZQMTO7e1oIOiUXr/90Q9
	NzH4ggeO8ihN55dQWjO1n/hq7UJPlaGhLjF5yHmbUiy9i2bGXzYQwWGDA9ccLOIM
	BAH8KnOkewf3nm3IrU0BA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792691942; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EIC0gxB8v0wlvrq1NSdBCROkIrjqlNxKmfk02qACNhv3CIV
	TMY50QHZN86Rqesm1MDize8QtxWd66Eq34kH71R+/8tBxuiSwhZZ6t4LIdwFjZcH
	7+2Jwhf24dWkQOoD61ViTEMpzfo0E2OWyMirBIBgCmsE25O9inI7pF35fHT57zAP
	Bg7sQa21n+LAShhpfxHUMMpjrjP8vvcFoFxwINruXDXHgvCizVFlecDt5j+NPUeB
	PQG0eUsW0v2K/dWiDtVajER1gq7/TmmuVLglUXQ81LwKui55uAevslHJPZGvW4Ph
	RL/uGeDjruLiwKu87On2Q6jYJef562C1Padam/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qoeKQNVUXfUSzPNacnSHyAMeRPvMcSPXHNdVl6lKrWw=:8LgXatbv9QUVoKgjBlNRdX9VSbp3mHgQMBnBEHsQJPM=;
X-ME-Sender: <xms:407aarnCW4FHyoX-pdAUsGH6jpHg7Jt3etoWNRj7PeeWKC6jhr8l3xY>
    <xme:407aapryHlFbjHDZFmD0GdM1rAp6h12CFLo04T_o2Yun0mlptCLiKU2rmS8JmOz8C
    yNDtUySgT4b249JFUHrQpu5aqeTARaZAEU0Wp-P6nMg4q_fkCfwoA>
X-ME-Proxy-Cause: dmFkZTEkZfbvHIQ7+fHi71kMpGbnPNg7Rqmy4s+r2kpdzgSCIEMDgKzfHu5lqJMLtG11AQ
    8XK0VKaXNH6qeVbU+3B5AZPmSDbeJVmrcvDeNLiq77pPk1xPdSZViFYT6GGJxPa134Y/cY
    9gJPSyezCAcE4sPsZkDcTUYMv5uLeCjfQPzD4uzeN2aWD+cxXWwdUTUAyq3RLyqagMubkV
    ItDN3O1LRMi8K9awJehzTSS8ykOIioBhAI3RSy6bKLGY9LLqEZhlkyRNphD9ohIwe00vRF
    mdki9y4SzEVuGGQdVMRSqdsxjroGNXvHEYLyXxk7uYH/2aM3PlPhIFVnE96WgsD8LXUrsK
    kTmAecihh9eeAw5W6BbOG2RCE6198m38a7lNUbph+D6Q6TS44p0TLiExbX0aeK1kbDZXUT
    tc3jz1er68z0rYiFezgpfBRkQeqNI9a3VsW/uFt5r/maUbgS3k8CfRklMvRVSG/iEUAAri
    CtGdW9m7NBrpdjRm5Ul11hZEmzrsnpjWj4ghUkB4FN/i/MwUzxxUtULLLZAb260OBcR68o
    b8Lo5XbhtI95VVF2Dc9P7r2l3sa1OUXXpQxaBLfw3zmotSdPNPcbnuqcvZMKmMmH7VHbN/
    4ruNZxro2rJcLdWKHREDjlRnbHQGkZf/pixVA/9obZUsEuI+u403T3PjRe0g
X-ME-Proxy: <xmx:5E7aahQGlFK9zyFPrGzy_buHffBV0ouRi4wDjeokgs-dY6Fjc7Z1MQ>
    <xmx:5E7aakH-2fxF-UCXwklKnbt34Zsd__tGUjl2zoo3pmgDdD3e23TcqA>
    <xmx:5E7aauF2oatbcbrGd2-OT4F2BpmrOylJCM3waxhTSV-gOhkQCRzchQ>
    <xmx:5E7aaqTiKWm4eO9MvqAW6kHlndH31_i9A_6YP--ku2p4AzlLGq1u2Q>
    <xmx:5k7aar5Lu3Q4SuXZfA3VGr57I2MawxEgfZ7Y4w3uELTCTyNDrnh4xo5u>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A844122C009C; Thu, 22 Oct 2026 13:58:59 -0400 (EDT)
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
Date: Thu, 22 Oct 2026 19:58:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Jasper Mayone" <me@jaspermayone.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <7cc80c0e-4a2a-494f-afe3-bbc07e0d8cf5@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnXC6--wTx0Mkj9r-9oj4R6ndubjzcucym8y3Hs9CKYfVw@mail.gmail.com>
References: <20261021173350.67854-1-me@jaspermayone.com>
 <CAHwyqnXC6--wTx0Mkj9r-9oj4R6ndubjzcucym8y3Hs9CKYfVw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] worktree list: add --merged and --no-merged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2026, at 23:36, Harald Nordgren wrote:
>[snip]
> AI loves worktress, so I suspect we'll see more of these discussions
> in the future.

Is this what mechanical sympathy has come to?
