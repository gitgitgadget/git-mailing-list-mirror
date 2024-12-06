Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7A1E22F8
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484645; cv=none; b=L0IXL75Hj1h1E+rYZQulZQJsLD9ejYJb2y8W9Gnd+fVOiultrzrtVMuLi6kzCg32JwcSvLJPrikeWyBQoubxlCyuez4/aSacN8xvEjnmGaK6VHXWfvtG/vOoYrtK9ndIUODN6WcMXnXJXEvS1r4tfSWmHVUn34661msHBQ3yUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484645; c=relaxed/simple;
	bh=SrgyXsWKq3T+m6PqWlvC2CfayYFxfKeMF6FCHjqiKeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iVgfpRt3fVwwVjT67WF4YlnHIJC3tOammvV2yA/ot64YXqp9tfAROz4uoVF6WWDD7Wx6yn9Gz2Eo0itZEd0b4A7OirgHINBBXQ/loBoEMlEggFdTFpHA8yqxLp3sy7j1koF8+nuKHFOvNT1tW7o8cWlppOuIZgSsV30aKU454rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJ6PuE8G; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJ6PuE8G"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 72E731140195;
	Fri,  6 Dec 2024 06:30:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 06:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733484642; x=1733571042; bh=f6eJ6XawmHeuyUYoQ2gmIfO2ScANdB0v7Ge
	xxErjErI=; b=nJ6PuE8GMcloqvhnrNa1YkWiHE6i1QMsQqEikcu5PcQDAtTEX8i
	NIvyYnSBe8hEZMRQz3Lq+OmTTZ8HtlEamMB65BqQGr976RnpgtXBtRC9ludMI4bo
	ukb47eLXhkEwpgo7aL1ryettTz9S1S/GjeHB78ahGG77VL3msW3eCAc/ujkex+wK
	RUuZexxsvMtc65p1VfurjpRdbsNIAn/9zTdywG7XqQwkzWaha5Zvua3t5oDa+Cep
	F+A689LceLpLN7uRB/rD3aTC3LSuPqHQePHB0qIv4WUUA2TipIEYKafdTuPYPUQT
	up9mHh1KOgZL6l5bjHkkAUTKBN0h/4VElyg==
X-ME-Sender: <xms:YeBSZ8PcmYrUETcMuM5zQ__uCeY6ktBqg-V09tavLI38lP521PfbJw>
    <xme:YeBSZy9NlCXWwKcIb6oo_0QSAXSDdZEhmK1p91kfAR2vXT4iWbVsJ4eZYx09N4Vxs
    TO7zedTU24Of8qU4A>
X-ME-Received: <xmr:YeBSZzRvMR5c_Jh6vDoa350ubFrCqjpsHyvSg0yGBqB1a0q9FDxM-yY7eXQPH_QWgUX4LnNpAX4Q0KBnpah-pWWeQx4cqWBnalqkDbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:YeBSZ0t9yCX9ljiqFkB3mDQmq0XjdMExI-AnxNsBBRSaKOsoe28kQw>
    <xmx:YeBSZ0d_Vv5KTSawZkdSjXwTDDQt995qgq8PPQlkSs93pa0lLUQtdQ>
    <xmx:YeBSZ42XiGnv6WXB52WBVmF9OupJOXU64kltKwurPX-w2iEXDVuCtg>
    <xmx:YeBSZ4_G6hX8vGlEEPZhdmzAx-nPylB6jH9DFaspE8ee6fH8YqJQxg>
    <xmx:YuBSZ42nV6c2LQs4KA0SrXTjk3w-tKgzz7F229UyD02Bejc8BbcGlhV6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 06:30:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  bence@ferdinandy.com,  phillip.wood@dunelm.org.uk,
  l.s.r@web.de,  Johannes.Schindelin@gmx.de,  karthik.188@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  jonathantanmy@google.com
Subject: Re: Re* [PATCH] Fix `git fetch --tags` in repo with no configured
 remote
In-Reply-To: <xmqqcyi5xmhr.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Dec 2024 17:08:00 +0900")
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
	<b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
	<xmqqcyi5zdzb.fsf@gitster.g> <xmqqcyi5xmhr.fsf@gitster.g>
Date: Fri, 06 Dec 2024 20:30:39 +0900
Message-ID: <xmqqo71pvyjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> +static int uses_remote_tracking(struct transport *transport, struct refspec *rs)
> +{
> +	if (!remote_is_configured(transport->remote, 0))
> +		return 0;
> +
> +	if (!rs->nr)
> +		rs = &transport->remote->fetch;
> +
> +	for (int i = 0; i < rs->nr; i++)
> +		if (rs->items[i].dst)
> +			return 1;
> +
> +	return 0;
> +}

For the purpose of adjusting refs/remotes/<name>/HEAD, which is
expected to point at something that we copy from their refs/heads/,
it may be tempting to tighten the above logic to say, instead of "we
have a refspec item that stores to somewhere", do something like

	for (int i = 0; i < rs->nr; i++) {
		struct refspec_item *item = &rs->items[i];

		if (item->dst &&
		    item->src && starts_with(item->src, "refs/heads/"))
			return 1;
	}

to make sure that we are tracking their branch refs, not some random
hierarchy for which refs/remotes/<name>/HEAD does not matter.

I will leave the simplest "just check we have .dst" version (in
other words, without any additional check on the .src side) in my
tree, but if anybody wants to pursue "let's make sure that .src
copies from somewhere in refs/heads/", please make sure that you
consider "--mirror", where an equivalent of "refs/*:refs/*" is used
as the refspec, i.e. there is a case where .src does not begin with
"refs/heads/" but does cover the hierarchy and wants to learn about
"HEAD".

Thanks.



