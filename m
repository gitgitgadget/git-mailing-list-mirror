Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAD36404F
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696302; cv=none; b=tw9iX34JC9QdXqOQJjkM6sGt8RJy7CIn/W+9FtJ62+MrNELXpedJ6BpkLL1BUtGmxepKbk7YMxdqeW4BMILE6PgEG+RqvnJKzPicxISurIkE+nU10xlIj2FBjgvcsTzI7b9/F6cHJvogu6kRuA8nRaT+wA/ENt+8BpnzCk5z2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696302; c=relaxed/simple;
	bh=CB/IOMLFYeQ5n6J7hBrzT8TAjrW8SWsj47R4oCnr0bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ubcMR38YNl6Yf/E9fLJOCn0XZXYL81hDwHRTzerpYBK2iP5PT3uv/nWWVDjQWfb2uUMxY0XqG+G0GM6yv40XhXYP0eTm8bwDHSI6bM2kmtZhye1rXjfqA5bglxhYjSBQU9SRlwok4P4Ys6/iGmx9V5Y2o0kc4bdMHlt+nZmzawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gC67Omtr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yZf9Pr4p; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gC67Omtr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZf9Pr4p"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09B7C7A0337;
	Mon, 16 Mar 2026 17:25:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 16 Mar 2026 17:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773696299; x=1773782699; bh=XL2kHK7Pbu
	iup3GGttKYDnLptNmNv26zeMFSa3suiU4=; b=gC67OmtrUBmtPpuxa4QWw/zjXn
	ov1gquNXnegjXBDhnfgXDrAK0GdEcOEII96bpIUd8eUmdKAZi8+4MmoTvFUC+S/Q
	4wASar5tK6fQzn9MVs3TtyuBe3uMVSZDmrQYv3MeXr9K+0tEdGbyhNLfyziRtCNU
	vBvvtJBv1Yhn4eY9ksEN72Th2ZASMBWKh/5mnRkdWsGjXEmbZUjlVbtvh2F21B+Q
	3xH2d0cTlZ2wZK2I6SKRoJsjL6w6CMfubZuanRrFLCZs/QEuOWBa1VhiFhKFc3An
	L9UbGGvTZGfLSX4xncunnC/Srcrwj1txU5dmEZYV2JbN6IEu+MwGYh8Dr3zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773696299; x=1773782699; bh=XL2kHK7Pbuiup3GGttKYDnLptNmNv26zeMF
	Sa3suiU4=; b=yZf9Pr4p3kfl+R4LluCt9/xhev9d0XxWumPkMyomgFGpEcvfH20
	KxHTKadn1a4JZfgM/mvw3C57PgvRw6VYZO0H3WoIoPN1Md6blV0QRCdwJEUGAfPE
	wlHrsTGbxeTsnGCe1o2ibM+uHfe5xzR1diYMZnEJfwCcMYWn1PjokIrZAbK8daD1
	FIfDahzzxyj7s48WbzsRWN9d+JALy25A6k6x/YtDsbXqCFMFsL6XAgGr83DgxXXi
	K4Ln5RqSV5WPiuQj9btg5Z7iKtPSr7lGWrCu8/jGkmR6+3WI58XCDo2PhshKiHW0
	4WfYN0SrXJVnPAgoKsDcK5hoiH/6204fBzQ==
X-ME-Sender: <xms:K3W4aU2L9l5YUEIf_pibTODxoMlSYAvMBUKqG0GwMPk28AlFLq1KJQ>
    <xme:K3W4aWE-S4Q3HxrrbaAawv8cR0mfDtlgLvOiIdeYfAWBr5AVrTKwlcJ3vGS7hTX8e
    k5hXqHBzobYa5ybo5894MJco1x5XcV8Zo1olGzZq7BhAauCNu9S_g>
X-ME-Received: <xmr:K3W4aR7Davv402dJtkZ2vSdQVCNVUUa4ELMYFqf-iw5EiP9a4s4Kg1g1jwvhXvcoUlKgEGOz90N03h9MP54FGKXCtwEc7gOalw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheptghshhhunhhgsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:K3W4acsVirSXBWfe4gI4RN8Nc0lkhibebcNHxzk70k10iPGxhBrqcQ>
    <xmx:K3W4aS7fxLzXuOvgT_LZtwLVUDVo082ogiNXiuqyvk-z8u5KsxcBqQ>
    <xmx:K3W4aXWoVDGnvVlgkAXk1tExn76XxXFtoY0n0CNGXODoGdmBKOVrgQ>
    <xmx:K3W4aU_rK1rkjwYf1_p2Xsx39Ygz8j7vk2GgL84Z0vBdVu4bGzz0bw>
    <xmx:K3W4aZ1xZnyM8gtYjmASEBHXXdeDH86vBg1NadP0pW9aLCVIS5YZ1oKR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:24:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Andrew Au <cshung@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
In-Reply-To: <20260316211934.GA1042816@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 16 Mar 2026 17:19:34 -0400")
References: <20260311184206.GA1911377@coredump.intra.peff.net>
	<20260312214945.4050010-1-cshung@gmail.com>
	<xmqqsea4aen2.fsf@gitster.g>
	<20260314160814.GA918806@coredump.intra.peff.net>
	<xmqq4imfo6sz.fsf@gitster.g>
	<20260316211934.GA1042816@coredump.intra.peff.net>
Date: Mon, 16 Mar 2026 14:24:57 -0700
Message-ID: <xmqqpl53mpqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Huh. Obviously yes, but how did I manage to bungle this so badly?
>
> I _think_ what happened is that I compiled the topic without -Werror,
> because of all of the -Wdiscarded-qualifier errors that happen on
> 'master' with a recent glibc.
>
> My integration cycle would have caught it, since I have another topic
> with fixes for the discarded-qualifier issue. But I hadn't run one yet. ;)
>
> None of that is important for you, but just wondering if there was
> something more subtle going on, or if I just screwed up something as
> simple as typing 'make'.
>
>> I'll squash an obvious patch in.
>
> Yep, that looks good. Thanks for fixing.

Thanks.  It is probably a good thing that you are using toolchain
ahead of the version I use.  We catch different kind of errors that
way, even though occasionally we see a gotcha like this one.
