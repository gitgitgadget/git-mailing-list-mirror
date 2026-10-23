Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737652;
	b=JHdt/nQlELixk4KPZReplQKCorIclplYuWwSWFbF4yi2lnyGfN3RV040J0XGdqSYwW8b
	 F/+o6QK/3rn+tbygjyVn+WFjv/5phPvwW+nDiF4dscM/vwNpFU3zOMhdSC7n0+yk1/pyb
	 85KaOGW/6vHN12xjz3T7vTbR4vX2xJ0Im6WmaY1SXJU3PMCdb35xoFkUBBmjdh4PrIGl8
	 KmuG8NRD8tD/ME2T0q79v1kDHkXiTHqydjeBwkctRjKr6XNPMRpRe/9SfMaaTeoezxJhm
	 H2xHwzd1UpkLBH92vwV4LNRs4/cffmqYHEMjeYmZDctUcRvXwAP0RzmuLaQ32VD7C+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737652;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ue8e6xakKP1I/HbAmp0wtDbkZVoWcDXbIA9zm7470oA=;
	b=5b4bT9lUp4ypi/u100BF5XHKyenlizrnwd9IhUirm8fXU4lLvWyGdmOVjUiT7N9gYuhm
	 a6GGUUzpsH5eO2huMtkN8HFOudOm2SJFpzkXVJi24g0irrQAa7g/5GQMCNonc8W83PV4i
	 3FPkytXNEiAzAMemf45JoC1VOMUYNh8GF2Z7oHCL1uz63uYOX61UgfknKNCVItFMGz3zS
	 GIQkSNaPVGq5UtEca3Y5j4kjpKq4LQWDrzKzj+LuwA4t5F91BwvUVrY7aT6i16DzPqIpc
	 dwUgdIOTv7eaL3mdxnQ/StWycH5YLDzGXTG6RhLq5l5J9oIMnjpYFmfsZANLEXcFTVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=asFKMdz6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U5Izwvln;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB169606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB169606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=asFKMdz6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U5Izwvln
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C3A2EC01E5
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:40:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 02:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792737651; x=1792824051; bh=Ue8e6xakKP
	1I/HbAmp0wtDbkZVoWcDXbIA9zm7470oA=; b=asFKMdz6z/TSrAzgOcnBAHTlr6
	rOMGnRTh5+YRv76bkCt0uH2qYzad6aHnf2wl6SGvzpYHmRWrVS8TH9IZ1uEzL4n8
	uAapjil6HbN0ACFHalR+rITQ0F5sBqHDrBZY4bXg73HDiKKSEAqZVCaG6P7n3Azp
	JRxVgIHciKlM3mGQInWEhWo2y1ShRp2jqknXgF9BDTLCKheO57ArX+EnBLAoCUIM
	esV0DMypc8Y63FAFQeVpgMnv45RuGhI8nnRGxGo5Um3jHUjy3IldFWnj/jiTq0sI
	lOIm3antO9Z1wezxeMB+9LuO5RyZjExFhQDh+XhFbh0OEfDgLNvXOntlXz0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792737651; x=1792824051; bh=Ue8e6xakKP1I/HbAmp0wtDbkZVoWcDXbIA9
	zm7470oA=; b=U5IzwvlnJooaT7Lopzg69IFjehSNfrMQOZUQ8iKa87vUpR2LE5A
	/8vOQr6FxpOukBM0uaNOD4cA+VFRuwQ0cHEMUvcYs3GpnP0EUXfEX/4ITQZKxO2F
	fjndj1Mb7p6wFMErzN0Wxeyi/RWud8PTTYLc+9yfD24VLdP5GBIjRtUDHayYqSFp
	tEmcFn7gIuUWgRxuvajqJDp8f1D0gw+SBPdi5DKSnrMQgRHbiTuu1m4JxIXg+pcU
	ZS/digLWFsipTKEXqmHQ5SkdqkgfVBqVGJNPTWR2ZgZplqraabqQq+0aKK338yPc
	ajXuMFnfkaWoXoW2K/V3wMlCMOsNBBwpEhQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792737651; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BSAXBC0BBkInSWnSWZu0w5dA+kRdjG158P9T+EawxlYpIZl
	PxkaXsC9MJmmKbUIJzzwOQ+/bMiXU87wJuZdsryO7jTNZesRtVbcOm4aw84M3imh
	wnQDrcgg+l6ItV//DCtdQ172Idb8F0vZFyOT9QjhcXlPf2zwtzgfga2c3qB2yGvq
	LHKcS1wTciZvNDDdfd9NrbAb4Q0Qb/3mZOhTUCFy4iwbDEW6mECw/6fNHQQn5xp8
	SLxcBOu6y7ia0koBiCJ2S8M+oJNsZjrlIqh4+mK/GrVV1oLhiY/srFIv/idu04gp
	RbcMFQO2FUodVkzfd0HjYIPLPFBFBGba2YqbiFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xy9JNnM0wVALzYCMu9NcrGIE27a/nfMSzoBxjZHr9Z8=:BAdU9tnWIC97aWMtYfKFhlc0C5prDKUHmbPWDsJ5njA=;
