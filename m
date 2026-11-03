Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725312;
	b=vRUFRwztcm71d6TpzWlK/4ksEnz92yIKoo1Z5GKNj92NV8EfLehoXDOkcmknSTK/qrDP
	 E1X0IQCIW1G4aufRGchywAy+U1bj68eQj2PR6bAy4xenqNbHExfG7MkiE2sFLk4O3nPIG
	 kV8Xm3qnKujfPKhfaR4LqysMbohOxySZUsDAG2Yta4t78X0p7CggrOzUhwWPciRJhqYET
	 TSGeEiu6LB1zYxW8DhbuQ+7R62ZAeVfO/Nw11vWVDgkhgvWJxjzyb6LkluHtaaKLyZxsc
	 U89uVr5aIW8kppdxxzvANw1V2y1FSup080k90bcAIlaOOZ45M/8wN6Y44OmybzZpPlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725312;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=alHvWS1+fp/XoPEWJpAotpybjI2rHZdt8VZUygY12p8=;
	b=dlkou0SzjKMzngerL5wpBCApmHER3vo6shIYyLEI2v9gGquEb0bvR/rjTd/5Ne/c+b21
	 SBNpshud0mdXMYraikqoIafNMsjUfC9J7brUpSVgNNegeC9cOCBZSaGpLUjANa8mkHigJ
	 Z5QBbcCylkilPlziR/QV6ZnvygHuwepstS1XjgpJFLpzQsYqqagTFF1nQDY4/Q/f9LyIW
	 aVkrmQTB5gqPgppUMy1uvdnJlYFFvPdC2FRWNHj+M0zsM/yAlC7VAxRfVHM4glSPsOVPK
	 1vh7Y9B0/pT1mwph1Z86n1IM+K/V7o5Yr02l/3MrL16votvHhhBKSgiKkTlZQtY8BjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DxfKWbHV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h2BSwxdH;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E036606A328
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E036606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DxfKWbHV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h2BSwxdH
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 89C79EC0094
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:01:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 03 Nov 2026 12:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793725311; x=1793811711; bh=alHvWS1+fp
	/XoPEWJpAotpybjI2rHZdt8VZUygY12p8=; b=DxfKWbHV6fJ3qbD37o0N/PWzuH
	WZwVgr8TA+FCLuazoZJpo2AzN6X9X5zkvRavZEyZarGcLrk26Alx7eoIH3T8iui1
	3NC/MV1YCkiV+cLS+TayFmFphQjE0KLkLckRSmMxhcMc4FA54ZK+kl5LN9PBR52f
	5avhwNjw3CzHNBbrVDYkAyqsamNnBvMrxVnWBamjR4gghvsbqXPTQnP+RVscWYI5
	ORFyx8odz3uDH7lKMGoxpxp1joTHgfLO7fYuUZyOMoxYKEqiH15WucfOg21pdWfU
	bc4GUONJwEnSWX4gFNU0DLUiQGgoWmT4m1Pvgm4Oyn4VTzfm1orRvD8UtN3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793725311; x=1793811711; bh=alHvWS1+fp/XoPEWJpAotpybjI2rHZdt8VZ
	UygY12p8=; b=h2BSwxdHXez5y2J7LeiqVSm5GdJQG4zhi7vzEmeDPepWnoMNJ06
	zOXGUE/MMTmIo125ZpUuAOsu4mBvtx9GwoSDn7hbeO6zpKI+TJG4hKYcb2ELKoML
	y5rS9hIUQkYrD3bk4AEPeiVjhEO5GAk3s+5tJQTshqYW2ZS1BcdAgcArWHUjAqEy
	n/egwwSHpCggBohJTIeZ4qX0Ozb+Xxp/2gLKXubuV3i3Sz7J4bMgw2XXLmqvjOoo
	skAB6r4EQ9eNm/taqiSv+Jz506ccRkatngdTc3zvzlyyT8ooGfbPT+Oc5tiFShf+
	iAQ7Hmj/ZUJ4h8XrtDVegDAcOFQe7jF8I2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793725311; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FNXG9e8t7erVDrUYMYSlXEV4B204Nq6CQfVwN9uJim/0CRv
	LM+yJ1A8D/GDzgsRA8SY/jCnYSOIukjkFoBtNoSgh5HZ5hjx3FeqPkm5OCVwxdie
	OYSM680jwMsiAtseZXM2OLUDro3K/8wRGR7eOirR1fU1thq+fxYIByaxbBnMd+wM
	xdXx6aYtVOFsqVxJ9JM1vCWSD3slXrWJ9bWfbhZZ28GX85ehbZ5lm+1h0sLmZ3D7
	M9+66NpRziENh556BAUph50kYE7Eejsd+/HePEQNEMBZr+62lxlxgmQR8BtJmpqD
	8IJv7yrqM6mljNTH+ojqC1AHnDwGSmcym3blu8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IVI1RUxyiFX5gL4fA8Kh86v4RyBaGi/DaeYor1dEle0=:6GHqsO+ECKtqL8U5LyTezuAfVsMQ6L/2Ld71KvVQ7UI=;
