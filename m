Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BC1FE47C
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325553; cv=none; b=fQyhUfyd0WvhL0XKusqtxeLc2LMxVB3nCPnzKMjwgxXRlOsTSREKaeq33Ry+oBSEWjJQx8vakBDJQGcuIk64btljMvUWnGVv6jtDlQwhitvF1DI5Qvv3qo3AISNXwGAihWIMjA+oVyGPVwYHS9bpyeKgauRjg7gq81DiNlPsGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325553; c=relaxed/simple;
	bh=LuZ2+2n+NHeUm/2CCdzrzeaivOrezHgwEe2NKJ9OZ4k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CCrWWPep3vMuP8S1EkNeqyqGs43En2TQDfL9RWNGq71TdllYcqA0YbJ+r0RYYxdogWMwd/kV2gwm7rQZK3rxVxIUrHOfR6pABHpom/b4cXPvQyxPu7bAjCYIlHAXK3H8jBi6qo6bJszgpCqqlzQMgXV9qqMJmvdEOiak9PmRo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CHVovmFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+9ptvBk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CHVovmFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+9ptvBk"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 97892EC0179;
	Mon,  8 Sep 2025 05:59:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 05:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757325549;
	 x=1757411949; bh=/bnI7Q9MWlStYCrvpmQ1AMXQLgPD5BBNmX7KKirjKNs=; b=
	CHVovmFO8JcSlMhD87chcTLXKo/cFKPBAtHz3TgxHTFTJTtNR2Tj5BmITXHe723I
	j6ipqlGBIYpz5RVVaBzTYrj3kakVLkdX4vZwxsrvMBcDcvIpXeGpzx4qaiNarQLc
	Yi/Hz5x8PifESPIKDhW2dkCbSzdWb7+BQYzC9EIXSPW3v7SIuyTNvVJiLbD3n5fr
	hGX4ZkpYSb0IoLBvjY7VWcflKdPsUr75MXV/U+tE9NbrGZ9eBq/0HX5UVJYVwDBL
	PMd+yjeTzC1vujxWQROdF0Mx2JWmKDqJRHMjOWT/7Lbg+KERYodi1NjM+Es93qan
	OstS+OTh6Io/gceg2IuofQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757325549; x=
	1757411949; bh=/bnI7Q9MWlStYCrvpmQ1AMXQLgPD5BBNmX7KKirjKNs=; b=g
	+9ptvBkyAZgNOKBrNY3vxmgb/Jr+UqBtsb/4gygGoizlPoITBN+OFSCPcVKOA6f5
	4LTRA7fu1Qzj2//P6YpmTF+v7ev8d99bnb7Rw7iN2hm87u2aJB+BxiA4WekuyMYR
	yB+jg/M0cvQhJn3Iw7rERRJZxyrHmpSw7zLeuykfXDp87/i9WvJhi5rskKTCjm4I
	CdVhc6mhL48cDp8u/9Ze5LCWQqxiV4ZEsZb59xIb7Nn5n3nFB/zIo8W5Iw+IPG+Q
	A0W8ScJX0L5OMvKUprXulQhgOLK/mOgqJ3t+tZEXTsLMvDkSJxuUtt4jIErYfnQt
	9XfT1GGtcU6BxcDrmXpxw==
X-ME-Sender: <xms:7ai-aCAy8rUSDjD_bZjx8JKngeD-rjGU1k6tlbxco-FRLA-PEXP6NfY>
    <xme:7ai-aMgznk4mTgw7z8cWJCGBOublLH_LhUcKsqyNVnahPKg_relclmBOetjbOFlnq
    SL9b7dVNALtzYsgfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghgrsghrihgvlhdrshgthhgvrhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:7ai-aMR7EenWOBcq5viK5sBsXIAcDoKIZ4c-11DuEgGvALFpVGzL0A>
    <xmx:7ai-aO9YkiqObsNCuxET6cTLTqFLWErZDHvw82BAbYzfXr4QEztKJg>
    <xmx:7ai-aKuVQrvJdhep5CuvjojCYok6m_YDWo536sg193i9ddxfHawZgA>
    <xmx:7ai-aGOsOFTCcscnmb0ysVwuzJvPC1oYWNzPJrx_I9EAi5xB0nusoQ>
    <xmx:7ai-aIOw76Ph0lV2xecg8F24_bu8zUG85yre1zRLFc1pgpUUxd_8C7as>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F6D51EA0068; Mon,  8 Sep 2025 05:59:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIy4R3mHOV7B
Date: Mon, 08 Sep 2025 11:58:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Gabriel Scherer" <gabriel.scherer@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Cc: "Matthieu Moy" <git@matthieu-moy.fr>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>, "Elijah Newren" <newren@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Todd Zullinger" <tmz@pobox.com>
Message-Id: <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
In-Reply-To: <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
 <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025, at 11:28, Gabriel Scherer wrote:
> Dear git developers,
>
> I find myself affected by the removal of the `git-new-workdir` script
> which is a relatively common part of my workflow. I am writing to ask
> if it might be possible to reinstate the script in `contrib`, and also
> possibly create a discussion with other users affected.
>
> (The removal of the script was released in git 2.51, three weeks ago.)

Did you run into this issue when upgrading from 2.50 to 2.51 or from an
older version?  Was it simple to troubleshoot that the script was gone?

Just curious.  I=E2=80=99m as na=C3=AFve about release management as any
random person!

>
>
> Thanks for your work on git!
>
>
> ## Details/comments
>
>  > The command thus predates git-worktree(1), which is what people use
>  > nowadays to create any such working directory. As such, the script
>  > doesn't really have much of a reason to exist nowadays anymore.
>
> `git worktree` suffers from the substantial restriction that it is not
> allowed for two worktrees to checkout the same branch.

You can override that restriction with `--force`.[1]

=E2=80=A0 1: Naming override options just `--force` has some UX issues l=
ike
    discoverability and the fact that (in this case) it is used for
    multiple orthogonal things

> I understand
> why its designers felt that this would provide better guarantees (it
> is not a good idea to mutate branch names that are checked out
> somewhere else), but checking out various branches to test them and
> inspect their code (before returning to the feature branch I am
> actively working on) is a common part of my workflow.

I agree, that=E2=80=99s a great use of worktrees.  But I never feel like=
 I have
to checkout the branch itself.  I detach on top of the branch.

> Getting a 'fatal
> error' because some other, independent worktree also checked this
> branch out is a hindrance.
>
> Note: I don't know about the `worktree` implementation and whether the
>[snip]
