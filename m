Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B97224F0
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198978; cv=none; b=CuZXLWSLZPqtvzGKX7AAlqgNQeb10cmSRk2HN20CCtiVR/YQKZoPl+TalTR/9+Gc/ebfwizX+hvGqZQSc/s39CE4jKPmCzLzCjc0kxoD6HYRqEtuEKraglPYi808Oy6I9pmeBSnx09232Ks+1IJseWjQFS8XaBocu6CAxFrxyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198978; c=relaxed/simple;
	bh=8Wg2DzSYnR6OXIzji3M/+3bJyM6nprFaCNAFS/DLcaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Is+N11Va86BH3RfIgUeZJeUyKM3tse1jQ/QzcpcNSGqZ2l8BpIMSYnH6q60e9QccwzoQt9DGBphyKHwmkxYebRy2yAGjYMy/MfbMmF08LydhVOKJxmiHE+dGyREgUPB50x5VmOpwF84PuTMP4aPoIeBZI2NYTEVtdvD/EmhTf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tcTum/+1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcTum/+1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3864E11401F4;
	Mon,  2 Dec 2024 23:09:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 02 Dec 2024 23:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733198975; x=1733285375; bh=79YPwILZCosvNCYlTdTgj70MS2cch5TItVd
	I8sYsFZ4=; b=tcTum/+1/K4xG1OcPPM8OZV3e/W4n/B9s0cT88cPf3NNsuhA8nX
	8n6USxOBe3mKigcIvV3/MkzNZ/TslseVEyHJxFcrg/ZYCq/dXaPk1YnwQkF0dyuC
	VVV7OxWxjje/R1dbx4FyYZzXi0qRT0HJ2kaRzr/kUfOnJhs/aZoqcITxQR84aF5Z
	wsOwFeDTlnKrrPzSzS5CT+OhB88F4uIQEeFxcm9+kHVzuSL8IVdGJw7OxvwKK6NH
	e7m4NerkdA+lm/Hlj0OtBfPr9d9A0qt98aQF6LK8hGQCvUE26g1OO5udSZCYSgmy
	Q2t01yADHQ83K96PZamD4kps9bZYEyLCeUw==
X-ME-Sender: <xms:foROZ_IHpdKdfahLpPSWpJ0P8jxT6cESsbMDA7NQoMWcE2pQS9JQ1Q>
    <xme:foROZzLqdWzhYhzpZbzgqFOxJx7_Px0AVn-DH5_NumTRh-Rr_WkcqhLFJvSCaaVQe
    nnlbuxKSHMYWO3etw>
X-ME-Received: <xmr:foROZ3v7FVgV_rRAh21CMl6UzxXl7UYgKocTrd1mMnVb80PyzkuBXTDqQRG-LC5SEmxCAj6f2HW4d3---18MBGFkqchEt9-JEQEwGVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhihrghnghdrthho
    nhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:foROZ4YBlAX1JBQMlfIwFLEhTcjCD1WmIgafyV6O3FkmRqIP4K122g>
    <xmx:foROZ2bOLjEb_yZlIRGxTBx-u0Kw7uWaH740Vwsoexc2koGPVhFAFg>
    <xmx:foROZ8AhTDlKEIE30HBiVsldhpMrgkcTG49v8avRw2er1TzCnQXZMQ>
    <xmx:foROZ0ZwWtsI3RKDFpXZWpm4F81rLAT8BXkgNtq_-jriJ418aEda2g>
    <xmx:f4ROZ9ybePGkQ7qQImN1Yj-_TFvmV3qrjJ1F57-aOO6bK-_LriVV9RIc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 23:09:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,  git@vger.kernel.org,
  hanyang.tony@bytedance.com
Subject: Re: [PATCH 0/3] Performance improvements for repacking non-promisor
 objects
In-Reply-To: <s6adlnfgts43vamiyzdjbjk7bqwy4gvudskclr76uunkgyktbp@pziio343f43z>
	(Josh Steadmon's message of "Mon, 2 Dec 2024 13:25:20 -0800")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<s6adlnfgts43vamiyzdjbjk7bqwy4gvudskclr76uunkgyktbp@pziio343f43z>
Date: Tue, 03 Dec 2024 13:09:32 +0900
Message-ID: <xmqqwmghe7b7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

>> Thanks in advance to everyone who reviews. While review is going on,
>> we'll also be testing these at $DAYJOB (I've tested it to work on one
>> known big repo, but there may be others).
>> 
>> [1] https://lore.kernel.org/git/cover.1730491845.git.jonathantanmy@google.com/
>> 
>> Jonathan Tan (3):
>>   index-pack: dedup first during outgoing link check
>>   index-pack: no blobs during outgoing link check
>>   index-pack: commit tree during outgoing link check
>> 
>>  builtin/index-pack.c | 49 +++++++++++++++++++++++---------------------
>>  1 file changed, 26 insertions(+), 23 deletions(-)
>> 
>> -- 
>> 2.47.0.338.g60cca15819-goog
>> 
>> 
>
> This series looks good to me, thanks!
>
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks.
