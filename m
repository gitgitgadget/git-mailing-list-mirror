Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217216;
	b=3HLkOlbF6e2PTn9m6nRKR0HpETcTkNTMs+qYhloFosYsxGGrGS9GeX4X8PD5Qx90x0Ml
	 lIF4wRTM7wCNeeBo1iptT8NTx+mJk7rqPoPPSVDjQT51Fc0M169Tiej8sn8ywygqtzS+M
	 V6ej/tGLwXDCBbfefuZJsavZuJSZv2EGyG57rQoyViYvDqjFybngjx02awhCmzW3T2FNe
	 FPJrh5PU5IbKyIvmxQ12S19Ewkrip+J1RYhIsWmVH03J0sZhS7wzWJPBDVUh1xOvbRGnD
	 wpNeH+znPCftu+oxrnQKSgsoKDh2iwynV89xOSowyI+DbrpwwJrrDJWwHu/X22d5r3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217216;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4kgkfScrd8vkSq8TF81/TfmsensuMBcAMWdal0Zwwco=;
	b=fZP3UgDsMOQiTnz+Tz5OLV96abs6sxrKpZJUnb5ox/YooKlH1NSxNIEe6Oc0aLgLD5GT
	 WEQy8h0r2fcvYDDLYORfgFckU5gK4AZhlQCY2jJfPuMhRM4CsuPxNIJqwnOMgk/m5BvYv
	 5e3ApYulVbt5uIPvfrkp+hPubb1BrFo4EbCf5g9yvdmVCnnXApegpElaL9Dj3EXQwEYSZ
	 vpCQmauyY1lgFgmZsCFxYbFV0nvH/5SPFY+OEl4nV7Zit7zefKhIyATIPOJIk61pQwrC6
	 Uda4hZUZKdiQKMTkd2IQBDpyNQfr2XXkoLJLaLOZSJyDzkAvL/B2DlwM+NdjYh1fphg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vYBS2JQB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="JVy+d/uY";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F9606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 379F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vYBS2JQB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JVy+d/uY
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 480801D0016B
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:40:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 04:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794217215; x=1794303615; bh=4kgkfScrd8
	vkSq8TF81/TfmsensuMBcAMWdal0Zwwco=; b=vYBS2JQBtxkeLO94+w4bKVPG/8
	oDiZ/JWfowhhedTjlK7azRUM8oIWhLeWkfabh+T8oUnduuSaU5amUZ4H/qaJbl8a
	8P7aXNZTdPy2qFD5Zwa2AOpdugjgJonLB7RYC9HWGY41rMIz0FIl/Sw1FCJ6W0Yu
	6eEDPsRF5ngDxSGKALKO8ukjUXMX2FFJLKIO9/yqL8NUl5LPc6QWPKq6TyW0wYsv
	Jt3wS9nAMmp0bRUkt6FPWEPb8a5nr8ngMUSJzGHA1eWA6/aFiBloFSk8+n55lE3y
	XRlmwV5EwvMzFkX/PnOoNousyUYVUKeDK144bpvbg8dJgDXoTlw4umLFGVTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794217215; x=1794303615; bh=4kgkfScrd8vkSq8TF81/TfmsensuMBcAMWd
	al0Zwwco=; b=JVy+d/uYSoLGRQhSVj62s/WqNUlr0HLEs9vm336men4VMxq5EQJ
	q7uUO54mDoSRvJcZdSWdP7I1mtjXPGFCnusqjz+Fnn3UfcCcpiO41YUuqmClVKIc
	08w4IKZFfXz4RPkDc3HqDHT2pwMTF23+l9EizjZfri6sZ6aa2Tg0+UMhIyG7pDxc
	p+RU5YS3xabh0z0WcXZuZP00VL0Zi/WbW6bF5KA4rT6NuHwZKLu1sRFtK1tqM/zT
	Uj+roq22OBnsfQkHCfIWoszAP8FR7ms/XAlBfBEkk/qt73MHOoOfWunL+jmHkqQi
	dMKi+LsOfZze+/YG16iOCYkLAgbGzT4JKdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794217215; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:l1b5iJ2RX7AD80ksuXx4QkJG8l7wfRo3cjcUGO9U+tfpGXY
	Hgmyd80yle4hfRTJiq/Rp3nl4BRhPuIW6N/B67dnvkQuGwrlA36P5gHRe0R8Pd0v
	SX9c/RvLexT1xd3POWQAaz9fvZFDx9YAp50ePX90XX+zeqftvYGtNaXIHu/eq9U3
	dxf0yuQVWNvlixVJXnGKAO38bYRT045RhewkwnjPV5d8UgGBISP6p1CIj8sPafMj
	nY0shDaEDryzUV+yl+BWK9vIF6nEB48dgtet3Eb+OzDI6HqGHpjHcYJrlTb3Oq4Q
	OyyMi1Ri3YUhC/zED/FyU4yv2Zty4Q3dT30l5kQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QeS+VSZJglNvI6c/jR3jhoY0nvu7BPBVtcfWjJV0JOg=:pj8QjFAKWpE3ASJhyA4P+qBoHVFCLHlMihY6L9U/hhc=;
