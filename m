Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613923;
	b=OVcbVA8dWWslFJ5rWIWUYs5WUkTNDsqc6spysVr5KxEsOnSPeev6AtvtkyIr0IXRlx2i
	 SPHrk80MxlojHE44qP4cUuNLscRFYVhRNCaF470ml0szFkGwCqTBdUB2VXisJc/Nb97Jz
	 60lCuChhVjhpGjgoKnnAorqjzBkTUHheHOuMncF0m/9A71v+s4ru8AjTRiaqH3KNJqKPa
	 dB+gt5LcL64+700Ge/gKyRJ5vsTDhUPShOHzeXszdTCSapfbKzapCcREs8ikyQihjCUIV
	 5wh7GlMpW39h+9kLYDcpw61iGth/59JIYHsKZauhTB81y8Ija7eYUn3xTwSy7E+1E8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613923;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Yw0h72g3YWy+tEYPxghDKlsjLIedKMP7EeMshX4nbMg=;
	b=Q7uYkNvbA/xQcCp9e9U+2pMyK6w8Kom5rN9C0dCfA/XjSTZkHsSQuAlfeLHgeUiBnRb4
	 0n6U5CH1bb5IpNR0PSxJqreo7TOREiGtuMZGI64dLGGWq39h1kOVZEY1uUxEr7VwClQg5
	 9egAiyRlkoIrzMBJawg2zJQN/L+t4Cvel0a6kebtfruwGsRHlXL8Vwp2FNgA0JZ5XX+Mh
	 oIMj7HYC6Y5pYz0xBEFVCMUi4CKmwbQ0l76nhZXZmUaPR+DSL+pw9VaHjdb487UiKtv0B
	 71ZRyCg5K8PV7dDjopUg0C7lOK46dxyhqDFznJrw9YbiwruG3w2gK7sPNcPsqB8aaOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=j0DWFKX9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RuZe2kv3;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3251606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 20:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3251606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=j0DWFKX9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RuZe2kv3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24EBE7A0078
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:18:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 16:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792613921; x=1792700321; bh=Yw0h72g3YW
	y+tEYPxghDKlsjLIedKMP7EeMshX4nbMg=; b=j0DWFKX9jovaQBWQqUknDqsVFo
	o9tfJlujk9UOqd1bSXmZwj660rahAUuD8YLf1JDiGx6b4GJ2TVXR8v0A9EHSl1FC
	KBRwxMemdoghqVbG+oI/U5G0XFkkW7HFXGsuiOE9d7EK87ClhPzZsE+TjAuieKYG
	0r++TkgjhFuhuf9bN/K3041PnsVODTouNhuaeUi6An8EpVnXLVMxIlL2AP6hsOQz
	Ps1nbBARnmPRnShlMl/4PBTevQWthIT7DHyvwM6q1ZY7quqA4aC7MwBPkH0OxwXS
	LDK4csiD2KvNnxccvRzz5gpSMUSPcc5Didz/dPRLMNxRhbzf82PhhpVJyVSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792613921; x=1792700321; bh=Yw0h72g3YWy+tEYPxghDKlsjLIedKMP7EeM
	shX4nbMg=; b=RuZe2kv36T6rlHPnXyctzMUX1j3XCOXY+3kgejSqkZQ2VyLHJqp
	aty11blNSWfKyGno4xulzeqNxxWG/CZVqsYGRHecxmS1JcCFzQnCpdTlUMazLco3
	EQfOYcyFMfxIhHtHM4mAJAHPLHPZkrxmzkpCokGz3rHHPSSA4ZJtrmM8L8cch7q2
	qbZp7Yt6OZG4tNitemusBjWuYl4/gxbxLeLIts0i7mxQu9KX+Jq4v2i6ga9EQ7gU
	x2Vuk/53fkHPjTzFVpxuPKI4zntRTcJcJSIG85HGbES0qTIBL/2I/2mToDQSjvsN
	kL+tBC5Uu9TaPaEnqEuCEIZwDYbFE9PcNDg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792613921; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LcsUR30oikTZQPnJpPRC6ybKcUb0JeC+r0twBi+fS6u9HIJ
	RbHo5FhHELHP9AuXfpzbKIKBq+eDZSASEz4SQ8sEET5VdMPRwRZLcCQSYwWDWul/
	f33kJs7nUKbwefFaZkdnH5PMTilcwIpAizzFZnftOApbAIxjl3yvCQx2N/oqVPiD
	nyi74KlgSjTQUwAPVpJwwO1Fo47WQVx2+c5UMUfaiUoIdE2L+169RR66YClRP3cJ
	1vOFBA4NYscvJmiAC/M13mx+QVnl0qcZunMHWat/13M+njdyki/rSylVGPQwuktC
	t/Ok5Ty+Jh9UIsdfIfAtwHHdccJDgJ7fYOgZsVg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Jl9vZiD/05i15wV9RhXVpfpQ4Cw9Q124GcB4djbJ53I=:8U1NgVZsdLk4j9R7ikeuq/+Exa0B6knKdcWcVhS1lxI=;
