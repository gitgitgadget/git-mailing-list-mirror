Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508F1C5F39
	for <git@vger.kernel.org>; Tue, 27 May 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333722; cv=none; b=TgPwxMSunvHpFpgENEYoaqnX2rSeVrCcMYG1ravm1cBooH9jENunAO9ckD2fQzQJ6oNzt8gW8HtUA3GLdBzN9rcjIwhODyIb5fosLrq50S2KqYLdWNf7/OwCtpBx1ca3ERKrLgetx7wjcxFT/wmOen2VO+L4xx2eMoHxfoBsjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333722; c=relaxed/simple;
	bh=HSx7C0GhNMjPjRdehgkad6MkGtAApYph/SypmcQf//E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRwm8yxGlzM31/PcAS9c2eafVdS1xgWFLWf9buIuyEgHwuXGpkKmlkNoKgRYJ/OWfskUvTLyh3MxrhMw9oHBvnFffr4E4Cn4j5DqiLPnM8i9i+/cuq845Afkgefsy0IiOs2MJrTxtPfvPw6RjGCR80oNi1ispWHTqAUxQvv/z1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rpOdKar2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSgacRz4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rpOdKar2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSgacRz4"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB00825400FC;
	Tue, 27 May 2025 04:15:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 04:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748333719; x=1748420119; bh=WbkOmRef0Z
	e5Mn5HhghkPWMHygOzA2zaQ+U1lD2z88E=; b=rpOdKar2ZjRzWJYoVCr3Wbe7HD
	4FY6TI1fD53jtJvFfswrWoioZOjpg2ahrl7QsQFiJlzdtWcZBOm0Pw2aS0bsa7UM
	6UQdZGEZT8Z+AhYZVI16P75Ol5DUYBAemiji1JXvPIGNGVTJ/vveehoAql2eCBZH
	yJqHb3TbaO4PfTYqGFA4Lx5lYShVNAZoeBvZOxwfnCr0VezAfBJ12V+o0Rz8Xbu/
	uwzHP8X+M7Pe8RCduVMtwmEnpmJM+9MuYXh2jjJuIZYZx+jbbPy2DBZqbBJPcX7C
	oBDpykUv0mvvrb6rdMem9gqb5XzwuHlhKAqALr1ztdCGy7lQmg43u7macUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748333719; x=1748420119; bh=WbkOmRef0Ze5Mn5HhghkPWMHygOzA2zaQ+U
	1lD2z88E=; b=kSgacRz4ix+DlYD/o2diaIXfn/qjo6rSC3BV7x+L4z0EePLgTyU
	E1kvjMRyxjegYdVYjo+wxfqCcQRyimqmGimpMw1hjxNmoLpZZZ4M+xac2Zq2KEeU
	qUt+mM+TC1laLXPtTrDIGx6GefsoSJbxZQaAm6xxOoQfN7cb6QuuXKZGPIoL7NvN
	xEJtIyTPj1yx1oWHHukKib1Q1/vEht8ScF0wLHeQh/DAaiJh+W6rVA9xgBYus0Mq
	twIVYsTPZ5UrKbCGTgD196RQvClm1i8U5Dr/OpwPTpVq7NCkO0rzer4AqHsiN7eO
	XkIuEYXfmOKkzY57O6/NUQorRIafUbDQe3A==
X-ME-Sender: <xms:l3Q1aGeQi8lV4RP6ZN5wqPaZVisU25hC20lH8A5lUwsyPBZex3injA>
    <xme:l3Q1aAMiE-2EE13Ry_VTaKP26t1L5UlWAf1WzfbrErvDY4JfID_cm6gYltnOPICTR
    2mjDpi9airHLm5yag>
X-ME-Received: <xmr:l3Q1aHiF2A0UGpBRPNGLq3rkmFsUjmoctMlzmqwhLf4C8LSo12O3yHH0nU7_0XCw2nUQ9cqeZI1d8xKjzbZJ1aRmN1L4ukB6PDcS5yHZtmttsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleekjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelveehjefhuedtffel
    hffgfeeihfffhedutdeludefteduhffgieevveduvddtveenucffohhmrghinheptggtug
    hhihhmrdhpshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:l3Q1aD8QnsyTGPvobIL7oVNYZIGhnG3ee5oeoNOQ2F9NTXyZuz8eaA>
    <xmx:l3Q1aCtJPfoXlJTQNIuR1fWXIZtow0ptOGCSpnw7rO-5wGByCI5g_w>
    <xmx:l3Q1aKFlX9qVXiaP1y4bGY_bBDf59XE8xnt8rg6UujwA0wP1qgf_nQ>
    <xmx:l3Q1aBN99nCAsMEbJlnf4Tl0flObJqPgRaxHOEuT2wMyfBu5w56QVQ>
    <xmx:l3Q1aEfnB1zwqJh-M66ryOB059j5jXgY4bq61HqKglAzliXRU4ja0a8n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 04:15:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5689cb50 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 08:15:17 +0000 (UTC)
Date: Tue, 27 May 2025 10:15:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (May 2025, #07; Fri, 23)
Message-ID: <aDV0jwaQ2DlcM0lZ@pks.im>
References: <xmqqtt5au523.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt5au523.fsf@gitster.g>

On Fri, May 23, 2025 at 07:16:04PM -0700, Junio C Hamano wrote:
> * ps/midx-negative-packfile-cache (2025-05-20) 2 commits
>  - midx: stop repeatedly looking up nonexistent packfiles
>  - packfile: explain ordering of how we look up auxiliary pack files
> 
>  When a stale .midx file refers to .pack files that no longer exist,
>  we ended up checking for these non-existent files repeatedly, which
>  has been optimized by memoizing the non-existence.
> 
>  Will merge to 'next'?
>  source: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>

I wanted to send one more iteration of this where I hide the ugliness of
`(void *)(intptr_t)-1` behind a macro, as suggested. But I saw that
Taylor has built on top of these patches, so I don't want to make his
life harder. Cc'd him.

> * ps/object-store (2025-05-14) 18 commits
>  - odb: rename `read_object_with_reference()`
>  - odb: rename `pretend_object_file()`
>  - odb: rename `has_object()`
>  - odb: rename `repo_read_object_file()`
>  - odb: rename `oid_object_info()`
>  - odb: trivial refactorings to get rid of `the_repository`
>  - odb: get rid of `the_repository` when handling submodule alternates
>  - odb: get rid of `the_repository` when handling the primary alternate
>  - odb: get rid of `the_repository` in `for_each()` functions
>  - odb: get rid of `the_repository` when handling alternates
>  - odb: get rid of `the_repository` in `odb_mkstemp()`
>  - odb: get rid of `the_repository` in `assert_oid_type()`
>  - odb: get rid of `the_repository` in `find_odb()`
>  - odb: introduce parent pointers
>  - object-store: rename files to "odb.{c,h}"
>  - object-store: rename `object_directory` to `odb_alternate`
>  - object-store: rename `raw_object_store` to `object_database`
>  - Merge branch 'ps/object-store-cleanup' into ps/object-store
> 
>  Code clean-up around object access API.
> 
>  Comments?
>  source: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>

I think the only outstanding discussion is whether to name things
`odb_alternate` or `odb_source` [1]. In case others agree that
`odb_source` is a better name I'm happy to revise, but if not I'd rather
keep it as-is.

Other than that I think the patch series is in a good shape.

Thanks!

Patrick

[1]: <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
