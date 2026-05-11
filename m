Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0562032D
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458587; cv=none; b=ZB4tLm5Q/FAuimt32bSMeZnU17R9kJh5f+KMIrgehInCuaa8ynIkVnHnMWDSYoLvuwARj7Rqc8HlHfJX8npuTJXjjSGKTDcbjSnIwL5yYeZUjrNJpwOlWPc0pLzNGz9BDJ5LM4ym2kWEhP3YtABDaeUW8IFPpGeBq0RWCFra0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458587; c=relaxed/simple;
	bh=bXi1anQXCV/HT/ysapGYNmz9Y+MeszRkT+1nJEygseg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TucTrnouRLlV2Jj6I2/ko1OfmsxsZDu40B2XolT+iRJuvrrINS9zT58Ji5c1f/xKdHOHcfZiZa7gQfzSZW5ZRsyQWqupf3WrZd9Csc0/2G5RsUHBEIOfKjKxQP/bKQscQxze6cIeS9bWVwoVwZxBR/lg+PTgCYCArvdprCFUs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net; spf=pass smtp.mailfrom=abhinavg.net; dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b=JCbBU+hG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+K9ndjW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b="JCbBU+hG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+K9ndjW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BB3EEC0067;
	Sun, 10 May 2026 20:16:25 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 10 May 2026 20:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhinavg.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778458585;
	 x=1778544985; bh=kD/DmLvSaWSTYHOGdNdRdrj9dDIVKXpl6o6MH86+kpQ=; b=
	JCbBU+hGliykjtXpkPi/gVbAc6BB9KJa/NXdnk6bh64G0L5ZWd1lzks1P8Atn0kp
	4oRaThx/4NzN0UrUkAM4wZ2bz1i5nCUF5bU0kzJNKGoO5V7lXPjlvcyDZQB60ha6
	j0QeltBUHaZwLqTMdyGO6FmXikdol4U2StuNo74Vb8TmD9q/T+7vKDf+De6OCd1T
	hSwYBP2Es2rcIsczRMiOYDA91BNFzE+KnVstlzC8Bmdhlcy3pg5pX6hKffpwioaN
	MVAjCLXCgDCdVrb7hgF076jml2fyeNfZoFhZWiJOZAskJjTCxDbc5zoxzKXBAD4S
	Ua3EiHHsCYe6+q66XQNd+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778458585; x=
	1778544985; bh=kD/DmLvSaWSTYHOGdNdRdrj9dDIVKXpl6o6MH86+kpQ=; b=O
	+K9ndjWwFq3Mlx2OMd17MJZ6R8oq2ULKrxx9pA2ZPsYtP7lrR88vZr1SRq1Ot9fm
	5ysTYND+uxol6D/De2D1Jojjlr62RScidc6WDFiNioG4TJ6mDUBLTcaDdTOQJwrR
	jX7FrtWhowBtR7wVkzlA4Ttq8ojh/NLzjQlI6m4cih4FQwvMv8X5Y8sV1ISQbLFd
	4X1KEQWebeVwPLBHOI5/Sz8r1vuSxPMPryhEQR9/y93YupQxtcjsw7qz8EknAt5A
	N8XqgGpW7yby4n6ahPrJxjwQaP5smBLjG7azqsxw12E7Lk9F0kUelhc8uSlGYvaR
	9/qMUNq0fBUeyZIcISaPA==
X-ME-Sender: <xms:2R8BauF2GzNW4ZdPK8K9FY6LUa1xMAywT5QCWPW1awI05fHUol5pag>
    <xme:2R8BaqKXegA0fwQca10LvPbEwL-ddTXwfQxp-FA9mGjFtaf_Tzfl_xLzW9m9Kd-x6
    ZtFFHC8GdsLv210PGfF_KU1L9NVvZ5suIO4NhdtOWKvG00yUjDk1Yc->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftegshhhi
    nhgrvhcuifhuphhtrgdfuceomhgrihhlsegrsghhihhnrghvghdrnhgvtheqnecuggftrf
    grthhtvghrnhepuedtfffgueejveeiveffhffhjedugefffeevleelieefkeegvdfhteef
    ledvhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrihhlsegrsghhihhnrghvghdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2R8BavvMDgg3jqhgE56ZxaoDJJYsqw6AweF9jQe8cyioNRmnJ9mS0A>
    <xmx:2R8BauTW-jQuDiGtpkbcLHQWPhrnDnzjhlSj1G6kwpYU2BpuUnhNCA>
    <xmx:2R8BatOMT2s9iHpKNwbo4r-sDuwdXfaDUe6LEHrk34GB82CZ3vgFIA>
    <xmx:2R8BarbVfkTbHHDlvo9zeJKIgYYUSQxV7964fwURW8Bvtc1D4wxI2w>
    <xmx:2R8BanjCdVMDGTF2DJiw6r3SvHwNB8TZRYfdkBIH2iN4g4wX38futCk5>
Feedback-ID: i43f949e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 564A83020081; Sun, 10 May 2026 20:16:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxnbQjaRaRXw
Date: Sun, 10 May 2026 17:15:42 -0700
From: "Abhinav Gupta" <mail@abhinavg.net>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <63e04828-5895-4deb-a698-5d6f494d23f3@app.fastmail.com>
In-Reply-To: <xmqqv7cu96q4.fsf@gitster.g>
References: <20260506023944.90691-1-mail@abhinavg.net>
 <xmqqqznk9ih8.fsf@gitster.g> <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
 <xmqqv7cu96q4.fsf@gitster.g>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sun, May 10, 2026, at 16:37, Junio C Hamano wrote:
> it would have failed to work due to the "HEAD" thing, so even though
> existing versions of Git may have added such local tags to the insn
> sequence, it would not have been a workable configuration anyway.

Yeah. One additional data point:
non-interactive rebase is also broken under this configuration.
Given a branch off main~1, it runs into the same issue:

    $ git checkout -b foo main~1
    $ git commit --allow-empty -m 'do things'
    $ git rebase main
      # ...
    error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
    error: invalid line 2: update-ref HEAD
    You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
    Or you can abort the rebase with 'git rebase --abort'.

I'm guessing non-interactive rebase works off the same todo list so that makes sense.
