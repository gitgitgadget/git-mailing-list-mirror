Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384811;
	b=ePaQvfswIX2fM6BZbaFhGa++F4hWEvfj5s88dAcoA+7M4e4r8YIDECt79XKWQ6AtW+XO
	 Sj6CGLPhOvYva9sl+Nx5mF4Zq0UvgYfUj5KGiiW8VH5uXn60cakSi22zKCmQuj3K3q3n8
	 Ak/UfuOMhQ4BJwAAVT88FL02XU2+zgcGaosc6qWNV/ZA3BOe/JsGVfIuf2kqUUDtWl+dL
	 OmNj1jyi3LHsqD87cvjR+RuHPbAVO6n/PdKBl1s8+I+7ycn7ekU9sNUZkcTB6CrNuKnpD
	 4juX+uvgLQzNpGP/FQP/uSnQ9dT5mrKFi/ZhKLG9MXXJ22dos2pbq9mBI1UgYdZONTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384811;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=tJS0PLfY9V4bqxjTrMINud4hbejBAxEbNANmIcQZBDM=;
	b=RD1DhhWdRDL5llTyI4qyiHrMs5puTaOadTrNsdW8teK2vmsWBEXOnOyVzui0oUZmFLNa
	 asCHeqLJWqDurPueQB89+2qrjtmBLJ35JBM+yxfGox2TVCfFzDHk1vLCZigRNKaiWXwgo
	 p4Gn3G/+tU79GX2nRjJ71Xa6Jqxy/qqBHUacpeXwNK823XCAxafAaAZa2EyW/V+CybeM/
	 djvTCh5kmhxNraFRf5WA60mWX/n/pSP/Z7Sp1WRBbLF74Ny6bg8c2CdeIwS5SrVTo2GQ1
	 3svUM88Cr5q6Ay5Q+MSRFjBXZHHekFN+jlqymeM851YSmplNOPYThfvH+r+QBLXqofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=hKIZCPSp;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857F606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C857F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=hKIZCPSp
Received: (qmail 49307 invoked by uid 106); 30 Oct 2026 18:26:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FdJX+wcscFdCBMrTagX1WYQzcVjL/leHb9KEwiJ+/Tk=; b=hKIZCPSplGkeLTfpr7YOAPdvdA4XzJ1FP2UJARWyx2orBDOV0Eb1mQbQM5xgSx8KgCFP3QNBA9EEZgCabXZTzZY0qxhhtbW/gxrZFlLC0hNA6PHv0lEpGQHHvZJkx2sxxGeXoyh9rdQ0uAOkU3LAaTwr1Id6rIbnO4V6/3QTvKSPnnl2OE3c+iDt3h/7QgJwg4qT4qThusADCEFezNRa2QUhaQ00Ypkk//WcAybqgk44ldq+xbZJztO6W7/8ePjZ/rFgEbaSFRK8hFY/YY08IoHsn/RSOIjDS5ElkGChKSuV0tHTcpXSqStEhBgYgURDMO7PczmednRw/JObJySEJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2026 18:26:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 323547 invoked by uid 111); 30 Oct 2026 18:26:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2026 14:26:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Oct 2026 14:26:48 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] mark symbols that are unnecessarily public static
Message-ID: <20261030182648.GE7582@coredump.intra.peff.net>
References: <20261030173956.585250-1-gitster@pobox.com>
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
In-Reply-To: <20261030173956.585250-1-gitster@pobox.com>

On Fri, Oct 30, 2026 at 10:39:52AM -0700, Junio C Hamano wrote:

> Over the years, refactoring various subsystems, adding new callers,
> and rewriting them from scratch, made some symbols that started as
> static into global, and some other symbols that started as global,
> no longer need to be visible outside a file that use them.  Here is
> a small patch series that turns them back into file-scope static.
> 
> Honestly, I suspect that [3/4] was probably better with a forward
> declaration in the preview I sent earlier, but in the longer term,
> readers would not care if this conversion ended up in a large code
> movement, as they do not have to even know it.

The subject for patch 1 caught my eye, but I eyeballed the whole series
and they all look reasonable to me. I agree that big code movement is
sometimes annoying in a diff, but the flip side is that the resulting
file is nicer to read and maintain.

-Peff
