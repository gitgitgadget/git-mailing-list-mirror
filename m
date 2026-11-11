Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400967;
	b=AU+WqyYYl7SXRfAtXRVxtP4dDNG66q+jOggDxyaM8q1yV+hKMkjc9+lGhNq0J/VbyGsP
	 5SjlpHuFLcGyrAu6LPcTQDTwHW9fV2Brv1k5wafBD0uiSb1obd5K0HwpddM8BhOl0/4+X
	 sBo+AI3DwCPW/NzA/lG2xDRreVI+q/mwdcWIKEPwM47arWBhRu6n5u97pZesEbz1LK59Z
	 lEogeqg3iMabGJ5SOC5UjwbIsNk9H7AdUP4WFVDDNoKGYZeEqzoflduBQsj8d/sJQwKgg
	 pNCcjBWYVqUB/oBmmGypzFmCHw3RC+gnoLcBMObUui0j+Unqd4BwTkT959W2buMMeOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400967;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iwxFHybWGuprGZ3dVmGnh5hs76t8bfnHGS/EYw+m9EU=;
	b=Y016gDCr/1shHUZia0MMPCABoATrrRNnvC6V4zLudWAO81t9HtB1oo8u00dqyDNY2Co3
	 TS2SuY/w/RX3Y7SqErRH3tUAGseekybir5sb5T+OY94kKotqW9SbdQQrEZIdCBR9xA5Ob
	 gELhMe1Aqd12RNKV/FOWQl05px+A6t2jMzzJKq8+27vaCE3thrlBkRCSHoCVcMQ5kMA5x
	 2J+JZO0Eg9M7Mho6J3jP7p8ITwkTzkD3YtCGT2LffejZHGzbdsEOA6mNqeoU1azRyzNYe
	 eeqRJWBG+qvkghFM5NXJgU5KWlGNNwv8Gp6k7LhrMxo+0OZSL34xe6x98AUshtLxA4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Fm4Enzs0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Y7JjcIKA;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1D606A32E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A1D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Fm4Enzs0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Y7JjcIKA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 42C3E1D0021B
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:42:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794400966; x=1794487366; bh=iwxFHybWGu
	prGZ3dVmGnh5hs76t8bfnHGS/EYw+m9EU=; b=Fm4Enzs0b7FmQatUHnsZjzDeSq
	8Csfp9UP2D2/riGGa3Vu+DUDUAiSwIVGWNH12vFNJNiJXE5/wy23r9haiWai6dKC
	vJdAro7w2D7+tOWCYYeOgsbBk6/+xNyo7gIurCTHl17gWdQ7Mee6wPb6RqT2bghn
	cFsep2CB0bdJNAxuzHm6FmrE4YGcG641ILGigxvC0i0SpdktbZ3H9PwuEVCrkbKg
	eWwMS7k5JbKKcACgI8d8KTMIwVCfG3lmBo6zd/Vcf6uAOUX7QW7QAYdtkJrelqY9
	ENGZnnNWd9t7ofRqknUHtlGMzQPIyBSHuK+jsWb9alPGaZpki4yNtSsRpkDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794400966; x=1794487366; bh=iwxFHybWGuprGZ3dVmGnh5hs76t8bfnHGS/
	EYw+m9EU=; b=Y7JjcIKA8JjsCJK1BJe6EydOY2P2mOEZ8o03haU60tOIs0nTFLc
	4lduw7lA9EBR45UfVSLdQR6NNNxc0vvE3ZaTwC3GjGE0ALN7+S6aDTO9lu7pKMru
	6AD7dQBZg86x0a2rAQ3oClgRB9DKJL4+nUn5aTynFkx+QeqoleTSK9846Kc16bqh
	0IUgxnuNjZm8b6rSGop05AQzC+Hm0DY5/Oa8qX8/xZW5Hi5V6eGd9ZQg5MjcR3JO
	4rjJ2Ql4JHsZAkV8x1az4iDZ/LO4GNXgnstfQzjaWleqJdcv7ppJne5ghN0WHnf5
	eJNTre+cZzjykCrF56T+/mCRPaJ1QrQqIIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794400966; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:rjIFwR19Gx5YYnmLUjzPX3/Z314W8Tau1aFuzk4NRggPAYl
	UB+ZApbVi7MbHnSw+4r5CCVL2XDGWqk55ragl2dO3/cEWyD/U+SX8wIiPSr74Dl2
	ZmERNLlbPCvgQeHlrrJKhh6vqnyick7MRimU+02O+R97gxeIl3Osp6h/DmGTOYLq
	J36tRwF+8MiOTBkGhxphZmYhoz2Z/LgDx5pme5dxdH7TfP7aVX/KNgzNutuRu3L/
	dBumDg7N/SkQqt4uNldt2/HAN3tuBIVdXqrtrqq+Xvb37qoDIWXoIqiBwMvwhYV/
	E66tRqqhZhhJGLxNEZLFvQYOPxIeuTQF4yY6eVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zR+R7gX4/mqo/rHgcA9db129j8pnT502mVUtgi40Sqk=:cNeyJufDipGg39Xbp794pJMAImcgrjXNaGtZZqtR28U=;
