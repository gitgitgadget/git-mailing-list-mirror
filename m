Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A843148FED
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566474; cv=none; b=MlghF+3tp5qWjRI+6PHfVkuCZUgbfI+v+gWXerzt/RPJPTB/qF54F9zpCEX3d/EJBgJvCKSDw8HvlpC6ucTPiWkZHzicaMZuPFwW+0DvqQGcW9C42+0VozYKbGF6fQGBo7Ml/pog8579WsrNanyXDAq4B+HcAPDH0D6oP/EIlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566474; c=relaxed/simple;
	bh=eK4F6EPCS9LCPl1lZ9VHPT5lVQ8qWeJYEETkTCHiTb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDWUZ8Rvd+x9FXjRfyHG6Tm+ykQM9ger9STCkMVKTjpSqulOw8jRBhlJOQ50sY9NnYjbITaY94kdoKS+rPU6C+XvfsXoahtMSJ+BTlTbr9cwbWRvUHP9dQpudoJw/u9BlpaHlQ6b/Y0PEyCCgMzjtZP6n/8XVmZ4OBc4sWiHoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9VuvYEJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9VuvYEJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B381114019F;
	Thu, 14 Nov 2024 01:41:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 14 Nov 2024 01:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731566471; x=1731652871; bh=eK4F6EPCS9LCPl1lZ9VHPT5lVQ8qWeJYEET
	kTCHiTb4=; b=U9VuvYEJbqAb5sqJLic0oSgDO5qPYMslKiAnDjceAE992jHpkPc
	ChaGuC3VKo1/sEb2Os6jFFVvDxAJJ4E002IUscimrO8+vnwjXtLEukobJuGgBPLG
	8aipONp44GViuhZ6KMPx3c+mDsXnJuKamHsXkX4DaW5VCBJ7V9Ymz+rVE3cpMmkw
	M2P4MfsFuoM1l+Th90NH1XSwKtqD+SM0uYc1/0ORcNe4EnJg++OVLj2cAMrYNWQh
	BtGjz35KMIqqvPogCpD71SqIFGHbDLW0SC1k6zFWAreNWaPFfxvuqrtE/Bgwm5Cm
	Te3PYL7HbKj4U23pox/DE22Gw7Inj5NhHcw==
X-ME-Sender: <xms:hps1Zxm--69QiZOUd_2FHP0zv-iQsKkgurqi_LPVwNyUVYC3xYHCOw>
    <xme:hps1Z82C_E_KTv8zn36Jk3dVLxMHTSLK0E4hWw_KKwCIiN95OJE6-0VIhH0SsakS7
    tKuuYEHan1pA822Ig>
X-ME-Received: <xmr:hps1Z3o3ZD4gyYDNbK9JwY0oPw46wXop4-rnqdTTi9BGgQqvGZFNP4KRICBryey3V4GBP6kx-zw1_PgfvLj0CubyDjq_BppgIT4K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjohhnrghthhgrnh
    htrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hps1Zxmn3s-ZkLxzi_p_dZ03cYPDv9AeoUvLFNXqEYnmU7-P37rgkg>
    <xmx:hps1Z_1fPYHcE_JIa2iCaQYt3r_OdysN18YnGtBtEC41NLMzuqgqWw>
    <xmx:hps1ZwvJgY9CEVD1D4054cuZdgBBrxRh4jR8m8YHeNix_U1zamePiw>
    <xmx:hps1ZzUNpAfk7w3gbJWX3deMky08-xQBEnqpbZP6IUVngfWb3p6tcA>
    <xmx:h5s1Z0lacF_ROdujGxUb6S-8ksFKtCJhT5Hzkki65a4WVPAtLut2apw_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 01:41:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jonathan Tan <jonathantanmy@google.com>,  git@vger.kernel.org,
  steadmon@google.com,  hanyang.tony@bytedance.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
In-Reply-To: <20241114005652.GC1140565@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 13 Nov 2024 19:56:52 -0500")
References: <20241113073500.GA587228@coredump.intra.peff.net>
	<20241113182656.2135341-1-jonathantanmy@google.com>
	<20241114005652.GC1140565@coredump.intra.peff.net>
Date: Thu, 14 Nov 2024 15:41:08 +0900
Message-ID: <xmqqiksq71x7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> As far as I know, index-pack, when run as part of fetch, indexes a pack
>> that's not in the repository's object store; it indexes a packfile in a
>> temp directory. (So I don't think this is a strange thing to do.)
>
> When fetching (or receiving a push), we use "index-pack --stdin" and do
> write the resulting pack into the repository (and the command will
> complain if there is no repository).
> ...
>> We definitely should prevent the segfault, but I think that's better
>> done by making --promisor only work if we run index-pack from within a
>> repo. I don't think we can restrict the repacking to run only if we're
>> indexing a pack within the repo, because in our fetch case, we're
>> indexing a new pack - not one within the repo.
>
> I think the "--stdin" thing above neatly solves this.
> ...
> Yeah, I guess the fundamental thing here is that anybody who isn't
> passing "--promisor" is not going to be affected, so that at least
> limits the opportunity for surprise.
>
> The quarantine discussion above is an example of how there could be
> unexpected consequences. I _think_ it's OK based on what I wrote, but
> hopefully that explains my general feeling of surprise. I dunno. It
> still may be the least bad thing.

Tying this extra processing to the use of "--stdin" is not exactly
intuitive, in that a "--stdin" user is not necessarily doing a fetch
(even though a fetch may always use "--stdin"), but I guess it is a
good enough approximation (and the best one easily available to us)
if we want to safeguard the use of this "--promisor" logic only to
fetch client.

As to future potential mis-interaction between quarantined fetch and
the effect of this "repack local objects that can be reached by
objects in a promisor pack" feature, I do not offhand think of a
good way to future-proof it with tests.

Thanks for the discussion, both of you.


