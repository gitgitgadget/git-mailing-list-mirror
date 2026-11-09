Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265759;
	b=gyXXP8xcAefCgXzHPm9nFyRqcu6JlCyDb1N+IXj+tvMUJPlOcjm/wBqckUPv4q080hR1
	 6pm4/Ry18ibC12Dn+g1eoXDMIOStmTABAzqw8DdHKThChXM3bnfGt8faHzKqIU752J6du
	 NFG+Auz4ff37TX1kp2POc9m1zzymV3WuZ3vApEZytHCeaMeNRvugZSPprEJwV9Acx0Ecs
	 +mr6Ts0rUi/5CP+mdwxW0bith/8IAFyh3ePQrhi7PwGuYgnabpsmq0Pu+JzIfC2jCkhms
	 p0LMYThtMQNodmP19zsBNGB2w38y25SsZQQJfZprjV4QIYrk0jGMmYRR2MG8q3zAbgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265759;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1+3CQm+TkVxYIjnLdB2krr1IR8KhRfEoWvN81jEG41A=;
	b=De4luagJNA/Ga8xrmsQCQSeDm1ccYVNiiUep7uJo1P6NmXAyUTk1p3xJcsmG8El6Vq4G
	 MdXsxriSvOrtMET2hyCH0sS0ckRcZwpzWwr1mLZ8wDbhJXQW1pWzNEa3/TH8jTCUT48/k
	 S/iyTTD9cQIGIlyg08U3HFx6NlFa2s+PjEwt1D+pyjehKosa+FB9mkA0LSwX3FXq8EiFw
	 bg5sbV1EENj8qQ01LROZwRGGtokhdDUEqR4xS3i2JZR07Mk70P1MTUVakQbaJl25JvDwy
	 1Je6MiHV18h8Iuamx6NGiDFG06w8xazy7LXTVvm/nMJFQ04f/OZnBwtR2JMO5y992VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b="L/QZiFD4";
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F35606A32A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 23:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F35606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=L/QZiFD4
Received: (qmail 2739 invoked by uid 106); 9 Nov 2026 23:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wdzk8vaftlh78fgrCqcSL2HZNpNmIeQmeIl4L7hjE8U=; b=L/QZiFD4aHuarQtL3VrHBmJ+9M90Y4UKvh4/qQPQuaS1gTQoNbEK6Bt0NoN21AgUFZj62aVQPDRvH+nk8P3PPJgoeiAsIGCjaOdlIGrFBreDNSy866YHJaeeP/tYO/kCz5+3RKXc3uD3G4V29yy3yupbjQ68omzvlI4vTfOp6T0XceWDJcADd9Ih/MPTYC8diGqy6LKUjCj5lKz0bmOsrDeGdekbo/RXX1627S9n7jKe91hnqH6SsoP4GzaP9tAMCBuo+YD1vQHzPeRlH2i88NzhBO1J/6YXzRu+hb7D20TXrvlBJ78/IcMURrO30Usz7GkGZETrKl8mKOH5rpJMyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2026 23:09:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 162152 invoked by uid 111); 9 Nov 2026 23:09:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2026 18:09:16 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Nov 2026 18:09:16 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Message-ID: <20261109230916.GA1347453@coredump.intra.peff.net>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
 <20261108023730.GA1242909@coredump.intra.peff.net>
 <xmqqa4nhwstl.fsf@gitster.g>
 <xmqqo6bxvdbf.fsf@gitster.g>
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
In-Reply-To: <xmqqo6bxvdbf.fsf@gitster.g>

On Mon, Nov 09, 2026 at 02:40:20PM -0800, Junio C Hamano wrote:

> > In any case, I'll queue another SQUASH??? commit on top of the topic
> > until v3 materiazlies to fix these issues we have accumulated so
> > far.
> 
> And I realized that we need yet another SQUASH to address "isn't it
> a value of another option?"  point.

Thanks, both of these squashes look good to me, and address all the
issues I saw.

-Peff
