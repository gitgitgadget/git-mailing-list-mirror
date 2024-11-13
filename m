Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1818D62D
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538662; cv=none; b=FoJaEqHEqhgFVquyM67fYr6HH6laS7qpn+lkTBOJ2oySeZ/JP1XE2CWwXmWSWoixErSZd5+BgtIN+a97R/K9UK4w8K15hPLh1p0Ml6HUlxU9Wj/9Pi6I5LMRU+nB9oCQqhhyE0ZQAWh7Yolvx81+hhLn5N/Q3ZW4380uRE4gSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538662; c=relaxed/simple;
	bh=I6gisKuEoBAGsHzy3g9ymhnKNXBFyQAzwd5BK3t+RKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cC56r3vjH7Q8NneZy7cnbJ2QBka8tMXyl+EbPZNxT6AlXI0V/znas4C1q6IWspfwxRRXb6bxB0wazZT8yfoykoStem5ZInlauv8UG6dUd1B4XQHP8A0/KmcMmlpCgxCQwNfhQ2PoG7LEwoXj/VOuszprmYLervnYtPOixDQXlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVFl2gGM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVFl2gGM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D848114021F;
	Wed, 13 Nov 2024 17:57:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 13 Nov 2024 17:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731538659; x=1731625059; bh=fylZCqSRQpPVUZnXcIcmvlj4zp0eBqcdyTJ
	Qi329ms4=; b=LVFl2gGMY0pifTISaA664RZiQ+vMxLhySxagbkFQ1XvcItEuBjN
	fAKWp/ldqA34CxoPG3QcH7zJdLw9LHCknJWBk1ggp/xAqwrtryooMnoZllRJhSFb
	QUawkZJUmrmyPib+4bjDqLFN3MIoPLfWfFzq09hwRYnZS9tzRoNFKDZyRLo+HRbr
	AGl1e6qySf7uOTsM5i88DnfjYfQWJIwk6wncdPaGHST07T00G+Ur0Gu6uoaOOEni
	gyKP31wbYkrApX3RJcIsGjdX8TX4HqIkuriqOtYPnA+aeRgNmH8uFkotnBv/n8uT
	4bo4/SknyWg8RibFnV+leqhP4a3P7kEXC2A==
X-ME-Sender: <xms:4y41Z_qe4WUUyy-GrPuZzpNWhco6XgPFpaxARdNxdzLLpnfaaX8NMg>
    <xme:4y41Z5poU7gm3dmcgmTXuhTT6HTuUDuuUO7is15PhL-m1aPgRKQM5WmhVFOYnzDp3
    eVMXGnwJqk6czyOEA>
X-ME-Received: <xmr:4y41Z8M91lyZG-puRncDv-Lnjo-kfCjzuTcWdsd6i6VO8GgmbBvmYG2oOAJAEEsij-x5qLL7sWB8wT7g44FBJh5PohYEUEVpap9_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4y41Zy7qXFETjq-p9p2QWRxLlIAyLWdDXym9Kk-LffRsFOMVFuqS1Q>
    <xmx:4y41Z-7NoCEi7YKu915N8LOEM_9Vus5cGhQ94XtHd_09sAfWbBzpxA>
    <xmx:4y41Z6geyobwdCXYIAQqPxWNfnAj37LXGcFxDoNDA-5thwa3EbVKVw>
    <xmx:4y41Zw6PF2GQ6ZKEj7Sn9HsiN9IUfn_YGUadfDgh8ocQ6x9t-6a-BQ>
    <xmx:4y41Z1ZNMIwK9gtQbebSx0NZcPa_TJ4CsrOv6F4eIbbIRp-UavlAQ2rX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 17:57:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  stolee@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 1/3] sequencer: comment checked-out branch properly
In-Reply-To: <5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com> (phillip's
	message of "Wed, 13 Nov 2024 14:47:47 +0000")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
	<fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
	<xmqqikss2b7l.fsf@gitster.g>
	<5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com>
Date: Thu, 14 Nov 2024 07:57:37 +0900
Message-ID: <xmqqzfm291y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

>>> ...
>>> +	git checkout topic2 &&
>>> +	git -c core.commentChar=% rebase --update-refs base
>>> +'
>> Can we improve this test a bit to give it more visibility into the
>> breakage?
>> I am sure that the internal machinery gets confused because it wants
>> to skip commented out lines assuming '%' is used for comments, and
>> fails to skip lines that are commented with '#', but it is a bit too
>> opaque how this would break without the fix.  Perhaps add a line or
>> two of a comment to the test to describe what the expected mode of
>> failure is?
>
> Or check the todo list shown to the user with
>
> 	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
> 		rebase -i --update-refs base &&
> 	test_grep "% Ref refs/heads/wt-topic checked out at " actual
>
> so that we are sure that line exists - I had a quick look and I can't
> see any existing coverage checking that the todo list contains this
> comment.

Yeah, with "rebase -i", it is a part of end-user experience to see
these comments, and a check to make sure they are shown to guide the
user is certainly a good idea.

A test of "rebase" without "-i" is a different matter.  Maybe in the
future, while we still reuse the machinery used for the interactive
mode to implement the non-interactive rebase, we may tweak it so
that we do not generate commented lines, only to be skipped by the
parser, in the todo list file that is only used internally.

Thanks.
