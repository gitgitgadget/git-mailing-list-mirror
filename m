Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596351;
	b=D1EPCYxyKuVu4wEWllfxj7LltZPxFwLz8tSwSYKf3el0vvl+w1PgJneV43d1wddt6PEH
	 pqSK8jul61MKij78nJ6xLJsRt8tv7grYuYaKbP+ZxoPZivvHtoEsXeee6wJJ6UehBKlC4
	 5eVrPCAimzge0gsMSn4nZumLuIvFDj6dXH3X8LIKxMQrRAwn9oKIpiiWZyADmV4aanDWg
	 R+ITcbfYO/0DFiYP64Lz02ox1YRZaoZ90JeXrM88QQA89lJ3SR4y7vVQKkdhxRn38gx6O
	 eWkgwihO/ZpTVMpM4H12ujZ0eAwoBLbv9GBFa9HzD+Shj0qa/GVXOaqdHRTW+nhUcOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596351;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=GPws2fb+0VBj4QpwLPNESWNNjeqxUBviW+mbsu/g4yY=;
	b=Of31oWkY5uc+rshkcmG5AAQ9eT/LVFjOkjfAHKecHZVXtCZZGYRcJTa2SPdFkUMz0wQZ
	 F94Y0Go98ztdatxUJH+mlJAXvN1COawQb26Xg0zqwHxY71RYCidWa3MOLkvXqQowQNIAK
	 fonLseMyK2yNLWhCavLPI8CFr/GzJW4Jp7YPFk/rIK1rfJYfb1eVANjofi/lMPY17gEUp
	 PWkyTrOBc39tsypgZYvFiqWOMyoPpoe//uGunMjmKQFO7yqleUx75oSzzsjpqxdy8CF+3
	 RntaqUOMngI0BzvllCrkBBIDb9KxifOfUTcxG2jsnkVkJVzPcgYaJUUXDREVD8qFdlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ICBR1w3x;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NiXHRUV1;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D25606B2CC
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D25606B2CC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ICBR1w3x;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NiXHRUV1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3E197A00DF
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:59:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 13:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794596350; x=1794682750; bh=GPws2fb+0V
	Bj4QpwLPNESWNNjeqxUBviW+mbsu/g4yY=; b=ICBR1w3xWjwV6bra9b2eoGPNGU
	J0kwt7ee9WwM8zW3085kuu/raKWlB1oLHUWsJSzhql79dwIMeVLaD+UNuO/3vkkX
	htOlSVwLfoei1xwoAcodhTpyYaHWidAW1Vz0nz3Xmd7KiLlliR2mRUZuyZpj66Ml
	3933ccRMc44ycZjMB48RUl8oyJTE4Fth/MCpNio0te5vJH7egi6FrsDnkdpA7x0p
	qSW4qaUSTPD76SjZwOxh4TCW3zgtEBuWUBjcf7CAI6IrqgXUgOnA8Fh4VXawiBSA
	FQA7aelFdznvdsJVVHpZF8ph6WqbgDHLCzdHluAKdlntGzayjjzNsThrA5xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794596350; x=1794682750; bh=GPws2fb+0VBj4QpwLPNESWNNjeqxUBviW+m
	bsu/g4yY=; b=NiXHRUV1phueKC7GF9stjmRwVDB8rKjuM1EBQWT5dJdILTVd1Tc
	E7zOFbq3GkTHLCY0zWLEFE7SGUMgAkVJsC1XFshCxtKRnwAaE04HToA5kIAM9Bwh
	gh9VT8uO0vYATdrWU76F8MT1bto7nAugYJbv38kxHIm1IZehcb6G4/qUQIjbzG5e
	8Gy1bd252YIFKuiS/vcrISJrLCo4gv3H/mlUYkkT/6061g2S/Y9Gv+ZCVuQZIvPN
	jSDX4AuAmo4eaTMkDqshvhvhprZOqDaGQ7Yw+x+wC7lFEu4oMbeOWJvI7yC+TLyK
	Yz8Hv5loVVpZpe7xP7SKFN3JOs8ZfxofXfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794596350; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:P74q4AYlQ+zdkKUn7CpjRn3BMRgOlCEAsRMcZPIXJ8fOTpa
	ybwWI7keVquQ8QiGEv5mJOlf2SE4b0U6/7On9bgYu0tn0+8VZOvcyLf4rQq9q4X2
	WnHBNclX/k7LX2EVqCBrf/IybxhB3Wk70yxWVicq2/QeEm1iZ42EQuC/Po3FC72+
	Lrd29Sxb8bRAINnGsrJhSeCrs29yJvoM58/1j5DCP0qobI5V6vq8+1yQr1u+Brtb
	01apP+SBtUJcsY9Gdj0lUWjAYzTXD1SVEjMGKHl5BbcZ/2y5MTBrxqOdA+6kldAC
	sEeDd+LisQstXKgjK7rbDzZsAVDQmeN3qhDwjuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:niMgCQt1h6ctaSVrYBZZgLwJI2USgP6CgDIBy9d8AGc=:GPws2fb+0VBj4QpwLPNESWNNjeqxUBviW+mbsu/g4yY=;
