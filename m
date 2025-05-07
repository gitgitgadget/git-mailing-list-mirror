Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C4DDC3
	for <git@vger.kernel.org>; Wed,  7 May 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654422; cv=none; b=cu+OwVS6Iljh/a36o5Zc3Y4S1KsXxwNuaPrXxdRLO+26Lyx5Mi7fkPtHAtMaq4dmNB3HmnJV0QgRqZm3eOVpQ/g3bHNO/ar9hMhP0qLi9c7yMrGC0IyykY+WaiY3kQe9/diLgQ00GDY8wzqWd7AGdJ0y9wQMm+kTqzesjMGOGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654422; c=relaxed/simple;
	bh=FD0n6dmNefktvOlwRtm+t5nv6Bo5Ec6t1zCwzMNv6zI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5IT3AYAO+zK8OHrSWwHIC5MnWmq6qSJwBgdCXZaA1wH78PmjkzHOIkDXgntcnkKKn1haq6O37RUTlzi3awlzGyzBndYKu1MYRDne16Y3s/Mxie2cz4QN1T8mGqGUlAw9hebonhynVi7U7YYu8pPuS7yE7pgpaXkf+eADies+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oIRN+zBz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=utPRYP9k; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oIRN+zBz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="utPRYP9k"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 147EF1380178;
	Wed,  7 May 2025 17:46:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 17:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746654418; x=1746740818; bh=JxA9/8v814
	r2QuqTcLz0ad9h6R5JYpdvvPsmYN1llAA=; b=oIRN+zBz0++IcbpEpJutyDLXvK
	XrfKkBRQqr3DBcGGf08O0e4k1U9ZKlN2PpYJ0I/FvBCB5T+4n5DXDEgEh/mDzRic
	H0h3YmxYv6lrEMKQ8glW86QP9xtkCz7IVq5NfzBIcw6BD6hl0q/a7V7RXb9Ek+Wd
	9GFYWO46ms5LfURjJI+fJS3kxVgxFM+Zpzikk8/KpksxPdh0Yzu7oN6lcy/bjQAP
	iyCBeeTJRxEndav/lfCq/ZP5nOrAgtZ4HAd2apt9L2tqYJVtdg2pVYam8Si5GS3+
	Tt/vievOkvosI/1loWUET6eVIZPqJ3N34be/PV7BzQ8C3nZeT4K8v7jvHGmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746654418; x=1746740818; bh=JxA9/8v814r2QuqTcLz0ad9h6R5JYpdvvPs
	mYN1llAA=; b=utPRYP9kAgLUb4UPCZAxOHwg/ui6ex1dth/LTtGhxVv1yhnEuun
	Drji+C97gWv5T0nnUNNstsO6nsLfj0JoroWoFI+G7SaPI1ifm2tM1uvRis4BCHhc
	LIOt0OM4fS7/Jr3XnbVxq7zSZKdb9p7jKiyfn2g4mQbFuwAiIk06XKeQTUp0AS04
	M+6upIFl+FUPUD45ikP2KLyJvYK4aeyL8bjf59O8/qLemkqAlhAOTk5eR2aE/dyO
	jhIDfj6ZtKMAITwq/pOXJ/fMFGKs/75Q7vAwAc7m/T9k8i0cmRYK4Q6Uc5lYSL7N
	/EYO67IOOAZcawZYucq+RE6xHHJEwRvOFwA==
X-ME-Sender: <xms:0dQbaC3QEoutsvqsdPNKkTSKt2bdVs2m4vhJ24K8LnPu4R95tfU7sw>
    <xme:0dQbaFEtfVUm3qwu9hA_4EEbvbNZxN7gWxYwIsyP399KXifQpLKFKvWcGaNpeKqwu
    58TZjkmHXGxtrxpaw>
