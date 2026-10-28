Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177855;
	b=uqFA22SNCSdJgWEI5yNG8EV/uVSvGIz+FemQdr6noKUSoXeWWlvHWHJADq9HPJrqJzGx
	 2N/+sANtC2q6crp2NJdDpCCEfWHwfMDSGarfqArm8FlsXee5hw9cm2H5yc4KFCHR1/HIS
	 6Xn45zLUFhOa2Wtq2ARe2nAnEsw5LXIiFzopPFok4vinDfI4EpfIHkxFklQ8+WIFu+uEz
	 CbuCDMVPcY6nEG0JCleALJDeVDT+ADhK/8M/muwDjGAA8QogtSiwscu48NBbReYLvffKn
	 +EVbE52M0+f074ypf5IrHGf0i9sGNV6EZBRJd1gRZJmlTUZXshBPPBBTV0E3eHcYaQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177855;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bs/3Cu9MAIR7k+zIrN6J/pud0ViuOeilxH5LQNdCxD4=;
	b=Ka6humxOY+iz+kamVpnqwOjbN2WyS13iW8kT1JesisCBZiwJ5Ht2X11/bX8HfnPVXAip
	 m+DKiSqNbdeoh5WmJhroobPau4ricQfm7tsnpi+82CqgKfGhLOarBxY1zlGwroKUTBYmm
	 D3icTXh5ba2nHVY3zUceRHTS7I+BfokqCu0xjS5GE5FcJlrorBK3WOxrEsIjap+gsegu3
	 v94wKcfG7arelTZH0I8DbjkNTYhuL2DzBroJ1T4oje5B+RYZdOuCW88UQmq8IU/Sx9nNN
	 1l4hgViyY3Hr4rW5OVoAdFsPQvSEyTtiycKU8cEoCKledMZzmuiWxKoF/OMsiGM9GgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FA88BkkV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=swUyUC+S;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA414606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA414606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FA88BkkV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=swUyUC+S
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 187151D0017E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:57:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 04:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793177852; x=1793264252; bh=Bs/3Cu9MAI
	R7k+zIrN6J/pud0ViuOeilxH5LQNdCxD4=; b=FA88BkkVdqpmFNwyysyOnOuQ1p
	bBPsebG24NsIn4tt3M/GEkpB07zbIZvo4le7yTN1AslKN32wPyNqj8oJW/k+5JzM
	1UXTs1wV7jOfUZdjWAmiYknq90AEZRCXQjgoXywWPe0nqsWmMhy3Ve5eKoUb4Zm0
	87GHLcOQVMZA6d7pLKTdJSH2ohSKrP2+IBGoA7BnOJSzR1dwFoB/jgsnRC7/Zgyy
	f4oyxCuDZ/gKfkLz16lETuCa9nh8uLZGplQ+nFa1eSIAhhXaWh12yrG72rnIv1hj
	6SinAHsSwFF8Rs8aYJxUn2xFv2MUYGzNWuTiZgAvOsizng90mX6pQJ7bL2tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793177852; x=1793264252; bh=Bs/3Cu9MAIR7k+zIrN6J/pud0ViuOeilxH5
	LQNdCxD4=; b=swUyUC+Sv5zOXaJQ4A647Dj/I2YOYCFha/mGarrpruoFPEDfCpK
	+EMsM6SOGhy9mLyVDVELTwcRNjSmRPKkGFOgBj6S7nIvYg75shOFM33jvoc6Y1HS
	l3uiTocQACCyaLwr4QDFwibzdhJaYSJ74ZBOnFq/6enAFYgqo0QMc9sFpfMjYGCF
	AkaD05kGSG8lJWCjpdcTg21uNs8C5HHaaZkz0/2hRbcLHQ9L5ZnG6MmiEuUIEMUu
	I7Z8Qozef2qdXZCWRGh1v548RLrJrPEBpkhP5hFAKkLZsWt5Y60d+hBTk/XgGNZY
	kkzatsWYzrA7a7ZI2dYirtzWfAA9RipmvnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793177852; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Me1PWUJbdfHYkbRccK3LYEn0ZbMeHvL9g0T7jWk6Jvq+rin
	36YCx/OSUVwzGNW5UByJRY7eJPugQbTaeP4SUuF2gBqzSrsU4ZAbf1fBayyeqvZf
	cejT5nKgtMpz+9yoXPs9Vat4EHcyzi0ViaGQarQD/dnrfCgbWpdIYM2xuT+JbJM7
	9KBFdV/3tGsTvihPsAm6+UzjXPvDhEb0jq0rHuLVsK53fut/ALVl6PehPxknBH4T
	CQod6b5BDcWaPWHDgFNb7ic4JIIihhb9fSmA/6u71a80DMkknmT7iGHwuq+Rc4iK
	TLVhsOUsEHJqZclDTRyc7FmA4VYu+2K76moyDuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iRTkJgqIIUhiD/TtuD1/ODF2fRM7jc9UaXGVMn3TrQc=:NsFBUqNDpEA7yX7F0/CL+dmUXDS1fXsyp1rKe3OBUNE=;
X-ME-Sender: <xms:_LjharN572_93MfwGDu0_VQEX9vzkl_NgrRs0ve9--8vBKHMcRsJaw>
    <xme:_Ljhas9jgJ5U6lNNxZY1pNr9D7Nf4jBW9bB8rP2L0NaS8mPVQTBoRGoJ8becxCxTV
    s_ipG6a58nzkzoLhQ2eM8O7-jdQYZTirB4ss-OhjZGJqNxd97UXbBk>
