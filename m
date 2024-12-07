Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21211E505
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733613851; cv=none; b=SNwD5mCrm38FkATJxAA3IF33gUkOao1+wJvNU7NBTdV3+H4pEi6WD73Yw8xpSYwYXJDsxG5wSBbR2H/gTEzrXgKVJQetXKjskf94mEo/lyQkttVOXboxN/a3xrqgsKIRIzGm+apNOgdbVhRmJeXzZMlqB0YavgXGfpjJQAxa84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733613851; c=relaxed/simple;
	bh=TbLL4PXhGD7ytrqDjyJvkweInEw2WMO5PL6pRKb+q4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QO+VRae3BzBcptExzPj6DsY8sMS6FQuNy1h2oCvyZBU1ehdEh6fLidUZ5R1LvmBhC3vGyqP9BUhGKsDNGaZG2RCNwED5UINgSqgIqpiqSZLtR4XpmNkrptAeSIXDlt08l2LcOi6WLoJmiqinlz5HkCqk9t09LeV7+a5d2sf7K34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmqAIrGs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmqAIrGs"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFDFB114011B;
	Sat,  7 Dec 2024 18:24:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 07 Dec 2024 18:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733613847; x=
	1733700247; bh=Tbs635GdvT77s0kwSA+f7KLFkCSASmIi2neEpmt1xoc=; b=H
	mqAIrGsJO0OiUu/G9bvb/M4RIWzaKSAR+M1lKCSjCAsYJToNj7x4/mrIuBZsAom9
	sW4EV6aVwD/96gHihUxzF3oK0BQQ6bkhpU1jNFkqQjcKpWBzI9hBd/JhWiwD53k5
	4noHz2CIEizSoHoyAD9IgA3KlcSqQwsrnmc++L7epQRoihlYArnMb2H+OY5tXy78
	q7+UosCgfMZvm/LbdfRCHLrRj2Nq1YZ9Zcfm4wOZdnsX6kNgqGMk1qnxZXgwEi/Q
	/NgKHHYK0fq7fulfHhpYdkGPKtTBm0Oq/2cYd90vHxDcSOiWc6UbFNA5v89dBZDQ
	oCFpgPcQvXDpbj9TrHzAw==
X-ME-Sender: <xms:F9lUZ8twliVVi4sI4iksdlquz0Vdfxz-Ok-3fojjWox-_mBME0EmfQ>
    <xme:F9lUZ5eEfnc9IQTRrqIdMPd8yWXWMxUI39fRTNPUfkL0SrpaTvBBuHBaoTSfxu42m
    ic8rwDlofALctUQkg>
X-ME-Received: <xmr:F9lUZ3x2krBUY8fYqVfRdpKEaI2CIK3hHrItK1hZloUCoFTcOcCDFdOyL9OuAjqx35h-TRit-2HeIeFU24UGKIeo3reIwpcjXjmkP-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprggrrhhnihesvhgrlhhohhgrihdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:F9lUZ_NGA8wqVEcxLFjOy7_kSczW0A_eQarfbQdjccEH6bRbIiiEsw>
    <xmx:F9lUZ89Lay1SLLNGVuOC73XotOCtFr8eY8HYI5Lba-CYOX4sB_mjBw>
    <xmx:F9lUZ3XdhaKPX4xoh_26BkdTvUKB17rOp45tcTnKppfUN1aB3mkCLw>
    <xmx:F9lUZ1f6b4j8uiL-fBMAISalZSUlOWxWFoDiJgTLVVi69dNrzYLX_A>
    <xmx:F9lUZ5Ni_voyr4YZ7oCUKA8GczqEn86K_yaWUOAhWkAsGNC6uTcUW0bD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 18:24:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Aarni Koskela"
 <aarni@valohai.com>,  "Jeff King" <peff@peff.net>,  "Justin Tobler"
 <jltobler@gmail.com>
Subject: Re: [PATCH v3] object-name: fix reversed ordering with
 ":/<PATTERN>" revisions
In-Reply-To: <3ef4f213-a49e-4d72-8f45-00a5fa030852@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 07 Dec 2024 16:51:39 +0100")
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
	<20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im>
	<3ef4f213-a49e-4d72-8f45-00a5fa030852@app.fastmail.com>
Date: Sun, 08 Dec 2024 08:24:05 +0900
Message-ID: <xmqqcyi3t6ui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> This isn’t “e.g. ':/<PATTERN>'” any more since you are not listing
> examples.  “i.e.” perhaps?

Will locally amend (and with s/PATTERN/text/ to match the relevant
part of the documentation).  Thanks for carefully reading.

