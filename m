Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03650610B
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976327; cv=none; b=VfGN+bmgv4hBPE2loCFelkHtEbiH5owLLimpQChmhOuYENr3EZjAbsL/3eoi3BztgHJRpGBJrjAptazInD9kb3AIjVrC2yUXqOvE55gwa/1EfZ09wU5LARIM32Eirada6qwFo75gLKf/rg0hyAaBxFcdM38TTz4Y6ro5sjPGYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976327; c=relaxed/simple;
	bh=0Iy4n0c6ACkTpi91l2JdQuRBlWxPHqXWA0pRAqrp2tM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4AlfJeajlAfKshgqsuoSkW4tRQZxmhSDQZkku6VFGxnD6CV6s57E4uxiQ2JP7siUs3EkISW06LHK7I6Xx+/qYwzoyh0UxGrrXm4rtrZpLwDvHR7swy1O0pPkQ5/uezJ1RA1ZqrqSUAvk7Q1HZFt+JMvcHY0/GXutnam3MdI1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2yECVC6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2yECVC6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CA2E254015A;
	Mon, 18 Nov 2024 19:32:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 19:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731976323; x=
	1732062723; bh=yz4x1eim2Rvmt/Xipg+GDS3dYDS92z+dROyDzRwRX/s=; b=h
	2yECVC6OidiEjv7Ew9HirQraXBvrpb0x4E3Lwq6C/cEaAd6VAWxWSjw7M0qx0scm
	dh2UMHc9Wf6UJfTfZfBq/SW4jcPPjAy8qPgHmkksD1xImB3fN/yPoJY4cOjkBZrk
	pG3bIh8b6gpcr/JoNa4LL2sAm3hiaeVrNFLdSIAISnfUolFL+jkj7gegAwDLZ+kM
	wIvgyr8cxuK83gBH4Mu5965MevEOMPNsJLFikCXvbwqymgvEikHEVnI3bMs2vF9f
	yjF0/bZnubrjJ+LmQCRmlsW1j47shYJgbM0RzaFmk6qwNEjokyfJzuF1QctjixPl
	KVZ2uy7DVKD573MtD77kA==
X-ME-Sender: <xms:g9w7Z6M8I9Ka69f5-j3nxAmC33-DUyLqjKy5PNqjdcCBqFsFQzs-9w>
    <xme:g9w7Z49ftakirxV2NHjwSVYV4MCi91akIlELvSCA5OgiTemhd9KT4oCakwytdxEOS
    crSmuRCXQhjPQUqmA>
X-ME-Received: <xmr:g9w7ZxSCSEcczXK6Llo3hELkBbt8HKKQff8F-yDG3NVwzJEnaEj0n4oG1ohiRGgifmMxs15bm75VwhlX-HNl9YvbahPFPQUO-_IF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiphhhih
    hlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehsohgvrhgvnhdr
    sggvtghhsegsihhtiigvrhgukhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:g9w7Z6vGEAZVwlzVe2R-Jb1GqwHYu8EUXG6ksrsd_5AAAROfKHLToA>
    <xmx:g9w7Zyf9iVMsNVf7aJLoMMBuArp3rszqHrRX9DRroVIjsKB865pshg>
    <xmx:g9w7Z-1vDD7m6yjtThHNtoertOIPf25naO8EWlvOB1DBFxgr505PrQ>
    <xmx:g9w7Z28n9L6gAZVEFpSvtO5kc3KrO3I7_OOAp6LVtrPuPozspIWG3A>
    <xmx:g9w7Zx6V8zo_t4QjR9FKu34Uxg8nOnR6YrW8s-zlnDWmykwIyWt-dzmD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 19:32:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: =?utf-8?Q?Bech_Christensen=2C_S=C3=B8ren?= <Soeren.Bech@bitzerdk.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Possible bug in Git submodule update --inti
In-Reply-To: <8db6eba3-a151-3819-159b-921a6c3f3242@gmail.com> (Philippe
	Blain's message of "Mon, 18 Nov 2024 14:22:18 -0500")
References: <DB9PR10MB709879A45AABEC017F3E89DF8A272@DB9PR10MB7098.EURPRD10.PROD.OUTLOOK.COM>
	<8db6eba3-a151-3819-159b-921a6c3f3242@gmail.com>
Date: Tue, 19 Nov 2024 09:32:02 +0900
Message-ID: <xmqqldxghxml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Søren,
> ...
> in the doc for 'git submodule init' [3]. Note that this is _not_ 
> the exact command that you ran according to the trace output below, which is:
> ...
> I think what you'd want to do is simply:
>
> git submodule set-url -- <path-to-submodule> <new-url> 
> git submodule update --init --remote
>
> This will fetch the new URL and checkout the tip commit of its HEAD branch.
> You will still have all the objects from the old URL locally though. If you want
> to avoid that, you should completely remove the Git repository of the submodule:
>
> git submodule set-url -- <path-to-submodule> <new-url> 
> git submodule deinit -f <path-to-submodule>
> rm -rf $(git rev-parse --git-dir)/modules/Submodules/Lodam.Standard
> git submodule update --init --remote

Thanks for a pleasant exchange, RFH with sufficient information
necessary to help, with a detailed diagnosis and an alternative
offered.
