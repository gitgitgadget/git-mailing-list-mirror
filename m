Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014847;
	b=fizlpZelsX9N0DR8WqxvPJXnYWDk5fJyWlyCWy9+3Z3u4HnSwyErbnwQsEEAUtaIq1r+
	 xFISp+ZW0CRhycIqzdxHi7YUqgcMwOvQjTD+KN9Ax/XPKJiZV0L0hHo8+ovPYcnnDyH9c
	 nlAECLoMZDKV2Smm+BCVwTuiTfpf2545lpLoujdO8Vs9wdMpYRGe4XJ3oGKnokrPwvoNq
	 J5YXNLYmejc4ZvWRztnXiNQZzP4l8f8INsmBx4mz5gLKrTrZ9GKQAqHIZlp5EAiTUzzhH
	 UFdyelDs7QaMY2Q6YvHOxkm0L71P7w6nC1dPbBeOWSCTgi5Kr7PVVIzkfyQpoyTDWIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014847;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=alkvDoEpJoAUxSBqaED+IC2JNsOEFjbRa7rB7U+IxeY=;
	b=y3ITpvBQYC5g7BIZNGYw+0Yu/rO9QtcJ/fG3cE48tNLj0hcu4v9xalUnR46CLaaiyM/a
	 upAftuSDu/xy8VBVHxUYXv4lJ/EFtn2asNiMFm6Oeq6/wliBAt7o+BDUupLJJ717NMlkd
	 HyEykdQKiE/C0H1Ki/AScO3UO9Gymaa40d9gSOVwfBfqQ1vEdzbJA+6K1HjN3SUtoKqXg
	 qS5cSOCjOtByuHgGOU14YxzhjabndCRflCPUqRIbwcT+ZvrJHO5yc+Eugec4iCYns9rpZ
	 ZyiGF/FP/pDgBd2QvNSZFn2UTxbam3pV9jIsz/r6Ob9NtMg7S/yUfsqz/7t0vHGkHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ivKpXX8a;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PKBSdxfr;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D2606A335
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2D2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ivKpXX8a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PKBSdxfr
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62E8B7A01E8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:40:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 Oct 2026 07:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793014845; x=1793101245; bh=alkvDoEpJo
	AUxSBqaED+IC2JNsOEFjbRa7rB7U+IxeY=; b=ivKpXX8aiKdB7FDwFWpYViR4Fm
	X7YBYZJXkrTLnRDhbXsAgRT9qFv8p/Olm+GpF78I+8XQ4bUFcKo7A/NqrWCiAFDx
	1noCC3CsSCv723we6wtS+dUx0r/JAmXRAYe1b/Ir4GbgXNh8vIutmQZoUVYgiI1R
	VmM7b5iN5Yygs8IGNb4wpp8d2w1rhSsoHkls63ZWNr+HLyjVvTYCLH1S/0nyCcFM
	Nm+4E/m4TCv8j0x/LFzHvNRGMPYmUzpTDq7zVIFUzLOa9ulWLsoYmmeQ7mOwkhLY
	SZM1juRWh/ACfz9V5XeKdp9O1YnYi4p219qkghaR7zPos3V5svtiSn2Vgo4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793014845; x=1793101245; bh=alkvDoEpJoAUxSBqaED+IC2JNsOEFjbRa7r
	B7U+IxeY=; b=PKBSdxfrGyeTq5xujRkFgedS3Pvzf3Ujy3vrqZW9b7mLu+atlIa
	jncy6KKsxR2aW1DLy8kBnp4Zpa/S1QJYyzxLOkNh2tGJNmTiCB54xjxXygHJjSzf
	PaZu9BUzAem9500bT0kYr4LN0xqgPcdNwO+EDnBL9RDMkPnv6hl/ELsGXYJrFwUQ
	y0BXortWGGLxfew13ae/Pax4qiKOn+RqnPhMkRHWWqY0JvffAKgEuftLFLNyvI0A
	HWgPRMFmjMc5ZcK1m0r9w1qReEh2r6/0LpNINRpW+DjslnBQTpN0/qHNPIAxLggr
	r+2MdBGKwDL7jAD+XmmrjoqqeM090czozWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793014845; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:crbRBiHYRG2NbJquEQyjASqfnAcs/C1YiXAdMXSghazgz/Y
	d7YVJVnRNFRpsBvH22FX4F25Wm0GC8gW6JyxTT5qn20lLHl3mPtmkOlKk8jrjvZy
	yJCg9Z+fzQXQFOmcyQoI7Ik+X4swjRZI94voFGyIsoi0B8f+g94gBDnH/GQm4ILQ
	nmRCwfcK3RSFBiGeWikh2flit/bBA4e5926moc7rZpymg+yL+5BtopvmRQ99B4gA
	kl/9M6yKO261ERdJpJadlN4qEsE7Tat70TstNlNcA0oKZ51i5p+T0Tpicv+9P52w
	xmE2TCGhhu/8gCD6NMQGZBWKRQf6EbeNeUAGr8w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4hAXl8P2B2VRLdU6JNE5za3h/HDnsiz0HibuYZTS3zo=:VMliWIXmqNEBJiWHuhR2a4vHiVY/RHSYidGc808JFAs=;
X-ME-Sender: <xms:PTzfalHJhysOEvBlY2AJMsQMggdvvCwkF7r5AfGwvN-bZFLn59bxJg>
    <xme:PTzfahU-ir9KPTwGVdlYImp3YrC77tRneL0CQK8jUYpVSK79vFe4I_t2szjBiRXWO
    3Y3XgDP7fgfCB_dGIYUGR_IpN2EmSs62nE3XjYqDJfHn2_x6yzn>
