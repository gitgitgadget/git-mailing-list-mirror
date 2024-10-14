Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E664683
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939643; cv=none; b=SuiijSL59R2nR0MfPYDeFbmwtu8sQ0UqCFph+gVZupKOyUisDaAG+FV4zE5pTdRutkQwdtfvUvbFI7zUz76dM+7Lj9xs6Gy93Q3h5cfyeO8aYwmqa6PSZrA+wmFnZ2CpMffx/hWtf/Sn9NWrf62hhyBLdJeP4itBnlu0FQGK0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939643; c=relaxed/simple;
	bh=0rBz+WCGt21dA4kO2Fu0nZo/LLB3AfKwMsniJwuuCQw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OZVKKy1+zdphQ8qctShNdR6GffyAo6UMLxqt8A9NATf7crUVpB6xBioIM+fvlqMTUUZrjjRpro61OdviiVnqldYenoedT8MjXyS7OlVdLbH2rpV9jnlx5gExv2fCYJHdFCXOWED5Y+oDysiPhV0+kTxiip4PpHVxyAHbtanrTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ShXnzLT8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5sa4HDH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ShXnzLT8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5sa4HDH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A36CA1380295;
	Mon, 14 Oct 2024 17:00:40 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 14 Oct 2024 17:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728939640; x=1729026040; bh=dK6g++5G6p9f0mntRbPGMV77aGEoF2Ne
	V0Rkr2xT+ko=; b=ShXnzLT8Dm9RQCwIM8nhw2/W96EOp0+XH2XVHxQ6CNdHbvDe
	W+aojtHLEPSkdBCjIw4i46gZWQTcNkA6nV29WOOGv2oWqtP+grpsY6MNh+rIAGOB
	BX3rkZkJTqyd2jYPxiInBIWhWgXO/mpl07ffQb+knvbSkcyli/0f7qiUrhEP/Hy9
	IQLBG7KHR7YFFjLSgswmlRAtbSiiOZ9oaWlxXYQquwqMu97o/inl30qxyCct6p+k
	kf3f5Zy27n2REW0fPeIXUvyqb37k0orQ5pfX0yXFurT0JbbjCP42UIkBg69Mxy6F
	bJ0LHkm3zDWyjzmRzQX/7U+q7qb7Zw4IfnvTUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728939640; x=
	1729026040; bh=dK6g++5G6p9f0mntRbPGMV77aGEoF2NeV0Rkr2xT+ko=; b=h
	5sa4HDHpg5LugXX6fGhDYSEAHvKEuTKJb9yiZDIPN4Hber92d4yTEfuomZz1pdVV
	QgyDH1qdq/11Z+UoHPHIfKLn8SJNI/bVtcqnZXJgd/JdEKOeNspGqLi1My4P4Fc6
	WrJQcQIoscN6vCdTKdg9Z2gVM1WLfrGHaXOniJFHfWaRPQ2K+TOXuO0pV/9uXiKY
	eGupc6nHeAehljQjN+5k6mGcNaOQf5JrrTdw72SeWU3ufHfqHEXZXsH+e7wZGiid
	cLFgY15XkMluVJ2QSghLcz0C1sT5bTKRKA5ss0O/v6xQHDMqqk5h1JxBi5zfRFW6
	Gw1DAbji8SDUpPMJDUImQ==
X-ME-Sender: <xms:d4YNZ9ef3QxlUbp-6UObLi2X40o1K-Yp8RzKcoc7lCWDWuWzUN3xeCA>
    <xme:d4YNZ7NUIqzTPwYVLMkBDpTriixKtUeCTApNH7bsIj1Wt9iKwwiqmZZ3IaOeDsWF4
    aoc1MlgC1CSM6s_SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghoug
    gvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpefggfeuteek
    jedutefffedtgfetveelledtheffhfegueduieeuhfekheffueefhfenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtph
    htthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegrsghhihhjvggvthdtge
    dtgedtfeesghhmrghilhdrtghomhdprhgtphhtthhopegrsghhihhjvggvthhsihhnghhh
    rdhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:d4YNZ2g6G2mAvQMOjIFYqf_a4e6D5fj1qfnnaQBmLNHA7WeBf6KzQg>
    <xmx:d4YNZ2-61IOYDZidwpx3Q8MQnMq24tCP40ezmGmYBzRrif3jI3PoJQ>
    <xmx:d4YNZ5vfqp1XawUXOi92nDpdVNvn4nwuF1KaZbEpCWJ086aIzoxy8A>
    <xmx:d4YNZ1ETcbSsqMxSZeVd8Qp5X83KpOBydoIJ3ocksbGJOF_5_CGDWA>
    <xmx:eIYNZzIdbZy1iUP-Ot7DawEeAqw_I3UagC4C3q0o5j74nQMvMTxiOqdV>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BB4B8780068; Mon, 14 Oct 2024 17:00:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Oct 2024 23:00:19 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Abhijeetsingh Meena" <abhijeetsingh.github@gmail.com>,
 "Abhijeetsingh Meena" <abhijeet040403@gmail.com>
Message-Id: <a4261533-33b3-49f6-861b-3571c2666c81@app.fastmail.com>
In-Reply-To: <98261da2-c8a6-4ae2-b62d-323093f94bfb@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <4f835282-d921-4cd3-9680-d8522bef7b39@app.fastmail.com>
 <98261da2-c8a6-4ae2-b62d-323093f94bfb@gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024, at 17:25, Phillip Wood wrote:
> Hi Kristoffer
>> [=E2=80=A6]
>
> See https://lore.kernel.org/git/xmqqr1f5hszw.fsf@gitster.g/ for some
> discussion about this
>
> Best Wishes
>
> Phillip

Thanks!  That was an interesting read.  And an interesting idea.

And then today we got this:

https://lore.kernel.org/git/xmqq5ywehb69.fsf@gitster.g/T/#mce170a493a7b3=
24c585124a9124356a0f87c77a6

--=20
Kristoffer

