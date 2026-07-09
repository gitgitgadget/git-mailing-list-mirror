Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A145314D26
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604639; cv=none; b=c54dP8oGTL83hxGkKHAnMQi5Z5GNyjfN1QfHM2fzUEOr3rYXGHpQT/tjALHdANgp6uq6YYSF3u5mtTyC40q+DQubcsZvA3l/fbeV8a4G6DCGvcsUbtOKG2kYdK0LBts3jYMZn/RArsry97PhhLcFkrzuVUKJvk178Ln3Xi1jwBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604639; c=relaxed/simple;
	bh=ZoPqD5akrF0+jyE2NTPrOe/Fpi8ALjCKJk4JoBip320=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUkzK1QwM6yIet7xGML7A6so6oK0x6W2vfe2rDPWKP5w25zi6Fol3esUxV90kUTTnFb4W6IzRXBt7YDxY2hZVAB5+lotHFfyfclPGh64VMYP5X02nHkog0UyUjbNhWvz87fuD7cwqFL/MMY4zGsX1flo4UgAab1hGAtS6z73xOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QUbKlZia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2KnEwWC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QUbKlZia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2KnEwWC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 455B01D00055;
	Thu,  9 Jul 2026 09:43:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 09:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783604636; x=1783691036; bh=99FqadNHuo
	WmwhQt55sS4u6bHVs0vbrCqRuosyRekxg=; b=QUbKlZiaUKI0L6P2jSw7zIsDB8
	Qr32ewMQ/Ax2ZD+Tw0qMN+DxG1Cu8Rf1ZChDaUh1bComCoCGk/DQ43ucidQBVGC3
	LilsWX6GD17q/1CVWs8JUXk/xLgwAS3v7Gx7A3mmaXSix2nP2CjCb7pyGbVexwTf
	00F0l8tSMo0bdiFFv+7llx9mopFwfyf4GWFc5cZsFPw1bfBGs9pQ6tTOSBs3nRNA
	ghxHCeB58iHnQNgI3dPHLzUC4UZmYDeaYVwWU9cTxTULPuywh/n84TSimXJUSsXu
	Lk+WoqTKHHJOvKmOU2qSiy7jRW0RkCmNNSLPU9kNFvAT3fSwGEcQ/Fu3Ok5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783604636; x=1783691036; bh=99FqadNHuoWmwhQt55sS4u6bHVs0vbrCqRu
	osyRekxg=; b=o2KnEwWCn/VHOCxTBvCMVEOLg8WUlsOJlKaW0zlFHnl3F6hwEeb
	IwKslgmCk1Y0yVha3Ud34svyy2FhrWq/wvP2wdq/RMp4olO1vOKdPBvRMZJ3Qe3H
	vojjrPWPjjO0YTtMPwRLcThVMkRhQYYanVLt/p6u6h6+OWXU5X2MbCjtMA1VTlqH
	VsNml9McYj8RF9vbhxd2zRnpy9Ve7Sf+/fu/PLILHQ6d0T7R86Db5yU6UkmIqCYq
	Latj443jpEQDXvcceZGjS/VERIOzgkA6qykz9jIxUox8lV4azDp8ieBjVJOGS0Af
	xtpd2ZxwzjyHqE4arkAslp2Olsz+EIelB8g==
X-ME-Sender: <xms:m6VPasA_axUeKCZU3ZcX8TuLVV7-lhDe45mxlZ2abQR3mMHNQxA7YA>
    <xme:m6VPal-cwnAP7rQLrosc_YclHJoGyf5zrDxmWrvTLOq5HX0qnj2gTSXOa7emZ4E6G
    5gcpg0x-U98MNQRZlDLz3SPNv9CyiMRIlZLjJojcYNiSTxvb9CMAw>
