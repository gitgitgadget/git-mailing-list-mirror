Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423021;
	b=lMjmTaObYG5wYfhb1NWXgFzKgvmZQvahXmYseArdoZswVdxrjDlT2+i7Q4tltAxd0L6p
	 r3OHHXgTfIjn5Gd3JLPoD4EpLTg0iZfcl9L5PgwKvygS4syHC422TVD8t0qNK+kNhHkjA
	 +ibdJvcDT03J06yc7UTgJC/C4q8H2ZfogbNy2O3UWNVyTxNaYFSUbmu1xMQzOJEscKyRr
	 VUPDhO5vyKwzPQ64RvYo3gnW89+NSP6DbNhdi4pm7H1P8AKRBxdidlPOK/8JJKKiF5Xou
	 PI4A24qENs91j3j6xhevZnF6cDV1/0rTpP+e9DgO7J2OmXGmmKMiNxK93mAKfI0ZVAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PCs/ttGxj08ZJICnTUmlGmKWjbT96NkZMuMHEU2H6os=;
	b=dWAXFyrskCVn/tj6VPdFxJZ9T912DB/qk6vgmHqQHRcj1TmCR046s7X2WUq1bg1qUy/x
	 +u5gIdnrwJajC9pLiWFWeXelhnJh7K8Fjlh/u4Kv/o19dbw7SBORkRCzzvKt0G2mSPEFA
	 sYFD09yaKnz2BG+kK1MC/TkMzjpMfY0QqjjJjZ8U38e1wqJXh/5wyPSylvDgQ3QQS03Uu
	 sq10GZTAX3ekGad3I/5s0QXRldRdhCuTg5tAwZuLFsRr1FAllQKuDL0isrxifKC4wvK77
	 Pl+XGM0szQUOSD4ZmZ1ULMEGymzdPhqXiV6QKZlTJLSenoQSPyYfePG+fK5/DLjOknw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=S0FgrW2c;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D2606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 05:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 121D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=S0FgrW2c
Received: (qmail 50808 invoked by uid 106); 31 Oct 2026 05:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GrrGmGJFv9CM+VYfVw5sxq/2nVaX3AYHWHlBd/wqUgM=; b=S0FgrW2c92XIoJ/hZgT2l24VKEg21zkH7jMb91U3HpO4gejO0F17mqxoMAnYwutbA44K0jtRzkJFqqs+i8vJChI1V6PVwKic0L2aluxEDrhMbVlPBgB26vUem0N0GzCBU8QY4x4bI85xVrwb4OxzKBdEZIMV8q04h1+/ahu+a49Y2piu1NHMp0w3o7iDtv+jjbvJbnLl0uDHS7F/ou+QmgBz4nrigUFrLEcITiSg9tOQVDhsEg/0/7c/EoOF7sxRRs8vs/UnOAPO2En6794xv9AMifBK+hXNNpvzM8/ZGWucN+WoqbDPuT3HSRzoVcSEIxcpFXjdaGgZ3y091RmA9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 31 Oct 2026 05:03:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 329721 invoked by uid 111); 31 Oct 2026 05:03:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 31 Oct 2026 01:03:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 31 Oct 2026 01:03:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
Message-ID: <20261031050337.GA1202343@coredump.intra.peff.net>
References: <20261031002550.GA626623@coredump.intra.peff.net>
 <xmqqwlqytvg9.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwlqytvg9.fsf@gitster.g>

On Fri, Oct 30, 2026 at 08:12:06PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The new coreutils hit Debian unstable, so I ran into this doing my usual
> > daily "make test". I wondered what idiot did the overly-complicated
> > "env" invocation in the first place, but naturally it turns out it was
> > me.
> 
> Namely, in eaa0fd6584 (git_connect(): fix corner cases in
> downgrading v2 to v0, 2023-03-17).  The log message starts by
> discussing dropping a "push" that asks for v2 to v0 because we can
> only do v2 for fetches, but the three tests added by the patch
> verify that fetch, push, and archive invoked via a custom path do
> not request v2.

I think you're misreading one of the tests. The one for fetch checks
that we _do_ send version=2 in the $GIT_PROTOCOL field. The others
confirm that we don't (the idea was to cover all of the possible
operations).

> I can see that the patch correctly checks the value of '$GIT_PROTOCOL'
> in the environment when these custom commands are invoked.  I would
> have to read the log message for the "head-scratching notes" in
> eaa0fd6584 if I wanted to remind myself why the original code wanted
> to downgrade a custom upload-pack to v0 in the first place.  Luckily,
> I do not have to do that to be convinced that this particular patch
> is correct.

Yes, I don't think digging into the esoterica of eaa0fd6584 is worth
your time. But knowing that it is confirming upload-pack as v2 might
make it easier (and hopefully it is clear that this new patch retains
that behavior in its "expect").

-Peff
