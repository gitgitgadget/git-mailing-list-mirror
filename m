Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1D34F27B
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778483; cv=none; b=ir8uCjhlklrmrSTMHpIxVrl7qR1zhAGWJDzFlaYhwdiFAB/g+Ma5yBBTpP8LIqjYCzFijCBkt3CZTwLsa2wJhENfxwr3IejSiCcvkZO2sT9GJ6RUXy8ATEs7/amwMd0fID3YWdDrRw8/nJVxh9pQiHg0uhKDLj4MQwJa7aByzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778483; c=relaxed/simple;
	bh=yMoRvohzLoYF6wfsUNf0Mm86YxCJ920t2SVivzDj370=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l7XJicQ08xKyxekn2YZNCHlMgZV0ubqls5iJ8CzGmdq+DwL5LUC+D7TxuWjDdBt7f2Eoac5Rxg6fuSN2v7CAkWje9+XEZSo/1Vz0Xb47HXo6F+bVrlrsEcb3Cahcgee6/R4LFI2EktV5FXJKCfZq9yGJ3MV6zcunPHWO2ups1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KW8pHs2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wuQchyTu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KW8pHs2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wuQchyTu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 826B01400068;
	Wed,  3 Dec 2025 11:14:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 11:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764778480;
	 x=1764864880; bh=CVPC4d71ujc77nfuxZ11P/5j9ed6AM5VHZ08jaYdK9c=; b=
	KW8pHs2t5v9pLnb01NmTszo9qHOKNTXfnuRBYCFgU78x5/lnMsDrwT+t7ZkagsTb
	SSz1aigHmpABL+1LYlNAzNThOKn+HtHG67v5H9JTxwtDeduLeBP1CNr9C8Iq8oln
	yhEJAka1C4RLKE9diaP7lv8lwdliTm+3hz3xxbWY7QErNuQTn6Igm89gKUHl9/64
	l282iluf7E9uDkvkqZ1y8m7ugxkyn1XXf6D7MqZ7jPrtNgPcQJdaWvZM8d6MiqUJ
	MAg1g/FTownfcNsAQqNadTCMQXnNVkRO+TdRjAUYTRpguOvF3SY0AxcRmIZ2akdz
	Av/Qu0LOUhWzTm2C9iUldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764778480; x=
	1764864880; bh=CVPC4d71ujc77nfuxZ11P/5j9ed6AM5VHZ08jaYdK9c=; b=w
	uQchyTupkJqO1kGiBaV7N3nWELnpaHy67eSVVXtQphFlZ3bTujawKhgmNOkQc6zv
	Z9qnObtPgxzpouwrQleb3ZFA2IIa0X0NkrgaqPYWcdR1GyF2J6102fdbNLdg9kBL
	OV9lNDr0rsAvhWViZvD1l69Mzbt6lgK4hRjcX2HAUi9WN/yNlb7IsgrMLhU4Bcp5
	erE46g6MToJo0m3M53jIIjU5tk1ZFWze2sbiFDLlVIu1S4v2hbTN2mpTmXxUxQ+s
	E2FDAc6+UcNhXAsxopstjikxFvCr3kgqpFBMjhjnMRHxiYMLlUM7jK+pKFfat8Xi
	mMNCwq8JmgsjqJkX/YhJg==
X-ME-Sender: <xms:8GEwaX2kdRXLRWly0RD1fHEYFAUvDCfjwN1SPLhqbCWfnC7MGIzMlQY>
    <xme:8GEwaQ4rqrl-n28bGMnQq3kruIBHx-oZeyrp1jpTeaIJtEBP2mh5Aw5mhglD1Q7hv
    kCsHoGZGbuhSelX4SFfpP7Xn4sTU39qBxZyIlp9Guj4ht45g7cqKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfefgfff
    vdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghfrg
    hnrhhivggthhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhs
    rdgtrgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8GEwade2hGXDh6jfDq09A7oMq5UXHfVTApirqHpXxfF0tPUc0Tj8lQ>
    <xmx:8GEwaZARG0-4IkOlFlPxETbejQ8Xt66k0Fp42PiS1dR2gvaWk6uiRQ>
    <xmx:8GEwaQ8QT75uR8mqO9Ls_cE6uRLfO5yKBtEpb9hc9Owtz1c8qAP_sg>
    <xmx:8GEwaUKegS4TnRcU0e_d4x76M30540-0UNv8bg0N7yxwrk7X3q6xkQ>
    <xmx:8GEwaa2sI0v-nIbNSGbEkBsE07uDJiRq8VTJSKj8EVYIAMOOcp7mNkbn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 587461EA0066; Wed,  3 Dec 2025 11:14:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtmV10PLKsYV
Date: Wed, 03 Dec 2025 17:14:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Julia Evans" <julia@jvns.ca>, "Stefan Rieche" <stefanrieche@gmail.com>
Message-Id: <f4bdb657-6217-4ddd-aefa-10263e1af05d@app.fastmail.com>
In-Reply-To: <pull.2015.git.1764776095597.gitgitgadget@gmail.com>
References: <pull.2015.git.1764776095597.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: git-pull: fix 'git --rebase abort' typo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025, at 16:34, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> `git --rebase abort` should be `git rebase --abort`.
> (typo introduced in e9d221b0b)
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>[snip]

There=E2=80=99s a patch for this: https://lore.kernel.org/git/pull.2111.=
v3.git.git.1764719353631.gitgitgadget@gmail.com/#t

> `git --rebase abort` should be `git rebase --abort`.
> (typo introduced in e9d221b0b)

Commits are usually referenced using

    git show -s --pretty=3Dreference <commit>

From `Documentation/SubmittingPatches`.
