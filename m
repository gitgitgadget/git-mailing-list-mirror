Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1D2DA769
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533504; cv=none; b=kDXUM+oIM8aKdUt98vQHCiOAzaQjfcTDpwft1Mlr4qXipxzbMooLkZPg9TvC11l9SmF7atU+e4+62uUH+3bKeU9rIuFd//+bDgMLRuYoC2i7q8Tsbeeo/+SQ1U6pIMz4ViaCYQlaHFYEk89ZQOEwMlz0Z/jmiZFszV8XEgMFPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533504; c=relaxed/simple;
	bh=8AIyIN1cE9uYF6lZRIk4nOqLb1rEHcs6z6ZwH4vhATI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6YUltWr38obVHor/unaoCfNTg0fiIDHnq+w9YVDmi561TyIx8RSS5xK7UdkehKbbAQjOisCW+KxW2IZ/S4QsMs1gXVjt7jIkFQfGO5O9kPzMyBw8Jh9GBsB2Gxa7ETNhndyyCk8Sq9ZgdqpF1c/Y1P5ptBOnuHpsjGdba4o9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H6djnILQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoBa3omM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H6djnILQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoBa3omM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B3D71D00213;
	Thu, 26 Mar 2026 09:58:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Mar 2026 09:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774533502; x=1774619902; bh=8/oWj6abTq
	ULKWQroj4U70Fie9M0KFzNtM+i1wUnu5o=; b=H6djnILQwMn6W3tntLDmosZmP7
	DNpVnzLOj6MnvRo9aSWFTcyp08nk8+XBIKCvUXCFlkPQOjjkugHGiZJ4QjkDZXjn
	K4srEvtVEq9J3gpYXsBAxpi8FNuTBAclOX9RdclrHaTyP3UNv7JJAON3YX0Fcdx7
	4cloPLdUQqU+RoPNQMUaGXILdUWjmqLPTTnA2E4lYfYPWfeBxo4T5ZZoy2i3KIRI
	1zZs4WFlUtl6+j7y2KsweaN+vDsw3dp7u5iuvIUhj255tFyBz4W106P+h2tYAnY1
	oy8gf57/HPhLBbNEhuYbAgDZZK75x8FnDOITVpusfUMdqD3kJvT1bAGrv+IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774533502; x=1774619902; bh=8/oWj6abTqULKWQroj4U70Fie9M0KFzNtM+
	i1wUnu5o=; b=BoBa3omMvq8BCxnJBTIKTBFRsdEgbpXTeNcFNrIozE8xOLPac/r
	mxjUMmtGcWUw2tVrf4kIvccIADb/sFTQm6LoQIanZvN3vrh3NDHds61csd8vm+bD
	s6wZ7gN99yA0B0P1EpYU53lkhrXpFFAX32XX7+dBTyJiMVXHxrDk1W3XvWDgQ/XH
	ybouVrHL0Nw9C+EbqmKW+YdUoKaASc7UOZu8t15PGISdqPhWj9qin++P7OMu+jnC
	1y6oEBbbguvGiU6hYwIz6afHlAS1rmFS8PVkFc8KhRCMLjw3q4TU35EX/erwKxNk
	+PXGYYeFhMgUyTKkmd3maImsiiLrWVmAusQ==
X-ME-Sender: <xms:fTvFaXOv3VpEWOndzFWGjPwwHRqLnoTWY5tjcYshAAEtrspy6qJiWg>
    <xme:fTvFaZb92gWo5NaCamng5if8nIM1Z5DX4iQniguJsRwD_JJ4JNZO82GLX1V4YjQ5a
    XQ4BtYnGmTetbP-L2oE5yeYbCL2CXvoIwWd5jDv9rvicQrKRECEdA>
X-ME-Received: <xmr:fTvFaTrF2EzQJg0BzXHm_g9AUzKP-qHA6Siaf1mQHsdRlEmhCZfJyf61XMd4A__3csw8kdvZME47vpODU9Qo7tPxaOh0wIPK5J5j6mkHx1AAsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegrphgrthgvrhhsohhnsehp
    mhdrmhgv
X-ME-Proxy: <xmx:fjvFaVaZwH9hSw2u0szbT_oAkvyLgRkxKUCrgFAMD46RZikT-38buQ>
    <xmx:fjvFaTQJbsgRrPFmUpyFG-Yg3HXRUu2M5Bb_WvPPq3VoKCCu9N2JkA>
    <xmx:fjvFaU4koNFBkrpLWbC33rFinwgF9XbsWPhz3nUxJio0ZUjkmJkpaA>
    <xmx:fjvFaQyTiKsaDzZr0LvC05Ve8s_hTByPtP-amiIPfqX5SWZdmOBiVQ>
    <xmx:fjvFaVY_P7EA7SfqTuIrBOyGxG7GRL2rLT7WelQkcOFJo56UVfjcc0v_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 09:58:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4e80072 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 13:58:19 +0000 (UTC)
Date: Thu, 26 Mar 2026 14:58:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Paterson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Aaron Paterson <apaterson@pm.me>
Subject: Re: [PATCH v2] odb: add write_packfile, for_each_unique_abbrev,
 convert_object_id
Message-ID: <acU7eJ0MpUVhCs6-@pks.im>
References: <pull.2074.git.1774530437562.gitgitgadget@gmail.com>
 <pull.2074.v2.git.1774532383055.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2074.v2.git.1774532383055.gitgitgadget@gmail.com>

On Thu, Mar 26, 2026 at 01:39:43PM +0000, Aaron Paterson via GitGitGadget wrote:
> From: Aaron Paterson <apaterson@pm.me>
> 
> Add three vtable methods to odb_source that were not part of the
> recent ps/odb-sources and ps/object-counting series:
> 
>  - write_packfile: ingest a pack from a file descriptor. The files
>    backend chooses between index-pack (large packs) and
>    unpack-objects (small packs below fetch.unpackLimit). Options
>    cover thin-pack fixing, promisor marking, fsck, lockfile
>    capture, and shallow file passing.
> 
>  - for_each_unique_abbrev: iterate objects matching a hex prefix
>    for disambiguation. Searches loose objects via oidtree, then
>    multi-pack indices, then non-MIDX packs.
> 
>  - convert_object_id: translate between hash algorithms using the
>    loose object map. Used during SHA-1 to SHA-256 migration.

This will conflict with ps/odb-generic-object-name-handling, which
already introduces generic callbacks for `for_each_unique_abbrev()`.
There's also ongoing work by Justin to handle writing packfiles via the
ODB transaction interface.

> Also add ODB_SOURCE_HELPER to the source type enum, preparing for
> the helper backend in the next commit.

Huh.

> The write_packfile vtable method replaces the pattern where callers
> spawn index-pack/unpack-objects directly. fast-import already uses
> odb_write_packfile() and this allows non-files backends to handle
> pack ingestion through their own mechanism.

I'm again a bit puzzled, same as with your previous patch series. It
would be nice to collaborate on this topic, but that will require a bit
more coordination than just sending in a patch series as things are
quite in flux here.

Patrick
