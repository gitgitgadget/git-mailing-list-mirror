Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49546BE46
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575520; cv=none; b=eop3Xn+abe8NMUqBdn8HF+ISfbpH4zfW7XbX26LBzNBKdRcmJKyecvuga85uLB2OsBbZTitCyb5TpWYTOBoFFf2y/WkeV20ZpWTvfw05jfbj9xZY3TOB+z33AghfslWXqzhMGWDCmk+iwEJqf+Y+TogNfQVa2mshaSoaPRut3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575520; c=relaxed/simple;
	bh=vG64O7QVsXF1WR1C9NAaVtpWFkEoLl+BjmO6Xm6M2AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2OoMRp8pCCOivxBnT/lYiadTBuRXXwuUDRENMI0VvbE9tT5skyEzNEhnNCgoN3roSGlxalnVeHtro/HgE6qWNiKDFvHr/G5noUnDKUpkx1psLhnQ0Fjr+SsBqxbL1Q5EyhtG93BI9p+MqB0gbjD+wPfTMzRSG0pd26dcvEpQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WRAA6Hjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQWrO16v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WRAA6Hjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQWrO16v"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E93F13802AB;
	Tue, 10 Jun 2025 13:11:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 10 Jun 2025 13:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749575517; x=1749661917; bh=K62gkjSFKT
	xXjjtR+B9y0vltVP5sysga6Wq4eXoAqM4=; b=WRAA6HjgLUH4845R+Jfs6yGMBS
	MsnpYMHdbygUqpXa+VlxTuFTbxkXaWjFHl3003/wthpPgiqAPL5o/9mrObwg04tc
	HniwTLNAwStbWxWtIIgTB2Ogguwz/hCmH46M0fmn6sR2hLUjjrTEL86o/Pp9Ptll
	rKMRcYlFoSpd/+5X3TN+4UAW6pwgkO9mEx/0RUdNTnJ0DK1Ydw8zRAnA2Bn68DBt
	5H9OPrPjUaSgkpl+ZJv5eqQ8598vaHP62DmJCLpZAso/SkJ8TxT8XtlUfVgMNASq
	vNtfRMr4LxQXRwSNApICz8ne1UGD0doC7IDxOuggWNRLNUQXSGcB+6bFxSxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749575517; x=1749661917; bh=K62gkjSFKTxXjjtR+B9y0vltVP5sysga6Wq
	4eXoAqM4=; b=GQWrO16vP79vBsIgbdJz0fSkPfIaHIFWnRf4I4g3d1FUJ5OUyq+
	y4xka1vvh6GTbMlZGYikp5qA15B3jmBgTaD+EvwE2Hxqj8otw4YG8Ev2WM4+TGzZ
	C2RF/UoLVEQLpiKIUhZBU+hnH524sBl6QBrsyHG+l5Wsf9bPEm6QS8suCXhms7F3
	Xw0xrHGTzyhkFM6piYEtIQJhlEBwdKC+zJoQFEoliFr61Aga9GLS7YJM/lpERXYA
	upg442eWXNiJT3WaJXe2MbqEOl6wExCN65C/FHCYaHo5dJIWw+rlp6UqFx59u+j4
	wm08dE5PI9vSL8kNNSPbbMxpojLGVW9ixNA==
X-ME-Sender: <xms:XWdIaOL269z1rKhw33HUxaSFgPCDB1i9d7Byi7eM5aLcYl8zqdRMZQ>
    <xme:XWdIaGJGley5bBvgLubOz5MkKtFF7awIw5muVXgVlkb20ZnTSxSBuVUiqrPBsbvmn
    3HX9SI9P3KvKkQb1w>
X-ME-Received: <xmr:XWdIaOtbg65RzrO2ZvRdETVxiHw7AVh0mw4-5NfYpI-nIO7MXR7J4TnqotI-3cAMd5W2NN1Gbmo3mo4tH38wNqDX04QMNa9MXJei>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XWdIaDaxCh4-aSzSQCkZE6cbRpQwoISiaf1DgzkcuAK2TfbT-eIlPg>
    <xmx:XWdIaFa8z9M4KmMDobAM1Htwft1w61CrTJJsH_ZDEw5ouxsoDHYQJg>
    <xmx:XWdIaPAQ14YLfFZISAQAbFEbZQLEjOg2Yi4cRgOPRjFu2Yc0mT7U2A>
    <xmx:XWdIaLZnp9Jtj-2lYdNz43jIe7wmla9I_6o484q4t0hUbQl36EyVaw>
    <xmx:XWdIaH59AKeGzNnliae25v_kOnOo7Y74vopBhuzSYhQtdXXUY1Wx3xbp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 13:11:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 0/2] preload-index: remove dependency on global
 variables and 'the_repository'
In-Reply-To: <cover.1749557133.git.ayu.chandekar@gmail.com> (Ayush Chandekar's
	message of "Tue, 10 Jun 2025 18:32:19 +0530")
References: <cover.1749557133.git.ayu.chandekar@gmail.com>
Date: Tue, 10 Jun 2025 10:11:55 -0700
Message-ID: <xmqqecvrmsh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> The aim of this patch series is to remove the definition '#define
> USE_THE_REPOSITORY_VARIABLE' from "preload-index.c" by removing
> global variables and the global 'the_repository'.
>
> This patch series contains two patches:
>
> 1 - Remove the global variable 'core_preload_index' and localize
> it in the function which calls it.
>
> 2 - Remove the dependency of 'the_repository' in
> "preload-index.c", allowing the removal of the definition.
>
> Removing these global variables is part of my GSoC project.

Both patches are pretty straight-forward and readable.  Will queue.  Thanks.