X-ME-Sender: <xms:_l33arveW9q-CPSaaCSUqqxa7htN8Xo81FYmZH61pZnjqVCTk3QqpQ>
    <xme:_l33arjSBpDq3e_p9tmL2oo2iTJzgpGu6djpFSniJ8ElQQCLx4H5Uj3kRGH5Ratjo
    rjHYY7LyF1PgZUOnAneeukrqXhiWw3DcE1AcpHPe_giB1CfKpBjQvM>
X-ME-Received: <xmr:_l33ak_GZdlJq_eDH8mpid4icuTLyzsmz0Oxx_KG7py1AaZ0v4HlaD-8DJEoSYcpZuj8m47t0ZODXIFIj5MO1H9JPklCdrMxo7hi>
X-ME-Proxy-Cause: dmFkZTEpsCvB+oQgh5GmoLv7N2VkFL/UeRXEeBIV98jy7hMM8Qp8VcPNqLZJKjFjgAWomz
    Wtf0WGTyAj7IHZhdIlspAHon9rt+PSV7uwV0Am9Kb5gW9dYHUzyUg4x3pgdpvXIJ7yfrog
    Q+JHE42g88ac3ZDzzZ09dxKeeUsD2ZiDK50kDtAaliUlsVq8g8X/ZDA5ex/AvUUo3R1KlD
    X8KlDqYxpEi01gLNNuJ3KbT/Hsh3oJxMakQlCjqItE9lYU00eNxIiSSJ6U7VoGAijZZjIh
    EkgnbJYSFwpkCpgXL8uW00f4Xc1sGfJOUkVPSN0AsgyWvAll0fKidhSGQuP5pdmuiCm1Au
    n6sfwKLOPDlyYqxB8u8SKDz+3CHjlPGxsUuRbT5C4lr1o0nxc7Pqd37k5zHdlByBrfjcY1
    +AfPCDqsfuGbSsQXLsnndku+D0+RU7JuFpCZmqYLxRX63JyqhY0KBYqVO8h58LVFKoSMzj
    reKHlSmquNUQ9uJnGRjN1E1oUSleU/DLkYInNjyIT6NqZ5B8HuJzfexpk9GpurfF/4GIvg
    8XS9kYmfIr0UPxZm6D54Ow8rZNMIgZQqCHe1xh1XkTbiW0KlwFFE7ytZBnfSr/YiPMQGQ3
    8yRNpP6mIB26KsFHdQ8zrJ6vZUo+LGvDrJZc5i0u3Z/nBGUjvYgWUJQBA0jw
X-ME-Proxy: <xmx:_l33amuHPchDQzGWFMVAA0mdttuQ7fksZO1vQSFrl9ipxXtErgH8Uw>
    <xmx:_l33agpZv1IM2eLhaJKsa0xbOBwhmG8fS60diuiCN26q9gAW76LS_A>
    <xmx:_l33airjZ8cPzmQUHP-o3vazbYdGmYvdLkks5KHTLYOMYFU0ED2sEQ>
    <xmx:_l33anbFzpY5rfNbcLmIF0z_jHqQ5He_1_HC0ACOcjJ_s8s-TlQxNA>
    <xmx:_l33anhHtjT6pkq9qX1aH-7NMtZFJzvsvT13-DdTMaAgI6lAjkH_qWVm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:59:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  kristofferhaugsbakk@fastmail.com,
  ben.knoble@gmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH v5 4/5] ref-filter: add %(currentworktree)
In-Reply-To: <20261111152811.99986-5-me@jaspermayone.com> (Jasper Mayone's
	message of "Wed, 11 Nov 2026 10:28:09 -0500")
References: <20261102182930.3511-1-me@jaspermayone.com>
	<20261111152811.99986-1-me@jaspermayone.com>
	<20261111152811.99986-5-me@jaspermayone.com>
Date: Fri, 13 Nov 2026 10:59:08 -0800
Message-ID: <xmqq33t4d0cj.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> %(worktreepath) names the worktree that has a branch checked out, or
> is rebasing or bisecting it, but a format cannot tell if that worktree
> is the current one. Comparing %(worktreepath) with a fixed path in
> %(if:equals=...) does not work for every path, because a ")" ends the
> atom.
>
> Add %(currentworktree), which gives the path of the current worktree
> when that worktree has the branch, and an empty string otherwise.

"has the branch checked out"?

> branch.c records these branches when it reads the worktrees, in a
> second map next to the one that %(worktreepath) uses, so the lookup is
> one map lookup per ref.