X-ME-Sender: <xms:IR7Zalywg8U0CTSJltKUv53j4rwhvXCNdSpl7T-utOmPTJk7N5rbMA>
    <xme:IR7ZasKlgeHxovsSjYs7gepi_hdyl9t94aVO9YGkmFe4ChVMZb-6J_qn2gIB8KaGc
    ihW97KuW7vwmY2S7EymEkOKVz2eU2-Am-eKDS0LqH4CS4GfxMAp6XOD>
X-ME-Received: <xmr:IR7ZanpyCi21brFuUUKXDKtfxEAU_JYEYpG0ke4lHuitrjshOtdUza9WaA-3KTJKXmO1Oc1KeLIpuC0HD9q4tRjZN7XIYYcBUYhe>
X-ME-Proxy-Cause: dmFkZTGAV5hwNSnBDgHygtKv5oZreUvvZLkdHGpJwd04qmFrxDSJQv9Z/gCHNcPTN7xacP
    zKiXYb2UvK9fkJqopQ+N1eMiyVZ0EKXyumLSoq9GaSPOHGglRZE5HEtlNfBY26BgctLMrj
    WLCWIhMZKQrsF1HsuP/P+/LNdi8Y+ZivAJ3kx6051EIOCVIz8xXlo4PwOGfxB4uGLE5RoK
    004EEt6vA8L/tISSx9xjqqNqI+B2oQ54YNgsFY/vW38/nP6R2w9vgN1e/KQpjOwNO4JT9i
    Ga5eKuaecqmaqsjBsrRTVRyYrzJTp+QIbaaj0fR6KX3GfqRbE8RcPR2zwaFN7Jb4gGabH4
    CgGNZHUsRtxDR6ag1k6qeqTKuHY+E3kpNY8olpXky3ckwer6CNWjfHAN91n2AOctlUI0UQ
    42kEyUypq5VU+4MApRgaUOk6ZGEkqQztA9OwUmpoTfHEpcLKKyuYOypIJ1Knli0xvTW3mT
    /ukkPChzskapKmlwGbI2W/be5c25j/+BqjpFarl9LXcLG2iaJO81jOxuf5cj7jwAvuU5i7
    wEseC18hpcWKWvGduzRgaHmgn2zBHBCE3ONPhORRSDIwCrtNgxQVon+ypWTSKp7IR+MQGK
    ocL3SuITP/O65b9gMdk6ysoKGnkpNrjdvbtr1aZeneNYlsPZ8dFvEieySSHA