X-ME-Sender: <xms:_5TxarFL83uTKaSi6926bUjxqPU3p1Lazu9wZDvUTDZ4bN7EucmljQ>
    <xme:_5TxavMm8bzElDtBT6vhPr8dlmB6QOS6_4YoU20cwqs4vkOz_LkYhDxylDDtw-sWo
    1eNVGxTpYWXMQJIWVXJqrEhol6RUGI_618-LwX1MoP9w53QzVGPNg>
X-ME-Received: <xmr:_5Txald6wmAf3o2YQ_yZny2ZBz7T5ryPiCmsuKFnOdNeLbNYxJ5OzDzsPHbAv2rMj58eI5o>
X-ME-Proxy-Cause: dmFkZTFehMgRQ4phUOoatJaPTDs60ffiqP0zx6OARdOneq6ztQHDvdSKbAvxoOT+iFAgGb
    iSksQBBZbZ7poZNLJDlKF/JWMEQ0DaExwSU/y0fs9CE64tbanl6vLs70MdSRkBx7IHsXdv
    xqnjkyTmFHhMrF1gaERU91lr2lsU+n6imNjxtrgvOvQhh8ydy3/9lRSuURbf1qdiQwbjYL
    PIDfhd+4pFcUmAXgorJW6RnOsjzLQNfgYG5W3Zukx57uYvympvx8OybMnMsUD6GUFY1bDY
    9BDjEuyX91572mrms4JVVT3bQVRDcqBFWKpV7UwK5FI16AP0WAm2KFKoLSLLwWM/aYj8SQ
    rEthB8e6syYA9aLuk84L9NelOB+tHoKMbmBQ0K0mgXuk7Q346i/u+SS6bKTsQQfLfoh+bB
    IwM+ROaODZFovNAGLpyqMnVKw94oXAAEUMVGVaI8sZaWFvWsyjUwW56l6gO8Do7ojIBe0m
    PWzDsPc+I+4lxBEoGG5YhGuV1leIj11pynFl7ZG+B3plL/8yW3gGx2FoINL0JZfKpgiFnL
    pBaqWC0LMAX00MxjAMn8NfYNoKLjXwzzVVEP0KydT2gnSwGdULR5x5NW6abxviCrQgybii
    1FgMZm7yg5qky5JDwH0p0H1SMS38nIWsLMn8cstkFeboKi6Y0wWegYAOpQUg
X-ME-Proxy: <xmx:_5TxaktrjaxicSH6GofsVdqrtAHLXJ2CbPnHI6P3OZ4FO3ZWNk2aFg>
    <xmx:_5TxaunN1a4sIdnJB3KYSXF_XC5OqXvzqehBPVC5LVxPUm1a_zAGyw>
    <xmx:_5Txauxb0GyGLEJ9HiDFTW_SSyI392wfjc_yjEKSFPNqaSf66p2FPA>
    <xmx:_5TxaoNzFkM7GFWKllQfDQ6-ENSNkMY1XzIC1jB4NePrR6ZU6ny5qQ>
    <xmx:_5Txavm2iyX7qdngGBkXF77eDzsfsELuiGEsMsYXxU4gyTXe7FwfIe3L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:40:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a88e5d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:40:12 +0000 (UTC)