X-ME-Received: <xmr:_LjhavSGFMm0yEPS0ubnxqI947hek3zAPTZL7JHGPvLyLs0lFcUoJg>
X-ME-Proxy-Cause: dmFkZTGlaXoQAA5G6SDU2bDXxCogZEt25KgSXmqCcULud3JPjq23VjRaE1FyzKJXvqQQFn
    6rPWZBuDrVUNIgS8j5ZrT4+iSJLUvb1GbCUrB3nznkjpMYwUeHtNTAfnk4c4kDp8iQHSeM
    SmSPfiicH5sXINQU5ZbWjnIcCVx09wNDMrew2DqSZPwon92L8LdP3YSmzsOtT+vPjSBGuP
    BDDeFs05tNEnlAM+LMAld65/vKtlulI9LLhE5DVeq4gaJGRqfx8GOcNbAwD5Tx/zeSu5Wv
    GVcjN5JHjfwTFzzbVbRxmKuGmiKFeIiZNFGb1CC8W0tQbJu8AdiYUx2qGKSmjjGRwDaKEh
    tRQQwwVRa25HxN3H1h0iQIu/58V9aXFW2DZlwy5Z1f7Hlw6+5R3fW4sD5reoCnqDiptlbx
    k7HdMJFAxPvJ5comRmM/scseRwrXeLgfzjuTpYcnwz3lRGKUMZKdEoiFhO8W9Dcm1HrSq5
    opy8U80yuRSu1skx9Kqbvj4+wBe9zFdCQjhk4z0VyQGp6NsO1LQYy4gp5ikveiYtPD8wez
    Ls4Yj2OGdB4X2LpmFxTH9ax4SqHYYVuOyehNV74Ww3Y/0Pq8aK1KyY0DfYd5ZN0crOghwB
    vvKU2UPk0TJamhZr2J2ckP290ZUxXgbhP82A47jiARVFt16Asl1ZZCG/cmQg
X-ME-Proxy: <xmx:_Ljhaum7DOmjwEpgjpNGnfk7plIPUYBb3IvnQM0s_9T1CREZAHFbXA>
    <xmx:_LjhavSNTKG5IkFlmtQ4sercV4XTG6AnWKY2-eilZlWMkfUbe8aQ9Q>
    <xmx:_LjhasP2pzi5P1fIKYT1fQEwqvCmZJrSVUzhCz4bevnhD9QRKZOYjg>
    <xmx:_LjhaoVW5iTuBrDIA29OG3MpNgK3AV4iSCE_m--s1_60l4kEttTE_A>
    <xmx:_LjhaqnQFJdR9_gWAQd7Jv9pn65zC8nJD1LFE7cOmE2Mb8tKvKVIXmnD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 04:57:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b83a249e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 08:57:30 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:57:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Venkat Ragavan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Venkat Ragavan <mail2venkat21@gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
Message-ID: <auG4977CYFRTJVRQ@pks.im>
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>

On Thu, Oct 15, 2026 at 12:30:55PM +0000, Venkat Ragavan via GitGitGadget wrote:
> From: Venkat Ragavan S <mail2venkat21@gmail.com>
> 
> When seeking through loose refs, cache_ref_iterator_seek() compares
> each directory component without its trailing slash. This can confuse
> a directory with a similarly named ref that sorts before it.

This observes the status quo, but it doesn't give us any context _why_
we even did this. I'm sure there must've been a reason for this, but the
reader will have to figure it out by themselves.

> For example, with these refs:
> 
>     refs/tags/releases-z
>     refs/tags/releases/v1
>     refs/tags/releases/v2
> 
> Starting after refs/tags/releases/v1 can position the iterator at
> releases-z instead of descending into releases/. Iteration then
> returns v1 again, even though it should return only v2.

It would have been great to demonstrate how this is visible to the user.
E.g., can this be shown with a simple call to git-for-each-ref(1)?

> Include the trailing slash when comparing directory components so
> that the seek follows the correct directory.
> 
> Also handle two related positioning errors. If every entry in a
> directory precedes the cursor, stop searching that level rather than
> descending into its last entry. If a leaf sorts after the cursor,
> leave the iterator positioned to return it, even when the cursor has
> remaining path components.

Are thse separate bugs? If so, it would've made sense to split this
series into three separate commit so that we can fix the individual bugs
one by one, right?

> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index ffef01a597..a3bc2dc11b 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -532,7 +534,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  				level->prefix_state = PREFIX_CONTAINS_DIR;
>  			} else {
>  				/* reduce the index so the leaf node is iterated over */
> -				if (cmp <= 0 && !slash)
> +				if (cmp < 0 || (cmp == 0 && !slash))
>  					level->index = idx - 1;
>  				/*
>  				 * while the seek path may not be exhausted, our

Tiny nit: we usually don't explicitly compare for equality (or
inequality) with 0, but rather write `cmp` or `!cmp`.

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 7f060d97bf..826fc1b9f2 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -746,6 +746,61 @@ test_expect_success 'start after used with a pattern' '
>  	test_cmp expect actual
>  '
>  
> +for storage in loose packed mixed
> +do
> +	test_expect_success "start after respects directory boundaries ($storage)" '
> +		test_when_finished "rm -rf repo" &&
> +		git init repo &&
> +		(
> +			cd repo &&
> +			test_commit --no-tag base &&
> +			git update-ref refs/tags/packed HEAD &&
> +			if test "$storage" = mixed
> +			then
> +				git pack-refs --all || return 1
> +			fi &&

Okay. These are a bit funny in the context of the reftable backend, but
I agree it makes sense to have this anyway. Doesn't hurt much to have
extra coverage.

Thanks!

Patrick