X-ME-Sender: <xms:cgHbahYbzntXXchYLZs-yVaTToBy66uH7I79B1li3-t0HEQ76YAaJA>
    <xme:cgHbavQyjAoYImL4t9SCwZnA0Cg0U2yiUBWLoPLsRvACO0E08lhkZdh21zk7Yr-Yo
    _aR5rJbTr5iPIhPwK-JvIjIgh-Hag_xya9DBT_zCDTtGRcKuFTwqpI>
X-ME-Received: <xmr:cgHbasR8e6dWrBM08HjG01jSBJkkSKg_MPN9DDO8vdgUzp7nQjPltRFnGIR1i0HfkwfrOw>
X-ME-Proxy-Cause: dmFkZTFWIo+Hf2el9CPPHsKI8kpOqhJkc58ghWLkDoXX22YiG4iYj3f2/Y4mxkxVFN8EJq
    N3XFxrapauVQsgYAZiW2C4hDQkcjz87emXKBj29o7E667bk9rj7AL1uQhhZHGgPxpPnxCL
    JSe397oqegouPQJShJbg07EajzmOuT6uJVuboJ0cc8DDHigXZcXhFCt/Yv6CgpNN/X48at
    gnR3w/u6qsjxHCGY4pJzCedbWB4fx93jErKcLSvlYNRSDug64wWuqj2LO6obnF3169902D
    HWtXPtlJZ77Blk51eLTMrN1TLzwSB/acxuUv7KZJ8l9okDVH7Xp5GMJ7qWCQhQOkL938M0
    ngMRC/Cpr6f6kSU5/6E9UGnlLngifQ+OyDZjos/34ulZMhL4HW49C5BfWnKhtpTpWkrHnh
    WJuxNGia1weuYQL1L4Ml0iYhFN4NvpishZYTwspu4c6V8ZUIFPGGA3ESAvhR1McDTuVp+M
    nk9+GuJmavnNUNm53BsOiDPXTcyvHMCzOWL6FETPkyc4W/Krjfg5UQ//QX1R8MbYfFD+T2
    FrievGL5pz179CVkRtLqf3frW9+BqVv82E7LFskJ2Z+s7pFw4WgIEiNw4JofIhb/S9ffNn
    eI17EzN9btRnn6s2x8aZpJUwr0JGiSSggTGY22u81+i4j8OWeug5gTmiJQuA
