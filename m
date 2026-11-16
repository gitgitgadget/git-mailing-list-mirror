Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862440;
	b=XDl92KBbi7z9QazXJQfkJlzAvurhKDFJ8MebsRr9pByFSiI7F+xMxo5vw8GIfeO+aG0/
	 hPfypp1YWULpKGemb5D3j9i7tATJwkZCikrN8NI9Z6AZhOSMJ+4SnbuGtOLuMDZQ4MH+z
	 vBVcmhFSuRhL6Ni2QbQg61KoodK9bOKx6grpsQbvxHgYg3MStXXJMwhCOJClTYdpYKd0N
	 LwmOT5/wzP9r97swln9Pyo3It7FEtUG4HqD7Q549SKSNsuD7Hr20qGZET15wPXpBeGfmH
	 eNQjH5Y70mTkLEZTLmNnS1csr8cuGkOAQJ1SvK/VNzq/JlrSbZWErSXgQMfxVX2/j5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862440;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EegpANW5/G0ADTZWhyYvw1D77zjFfi1nq5NOQgfKoe4=;
	b=SlyFbVfu/YfUfRZuwoqbGzgvwWGjAcl+NgH7JgSpik9IP2N+mRzCmnCxzigHHSsvUDk7
	 OPOne44rEvmh8CrgB4kLx2RCTRre15UKaSnWyw9PhxKBn8BJ0UNsYUhs6YJZAY1j8wKyD
	 VKkCTzNtml/49n0KobosbRD2I3p0PcboD+mRSgZIR35sr0Ym1F/zmMgZGye+NQuTK/aeb
	 zM2HPACa8u8cSOVcjtiyEtfOXuDA6r0I2vI6Okz3vrjqpeZrbh8T4MgB6IjB0KbPV5AP7
	 PxjQrxhHY04cRHRYPPxlstfZDwOHaJveLGROGVk0i5Pgf5/h35mm+zmkBzWB6wxVSvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="nQvco/Cc";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3hs6Pj0m;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B67606A8BC
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B67606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nQvco/Cc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3hs6Pj0m
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 815901400041
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 15:53:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 15:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794862438; x=1794948838; bh=EegpANW5/G
	0ADTZWhyYvw1D77zjFfi1nq5NOQgfKoe4=; b=nQvco/CcL9GxL7AulFdnVp9S4Z
	Yt5xASt4ZXmAkVrCHCS+iFP2c1DpKL3lrs3tJxG3QRTYHfX8KZ18pft9G40BxDXh
	gNPZcn33pkQ6jroxwksKWYVwsaKof1x4B9wgUz74ak/17dW1qp01T2UrpGJjqS8m
	m7Infl468tJ6NOL4NFg/52njE0Bu5Y+XcLvuDHL50BKfFnNzlqqkOSK1lrWEoA7Y
	MzkSmNSGlmi+zusmTLlzZasgBzVnoBojAQ0LwA8D485rg3c+b9CplWXXVmeHh4O2
	RzGbz6pfUcEsl63KCPNEyVvUYcqEU1JFwDgYMycYGlYUOofNkhyoQDSj/W6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794862438; x=1794948838; bh=EegpANW5/G0ADTZWhyYvw1D77zjFfi1nq5N
	OQgfKoe4=; b=3hs6Pj0mbgtXJPywaEycgcAAxX9PjX5Fx+DndVoVUq7m8oGOxhS
	3lwDVmOOXeYzYbgwVgrCFaGaTwS6WTnxNIb+jj9DbNo/B1LvrC+k6wFUOdzGqflq
	MKXbaTQFJEZoKOmMGU4D02PAVe0Lxau7fXUIucX4BcInAUbEiAvuzTgy/+cLcDaS
	PrtjBsYpfGdH+U3xzIrpb+OZz5Oj2oCoEvartVcVI6uwoNP+Q4RAdmR5srMi4vqb
	wADyB2AhZZWsmo7+2HxneQ7Szxz/LjIoc+DhyQZK3ygnGpLRZKtak3DeCzcrqaOY
	h7AdDoY2IW1M7Z2+3/+/PAB5jkGZDXrmqoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794862438; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ILStx8zOgPa7TdeAwANszrAdSVhFyYr5XUO+H2X2m6Sgxsv
	heCWS2ZhPZvwaxLYDkh/FGx95J/uQwR6OBSmxL3zHcQ75yifZN42GrscNBlsyk2D
	WO1vPI2SBbJS5Nap7V2eDFbW0sR0tPrArzGGPx5xNdqnWYun6Wo758bE1qGzYHXH
	uYNEr7d/OfUwoQbQ4LxuP5sdXiAAA41Gu/qXguCp+aHxe0ffJcWpuyZ2J8KpcKhB
	A7lVs/vwxM3q6u6fEUBKuuXvMOo4kVdZmM4pP+fmnu4tMxrgsjphCSpxR/r/GjfX
	goXwftm5/XmKDG9atT7p/D82pLPH5tqp+ptmS6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bXOa2syH5uwdvF54sYY8xhUywE1pGCihPEtfegf3psk=:q06PxG2J3PYpEm6ynDRo6Hhk/SIvtO1GgZ0SoNqbuzA=;