X-ME-Sender: <xms:xWL0aiJ3p6vTVb8MwyUjZ6s7985kCoydL0Y2uPcw0-guld1kLZ0M0g>
    <xme:xWL0alrYwH2BxjmArrEtW0swj5efoJ9zfhDCsHNK76RRwEn5cwg4WDFRjlCMMqlbR
    SanSRkeYZKjXfi-F70oajWBt9_MlHqUswCtylMrIoLZgAnpkruqk2k>
X-ME-Received: <xmr:xWL0apIkFtI_uDqT1t2ArDkv7AqUefNgQslWfL2-dDxzs-YodnRZifCo8A1Vt0DSkI-tMQ>
X-ME-Proxy-Cause: dmFkZTEc3y2rN3E5XyHlQwkIgomcTHkIzutc4QQ6dyZGzKwLk1xM6uXaDDCC+TFTk3XLCT
    vaiuF3yCTCPd6urPZQ6uWFN5nB5e/Lxj/sHpRqzaOiRaCFrQeVbi85+Gacm/nfkTTILDm9
    t1tU9iyf/JTNhNZGDVSQlGNGWvBcdXi6l0qqHB/tEmGDX4APZd7TW4evoamUOpjtqtAb69
    eu+QZE3I9Zxht9s6GITZkU62iAp4v1cxVnsFSAz7xA9j5v4VrVXDEkTXbfm7Pvg91OB+cV
    LScFf3AoIS30XU3E7GSCaQZModPbKYg7dx8Do5B8Ep/aB1cL3A39x+0CwduZ3FbpA7nOe2
    MNORCGYHeFavpx6HblCGhyOdS1sjLMO2WZhgcABDB6F9UFAztUl4QQz6rwqlAxKQMHR9YJ
    c2SeIw/oCS3/+gZD4v9FfQ9JldvDSviNBScpVj4RHREDX12b7sSPkwEiWIuaxbGHYm3sLx
    pQQZKom+Tep3hXfmvN5h2Vyjgwo6q8gsTH3+PKz7O5hdEqS1dWh6E1CUsJ653JhGnhTqnT
    0f1UkEqO5pbli51O471yYK/cqtFwvQsbk8n/aeZEdkq8GQn8mxkihznZ9XkMgRnFmdNsWB
    r/Zo1T500ucTZT3kK88PnDjobh8LmA1VShfX4r64/JmHscepsWqC2BgsztKA
