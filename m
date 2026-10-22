Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698551;
	b=mKvRxItc5jX/bqcvnNQPFjkyX7aYe400ykR32nilbn2iOeWVNx3xMqFp4onieGlqYD+s
	 yseTiHgRMbfTzCKdSHqZuNW1D/qQMpKGRAR8s6Hy5ZlRizQPBMvnE8xffJQ77VFK8eYLj
	 9WVcO2b1qs4pPetfRreucBXRUGyRH2FxnPMYAG3a1Ydyl5ji3vQeL3s0w4eRso7sEl88h
	 fESGTBSIUZafTputi8bdPWkg6Tfb4imMc8u1nvUYH6gSc7KQ0AMUdeBZ6aR4PR7mJ0yj8
	 ojz5urD9ygKm4uFsSETpVV3nLkioxpgn3XwCQL3t/OqVxz8wiUPajxWKvFYyqQhr6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698551;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4Cb8LJMJm+HGckkGFOTCNkCoBaxmgtxghaUEALchVk8=;
	b=ibxnwsjmMK3YoePzqsKAw5HQnmpBm040j+NmkMPAYslnjllLILG/7w9je8IjmPno65FR
	 Cq/ZoZCJS9B6tkfFmh6X9jaduyOnghr4s038jWjn7jdgg/xvwerMWnBUMdNYTLdVBdS6E
	 c3bEEovP+BgLs2YNlGW+8sruYoTAR9YJJLvPcM88oG0+rQ2ODUKtULXj1tkgM7YhP9g5g
	 5XUVdGogFSEEMx74C8eKL7saOkAB5duWvjuYpnj95BYt0iPgEL/kyrEjfr0dIOX/gg5Sw
	 9B45j7o1G14Kg4jWJsoCJ831rdr9ixMvc6c2jG7raNq0r0iRxwFSQ6b2CiEH9/MwR2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k9GteMFP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=B2ZSLFkW;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87628606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 19:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87628606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k9GteMFP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=B2ZSLFkW
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D0CEB1D001B7
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 15:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792698549; x=1792784949; bh=4Cb8LJMJm+
	HGckkGFOTCNkCoBaxmgtxghaUEALchVk8=; b=k9GteMFP6RAhgdBMYMSI71m/G9
	T6z0WeOL333+FNLsQn7lMRuZ26xcJnKpphZUw4l1EReZdHYN1WF8LPyB0tLbCv0J
	cOqz22XQYtHmt3duU4+ZnRbwEWSpTpQxrelEv3UIBac7/C7inhtAhBP0DW4G2ZBC
	7QTM2y2r5gTAD5aRBpNg4kRDnDKe1HZxbqq4dAd+4Dz4SwrPoVHmBqMAF3tEQ577
	QuTCOSp840ACwTPZO2pBlzVHtjA+NgwxL6hQ7Y9IgqoX7JFd05T+yfstGJ89haqu
	KGMVbHIxdwETmfqnpiC/xiDuYnuPyaIlejIYkTl9Ukr4sg6qnDHmfMZokuFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792698549; x=1792784949; bh=4Cb8LJMJm+HGckkGFOTCNkCoBaxmgtxghaU
	EALchVk8=; b=B2ZSLFkWzXtfn88+hpc2TiVfFIpSw99Hwwokh1YsPag6b3bcC7a
	Fj5KJmXGUO4IBekmd1KekMAbS73OSNX4kO+P37YZRZi2/6pLC+C3/3dDVCFwDctf
	atV/qDnAYaq/K6Ue8tYtDLZP3OM0KqWDT5U+9+h3BRtyWghDIeM7wcjwhKrNWrtc
	TQP40zllQrPkGZfz43RIX3VC4oMEUKLUeky/b2umx5z8h+w/+bNDjpsImCKwwCx8
	lxGQgIUwqIjE5YoD5TY0G2vCPaTw8tk7k9djWn40zrKBYcERCqi/N46slIuc0+xV
	T1erd2Oyi6vJJqBJeDLBltSpq+4Pj3AZ5dQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792698549; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UAW2xku+3NZo0no4LhxoFTLUPGksrRdoIwpRwWnzFzaEE5f
	TgDtqSRIgcBJRXIwg+LrkMfvQTX1OKjb25guJELUXII1OfesOBfNnws3qHL8frnn
	3tzOdf/GgIFW48+krs4fBqbrPx3U7ahkDwdzzeXgiS9YCNBKCLUf5pPWXyMRR4Tp
	+PWfzoJ+7f+fx9OhpDc90aXEjRTHf0Crpyh6BHQkHX2TSFx64D6YCTbjPRkY3cn9
	mDVDjMWbGoMOu2oYtzPVJJrthgCDF0SJALulcYOnIy3w7Z+it4kiok3Z5VzNCj+q
	qRNkUbL/eHj42adT/Dk1sgHmLyuDCGBIpsKNglg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CimdWzMfE5horUApvkC7UjoKAFqbWDiQQOngexS0Po0=:K3NRDt1hP4l4Xer9+hdLMmkiiXjI+LSux4Jdwe0ObKE=;
X-ME-Sender: <xms:tWjaamSUQDOV3VTTGb1rhiX8310RgFJsZ9ylcXPkYD-xdqawQU5yAA>
    <xme:tWjaaizHL78bha9JS8-WtWpeaifoqQeMy6PPSNhrkSuJCnrVWaHZiy4YW3ZsCBnN7
    T9ZkjmszFq2s93-3MTb_R31OWdDbeVHP11bKdabV7ggibg3oJJW0Hs>
