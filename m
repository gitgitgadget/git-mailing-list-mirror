Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627061;
	b=Yq8/f7PvlX3M1czksJ7VreyZZpKWu7jpJyjSZPAYT+RKIHgUtl261tsrpjZS5R/j9ZMA
	 zZ5YlLc04x9AMLIDFQwSyOYD7lge3cirw3jrMvzNhoTWLcAOvQ2HLLywB5U+0z1wiI+Qv
	 hLsApnXXvh8UhgtHIQXusV9syfe3QfCG12ZewK1CuRkyyFlwAMC+ZPGB1IAk495bYzw6a
	 9B6MKHIxdrQrKgYLGKe3qQxpRA+LY2iMpJlB3oXoSfKsyz3uhr3JBTw2S9Eche64CQmNZ
	 kLkdTVaplaXp8uY4B1xi5PKdTf+gGICg+ehtDWT0QLMivLvpTlbuUhl07Fl5dFG6PAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XT9JYmIGW+yDW7J5jMk/mEsnGKFz5qYy8gwYyXtJn/w=;
	b=Bd3ppqpyQU4qNlnKgEbZbVFSD56PjDQI/z8rrwFRNEobm8guiusgcD+VDpc414tcnD7e
	 JeE5lhG6e7kXP9VbhxeTZS3ftIDgYJ1R6mkHBQgaTLZtdJEld6IvT9feJ3IY8ATS2r2bM
	 o6C+ItVvytVdCv5jTqMVzEbc2mNR0iFcE6qxkzPz/pLojitzv9DQvmJp5CZGBMY0ASMjr
	 IcBKTlGD0k5XqaV08II0VFBst7Cek87ctvhk5Q8EmDCaDAYNzsxwboxHZFP44FsYOakxe
	 NLgH7OPxLz2R/8LldUu+uoyIjrCuWaTq3HIXPU6CYq1HyrveO0lWQOcqPWb4JzjJK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WmZ2W4eU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2M59rIFL;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18425606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18425606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WmZ2W4eU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2M59rIFL
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D6F71400189
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:17:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 12:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795627060; x=1795713460; bh=XT9JYmIGW+
	yDW7J5jMk/mEsnGKFz5qYy8gwYyXtJn/w=; b=WmZ2W4eUYgCXwIfGeG92ZDZRu2
	YKA36cNod59S6uZrqn6Jjk5/8YFoQRHx5icWzlHrDpvgbTiC/j9l9VA/QIQ9Piwg
	LWbwMAj7Fe5oLEFfEz4ZlxDJnUv0qbVgF37JbdW+X8lZLHLr6tDjlr6wrFT3XmQl
	EAodTDXYHoSe8+p1BY/VRTyFDKiNm86PlUlbqX9UZT6kAX8+KjWGxeWPZH4n0xi6
	xhCCDwIhYGRUtkH+bvalmayGxW6bdnF1fLo802g7rRaiuE1J+3b4CyaE2bLXVcrf
	gM2lvgfbKX2PNlbQDqRmOGwHtbJzkk7i+Pb4dz8eRo0MMWA2PqTx9nRLXB/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795627060; x=1795713460; bh=XT9JYmIGW+yDW7J5jMk/mEsnGKFz5qYy8gw
	YyXtJn/w=; b=2M59rIFLNhmYhmZQ4Q5HuzduTcg6w5XICUi+mG83XrTm0D2f8bE
	QwoWk57csw0CrM8QlBtR/LPWt27kyniucnPPr8KxScZErEcq1zWkHwx8tQK6feh0
	PmIeEi5/J00CLq3sxp5psrYgLGsOPArPfPQralz4Hj/nRxZI3tHA7Dkv67IZMHyt
	hItc+fh/IYApSqZeW5w8veoJefTtgAKRA7fhcbtfo5PPc7nOO3Guc7o8UTMYLggz
	pyAg0qFTt2ECXntdQnLQvEb+SVWYhodJtgBrtYT8QklxI8U0rXTxazv+dmb7vICK
	hotzkDc0BgLg5wtUxPh2jfCf9Oc0Ij6kNQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795627060; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LU/fgsw91V7rbiBxx2g1VijH1CWo4yPixC4E7Jz4pzcNV6L
	jLS83ZK74lJh34mGT66Nqylz9Roc+gLgRqDXhuYW0HpzpGFcWXGEPXV+oVlpVQXN
	mLhxyRVwy9QWRZwRlxpI6TCuj0B88jnZyHzfdjt68lIykV5Gf+JNvCWHaGNkejHu
	Jf3kVzQPUpQ2259HPsCeVKJfhj7y4vb8NPw+TaFi906bRWWX8su+H+/WWrOeCaHo
	0lcdqo4kt4AXWoHAoc391k4CmxReb03qgYV22oog7Y1ogA1sY259M/ooXFtjfMgf
	8b5v8vd/ULolGcBEWjKjiDOELbU9IDlrbQqi1MA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LuYm1NZB2WMO/nAnM8q0KPfyuGPh/ebMtD39gjg1Llg=:XT9JYmIGW+yDW7J5jMk/mEsnGKFz5qYy8gwYyXtJn/w=;
