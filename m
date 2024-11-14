Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997F20E3
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731558283; cv=none; b=hgrLV5OdjKzBDDw2b6S+V44sjE/0ypgIoYNEQL33S0hIfzqQelEQjHRn3iHALJ1hYxs2Tg0lJ96w/kg13Q6YFX5CtggHzPN/qA8F6SsQenyfuxBx5clu7wvLDb1ttrKBjaqFlK5wDZJolKW1UbvlbZL3JOhFMCj1m0W9EtD5ybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731558283; c=relaxed/simple;
	bh=C0Fyxxaugae4S34SAWloW0RhWNRAh/7vtYVDMX8qpnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prhNDCykapWQ2/l4Td1qrZ4RMAgVF+p4xLmUOKreubG5dpSGgRuEGIu8rLt8hxy1Zt53w+jeP0xAfu6owbDdd2p16O6H7aQNmMMjJN0TxHOl9DVdiCOdtCh54opi/M++M7AULO9K6UChme9jxXR35/OJZ4yK2o+Sl9BOz43+0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJ64o1pd; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJ64o1pd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D1F9B1380391;
	Wed, 13 Nov 2024 23:24:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 23:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731558279; x=1731644679; bh=Wj66VjJ67XhqOoSZ9Q9FKV53sgZEA6W4ZS1
	NTtoXvbk=; b=NJ64o1pdOeaiYbrg0aXyvZrKX/nRejXDQIs15z+xVyj6EQ5c8BO
	InosiLoCkJnH0T9aSCF9LHXPPuHdIu303pqOyLQEMfppwXLb878YJI3GRh1LQrfL
	uPFgE6Lzn9yMFae9b4o+6QCUTwmfvjjqjLqzpmoguTdo45fO1kA+1RUC4tfiEsJU
	eCb7sZBZmJxKfGiJFMF5+s0+lUu5RS6Bod/uJoUGRsueHGPzRflCkffU5wZNcJOO
	99f/fiIBaIR2/KwFypqto1D1V8vf/ipZ1nRVlb5BVBODl1+TzbLUwqdlf486KBiM
	hoNiWSgAsci5DTpuqvem1HLxnjvXUIEYv7g==
X-ME-Sender: <xms:h3s1Z91uLc4jbFzHJyU82STo9uB3n36GmLO_8MqjkSGoODibE6Lh9g>
    <xme:h3s1Z0HepLyBHxnW9GJXYKerYbwvaTQ319HdrY5mJsvlqs_7KPqTMOXPzxO4WfO0u
    jCgbW9Z-voEhmbieA>
X-ME-Received: <xmr:h3s1Z95fLas7fRMYlfDloY3WcjiafIkyFgqTrIJYxKpjmaTUvbxerdI3z6KzidMejPUYmPyWzp8jabclyVqVQbckbGBN54D-FXJD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehr
    rghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:h3s1Z62x_s9MSXi-FOAitUdWdo1qQzAnn4OWtuEeOz7nMJStg-1hVA>
    <xmx:h3s1ZwHZ0nBMJW0RrnwPFk2Wjp9nCtpIAemXpnZJKs5yc5l23BWrdA>
    <xmx:h3s1Z7_nj-To-TwUXQiXjwLsgxzIPnRuwgMmGOWUTkD0CydDImJfcg>
    <xmx:h3s1Z9nXLFSA24CODCaqE1dEf3XASahttXKjyTAY05MuDMeqq3br9A>
    <xmx:h3s1Z4-tFZD7kIQ7YP1pBgylB_bXpFlDRvXLzpbt79eYnbqjuqY9PZFt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 23:24:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: David Aguilar <davvid@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Ramsay Jones <ramsay@ramsayjones.plus.com>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
In-Reply-To: <ZzSprTl5Z3uIx0_d@pks.im> (Patrick Steinhardt's message of "Wed,
	13 Nov 2024 14:29:17 +0100")
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
	<Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
	<ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
	<ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
	<ZzSprTl5Z3uIx0_d@pks.im>
Date: Thu, 14 Nov 2024 13:24:37 +0900
Message-ID: <xmqqo72i788q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> (2) There seems to be a difference in how symlinks and hardlinks are
>> handled in the install step.
>> 
>> Running "make prefix=$PWD/dist install" ends up with real files in
>> dist/bin/ (hardlinks) whereas with Meson all of the files in the bin/
>> directory are symlinks into ../libexec/.
>
> Yup, that's documented as part of the commit message that introduces
> Meson as one of the main differences.

Is there a way to disable that?  These symbolic-links pretending to
be installed files are quite annoying---when the target file is lost,
the links become useless.

