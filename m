Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217132D876B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885245; cv=none; b=p2T7oOiPqaWpxm1/AM6jAs9DflPytK5QnyLzBFEO5iJdaNrUyXxXyhZoZTyr1NFHPZfH/wg4bHKXpDcKGDjUtrm33ckubSd8cNrvg4I2JycDiqN+4X8RZTb1w+YdEEHJA7mFwoVVP5d+cV0j3lGAPyHWOZ1gnQLrIAMj5V9aR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885245; c=relaxed/simple;
	bh=6LcLB8d6C7/uoVDGJVlbr6D0vhTum1iz/LxEEV442iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfWuXar8Mutq03gkE4/VfQQ4LHYCOL4YhxgiGRwgJJ1ikSQNZe799pXv22/cyzW8/VH9pERFe0BWrhhmDXQlAHJBmVln7XNVazLGwewGM17YcCBudgTEKDUT30ALyojFTV+OYlNd1MwSwMST9k4F3g4+qg1loxjZm8tVkX4Pa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tc9JAkeC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CaLE/XuG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tc9JAkeC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CaLE/XuG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4161BEC02FF;
	Wed,  3 Sep 2025 03:40:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Sep 2025 03:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756885242; x=1756971642; bh=ImRRTkorb/
	4/zKoBiJcaXqDdBRjPSebVLWVSZrl4/P8=; b=Tc9JAkeCFkb9mnLbL2zagJ9Szo
	2wp4AetEUkU9k3m7vdBeWfyqScId/YxF2CNVAzDOmHmpMSd1cL2TT1HmtfxwJQEJ
	mX/iGrpzFb2H0L/fWqaLu74fAktcbk+5NZVWHo3Wpqhx8mTW/vAu/ZLyKj0LRAMO
	v1iK7PMRXNOH3W+S8aP762rZL32KmILdaNXmKk0TJ5/XrT54IRGRyBJKRN+8oaLD
	5KwSMaA8vx+J+c5WKhKCCfJcPcombo07lqZfFdneHlKo2rsAEJWH9jcTqYpos7ln
	kqih6BZwZnT6nVr2v0czpILb9uKEfD52ouBEcvymGHnIRGPYEQWhh+BbWPzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756885242; x=1756971642; bh=ImRRTkorb/4/zKoBiJcaXqDdBRjPSebVLWV
	SZrl4/P8=; b=CaLE/XuGs1eWLOJin7sgnRop1JH+dup7CqKY0J4rbvEYnxv55sW
	aOcjWgsXbMvA+g+MeTq8z4AAGGseXO8Uoci6IaNoPeHeKuXiqTBJlzLWxYK3Ofz0
	3rBHr16c+/udRX9pJYTW2xjF6vTHCeqyDYgnJH1VjtNpZ3fUf2vgRp2gKJhNw9vt
	hak0aC87R9cgA9Y4TZRX1dUPwuw/3K66vUg6nTs+Vyhp9ykpKe5ghg22oK1Wmdql
	DyRajf5RsVB42SoWrBRwpCSAXsCAnf5Nm/IPovHvbP64Ghvngfn3cwTyVRyExLgA
	hhGNHshzDqglAuk7j3vZ5+nlOkMFTi+Krew==
X-ME-Sender: <xms:-fC3aG6ZqeUSD7wNJxQqbMW_mlHJ27Y7N9bS65dF6V2d-Vc-e2hpTw>
    <xme:-fC3aLa6iaFrAPBBwoDexia7KnTcPrfs_9g3fn2YQxspA0kABdwp_M_SEiimvgN1f
    QHRA549vQLuzzkoIQ>
X-ME-Received: <xmr:-fC3aL4tzf6z_RJLtu1OEsTnZOHv4M04eLE1_yScIVHT1KpPNF-kijQAxlJKEp7tCVOjKq_w6mV521buXSWJLPyJYfuLMIVn6DXu-Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhovg
    drughrvgifsehinhguvgigvgigtghhrghnghgvrdgtohhm
X-ME-Proxy: <xmx:-fC3aODqsvhTXsdzK3NKCxstufjCK2SeojlQSnNyOQB-NF_xPinBUg>
    <xmx:-fC3aBebr20y4U2qNuNwMKbnG-mGQeE8b4qNFvxqd9X0UxW926HA4Q>
    <xmx:-fC3aNL6iLp2ETRaayc5tnvMcys_NgD1jPKV9sjy0-u1raDnZpbJIg>
    <xmx:-fC3aM24tMosWGe8G_WzMObNhWf_hCOadUe-GbsKvHHoYlSzBmC2yQ>
    <xmx:-vC3aGMBw9OHcWmYnRJa5oFcZoy7GUeikT10_8JDaqeoMLOpA3mUxRDo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 03:40:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e622e6f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 07:40:39 +0000 (UTC)
Date: Wed, 3 Sep 2025 09:40:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH 1/2] refs/files: use correct error type when locking fails
Message-ID: <aLfw8xiys53A-azC@pks.im>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>

On Tue, Sep 02, 2025 at 10:34:25AM +0200, Karthik Nayak wrote:
> During the 'prepare' phase of reference transaction in the files
> backend, we create the lock files for references to be created. When
> using batched updates on case-insensitive filesystems, the transactions
> would be aborted if there are conflicting names such as:
> 
>   refs/heads/Foo
>   refs/heads/foo
> 
> This affects all commands which were migrated to use batched updates in
> Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
> that, references updates would be applied serially with one transaction

s/references/reference/