X-ME-Received: <xmr:m6VPas_2a5ke1dlMpoQYXklIk81AAlQT9ece3Nlyx1apOO9LZq463Cb6MbS1jKMMFDBkVIqsm3u3w_tydhuk3klRSzPDmZaT5UsnM-SwPQ>
X-ME-Proxy-Cause: dmFkZTGCpp+kVu7PyLycyLftjFz0gueNvniYQzL64EfnRxt4MEjqSOzTfqBrwEAvB5ebaB
    CnY6kwIsxPndYcvQ9GpGbuLVwT+VczWRHdI1yTxvpmamEfm7XLSK3qH9CvDZvS3mePJJ4O
    ukEwiap+FBeR1AThN3ZGHv6fKyyGvL1A8LtQNsOGC0Sg3VSZzEyZE1Xigyxrqr0f+Rnl7V
    0sdCqptiACgUyCORDo8D8PruieXfukvrKJl0yYtP6D4KQ3lbRHYdT4ngHnmB/dbFarXdoi
    DMeEkic2Jded0Y/2b6Gu1nTqxOJ1Sr9BPIxnn9uqsj+Y15e8MQrb0hYw0Xn8KKlztY2vog
    rvcmYxmHsMhWpNNyvQGVn9yzLtPyEM6VUtNy/sGrQYTBMTbvGqFMWtd+CmB4+fanPqmZbz
    U8/y0S+VEHqMOPawXtKTCTLWchlmxtg2lrybi4ghWZqTy5PZGYf44h8wa5Dr+fr/Hx1gUl
    oIFoHle7F291wSYqaVShuE6Rcq27XMyk9TeD9zkz3Upo7q3IrQ/ZCTdDDYQxGoBBKnyeIj
    URk7Mgx6rk5ia8QyUHmNC6hR2i8xIYKy/Wo9QGG9+c3xOOoWvwUf/dzLyZCK4S6tLiDpS+
    jA7NxB7cMFUbDLYdD25v2SoQR/Gu106N/Xzxvvud5noRBpxZKgVK1LWrJfMw
X-ME-Proxy: <xmx:m6VPaseTVESjAWDt5jmHxlMgIeJ91qBSOtqRPr491IRNMXAraIqO1Q>
    <xmx:m6VPalExnUxPS_ZP3Y3rthZCmHVjLkej9qMjdLFy5lMvt17zrHHSjA>
    <xmx:m6VPaqdGepirgzUz6hQMq78kAsiiPPjgTeHwqSQQyN-bMl4t9w-YTw>
    <xmx:m6VPavEoUSmTT4Z-lBALykIotHL5DsJaAE5TtO00bx9j9YqBNuqRuw>
    <xmx:nKVPalN-hgMTSmffvSLZfP8BzndzWwc1H64TZ4__37ygtIu3-cL-dPFD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 09:43:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51ffbfe8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 13:43:52 +0000 (UTC)
Date: Thu, 9 Jul 2026 15:43:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
Message-ID: <ak-ljlV33GLigFf6@pks.im>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>

On Tue, Jul 07, 2026 at 09:59:43AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 4e39a048c4..c2a711cceb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2610,7 +2610,7 @@ int write_commit_graph(struct odb_source *source,
>  
>  	g = prepare_commit_graph(ctx.r);
>  	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
> -		g->topo_levels = &topo_levels;
> +		chain->topo_levels = &topo_levels;
>  
>  	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
>  		ctx.changed_paths = 1;

Oops, that's an embarrassing bug indeed. Thanks for finding and fixing
it!

> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index f9c57760f4..9e5ab7dbd0 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -738,11 +738,7 @@ test_expect_success 'incremental write reads topo levels from all layers' '
>  		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
>  			git commit-graph write --reachable --split=no-merge &&
>  
> -		# BUG: topo levels from lower graph layers are not
> -		# propagated, so the DFS re-walks from base-3 down to
> -		# the root (7 steps) instead of reading topo levels
> -		# from the existing graph (1 step).
> -		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
> +		test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
>  	)
>  '

Makes sense.

Patrick