X-ME-Sender: <xms:Zm37aoI-FQB62r0Guh3dEqkHEK_4Gff3UD-m9HAUZk3rFZnCN2PPQQ>
    <xme:Zm37avlg3iybLmBZ69XBIbY44C0uUKyah8eg5SSB6ec5ZBzpa8ERRVgcrCbjFdXtz
    TtFN6pT60m9yDSKet3xjksowTgWx0z4xERXeeF6VLqo-8C-he4D7A>
X-ME-Received: <xmr:Zm37amEI2W1y3G4eX88hkAH81IbvkVrWodV1JD1G1QpoLbfcUyHkqw-vXjqG_MzSljZXqYfCWHNNXe_BqWuFYsq2xqy-qzDqnokg>
X-ME-Proxy-Cause: dmFkZTEA17c5g17b5neaJRBVUoMTvYITCpekv141fO6t0Mb34PkO8ZSfF18Ww2Ce2kS8Bn
    GNkStx87yR42ZDwn9eP6ghvoYPozwHXDcfpe2uWcHu2OdyTPX2sXeqaDPlZVJteFzhAClM
    vvQYeoGf5/+/MJT+0PXPqavK9BYg6sVOIciEo6vY7Zp1NfYn0GwhInocPS06w4uL+fqR+l
    tqf1Bx1zMUQDImZkWKfvBBFNXOKbXvWAPGclA/VKYx7KaSDijolvSu56754ydHTpB2nfoO
    r06ZU0N37gc0HbR7KVlxHcL5rdi7Pt6siHWoxxHKXJC9+FUN0SWPIv83Sy3hpRZI7ki1F5
    tsCIQ7Fo66eb2VrhqPQl5WQICa5CZSr6Xdlh0zGZ5jiCCs9ZMOidiE6RGUGyKUuwfgqtiU
    28cgQrHlhKQgQnJ70JrkINzCSUFblseK7qmQpPp+rPVBNnsvcOU88PhR2JCsek2p68vL/l
    svmCztWtRbmkVg0spkAR32APiqVUvaORHw0/hVhQY59vWJawcDs3GwQlc9BcKZwTkmBFbB
    JSg5X5CTTVLHzb7r//hqD9XUbGDKwlaymazbeNOgzVF1H18invagR5QFsYli/wIfRUDFxL
    LtcUwz8a9JlqGeRwprhR9jw+tWLk/hD54S9K5kGuBefXNLypCzDmukQ9hVGA
X-ME-Proxy: <xmx:Zm37avE6JoOXOAv_4R4ZU24AnE2DiHBlNVCnb9EHhTmPxCXqi_WLdg>
    <xmx:Zm37ajMaye7cBMt_XyqYL7uHVwBQV5k320Xi9D_wBEqsK82WMVM_YA>
    <xmx:Zm37auF6v8TK1sQFLus7TRXLzxPC_zfWHijOo0Aj65bomAUMBB15dQ>
    <xmx:Zm37aqOBLKEyb7vDR4R2VaER1Q3v00Lar5rhG95kV60s4HaVilRrdA>
    <xmx:Zm37anu_YuC6UAsxpYH7ASyV1yA4D_PWxhyi-iIMfDkCZmvLP2ImP4_V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 15:53:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] commit-graph: simplify linking commit graph chains
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-1-a83fc1ff0808@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Nov 2026 14:07:37 +0100")
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
	<20261116-pks-odb-pluggable-commit-graphs-v1-1-a83fc1ff0808@pks.im>
