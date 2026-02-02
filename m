Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844B36C0CD
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042014; cv=none; b=Bccjw/xVKDcsxvd+zWqRoTQ5kCXbAPV3djl0XK1UppwAoMQYwYYyt8ajrQgd0wRXf078V0qn1Ya4HXZb1nBeDhZHtKTjaXfpae9rqeYfvmOO4AL8KCmG16C8ZhSpESaA144wsO+zk7fuv32CeFOdMTWAkhA1KsSUF8cuWybBbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042014; c=relaxed/simple;
	bh=/UnkhtJLD7NEQA7lzy0QAl351/j4DU23JY2QQ1zk7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YobUpFO+aOlAElWzTzWyiDRPq0Bn1Jx7bwvADI+qFyePnLhFvyWzZKawyLeS14AtAuVFSv+FrDwYsdkK3dE9f6wIqoVO20vz0QxObkGEv/gbJhkMIUheJ+55H0BZ2S+livjLJGqaCRYmVoGKkpyKeGZad0IdR5qdBs3DUaAGMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dNEdhyhj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlxkYyhu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dNEdhyhj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlxkYyhu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D954714000B2;
	Mon,  2 Feb 2026 09:20:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 09:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770042011; x=1770128411; bh=GGxwsxjHJ0
	5SStIbEQ6yb44FGxLe5BWPbeElYAsg9Fs=; b=dNEdhyhj7vw3LtL1L4lbC2h8yR
	CpIYWxsVMLoW2i3quA0sPE7UvuM6LNBLJLes9Rxyp9SnUq57ttBpJEhog69uOJXM
	GNWcj70DhuG3Wespcbtk/S/VD+vMAsbK9WQf3kXGB9f/8LrMdUytMnLklRBmREeu
	vrCfCQdAmSpn993KtvHWglVAUmxhf2FSnf6/iAQdJjMVjdqjA/pOaM+TYQWo8Mcr
	tTwEcamY0vbTg3iD4qa6swEc/FJ0PoyqwiRwH5GgmGnxXIDTtTcorCiJ6LMjwtla
	+OdT8tg4oaxDci/TrqGmtfD1/2RCDuqJ05DMr/vH0nBsFmVE6+IbndkXAbhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770042011; x=1770128411; bh=GGxwsxjHJ05SStIbEQ6yb44FGxLe5BWPbeE
	lYAsg9Fs=; b=YlxkYyhus+XhOMT7CwHvV9ie8/M3hhDRj2hKxzF+YEajE1tEfoi
	VTBeuF14z31yJJja16ETMF500X+0MG0pF9YnurQiK1lmaG4iaG7cd0jRig5jSLeI
	mhrF9szVqKM/PFXGTaHaIKE2Ak29TBXSN0o7mVEaYbmGRzA+3OetxbqxaEGjF2w5
	Hn2EEQxOt9+2qmNi6b7svTCX2+qoBfp9E1cNTYL7vk/TV5LfQaCruFGKt4rQF/6M
	GUIzsLDtnBABYopHyCMEfQ85BeLj9BTw20FX8JtEZj0N+/5NfOS7n+ox/goyU0BS
	vGPmN7k78E+zcoRgrp+8LalqaHb4DOKjxWA==
X-ME-Sender: <xms:m7KAaTATizkepoyrhNX_4noP1wnHpwvPSHSe-3PdcZpkCWdtJ8H6ZQ>
    <xme:m7KAaQgM4ybnwSayZFxc9UjzZVSZ3wWv9sIAt_TIR9X1arpKqlOpMBAPb9C0BiNxb
    ceNP45cMbINaFoiySgkR51xNFuDXtrm122Z63DR5XDZmSvpJHVREQ>