X-ME-Received: <xmr:tWjaao1jw4Y0j9WJDLKSCNK0vlkVqrD1OmxJmpSgBjAlJGP8cYPvy2x2ubo_kH_61Cpy3amgH8hrWHvVRqvJCBZEC6ABXk-q7ksA>
X-ME-Proxy-Cause: dmFkZTEAaSve3Eesui2XgKMbokQ+PuIn6okuqfW6ysEvvLngf2NpqEr+owfj4Wo0U68DvF
    xTHgZz8jNi/nQgMfSkV0vIocD5lUjxvhW82LksguiuCfev0O1Rn2WbEKggglzYFsMRhkci
    whQ3KflCmkB0HjwIB6aoz2Zx7SOX6iea5cwYc9Ds058iJiEfVBb5mhTXc3NE9Jt1eRGD1k
    ID9HsV3Mh1vQny4nErXaHXoTXROGsxB5k1yJAQ7BQYLrrpTDZHD8CM745cbj0Lktuw6fdQ
    XD1PSCCxhl0djhwrObOMaMlQ8TgX71PTQAuE05wbn6NQnnb8+E1rhsi8cU9edH1wgLe2Vw
    XcdTD9IplD2oFyvxNWP97vDEV4jS3fB9gzC6CrRAOcU+Puu0d4RclgFZtjS5kOBgN0JACt
    WaXnNWZUNh/b0dJMjAWLQcg03XHvq4jqYWTCz0Sagl9/M6RCZEbDj8bp+Ik1DUzHBJjCo/
    CIyuJmQ0a7Ff8/vf6IO7a6GDt0SQ+gp+t889D28GmrxnFGdUOK+tiqxbQ8e91aW03vd/2k
    6hoO3yTxHaNHKuSfMCoutOGHkfWDYS+CqbwrO+3OEIgaKobgt511XavDy5uOavPuJ0P/jm
    OyfDYJv60khWP6XiCsYvG1Ekduy1TWyhGT9iQwSY1+BC7ePTWfh/ZByx2q2Q
X-ME-Proxy: <xmx:tWjaag4fvtFVzlvwjbVK3suIM_MY2VW9z2mkzklydXac5PBcq2xohA>
    <xmx:tWjaarUCA5DRg6uRJvR9QNrynAi7Tb9uf_fVkRjDSEk1xSE7-U1dmA>
    <xmx:tWjaavASKcmuwGTMbFASiMQX-VWBRSZP6HvPRus4Ux9bqD0BMh1gbQ>
    <xmx:tWjaaq7Dq6odb7DUq6KruHneqlVPqsa37dy1NYljGqm8cs5Xp9ngBw>
    <xmx:tWjaagWchBxphajNFaoI6eakuGsWRYKKWMU2vwuejLytRVWtoQYz--wl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 15:49:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ammaar Bakshi via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ammaar Bakshi <the.ammaar.ic@gmail.com>
Subject: Re: [PATCH] difftool: translate "combined diff formats" error message
In-Reply-To: <pull.2447.git.git.1792219239440.gitgitgadget@gmail.com> (Ammaar
	Bakshi via GitGitGadget's message of "Sat, 17 Oct 2026 06:40:39
	+0000")
References: <pull.2447.git.git.1792219239440.gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 12:49:07 -0700
Message-ID: <xmqqy0bpecss.fsf@gitster.g>
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

"Ammaar Bakshi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: AMMAAR-IC <the.ammaar.ic@gmail.com>
>
> The error shown when "git difftool --dir-diff" is given a combined
> diff format ('-c' or '--cc') is wrapped in N_(), which only marks the
> string for extraction by xgettext and does nothing at runtime. As the
> string is passed straight to die(), users always see it in English,
> even though it already has translations in the po files.
>
> Use _() instead, and adjust the indentation of the continuation lines
> to match.
>
> Signed-off-by: AMMAAR-IC <the.ammaar.ic@gmail.com>

The name that appears on the "From:" header in your email, "Ammaar
Bakshi <the.ammaar.ic@gmail.com>", somehow looks more real than the
handle-looking "AMMAAR-IC".

Please consult Documentation/SubmittingPatches and specifically look
for [[dco]] and [[real-name]].

The patch text may look like an improvement but without a proper
authorship and sign-off, we cannot use the change in our project.

Thanks.

> ---
>     difftool: translate "combined diff formats" error message
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2447%2FAmmaarBakshi%2Fdifftool-i18n-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2447/AmmaarBakshi/difftool-i18n-v1
> Pull-Request: https://github.com/git/git/pull/2447
>
>  builtin/difftool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index bc7b2ea443..13b3d3ce47 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -450,9 +450,9 @@ static int run_dir_diff(struct repository *repo,
>  		const char *src_path, *dst_path;
>  
>  		if (starts_with(info.buf, "::"))
> -			die(N_("combined diff formats ('-c' and '--cc') are "
> -			       "not supported in\n"
> -			       "directory diff mode ('-d' and '--dir-diff')."));
> +			die(_("combined diff formats ('-c' and '--cc') are "
> +			      "not supported in\n"
> +			      "directory diff mode ('-d' and '--dir-diff')."));
>  
>  		if (parse_index_info(repo, info.buf, &lmode, &rmode, &loid, &roid, &status))
>  			break;
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
