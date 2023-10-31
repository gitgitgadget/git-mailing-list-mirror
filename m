Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02E1A72B
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="JpoTs4jv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GrtDQB6k"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92AFC1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:33:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 970C25C0272;
	Tue, 31 Oct 2023 04:33:15 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1698741195; x=1698827595; bh=ml9TywqXsuMSOXbEFU9VGy9q3
	Gth/XSJUMINr2lJMMw=; b=JpoTs4jv9Cyvq4w26ZJ6E91v6PkSeIlwpnsiQJ6SN
	/lIQBKJYDhakC4BBvhUWd7OxVu4ju8FsXnDbJTdEgijfYHRhBAG4PCG37dJV5eqQ
	YjV+hdc3IFGdl5mZEG3ZQcNUCNnmzaevos0MVoU2DU3UsrMBHt/v5oeLTT6uzKlD
	XRoZl/qzI0s2fkAr6ba99QXPy5w7uw2EGE6k6v5VA7lyKTVLukYzGFOHH2ISxDvI
	hl/QdcMcLWmKe2Gt9JJJRjqIFDdWEQnzMuQIjkgxAfMH3EFaXN7o1T6mnDTJDwb2
	RBZ0qAocfW2uuWd56hkLegEyKRwnrXl7W4hd7enQ0XrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698741195; x=1698827595; bh=ml9TywqXsuMSOXbEFU9VGy9q3Gth/XSJUMI
	Nr2lJMMw=; b=GrtDQB6kvKw8xkOl1EMQxm/6ofv55nAzoLEowjYh5uPRi/pgZEv
	DRTz3IFZL/98oTVejQhaoxJ/npBNZVejjYej30DfAGdrYmJ2bO8B5rBbjZFiCAnN
	J8BGKifIUOyFqlYFZStiJug1JRNGOaXckUHklw1028XcaiKQje7JQGar62PDyWwM
	8J4m30PTipD+e/N5ALh2Jbp3tGdOLCYpPoSkXnLMJTdYFXuG6Ecgkn2tat09yzF2
	wqlQgAzwAG7/TXT8YnHEx7mu3+0IUFrhUoEVUSmSn8UPhzVrTkPF5rt7uifIxU0Y
	/9euMrf3YfbW7wE07wJaKvepULlxIEo74kw==
X-ME-Sender: <xms:y7tAZQY8WZuH7wF9OysLcYA66P8mt4ZQ50tmQ9nq9NFqCn3FkSsH_oE>
    <xme:y7tAZbYOaiJmBakO_3ARL2nbCTEGCRJkM9ZPFE-vRWmmJQNdl1upL9WeOS3ewHRVf
    kK5W5BLLdfP-fHnxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:y7tAZa8fiEvKASFIgCZB1S95dB7MmVsGmEqFn6SU0zP4opzDBcE22w>
    <xmx:y7tAZaojpLEzLNFkZtMJ1IYsQaLH4u0K3jPCytisGuEYWuYJbptqDA>
    <xmx:y7tAZbqv6aP_c6zT7l6oDyiDlKHEmLauiQpqwiqfgYo1tmPxAzRNDg>
    <xmx:y7tAZS068e1MLm28WTYiD3r74H2OIvSyYZx9C2I7cnZQAWQvHDd7vQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4FDBA15A0091; Tue, 31 Oct 2023 04:33:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb166ed4-b8b5-4120-b546-e878445573b6@app.fastmail.com>
In-Reply-To: <xmqq1qdb8wzk.fsf@gitster.g>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
Date: Tue, 31 Oct 2023 09:32:55 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Ruslan Yakauleu" <ruslan.yakauleu@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023, at 01:19, Junio C Hamano wrote:
> Another more fundamental objection is "Why do we special case only a
> singleton commit?"
>
> Why isn't a trivial two-patch series also OK to fast-forward?
> Three?  There is no inherent reason to draw a line on one commit
> topic---given that a single commit could be a large and involved one
> that could have been a multi commmit series.

I think it=E2=80=99s about the `--first-parent` view. Then you get a one=
-commit
view of each pull request that was merged. For a merge commit it serves =
as
a summary of multiple commits. And a merge commit of one commit would
serve as a summary of one commit. So in that case you remove that extra
level of indirection.

> And you cannot decide if the "topic" is large enough to deserve a
> binding merge commit even if it is a single commit topic, or if is
> small enough and you want to allow fast-forward, without looking at
> it first.

But the pull request is already given: it either has one commit or
several. And you can for sure look at it and either argue that it should
be reduced (squashed) to one commit or maybe expanded (split out) into
several commits.

The point at which you use such a merge feature is when you are already
happy with the pull request (or patch series or whatever else). And then
you (according to this strategy) prefer to avoid merge commits for
single-commit pull requests.

=E2=80=94 =E2=80=94

This is not an argument for making this a built-in strategy. Just an
explanation from my vantage point.

--=20
Kristoffer Haugsbakk
