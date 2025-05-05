Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E0502BE
	for <git@vger.kernel.org>; Mon,  5 May 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456096; cv=none; b=X50DKN5MK2I8btsQ7baAbZb7TRGVSjKWMpRXVQZMDS6bpgNFrnevkVVllkub24DHsd2IQAgezpJPvQkrgGnE0wSzSYZGRYjnOwjOSqorerdAcTqDRxhu6D4JhwYmFnNVXtzftRJVdhAup3a/7odjR76Eg/eyQDuaKUyxrJzsBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456096; c=relaxed/simple;
	bh=aY99kyek7AAdTgcvJSlfTVRIkri0P7KGgSfzg0G9XzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cK6KRl4wuPWJ+IG6TZXYAz7XYTMJbHcT5N3P3gFC3WN7LnIX0DWxVNr2FHk+kdtzM3PJfbPK3RFl7bfObGSVTb00L3OnEZcmjyvIwfWpf5zw49Jh8Mh7iYvGvtWRKGKubIhmoxr/EDPnNApxoTzh98FCUiICU75UoiHWtWDOtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JywXNJBe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwMNkGMu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JywXNJBe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwMNkGMu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C7DE25401D0;
	Mon,  5 May 2025 10:41:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 10:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746456093; x=1746542493; bh=K9kN4R3fYE
	bAdLtix/rQpybbloDWqkWvAMEDfd7rSp0=; b=JywXNJBeFxt+vuTOLI3I8xAhD2
	LaeWxfjqjAH7jPqz+EIm8AylhEDViLOatnJfMK01PfYmq+KDab8qSaNw5SyppkG0
	eLBIXTxqDia5FMYsSP5ljc6co40haFd0JaTsxgXEFSNF2H/TqEVQ8yNhtw1Nlt7X
	GQaowdmjTGG79Iez4bO5rqNApfuQtCl7Cb/xaDtm0aVoDGGKPy6XrmOzU04iEgCG
	AFVs5x/rvnJuJhURSlVLmQNzBRETI/wbpY50DtgPkuNIDc8QFUYHiUK9JGmvUr9J
	DnWH3ruA4A1WxTtQrqAQAkcumDhuIn9vcU1qPKbzugiumREaf11/Y/WWInXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746456093; x=1746542493; bh=K9kN4R3fYEbAdLtix/rQpybbloDWqkWvAME
	Dfd7rSp0=; b=OwMNkGMu7BpS/UbE6hN1DnWrtIZ9wKCgp+SlcBnFQY3xM7hxIL3
	EL4I/wA9jRm+visyqMKnSies8iWl3mYVc75bWxJLKIB9TXqZgG9Hsa2gpmrqYFnN
	cMlTneCaJHuHh3XaVv8j3NKYDPEFDJxo3K14IeJjHV6KBjnR87n/iO1zHDTuB96w
	HXLZDIi8fx4guq2zbMSTGtenhrHC3E0+LbfvUIOClpWQUkCS7f+M/1Mt+XqicG0X
	iRnIpIJa2e5ql2YVAhEX240bF1mTdiXYtwk1MVrWnw6XP5B5XHbD24CeUYzJbixS
	ijnl8MCGW72LUkmuWL1D3zfjqGfKtNzUI4w==
X-ME-Sender: <xms:HM4YaKG7gJcm8oAdF9Nxt3Ysf0r6LYXvYV9ZM2fmTKsRhN8RtDk7nw>
    <xme:HM4YaLWlxAhF7Fy3Jp1IqGtGORB1rB7cBc_VZcUnBO6qM3y83397Mo6Fgmm-Pr38Q
    Nrtpz08aGqsO0cl9w>
X-ME-Received: <xmr:HM4YaEKE1xgOfFUzOy0LZWGZSkJtjUKrfYk9ww6SzoowAiIVgUsBaLqYXoPZtC5ZC-4o4W2p85gE_ll8xxXsi9YXk6836lF4jagL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhiohhtrhhsihhu
    phgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:HM4YaEEIUqIFB6xDzdP1v6FRygfHg_znmQ_ePHeuZ4O0OiCfIaRtlw>
    <xmx:HM4YaAWuhwY9OxfnlFaz0L4yCMo-JJ-9HbuYG63SrJitGvcb_3Roxw>
    <xmx:HM4YaHMyoPHKQHC4__YmT7_GJjxCixcNpwdvEwZx_Swb6ioFCOvINw>
    <xmx:HM4YaH1eKn00Cij_WaCUqQ006oiawunk9GQWW1YNFGfii58zMLKSsA>
    <xmx:Hc4YaHocdKvzH1eZpoRuwtwyigTQVM3MEBkhUAIbn0x0KeH0OfYcE-YP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 10:41:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  lucasseikioshiro@gmail.com,  peff@peff.net,
  piotrsiupa@gmail.com,  sandals@crustytoothpaste.net
Subject: Re: [PATCH] dir.c: literal match with wildcard in pathspec should
 still glob
In-Reply-To: <CA+rGoLfFCi-q52ABUr=0O=pu+qSikcomSk1akHWUkfAfSf=pZg@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Sat, 3 May 2025 11:54:40 +0530")
References: <xmqqecxk3u5l.fsf@gitster.g>
	<20250503060736.587286-1-jayatheerthkulkarni2005@gmail.com>
	<CA+rGoLfFCi-q52ABUr=0O=pu+qSikcomSk1akHWUkfAfSf=pZg@mail.gmail.com>
Date: Mon, 05 May 2025 07:41:30 -0700
Message-ID: <xmqqwmavqfvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

>> +               if (seen && seen[i] == MATCHED_EXACTLY &&
>> +                       ps->items[i].nowildcard_len == ps->items[i].len)
>>                         continue;
>
> For some reason on my computer when I check the formatted patch the
> ps-> line
> align with the (seen && ...) line perfectly

Because the quoted patch in the message I am responding to has tabs
expanded already, probably by your mailer, I looked at what you
originally posted, and it has these lines:

-		if (seen && seen[i] == MATCHED_EXACTLY)
+		if (seen && seen[i] == MATCHED_EXACTLY &&
+			ps->items[i].nowildcard_len == ps->items[i].len)
 			continue;

Removing the prefix '+'/'-'/' ', and replacing HT with ^I for
visibility, the above looks like this:

^I^Iif (seen && seen[i] == MATCHED_EXACTLY)
^I^Iif (seen && seen[i] == MATCHED_EXACTLY &&
^I^I^Ips->items[i].nowildcard_len == ps->items[i].len)
^I^I^Icontinue;

As the display width in monospace for "if (" is 4 spaces, "seen" and
"ps->" would align only if the third HT expands to 4 spaces on your
system.

Perhaps because you are telling your editor or terminal that your
tab, unlike everybody else's, is 4-space wide or something?
