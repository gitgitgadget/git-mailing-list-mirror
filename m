Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794113086;
	b=Xq3ragy/q5w5kmIagIZ2Ey740IYlsdp6ZSwZ3CSXQfgTCHpWAFLyQXWgrkaflixjv9IM
	 Q2bwQL4PLiKvK0RdyANRyxAg4vlm6AOJIYI7k8lWGr5AmprxTlLAyKB3FSJkMjGvZKaGV
	 RcQ/4nQB/84BlgszsVe3tciGPSvxuNoFsS2Nh/F/eUHZV/2qRsSTtiKZced3+bIHMoHxj
	 nhOb/GSH3oIgo41RF/Vtf/VRs4rKiSDr8gPkxp0hwFPYZFN4SJjn/2oIc3jGo+rNXMWwj
	 biCCh7iemb1l1emNCapKCl9x9PA/vLMJVWQjaNrspgMaYpu8Mq8FLCbpEpKphmQnLuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794113086;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PsqBExsTgvw3ASzODeXKvjOQf0+os3e3OQEYbGpO/rs=;
	b=2382eCjijaoEVqyu36pO2SK826hdVYyVBb1rYe+EhluAt17lAywPm9+DFNg3ttzRHCua
	 Gx8p+7onOLnsG+ieKDvyTuLU4DrLmd7d+PGi0NaJeVZ/VJDITWJjJEOe7qgHIXoCoZgCp
	 bGudqlIzbfZiVWyLnQld9kpC00VBUvH5Uu030h/m976+feTMG34tA7WgOHmQdfbsGlCgk
	 k2NYvsVuPtz2r3IFRWgB8kHKBTGeljY+OdzZP1d6ncNA6opMTQW8HNp1GUWpPAfZYE1MY
	 5ZZf8zDemXNWqSY91IowKA1c9yFCqCzHS0Mq4y0H6hyQfYbwQxa1EoTR2xzg0QC/jMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=h8ynP2c+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=33rJVwa6;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974D606A31A
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 04:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A974D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=h8ynP2c+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=33rJVwa6
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 011A51D000CB
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:44:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 07 Nov 2026 23:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794113084; x=1794199484; bh=PsqBExsTgv
	w3ASzODeXKvjOQf0+os3e3OQEYbGpO/rs=; b=h8ynP2c+2nGuFWy4tiGTAX0a27
	rsQfl4ioUdCllHm71ouXUeSN3seAY025rF5ZWo8wqTlYLa27x9xlfNq7tIet4C9N
	1nfy3OZs7ofTSUPNtyiv6YKqQxFVU1R6RVLk/3/+HDWPIKRCeabM9K4RQpTr5OK6
	v8RKdw9pxrc/psk1n/t/TBR0EZ8pc0H7CBYOfB50eiUAcIRqIq9O2HbIQoR8nE/+
	6NdcbM/1cdPuY18LVxhMVcXKrDhEHp/ca831fkl3QsLmgjB5+aD6jEyJHguH0gWL
	Z7aO3buNj7Sfk8KvUi5zvpJjIWS3I0YXTOZTJSzxCRllaZ49n+864/EaQTrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794113084; x=1794199484; bh=PsqBExsTgvw3ASzODeXKvjOQf0+os3e3OQE
	YbGpO/rs=; b=33rJVwa6W0CEDOcgsDXyA87NZXexcFcZ5YKelBoiCWVwQILXZar
	OSjOLg2Lks+1d1r0YLGSXoYH8qQP7lYt3x3dlWpOu7OQrvbMaAwIOskWM4oOsgVX
	jdU1pbO+kAO92vb0JwmBh/moldsOC035f1RXD4nxndfCeEjpgGdt/fDnN0esu5uW
	ripyWNwX5cxZAAXY/Fgz9GBYdf9AGyPreprYL1MfQLOOZFnEsq1ZdmD95vFjjx39
	+SQh4Eyo49YdO/o/K9xMV698+E0O87q1IZuPeAsT3N/78+r+v42kqM/FXoA/eLZ3
	RgsLJ2TrUMiCwLxsDURfs8PRS6EDPQgo09w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794113084; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FnQ0mp1rQpIRx9AFDyJLfZwgLhKoEtKKgv3Or8hyDAETcSp
	v+Zc2onDRU1F4JB5miP6ySoLROvjYmwI/Sh73FwWVZLYEJ/H7AiPGXvqxJCluz0x
	WYR2yjiSmS84yzOkoS2pxHl0p3qtHXq/XbMDC/kn5Hmy2kDRvDFK2oCGAGP3um7f
	vtQkr9vmDWBErZ8Ki/5zq4iVsvp7J4lub1ArG9E9qhqggICcys37hAl6YuXxm+hp
	NScodsHw480hko5Sb+VLVUSLllLnybA4S5vL1PqP1Mh6HMIr6Pifp36l5QS9krNn
	2TIic8kejgQJfkd4WeKiEhNSO3I2TuMp6Qg68Gw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BclDIMf0kaytV0YuSIVXApYk3W6D5eWoYlf9QmycRbg=:9Q7Txreakc1UmmZ0z3xzTXuLIPRfe+8loPmfZXxRp4U=;