X-ME-Sender: <xms:MxgHa-UWFP5Bgdg3z69AHktZ-Bqd2iwJQ5F_h2fcxS2x74P3h5cJcA>
    <xme:MxgHa8Gn3HGVOLEb5tjAH5zpcOVsyT7d6zJMChrwBDs4HgBXuydirFcP4ICXe2Kwy
    2-9TPK6euICmhPvkMRsFJ40TAYkCVFIELRm6FwKmMIaliGalyW6PJg>
X-ME-Received: <xmr:MxgHayeQrPJXh7-x1hNLJX1p5K58RekEdcaL7NhdFODk6bbcd6QXJOKFe6A4KUdo0yE4J8o9rdx4fBLMcvj4h4lkoBxPTD2UkzUmZcM>
X-ME-Proxy-Cause: dmFkZTE8byxVtBb9hZ9ShsahndqnfqWqDQs40YVwobhwOqOIXs+jdYTZJ6AQEN2okt132E
    55iKBW80gu05N/ELPTlt/JNY67ruy6hNZcsfiwo6KlqRYCnZ3e3TnuNYItaPx72JWb6aNz
    i+jK73VTzE05AA9GK2IXYhPygbx+FL9SWV8gB4uorWvPGXHuiCwgtGql6e1YFwt5kk5U+o
    30SYEmKD0inU25Y+t89gN33SI6+JfihbmbINnmv+kX6BI6JmKKQh4yHnHEywhT8RS2XrOw
    5jEonZ/Ssv6DH8wDl6ThK+1JhjUTd+3LEzsF+NbWxMC6UEvU3UJjE2SFDqQ5+eXwAgVeeb
    f2kTkCCQe189rNWQ1JM8IR6kxR95Jjt7GfhVomGQz0tPHsDOWm6t03KYHrpaCRqSiX1akb
    wAUR6WDU2VnfoWDYVE5U6OvpepLgiz0kg3rV1FoCO3/eHJcZgQsxpIHUNKc0+KNFeuftpw
    c8O1PK4Vy1lle/n/T1KWO3A+mNi+nW0ufd5rVuH3MRSLIBCb/6pchrwN/6O4ra71PUZkRB
    vqf1Kx1ebMiERe3VqhYxMraLV9ORjznxlz+TJhKAUjT3J4SA5QmXuH/Z9hB4AGlqneo0xp
    bz+CprenE03EMRkqGyfakoE78Qsw7VLRycID/HrvtvVoJ0t1dQOHCD+x45LA
X-ME-Proxy: <xmx:MxgHa1LE7BY1xPlAH3eg9pZQGXfrBgrgYkLGwDYxdsBsD8CcRQ58eQ>
    <xmx:MxgHa_GKAunKqqwT73lDAwq5Z54JGH5aDVOTFWblLCmFesxjAG_AsQ>
    <xmx:MxgHawDwhooYMC1W7uDaQ0z2CJwlvCYKd2Oix8stup1yTy5lOFi_ng>
    <xmx:MxgHa6-K1783iAYFTmC7zmoqvhUNPjujuh80a5iYYlIGpflQ6KvgaQ>
    <xmx:NBgHa3iRXtAFajUHNZykG2O2ie-Ij80fUeJJxt45UZgPalVbs9KNqXmE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Wonseok
 Oh <wonseok_oh@korea.ac.kr>
Subject: Re: [PATCH v2 0/2] sequencer: save the null OID for an unborn branch
In-Reply-To: <pull.2317.v2.git.1795577024.gitgitgadget@gmail.com> (Wonseok Oh
	via GitGitGadget's message of "Wed, 25 Nov 2026 03:23:42 +0000")
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
	<pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 09:17:38 -0800
Message-ID: <xmqqwlq07rv1.fsf@gitster.g>
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

"Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When "git cherry-pick" picks multiple commits onto an unborn branch, it
> saves an uninitialized object ID in .git/sequencer/head, so "--abort"
> behaves unpredictably. Patch 1 saves the null OID there. Patch 2 makes
> .git/sequencer/abort-safety hold the null OID for an unborn branch as well,
> instead of leaving it empty, as Phillip suggested.

The split in this iteration addresses the feedback from v1 cleanly.

Keeping the fix for the uninitialized OID in .git/sequencer/head
separate from the .git/sequencer/abort-safety update makes both changes
straightforward to verify, and the test adjustments in patch 1 match the
commit log scenario well.
