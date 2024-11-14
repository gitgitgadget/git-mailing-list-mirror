Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C212374CC
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628097; cv=none; b=SUwglY6bgJxuv5VYKcZSa3uToGHZztY/uV0D+K+K+tZ1VzYtdYX5P2GxCi9AjprMKHNAd2Uoo4IaMfXyVeLIo6FamlRsrX0SuV3indVAq2LEpR+Y5wxOaHWnlCL18AMwEJ+LFqDrDfvjIskU6fnBDqimWK7kaCuPWJMCwfXGcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628097; c=relaxed/simple;
	bh=RXp+Msr51xlOd5VYBgAt1sLuRMV3lGQF9g1ugg/3LNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KxDR54KI/+NZ49OQG78z73MetNfY7JZc7cZm6hI8PTVprZzlfT4S92MPgUrOfIeToXuRgLiMJrmWU24PuO5V2iqfoJ+pTDArYMYeOdmm5KwMwPHky6X2R03hFaAT6il8vPplQNDKtFM2FQPr41Y8sZEKWJzrdJUkrPrQ8n0NFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hm6eigsS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hm6eigsS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2ABDE13805F3;
	Thu, 14 Nov 2024 18:48:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 14 Nov 2024 18:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731628094; x=1731714494; bh=D72iT3IocJdBZTWxqneqaGR4/gp4zXneqYR
	KRUMPE2U=; b=Hm6eigsSG9AToOs7YVkO56WmpfC8OCOe5Whmbd63ikzPwV/VOMt
	8cIr6qvP0z2l4P/EnKcBDItQ2GX36KQThDXQHJka90C7oHWyaO1YUMZzJzOunutQ
	EDqIg5I9vq++p4IYYV4e0LfTZquICchpFwwPzGBCNUWlm9LZCWkpNqTD1fU2wKv+
	o4DBOIOTic5C5aFEIksHfYOWwOMjHHndmgNYfj0+KwxVL7JE9Bc7bRBuPbnt1aBa
	PbuGvOe4tyBNLK0bn5M/4GIf2xiznR8NZ5LZeQAw3d7IzowiiD9z2hWwbVCL0ugs
	KvLBzgJomxmWCjWta/8Jr9qInFS8Od3Zt7g==
X-ME-Sender: <xms:Pow2Z2pTCe8Y7wl_iO7tYjfuG8gLmIEmrtjvPrO3DHBzZ0SxeJJbiA>
    <xme:Pow2Z0rcl0F0d-pRD4OLpQa1ZatzgbnYMPMAVHa6iUgrdfcEHpVyd9qeLNAFVqNbk
    QVavOiZvibKnYA8oA>
X-ME-Received: <xmr:Pow2Z7OfK5XjJSoWfh6NXWT7t8U-VOWdXP8sqHeB86nhszH1M_AzoJnjn2byG0rUDOlEPtDk-Qq_Gai7yKwI8GVYpcfbkfepcn-7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pow2Z1499Wz2kHO28DiEiGNsLT1z2TLtPE809c4NPB-A9uKyvVwxNw>
    <xmx:Pow2Z15ZeQwq-nyWxReUO4xkGshE86sOzUz175sTR-Zi8xKbbNna9Q>
    <xmx:Pow2Z1gdhL0VVk4lOk35q3LdgMRy7nJ8iw-9IW_w2REYh6R1zJZOtg>
    <xmx:Pow2Z_4fWzNz7Wrb6pHNuQoZCqcSieAHxByr13e-r7PeiV5sPdvHEQ>
    <xmx:Pow2Z_nVoUfDL9VNCGXZx6LKWGCHFgny6Gu1qjPyKppISmUqhem7Vn4s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 18:48:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs: don't invoke reference-transaction hook for reflogs
In-Reply-To: <20241114-348-do-not-call-the-reference-transaction-hooks-for-reflogs-v1-1-ece7260ee3c1@gmail.com>
	(Karthik Nayak's message of "Thu, 14 Nov 2024 10:58:35 +0100")
References: <20241114-348-do-not-call-the-reference-transaction-hooks-for-reflogs-v1-1-ece7260ee3c1@gmail.com>
Date: Fri, 15 Nov 2024 08:48:12 +0900
Message-ID: <xmqqldxl5qdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The reference-transaction hook is invoked whenever there is a reference
> update being performed. For each state of the transaction, we iterate
> over the updates present and pass this information to the hook.
>
> The `ref_update` structure is used to hold these updates within a
> `transaction`. We use the same structure for holding reflog updates too.
> Which means that the reference transaction hook is also obtaining
> information about a reflog update. This is a bug, since:

Yeah, the transaction hook is deciding how the values of refs should
(or should not) change, and its decisions should be sufficient to
determine what should happen to corresponding reflog updates.  If an
update to the 'main' branch is let through, that update should result
in a new reflog record for that branch.  If such an update is blocked,
there is no update to the branch, and a reflog record would not be
created for such an update that did not happen.

One thing that the above argument does not capture is "stash",
especially "stash drop".  The way the subsystem abuses reflog
disconnects ref updates from reflog updates, so there _is_ a use
case for hooks to interfere with reflog updates.

However, the existing ref update transaction hook does not have to
be the mechanism to vet "git stash" operation.  If we really needed
to, we could add reflog transaction hook for that later, outside the
scope of this fix.

> diff --git a/refs.c b/refs.c
> index 5f729ed4124f7fe8fa9df7fd1f1ce951abefc585..7866cd7378da95b3cdd508500633958802d166d0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2185,6 +2185,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = transaction->updates[i];
>  
> +		if (update->flags & REF_LOG_ONLY)
> +			continue;
> +
>  		strbuf_reset(&buf);
>  
>  		if (!(update->flags & REF_HAVE_OLD))
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index 5a812ca3c0b5d3f7de60dc999de6aafaf1f384a6..262efec60e85b7e00def18cce15d5ce15897836d 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -53,7 +53,6 @@ test_expect_success 'hook gets all queued updates in prepared state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
>  		$ZERO_OID $POST_OID refs/heads/main
>  	EOF
>  	git update-ref HEAD POST <<-EOF &&
> @@ -76,7 +75,6 @@ test_expect_success 'hook gets all queued updates in committed state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
>  		$ZERO_OID $POST_OID refs/heads/main
>  	EOF
>  	git update-ref HEAD POST &&
>
> ---
> base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
> change-id: 20241113-348-do-not-call-the-reference-transaction-hooks-for-reflogs-bb471a0b192f
>
> Best regards,
