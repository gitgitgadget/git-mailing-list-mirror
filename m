Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADA346AE6
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833845; cv=none; b=kO9OKe8lood42/Ljg6JmSxDh++JNOm2c6DfyDRR0e4lvq27hNWGqWcnA38CIrzqQL6AOOGRgtWlP3Aqhp3FI68qp4u7ibqjpxU+tSW9Bf28RWlFQPLa+nQcTpbbD1yxN+UF10+hp3pADocVQzx1dmrPPGNb9UT4aXwlysFno82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833845; c=relaxed/simple;
	bh=SlZsAJIEsEPteJ6BGiHhdBYRaD9h8wawdGXYtI1SjXk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N9U61H9qd59mAkYwxnpdu2iYadUjJO0VJe3RrqGvCz5Nfs3moWzZvsBYzQ0mIJkQMjovHqqj8qUl02YDK0WueAeEljxhdxkZsHEil5ABumleEg9HbA4pgW6T/Xh3Ml18ztnGsgJ7Raa2esavSdDVYAMTxzMfy6IY03fEu2zjWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev; spf=pass smtp.mailfrom=braithwaite.dev; dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b=Fg/ieurg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pTt/ikpd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b="Fg/ieurg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pTt/ikpd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C4991D0020F;
	Fri,  6 Mar 2026 16:50:42 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 16:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braithwaite.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772833842; x=1772920242; bh=xDd3BrUYJv/dHjDINEpcZUQic758iIJL
	LzVMSsXxg+Q=; b=Fg/ieurgJw+WP9rUndhiedNCnjCfKLwHztmJ/48Da1fk3R6t
	287j0aXm2EOpX3BlxoV+2ONjkb4YbJb93iUCvvMvcoQ14xDPbCzbT2HUtA3+oRab
	MbP4g7cP+mtChGJRHnK/LKSEkhUis9miBcKUeH/gqoxE7QKABrivaDRU+wci7qBK
	+BhQWZEMHKQno46teAGXdfqeO6DYFGPs2we0grQmqLaywTHU306x49+Iyhh5J6WS
	mCdXnjSEbynGFHGhnVnb+D/9mlCyCgyO6PB2waXB4VQOYEHJxIdR7WKxGB2v925p
	YcrsBOehZ3hPVlO5f4vNloz4youqPhtYPoaGHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772833842; x=
	1772920242; bh=xDd3BrUYJv/dHjDINEpcZUQic758iIJLLzVMSsXxg+Q=; b=p
	Tt/ikpd2WqnK194GUQtvqfBzu6g94XHoLQVAeduAayjQtQSD1piVBaKeH4hVM4IL
	fOB8UHFz95GEAlCKIB4Q7iS4rML9cyite9NzGBTxcPAKSWnQh52LXVt7BqPqPfT9
	SG9e2LdI8v5r9gQfhTPn7GXW7x153DTMWGAR3PQFrxKx4+eHxEhfeUDXCxn3ecM+
	eAmieL+K+grZ/w3rnFJ2I8bhJ6qODRao8OL7TCKk8PXaniuJJ1Xu6bNcN8VMcrJq
	EQ87gJIvpf/qjpnWJlGYja/v6/f5StApwVyfFfxiHkdm3OmLnsWl+4omIV+tbx/q
	lD2ORVoY8GDTqPt1313Dg==
X-ME-Sender: <xms:MUyraabAFVZYKHYGRVcLxtN9_X_OsK1Qdg788WheVkdUPwR1c2yGZQ>
    <xme:MUyraYP-7pp8TtXi_YEFdALe4WcSqjC6ShBdM3zJdnvw0AY5W1YU89t_FyM4zdFcS
    CjLRtYcBDD90hAgpYPx-usviP4Jng9_n8-r7hGU1N2iHqRsEZf4cms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlrghn
    uceurhgrihhthhifrghithgvfdcuoegrlhgrnhessghrrghithhhfigrihhtvgdruggvvh
    eqnecuggftrfgrthhtvghrnhephfffueffkedtffekieefjedufeehkeetvedvkeegudej
    tdeltdfhtdehlefgueetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghlrghnsegsrhgrihhthhifrghithgvrdguvghvpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MUyraatfMMDRJds0DdeT5-OdLD5kdxgqDTS8vc6jBtGkUBKCP34OrQ>
    <xmx:MUyraZd7GTtdHs00K_iE_A07R_Sjz9zW0xMZZxd18rXva-JfUqgN2Q>
    <xmx:MUyracbXVRjrUnWjKnUgn2yvB7tSAfeODoNIw0d7EUfnJb1oFFVP6A>
    <xmx:MUyraTbBqPuu3by2M_X-pjZvPUm-p9Xc4w5JqVbXzh5ChGLsJt_IYw>
    <xmx:MkyraZ-_-5nMj5BvyKYOKEM_cAXgY64KLYnjp5uPub-82PjmB-6M0YDb>
Feedback-ID: i1a914699:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A58B91EA006B; Fri,  6 Mar 2026 16:50:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AItb9aa6r_v7
Date: Fri, 06 Mar 2026 13:50:20 -0800
From: "Alan Braithwaite" <alan@braithwaite.dev>
To: "Junio C Hamano" <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Alan Braithwaite" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>, christian.couder@gmail.com,
 me@ttaylorr.com, "Jeff King" <peff@peff.net>
Message-Id: <18655b73-0050-4255-aa7a-c0bcb854fc6b@app.fastmail.com>
In-Reply-To: <xmqq1phw21op.fsf@gitster.g>
References: <pull.2058.v2.git.1772672251281.gitgitgadget@gmail.com>
 <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
 <aaqu44_sDJYcftWd@fruit.crustytoothpaste.net> <xmqq1phw21op.fsf@gitster.g>
Subject: Re: [PATCH v3] clone: add clone.<url>.defaultObjectFilter config
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Do we have a way to defeat the configured filter to say "no
> filtering, we want everything" from the command line?  If not, that
> needs to be addressed, if we were to add this configuration.

Great point, added a check for the no-filter flag and made that
override any defaultObjectFilter setting for the clone.

Thanks,
- Alan

On Fri, Mar 6, 2026, at 11:33, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> We've historically not implemented default filtering for clones because
>> it makes it hard to reason about the behaviour of the clone command.
>> For instance, if I have a script that clones a repository, it almost
>> certainly expects a full clone unless it requested something else.
>> ...
>> We've traditionally placed this kind of customizable configuration into
>> `scalar` instead, which is designed to be configurable and set options
>> for large repositories that would want to control clone and fetch
>> options.
>
> Hmph, my knee-jerk reaction to the early part of your message was
> "oh, but isn't clone a Porcelain (admittedly without corresponding
> plumbing) whose defaults and end-user experiences are meant to be
> updated from time to time to help users?" but I didn't realize that
> we have another class, which is "scalar", these days that we can add
> these settings to.  I do not have objections to add something to
> "scalar", but I personally feel that the configuration for clone is
> such a bad thing to have.
>
> Do we have a way to defeat the configured filter to say "no
> filtering, we want everything" from the command line?  If not, that
> needs to be addressed, if we were to add this configuration.
>
> Thanks.
