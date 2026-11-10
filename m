Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331738;
	b=bnI1EZjTCXSwCc8Z1j1TSuFkYhauA23KTOAIz46j40snvlE/AIRmP0HCo7wMd6IKLgWg
	 oYFXp1pFGDAU6UWdK7LZUvLEEXSsb4McThxEs+/UodmovTEQlMUFFUslYGaP6MMRzEtoO
	 yu4UcZWvynRxlKKVJAg6RCBJOOGYBT2BdK9kKLaK04DALuG0unUpffghGPGDfjr6hmjzN
	 5xc8E4I71kbSLYDJ3kFub44oV8HJpB4e2UIZZ4iWsuzSdD54JLG1G/u79G2v63Tc8dGEo
	 yLr2Pnbh7M/itayCDMhj4aY3LL2RSF8QrnNXrtwEmLAi7/mVzSq4TZplC9+5uOomzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331738;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ojL4oq94Retoh8H9zWasszRFgOuP1/Av7asPXSa4XCM=;
	b=yGesAY/Tu5eFPcwJXSGE0HfoRPlms0o6aWQ2p9Rpp5cu+x1HMT6fAfgn/i/W8BiW9+mE
	 nR4Jy3Ex/Lp3MU5z8oFMqWBBg9551RvV8t1lGAAUbteqyDVRTScPAk/XIQvgRQ/YhEAIp
	 o6xD0++nqTtkXKhmpEBQ7vo3i4HFm8IIDC1HSyL3JEM+7mKAoqxIpZ2HUBkLSK73ZyrKl
	 ZjuG7GdHa1kanUB3CNwtQ4f0lVNeDVEqoCrznpbMwsamt6DlQPL3hX1JXMiRv0ZGqbf0U
	 VnHjgqJlymnQildIZOq+K8ggJP2xd44ntGFNdIo8kbdWMRB5ANJDyRZJiVvSIWmVpaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SAlF7Gvq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="SYDbN/3g";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04937606A327
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04937606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SAlF7Gvq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SYDbN/3g
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 677FF1D002DE
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:28:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 10 Nov 2026 12:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794331737; x=1794418137; bh=ojL4oq94Re
	toh8H9zWasszRFgOuP1/Av7asPXSa4XCM=; b=SAlF7Gvqwr3FqiGqFbZxrwEiS9
	+oXOkzlzxVKPOY7vLBOKnRJsQM6vYUgrxlGikb0uLOzkb79+9lYJZ0Fq6Ho38KCH
	EOcJ7b/r3sIgkjuMcfuTdzAcA+Tr+mLW4pm2QTaHYbQEjt5p8fxQUnKu9aK1eoNS
	UQhGrMR1/3RlUAXfNA+w9bDfcCvwODiKgN26FyamgW6e7npvqqLFA8SgbvsoRxqe
	zoz11qEA8lpdQ5TwKe1POet20G2hqNrrIop0idjtUNT1UqU1zoKIZjEfZ1smGmFd
	w6SNHCggFmYUjzCnOOImAughkbM6fhve03JjKxhqUcko7wkwSdcnPfhC8g4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794331737; x=1794418137; bh=ojL4oq94Retoh8H9zWasszRFgOuP1/Av7as
	PXSa4XCM=; b=SYDbN/3g254Xkfwts4HLSEm4vYO+aA1lAJd1/NHuUjGwM/YYm2Q
	KNMOmUXFjpD0AMJS6TgRr5V0NNMsJg+vWGZsG4ca9QYQuHc2uPSfzVOtd6n8U6/0
	ynmBu5rb6oZq9FdWLKewQ25IwxLw5J+0sFe54XWjAylUEYxYlwIca7Tlbv5yXi0x
	Nd70C6oZb3i0VSUATIMhVC+KUYgehWJ81UtfE0B8Q0OEXe6NWZeGp1XKaD8OqAsP
	uPabgCJAqmglViNGiexxDqiKZ0SApdfDOHEOWfawgyY2rwpifLsStH88WBcLAY77
	BXy1e27ZzZCEGVsXhOQTZsYmPGhB8rDe0qg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794331737; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DeGFlqCZG3JcJLrKPFV8a5tlaeh/4noWflbkHm/m3BZCQZn
	2dAsHqGvfUY3fsfzRRKp+Lt2KJhn7Ip5zvkGs8tdHj4ZP0/3/2lFQvka9WZYckaG
	cSh9kNhws3H4wLnZm/Rsz9jF/3sAx2jm8aqHCrZ6zNK99UmMDmyeeBTSowbQ1TQZ
	axADO6/vDwiUtXsb4vga/WU9KPLZrDIPBPRhdvqfx7SLj4azmgtwWGbYY223vqpf
	wEuI+wjOm+iJ3270VFsb8LH2fI7hLe6jnd3dQub/79eaF2csRsEEEtZD7BpBTRYa
	9D0/k9VWp1COUzNMoQwwl8Q3Wq0nh6WcH11ST8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Q7qOReSOlq3FCTXWMLqD3CCgIKWpgpaPplL8RVmW4BY=:Q8W8oH4sYlvJOlWFeBaLsAYzYVuEjzObkl6x8YXP1mo=;
