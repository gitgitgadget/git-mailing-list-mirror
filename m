Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD38C07
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671558; cv=none; b=j0H/Wq61y28Q6algBwjeIG+dWGwbz6QPBgjRprM5f+sovc8vYkfV0mAQGhtIFpYaqsjoHh8V4e4zEcoZ2gSjCc2CfrmZcO5TfDnYTGn1R63rFcYO6MGOVmCAzMTq0iVaa72zeZY9byonfZSH53898k46XCRdvqTe271xfsecCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671558; c=relaxed/simple;
	bh=C7cjIab4OcgwkYrH9rvOSA9fTc0txvxcs2AkB797uGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HvjfGZzk3/KQgYevtonvwpwTHAaffz+cPQnUwW8+DJ+QVcY1Kk2icH+SYNQRPLzCmH5/z+EWXasWZRj9F7Ri6Y7c6W4Yin71QIsh9sxnDcIefikBuH1L1ecmA8CjUyzcmuMLNAeSwT8sc3ZSLk+CqklGUYaClb8v8sU6Si+hMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yClEMSUM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yClEMSUM"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2917C11400CF;
	Tue, 26 Nov 2024 20:39:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 26 Nov 2024 20:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732671555; x=1732757955; bh=csI+jL0Sx0Rj9YuyMEGUv6Wvu8OZ+Oz5Utv
	eq0kSFMA=; b=yClEMSUM9b67qoee1CvWHHeggdOMuUfIWes8XsMYp1ncuRuh8Jy
	DnsCkAyd4F6YLrrAdM5L3to6RFQwUNmi9vkvunxnzDRUn+jS+pe161G2PSa+ixh2
	vMB29QpX8ktLdv0O3nQbIOwSsjbXT9gcN6AQWWwPnOE+JUYgVbQYx7BFb9nh2xUg
	+NiK0T78lUpGmP6MBkfWLg9Bka3Z16o26LBFQf6NE+LUGWpHLQgTimU1+ajJzJxK
	ekAsi7nZl5ZAIvmV68mkXbRX5fo7VQBKcT7uDIuLqeOxOV749RaIquO17pcB42sc
	6TAS6ZC/pVVfI4BjUpNuZ4YVRiZr4rE92CQ==
X-ME-Sender: <xms:Q3hGZ3hep7oF3vU_CeD8iwoXA8mQZPOufCtt98zgbT43ESAAhMaNsQ>
    <xme:Q3hGZ0AluUapFt7rTdbzeWvklWRsMGlGZfOWOk1d1P3gQAF-BekdV9Zd0jAPz3TVe
    rQid7lM3eBjvbXiug>
X-ME-Received: <xmr:Q3hGZ3G0rELeGdZNWDnBm8POP9m5fuFHwN-B_e9bpPwaJ7C0kT-heuEBy4Gj0AD1ukzIZj5F4z9s6WrfYjJSEAacFDvGnMzXnM_kIJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Q3hGZ0TGtSjOc86bFeUT78iTTWOrdItv8Hlz0z30C8eqtuHy2hTazQ>
    <xmx:Q3hGZ0xHeqC2K1gGYIviQhhTBrfm2Gfdr_2RsFG77ga-AUDDKn2Q_g>
    <xmx:Q3hGZ64_FVPoDXfNH5TasCY8AgremD-SxZd2yFT7B-Eihnzf2E7OJg>
    <xmx:Q3hGZ5wCSIKB-r8D4oLS6EjpWc2bMAa1SR_mLzMqWFeertzOszLDqA>
    <xmx:Q3hGZw-tGBQLah2kHL-L1PjbQS0f9EJOiwJ-c9KTyZa5sLzmkJJOLfaS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 20:39:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] transport: propagate fsck configuration during
 bundle fetch
In-Reply-To: <20241127005707.319881-5-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 26 Nov 2024 18:57:07 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241127005707.319881-1-jltobler@gmail.com>
	<20241127005707.319881-5-jltobler@gmail.com>
Date: Wed, 27 Nov 2024 10:39:13 +0900
Message-ID: <xmqqzfllv4ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +static int fetch_fsck_config_cb(const char *var, const char *value,
> +				const struct config_context *ctx UNUSED, void *cb)
> +{
> +	struct strbuf *msg_types = cb;
> +	int ret;
> +
> +	ret = fetch_pack_fsck_config(var, value, msg_types);
> +	if (ret < 0)
> +		return 0;
> +
> +	return ret;
> +}

Looks good.  Both callers of fetch_pack_fsck_config() must deal with
the unusual -1 return from it that signals "I didn't find what I
care", and the original caller does so by calling the default callback
while this one just says "everything is well".

I wasn't carefully looking for typoes and style violations, but the
logic flow in all these four patches looked perfect in this round.

Thanks for a pleasant read.  Will queue.