X-ME-Proxy: <xmx:cgHbarRh_cOSp1NsDArTGH1Xc45rotz2AECiIliE0VqPgdg48PqBDw>
    <xmx:cgHbap4OsHeXom_QGFE1aQoYLALFkOooM1SGpsHTWpAtTAr_KU549w>
    <xmx:cgHbav2GvKQpjWNuEbgBsaat_KkmD2a_3oE2VA3Pd_vnT4uTb_Ys7w>
    <xmx:cgHbasAPArMdBxRdB6F8sKM9q3ZVWucwufwm_EhvQiUeELENUlcTww>
    <xmx:cwHbanxfXyoXATktq08pTP4NQi9nK6GWU17stvTEEjECxbn-qkemXFmk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 02:40:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00619df7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 06:40:47 +0000 (UTC)
Date: Fri, 23 Oct 2026 08:40:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4] fetch: advertise fetched refs when backfilling tags
Message-ID: <atsBbPi_EuhRdNmo@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com>

on thu, oct 22, 2026 at 11:00:16pm +0200, karthik nayak wrote:
> In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
> fetch code was modified to use batched updates to provide a good
> performance improvement. Batched updates are used both for the fetched
> references and to backfill tags.
> 
> When using batched updates, the references aren't yet committed to disk
> when we start backfilling tags. For shallow fetches, the negotiation
> phase while backfilling tags does not advertise the newly fetched refs.
> This can cause the server to send objects the client already has.
> 
> The issue always existed when the '--atomic' flag was used, as both the
> regular ref updates and the tags need to be part of the same
> transaction.
> 
> Fix this by advertising the already fetched refs as 'haves' during the
> negotiation. Do this by simply adding the tips to the transport's
> `negotiation_include_tips` field. This also fixes the issue for
> `--atomic` fetches since it follows the same route.

Okay. Would the client have advertised _all_ its local references to the
server before the batch updates? And with the new logic, would we now
start to advertise all of them? Mostly trying to figure out whether
there is a potential change in behaviour here where we may now advertise
millions of haves whereas we previously didn't.

And even if that was the case it _may_ be the right thing to do. I
mostly just want to see this discussed in the commit message :)

> Add three tests, two which validates that the 'haves' are filled when
> backfilling tags for atomic and non-atomic flows. The third, to test
> that upstream is still set and tags are backfilled even if a sibling ref
> is rejected.

The third test is curious. Does it have anything to do with the fix
itself? If not, why add it now?

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2decc6cfd..9867e8c2ef 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1697,9 +1699,30 @@ static int backfill_tags(struct display_state *display_state,
>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>  	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>  	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
> +
> +	/*
> +	 * References fetched before the tag backfill aren't yet committed
> +	 * to disk, so negotiation cannot discover them. Advertise them to
> +	 * the server, so that it does not re-send objects we already have.
> +	 */
> +	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
> +		struct oid_array **include_tips =
> +			&transport->smart_options->negotiation_include_tips;
> +		if (!*include_tips)
> +			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
> +		for (size_t i = 0; i < fetched_tips->nr; i++)
> +			oid_array_append(*include_tips, &fetched_tips->oid[i]);
> +	}

Curious. Why don't we have `struct oid_array` as a local variable and
then simply `transport->smart_options->negotiation_include_tips =
&extra_tips`?

>  	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
>  					 fetch_head, config, display_array);
>  
> +	if (to_free) {
> +		oid_array_clear(to_free);
> +		free(to_free);
> +		transport->smart_options->negotiation_include_tips = NULL;
> +	}

This could then become unconditional.

> @@ -2077,6 +2100,17 @@ static int do_fetch(struct transport *transport,
>  
>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
>  		if (tags_ref_map) {
> +			struct oid_array fetched_tips = OID_ARRAY_INIT;
> +			struct ref *rm;

This is just the loop variable, so it could move into the loop.

> +			/*
> +			 * Collect the tips we just fetched so the tag backfill
> +			 * can advertise them to the server as 'haves'.
> +			 */
> +			for (rm = ref_map; rm; rm = rm->next)
> +				if (!is_null_oid(&rm->old_oid))
> +					oid_array_append(&fetched_tips, &rm->old_oid);

Makes sense.

Overall this version looks much saner to me, thanks!

Patrick
