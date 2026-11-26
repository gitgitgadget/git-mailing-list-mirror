Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661261;
	b=ZdpgiDjnDFuF7W+8DTW4vZx95VaRIPGVMYwAYva2ABZCWNrfA6DTGGYa1Zg4G5agFU4c
	 2SrPaGh5BKWulkZbmHqoa5R8NxqYPCs0kCT138SlDzRgqDtr52N6SsYLnSSjTJKYM7Fwy
	 d38rO2BqxkMnHjw8LCdCFZs43+lMa+PzrQBouGOcDmL2gzI6cRKDOFcNJkM3eR6BlQjRx
	 9cMXwC1D22+s5Q1Scuz4Ct9nolLeqXY79QLC6mkew3tCptRWemevhfDwBJYKGb1xW9Nec
	 zEaVdrW1fy06zsSHcALPBbYHuw8k9reooE88Io1ac9gRCJdD2Y92e085KeK/kDul/1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661261;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iXISHs6Vh9tBZY/4NLU+OGjTLBg4ec6BdWxoGFxkY+Q=;
	b=xP6G/mMtWB+6FQnDDVa43kegc0PN2rKG6XdAgrDpNQr/+MlcqOKoRTw6PukijIgTrHci
	 n3eReuLDQVuauckcZu9kEkZjnczxmD5ZMV2zpmoHhVLY8JVIEpr3KTbT7wbf/lz1f5H70
	 oi7x+2b18T7Ry6KnjSBqPyEm/GHVN2egyzZxvcYRqs33R0buknxgxyLXaLiqnMn5XzIci
	 +IgJiez0WaoaW+MI4wNN+ze2szImGAqnrhdQKOlyFwNhTYTrxWSxktUXOB2PqmT3r6qi7
	 VMSDrwlA6bHSKUu5/aybys+sEFanzQ9cY6CNlL6mlH3d3isf2YO/dcMFcuAxnMwPY+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="BRxIaY/M";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NMCHxljM;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AE606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 02:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BRxIaY/M;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NMCHxljM
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E6B67A0528
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 21:47:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 21:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795661259; x=1795747659; bh=iXISHs6Vh9
	tBZY/4NLU+OGjTLBg4ec6BdWxoGFxkY+Q=; b=BRxIaY/M/fzgcWouwdGsPfHREZ
	L/R0p0ryMv/p53cchxVNHIkdd21q6te8+p8nlZabwiCkTNAAe7/jUrKceGZ+yXTf
	wIiIQjmPmp9UbN5PQoL+BdbSTqmjg5IuFzXGLg8m8wy4aajbX8XoaWAplEKEUpGr
	6/q6wmy71b54xuScIb0GDoKYMG7410pyuW/Hhq5nyhdQFH49K5ZETnlvN8l2zeHj
	S2mmwtvdzWyHA5qV1AdgaC4Y/gKibjciK6g8FUzOkSMzx/9vfxwdM+MOV0GvoHyq
	CPpVdE4ApDgqKYcFGJbIcEx5KcXsERnqRt9VyBQ9s3WYBfAC2p3v+yz7B1nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795661259; x=1795747659; bh=iXISHs6Vh9tBZY/4NLU+OGjTLBg4ec6BdWx
	oGFxkY+Q=; b=NMCHxljMUdV72wQMSXgspBrpJmhc5s0AZyaBFIFjmdiCKGYoqsY
	J7dj1X9bBT+b8gB/EU0UeUo6EZFmB3Cta96IuRz4u3wSzKCwafwG3ASZeYNXofCG
	y22nY9xiE2osetJiYi/6heo94H/ccB7czUgIhGakXT/is7aMhi8FnVOqbzIZ1g2J
	A6/sAy/bXiYpBcMThhrLsYGv5WiFSId4zR+hhLyZj2qfVcAtaaFxnqgIABNkYns7
	Lin5Yi3MP2xJi8PXJdHobEjAvF0jh8kOlJQXmAetFNAD7eFRDqRcVk3zgpmWWtCa
	mk41aoo34y4zOS67oavI1Wu5USA4xa8XB8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795661259; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MZ3R9wtKzxhcQkzc3FMf02Mf2VQ4IHsbGTwGLj+sDCYWYNh
	5kl+DDuexJOsF3U2pjcsjt4hHcWGTjKN1R6f8uZFj9+4Dc2KlxJfJkW84nVbuMvX
	ZGpw0c+d78wrDh9ksdZzhqbPgmBCf4u8UVW10FdB6dNQBtSuz9wT0Epw0C2ufOh7
	nqBBx6xUASpDmrPnB/yAK6jlcwL2L4kxwA28ukVBCbrEzuO9YbEOpcMCa0ZRvnaF
	rvLFtYimjrmBUclpX4tFbQpBD8GevX424rsF0PxOVD5PQaK9o7BtLc9e17NUft+t
	6ttIL+oJDKuWq8Zte1x594IVbXZXgke+m9HaG3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xXeGNinY0pQOTH1emOyE/X/qfEC15K5e1WEtJzIVehQ=:kZ6SojhnXWvIOviN6kDafld8lxT0j4GHI6ILO0OM0Zw=;
