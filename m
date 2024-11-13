Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE42C9A
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480480; cv=none; b=fA6VNr4uxJ1vVFjIQ1ZC/vKBB6wL8nzXONXeC1nhwtFCZPjaznoUyHZwXoxc5GqCnxn8vFp2sABTxlEarL/EQ4Mjb+vKv8HwgXr6FiHAz1PMhk2TPcaaxObz7T1f3Vl4chAUtKoWhgT2FW31anPm562nmNTkfaHEVjcpZQVuBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480480; c=relaxed/simple;
	bh=/uf8WFwBOl32BDWJEqxT1gTIajrKHxEkX7VuxFwcYV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXBLqSpDUqiNxhgoWK4qgooOvTpRJuUD3/FiA4D7GY8230tARLb3XKZ/BqFw5shxk4mxcBF5cGSZzd8Fv4cxXM2nbJa/81HTFn8Eh3Vrf9IzHKJCunz+WePTbe1tmXQ7PRz9w1+CA9275PKPWeXV6NvbCfSERDpNQORQlsMmMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFoisCYo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFoisCYo"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD1991140138;
	Wed, 13 Nov 2024 01:47:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 01:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731480477; x=1731566877; bh=miaxwBSFBYfAOLQ3k4KTFbU+3y08kD3vrRe
	g5y2QAgo=; b=JFoisCYov9JKfnn+JaQSY9oMdRMLm0Ud8VIdxNs/cpUd2QyUPaz
	VfSW7gbJ4b6l2cbR7zZfeQzWvobVru5tGbWCGUTrdF8Uj6M1qxuGN+nm5pmV+9QO
	teYua4rFeshWyYlatzUjt2Tz/Tad+X4CZotXQYGTuWNEsfNL5uTZ+6+k4MfaPfP8
	wjR7DjEYpSvrfMXadSK+I+oTotT5P9fUyJyk3UQ5yXwNyVO+pnvxpeg1N9cqJQBT
	TxPyy8Gjw6D1WRq3E+y3G7yL6dQuT/nnSoMe0yK/tigp3ZCnmnLYpC3b/O1zyKXi
	IYEaa3gbYJBBaolisDFvatsLOF9xOZrD0Iw==
X-ME-Sender: <xms:nEs0Z0gGoXJo5zEGMdSv3a21HVD7op0EvVOuRhJIJIZejZUV84zIjw>
    <xme:nEs0Z9B4ivygeSmGBSLyizFH_vqf-P97zLRpZnwAlT6ICkpdxiblyRGGuvD2BDQH_
    mozrOeytx45AZsd7A>
X-ME-Received: <xmr:nEs0Z8GooKYbR4hnXflJmiMA-8i_sM8Ec0Je1gqVxsEStYKnfVpSeWHqkHkN_i0zO9gFG-vKYZ7lb4yLclCsj4nXoe8gQW_OeGEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudekgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhi
    hjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:nEs0Z1Ss1H6Za-eVVscOVWnL8cks8oyeC4w3izhTpWZg86zWQYVbsA>
    <xmx:nEs0ZxycFAW23ECUNq3wku7bf8LiH2TrVe_KeR-2hzN5pOZOgoLghQ>
    <xmx:nEs0Zz48vmB1UWHcexhz6AmN50gc4tYlacy0_pwOC2DUh4i4nNem3A>
    <xmx:nEs0Z-zr5NpGMLhXh35hPIpnxIJ0OTOYNN722Qek2vYRHAk1KBYLBg>
    <xmx:nUs0Z2ptikCeYaUp77ebffzv-IJ80vYZKwtBJBcfqq4M2P8PqTw9LiTx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 01:47:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH RFC v6 18/19] Introduce support for the Meson build system
In-Reply-To: <20241112-pks-meson-v6-18-648b30996827@pks.im> (Patrick
	Steinhardt's message of "Tue, 12 Nov 2024 18:03:01 +0100")
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
	<20241112-pks-meson-v6-18-648b30996827@pks.im>
Date: Wed, 13 Nov 2024 15:47:55 +0900
Message-ID: <xmqqiksr1vfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +#      # Disable features based on Python
> +#      $ meson configure -Dpython=disabled
> +#
> +#      # Disable features based on Python
> +#      $ meson configure -Dpython=disabled

These are dups, right?