X-ME-Received: <xmr:m7KAaTldxQAZTberGEBPMaoXGmGnKf9BD8YqtbybnQXRyNHpthLW4fEiaE1HgK0fnSabCoEqO_H-Zl_4-5ztn2EZq4itjr1RNRNUSrZRCfnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:m7KAaUr1dd235lYv1sEUfrxWkvleHiFA_PHNem8XsctsLu6cze-Y8w>
    <xmx:m7KAaUEiEz8DUCF36Ybb7ShH88r1jPVcRSPIo4zXHqkZBkYm8p4Wyg>
    <xmx:m7KAaYxJbkw6p9awyJAzvc8J91jhITjhr5pW80FqRT67OQjMTrzWJQ>
    <xmx:m7KAaRosBF6iptSFhdLZgmOPTSdNh3VSwoICAZGYQ6XBWa20zVcUDg>
    <xmx:m7KAadjbTG5fL0hZSAhOKIHcVWsoRWDescyDBbnWE9ehAXBHpP2sXz_R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 09:20:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63f2c9ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Feb 2026 14:20:08 +0000 (UTC)
Date: Mon, 2 Feb 2026 15:20:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH] stash: honor --no-overwrite-ignore when updating index
Message-ID: <aYCyk02vG8ObH02j@pks.im>
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>

On Mon, Feb 02, 2026 at 01:19:22PM +0000, Pushkar Singh wrote:
> The stash code unconditionally cleared opts.preserve_ignored when
> updating the index, leaving a FIXME suggesting this should depend on
> an overwrite_ignore flag.
> 
> Introduce overwrite_ignore plumbing for git stash push/save and use it
> to control preserve_ignored during reset_tree(). Add a test to verify
> that --no-overwrite-ignore preserves ignored files.

It's somewhat surprising that this requires so little code changes. Do
the mailing list archives yield any justification for why specifically
this feature wasn't implemented?

> This removes the long-standing FIXME and aligns stash behavior with
> checkout/reset/merge.

Missing signoff.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 193e3ea47a..82d10520fe 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1856,6 +1857,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>  			 N_("include untracked files in stash")),
>  		OPT_SET_INT('a', "all", &include_untracked,
>  			    N_("include ignore files"), 2),
> +		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> +			N_("update ignored files (default)")),
> +		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> +			N_("do not update ignored files")),
>  		OPT_STRING('m', "message", &stash_msg, N_("message"),
>  			   N_("stash message")),
>  		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),

`OPT_BOOL()` already handles both the positive and negative case, so
there's no need to specify both here. Furthermore, both of your options
actually do the exact same thing.

> @@ -1959,6 +1964,10 @@ static int save_stash(int argc, const char **argv, const char *prefix,
>  			 N_("include untracked files in stash")),
>  		OPT_SET_INT('a', "all", &include_untracked,
>  			    N_("include ignore files"), 2),
> +		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> +				N_("update ignored files (default)")),
> +		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> +				N_("do not update ignored files")),
>  		OPT_STRING('m', "message", &stash_msg, "message",
>  			   N_("stash message")),
>  		OPT_END()

Same here.

> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 7704709054..9c5421cd76 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -427,4 +427,17 @@ test_expect_success 'stash -u ignores sub-repository' '
>  	git stash -u
>  '
>  
> +test_expect_success 'stash push --no-overwrite-ignore preserves ignored files' '
> +	echo ignored.txt >>.gitignore &&

Is there any specific reason why we append instead of overwriting the
gitignore file? Overwriting would probably be preferred so that it's
easier to reason about the test without requiring context around what
the current contents of this file are.

> +	echo before >ignored.txt &&
> +	git add .gitignore &&
> +	git commit -m "add ignore" &&
> +
> +	echo after >ignored.txt &&
> +	git stash push --no-overwrite-ignore &&
> +
> +	test_path_is_file ignored.txt &&
> +	grep after ignored.txt

I think another good step would be to verify that `git stash push
--overwrite-ignore` _would_ cause us to overwrite the file.

I guess this test only happens to work because the first option
takes precedence over the ambiguous second one?

Patrick