X-ME-Received: <xmr:0dQbaK5pD9lTbf_HcbT6vkEYTdPUx6aJsUm-allHi6kXflCnHhMWkUmnJ5HOCC0ghegFWYpfD4osnRNIlhUv4Nux6feKtg-fCKu7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:0dQbaD2_zdnsjS9DsNkyA1dFci-a2JJ1ozj_i1se3Qykt4Z957okCw>
    <xmx:0dQbaFH_6gST4h96Y2oLup4L08OnTVRoSDZj5Duh2QJymibAy9XaUA>
    <xmx:0dQbaM8XBFf4_mvPY2aAU_1OH2LBeAaLqZjBJeONskUall378Rnwsg>
    <xmx:0dQbaKmuk6G13tppdy59kZxsOHvc9iuIXKYDiEfUUGpKhaYSc23ufg>
    <xmx:0tQbaN-eF9Ine3qxVB-Y7izzQSO6U0MPF8khtV6O3IbWzCrQFlb6r7US>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 17:46:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/4] scalar reconfigure: add --maintenance=<mode> option
In-Reply-To: <684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 07 May 2025
	01:50:37 +0000")
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
	<684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 14:46:55 -0700
Message-ID: <xmqqcyckayb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add a new --maintenance=<mode> option to 'scalar reconfigure' that
> provides options for enabling (default), disabling, or leaving
> background maintenance config as-is.

Hmph, this is a bit unexpected.

> +--maintenance=<mode>::
> +	By default, Scalar configures the enlistment to use Git's
> +	background maintenance feature; this is the same as using the
> +	`--maintenance=enable` value for this option. Use the
> +	`--maintenance=disable` to remove each considered enlistment
> +	from background maintenance. Use `--maitnenance=keep' to leave
> +	the background maintenance configuration untouched for These
> +	repositories.

If I understand it correctly, here is the only place that the users
can learn what the valid choices are, and it is not even an
enumeration.  They are forced to read the entire paragraph to learn
what the choices are.

> +		OPT_STRING(0, "maintenance", &maintenance_str,
> +			 N_("<mode>"),
> +			 N_("signal how to adjust background maintenance")),

And there is no hint what are the right <mode> strings are.

>  	const char * const usage[] = {
> -		N_("scalar reconfigure [--all | <enlistment>]"),
> +		N_("scalar reconfigure [--maintenance=<mode>] [--all | <enlistment>]"),
>  		NULL
>  	};

So "scalar reconfigure -h" would not tell readers what the right
choices are, either.

> +	if (maintenance_str) {
> +		if (!strcmp(maintenance_str, "enable"))
> +			maintenance = 1;
> +		else if (!strcmp(maintenance_str, "disable"))
> +			maintenance = 0;
> +		else if (!strcmp(maintenance_str, "keep"))
> +			maintenance = -1;
> +		else
> +			die(_("unknown mode for --maintenance option: %s"),
> +			    maintenance_str);

Those who say "scalar reconfigure --maintenance=yes" gets this
message that tells 'yes' is not a known mode, without saying that
they meant 'enable'.  

The --opt=<mode> interface is good when we expect the vocabulary for
<mode> to grow, but I am not sure if it is warranted in this case.
Is there a strong reason why 'reconfigure' MUST enable the
maintenance by default, even if it were originally disabled in the
enlistment?  If there isn't, initializing maintenance to -1 and
setting it with OPT_BOOL() would make the UI consistent with the
register and clone subcommands, and also we can lose the above block
to parse out a string.  Also the code below ...


> @@ -758,7 +776,8 @@ static int cmd_reconfigure(int argc, const char **argv)
>  		the_repository = old_repo;
>  		repo_clear(&r);
>  
> -		if (toggle_maintenance(1) >= 0)
> +		if (maintenance >= 0 &&
> +		    toggle_maintenance(maintenance) >= 0)
>  			succeeded = 1;

... which does make perfect sense, would still be applicable.

I dunno.  I just feel that 3-way "mode" interface is too much hassle
to get right (e.g., give hints to guide the users who forgot what
modes are available and how they are spelled) for this code path.

Anyway, will replace the previous round with this one.

Thanks.