Date: Mon, 16 Nov 2026 12:53:56 -0800
Message-ID: <xmqqqzgkjy57.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> When we load a commit graph chain we verify for every layer that the
> hash of the base commit graph matches what the current tip has in its
> base graphs chunk. To do so we pass both the chain itself as well as the
> array of object IDs that we have read from the commit-graph chain file
> to `add_graph_to_chain()`.
>
> But the array of object IDs is redundant information: we have already
> loaded and linked the base layers, and as part of that we have stored
> their respective hashes in the structure itself. Consequently, we can
> already derive the hashes by walking the chain of base layers.
>
> Refactor the function to only take the new tip and base layers as input
> and derive all the other information ad-hoc and make the function
> public. This prepares for a subsequent commit, where we are about to
> move the logic that creates commit graph chains into the object database
> backend.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit-graph.c | 52 ++++++++++++++++++++++++----------------------------
>  commit-graph.h |  8 ++++++++
>  2 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index da65cd3deb9..94c761907a0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -575,50 +575,48 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
>  	}
>  }
>  
> -static int add_graph_to_chain(struct commit_graph *g,
> -			      struct commit_graph *chain,
> -			      struct object_id *oids,
> -			      int n)
> +int commit_graph_link_base(struct commit_graph *g,
> +			   struct commit_graph *base)

Nice simplification, I guess.

>  {
> -	struct commit_graph *cur_g = chain;
> +	struct commit_graph *layer;
> +	size_t n = 0;
> +
> +	for (layer = base; layer; layer = layer->base_graph)
> +		n++;

We chase the pointers to count the number of layers.  We no longer
count in signed int, which is probably a big plus in the sanitation
department.

>  	if (n && !g->chunk_base_graphs) {
>  		warning(_("commit-graph has no base graphs chunk"));
> -		return 0;
> +		return -1;
>  	}

It might be obvious when reading (and writing) this patch, but it is
a welcome change to standardize on "0 means happy" convention.
Should the fact that we now use more common error reporting
convention be mentioned in the log message?

>  	if (g->chunk_base_graphs_size / g->hash_algo->rawsz < n) {
>  		warning(_("commit-graph base graphs chunk is too small"));
> -		return 0;
> +		return -1;
>  	}
>  
> -	while (n) {
> +	for (layer = base; layer; layer = layer->base_graph) {
>  		n--;
> -
> -		if (!cur_g ||
> -		    !oideq(&oids[n], &cur_g->oid) ||
> -		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
> +		if (!hasheq(layer->oid.hash,
> +			    g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
>  			    g->hash_algo)) {

We no longer check cur_g->oid is what we expect, because we lost the
array that holds the value to compare.  Would this make cur_g->oid a
write-only member that is only computed and written but never used
other than reporting purposes?  In commit-graph.c before this step,
I think this is the only place that reads ->oid for purposes other
than passing it to diagnostics like die/warn.

We seem to still be making sure in load_commit_graph_chain_fd_st()
that the line we read into local oid there is a hash, so perhaps it
is possible to validate g->oid against this oid after we load g?

> @@ -682,7 +679,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
>  			free(graph_name);
>  
>  			if (g) {
> -				if (add_graph_to_chain(g, graph_chain, oids, i)) {
> +				if (!commit_graph_link_base(g, graph_chain)) {
>  					graph_chain = g;
>  					valid = 1;
>  				} else {

> +
> +/*
> + * Link the commit graph layer `g` on top of the chain `base`. `base` may be
> + * NULL if `g` is the root of a new chain. Returns 0 on success, a negative
> + * error code otherwise.
> + */
> +int commit_graph_link_base(struct commit_graph *g,
> +			   struct commit_graph *base);
>  struct commit_graph *read_commit_graph_one(struct repository *repo,
>  					   const char *dir);
