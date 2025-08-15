Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC56DF71
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291934; cv=none; b=An23hnx5N0tuGU2zTY1G/a6x9HJyuGneNvfzlIAI4eixXFJOWUJVwIPjQdYb8YRS6snaKEmW2Gg7Rmu8UoQaflQb9v1YKna7lVppHdZgTx5sw8NxaVpKTBZaYzVOhJ4E9s6DQp79sWGK9dlUqXOT1P6jO2R4+Oz9wLe3WoU+LQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291934; c=relaxed/simple;
	bh=h1z4h3wcomwG7olSCL3/324/ILjh0kYWsgG14Tkpm/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LHUOqhSj1yufZqs0TP/hTq33cEXXdNLvUjWgUvTz797q0hm3YpLpPYS3zA1TYXhduuEmySbhwhXf9tXrelLPlgpz3sMCeM4UMsUErP6KzCD9XnpSUYHnW1Dsq61Tde7kB0MP90H7JzTXmFSS4YzNmDVZOXqxnB5BUYLjIl59ZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IVUxiNHM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2HsNVok; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IVUxiNHM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2HsNVok"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3ACFBEC0143;
	Fri, 15 Aug 2025 17:05:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 15 Aug 2025 17:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755291930; x=1755378330; bh=nX0A+6iKet
	iyyF7GYL/gwxhEu3OQBAIEq7a6/+ZeT1w=; b=IVUxiNHMwtlSJFXnV+q5oJYozk
	HnXnMFKU947AP1Wn5EnqfgxzTTCexhlz19Fat7ATLmoK2X1aRO0LXG+uHAD9TeT4
	MdnYhvB+OdLFhq84mJ8obHhLu+aZq88IMHHliU4au10H2gsKCSh81Scnm/65HLxY
	OgZfOCIk8zy2bbX7iJMbTy/2oqJV7zOkVpGpfWzvL7IYfQiU9UtXcSya8cAuATGo
	ro/amuGXSCodxJujnJnG03csrpx0urB8QurVs5UjbkyEKzuL9iGjjSPczpjiLWg5
	wWCsLWa+DpL7POIrEjjZR3RvqYWOax0rkZLR6QaYEEn/a5Uy0NBC4W3Wri6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755291930; x=1755378330; bh=nX0A+6iKetiyyF7GYL/gwxhEu3OQBAIEq7a
	6/+ZeT1w=; b=L2HsNVok0vK7x/zPQZfrJbN0b22QkFdyakyQw1l8RJ4oKmJvptr
	Qd+/aMvemqnIJJkrwQ0y6QGzTGyN+vzZIBSDI78HKDhG7j4I5NZ6sM29ObKkcu3n
	QcaNO8LIf7nbeH+RXrJ91AywjSJtRHm+IduVPneXxDyTrGGWxhI9BZ4HXi0ymY4g
	DKL027u5h20T7zh3XOlrbh/0kufAwlfwiavDTaiF0lKx/lhMMW0seaSG9iwhrbq3
	u1zRd5frfBQxx71XAQtMHxJ1/NCD/p5+ISg5ObndTeiktodGy8PbRGOXhIJvTo8v
	H7L2YEeUIG8uVlM8GkddlkmncU/dW0yROfw==
X-ME-Sender: <xms:GaGfaJ_4rwhkdWzt0ETK-sF8ue3EcLswsuGYec74iXJ0UdLnKW-Nvw>
    <xme:GaGfaKpzbHQklQVXBYtchfFdGa-k54Np7CgoH5txBDLfUWQ8ygvDGjCg4Zmfu8iV2
    iyuG-2M4hp4DOGTtQ>
X-ME-Received: <xmr:GaGfaCoZuYM8sJANUwnC1KME0j374FM1dGJbFoifvJ4d3i2VhfoouH1ucHt0YDsbagsTsZNfb8NOUgFI6Fvmaa_Glc1SpiM_VtKbDGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:GaGfaF0BYikeVkDUwxIflLU6h2X8akZCUJbJiHSG7pQL6U-IaINGeQ>
    <xmx:GaGfaIEgaHRMjGMiD1RD77EGMcW8GRwHbyA1RK7zG1OvgHK8bhpGSw>
    <xmx:GaGfaIENOXXm61eiEDP9Ju0We-wljgU04kYWQYg-iYAIT3WcZ_GSyQ>
    <xmx:GaGfaD6GDK9T6Ymu_mOokW3hVolNJscePxfNPz2geCcxP01Hai5vIw>
    <xmx:GqGfaKOSzO6JKE_v9edvm8y0QdZYEuqMlVsE95mmwizjFs9taoiWsE0c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 17:05:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v8 4/5] doc: git-rebase: move --onto explanation down
In-Reply-To: <4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 15 Aug 2025 16:52:29
	+0000")
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 14:05:28 -0700
Message-ID: <xmqqh5y8nvmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> There's a very clear explanation with examples of using --onto which is
> currently buried in the very long DESCRIPTION section. This moves it to
> its own section, so that we can reference the explanation from the
> `--onto` option by name.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 168 ++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 81 deletions(-)

Deduplicating is very good idea.

I gave a read-through over the result of the entire series,
including the parts that did not change, to see if the new
organization is easy to read and coherently tells the story
we want to tell, and what I saw was mostly very pleasing, except for
one thing.

The new location of this section on "--onto" felt a bit off.
Perhaps it is just me, but in case others have different opinions,
I'd raise it here.

The overall structure of the document with these patches becomes:

 - description that gives a simplified "what is achieved".

 - "mode options" that control what to do during a rebase once the
   user is given control back

 - "options" that is given upfront

 - notes about incompatible options

 - discussions about apply/merge backends and how they differ

 - overall notes on advanced topics

   - interactive mode basics

   - splitting commits

   - use of --onto

   - dealing with rebased upstream

   - rebasing merges

Is it so exotic to use "--onto" to replay a topic to somewhere other
than the direct descendant of the fork point, to make it a part of
advanced topics?  I somehow doubt it.  It is a very basic and common
thing to do while correcting a mistake of choosing a wrong base
commit.  You often realize that your topic is basically good but has
to work well with a different base commit.

I wonder if it gives the same understanding with a much shorter text
and illustration if we get rid of that section, and mention --onto
as a part of the early examples in the description section.  That
way, we can reuse the "set up" of user's brain and context we
already made with the existing example.

For example, after showing the rebase of A..C on top of G, we can
mention that the range can be transplanted on top of commit other
than G, say D.  Perhaps we can say that 'D' is still part of the
maintenance track, and the topic being a fix for a bug that happened
before D, it should not have forked from E that is a feature
enhancement commit that is not eligible for being on the maintenance
track.  That would be a good reason why the user may want to move
A..C on top of D instead of E.
