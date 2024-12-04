Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6319624
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271705; cv=none; b=fLhrNELemgO5gaM1S5uuX+6u0G8GwMiEMLJCH/mPNNLRmRYXZVmUQzGUjOLhlttTidS2VS1pQMa89PzuPyVonu6LfX7umJCQS/FQH7hbIVtbenVbwb03+2hi2hNEtGWp9FqmdnpDyzKxkxuXAUhimRfsHnKdW0H8dy2QITQy8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271705; c=relaxed/simple;
	bh=2//5Y4T34NM5MD/4vqaIqKM59dyE58LqN5favEAoUk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6FIbCaEzQk47+PKIwQceWpZ0VxO5FnB/GWGSaB3QQ0rkM+zvHrhTJFa/XO1RZ8oa5140SezbD79ympidbG06xz6P0VDHpW298EgiNdLe/T096X0oWkpqe2Syum1kyD9yJ72puujK7UKBHPECmHlHdvoxwdq3EJTZZ0z7KKfD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zeheYRvB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zeheYRvB"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E66C311400E8;
	Tue,  3 Dec 2024 19:21:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 03 Dec 2024 19:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733271702; x=1733358102; bh=xSj4cPbaXv8v5aHDvS74414SrkKi+llaXRe
	TxAbXLWo=; b=zeheYRvBx0b0Yx8VkV0AFJ+1R4UIxWMgfSKVctlm9Rgf14U8Mgt
	wcqJMbDl3L3k8+WLLv/jWrfXVruMVbuxxmKYGSaO69TZgWOqB/swDcBbte16WdNX
	JZ9ywyq1IGkG589k9r3Jbkv9zST1qcBxVpbLPUbilC/6xwWRl166c8U2tsZkVTI3
	LvpAqLy1HXauXhmIg/fVeloPgzstiOOQy/O+ArKznuYIUdDpQO8iz37QjjmMAqTy
	V+Gmvv12Jc7QAKZoid+bEtc38SPey+BcVgMkKSH3WxCQJOd8ZUxiDu33bHiRBN8W
	Iowr00c48MYInbJppOg0BHgL8+S/p2043nQ==
X-ME-Sender: <xms:lqBPZ387u1OTZrLy3A7gj57ApfHZ5YPsUTKp1u8rYKg79leAI5ws7Q>
    <xme:lqBPZzuLNiGm6VlvZhSswgwWzAMDj-cvTw0zTx-j5-NsvwzqjUaidzA72rrHzm77k
    gppKuYWmW7qHjsqFQ>
X-ME-Received: <xmr:lqBPZ1CiFKEBmmF3prAhiabFPHjqJJEq4dc42V698C1CeSZxAOJB573ocNB2YlrZoFhYqZt2Sy2RADSuThCZqz7Ik6JC6m9nkYxDRco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lqBPZzdoQGZ1az9TloWgwGQAqVIT9m1CLOL0FKvazGtQqLk4B2Ot2w>
    <xmx:lqBPZ8ONBWhWCVTizioU_XBjaHOmTf1YnAFMroaG30lg4ql8RSxlvg>
    <xmx:lqBPZ1kqZZL3_v8JWRhc7kdpbHsiiS3mDpvEfUYGqfVkoPqqyYmhdQ>
    <xmx:lqBPZ2uPyONLIO6PtJXvTlRFGaaXxULAD9Bae26WHYoY8oZLVzc37A>
    <xmx:lqBPZ5qAVnJe0nYAUlw9ZWQyNhOQIOQQlDU_rXXhHq6X9N318jL8SM4J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 19:21:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com
Subject: Re: [PATCH 3/3] index-pack: commit tree during outgoing link check
In-Reply-To: <20241203214209.2033773-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Tue, 3 Dec 2024 13:42:09 -0800")
References: <20241203214209.2033773-1-jonathantanmy@google.com>
Date: Wed, 04 Dec 2024 09:21:40 +0900
Message-ID: <xmqq4j3k70x7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> > The fix slows down a fetch from a certain repo at
>> > $DAYJOB from 2m2.127s to 2m45.052s, but in order to make the fetch
>> > correct, it seems worth it.
>> 
>> And "the fix" is not described so a reader is left wondering.  Is
>> the fix for an oversight of not checking merely to check it?  IOW,
>> is
>> 
>>     c08589efdc made outgoing links to be checked for commits, but
>>     failed to do so for trees.  Make sure we check both
>> 
>> what is happening?
>
> Yes. I was trying to keep to the character limit and in doing so, made
> the commit message title hard to understand. I think the new title
> should be easier to understand (and also stated explicitly in the commit
> message what is being taught to Git).

Thanks.

>> > However, it is also possible for
>> > the server to compute that it needs to send S and not O, and proceed
>> > from there;
>> 
>> If O, C, and S have all identical trees, then wouldn't such a test
>> work well?  At that point it does not matter which between O and C 
>> the server bases its decision to send S but not S's tree on, no?
>> 
>> In any case, will queue.  Thanks.
>
> O has a different tree from C and S. I will add a note to clarify this.

No, that is not what I meant.  "If you arrange your test so that all
three have the same tree, then would't the reason why such a test
would not work you cited disappear and make this fix testable?" is
what I wanted to ask.

