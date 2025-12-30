Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A982B9B7
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111092; cv=none; b=dzxZpuzoKnC1LFP6VA6VgKghGYF6CWnBdiloycMoIxz5wSvJHdwqBF82u5URQ8YS7kGjvK1c97WZiNVhWlsOzZHw2BQ47flG2ZQDCxr7r94i5gxAJQmUfbai6vay0b/ZHmUAtoc8ySvvdjFNGwG4VC91t47bEYAgt8VkqFKaCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111092; c=relaxed/simple;
	bh=1S+LZTowuI67gb6QiU9bOpbn9/opiTPjsF0OIng4Xlg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Js/msG7k8g9+E5/ce+h/cf2LFEfKGL5Vr2HSKEAOslwlr4NNJwHfZRKLkQ0Fwvky12UwIQYusdLPCjQpxmS5FQPdCrLrqFNv43Qmjaz3ANWzam71vv+6+1T2hXSQoqql4AyNS+c1gE7apCWATaIoaGTEUm/93hrL7uzQUEXWoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bhMlzUzA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIzSn6Nm; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bhMlzUzA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIzSn6Nm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C90641D00087;
	Tue, 30 Dec 2025 11:11:29 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 11:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767111089;
	 x=1767197489; bh=1S+LZTowuI67gb6QiU9bOpbn9/opiTPjsF0OIng4Xlg=; b=
	bhMlzUzAcNW3S+3B9PKotdVThiVF8K5pCC5Zkwyxx/lOl0vZdECBxFyT9SRSJFFM
	mKmefHm62872i/h43KF0iFcdzfKxgm1fMl4Y0SRuwDABYIx/zj51n9A3X/RXutTU
	a3ga3d3b3LAunO+ohxFAEt3zHRT9HeWVR77Au8OwWH2VNl5GS+mIl6RLpc4eVPzd
	JjyQLUKLOPbHxCxtddLIWqgZkhFTlisA1Y1sTBVjDNyeKej1HXhPD+Aj4kTRzash
	RYX6uqPS2QHm7nsGhtf1cxDpbRUhYPO2pm6Y/Szsi96ZNbaAj7VhCmEbuEiBIkTH
	TIGlh8HPrMij6gdKV49lNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767111089; x=
	1767197489; bh=1S+LZTowuI67gb6QiU9bOpbn9/opiTPjsF0OIng4Xlg=; b=W
	IzSn6Nm04OcQW4FA+MVjRLL/gUE79kbLJslDzpa6Mj4CcClBeEYQOVieVRsCERlO
	RvlX/+CJQpTqnU5vcQ0ftCTDdTNnh+Wh/tQdhn2R7/ZqXI/IDmCaWLwIbg7DQPY1
	m0xGlgl265yb8ADfyZxiBftg9ppIBln2Lqge3khiaI60ozmfGosc9pvkSbkms/3S
	vtLQA6UKIb+AdmB3GiJS7vC7eYd+borV92YY/8VeIe5Gc4CLluw9ioRorlMy2ZFR
	zEtcEhrCq4V8BEw8TkNNHtR/PU5MnDJyOkSieMmwzOnHIRNCFE5porV+X6o2UB+L
	ltfoDvh6nz/mke7Dw5W8A==
X-ME-Sender: <xms:sflTafV5TtKTfiSLsmDbnjvG8PU2jo-IYDHAUbkjsaQO-fQBJ8TFanU>
    <xme:sflTaSbfZsxtxclhsC6u55qlILQhTjk8iTiZQ7WqbVl5TdSAgBGbZCPVSDvQu6xqV
    OZfyIbWZ8l1TxU9dr3xM64h-awW4zpmPwjqi_fFLTf28QS5GCPN828>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sflTac8AZggahtoxOMdGQWVbNmhfM9PPpUatJWDyjv04QCgEkLeTzQ>
    <xmx:sflTaShgHFLQV635ihXIEGgsSe0ES4vgviOAaGBb_Jv2EGxfyl87wA>
    <xmx:sflTaccWmnYjGEKj99bWr-brEi1fweRLiFUDOyEF_2IFyvcOejkbvQ>
    <xmx:sflTaZrKHNDwqKa_NkZevHHKKvrAQazIKkSJAun12wqTTSB-cmjOUA>
    <xmx:sflTaRwmPcKYlH6mJV-eVz9-pNeAzbUmKdPidW6XFquYDXZZqkqhGG0e>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E0911EA0068; Tue, 30 Dec 2025 11:11:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3vRUo9Fbwmg
Date: Tue, 30 Dec 2025 17:11:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <66032fff-654f-4c46-a7d4-e80d594f2df3@app.fastmail.com>
In-Reply-To: <pull.2027.git.1767044697712.gitgitgadget@gmail.com>
References: <pull.2027.git.1767044697712.gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff: avoid segfault with freed entries
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 29, 2025, at 22:44, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
>[snip]
> The more elaborate explanation is that within diffcore_std(), we may
> skip the initial prefetch due to the output format (--name-only in the
> test) and go straight to diffcore_skip_stat_unmatch(). In that method,
> the index entries that have been invalidated by path changes show up as
> entries but may be deleted because they are not actually content diffs
> and only newer timestamps than expected. As those entries are deleted,
> later entries are checked with diff_filespec_check_stat_unmatch(), which
> uses diff_queued_diff_prefetch() as the missing_object_cb in its diff
> options. That can trigger downloading missing objects if the appropriate
> scenario occurs to trigger a call to diff_popoulate_filespec(). It's

s/diff_popoulate_filespec/diff_populate_filespec/

> finally within that callback to diff_queued_diff_prefetch() that the
> segfault occurs.
>
>[snip]
