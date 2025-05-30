Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688220E32F
	for <git@vger.kernel.org>; Fri, 30 May 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639197; cv=none; b=Ts/1wDGuF65SYTwnZgLpur0e+rn5+hd+8kuLgTgB3Q3oodrmABUkpyDSDfXJgbJNqWPfN51eXw5Gp1WsTBUu8PDgK1RPR0YhgWR1p8d08dr09+K6VZTmnIHKCchvvtWg/WYYR8OH1oX1ymDduUa49Lj9sCdZmhOjFauUhWwiYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639197; c=relaxed/simple;
	bh=JNsuhywvUzwpkkY3vQDTfDkF+/Rcm7hrziL2dL3iaxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=niMw/ApxEAad6S18ZGl+4R7mSsSvHSvm94rgwZl/A6uVw5Z3iPVzPFz40sKa02T1QE9q3X1SkRqqgpQs0/52WNOTpN5K6KpEqk/J7efQiNmGB0D/rmfIJ+b7e48QI9U82cGgIaXemsQKy/+FIQW6zRUazDSSTCHaBtxQFVvJPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zxZXRxUy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTU7xD02; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zxZXRxUy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTU7xD02"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 00BEC1380102;
	Fri, 30 May 2025 17:06:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 17:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748639193; x=1748725593; bh=6W3Ux1hFNH
	UMplz/LaoCEfoJ5FErN+4mvrqU5Tu1nCo=; b=zxZXRxUyfQjUo0rGZCWvBhKXXt
	Fl/efsRpkpnTlF8jGzV1X133aHfebVNNWN4u+iN/WQNQcTanYZ4gIJu6t2U6JAOq
	E1JwCkeaSqt11B8HAn+X+6bBp90RXvojZltAkwpYMcvRnjtJDpeEP5eIrZEQZP5C
	lhNjnDuqwOI9oPf1DOWH4hwZePURsdh/QB/3hMcFsw/z08XfIzsBlIj6mj1mTl8O
	M+54uUW9Rc4ul4tIyWfIuxHKEbjNzpHv7p4FfXBdMpeQlUDtp+d7Huu7WNb2NYrV
	UjVsmMBooc2v3ZMMu7xYIla9WN3Rpo/LtijNkmZfNg4/UxExBsfq7TTVrdtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748639193; x=1748725593; bh=6W3Ux1hFNHUMplz/LaoCEfoJ5FErN+4mvrq
	U5Tu1nCo=; b=NTU7xD02TVO1nejv3fUJaK9rDgF/q3E51vD3YtpiutoTKSYP1P+
	uFw5+6GwWJbfx3qT3ZSa7sRdSs6JkAaPGgI3bp8bWJPXsqXZUOp9KlIkuOQVTp4Z
	bgrdIVKvKZtJFCPTmXqhKNH2X02qjJc7TJSeKby3iZyyV7sHtVH5Rk/Q/U6UPgxI
	kdDL7jgkS+TKUIiFnHfU8EvV1YOlaPtSSsrM9iw/kzjCc9e6MgO478B7cRiAL611
	TQoTPU+wmb+tZYiIVt/bRdpuWvh6H3U1sf7aeLVdN/QWYmQKRe+rmxo5osFOga6r
	AohSnk/AyAqMfhnvXW5o6rdhf87B2JuPjLQ==
X-ME-Sender: <xms:2B06aNfpNln7nKE_phlndByrfGbK7IDxwYPXH2HVS0T9T-adr1TM_A>
    <xme:2B06aLPWop7bhfubXifSQjNEG0AHMeufidtYCthAN-9x-dwFJVlLqdoOmnHcgc1j_
    rKldAKL2gvZv8T_4A>
X-ME-Received: <xmr:2B06aGiUnvaowtcPxdEEjvTkDzP0p7CcR2aD56QwEZJ3UYfRoRj5oqohOcEjNk5X5M8UGLVecOIhe2gawbtMNTxi6wDDbE7pMvSQ8eU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeftddtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdr
    tghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2B06aG8Mnr_z8DlyGBypxMCpaXCtbzLbTHzGkW__GSa9lh3OfkaV7g>
    <xmx:2B06aJvJDor5kJJe33xEeNZX1htOh5xkj-9ONdBiJQt6hs1jjl6rSg>
    <xmx:2B06aFG1N9d_kY-pE43b-jN1otvJfSnGMu0LKQWrnyTDEZ61mR7BUA>
    <xmx:2B06aAOL6Ib9Zs6iwZAaYGWfzic-2feFS7-hC44cxzf5nU6LnOGDVQ>
    <xmx:2R06aHSyyILdK3ktbYPoPA6CdQlszQObGhGsre6TQOZPrMIGG8oALpuC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 17:06:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2 0/2] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com> (Lidong
	Yan via GitGitGadget's message of "Fri, 30 May 2025 18:14:04 +0000")
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
	<pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 14:06:31 -0700
Message-ID: <xmqqjz5xerl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In pack-bitmap.c:find_boundary_objects, remove cascade success check and
> always free roots_bitmap afterward to make static analysis tool works
> better.
>
> Lidong Yan (2):
>   pack-bitmap: remove checks before bitmap_free
>   t5333: test memory leak when use pseudo-merge in boundary traversal

How would these two commits relate to each other?  If [2/2] is a
test that exposes existing breakage if [1/2] weren't there, we
usually have them in the same commit.  If they are not related, of
course, they can be applied and advanced independently.
