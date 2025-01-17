Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2F1F6673
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737095241; cv=none; b=FJiNlJpFvdASBCT4cSQHj2LGCiZFSzCQMxh0g/X9ixy6A4kOXiH9UvMWEeyXFwCsVC9E4AblX6lH021MDu73vc52yLYB94TE8/HIfKV2ljN9yd2PvKaOOt8dFtr2+RHKDWNQCBy4PZprTZcnkVDHScxlnYewaL/EEDI++TtSN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737095241; c=relaxed/simple;
	bh=WtBvpCEhkxcZHHpi8k/FF0+OP+H0DNTO6KRsQDt75QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYBDNXSZ9FuePlsgU65DTTx9AOMXo/5Yu9IxjgKeDFbmTvpfV5qm4tTDUK1enCdKGpf62FuOCQGDsd87Vhj+ucflekJYLiP8RXH0J4DyWMZedqk3mL22+sRzB4XeOW6h5AXsvFDjaxotzXJLd/+oVLLPZvchoQe3422kg44LS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=brNIKOaH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vustOLdW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="brNIKOaH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vustOLdW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4025D13801F5;
	Fri, 17 Jan 2025 01:27:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 01:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737095238; x=1737181638; bh=P0AKV8S7gw
	rE2QtryaF0k8yRnv2b/zFDtGYBCysDjqM=; b=brNIKOaHpq5NOTl2mM6N58h+pC
	YELycZu6yUAOGir46GDzISWxHB/OOGXDWQwf2ZSL2pE6upqMaef6IEpgxh7r1IWN
	JA/LNaoU2cFHkED6+4uCthWmDqp3ciMMEQdIqL+5KyfMLMQjWgj4dkG+OywJy2LZ
	Cdh1mDB/cUCcC3bsZhIhZp8jzIxxdBPHaOpUh/MqiZ8J+QkbxKaxvEMAR2OwsTmC
	AiBzT3GHitrr0yuBe+lKK9XhOqkfhXSMqsa2KH7ekjGzpdnQ2Ghg4QZjzfkq3CnS
	WxZxtyH/MRpx7CnJc/STdNjDDrV825pPuWDceY4rwMpH+mfhtR1CXUqe0rWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737095238; x=1737181638; bh=P0AKV8S7gwrE2QtryaF0k8yRnv2b/zFDtGY
	BCysDjqM=; b=vustOLdWpUWuZ79aSoKsdBc0kNwyov2aDnHHxaZwNxlyGYMcu16
	mo7hYj9rGo6cSj14tjvDLhrYe+YyyKS1kUWa/B6F0hGpw5cIvWIqaaBVISi214KX
	BGfY/hOFRLY6/yGhSlZE+U8AcLoJjGgTFRh17pjXvEVbWkfvtwIlSqF6ZjmA7n7Y
	omZ1+7l8I4en0rnw9Hj4H203U0QC/DpUNWG07bhKATyy59I7jvwnJXFxm9zf3vCl
	zDD5L8cdvQkpNk1gSfuRDk+XkG0hybdC72Y97OvlEXJt4seCavxyp2wjKpAjWr9p
	eg4Z0AiBUhCVMbme31q5+iEiSj8smJeGzuw==
X-ME-Sender: <xms:RviJZ8XOrfgLi_jl952yXsnd39CmrlcvBF8ogODiekP5uB4Ofp_GgQ>
    <xme:RviJZwkkWMXteFzwz-V7W2QwRUx1RLXjZvonYV42KNw65Cosl5m2PZIAuaG8kSpKw
    Dp52PpDMZCUw0RqDQ>
X-ME-Received: <xmr:RviJZwbGkzR6WL8-ryEXWAcq7ZtI0koP7Ii6LITI4KmpEXW2vSvxZGzwoZfx-dGlY7E4FsyR1k9xIXRPRuHh29beNf8stkky1JppvYGkmRYUoHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RviJZ7UgQC1rAgtIuOX4Gi7Da6FBXKum8xowGV2G5_mSl5eXpC7-xw>
    <xmx:RviJZ2lP0DrvCUvPNjwDr59BFLmxy85ZTDl2a65NQLvu-UKQvoa8pA>
    <xmx:RviJZwfCvPXHMD8zyMqTcvLyg4oOeOoQOsKJ6eifwNfOxaBuMcy3Hw>
    <xmx:RviJZ4F4wprDfRwPqXV0mSO3CfoFQkL6_kfKd3aWrWX9yww2GOfigw>
    <xmx:RviJZ4jBgjMp5BFkpzUsifkE1b0LZa0x3qNLCumDjgo08_TUyibMgTZ8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 01:27:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a4e8cd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 06:27:16 +0000 (UTC)
Date: Fri, 17 Jan 2025 07:27:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] t/unit-tests: handle dashes in test suite
 filenames
Message-ID: <Z4n4Qyt8qSBMVXUQ@pks.im>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116161559.91038-1-kuforiji98@gmail.com>
 <20250116161559.91038-2-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116161559.91038-2-kuforiji98@gmail.com>

On Thu, Jan 16, 2025 at 05:15:56PM +0100, Seyi Kuforiji wrote:
> The script is designed to extract function signatures that match a
> specific pattern derived from the unit test file's name.
> `generate-clar-decls.sh` does not pick up dashes in filenames, which
> prevents the scripts from being run.

As said in my first round, saying "scripts" here is misleading as the
unit tests aren't scripts in the first place. How about:

    The "generate-clar-decls.sh" script is designed to extract function
    signatures that match a specific pattern derived from the unit test
    file's name. The script does not know to massage file names with
    dashes, which will make it search for functions that look like, for
    example, `test_mem-pool_*`. Having dashes in function names is not
    allowed though, so these patterns won't ever match a legal function
    name.

Patrick