X-ME-Received: <xmr:PTzfasJa6aCvwBhsEfCyKPgLxjYv9-K_yPwr_X993yvHne3Bg3fzzg>
X-ME-Proxy-Cause: dmFkZTFUYTnEwqY/fiRr9OSbbToSv0xIEDyo9jDJjiSiBVX4KrBZ77Q5++boexAnGRovbR
    AJMIffHMnN0o39lsjgbE95tiyFYQVCZgacV2u+vDpFRVrqAQy/WD7NHUqSp//VHlE7LEeN
    +vmobniRm7TRjX5eI0GtHFWCGQacnT54J2bKKifx4U4YMNFIb6pBB6ieEEf3o0G/M9RK9J
    GTb5ZCNJAuFsE/tIJatf/OqHFexboVeQjHmhZkNyvgVutyifCTVRjE12uIJPfVs3PATRuO
    IWfirGg8YVfiCKxyv+S7L+gQbWesD4w87f4io0pmP3ovh2G4X1zbWUg92DWpAWyQhtzSMc
    s/YcTPreBVpuBuJbyRQFfnvNpTkWgtX0Ow6zKkH+XfLI01IuneGtliBmX3Ju3EAeiRUgyz
    nZw8TvuwbnvD4cNx4TVx02yebcj6XhaYdCOgPDHTCgQzG6dgsAK20YhBNRQJwldFkcLI+U
    Wr7/VnlbJFbvU/5FAdy6cXZyq6ZQevclqRffbb4vFMD/hppgVR1h13+GwhkbHhatiCib2g
    Ar4nAvdDMa28/veLBKemCm80XOuXAkZMt3xVpjDqMfDonhUu5PE+ofs5syv8GyleKsJIge
    IS+kyHzpOP9Q+HLGjN7a/S5H6OFqKgKwRLeh2ZxI5v//9xap7BLA7IkuDRCQ
X-ME-Proxy: <xmx:PTzfap_-3erG_6qecJbd5aF2YSYcs-GFnIULwsw06Ti7ruu8HPbzjA>
    <xmx:PTzfanJ5Hb2vX1QpdHc7kz_5NQ6MO-NxZ8pBFQYqbTGklbD64KttFA>
    <xmx:PTzfamlvVyAQ58PC4aa4_tM0tjygMDH_xJ2kfhjwkwNCVK7TptvkIA>
    <xmx:PTzfajPZCZ41pHyN0VzQOeSlSVuq1gkj0edLpYcRIFiSRU1UBxGcZA>
    <xmx:PTzfar6C4QxjPhxnFgtKHnzpLu39ro2Cl58ZjQGEwkUrqc61EOWhOZQe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:40:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38cd0dbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:40:44 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:40:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] log: speed up --follow following renames for
 non-linear history
Message-ID: <at88ORA5midZJctp@pks.im>
References: <cover.1792701579.git.vmiklos@collabora.com>
 <6f249099cf214f83d31bc04980bc2e9dfd861bba.1792701579.git.vmiklos@collabora.com>
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
In-Reply-To: <6f249099cf214f83d31bc04980bc2e9dfd861bba.1792701579.git.vmiklos@collabora.com>

On Thu, Oct 22, 2026 at 10:47:06PM +0200, Miklos Vajna wrote:
> diff --git a/log-tree.c b/log-tree.c
> index c5ac6c2bcb..d5ce58d91d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1153,6 +1169,29 @@ void release_follow_pathspec_slab(struct rev_info *opt)
>  	FREE_AND_NULL(opt->follow_pathspec_slab);
>  }
>  
> +/*
> + * When the path in a merge is the same as in 'same', does the path still need
> + * renames to be followed in 'parent'? Only if the merge has the path, 'parent'
> + * doesn't have it, but its fork point with 'same' had it, e.g. 'parent'
> + * renamed the path.
> + */
> +static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
> +				struct commit *same, const char *path)
> +{
> +	struct commit_list *bases = NULL, *base;
> +	int ret = 0;
> +
> +	if (commit_has_path(opt, parent, path) ||
> +	    !commit_has_path(opt, same, path))
> +		return 0;

Doesn't this miss the reverse case where we have the path in "parent",
but not in "same"? So basically this test case, which is very similar to
the one you already added to 4219:

test_expect_success 'setup merge keeping the renamed path, other side edited the old one' '
	git init keep-renamed &&
	printf "line 1\nline 2\nline 3\nline 4\nline 5\n" >keep-renamed/F &&
	git -C keep-renamed add F &&
	test_tick &&
	git -C keep-renamed commit -m "O: add F" &&
	git -C keep-renamed branch B &&
	git -C keep-renamed mv F G &&
	test_tick &&
	git -C keep-renamed commit -m "A1: rename F to G on master" &&

	git -C keep-renamed checkout B &&
	printf "line 1\nline 2\nline 3\nline 4 T\nline 5\n" >keep-renamed/F &&
	test_tick &&
	git -C keep-renamed commit -am "B2: update F on B" &&

	git -C keep-renamed checkout master &&
	test_tick &&
	git -C keep-renamed merge -s ours -m "M: merge B, keep G, drop F" B
'

test_expect_success '--follow follows an edit on the side the merge did not take' '
	git -C keep-renamed log --follow --pretty=tformat:%s G >actual &&
	cat >expect <<-\EOF &&
	B2: update F on B
	A1: rename F to G on master
	O: add F
	EOF
	test_cmp expect actual
'

That test passes with HEAD~, but fails with HEAD.

Patrick
