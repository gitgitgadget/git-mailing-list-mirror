Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340380;
	b=F/mH2XQFaRE13ddrTZYT9HAuOL5rElg4Enz5VeoKfZlsdzMI4O5BSH4EjG2qix3Gw0aX
	 KWS3NPrB9QDqH+4x6QdGOxwBOZ+ConK4ffpBf1M3OY76biXmI2+1oA7zNRp6AluUyzxi9
	 Y4pW2oQfSTFu1Y/V63c4cz0MnlTsqKWMbCwoocfIP3Pn4pYICqGaqrhYXCV3JIS6Ux1aF
	 jAOpXghCI8O9rH0Tz70G/OyGNoBKvYOBbATUaABORazlT6INLdOOV0UjR6tJEM2U9HJIK
	 z/D5bA4NjoHQFc+hwLGUGsCYiNXRkKRgqDKbThKP+YW86Pv0oKjUvV8N6HCM/ttmZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+qFLke9DEAFbghowUzFRXO7/Uotu4ccSUhKquiQNwWM=;
	b=FFLd1Smtqs1LfP1vplHgVkYsAMf2zE2CLF/wEIA72hgBVZnO8r7wB2ckaJLqO3dqr3NQ
	 DE3X3GAKlesy352osXJGK8+5edysg47EEqeNWwL1/XXQyFxGHcMtEolf63vZU2Y3N2asp
	 ratuajQUmeq4xGYkGVOv3n3FnRgqbobuz5hZV3K6SFVVy8kb/fJADZzxte0qQzx3KdvUv
	 3thpQZyTjuhKWwUF0BbWbj0AH3jjYsoToLZ1UounRVp3O5/ytH/K6kt3FmK51FMS2M0dV
	 ly+txU71MqKAb7uSBCV2i+aWBIRhHwuB7OcNTM2kcLZAqaOcwIFFDkpsjVeo41vjWbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PKzf5P7J;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hGGNsXIL;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EC606A336
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA2EC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PKzf5P7J;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hGGNsXIL
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 59C787A0186
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:52:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 14:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794340379;
	 x=1794426779; bh=+qFLke9DEAFbghowUzFRXO7/Uotu4ccSUhKquiQNwWM=; b=
	PKzf5P7JwNcmOI2x1aHlOGjjDlFjvGipsBCZX3bhrbs/VDo3CHr5UABDOsCnv6EN
	RqyUIABw7pl2qRQLrrjinNltkTBr/lenSKBEcL6gVI8BhaQLCwwWsgQM+2XlSnrY
	A3MAML7aA3fFZFRCIo6rl7G7B43PDIuKDbrwSIMfTPDoBsOhjV6fX5vF2x6tmD7P
	UbwPTQnntupi48TNoIbOFWdvwm2f71W5GiAfrmCy9LZJRxm2PC1dROu+mqXl82ae
	I2Jhmw9G+I2Evtr73ATQxQXKNW25pOecJ9SKsoTIw+jYgqgL4RqqIKAAAszAuEXf
	n1kX9XrQk0byj7J6ZL339g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794340379; x=
	1794426779; bh=+qFLke9DEAFbghowUzFRXO7/Uotu4ccSUhKquiQNwWM=; b=h
	GGNsXIL7ssni6gCQxm4KbNTcFHOuLnBV+iK+8pqZAagQxktZ5EbIW0RsE65heSDF
	owl7FeSYuvAlKqZc2XQi5zUPBUi+UGDmn7hTtWX7wcyEZdK4ZL0R/NUH/aHQA5Vs
	r1z3JP4pdwMUXNGvkGLkGQAZxVkxzJmszDOVHaZDpmms0mekqgDJd6O+ThLqmE/v
	NzcDj1ka5YjhdCrD1jinXTVwRzOtR75sBLnQBuGpWnQAaNaesjhA81xS5Nx+rJ70
	V/KMpEIgmm+WSvmzmnDZWHv9DzhOUa/3K4FGN5pdZRUKA4QEKw/ckqRxNl8c/NqW
	E+KLPuVL5HPcy0T4acavw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794340379; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PErWglmQI26uHZQXk72Zo+NsTvO5lRFKWYTfta/fL5FgdZS
	32RSt6kw4RFx5RD96axuYUXSG3cy/hZlA0xzsqLC2BsXZDmJ7ohzc8Llten6KqPE
	WKd023zyKDY/6524tBNItTnoepb2+HZU/FyLQQatr+3rtpX5kiuXj9M05NS8wzsq
	xqovYyBCagk9HFwOU68OP8OCAHmM2XIvwIWau1wvpm9VMRnv6uK66GsSHAV5V2xe
	kTF7+k/2x3L4yqro+JmWprzE+5o/SrIAVtT8ENKsdva5lj9YrOiY0Rh+OXkjuM5Y
	6ZNaqyI21bt0Wl5I5c4G0NUnvIZR8AaONE91SxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Ue/lsmHzvV/Eo9NV1nX5CuE+44cmt4Fw18ARgqead/o=:PqcJyc3o6Un2bzVHy7NoQn/lA03KeYXyBIjJErqE8jY=;