> used per update. When users fetched multiple references on
> case-insensitive systems, subsequent references would simply overwrite
> any earlier references. So when fetching:
> 
>   refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
>   refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
> 
> The user would simply end up with:
> 
>   refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
> 
> This is buggy behavior since the user is never intimated about the
> overrides performed and missing references. Nevertheless, the user is
> left with a working repository with a subset of the references. Since
> Git 2.51, in such situations fetches would simply fail without applying
> any references. Which is also buggy behavior and worse off since the
> user is left without any references.

Yup, agreed.

> The error is triggered in `lock_raw_ref()` where the files backend
> attempts to create a lock file. When a lock file already exists the
> function returns a 'REF_TRANSACTION_ERROR_GENERIC'. Change this to return
> 'REF_TRANSACTION_ERROR_CREATE_EXISTS' instead to aid the batched update
> mechanism to simply reject such errors.
> 
> This bubbles the error type up to `files_transaction_prepare()` which
> tries to lock each reference update. So if the locking fails, we check
> if the rejection type can be ignored, which is done by calling
> `ref_transaction_maybe_set_rejected()`.
> 
> As the error type is now 'REF_TRANSACTION_ERROR_CREATE_EXISTS', the
> specific reference update would simply be rejected, while other updates
> in the transaction would continue to be applied. This allows partial
> application of references in case-insensitive filesystems when fetching
> colliding references.

Okay. Does that mean that both git-fetch(1) and git-receive-pack(1) are
already told to evict unsuccessful updates? If so, this bit of info
should probably be added to the commit message to say that it was
already the intent, but that it didn't work out because of the
unexpected error type.

> While the earlier implementation allowed the last reference to be
> applied overriding the initial references, this change would allow the
> first reference to be applied while rejecting consequent collisions.
> This should be an OKAY compromise since with the files backend, there is

I don't quite get why we're shouting :) In any case I think the
compromise is acceptable, but we very much should warn the user about
this error. Ideally, we'd even guide them towards the reftable backend.
But let's read on, maybe you already do that.

> no scenario possible where we would retain all colliding references.
> 
> The change only affects batched updates since batched updates will
> reject individual updates with non-generic errors. So specifically this
> would only affect:
> 
>     1. git fetch
>     2. git receive-pack
>     3. git update-ref --batch-updates

Okay, here you mention that we already use batched updates for those
commands. I think it would help the reader if this was explained before
going into the individual error codes.

> Let's also be more pro-active and notify users on case-insensitive
> filesystems about such problems by providing a brief about the issue
> while also recommending using the reftable backend, which doesn't have
> the same issue.

And yup, you already do exactly what I was proposing. Nice!

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 24645c4653..9563abbe12 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>  
>  struct ref_rejection_data {
>  	int *retcode;
> -	int conflict_msg_shown;
> +	bool conflict_msg_shown;
> +	bool case_sensitive_msg_shown;
>  	const char *remote_name;
>  };
>  
> @@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
>  {
>  	struct ref_rejection_data *data = cb_data;
>  
> -	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
> +	if (err == REF_TRANSACTION_ERROR_CREATE_EXISTS && ignore_case &&
> +	    !data->case_sensitive_msg_shown) {
> +		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
> +			"trying to fetch from has references that only differ in casing. It\n"
> +			"is impossible to store such references with the 'files' backend. You\n"
> +			"can either accept this as-is, in which case you won't be able to\n"
> +			"store all remote references on disk. Or you can alternatively\n"
> +			"migrate your repository to use the 'reftable' backend with the\n"
> +			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
> +			"Please keep in mind that not all implementations of Git support this\n"
> +			"new format yet. So if you use tools other than Git to access this\n"
> +			"repository it may not be an option to migrate to reftables.\n"));

This reads familiar :)

> +		data->case_sensitive_msg_shown = true;
> +	} else if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT &&
> +		   !data->conflict_msg_shown) {
>  		error(_("some local refs could not be updated; try running\n"
>  			" 'git remote prune %s' to remove any old, conflicting "
>  			"branches"), data->remote_name);
> -		data->conflict_msg_shown = 1;
> +		data->conflict_msg_shown = true;
>  	} else {
>  		const char *reason = ref_transaction_error_msg(err);
>  
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 088b52c740..9f58ea4858 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -776,6 +776,8 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);
> +			if (myerr == EEXIST)
> +				ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>  			goto error_return;
>  		}
>  	}

This here is the actual bug fix that makes us treat the error
gracefully.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 96648a6e5d..e37a5d83e8 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -2294,6 +2294,30 @@ do
>  		)
>  	'
>  
> +	test_expect_success CASE_INSENSITIVE_FS,REFFILES "stdin $type batch-updates existing reference" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +
> +			format_command $type "create refs/heads/foo" "$head" >stdin &&
> +			format_command $type "create refs/heads/ref" "$old_head" >>stdin &&
> +			format_command $type "create refs/heads/Foo" "$old_head" >>stdin &&

These could be written as:

    {
        format_command $type "create refs/heads/foo" "$head" &&
        format_command $type "create refs/heads/ref" "$old_head" &&
        format_command $type "create refs/heads/Foo" "$old_head"
    } >stdin

> +			git update-ref $type --stdin --batch-updates <stdin >stdout &&
> +
> +			echo $head >expect &&
> +			git rev-parse refs/heads/foo >actual &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "reference already exists" stdout
> +		)
> +	'
> +
>  	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
>  		git init repo &&
>  		test_when_finished "rm -fr repo" &&

We could think about making these tests not depend on the REFFILES
prerequisite and then verify that with the reftable backend things work
as expected.

Patrick
