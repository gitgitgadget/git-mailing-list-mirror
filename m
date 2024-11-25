Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70710F9
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732498392; cv=none; b=VqGuUqIU3mavlk8RQHpaHz//8+FzJZ3Fwkih0GsPzafRtngz0+r+QDXkv9gnZPb+chUehBCJyr/dXQBimZK/diDmkKIDSmKAAfYl+GDtzdgPTO0e1RWgpyDHC9vCdr+BZpxwewrAU3QYFW/6/Z4s55Oc2dA3KErGJya4udQA0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732498392; c=relaxed/simple;
	bh=TZ275HtluHJ7QnEThlBdVun21Dr4SD91pWF8p26Su20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qv0/38s5SEylS7aM84iqkkeHBTF9YVS5LqgBTLqsJhvjQwifgmv6gdmt4M5j1ZXqSRz+tEerH3jdGr1TYvxgkygNwt9niTZZPsMtga89zU6VlpGDp2HZo0qrdwvXzB5qNfqSQGR6mBe5LO2ol86ys/deOxVLLAnItC7TS7CEYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWJPEQWU; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWJPEQWU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3131711400F3;
	Sun, 24 Nov 2024 20:33:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 24 Nov 2024 20:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732498389; x=1732584789; bh=BR/j8fCb2Rt58Dy9/fcNapI9XWo6i5nzidQ
	y5DVcwxg=; b=IWJPEQWUf5WTZV7JVoGHiNXuQTAJe3D8xXtoVxdpAn93tWSG21s
	IAwWOEFCvFEiKQyHH/DbvfayQw5Vc5Rbw6KbsSt9yTfMvgb7+/3+SP/2inRpz9aW
	byv5sRNbZlNv3CAAgGeON9WQ2d3gwMIhVfc5Dd3j6Q5YamjuWaCfAdV4qPMl2PH8
	Z71AEZwqDxoD28Zgu0PTiI8hqv0k2iBPbaY5KNMLGuhZKsHqehAT7JatOpiGHJKd
	/p7/w9ps1Q7Vq3s8fZWwJMHSaTFF46pRacF/w0laCFt3GsoFo45ysSil//06iKDl
	KgW9dRrr+URMwejV3bRz3Zf2+8grMnAS95g==
X-ME-Sender: <xms:1NNDZwDHVHaq_hqcw2IPjOU22g8itjZUE6wQ9F_zCLXKvXwsbW-E4Q>
    <xme:1NNDZyjX2EheVV-mNJY_rPUcmzNVSdqfPPTDJaSBIbNeLPnnOzIbxNUSOjK0Wppux
    Hl-PhbDukFREst5LQ>
X-ME-Received: <xmr:1NNDZznk4dVu_fnviUDW2S4W-2Eg5nSGNxJfYAAgoWYStE391JmV_Mox09ys3t9KoWRkhjLy9DOXYR9qX5hg3oWMuzwvRuDtMfS2Hx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1NNDZ2zOqBs18PzlG0VyvxXDntoaAuqMmxbJeo4Z6HZmkM3QucNQlQ>
    <xmx:1NNDZ1SwKKAglJiTK6EQvF2JEV0nVKb-46CFthNvgWtR0vChTejNgg>
    <xmx:1NNDZxYoFab582ASgA2y0CH8eB2UhV09x83RuQn7y3UVsHay67nzww>
    <xmx:1NNDZ-Rm6zN8unJKnFmUTYcyWsIh0uGJpvw50CyJi-Ox42BTQ63Xfw>
    <xmx:1dNDZ3c6ducKphpiSQSQlrCcnqL3J6UL3RPIXfAThRG-xBNQV45_nD4d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 20:33:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] bundle: support fsck message configuration
In-Reply-To: <4icigeb6n75pbxqmpp3uynooef7dff2f73lxmrjjmppuz7hibo@bwb3tkffnqop>
	(Justin Tobler's message of "Fri, 22 Nov 2024 09:44:33 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-3-jltobler@gmail.com>
	<xmqqttc0cawy.fsf@gitster.g>
	<4icigeb6n75pbxqmpp3uynooef7dff2f73lxmrjjmppuz7hibo@bwb3tkffnqop>
Date: Mon, 25 Nov 2024 10:33:06 +0900
Message-ID: <xmqqed3085d9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> I was considering making it the responsibility of the `fsck_msg_types`
> consumer to conditionally preprend the '='.

In my initial reading, I too thought it might be logically more
clear, but I changed my mind and the patch posted as is is fine
(and that last part of the sentence is what I wanted to say).

Because fsck_msg_types starts as an empty strbuf and accumulates
elements one at a time, each time we add something to it, we'd need
to check if we are adding the first element (in which case we do not
want to terminate the existing list with ",") or we already have
something in there (in which case we do want to add "," before our
new element).  Because we are doing the check anyway, instead of
saying "ah, this is the first one, so let's not add ','", saying
"the first one?  we need '='" is not too bad.

And the consuming side would not have to have a conditional "if the
string is empty, do nothing, otherwise add '=' and then the string".
The consumers can just "concatenate the string, which is possibly
empty, after the option".

So in the end, the complexity for the producer is the same, and the
consumer becomes much simpler.

And this exactly pattern (which I personally find a bit ugly) is
used by receive-pack to drive unpack-objects and index-pack, which
makes it doubly OK to use it.

Adding a comment to describe what is expected in the variable is
indeed very much appreciated, though.

Thanks.

