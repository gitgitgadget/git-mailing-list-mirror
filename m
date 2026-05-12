Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF83998BF
	for <git@vger.kernel.org>; Tue, 12 May 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593997; cv=none; b=IHOBuiBwcZpCX3E3W59Rr1hK7Z0L9jNxj2oogXunyEO/A7Ip63MufQ/PHunN0k3dpZO8HZbFRejWYtyk88mDxvTZdJJ91Pp0gYe+euu3lTPmTfZvzvsaN1B+m1Gcf18mA5s+GJWNrw73W7G5x+1ivSFKkC1Mzk2qXKFQY+DCyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593997; c=relaxed/simple;
	bh=Nwlm7sBbtJnVzUiqRYNN7iGExfFhu98bMqgdvu0aEQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fs08tkHJ/wLEVxh7GujPcW4UzAUma0PyEwPRjsxGqyK+sMec9nG+iLRHLbdQb0+VmCJLAnqmqvZeMop0zMf350b64PMnt8CExHyrQp/fxMCqqbosxDbGVu/H5+SE69RGdFSOGY41i22R/352Y9q1JDDLa319qonrVskVKG3x4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bEXaoPHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rOBjrMuC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bEXaoPHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rOBjrMuC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 74A021D00090;
	Tue, 12 May 2026 09:53:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778593994; x=1778680394; bh=ME123a7eQb
	dhjnfuxHd31iAK3SKq2mQJemuW1UtfamU=; b=bEXaoPHlRA0nMX2Q9Y3mneeJfP
	R80be7HHcV3dmNyTA8tsNB1VLVLsZdSiAvX0VasAoE+nTa4VTkpYognfjpqBGcil
	RzPQsKl+gyPnU/Sp1wj9PFhxWYjMCEZHAtP2hpUUdYUOzxHDO4BjW6LrqJfDMzqY
	/cegdI00QZxTAoBQoI6UBGv9nYLysA5jiRxvM6DPF1Dg8kOKnm4WjW+XK4yapGQk
	9HtaeGH+2WWkMTuVLoglMNM2zFNgec29dNbxN3Ma8V/0SfzvczPuGb+4IxZofjJA
	7N+Yjr8k6PYsK7dWOcMyXrUJ7aw0hAHd+K3Mzhl9jxsyFhxaQtHXZXzli0kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778593994; x=1778680394; bh=ME123a7eQbdhjnfuxHd31iAK3SKq2mQJemu
	W1UtfamU=; b=rOBjrMuClIPNQphr0+IkYUSk9wA5RiCj1XH6AXBa+XatuG+i8Uq
	1pZEA0K0gPsg0/DTUaIpBD5h9VxKhAXVKcQMFs+R6r8p0m0LZ51ULOTzWuP0yTw+
	yEIiYx595t0nI9HBWRSnn3MZ7gN7NqTgRQCkH+fzmcyy//Q+ATTuZpYSe8Q6LDoI
	I9DaZ1TkZp/IDy8bD2d0FRL3hasyT4EVjKLpYnhR6V6u0B0XL1SguQd4jIFkZw4R
	l0xvvEPJx196XO8XZoUB1/kYTM+xwAhvv/q/6egEJ2wYzdSonr2xeynta452JjQ8
	QWipaV3Ws3k+lvC9LNyZ29hYbw8Q1ZveQqw==
X-ME-Sender: <xms:yjADaoB3FHq7oX049TKuC4KFv1QnJFRe4YrlrJIlxnD4H7QKdh2ziw>
    <xme:yjADauMihX-PKGl5xlEnlTbh0h76CamnP_7W85IkvUM_dPuiFHv3HpNUMDeDzpkNF
    9pbV6MJQ2PpGW3hLbdHWAv3mykQ98Izem_yxrO0Y9Gv8w4R9xqfPg>