X-ME-Sender: <xms:WFTzaphXoPbzFKB-cyj-_owBQuK_0YUeQY_mgRRoREwftYfAV3dZCQ>
    <xme:WFTzalfT6VISmqmHeRKleN_nrNjdA1WUid3j8_6qG2FPi1_5oWgb382bE4RoaIWLc
    h8fLvUNp-9RrO39dP3ywz3cojehy8K5VIyBiqd-6i-VpSo1db7276Az>
X-ME-Received: <xmr:WFTzamcuIdzEopDTwSVpPECYeKmysEYCHqdPsEpp6IDnQ_R6A7QZlQFmdBQzhGAV25lfqWSyfWuC7ylfXTTkwZkKYWiTpG0zcqS8>
X-ME-Proxy-Cause: dmFkZTGBPorqV5eL3Zcp7Z2zwDbLgv8CSCzISfUW5juLdZAOf3UkC8mYH4TfuV+J5YNxxl
    zr+CxXE9kQ03ttsZ5QABty+W2ySqGmFjGY6xJzE7V/aI7r5MeG8uDJ76JXHcTmmhqgSD9U
    HZbNpOjIhuLdSZJfRE7sWnnwJqjPDDmnuOr6mtWthT9UhGL3PnX2k2BbB4w5yUkHLewgzK
    RuWDdbmac53kbWse2klfVyZc673jzc76QCDCg3C6P+byHD7EIQxzhZXBemh7tW8N+1VN+m
    eW5Xkqy/qojai6XJxGN9x6k9JkJhFTD8LXtmMYOa/VMgZEk0UQIJHlTED+xCo4I+A7ses+
    ZFKQ01udQzn/EzLJEXRmkWkTorl1TPlRamEERcFb4pr5tkB8NdGimKmHEFVnIvsM9FJ7Ea
    IT5tVb7F10MmWOGplvemzlt+RIU3dtCDBJwLUaBqgjQj2HsplfGkxaWxCKJXsx9Yhg4wUR
    a+SUfzfAXmhqumlao3SqcpP0F/GSXuYg++s7PksVfKRBgFd6ckQGjqrbH/6lOFAfALMAtI
    TY9SLWGYYvVZjQt1Nm0WYm4+CL97SIlOPicEln0/Wj3whK4IZPJPbDxQMs/MIQ2ZioSF6P
    EUk/HxKILjqxFOeaUnurhpibg7wPFnXVsEcN+KDIVzYkf3ux/YS9PirTR55A
X-ME-Proxy: <xmx:WFTzan_Pj4uLi4Yztm9MBf5R0P3Y_IGqPr_O63uCmQegCypHrlz3Bw>
    <xmx:WVTzaqnuHHYEheYpt2AeoFCMZF1xn4njYZlbi2KwiMh6VxC6m71NYA>
    <xmx:WVTzah_1GuVJqzssX0zefAu4xcbEt1IFiXg0jXt-FNOkLj_thl7kVQ>
    <xmx:WVTzaglCGw21WAiA0z96Xd9MIfSOR0VEnxTaAxXyyqP5jwxPycFpOg>
    <xmx:WVTzaldwqQTLQwl8NTPXZAQ1lKkGKAr2MkTHJFG8NNBPiUTz2_Rw88NU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 12:28:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] unpack-trees.c w/o the_repository
In-Reply-To: <37267fd4-c565-4559-9c5c-01d58cd0426d@gmail.com> (Derrick
	Stolee's message of "Tue, 10 Nov 2026 08:22:26 -0500")
References: <xmqqtsltbfdv.fsf@gitster.g>
	<20261109205438.369060-1-gitster@pobox.com>
	<37267fd4-c565-4559-9c5c-01d58cd0426d@gmail.com>
Date: Tue, 10 Nov 2026 09:28:55 -0800
Message-ID: <xmqq4idotx2g.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> On 11/9/2026 3:54 PM, Junio C Hamano wrote:
>> unpack_trees() API serves as low-level functions to implement merge
>> and checkout.  It heavily relies on the_repository, making it clear
>> it only works with that repository instance.  We however can use the
>> repository instance pointed at by key data structures passed
>> throughout the callchain.
>> 
>> This is almost the exact copy of what I have at 
>> 
>>     https://lore.kernel.org/git/xmqqtsltbfdv.fsf@gitster.g/
>> 
>> The only changes since that version are removals of two blank lines.
> LGTM.
>
> Thanks,
> -Stolee

Thanks.