X-ME-Proxy: <xmx:xWL0aiR79t_1-CX516rKvu-0Wj6-sLtCIdE-alosHVAJ4ynTWzHqfg>
    <xmx:xWL0agsgwY-qFoqHbE9960IVkB8T76BIvstqnT6N4Egu294oDAw1oQ>
    <xmx:xWL0arbOYSIMyR57bVPPAq6ANWt918rUsZwikBV_TktBhkzgbkmvLQ>
    <xmx:xWL0auHIld41KFXvVvXzCqa2WOvFpv9Gz1p7Xk65ugr6HxFC_aSXyQ>
    <xmx:xmL0akcbWmKywHhfhQrZm5WL6_8M3ZSOrVB1aIWtNlp-NSPalVRJUgmk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:42:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cfcfcc17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:42:43 +0000 (UTC)
Date: Wed, 11 Nov 2026 13:42:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] builtin/reflog: expire each reflog only once
Message-ID: <avRiv5WpCZQCbRnZ@pks.im>
References: <20261108012213.89468-1-laveeshb@laveeshbansal.com>
 <cover.1794324064.git.laveeshb@laveeshbansal.com>
 <0e5d78f552deaf3bd0ba2ec70666cebc2957c9e4.1794324064.git.laveeshb@laveeshbansal.com>
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
In-Reply-To: <0e5d78f552deaf3bd0ba2ec70666cebc2957c9e4.1794324064.git.laveeshb@laveeshbansal.com>

On Tue, Nov 10, 2026 at 07:26:41AM -0800, Laveesh Bansal wrote:
> "git reflog expire" processes a reflog once for every time it is named,
> and reports it every time:
> 
>     $ git reflog expire --dry-run --verbose --expire=now main main
>     would prune commit (initial): one
>     would prune commit (initial): one
> 
> The same happens for two names of the same ref, such as "main" and
> "refs/heads/main", and for a name that --all already covers.
> 
> Skip a reflog that this run has already processed.
> 
> Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
> ---
> 
> Notes:
>     With --updateref, the first pass can move the ref, so a second pass
>     over the same reflog could prune entries that the new tip no longer
>     reaches.  It now ends as if the name had been given once.

Isn't this note here important information to point out in the commit
message? It sounds like a bug to me that we behave differently depending
on how many times a refname is passed.

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 42d37a3724..4221136298 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -190,6 +190,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
>  	struct worktree_reflogs collected = {
>  		.reflogs = STRING_LIST_INIT_DUP,
>  	};
> +	struct string_list seen = STRING_LIST_INIT_DUP;
>  	struct string_list_item *item;
>  	const struct option options[] = {
>  		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
> @@ -285,6 +286,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
>  		if (ref)
>  			refname = ref;
>  
> +		if (string_list_has_string(&seen, refname)) {
> +			free(ref);
> +			continue;
> +		}
> +		string_list_insert(&seen, refname);

Hmm. This here retain the current ordering. But is there a reason why we
have to maintain it?

The reason I'm asking is that the behaviour here is O(n * 2 log n), as
for every string you add to the list you both search whether it exists
already and then you search for the insert position. And we could easily
speed this up by using `string_list_append()` and then sorting and
deduping once after the loop.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 998a7e8667..d22216c36d 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -274,6 +274,20 @@ test_expect_success 'reflog expire --dry-run --verbose --all' '
>  	test_cmp before after
>  '
>  
> +test_expect_success 'reflog expire does not process a reflog twice' '
> +	git reflog expire --dry-run --verbose \
> +		--expire=$(($test_tick - 10000)) \
> +		--expire-unreachable=$(($test_tick - 10000)) \
> +		--stale-fix \
> +		--all >once &&
> +	git reflog expire --dry-run --verbose \
> +		--expire=$(($test_tick - 10000)) \
> +		--expire-unreachable=$(($test_tick - 10000)) \
> +		--stale-fix \
> +		--all main refs/heads/main main >twice &&
> +	test_cmp once twice
> +'

Arguably, if the above is a bug, we should also have a test for it here.

Patrick
