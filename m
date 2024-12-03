Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF02500C3
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189420; cv=none; b=dv/rDeyX1XkklGddo5oKRoXq3Km66XPpZG4LTkFC+HgfchkVHeUG8cv7vgRtkCTrN9E5/MRc+hOEWfaXuXTsbhjX8gmY+1o+goa7yjxM5fq3RQoW8R6t8Yz463JECz2DXKCxed82uc3h01nvGGATqFaBzng52UBqWeicv89TDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189420; c=relaxed/simple;
	bh=e7NJGG56rdcSKVQ8GjXy883if6FrlpJKlvxNRxaavyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e6YrBDbwEyVKNb0MzAqujOHsvhlwjZpHi3a/xQuY93lMhserGrMAQals3emHEmTC7aoOrNjKpjuTm3M6UI2+BGKBsa2nFxAZ4GJCr2UPN574UpMyvqIVnjgLCvPmpxW4WI2E2sCSolwreQHXsE+wldSvJJLu7Fu33XxwuLpV64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6+LbVlw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6+LbVlw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBDA825401FC;
	Mon,  2 Dec 2024 20:30:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 20:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733189417; x=1733275817; bh=h2yGu3cqk/1VswDzNcXayBbP8O36edERuI+
	qID+5SEk=; b=S6+LbVlwYZamCDt6r6fGaConv4BhF3rnwIzw+tIm4Gnng/G7WnC
	OZeUQwzsKp9P5cjjTkDm2tAceBGhxG2lls1kvK8wh0Hn2GSAM814HgMN1I7PG2bu
	dHplws6Wr5Bjee1Txu8IzB8Jly3Ges72foaLM8V9kMiAf3q8MSozwGW11CZQEoZz
	yoIqL77PpOTEczSXSq+ciBTMJwq34RQ9empavOd1ShAwONCTT2dw47twKpt5qnB9
	+kefkwmQH1OhlGQrvbfBB+JhLudtdXwfLTQuFBRWuWJKnuD9Djyjn4ewEQKM4WE0
	NLzoO4b6e537DpctboOeye6fWx63eUCMawA==
X-ME-Sender: <xms:KV9OZxJOG9ohc5gJyfbABhSet4Y-dF3p12nFfDv6G67rzn01-9Xmvw>
    <xme:KV9OZ9KFUkLh-yLi6MLBtE4S9OEVtRhIAKp1wrhiWoiFR8zhHa498FOoe7nEXEFxu
    0KoO_vPcbSMvYO_zg>
X-ME-Received: <xmr:KV9OZ5v-VdL5Uhaw5hKBrA4P-y8HCrnpWSLc2jfXeI7odoTj7L3aGvlOhi0PjG45-NzfJywHnvSRd8I4GLfJY6Heja4_-lBif4Xiitw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesjhhofihilhdr
    uggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KV9OZyYWJDd0v2DvKaRnnaYUS5pdZC3ezzjJ49WqeldkJl5gLq0X2A>
    <xmx:KV9OZ4ZWj4H0UnOLweErNZNzSSYeUeZ69rpFSARtYz4OwefXfFtuVw>
    <xmx:KV9OZ2DXMmreg2v1mHULAfLv_UibFIW12t5J_mYTqhkYHzNqvRMesg>
    <xmx:KV9OZ2aFQySgnfjdJEY-SOOSbDFMplr9KFdA66g_kUl3sV57lwX9RQ>
    <xmx:KV9OZ3yOzgHdFzHleIfGFwqNpm-x_pKbLHXXBLBo1yqfP6wzu9RjTeE5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 20:30:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  git@jowil.de,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
In-Reply-To: <Z02voaSNYRciv38z@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 2 Dec 2024 21:01:21 +0800")
References: <20241202070714.3028549-1-gitster@pobox.com>
	<20241202070714.3028549-5-gitster@pobox.com>
	<Z02voaSNYRciv38z@ArchLinux>
Date: Tue, 03 Dec 2024 10:30:15 +0900
Message-ID: <xmqqy10xft94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

>>  int check_tag_ref(struct strbuf *sb, const char *name)
>>  {
>> -	if (name[0] == '-')
>> +	if (name[0] == '-' || !strcmp(name, "HEAD"))
>
> I am wondering whether we should also update "check_refname_format"
> function to report "refs/heads/HEAD" and "refs/tags/HEAD" is bad ref
> name.

Check the list archive for the past few days; it was considered and
rejected.

Thanks.
