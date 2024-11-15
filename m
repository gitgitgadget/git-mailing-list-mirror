Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AF8F6C
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632889; cv=none; b=ZY89IcYxUGFq/Aua+ZVPziYDcB7lljgKkBFeG02F+d42RAWLWJ17HbuVM658mJaa6JAa1zToAvf9ki9wKgZUnmnZ3+5aV7j6jb7zD7Lszr0NUXFahajANPPfV07/rZ5yDVV5tfVbk9GN96jS7uhbXgoIRvC6vIQNJahkhHxGxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632889; c=relaxed/simple;
	bh=4xPnEr9/4UZELPScm93yj8AkDjFvL/e8GJyjLT7mAhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Palibn5isw9Dt222NPB/2aRejsKCCfVN5IYCGCvoZ0rLq/w6HMK6vQnpwDmfn4nrGPCDHl9CHtyDxdVG7TTt4A2flwMhvgmfQDI5RIdGMc7xDF+tzkOQ1+5CjP6ya4oSTdHSxOQLn3h+E0nL8dJCs+WzMsvT/HtfTcnULeTbOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKZv5zDs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKZv5zDs"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 365E01380449;
	Thu, 14 Nov 2024 20:08:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 14 Nov 2024 20:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731632886; x=1731719286; bh=RUvLTm9mm6/audV1PLp2HragUGxennzJxtV
	HSViZB+Y=; b=IKZv5zDsunl+Z4VJAyORB6pv1mPBnfSr859pZ1rIQseSJ/oMFEy
	ZTtrowmCY1wlU429f7KON7XZURWYkMiZ2ihtdTfuDfVz3T1YwV1EyBIB9DsTh5mT
	zMQ3463pghbQcRT6aJgF4NjdCzsPeAJvWE24cfiy/DiA5xWyGIC0hRleo5IE5ogZ
	ihgd3HuYVZtneJ+YBuqRBCCc9fCxouy00jvpHpclHNT71t3YajeCUPTXAaI49Fhn
	+cBrRdFBBICKtYX/6RQTZ7ciCu5ceGUdZWGybdNmqY6v0NP2L5i1/wQ9z2mZNQgu
	dxEboOzJwUftG+/NNThSY92Dm0oK/lsMfIA==
X-ME-Sender: <xms:9Z42Z1VVj_b8MMS5TJB4iEGaJDalibpItoYd70ZYNBBFHf4TdquwwA>
    <xme:9Z42Z1nPA2pjWnVKCnN_SWzT1LNzCvAlczEZ8fJzHenaXD9yEfrZ949otjlM4_KkU
    aiv_ZgXj7-TDQiX3w>
X-ME-Received: <xmr:9Z42ZxaXVdtSSuTMdvBSC7cCL_wgfzd66LM4DMlac5fhq2taLthfFOtsanxABGmQOgVzkuG8zFPYsdRPas4k1uw3hQvSQCuipX02>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9p42Z4WEWuoQw9iTjrolC2CphaYmVQCNqbeBf2Un5HMN0S_tGCxUNg>
    <xmx:9p42Z_muedhkG0ODAf_sfpuCd7Lnc2JovfqBixNixb8121cgYkSsbg>
    <xmx:9p42Z1fSdTve3VObEUkn4_P4NzDUHxAF34HpnHTVtlDX8KRrPY0itQ>
    <xmx:9p42Z5FK9viaH2UFsXT4yLrjhhXD4537zPUxD_jWBA540IfZkGL0og>
    <xmx:9p42Z4A69jrIK9LqA9ZL1aCFPgXeRWdcbXaHWBwzmxqDQTSo3T7P2vxC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 20:08:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-import: avoid making replace refs point to themselves
In-Reply-To: <xmqqzfm149sv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Nov 2024 09:31:28 +0900")
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
	<xmqqzfm149sv.fsf@gitster.g>
Date: Fri, 15 Nov 2024 10:08:04 +0900
Message-ID: <xmqqv7wp483v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if a warning is even warranted.  If you decide to
> replace an object A with the same object A, the result ought to be a
> no-op.  I wonder if it is makes more sense to
>
>  (1) do this unconditionally and silently, and
>  (2) when we prepare the replace_map, ignore self-referencing ones.
>
> instead.  If (2) makes sense entirely depends on the answer of an
> earlier question (i.e. "is there a reason why self-reference is more
> common than general loop?").

Forgot to add.  (1) could be done even at a lower layer, i.e. the
ref API could be told to reject such a replace ref creation/update
that maps an object name to itself.