Date: Mon, 9 Nov 2026 10:40:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] builtin/reflog: expire --all and named refs in one loop
Message-ID: <avGU-Wjkd821PLc0@pks.im>
References: <20261108012213.89468-1-laveeshb@laveeshbansal.com>
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
In-Reply-To: <20261108012213.89468-1-laveeshb@laveeshbansal.com>

On Sat, Nov 07, 2026 at 05:22:13PM -0800, Laveesh Bansal wrote:
> "git reflog expire" sets up the call to refs_reflog_expire() twice,
> once for --all and once for refs named on the command line.
> d1536ac3e2 (builtin/reflog: say "would prune" for named refs with
> --dry-run, 2026-10-23) fixed the named-ref copy, which was missing
> dry_run. Junio suggested a single loop in the review of that fix [1].

We don't typically refer to suggestions in our commit messages like
this. You should instead explain what the underlying issue is in your
own words and why that issue should be fixed so that readers can read
this message without having to hunt for context in other mailing list
threads.

That being said, it can be useful to refer to this mail after the "---"
line or additional context.

> Collect the refs from both sources into one list and expire them in a
> single loop. The names given on the command line are still looked up
> in that loop, so the output and the exit status stay the same.

You say what you do, but you don't say why you do it or what it buys us.

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 49e5453dd9..42d37a3724 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -259,44 +259,42 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
>  					     collect_reflog, &collected);
>  		}
>  		free_worktrees(worktrees);
> -
> -		for_each_string_list_item(item, &collected.reflogs) {
> -			struct expire_reflog_policy_cb cb = {
> -				.opts = opts,
> -				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
> -			};
> -
> -			reflog_expire_options_set_refname(&cb.opts,  item->string);
> -			status |= refs_reflog_expire(get_main_ref_store(the_repository),
> -						     item->string, flags,
> -						     reflog_expiry_prepare,
> -						     should_prune_fn,
> -						     reflog_expiry_cleanup,
> -						     &cb);
> -		}
> -		string_list_clear(&collected.reflogs, 0);
>  	}
>  
> +	/* util marks the names that still have to be looked up */
>  	for (i = 0; i < argc; i++) {
> -		char *ref;
> +		item = string_list_append(&collected.reflogs, argv[i]);
> +		item->util = (void *)1;
> +	}

Okay, so instead of carrying the logic around `refs_reflog_expire()`
twice you instead now first gather all reflog names that we want to
expire, and then we do that in a single step. That seems like a useful
simplification to me.

One thing I wonder though: now that we first gather reflog names, can't
we also easily deduplicate them? For example if the same reflog name was
given multiple times on the command line, or in case the reflog is
included both via a command line argument and via "--all".

So I wonder whether we should both sort and deduplicate entries here.

> +	for_each_string_list_item(item, &collected.reflogs) {
>  		struct expire_reflog_policy_cb cb = {
>  			.opts = opts,
>  			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
>  		};
> -
> -		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
> -			status |= error(_("reflog could not be found: '%s'"), argv[i]);
> +		const char *refname = item->string;
> +		char *ref = NULL;
> +
> +		if (item->util &&
> +		    !repo_dwim_log(the_repository, item->string,
> +				   strlen(item->string), NULL, &ref)) {
> +			status |= error(_("reflog could not be found: '%s'"),
> +					item->string);
>  			continue;
>  		}
> -		reflog_expire_options_set_refname(&cb.opts, ref);
> +		if (ref)
> +			refname = ref;

Okay, we only apply per-reflog options in the case where the reflog name
was explicitly specified by the user, becaues only in that case do we
call `repo_dwim_log()`. This retains the status quo, but now that one
sees this single loop it makes you wonder whether that's a sensible
thing to do.

Patrick
