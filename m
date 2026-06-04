Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714C3EDAA7
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563724; cv=none; b=AOSsncbGgvpyhxKP4fgnLN3D79hxU2DxRG83q+Wi8BOBqY9ZZEmjD9tCrNg0Yho9/F4d69Es9DhWc+q91DTWdHSVE/KHuDOyJsUKG6uwCoCwtvudavR9bL2mFwu8iBOwI+6nPnCNO/VJClR8P5rl1ihLIaEwhp1aS54L9Tgo8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563724; c=relaxed/simple;
	bh=/y2M3qoy8iTXp6vgCRUtY6yOp/kMBOzvJjE5szWOxWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB/tPtSTnt388eKfwCW9KXor2+Z20wT8rVQqqKKxFDDm5fB588VqtStCHFjhuvDSv2A/R2TUuupdCiMTMx4Ok0ry4q1kIaUm9jxaU0WICxsg4nZ/RL1ws4iolOmHBX9zOhP8HC3Y6uJ7Pj7B5zeHsrTx2A3WoB8AnEuZPCuW2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IvMeLQ7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9cCaeIw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IvMeLQ7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9cCaeIw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CE5E1400078;
	Thu,  4 Jun 2026 05:02:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 05:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780563722; x=1780650122; bh=DDnEU5xdla
	N12xUelCZ73VvocCckl0rbYsT/MJuUPuw=; b=IvMeLQ7dMpK64lHw3PIrA6ZSSt
	GOYwYtq7sMdS/tPgRLcZEPOUTTWsAsSTaFQ6DbR9lN8V3u9P/MNvc5khbZEhFpyJ
	ZR2n4rVVqmQ4LcGNxzEyKeBo1zK0HfrCg/B8hJA2mxOacpURum/sfS9ejIqS8okv
	0kFcZtk9FrXnsfj+Q902SW2GGXvk/9JnHTrnTo8w9+oY4RyOOk/A7rXniP/lZl1l
	bMA4PjhMfy1+notTBPJQYsWibDB8atIWl5BY8hbj5RX1EzVifFAnMdAn//T7hhai
	ZX6An6QoiksPz+RMw9z2GRM1CaHGf3w6GiqeJlITcJGeHHCPlMFd+1z7vKNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780563722; x=1780650122; bh=DDnEU5xdlaN12xUelCZ73VvocCckl0rbYsT
	/MJuUPuw=; b=J9cCaeIwT7b74yyHgBSHFgPT+LjTtEaofn0oBpZx0nSyuTxh+Y1
	qcLJXYYI4pDLRgyaiPNulSou1PO1rRUZRUdrecmD2W3pGqeYYwHuZCloD0o39khT
	lRVAS9KaVtUMjlStxNr34gfrqK2dks6vfgEk1NLETkhMBRPR4qJgAf34WedqFB6P
	o7WZ5zbb66Z6G6ZkZ0h8KvR7z1w9GqRmeHi1ZY2zJOa0Mx+Q2WBVTJyGLupJpJJv
	FbMuUMtpntZdArJLOVE9xz+z8JRoJzdykpzwC9w0EnV0FdhwJ8I62JMrGma49g0H
	dnjOK81EZGGG/GrJ8VuT7u2ivUbN+FY0CJw==
X-ME-Sender: <xms:Cj8hanu1j6OQfsSu_Lo2FgzFsd2qxGPbVWK1qWkOxX6HvGuSZBZsmw>
    <xme:Cj8hav6-cmqoIRJLS3irUx5YPC34heT49trvYjT3B-sBGaHaJoJVN2C0F5SgBlAxa
    KGGMJGGuAydf74f_-JsC8GUHqXyFRpbI2L1jzx32GForP43x5tI4A>
X-ME-Received: <xmr:Cj8haoKOGfW2hQWP9Q-Hcq-3t594iNEnaHVZcfEOhBjx02Mn4iDm7WsHTnpMZSTiawsk9fW0Tvc-KJ_SICyZPCkVkjU8Opn5ThFBQq18oDw>
X-ME-Proxy-Cause: dmFkZTGFLCKX/vggYM5jwwyMt8rt+EypqxrXadveFJWkzsKpDa8asC0zOR5+W2LIpwzuJl
    72XDLeBCaVV9maRLOWkDKQW3QdgJowIlVHQ9mpvFMc8hryZYsx9kBUqOl29D59daArvypx
    F7gLSH3A3Vuw9NoAruQjW72IDZAQKJllvycfambcNbPQevxREaJI2vkYBrf6PmflEfXRx/
    LF+Cv3A+bMmu4nDsa0fbKATZHXNlBt/OlNAVCwbvhVwjU5g5yAWC3X+9R4wngkzdzcIGSc
    swrDKmHcbZcNjt83IdcBtlQl4ZUuMa0xcSF10ZDF5kQCU0KOhgzn4Orn0FX4SR8cw4Xon2
    F3dxHjlsn3MiGCI6Xl/E1EKw6E8egTtgrbOjpFm8Wj7yGIMgS7/ygIAVFZ35jkb2gumObu
    dY+3Qhi6s1ztSG4nC42JgeelnWo5OhRpWzw/BvVjo1ZXc7a+JML9qG3HZ00cHyHGbd5Wkg
    fcYBC61KUbt7BgpH3FIbQxhMjjt/1TWUSPVI/F4H9hj24NLreSXmDXsxH9rrDTHPQSu3an
    kDYbscKbw0dZlPj3JiGwCP6IZjDhrlYk36pFdj3dPUeUyr1tqSJyD9/5Fu5cjrFPqzIsp1
    8NbejVBbMAQoPC82bErc/7IMVETGJeZuXUa7fO6GArzNP7AXUSIs1zKix+Rw
X-ME-Proxy: <xmx:Cj8hav78jFZr0liI7o0KFQgL0jdTpfUv3q8rF3WX5zZkVj_D286WMg>
    <xmx:Cj8harxn3W0kPn5r5R1aEwyeiDcE8PDz69y2gV6PW39_Y_jQcHDwwg>
    <xmx:Cj8hajaUWWZd-C7wjqpgZHvH9Gkee9OCHdwJ1FZ4u7oxd7BEZU0u_Q>
    <xmx:Cj8hatSo5_IW4VKUbL2s1tIwrWo3IxNiCCec0_BNsVDkqPzd7KRz5A>
    <xmx:Cj8har7SJ2Zd4DOusl6_UQRJO0ayE8UjDVrEaoB8ScPlfJ2xWoPAv3gF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 05:02:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a294999e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 09:01:59 +0000 (UTC)
Date: Thu, 4 Jun 2026 11:01:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
Message-ID: <aiE_Bcup5RTfcQD8@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
 <xmqqqzmnqj1o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzmnqj1o.fsf@gitster.g>

On Thu, Jun 04, 2026 at 08:51:47AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > @@ -112,6 +113,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
> >  	if (opts->branch_msg && !opts->branch)
> >  		BUG("branch reflog message given without a branch");
> >  
> > +	if (skip_ref_updates && (opts->branch || refs_only))
> > +		BUG("asked to perform ref updates and skip them at the same time");
> 
> ;-)  That's certainly a careful safety valve.
> 
> Would we also want to catch skip_ref_updates && update_orig_head
> being both set as a bogus request?

Yeah, I think that's a good idea.

Patrick
