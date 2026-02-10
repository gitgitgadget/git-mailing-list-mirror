Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86C21770B
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770699896; cv=none; b=PLFHUGBEG2H7awhF7BsBj3AgflQT4FfvISoURgknvsD8VZfiqXz85h1ejXEwbTA5HSD1BOQkoa8ZITi+ReBQRRuTsD9cXGXtMEFZpO2Sbcb15jFl91nkg2+3oEJEqpnqMglGloHoBBPit0k8qTWcrU50OFx7Tics8s3CjnGUAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770699896; c=relaxed/simple;
	bh=j9ueVZo8Xyu6KG/vmtwspUolGgnYphx1sT4FOFOIMcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HMm1mHMRhV5M7ncQWpTD8+ti35UgUVC5xIxMnQGyAkuJVsK5Iz25uWJoGJPHE+JB9SJlHbTtXDeA+xT7QAqhFkxicza9O7DuQc3u1UZG80v8zg1EcWP769rdcGdyhuF0ACNXKnvTuLuur6rF5uXZzb5CfOzEuonBO3qIEsaf5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=00plxHf0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkQT1q5+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="00plxHf0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkQT1q5+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 48608EC052B;
	Tue, 10 Feb 2026 00:04:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Feb 2026 00:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770699894; x=1770786294; bh=VxqVTHU+cT
	XhsINHDrrt3JHkScpUlY35pUegEXcF3Xk=; b=00plxHf0u7P8NXyPH3ERAxpWVu
	zL+65e1ewqetZmuMWhoeweNcY9Q+3YQavDT0NqnP2L9fAmuTEuaCL++ygAkb+kVh
	4H50ZqmcnherAe6iM3HS3PYmSdrNJJn4ha0sjKSIAXJkV/uGmVSrHOqcN/A746z8
	R7W1IjsCSW71B0TK2qgVspCuJp3mU0vyPloCsbeT5eckqVD2wX7MvRSo+Dthx7Gf
	15AzHww4zBMH4t5hlVlXrybr4XjDsXL0KPAG82YkcQdhuYnfpcpXFgqhRV6hAwV2
	OJ2VshHV1QSa6okpgFAwJ6mjpm6jBcQv2gxwRNGxB4/ELmkE4uK6xBmBIFAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770699894; x=1770786294; bh=VxqVTHU+cTXhsINHDrrt3JHkScpUlY35pUe
	gEXcF3Xk=; b=IkQT1q5+EzGqc0KoIg48vYKfd9bOAe2RD8bI8Br5DyxzH1dP8y4
	MZbFDHMqhaN3CBhF4XTfxAHk/KMeERD5cXsF6nTgCWiG1pJFwY/3QhUw6GtYROMu
	YcyZYe0s/Ko56vcv91RtAloiLdXsunK+ARM99neM/kzBgw5+xT9DR/eiJbWh/2i1
	+fS1HJlY+6ni1yZ4VkxtTRTJHW5fZwHMiXWPLWi3htjKjqf3y/Um7yA/Kx533hJq
	ROiq3Q4g5wjWM5giDFhGw1qsu5etNsj7Fg5eRKQCuXffTZhVae/C4Z1kbwgvLwxX
	MqKKMM52FNR5LKIx4bpwAmf5SF1xut+Wimw==
X-ME-Sender: <xms:dryKaUk1d7Qybk7h5nlx2d6hUery7XtxtPeWfspc2bmsJY12jJtO7Q>
    <xme:dryKaS5BVuw3JdTXVobvrsJm7n3TdBg966zrU4q6GjtyNKOy4lbr20Xk7_gIYukFd
    r1ayFJtnU6ao6doG_2NRpQPGct83Ro2NgzIxMXWw1Fta0rn8i8WWg>
X-ME-Received: <xmr:dryKaY3SPa08uzXEUG1R0eNKLaaOVWffSAqyxI9Oc2AWfmddXLRZMGvrASDyTdq6ah2f7U-so9br_c40eRwN16Hea1g6Gx93sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dryKadFxYiPHC1bPJHqwsyNh9PRTzAARH8PDlDFLe1U4w3bUEcVtSg>
    <xmx:dryKaXjKFtZjlu5GrLl9VGCAljyqnT85ps7OhEd-9HXFHMXeF4cGKQ>
    <xmx:dryKaQAD9DiO3Ay5AOrb3jTcbd4_WeuqJbuxKDvuP37lV3aCwy3mpA>
    <xmx:dryKaZSXWsGXj_-d6DA7GGX1nusA6gHAcRna1B5ZRu-jclPRhUxffQ>
    <xmx:dryKaX9NYgpVs0_YN_Ig7Nf-BHMPHcVe1mGx4qglnTr-Hjg_EIWE873Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 00:04:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] config: allow format_config() to filter
In-Reply-To: <d9e04240100afb4188d32c5ce784f189f59348b4.1770698579.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 10 Feb 2026
	04:42:57 +0000")
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<d9e04240100afb4188d32c5ce784f189f59348b4.1770698579.git.gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 21:04:52 -0800
Message-ID: <xmqqfr791957.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The format_config() method in builtin/config.c currently only uses
> git_config_*() methods for parsing. This allows parsing errors to result
> in die() messages appropriate with keys in the error message.
>
> In a future change we will want to use format_config() within 'git
> config list' to help format the output, including when --type=<X>
> arguments are provided. When the parsing fails in that case, that
> key-value pair should be omitted instead of causing a failure across the
> entire command.
>
> This change is formatted in such a way that the if/else-if structure
> allows the default die_on_error version to appear first and then be
> followed by the gentle parsing mode immediately afterwards.
>
> The only callers right now have die_on_parse set to 1.

Certainly you meant die-on-parse-errors, not unconditionally die
when asked to parse ;-).

I wonder if a "bool gently" like everybody else takes would be
easier to understand by more developers and readers, though.



> +		if (opts->type == TYPE_INT && die_on_parse) {
>  			strbuf_addf(buf, "%"PRId64,
>  				    git_config_int64(key_, value_ ? value_ : "", kvi));
> +		} else if (opts->type == TYPE_INT) {
> +			int64_t v;
> +			int ret = git_parse_int64(value_, &v);
> +
> +			if (ret)
> +				return -1;
> +
> +			strbuf_addf(buf, "%"PRId64, v);
> +		}

So, this follows the typical layout that was described in the
proposed log message.  I wonder if it is too much to break the set
of helper functions further down so that this part of the caller can
say something like:

	switch (opts->type) {
	case TYPE_INT:
		format_config_int(buf, key_, value_, kvi, gently);
		break;

and similar case arms for other types?