X-ME-Sender: <xms:GnbzamxKLmohLff_nq5pyh_5NNi0s_7NOAdW4936U__jgVvTnHLyOw>
    <xme:GnbzapR4UXNoVzUfH_Z9LwIX4QSTneUlJX3q7WFdcZYQqMHe3bjQZ7CBDdoQCxy8r
    onAIFMsOw6v2S2M476n1ZAMTrBB436u3DVKdkj1pZwWedwXRdqyKCs>
X-ME-Received: <xmr:GnbzatVcXzoYiPMKR2BjRuZ6uD-OW4BUw7x8BzEFUXsqeESAQDDQKUBGWLDjATLMKOviXVXxNN3wyDX0YfZK9ZJgz0DLg2gGiEWJ>
X-ME-Proxy-Cause: dmFkZTGVaF7aM3EfDZkhu8e9Ke3gQd1zMeT85kyq0cN782hUjYcRsnRY5DN2eGgWMvEr/a
    ZL2bvfEeR4trdT5mo+iVe9XUKy5gSs21YyFIz0cNLwLJVT5xReZ4MS+dF4apeXhJGDRWNg
    ZdhYBmxBck+8PUE7y9mzFlkOS6g469zLaEk+I/5vxm3z7sTVDPosjtqFsZUe84qoGX8RnI
    LqMnCafgD1VBCwHZEpqxFlLqj8NRlfNiJeDBP/v4FD0NTNqGJmjDAElJ/kWwG9sZ1lTs7h
    KVseddlbo2gemGigR+Ww13ihikDGvHRrrt/TGhvNeIO/dmLDPB45bDNpTWCwT+ftsaj0Bt
    DOmud+Olw2QUNhVeYHg5UMG74XRbSI3z968qQ0qctoojKzLRIKZ1c7B9dsP8S9fJUdSBeV
    DdS/s3Z+gnP0I1wkiOCsq9X7Tzj3nud+vlJSe/FGhfrprg2nuyrPxFvECruZCB2UYL9a01
    kEdPihjtCd5d6JoyKGxG/OAZfRRfXOCoGGva/sOZ1/L/+uYTrvZleoyirGZvLpD88DGSvF
    m4shdIq6jJDZNi2n/RGhrs8zStwemO9wSA47P39KkuBLllZjfa5imAcyTd3IMDTGgsTaAT
    LPRc2v+nAj6f5L6X6eeYAEePk3Ln8/Nsdo8UwOWUXMYXxQ2soo4oJ0/SDyhA
X-ME-Proxy: <xmx:Gnbzarbyfas7dO_7AYjSwa_EanksS3kGQxYaw7qFI83nE0ZJuTg9yQ>
    <xmx:G3bzaj0RuW0dW2G6GknPhGKF7kPwrJ8o3pao34qeugKGOUMgdiJLeg>
    <xmx:G3bzathyGxamik3kkqqDiifsbXDbtxMWgTGpw2jyDCDneWfvbwzUkQ>
    <xmx:G3bzanYJ6cmRMgscYdrR2nOFJDyAkYrOPFYGeOsPXDOfis5InWL0Sw>
    <xmx:G3bzaisHPRqt1K-o4MynxPGioWSAHOPEKtnZ6CPUoMCPWtRGndXbwLiH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:52:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git
 v3.0 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
In-Reply-To: <xmqqfqy4b7oq.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	17 Oct 2026 09:41:57 -0700")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
	<BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com>
	<xmqqfqy4b7oq.fsf@gitster.g>
Date: Tue, 10 Nov 2026 11:52:57 -0800
Message-ID: <xmqqjymkqx9i.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Luca Milanesio <luca.milanesio@gmail.com> writes:
>
> [Administrivia: PLEASE TRIM YOUR QUOTES.  Most parts of what you
> quoted from the long message are irrelevant and did not help giving
> context to your comments below].
>
>>> SHA-256 support across the ecosystem had been a blocker. GitHub reported
>>> experimental support, with general availability expected around November.
>>> GitLab already had public, non-experimental support, and libgit2 supports
>>> it, too. JGit remains a gap; Google was not planning to fund that work.
>>
>> It looks like the above statement needs amending, see:
>> https://gus26.gerritforge.com/schedule.html
>>
>> Google will present their plans for SHA-256 at the forthcoming Gerrit User Summit
>> and jj Mini-Summit at the Google Campus in Sunnyvale CA.
>>
>> The talk is at 2:00 PM PDT: "SHA-256 in JGit: Why, What, and When (Xing Huang - Google)”
>>
>> Anyone joining from the Git community?
>
> You forgot to mention that the talk is scheduled for Tuesday,
> November 10th.

And then we no longer see that talk on the Schedule page anymore.
Sigh...
