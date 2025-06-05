Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C54A0C
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113257; cv=none; b=i41I+zFC4Ny45BLLEcqVyKVTaIhgRAoWKszbZQFEeS/yrq8WIsVr5ZPvz56AbyhNANSm+M8tSHKs1nl5tTdUPY89LqJA3E8DXLWM68vMDwsTdW1JLn5WfL4mL64bRxheVrUJHFCCUbkTs1+y2g8Izo/KXx++FMP3JGOd+8XmiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113257; c=relaxed/simple;
	bh=+EZptT7YtpnjsYLOTGA3ciril1FUvuKlv3FhVq5hBP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzxMO22s3+vvECjcGqtBbJFCveA0bDaNP3wbhkF5u+VOfRCHZ2zejuU76NuuaiPrCr9sKOyDsEmRIDPcCBfKm5seOcUx+AtlUA0aA5CcnzNyAaGvlnQhKI54fI/gwoS9VyZ+sSF5TSfwt7kC6I6fXFrMx0OgaOsAfWma3Zbnl00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LgUPNJU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6IV4Ajx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LgUPNJU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6IV4Ajx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E04911400F6;
	Thu,  5 Jun 2025 04:47:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 05 Jun 2025 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749113254; x=1749199654; bh=4ne6Lt/1rk
	2Q+8x1Sy/I7kK7lXa37GhECluq8XZ9A+E=; b=LgUPNJU/LVRFuB0Z7EG3vzf5EH
	qV4Hai+lxM2xCQ4rtgApvC2LknIyRnRoBoenNdH4Smk7V7u95rx3c/CXiDPM7GZ1
	R7XttGbxJQIk892V0F5iAhgQ4F8w9Mvq/QmyBYj/VD7eK0QXSlLVjRk/M9GQLud0
	89JhS+NF2uWL5VlZ+39V5nggwrrTTi8sHhJEKI4y9NaOHghCBA9xLDAxUAE9v8sb
	rflZdq0mAWVPb/0L3G0aFEbn6qgiJ3UVsO7tRDRMP8YSryLniT8Ij9+0YdG5MLer
	8PltO31UD76F3EDohpBFjYs6eHLRSHHUV/9PBtP7ZXidXqgeuOE5D8zTeDoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749113254; x=1749199654; bh=4ne6Lt/1rk2Q+8x1Sy/I7kK7lXa37GhEClu
	q8XZ9A+E=; b=P6IV4AjxnONG0EPGNwNd7cbJVtGcivKv+I7FTz8kGYNayZ99GRR
	xuwRGjDUAzql6goUhxLZH9a7AN9h+srZPxf1JZJ6aBT1tpIKr7OBWKzfGhCr6Suv
	C0/HZciLEif9sVgS82o1XEewcI4zbZruXNstsZoq7rpuAi43uqcWDB4hsdCJOnFM
	KhBSExet+mADfTManc3Bg01CKT9HSqLI197e5/BmlWopFIuAyD4nW5vAVWfGiDKv
	bH0jsqUuMF9eiZXVPG83NM3fYIRRe0evNixKbEy/BR4MzS+65QA5SuMbt8fWBC+D
	7ky1hKsa/k5OVkdXKtNOSDFt0e9nNy/MyNA==
X-ME-Sender: <xms:pVlBaNjFvuMcvRQtvlT4A5lEqx76BNITOtIqVEQWh80ZM5p2xpXqkQ>
    <xme:pVlBaCBpEFlGQJxW5GcdZhEFLM1k4_zSfxhbtuRKNW1KjnFvJmMquIdD2NP_a7PYq
    6CVjnIdLutkDikGZQ>
X-ME-Received: <xmr:pVlBaNHaT0sMF3lo_aiR8_wgN2-NL_mpMLCdSYB8QiYCVAtohNMoVw0IbziTwvgnvQyYckZoFTDSPGHErobdtn2NoBNeOOZ0-tH1bxGwpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefgedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:pVlBaCRdJwsVvVwGp53yd87D_QD3Iy1A5eCEnyZaJmSNlu912rhDjQ>
    <xmx:pVlBaKzE5G5YC7JRVWdc-bt3LVlm1pMXvneSBHyFH7nJE3p_yEKldw>
    <xmx:pVlBaI7hkLegRDm2HKoyDg3FaspVc6U0xHmL1P8L7pypF_0AcJuXeQ>
    <xmx:pVlBaPwu29gfwCUj8VSk8B_e5bkvk44M_pF85Wx16TgLOrjCWfIs5w>
    <xmx:pllBaATrFZTUyN-IUkvVjOV-wLO3VY4CpQ94KhMZp3lywB0YDJxjpzYk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 04:47:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ddf40e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 08:47:30 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:47:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com,
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] receive-pack: handle reference deletions
 separately