X-ME-Sender: <xms:PP7vamG7VAwBooArC03yGyc0JZJ41XT1uSFyc5gJEn-teMqLwitqpw>
    <xme:PP7vauPUBVfuEDqZyR83bmVmV0KrJ2uS4_agu9SOeYFq8O_e9ol4xCTU8O6hcqriJ
    VhWjcFu6_LkOPx07iLGOSK0ekVxHhVddvqFNbrT-Gh9ZrE1GjYOjuA>
X-ME-Received: <xmr:PP7vaocpFgm3PRA8mMSYpKnFQdFLLqFNy1CRkmf5NyJQsnwvbKKeZ5NT-qVj-IxL-IQRmU0VoQDC2Qk1-kaXTGS6kAFHFO3wckKz>
X-ME-Proxy-Cause: dmFkZTFMzT0fav3fwU6hTZJ8Jdygi4TBCBoQqpdegfarKaBkCj6gJNNjKsF1Jbpv2Z7UoR
    98AfNIV1z8cuUiG1tUhStaQ8/M41GU/AlF9yPcP5oh2fhIUxts6IugiarU1aOPtXas8lcg
    RYGGulp9mj9odmRLe4OG80zoeVRUViIxktSWtIoVdde6BwsXrMeiojUFwFKCMa82IyYjlO
    mHmnixthrm5k248YDLZ6J4h61tH54rNt541Ur2osH5d+IPxwjVqp63aeffuoRknA5WokRq
    no11WQBDgWh95uYEMoJPraYxd2HF8TCJeukkRLoVdl4t66bwBnj7wxTnHUtgMKd9YPeOCe
    C55VF726M11XPUait+l7eXncSwrBxLSeuAocaodhNe5LWU05QhsSwxrPJiX4F5LSCUt3Y9
    EFfr2Pb9/i1IYuiFJL+xG+CvQjbqBLNgvj0gRR6RFe+fBOLtpcgMjfEaDJgDR5dMHkMa0U
    0Al0m5y8waVXugOXpCDtNApzlpfuD2CADfcuX/v9tuSTqBqhOMoKtmOrhUfG1EqrA/w22X
    zvVulkDt9dc5YlojHPwtDtck7dQnxs6LQHEly4aQum6fddW4cFEZvsI5/2IrZ7Wh3OLvUg
    C6o0p9CoE28e3UJGs7mraelFm6Ek17mPDrSj9ZuVaHb09ykFxijCfdeOtv0Q
X-ME-Proxy: <xmx:PP7varsi1KcetQYlEMCMZZvO3Txx9XE_-o4KWZCQXU2eV-8F12ak4Q>
    <xmx:PP7vapmIAHDA7dDZv5cutM2qELoms6LRki6rpg2DTDagHbxLZ95gfw>
    <xmx:PP7vatz4-8k8KEgimqTWcggW7xjuG2fB1aZXTxpdyYEh9wWXbD4Img>
    <xmx:PP7varPl5-rveOVdbYHrX-ZbOSyiW76dob4FGYFF1-rFyv6lPf4DLQ>
    <xmx:PP7vamuDCwj9FU5Lpcuo0oZnSV_Dos4F_Ew67KKyg7Ri6B1KvFxfg9Sp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 23:44:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/3] t/helper: rename test-genzeros.c to test-genbytes.c
In-Reply-To: <xmqqwlqo8c8y.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	07 Nov 2026 15:15:09 -0800")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
	<xmqqwlqo8c8y.fsf@gitster.g>
Date: Sat, 07 Nov 2026 20:44:43 -0800
Message-ID: <xmqqpkwg53us.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Needless to say, with this patch applied, the following tests would
> now fail, unable to find "test-tool genzeros".

Not really.  Even though the source file is renamed, the dispatcher
inside still recognises genzeros and calls cmd__genzeros.  In fact,
at this stage, "test-tool genbytes" would not even work (and it does
not have to work as nobody calls it).

So, sorry for the false alarm, but my point about not split the
rename + modification into two separate steps still stands.

Thanks.

>
>     t0613-reftable-write-options.sh
>     t1007-hash-object.sh
>     t1051-large-conversion.sh
>     t1450-fsck.sh
>     t4141-apply-too-large.sh
>     t4205-log-pretty-formats.sh
>     t5300-pack-object.sh
>     t5318-commit-graph.sh
>     t7006-pager.sh
>     t9850-shell.sh
>
> FWIW, if you apply [1/3] and [2/3], squash them together, then give
> a custom rename factor to the command, e.g.,
>
>     $ git format-patch -M3 -1
>
> to format the resulting single patch, you will see a modification of
> genzeros while the file gets renamed just fine, and you would not
> have to break these tests in the middle of a series.