X-ME-Received: <xmr:yjADalYnDzUpoNGeRmb5zbuy9NRUxaxqNun0SMat27c09cFMZQKp2y1kOgC_S0RBZ8SSpjpnyhWwUWFRYtenuL3b1aBUMDn6EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehhrghrrghlughnohhr
    ughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:yjADaltzAPCHjLT6nx-JnMo2ECLDZBbjnCYHZjToDGPmXDeykQcnJA>
    <xmx:yjADavOuLkAP4W3ms7_Yl55rdxvxqEZ1vGvek7kVvvxy_dVPFAg0lQ>
    <xmx:yjADak7uQtbucU7jyBhW56KURxfDtVjIB5BTbCnSOZ-1n5d-3uWpBw>
    <xmx:yjADatQBir7Vquk98c8-onubxTBQhEaclBo5OwsCMKyjI0vZ68iDZA>
    <xmx:yjADatNV9cCrC9vpV98H2haKSFIwBwuOmpL69to5Ru4tYl0s9YKJcTWR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 09:53:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 3/5] branch: add --prune-merged <remote>
In-Reply-To: <a2450098932a734f47ebe5f2c800bd63f760b64c.1778574229.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 12 May 2026
	08:23:47 +0000")
References: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
	<pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
	<a2450098932a734f47ebe5f2c800bd63f760b64c.1778574229.git.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 22:53:12 +0900
Message-ID: <xmqq5x4sn393.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`--prune-merged`::
> +	Delete the local branches that `--forked` would list for
> +	the same _<remote>_ arguments, but only when the branch's
> +	push destination remote-tracking branch (the branch `git push`
> +	would update; see `branch_get_push` semantics) no longer
> +	resolves locally.

I thought the thing you were aiming for is this scenario:

    git fetch origin
    git checkout -t -b hn/topic origin/next
    ... work work work ...
    git push origin
    ... the above pushes the current hn/topic to update their next
    git checkout master ;# or anywhere other than hn/topic
    git fetch origin
    git branch --prune-merged origin

The last step notices that our local hn/topic has been merged at the
remote to the target branch 'next', and the second-to-last fetch
makes us notice that origin/next now has our hn/topic merged, so we
no longer have a reason to keep hn/topic around.

But the above description uses quite different condition.  You want
to notice that _they_ removed 'next' (for that, the second-to-last
fetch may need to be run with --prune) and then remove our local
hn/topic, but to me, that sounds nonsense for two reasons.

 (1) Their 'next' is something contributors may fork from to work
     on.  You exactly did that with hn/topic branch of your own.
     Why would we even expect that to go away?

 (2) When disappearance of their 'next' is fetched to our
     remote-tracking namespace, we would not even know if hn/topic
     that used to fork from has been already integrated and stashed
     safely on some other branch on the remote.  It sounds very
     unsafe to remove it based on disappearance of origin/next
     remote-tracking branch.

> In other words: the branch was pushed
> +	under some name on _<remote>_, and that name has since
> +	been pruned upstream.
> ++
> +As a safety check, branches with commits not yet integrated into
> +their upstream remote-tracking branch are refused; if the upstream
> +itself is gone, the remote's default branch is consulted instead.

Again, this is as nonsense as our example in an earlier iteration of
having a topic forked from my 'todo' branch while the HEAD is
pointing at the default branch that is 'master'.  If the upstream
itself is gone, removing anything based on some other criteria
cannot by definition a "safety check".  I'd suggest rethinking the
logic.

> @@ -171,7 +197,7 @@ static int branch_merged(int kind, const char *name,
>  	 * any of the following code, but during the transition period,
>  	 * a gentle reminder is in order.
>  	 */
> -	if (head_rev != reference_rev) {
> +	if (!no_head_fallback && head_rev != reference_rev) {

I somehow thought that the necessary check at the lowest level can
reuse most of the "branch -d" protection logic, except that it needs
to pass NULL for head_rev from check_branch_commit() down to
branch_merged() when doing "branch --prune-merged".  Do we really
need an extra no_head_fallback parameter?
