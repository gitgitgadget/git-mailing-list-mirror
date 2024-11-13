Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F42AE84
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538861; cv=none; b=a4mhoLZvrMLjN9xTSg7um3NH/ITlQRVvHV8dQMWnOjt0yY5aJct2+jjUCbH8139EEtL2t02OP3BPkZ8kUxVizFEvVv/7LmgWu/z+mHVeu8F9hbp3M1psUJMej+bQOdWr2DzriDWPGdZ1TtyIWkBxVSebbIfrtZxmiGc2zEwWGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538861; c=relaxed/simple;
	bh=EMathhzpiL4ZiXynnzLHuh7NlpA9uu03bNLuW8FAElI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enhqazqRoCSfYlln5XxTHL62pe9FBXEwWMoJ8UJwisdkNCldcIXHbl5+DuCR/Ck67qHtZCBLoG0TxOLS6Tm7yBQ87k6kK2d1FlqnCkDIsO9diAS+KDouF1an5HGETkBWCUBRO4h3cBV5u1+g7J6bzdLV5oq705g+VO7yyAMYgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jdQn5KqR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdQn5KqR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0764254023E;
	Wed, 13 Nov 2024 18:00:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 13 Nov 2024 18:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731538858; x=1731625258; bh=V+iQf5StHhFjMbMsfHwGZB0heSNR7PA8J96
	xHL4pzXY=; b=jdQn5KqRGx1Y3R2QA/NAVNYbvagZNRjxc7nz+EhcLUJ8z7Xicuj
	21fWVD0MUWKtS//zpoOnF9wO2n2kZzfh+nQQxniT88+yLEH57+u/uQuLmJ5gQ96M
	7VRcpyK850CVi1iLFvHX7Ohyb0tsUqcu6y49QTaTRRddqduDLp8Inl3i2ciffSc6
	NUbGhZXM80P9TnZmoFK+x9CcpLWurCiVYqZmxVbSp5CBf87GTdQ2Hfn0gkCf3/K8
	fLrYTKcUPrfIu+7GXJGEaAIWgv6zY0qL94g5/Ym620VSE4MtOIFhN6yWfXlHskVA
	brxpZ9m893hmzDjKk9ndT7ai4koWP7xpKAg==
X-ME-Sender: <xms:qi81Z_7ur0dI8GWPn8-SyUpvmKHiyPasp9yqkRge5RcH5UpZNezSMQ>
    <xme:qi81Z04Sv3S9XmBhat37Fc6AK2nhroaDU2e93WC4qLov331QucEE0qBWLlXGbtp_A
    tkAZKmrs7Ee0fOLcA>
X-ME-Received: <xmr:qi81Z2c3FdslAHZgOiN7Ogx3YSPcJBYasv_g-QoIlS6Gy4llI20GEzb3s4mftjq63Dvv7APOaOyFouLDnr8RExld9moF-H_RsJZo>
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
X-ME-Proxy: <xmx:qi81ZwKNpgGZmc2qChQ9Myr7Gb71cFlTSSJyJ_JFTtVb3DNYCX994g>
    <xmx:qi81ZzKatUwZcbtriEPwUX5YkmqBzSiBzIbu3dzd6EL7YLlnpkMisQ>
    <xmx:qi81Z5wv2tSHFQBA9vTYQBpo0ZYYT2aMX27n3le8cG3H2G1SPAas4Q>
    <xmx:qi81Z_L-GUZYvHfyHorIwwsHe6HhvWD_xAvEcsPDmcGw3IfVSR4OOA>
    <xmx:qi81ZwrMaaDiPSvaucE7aHL3Zd9R5zw50Ot6mdosAyWsO-6mDfwVf0Md>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 18:00:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  stolee@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 2/3] sequencer: comment `--reference` subject line
 properly
In-Reply-To: <4c623fcf-01dd-4056-80c1-b3c860ab7f87@gmail.com> (phillip's
	message of "Wed, 13 Nov 2024 14:48:59 +0000")
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
	<cover.1731406513.git.code@khaugsbakk.name>
	<710c5b1a3f6bf8dc112ff13f27a8b2165274488d.1731406513.git.code@khaugsbakk.name>
	<xmqqbjyk2b70.fsf@gitster.g>
	<4c623fcf-01dd-4056-80c1-b3c860ab7f87@gmail.com>
Date: Thu, 14 Nov 2024 08:00:56 +0900
Message-ID: <xmqqv7wq91sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

>> I guess this fails by leaving the "# *** SAY WHY" in the resulting
>> message, because the stripspace wants to see '%' to start commented
>> out lines to be stripped?  If we inspect with this test what the
>> temporary file we give to the editor looks like to make sure that
>> '%' is used for commenting, that would be a more direct test, but
>> without going that far, at least can we have a comment describing
>> how this is expected to fail without the fix?
>
> For me something like
>
> 	GIT_EDITOR="cat >actual" git -c core.commentChar=% revert \
> 		--edit --reference HEAD &&
> 	test_grep "^% \*\*\* SAY WHY WE ARE REVERTING THE COMMIT \*\*\*" \
> 		  actual
>
> Would be a more convincing test as it actually checks that the user sees
> the line that we expect strbuf_stripspace() to remove from the final
> message.

Yes, it is a more direct test.  If we did that, that would of course
be preferrable.

Thanks.
