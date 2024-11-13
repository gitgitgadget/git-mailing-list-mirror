Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9372594
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457574; cv=none; b=q6SU7XXwD/4oniKftgIF8IMOH0w6NKTwBSVtn/hZt9wT0to72tjBWVuEO8xUjQgjz+9ubC3jGKceGGFQoNxHYZvhsuRKq4og5WXGaXtT2gWRlDDXr3bGRIdnv53WvMTwLSKDMFpsol31b7YpIQ9QTqOUm4+CtNWQ59MkGtLcpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457574; c=relaxed/simple;
	bh=3byW8Q6cRlOIY7w4vUiW6G7AWTN7c4opBBYq6UCgXzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mB7fnT5CUiC4taudsJZXyseJ6pcTv7snk3MFwfG95PhHJ+U6ALA0OPxsSoSJPxRAYKLcwRL82HpfFUjMmWPhsZGnhrmdA1jFOu8guBAf5goeZXMocS4m58DpsEbQj8QcomTfMt9RteHlRZ6jPXYrZDhHmlu0VKL1AypVMpHY/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VnERezcR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VnERezcR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 53A881140186;
	Tue, 12 Nov 2024 19:26:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 12 Nov 2024 19:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731457571; x=
	1731543971; bh=Bnrze3Qu+4gfsGTTRnZ79aTKryfrBDLABePrQqKn0Vc=; b=V
	nERezcR/gRzDQdrpWq/1+J/x0TdK6CiHo+jgUwwIO7O8QEQRrpCnRrxqaxrba31d
	ZkvRCgTyGnUtM2p9QKgnuLRR35SL8J1SchcFt0ZBEVjUmWulBPvWAhsIgFBnsNDX
	WvNl28VT0JBobpjigVyaMc9/Lwp5FWT6AF85esU0kTTzTN1DA2Zq7VMXJO6SCn7s
	eqHZJvkynq8D6cRkkcfguSnlDdstdJSJoyPtrnxyiFgR4qSI1/A6D+ge/mI+ttJT
	fdIwnyPfHhiSzTQ4lmStlzoSZLcNauIdLU+dTVJJXkA63WTmR+6Ouvxje9bpok7E
	HqwDtkgEUD6Q85S9MZwBg==
X-ME-Sender: <xms:I_IzZxV3RDhTtg8eRUl8LyWTqygC_8JhK-17_FEu66UtLg58ReecEQ>
    <xme:I_IzZxmudb1kSt7mBZvWb1uO8YRD52ctTPShYEUaxpEhdzS9O0yK4IRbgj4Y-psbs
    cj8z4pc8v5FykXWvw>
X-ME-Received: <xmr:I_IzZ9bu8Yl4aLsV-ut2MRDGas1M2S_7TW1QafQlhwamUc3GAc-l8Rc89W8cZs3EP_59NJNttwXRjEOLaptSNet_NY3H1eVSs7yr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    fhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteejieeuleenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:I_IzZ0Vhwh6fEqWhLmatTT_VmKotfG3wgGgghoZAwGSQiS0k_KRfTQ>
    <xmx:I_IzZ7ksB3oLPPzh3xnH1yf-nE7tRWYyC1K6OFo-OP9jNUqsOFx2pQ>
    <xmx:I_IzZxfdrpAwBONcftyPLnKkmFmLn9uKQBsLhyCZ-kzGbeyILzOz-Q>
    <xmx:I_IzZ1Fe6OrsIFwBZehsiA_hYrrU2wLMfN5UeP2t0lWUfjFxbuIGXA>
    <xmx:I_IzZ5Xw-jv0SLehlAXJm3duU8xMQTMlUBcChzA418dnsEVASdl6wbpv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 19:26:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  stolee@gmail.com,  phillip.wood123@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 0/3] sequencer: comment out properly in todo list
In-Reply-To: <cover.1731406513.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 12 Nov 2024
	11:20:10 +0100")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
Date: Wed, 13 Nov 2024 09:26:09 +0900
Message-ID: <xmqq34jw3roe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> The first version just had patch 1 but this one fixes two other places.
> The two other places where unearthered during the v1 discussion.

OK.  I guess they could be handled in a single patch, but the three
patches address different things to be commented properly, so having
them as three separate patches is good.

> Rebased on `master` (b31fb630c0 (Merge https://github.com/j6t/git-gui,
> 2024-11-11)).

Was there any reason, other than "newer must be better" (which is
not always true)?  I thought there isn't any in-flight topics that
touched the sequencer machinery.

> Some failures that didn’t look relevant.

Judging from https://github.com/git/git/actions/runs/11774751134
(which you rebased the topic on) passing all these CI tests,
if your topic saw CI breakages, there is nothing else we can put the
blame on.

But let's see what happens.  I won't see CI failures on individual
topic, but we will see what the topic, together with everybody else,
in the context of 'seen', produces when I push today's integration
result out.

Thanks.

