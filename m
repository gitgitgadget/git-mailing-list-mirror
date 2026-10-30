Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793344739;
	b=EoyHo3R6+0IEmPSu/BuOo/xICUGC9yo6q/ps1g8rOQQUoBmcm1KzRAbt3TDdmYkiOYDK
	 0deNqqb+fao9fgSoIstQtYpeIxrXpozPBkVXjktBxj9WJg/BPZ8rBfzI79gt4CtS4Xulq
	 aG280fL16Ylz++MM2n6DnWGQVfXkyxflFSZMalAfVXzMWYXdNFV1ek14Wexjr7thB/41/
	 AymSgArnV9VL8qhgP4PuzfZ+cd7r8s2j5IiFEr6sbKF2ijS1+YYk98RK2lLFvnc3PLkMr
	 v2DhwuQBVkU4KiFgqkajK64FDZsmLM+vmn3MiQ480Wj11OD36Zf0nQj8LZc338nDQRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344739;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r4EiQHW2g0+7TV/oZpvYKfHpVY/ONZvF16gzpSqchwQ=;
	b=m5KrkHYDdUH8ckIVXI6nLbpW1q+LzGlBUgHQ/nMVVCqr3dGCTnjP65UcFvkAJGEM7SJW
	 eQmr2Yf1MGbjGd5YXLLMJ1a++tkqvM8FdYqqANf4tL1n97c26KiIrpoWP3M3+XHrZsJuZ
	 irTMUyFljIqgDqmAsZ0n9sUFljJZggDCZugfV1YOlkXjOGD65J7lRrrqcVpTea1BnaN9j
	 UbwwKwbm9o9Rz95VOnoQvRCwrhjxVOPxjAlg/xWmWReHYr0rK3VUYydcNPmmxzFbVoyRX
	 Pv9ZMOCqUjPdW4JdHKVcWREaQAGp4CJcpkOrR7tkTv5N9x9s6gLpx6sYFqTpzzT7+XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=UP+SyZdD;
	arc=none smtp.remote-ip=91.218.175.215
Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EE606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C79EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=UP+SyZdD
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ltiV7ImHLqFD/KJrYFJ8/gJws8IGqSBsIIR/RnXHUM8=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793344735; v=1; x=1793949535;
 b=UP+SyZdDgXmyEzed7ortAmqYCw6VCDW/zN6HNEPNlwoUGTl521+w3uE3EM3N3NbaBmdlc+yr
 vstBjg0ok94Kq1o4v2SMhm0PZnWs51+jrkbmtWzbrebcJIplN6MZoD08AIlsOHMc6sdVJdU+JU0
 8Ok+5ubgvTYPhbCl1KUuq80lp5peGBFHpKTn5uospjls8w1fJGwtf50YaFiDdiR50jFHw5LNV+C
 g9i8r6mIMvWXg7rknLA1OCnWOysv73PY0oLdmqfDnoFuSz0GNMq8V6S5tG07XMQmTHPzFzBMLa6
 D0LODpxdDHFPbEZ3JRzFpkww0U4OCFpZB+xHCqsUSMgCw==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 152bd12924c9a0a0;
	Fri, 30 Oct 2026 07:18:55 +0000
X-Mizu-Trace-ID: 152bd12924c9a0a0
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 15:18:51 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Toon Claes <toon@iotcl.com>
Cc: Tuomas Ahola <taahol@utu.fi>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <auRE2-j199jZW2YO@wyuan.org>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <atysi3EHNTCUpvrT@wyuan.org>
 <87ik2jzoe6.fsf@dev.null.iotcl.com.invalid>
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
In-Reply-To: <87ik2jzoe6.fsf@dev.null.iotcl.com.invalid>

Toon Claes <toon@iotcl.com> writes:

> Weijie Yuan <wy@wyuan.org> writes:
> 
> > Although I could selfishly say that I'd like to have a vote, since I
> > might just meet the threshold in Junio's example, I'm rather afraid that
> > I'm not qualified enough and don't have the kind of foresight like Junio
> > and Peff have to justify having an equal say in Git's direction.
> 
> Well the voting system should allow you to "abstain" when you are
> allowed to vote but do not wish to cast a vote.

Yes, and btw glad to see the discussion on the setting of the threshold.

> On the other hand, I don't think topics on which Junio would have a
> strong opinion about will be opened up to voting. Voting should be
> used in situations where opinions are spread.

Agreed. Thanks.