X-ME-Proxy: <xmx:IR7ZajKEZWqKhlB8OVoRIINhYLcdqv5oq6TA1qQjTYdwSHVbkg9qIg>
    <xmx:IR7ZakTyK_FoJeGndWX_bR3q6EyZXw1tm8fXhryEo4CaPdcwIOQY2Q>
    <xmx:IR7ZaquYC36l2to1Xvpr-xQXPfezr97OSbTxm2tycI6Qxd_fxZAk2g>
    <xmx:IR7Zatbq9nNLAlRJoND2jfpfyIK36ZeRd2alGVKU0RrhbJWvHZaaaw>
    <xmx:IR7ZalKj3IGS3f5yps6hc7STYUsnUl7_rhsxiwEBqJ3bIW-mC1syUfx_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 16:18:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 5/6] connected: add incremental connectivity check
 via rev-list
In-Reply-To: <d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Wed, 21 Oct 2026
	11:22:23 +0000")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
	<d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 13:18:40 -0700
Message-ID: <xmqqecdin6xr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -static void parse_connectivity_check(struct repository *repo UNUSED,
> +static void parse_connectivity_check(struct repository *repo,
>  				     const char *arg,
>  				     struct connectivity_check *check)
>  {
>  	if (!strcmp(arg, "full"))
>  		check->mode = CONNECTIVITY_CHECK_FULL;
> +	else if (!strcmp(arg, "incremental"))
> +		check->mode = CONNECTIVITY_CHECK_INCREMENTAL;
>  	else
>  		die(_("unknown --connectivity-check mode '%s'"), arg);
> +
> +	if (check->mode != CONNECTIVITY_CHECK_FULL)
> +		repo->fetch_if_missing = 0;
>  }

This assumes that everybody that is different from full want to
avoid lazy fetching.  It may be true right now as you have only full
and incremental, but it somehow feels like a trap waiting to bite
future developers.

> @@ -992,6 +999,29 @@ int cmd_rev_list(int argc,
>  
>  	prepare_maximal_independent(&revs);
>  
> +	/*
> +	 * Without a boundary of negative revisions, as in a clone or a
> +	 * push into an empty repository, every incoming commit is new.
> +	 * The incremental check would still work, but it would verify
> +	 * the whole object graph like the full check, with extra
> +	 * per-commit overhead on top, so use the full check.
> +	 */
> +	if (!revs.limited)
> +		connectivity_check.mode = CONNECTIVITY_CHECK_FULL;
> +
> +	if (connectivity_check.mode == CONNECTIVITY_CHECK_INCREMENTAL) {
> +		struct commit *commit;
> +		struct commit_list *new_commits = NULL;
> +
> +		while ((commit = get_revision(&revs)) != NULL)
> +			commit_list_insert(commit, &new_commits);
> +
> +		if (verify_commits_incremental(repo, &new_commits,
> +					       revs.exclude_promisor_objects))
> +			die(_("connectivity check failed"));
> +		commit_list_free(new_commits);
> +	}
> +

We only call verify_commits_incremental() when check.mode says INCREMENTAL,
which makes sense.

> +static int verify_blob(struct repository *repo,
> +		       const struct object_id *oid,
> +		       struct verify_state *vs)
> +{
> +	int type;
> +
> +	if (oidset_contains(&vs->trusted_blobs, oid))
> +		return 0;
> +
> +	vs->blobs_checked++;
> +	type = odb_read_object_info(repo->objects, oid, NULL);

I wonder if this needs to be _extended() kind that passes a flag bit
to avoid fetching from promisors.  repo->fetch_if_missing that is
set does prevent lazy fetching, but I wonder if it is better to be
more explicit.

> +int verify_commits_incremental(struct repository *repo,
> +			       struct commit_list **commits,
> +			       int exclude_promisor_objects)
> +{
> +	struct verify_state vs = { 0 };
> +	struct commit_list *iter;
> +	unsigned nr_before;
> +	int ret = 0;
> +
> +	if (repo->fetch_if_missing)
> +		BUG("verify_commits_incremental must not be called "
> +		    "with fetch_if_missing set");

And we make sure that the caller flipped the bit before they decide
to call us, which makes sense.