X-ME-Sender: <xms:fxPqaiJXgwrxI9Qd82YkABAIuKKx_oO6eXefFkZyOvD4D0T_9h33ng>
    <xme:fxPqapOg9ddXaa7ku6n2u9lBoh2EIT1Km7FJeP30LerPKqpRFu7IYX3SUIm_Vez2w
    UYCUoWKmrJFvDw5Sz8fyG0ReI4_TyAoenFZKOGc8xI0kANF_EprzbY>
X-ME-Received: <xmr:fxPqao4u6rYBTFE8oTSsWgPmodieFpUT5fsnzQtJo-1PO6UZgIxfX_JRbyB6hgaRNd8q5XyFXj2tHmp3T8OH9gRK_81uE8HeCo0->
X-ME-Proxy-Cause: dmFkZTGaN79W2d8NLsb4R0Egv+nAiRQgkl7rLvPhHd3kIPlOKI9iIsQCh0OI03J+WS1nWf
    7Zw8R8WPbVh+rLBsOH+8JHbuvoKsMtbXCxQy71o3OVgxQFpnJ2/Dwv1Ylgkza/CB8o+GTU
    dgSjHlmAjVIcY5K2DBlY2sO1Df2mCR8YEnhewkx7GCtI3Cl8MqtRkvNKietOHZRu1pgdT1
    9URi+6qy0nEubH5BwvDEIVwakrvcfFo71+UZcv0fkuEHsiGRwPmoibn5HTatKENiIweI2k
    oy/6JuGmNiceyRAeJjAEaIXTkCEtj9Vd3Jn9tpUSmjsLlxF8f76r+vtj0EeGXr7fYaZMYr
    BXUa/FI1lQzXN6O1y2WdaJj0wuVi1L45fOP9/7bwvGZnIH6WvofteP9nhJ0JARhE37uKQa
    ja4toHYr7U6gOICUCjdV5Gs0skVQi7iArXU2Ncdu6ijkJH96WuHyI9wlMpypL+gUvofmFW
    5Z24T/VIPNK7dwKeiCcjx7OMtDu6aR5zDiv/7KPqLJRQjHJ0s2+v11QxZcIMjkWpAah6Ue
    2LxtbVhgkCisrxguFm3pur2i0R8Nd7+gfJvPMPGaDJC7kC1AoAt2v84kEWimHlmUjN4fci
    OhooDM0t4qSjeBogp1dtv4IfEaO4qpjEd0ywI2rDmM9lhS68vVPcONj1pPqw
X-ME-Proxy: <xmx:fxPqaj6EWsuWt4lWMZnObykpuhnkW5Faah581wlCninUFifsmAk1ww>
    <xmx:fxPqauGQwL2rpI-C9HGNl9fWofsej7hwdZX9mo-qCNP3yAlWI_hGdw>
    <xmx:fxPqarXTS1u_6pAasL6bkD2_QcLVMWSbVYfXjnYZeBdo-XIMKRFdjA>
    <xmx:fxPqaqUSHaMWcnsu6Pi1hqfgn9XCPSElvDe8eIocXHZW9TSJt8IDkA>
    <xmx:fxPqat1VlO7Y76_6ihiLumY6gnL4Kk-1sUQNZvOxf3SpTQj32g4tPF-4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:01:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Aniket Gupta <aniketgupta3001@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  cat@malon.dev,  belkid98@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH 0/4] environment: move line ending config variables into
 repo_config_values
In-Reply-To: <aumOHhbTVW0bT3We@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 08:32:46 +0100")
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
	<at9HOXZhVcl53CGX@pks.im> <xmqq4ie8tq3u.fsf@gitster.g>
	<aumOHhbTVW0bT3We@pks.im>
Date: Tue, 03 Nov 2026 09:01:49 -0800
Message-ID: <xmqq7bitc0hu.fsf@gitster.g>
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

> On Mon, Oct 26, 2026 at 08:53:57AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > While these patches _look_ like they libify Git more, they actually do
>> > the exact opposite right now and tie us more and more to
>> > `the_repository`. So I'm inclined to say that we should hold off merging
>> > these patches until we fix that issue, or otherwise we paint ourselves
>> > into a corner.
>> 
>> Could you please volunteer to add a quick patch to add a comment
>> next to the problematic structure to tell people stop moving things
>> there (for now) and point at the message I am responding to?
>
> Sorry, I planned to do that but haven't yet gotten around to it. But I
> see that you've sent it by now via [1]. Thanks!

Ah, I completely forgot about this exchange when I did [1] myself.
Anyway, I'll take it as an Acked-by for it.

Thanks.

>
> Patrick
>
> [1]: <xmqqh5hzjdwr.fsf_-_@gitster.g> 