Message-ID: <aEFZnmjoxjopv2xF@pks.im>
References: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
 <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-2-26cd05b8a79e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-2-26cd05b8a79e@gmail.com>

On Thu, Jun 05, 2025 at 10:19:55AM +0200, Karthik Nayak wrote:
> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
> we updated the 'git-receive-pack(1)' command to use batched reference
> updates. One edge case which was missed during this implementation was
> when a user pushes multiple branches such as:
> 
>   delete refs/heads/branch/conflict
>   create refs/heads/branch
> 
> Before using batched updates, the references would be applied
> sequentially and hence no conflicts would arise. With batched updates,
> while the first update applies, the second fails due to F/D conflict. A
> similar issue was present in 'git-fetch(1)' and was fixed by using
> separating out reference pruning into a separate transaction. Apply a
> similar mechanism for 'git-receive-pack(1)' and separate out reference
> deletions into its own batch.
> 
> This means 'git-receive-pack(1)' will now use exactly two transactions,
> whereas before using batched updates it would use _at least_ two
> transactions. So using batched updates is the still the better option.

s/the still the/still the/

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9e3cfb85cf..34db4377ca 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1867,47 +1867,66 @@ static void execute_commands_non_atomic(struct command *commands,
>  	const char *reported_error = NULL;
>  	struct strmap failed_refs = STRMAP_INIT;
>  
> -	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> -						  REF_TRANSACTION_ALLOW_FAILURE, &err);
> -	if (!transaction) {
> -		rp_error("%s", err.buf);
> -		strbuf_reset(&err);
> -		reported_error = "transaction failed to start";
> -		goto failure;
> -	}
> +	/*
> +	 * Reference updates, where F/D conflicts shouldn't arise due to
> +	 * one reference being deleted, while the other being created
> +	 * are treated as conflicts in batched updates. This is because
> +	 * we don't do conflict resolution inside a transaction. To
> +	 * mitigate this, delete references in a separate batch.
> +	 */
> +	enum processing_phase {
> +		PHASE_DELETIONS,
> +		PHASE_OTHERS
> +	};
>  
> -	for (cmd = commands; cmd; cmd = cmd->next) {
> -		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
> -			continue;
> +	for (int phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {

s/int/enum processing_phase/

Doesn't make any difference, but it feels a bit cleaner.

> +		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +							  REF_TRANSACTION_ALLOW_FAILURE, &err);
> +		if (!transaction) {
> +			rp_error("%s", err.buf);
> +			strbuf_reset(&err);
> +			reported_error = "transaction failed to s1tart";
> +			goto failure;
> +		}

So if the transaction doesn't contain any deletions we'd now commit an
empty transaction. The same is true the other way round, in case there
are only deletions. Do we maybe want to skip phases when there is no
match? Ideally, we wouldn't even be starting a transaction.

We could for example skip forward to the first command that we would
have to queue. If there is no such command we continue the loop, if
there is we can remember that command, begin the transaction and start
queueing from there.

> @@ -2024,6 +2043,9 @@ static void execute_commands(struct command *commands,
>  	/*
>  	 * If there is no command ready to run, should return directly to destroy
>  	 * temporary data in the quarantine area.
> +	 *
> +	 * Check if any reference deletions exist, these are batched together in
> +	 * a separate transaction to avoid F/D conflicts with other updates.
>  	 */

Is this comment still accurate?

>  	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
>  		; /* nothing */
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index d91dd3a3b5..b2aaa1908f 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -119,6 +119,8 @@ test_expect_success 'interleaving hook calls succeed' '
>  	EOF
>  
>  	cat >expect <<-EOF &&
> +		hooks/reference-transaction prepared
> +		hooks/reference-transaction committed

Yeah, this shows the empty commits indeed.

Patrick
