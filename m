Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BD23098F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732245803; cv=none; b=o6TgfQQeARJ4Q7NS0wGS1JTJbeO6m5zeCbMPF/Df2ymbc4nyB1enhI/ooQLCS8/utfMNbzWd/Hfk3VLHWsVFjBZFGL6lJ2E7YxDhlTHpUXZO5eIwE63NKqK7vpH4baMgu2Dd5cjTggWq2TsERqvJBoJJeqLzIfcwqRfKOsn36fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732245803; c=relaxed/simple;
	bh=YEZlh7QVAM8iWiZsLLqdLSc0o8reAGsuVqmpLeJVLRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcEKa7uk8NOHWW8OGGhd2i+X3HkgVMG6rS7v5hst2RWzyxuR3iTQtgzzCMfndTKI7Ou65VzjF4mLKoWBVDLtXDM0XE9a9vCFjoo3+CtcyDXn8j3W1JnR4OEZ6yFudQMdHiveVm8wzXTEcUpxDDCQBEwpszFiFQFd7zS+sjonL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1+PR+dKB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1+PR+dKB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 911131140126;
	Thu, 21 Nov 2024 22:23:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 21 Nov 2024 22:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732245798; x=1732332198; bh=CIOf97xGhC1e6TcKEYT0uHejXJrBx9XbaEi
	iokE2F48=; b=1+PR+dKBU5WxDzu6O0GUgSvHhyZjBB8ze8dNzIyeuOQpcIkp9Uw
	p5OrHtsDmm/9pavs6WtKVTUmnX7PTsCdGQxnSsoJO13N6KsKCXVCl4Y+U/lLyk2u
	FVxtow0iMiQY8pnq79M0P2yb/Nzdn3oTIZtxXWT7JAM6pqmbz3xODufxYzr2hSbb
	QMqgh4kQgtkaJCfp0weTLIplRQ7IEiaruV42RMGrh/nanhN+GnvkitDdVueX48Ih
	Vhj6ONnf0KH0Uq4gAqmcd6ijVUKz7VcUEYBh82ISuMfZOXcYXrvSlUSRpijU6BmA
	JQ3vnRIJMLZtiElkUNC7ezSw4pt/kkTriOA==
X-ME-Sender: <xms:Jvk_ZzlIXgKjJwWk4xdYSm4LHUHQO3tea6YJaJGtF-VIWZXdIsC0GA>
    <xme:Jvk_Z20SigFbhgG0Z5cXVHR7NP4E7sumfLVISOl3gvKNIlXB8177YMB7oaVTvs2W1
    MdTcqD8OS7g50Msww>
X-ME-Received: <xmr:Jvk_Z5oeNC5G-OLctpxB-PRtMBmoDRKjH7h8e6yMSib18WpmsmNRS3NGkS5od7_fFyRSwy6srVpaUNVsI3OxSIBKaEPKdmYHtiN5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:Jvk_Z7nPiobtSmmCP0uXgMF4EhoxFpQ1ReZIin_HI6xi8b2M2NBamQ>
    <xmx:Jvk_Zx1siigZjNq1UpItD95mEnTLWzy30tqsuuUyEIWmMM8vROZbzw>
    <xmx:Jvk_Z6uytPGKN364K36V1KyBCICj3SllIZM11RqwqPre8xddUZXG_A>
    <xmx:Jvk_Z1VGt7RLLTPVElmDyP45K20naICxR6vTuYYToMVmwUCOYUsKzg>
    <xmx:Jvk_ZyvGWBx4-7fl8ZiW2qmsROx3G8BiRHFV-hRW4qTHtSnsptdo4Tz3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 22:23:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
In-Reply-To: <20241122011308.2743517-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Thu, 21 Nov 2024 17:13:08 -0800")
References: <20241122011308.2743517-1-jonathantanmy@google.com>
Date: Fri, 22 Nov 2024 12:23:16 +0900
Message-ID: <xmqqcyioar4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> ... During the subsequent connectivity
> check, the "make the tree big\n" blob (referenced by treeB) is missing.
> There is nothing that can vouch for it (the client does not have treeA,
> remember) so the client does not consider it a promisor object, and thus
> the connectivity check fails.

It is sad that it is a (probably unfixable) flaw in the "promisor
object" concept that the "promisor object"-ness of blobA depends on
the lazy-fetch status of treeA.  This is not merely a test failure,
but it would cause blobA pruned if such a lazy fetch happens in the
wild and then "git gc" triggers, no?  It may not manifest as a
repository corruption, since we would lazily fetch it again if the
user requests to fully fetch what commitA and treeA need, but it
does feel somewhat suboptimal.

Thanks for a detailed explanation on what is going on.
