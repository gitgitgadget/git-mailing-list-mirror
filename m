Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD62D77EA
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509867; cv=none; b=nIlhYFw34V9kyPV6sl25wEVWFW4Ws8GcXJ7hGh4CSJoRMo8XQchSRHBrua6wbC7j9Xqu5HzwK8eQUWYBMuM9EAA4LDkfZj/GVWmuW1nzt5z5sQv6xNgbl2hvJS6HZWmGFnQ+5wAecMnZ82LDB8LrX4agEzWZl86YmqJKMkLQGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509867; c=relaxed/simple;
	bh=dVxFGfe8tGSxM2sKSVI3tzvrIAhutUZoOxOgVm4e9E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cI36TmxmotGCRStIBAOZiRGC1j++O6ZBN1yqjH6QzDDq7pz+392a21dd8ELT6Y3DOC+QAeAj9Tyf2/ln+5PhpBW5LBxqGuFCegAqxmV5b1hMdZxDQOrsgG4D+zq+jCvjQyZcY/WcUc5P8LqFvJBM7psXTvDOWWN8s5UK21nbZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Olu6Cfts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RB16DARM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Olu6Cfts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RB16DARM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC8161400100;
	Thu, 11 Dec 2025 22:24:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 11 Dec 2025 22:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765509849; x=1765596249; bh=eoh0vhCAfn
	FX+OxPJek2qS+Q//EJjglU8FB2W6JoFrE=; b=Olu6CftsW7VIeih24vEIsI+jRh
	/S+EFyEsJjEhFOFfy5bhqy4IVY0iHsPLrT4jcREBtbstJxGFU4MPzhY/0S+XLNPg
	yoAxyEXq2VbBfSiiWJB2BGaLXXgwh1C+J61jkGvo9XCZfzxpx77gGwLCZHDzLOXU
	8ywvQFQNWY9DuZBkfrNZEfhXJ1cnJS/PrvydN41XETHqaWyvkTzMqMry0QIu1kjR
	BfcBlaqlf1RivTwhNgadSb3jgNNRVWkczyK2Bc5eREzGDhIHT53TI8uPsUpAvz+9
	bzRzCXHRpM5SyD5gNXw5ns8KeDtMesjMMJVSmtO68L4a3YHmY/MQC4TRJX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765509849; x=1765596249; bh=eoh0vhCAfnFX+OxPJek2qS+Q//EJjglU8FB
	2W6JoFrE=; b=RB16DARMGIMPbLI8Nn/QhvfkBdQSJLMexarqJPGVLvGELS8loP8
	qiRqT5Hpw0gaMuaZZAcjIpx1HXHxyzf7VKlE8HfB8M4BkvWJEbJ8zNrEFRRRbD6h
	RYvG/pgFWxiaJ6fsB64GXBSSUOd8VvDnAQZ/ViVPpER4tZHXai9ywye8urWo0XZZ
	zbY2i3gMH7JUfyIfqMPnx0wb1A1i6GvRoWwIQ1uBboX7hyhZ+fFszSQFh79wJ4Vl
	poymwf+dVT+n7B3rkZjljuAsMq+MX/nYUws3vlpPsNWNv0jJQnpjzKYNSuUSikEA
	7t7fYE1wj9QVurvoioQepyP3a90wQx1myuQ==
X-ME-Sender: <xms:2Yo7aRx86P46bo16Fyg_S_p-dFIX4K47fGGtpPk3Ao9ExbzetZEIMA>
    <xme:2Yo7aYTAfH3erlWcygXlNQT1zLZP0rNT1BchmZMGlnWePjqvQA8c0lyNvdedB-oZ-
    Kk48vqHlUZZ9SPLh9LddLFb-sAlJaifHgMHOcaTxdLbXSw6gk_cpQ>
X-ME-Received: <xmr:2Yo7aQWeruIQWPvP9Jz7J5O5LVM_rAScXbpTmNlCKzvgvzwB_yjP6P7qUl-2dha1EVeuSkuiGpNft_gTp-QZfNcUA1oYczdKrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehkoh
    huthhsohhufhhlrghkihhsrdhsthgvfhgrnhhoshesphhrohhtohhnrdhmvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2Yo7aSbUDUL62v4utAmlZbbF3-vksfUY1ECLm3OFE2ASnIb_5lh9kw>
    <xmx:2Yo7ae2txsAEyBTiMsyHVQeUQokDjQeqOiNjQ32ucaflbiZimYuRYA>
    <xmx:2Yo7achJ7b_JpWm3DuzB8pQBwGoRHej3AlDO9LxFYBW4rCbCeWL8Iw>
    <xmx:2Yo7aaYtneTOqFYijzNIiEs6hQk2qLqfOSpM1ZQQF4cyb98LjBMmnQ>
    <xmx:2Yo7aXFfdGXvzjiSpJiP6oT_amD219LMD9hISa9qQ1fqXXQbASR4Y93T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 22:24:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with
 no commit history
In-Reply-To: <d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org> (Johannes Sixt's
	message of "Thu, 11 Dec 2025 13:22:30 +0100")
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
	<xmqqldj9g0pj.fsf@gitster.g>
	<0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me>
	<d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org>
Date: Fri, 12 Dec 2025 12:24:07 +0900
Message-ID: <xmqqzf7ocrhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Wouldn't the following slightly different scenario warrant a similar
> safety net:
>
>    git commit --allow-empty -m "Initial commit"
>    git add .
>    git reset --hard

Yes, I think everybody has lost new files not in an empty tree but
more often (1) create a new file and add it, (2) make modifications
to existing files, (3) compile, test, debug, get frustrated, and
finally (4) decide to give up and start from scratch, with "reset
--hard".  When (1) is much larger than (2), the sense of loss is
big.

> That said, I have some sympathy for the case. Would it be palatable to
> have `git reset --hard` refuse to do anything if the destination tree is
> empty?

I doubt that special casing an empty tree would fly well.

It is tempting to special case removals, but then I sill am not sure
it is good to do nothing and fail the command after determining that
the operation is a common pitfall of removing a new file that
appears nowhere else.  Unconditionally going interactive is a no-no.

And I do not have any better ideas.  Other than just failing, that is.
But that leads to nonsense combination "--hard --force", just as
idiotic combination as "rm -f -i" :-/
