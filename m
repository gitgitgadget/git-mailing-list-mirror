Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEA30DD22
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476507; cv=none; b=HTmMbdytWUxtRmCg01qwX72r5cNH4lxPzR9UXYONC2Utz+iFDKFojvkLkkWMtucOJ3zKiWR/UJPg5n6W2uqinrmKJeaDmG3e0JuNnTT1YRW6rwCCUaMhtu+jbUGO6iALps5/UNuwOblKlXWHun0jlIIt8/3SVQuawXNF1/ngAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476507; c=relaxed/simple;
	bh=hHXEmHXswQ0M+ErbmYeRdwX+qLeZJLzyWuxeNmW16Ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEzF1Jy6IdbSfiLFECWYrdWtBxNvbmIKXR7TDj7uA7NyN22LoJhOGfoTGTtyIMyihUzX1o/4c7LND6tzp1DYiOO6ZHabyG9j+ovpWFOU19hhn6kDmtoaFet2AlPDqLr9J3+8t4EqVeSoonmxRa/eUprocbD+HtDhnVJVfzF+jBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fnr8Kcwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUllDhsW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnr8Kcwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUllDhsW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B408914001EA;
	Mon,  2 Mar 2026 13:35:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 13:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772476505; x=1772562905; bh=WJkru+rp4f
	n705ROyRJ7tx5FtYr6G4gzVKnYuKv/KW8=; b=fnr8KcwzJv/BDgUiXfWJZYpRWx
	SJIZ6lqTlzdc4sf+q5Jm41fgLfoc4rkJk0wrL+3UOUr0yOulP+t3lqzVBLNP5F8/
	E9kSj4oxk2kbv1dTHrinDyZHQpIT4qDfCGwvGec79uFwkRE3DAqBd0BC94z0RYrV
	LdNhUDQZ+RyectGovbBCBEMo8y8cdoKZuQt7yPTX+98paPRBU5JN45MACUeHmDLx
	C0P+OgKksH4CK03lcHtiY6EvL1s32kGn5vy0OeHnuWDKX5wf7zXO+EbJcHBqnl/p
	P/gYRaUKnD9IJmv1K407A9qAvEFk436yjl34r1w2DTzlxDgHOsnTGh6NhA+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772476505; x=1772562905; bh=WJkru+rp4fn705ROyRJ7tx5FtYr6G4gzVKn
	YuKv/KW8=; b=dUllDhsWEv19ZtQ+bDDrW7WZ5dWrw0rj778EMJj0OJMit+LnxBW
	2qcm4IHO7BWEws9a8BiBU+0Puh+a+pDQidzdJQ+nhYPzNPiU/qGe0dc8UdsXPbcv
	5aHF88MR9Ngsgj3sKoeGpvSP2UPYLOxc8aZP9pIjpIY0/FH5KQZdEsR3eWsPuuYO
	VEmxufE1p+qqu9sSvkglJAtlEuBvb+g2f8jD+tfOP6eN8BbBhjtfMw+0N9ViPUb1
	SfasZnZMBDJw8x0WQfPzBrmUdeZKtotuSNYAOYN+GrVKYeaWJ3Xgu1GeKapTmVIm
	AGvOY4EqycqaegH5cTZ4OTfCDAn51QTqHKA==
X-ME-Sender: <xms:WdilaadlN7gfRKNjrhga9OzwUyz3jbMR9ublmJtbcDJJQweYG8zaTA>
    <xme:WdilaWwyku-CcLi9CLkyEDEQFD44VFNVY79wn_6ZfXeyPzzg374vkp_TaMe_NoeQm
    tMMYoon9_uuN_LX21d4WVP6wsdLRXo6OuYsTYUG6qUWVE-82zSE>
X-ME-Received: <xmr:WdilafJUOgWawwb4e6aLjD8ZXy2saNh3Dw0bXh2gH3fThFTxYbwS0dGwZn_rNAIyAdurpCWl0XPDG2SnCheZgLptpZEfPsUZBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgrshhttggrthesghhmrghilh
    drtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WdilaYFMzNoouEJ9lzbanoKw1h9oZb-yltt271jL670r3ZRk-MYLtA>
    <xmx:Wdilab-oJJzeoyS8RTmaCfy_Oq0HIPOsbO2OoSGjWwWrO7gxhnF77Q>
    <xmx:WdilaYIp7a7G6YntJ9ELpAVwMiyD1RjOQj09dxO5zgYo7VggTpvHSA>
    <xmx:WdilaZt0JFfwcTO5Z2nKXlM1baQ6nSeFbwKZ6PifFzL92E1w_3q3pA>
    <xmx:WdilaRhPxfzKXwFW6AWDQXk8xIAUb7ULWZe4HhB2a6qb3gaZmXNr1e7S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:35:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  fastcat@gmail.com,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/4] run-command: extract clear_local_repo_env helper
In-Reply-To: <20260302180324.GC28275@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 2 Mar 2026 13:03:24 -0500")
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<13d783dbbdd77b14fed651f0508fa0e668d98c63.1772465805.git.gitgitgadget@gmail.com>
	<20260302180324.GC28275@coredump.intra.peff.net>
Date: Mon, 02 Mar 2026 10:35:03 -0800
Message-ID: <xmqqldga13mw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> +/**
>> + * Unset all local-repo GIT_* variables in env; see local_repo_env in
>> + * environment.h. GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT are preserved
>> + * to pass -c and --config-env options from the parent process.
>> + */
>> +void clear_local_repo_env(struct strvec *env);
>
> I worry that the name is potentially confusing here, since it is not
> just clearing local_repo_env, but making a few exceptions. But I don't
> really have a better name. We called this "other_repo_env" in the
> existing function, which is equally opaque. I dunno, maybe the
> documentation you added would be sufficient.

perhaps "clear_local" -> "sanitize" or something, with "env" ->
"other_env" to clarify that we are not emptying ours, but the one
that will be used by somebody else?

> Speaking of which, the documentation for prepare_other_repo_env() is now
> somewhat redundant. If we ever change the behavior here, we'll have to
> remember to touch both spots.
>
> So what about squashing in:

> diff --git a/run-command.h b/run-command.h
> index 76b29d4832..882caeccc8 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -518,11 +518,9 @@ void clear_local_repo_env(struct strvec *env);
>  
>  /**
>   * Convenience function which prepares env for a command to be run in a
> - * new repo. This adds all GIT_* environment variables to env with the
> - * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
> - * corresponding environment variables to be unset in the subprocess) and adds
> - * an environment variable pointing to new_git_dir. See local_repo_env in
> - * environment.h for more information.
> + * new repo. This removes variables pointing to the local repository (using
> + * clear_local_repo_env() above), and adds an environment variable pointing to
> + * new_git_dir.
>   */
>  void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);


That reads very well.

