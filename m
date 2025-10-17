Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213D86344
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726842; cv=none; b=p0R5CnGN2P9mHomE/5tK2+BTykrBpC//c4hR0WawUsveOfZ97AQe3r6/CQDvigJNhgsO6fzoBruX6FFy/DPtA5DMxcEnQTjy+N1QpYciVpvkVAZWH/cP6R4MV1c5UpbDzOds9Wj1FoxjAx2+ZWmak0OewFcpyEDNuOqEEj4K/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726842; c=relaxed/simple;
	bh=0EXvTk0BP93xa1PTcbGtNl9eHGxkX+NZ+KGL/WYUa2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOEGuCBw5QIE7nciDPHBK+6vE7RaketglhuyUatrWUANidk68Gj+l8n69fUIKqm/y0Tg4sYjKGD4+1zup5Y/nZpENQLIhQ9ZjG7JVAVUgx08hRLspmOKtX8+VZ4B9W5Cu7TM5/bOz+Pi1ROu2OKhvPEFIZzv4S+OO2Oll/8te4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g+fCFNam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6C1+s+q; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g+fCFNam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6C1+s+q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 86C2D1D0011C;
	Fri, 17 Oct 2025 14:47:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 14:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760726838; x=1760813238; bh=M4w95qNJHL
	1ZlfBWo1kHW3iBauRisnFMCD+r3qq8uko=; b=g+fCFNamtP1KJMM00yue+FRxyd
	Z13jiFHLiz8jABZGQhPYcJM+5j94dZEIprWAgrWLCQsoU1D8PBXqVVpKBjojQWUm
	XP4pk0kkzqfPdnfg8b7wcqW99EvVeItdwZFRkpuW9TqSavgkbOp5y1/KXRiI7Xw5
	/kAcUQg+pL6gscQVCl7NMJFnF5PJcnEShXDhWbkjMx1zMB23teyO1ncAUlR8CQSY
	uDgtFpqBo+4GF5jX3T6BfDJsDWLGWXk66MqfUCFLdKwmyOHp4woNMBUkDeoWUVNG
	q88zxGYDXMd1TqWMOJAj21hRYiPuUG9UJKm8bifbkXysJPBQuq931vDbVvbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760726838; x=1760813238; bh=M4w95qNJHL1ZlfBWo1kHW3iBauRisnFMCD+
	r3qq8uko=; b=K6C1+s+q2NITxu4RZh/pS0xFVC/65rQY6o2go7y0nW3KddYteGg
	bVVWdh7BaWtRKt3gob3C9KzrmEH9mVwwmSM9sOC1LAlSLrdem/oYPeByb+F2JOiI
	MxH23szQYIc4a0J84X3aJ61uFhKnqs/1EJaljYre616SuNgFLkn83nzVokgKHuXg
	Gm6UOBUcF7o20pPaydbinrMj2hHql6S2uE0ajcUJH5VmylUuLX2AFAihKrf3dY5S
	ai4S0PLfkUsdPJctVFUDpqzmpLGNeW42FcJTEvQokfsrBh3Z86rgpemHS2z7ti1F
	DEbkLycHv/5TBGO3ZbV1uP4XTjoCrW25M7g==
X-ME-Sender: <xms:No_yaHEzgtBGQ1T1EhYZbPjapc00pHbW371wsf7MZwFhKcSSh4TBrQ>
    <xme:No_yaLNTAEdMMmojS7tRxlhG1DiXasXu08XfIRQnutXkCeD81r8YYO1t7EzSqAla7
    Uc8IC4mG3zYzQD_B98kvnRgeYCqOR9UMINXF1OgrSr5xV_ZnRhMTA>
X-ME-Received: <xmr:No_yaBcIbYz211t5Y0c71suUIjZwz1o8jw_Ydnc6CIbk9mEYMeKIUfRvMKJ4zPzuGDgJJHJNI84frAaHS5GeUFT2GzdikGMxChp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehushhmrg
    hnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:No_yaAtGhqw-pJd4N0HWBFMOkN4TBhhagetbJSszKAj-Huj7HGGddQ>
    <xmx:No_yaKlxU2mLvYG7WWGrY7M5K-dzLewnP-WGL-vdcs_ZhFu1xjlbwA>
    <xmx:No_yaKyUbSrzyAK9wcpOvQLqV8OSyWCahI4t-pGabkRN2hII-xs73A>
    <xmx:No_yaEMdBBGXIwC8agVf--2R2_7ILinru7Y9hRXWsEooLhtCCi34Dg>
    <xmx:No_yaP-DCbHXNI-pBq9tNy_nMlVonbPxBSyouJtXcQP6UxikvvEkFUMZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 14:47:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v2 1/2] gpg-interface: replace
 strbuf_split_max() with string_list_split()
In-Reply-To: <CAP8UFD1FMwrBxbZ6Ck8JwBPBOAhB039US6pHSTusb6qzW=crpg@mail.gmail.com>
	(Christian Couder's message of "Fri, 17 Oct 2025 11:15:37 +0200")
References: <cover.1760571220.git.belkid98@gmail.com>
	<818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
	<xmqqms5q4v0r.fsf@gitster.g>
	<CAP8UFD1FMwrBxbZ6Ck8JwBPBOAhB039US6pHSTusb6qzW=crpg@mail.gmail.com>
Date: Fri, 17 Oct 2025 11:47:16 -0700
Message-ID: <xmqqv7kdz7pn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It seems to me that fingerprint_stdout should contain something like:
>
> 4096 SHA256:PelI2esT2xZlv20wJJyYOkQsli5RMK79oJ2VxqYb2PA
> christian.couder@gmail.com (RSA)
>
> and it looks like the 'key_size fingerprint_hash:fingerprint comment
> (key_type)' format is the standard `ssh-keygen -l` output.
>
> So I think it's safe to say that we should expect
> `string_list_split(..., 2)` to return 3. That should work even if
> there is no comment in the key file.

I do not know why you or anybody can think it is safe from what you
observed above, though.  Who or which page of what manual told us
that the key owner's identity part cannot be missing?

> But on the other hand, I think it's also acceptable to say that we
> just want to keep the same behavior as the original code and check its
> return value with `> 1` since we only need the second element
> resulting from the split.

Yes, as a code clean-up topic, I think it is the *only* acceptable
thing to do.  Finding the source to justify tightening of the rule
to validate data to insist we have to see 3 pieces can be left to a
separate topic once this series settles.

Thanks.
