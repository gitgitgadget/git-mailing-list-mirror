Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FD18E29
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733108490; cv=none; b=DZuypqg4FZZb5khL0QSfEP6K7y9RbGvUWeWw3TyTSdo/ffyCpYKUsp0+akCydrWMJtAW2KHC757ECkgYzIPdYsJ5nu6iyJ8Sw1wB0ZnjfiI7PQ0GI7L9+mY8xFzC1QmMfYA6UiW1d6wCAV2WvS3X7UbXTZLE4RLiR5JpEZloa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733108490; c=relaxed/simple;
	bh=/o8AouhtbPD/p8XT3u4hozpBPEj1sVhQRqtim0XXD1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mw3YZVlhrNJOmsiggMtGpTk0Cxv9mJ5z8GPB5U/dcWUvGsG136kqFr8gAGOMXyoK4yeynok032IXqaPfndCwFO2H4kVNHTWB/hQdQhfA4B9xnnGyj6JVXbDMfD1vsO3Xx/v8axQcNr1HnKwVY3N9T+svykVS7O4YRx4TApjB7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3TLH03s+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3TLH03s+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 862032540115;
	Sun,  1 Dec 2024 22:01:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 01 Dec 2024 22:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733108487; x=
	1733194887; bh=RH5eI/dVKqNRJV/leYSLZ+hZmJuRSMjbBHkluPEODFI=; b=3
	TLH03s+013roBwztXldNaH4Vw7RXAFX8rrEOXH3Ja00SRoaMD2bxgF4dRQo+DIyX
	zu/3/Y4nBd8wS81EymIc8QGqQ76HTNbj27MEIbqFsX6og1NnZm7sNdEJhJgHh72V
	Kh7mQMWahMsxGSnuCzmcD1il24ggTsE4HMLabKCbwM10/esp9hXD3W6d+ggqJkbn
	ovqr1itzRC7gHBRs4EnJWHlm4bUSL1aEZE245Xf9Ys6hLA983XhUzoht+bqj+CLs
	czAzEtdh7fsB7feWLE7zaPlCPCheHwesr5Pz/gjJ96qjEraw3CEWjl+peO9bCgog
	fUW74FMbFW0Ajj9oco6fw==
X-ME-Sender: <xms:BiNNZ6IV7osPqsLCqjwbuBWVTLgqAVNw4kp-EZBwv2oy3B6kzJCAhA>
    <xme:BiNNZyLeHDFd7VdFYVHEJcIOg1g0-RrWW2qU56DfII8FnU985RHDGQ1WBb-it_g6k
    zHlj1t7BaTmC1hnSQ>
X-ME-Received: <xmr:BiNNZ6t4lROADyLR3efKzq8KO1KBywlKNyjL1C5PL3rOuVoqdhZUv1LlFY0sGXBWAcHRHNJ9JUkUd7UgKPpfWq9WgqICRkax2DHRd7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgtvghplhestggvph
    hlrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BiNNZ_ZulW0T5vCJk7LK2EQYOt_5l1Bv_u0X92M2R0bKFx0dTxJ7xA>
    <xmx:BiNNZxYHXcW-xZ8Iyr99kl2_szhVNVQqjcJ7q5Y2qB1a3RsZqCzJDw>
    <xmx:BiNNZ7BkKLrNOl9WDsXyUWT_R3FVWcIi9ib-xjFYyqRkG3zXrqq-cw>
    <xmx:BiNNZ3aQhnKjhi1UMNNKWuzuzDIOg_keXKcYImQ6VXfuJEbT06UgMw>
    <xmx:ByNNZ1Gw1tgtOu0WX_i7DV5nheOuFsWjkjLZ1vAEElLB2upIIC4KXo7Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 22:01:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-update-index.txt: add an example of use
In-Reply-To: <20241201222531.1478338-1-mcepl@cepl.eu> (=?utf-8?Q?=22Mat?=
 =?utf-8?Q?=C4=9Bj?= Cepl"'s message
	of "Sun, 1 Dec 2024 23:25:23 +0100")
References: <20241201222531.1478338-1-mcepl@cepl.eu>
Date: Mon, 02 Dec 2024 12:01:25 +0900
Message-ID: <xmqq1pyqkcu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matěj Cepl <mcepl@cepl.eu> writes:

> I met this command in the wild and I spent a lot of time to
> understand what it is good for.
> ---

Missing sign-off.

>  Documentation/git-update-index.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 7128aed540..da11cbc418 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -399,6 +399,15 @@ M foo.c
>  <8> you can tell about the change after the fact.
>  <9> now it checks with lstat(2) and finds it has been changed.
>  
> +To speed up other Git commands that rely on the index, such as git status
> +or git commit, user can refresh the index and avoid having to re-check
> +the status of every file in the working directory. This command
> +doesn't modify any committed data in your repository.
> ++
> +----------------
> +$ git update-index -q --refresh || true
> +----------------
> +

Two comments.

 * The example before the new one is for a rather esoteric corner
   case of running Git on an inefficient filesystem.  Perhaps this
   new one more commonly happens, in which case, it probably sits
   better earlier in the list of examples.

 * Because most (if not all) Porcelain commands like "git commit" or
   "git status" automatically refreshes the index, it is of dubious
   value to manually refresh, like your example does, before running
   them.  You pay the price either way, and the only difference may
   be the time (and brain cycle) you spend to manually issue the
   "update-index --refresh" command.

The benefit of refreshing the index manually beforehand mostly comes
when you are running two or more plumbing commands that do not
refresh the index by themselves.  We used to implement an equivlent
of today's "git status" using "git diff-files" and "git diff-cache"
(yes, we literally ran these two commands in a row to show their
results in the output, one for "changes to be committed" and the
other for "changes left in the working tree"), and before running
these two, the scripted implementation of "git status" ran "git
update-index --refresh".

Thanks.