X-ME-Sender: <xms:y50Ha1ZykstFpzybHBzF60XpI8syBsKIcndOe3ujDJP5oT6DnObanQ>
    <xme:y50Ha7ftxMk5FLsFpJ7lePJZbVCkwzxhS6XbG7E84VSd6hx5H4v2lLt0S8yBhMr-d
    3M25acfXtiNMr5bMjBD8iIkujTnyLEhrketZFe8GfmUzfRBgUysBfA>
X-ME-Received: <xmr:y50Ha-JerEAk2j7_hI-3hpQW34HJFLlluLHXx2LNpsA4-cQZpG7s5HZkJSpt_TGD-x5mZUCkySL0NF2yep2Dljayx3W3COalApQroYg>
X-ME-Proxy-Cause: dmFkZTEc01yjq6ee5VIt1zUOS+w6QBWZLwYTpFpRSjYuTslsuGbiz12/0MnyZdqJSOroaU
    6caYFwbscrzWNgKAZR16jy9XeH5D1ZpUM22vGjBB05PF4I5/ZgZLxeaObCu4qzOdHxQZk9
    quW+LnWAiptR8BT2IWGdQtDFq0Tm3Jj6hV8vLxyJ3tfFavEge1DT2fHkOIecEvWvf4Mk4/
    xUkMNF8IwOUoZ/jnrFqHUCdD7DByJFaQ7fKpebDtG34mgm7ByQxaCGCAFNMWNwvtxj3LzJ
    XupO2IyFoxklOk2eLenL2mFlrt0x+G4Ydl6JULBzQVMDmmqQAIVHMs9Q44+9HYaqKBV2d7
    wg5kpMmUQImoJ5TGM5KqKQpRoIRuZYOUTE9Yz6iFuXp0Vsj9JQxP59N70cX5OzksAlIp2m
    nw8uxEnYlMSnhjHhQMKm+ri3vsakqZPJB2HnTsbyE5MENomhJYRvn359321eBYZqedUh0Z
    9p6TQZc73H845Y9tHbf99VYy6/FQbpctVmhhJ5k8hBARtG5H0psKxdUKOZH/Tlhpwjn8XO
    GSo1fytOWaegzfP7sw6eUtPD6+DkJ6+Pj0poczm3LldfDrkT5sLtSj0lFjoe1Hpw11Rzmu
    Whu0VhoD5UhqjRtBcVHbcwony/EZXQybd7Eh3WEh4R6YAuiokTGnQlSNrB3g
X-ME-Proxy: <xmx:y50HawKQ5E-TGJWDKSqMmdrEEZt3vAGxJuwsjAfmcM8dNWBuamODuQ>
    <xmx:y50Ha1WryQNvf4mx5ihhl-jum7dOLHCHOirFq79eXqhsXUO7B8js6w>
    <xmx:y50HaxlP4FUtDHuyRD3Vssu9zhaAlgsX_WR1bZlb7rCWamk_92QwAg>
    <xmx:y50Hazl0YTOGXFNrgDPihwsZRxW0CYgy9ZyZw2ohA797b8lWmr3OpQ>
    <xmx:y50Ha9EDR4EA9FrTWUfixjX0_2Ph2700lhUwWycwXdkt2_UQ9LTw86ja>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 21:47:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Matt Hunter <m@lfurio.us>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v16 2/7] fetch: let --refmap apply to configured refspecs
In-Reply-To: <72c288a81ece231434d3e4fa870cce714c9942da.1795633584.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 25 Nov 2026
	19:06:19 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
	<72c288a81ece231434d3e4fa870cce714c9942da.1795633584.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:47:38 -0800
Message-ID: <xmqqld6gs3zp.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Tags are followed when the fetched refs end up stored somewhere, so
> --refmap="" follows none.
> ...
> +		if (refmap.nr) {
> +			drop_destinations(ref_map);
> +			map_refs_without_dst(ref_map, &refmap, &oref_tail);
> +			if (orefs)
> +				*autotags = 1;
> +		}

Is "if (orefs)" here enough to tell whether anything was actually mapped
for storage?  Because get_fetch_map() still appends entries with
peer_ref == NULL when a refmap item has no destination, a non-empty
orefs does not necessarily mean fetched refs end up stored anywhere, no?

A refmap entry without a colon or with an empty right-hand side (such as
"--refmap=refs/heads/main" or "--refmap=refs/heads/main:") likewise
creates an orefs entry with peer_ref == NULL and triggers tag following
without storing any ref.  Only setting "*autotags = 1" when some entry
in orefs has a non-NULL peer_ref (or skipping refmap items without a
non-empty dst in map_refs_without_dst()) would make "--refmap=" and
destinationless refmap items behave as documented, I guess?

We would want to have tests to cover such cases, as apparently the ones
in this patch did not catch such a corner case?

