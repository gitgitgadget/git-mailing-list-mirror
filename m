Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.145.225.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812461;
	b=qr0Ub/cikPf+pzUa3gOJ/QMrAyuoFImwqjcWGVin7grg7Il9eyungZjKQaqCwo7uzoTo
	 Q5YesgUDElXpzVj1D3+5+XKRbVpx3Wg/hVVvGuQ6p89wJNG94bHzA0qaWvQi77tyEa8wC
	 uw9y1vIUyGlkkbEl0oqaQgaYJ1yT++1ZsyEQv7Pvo+npBpPSnKa0QWJ86sFYdFJVI4rrG
	 v3wU9UodUoDvQSTMzoC9p1ZoDAZ2YWjcfiPac7JDX/bObuL9rPDJGXuRtWoZbBjTgpGIV
	 O8izFVQw7GJPCHxjHUAeTHC4QhhIiVT4X2IOxbKtsB75qHQ7yjWrqboXpkxY6vKYvgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812461;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:From:
	 Content-Language:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8cRp1ilJvI00JWUW2yF7cNrGZEf1axtuM85a3lL+HsU=;
	b=vUuXFWR3846zywIwaZSP1CY9pNSyWNpZU0SpWoyL/QKtIsMYNb+V0rbkaEGXzspoX1Mi
	 HHoZEmHV0VfN2xU9ypeFnxvtPkeAS3XUtHJvFpRjtOF8r8OGz8+wQZQmG1M1rgs0VdowJ
	 E3+KLI6ZXT4+qS8BRL3G7syvYYNCURDyeMylrCslV1H0Oce/XDgyYqbRInzmUB3+kA4Xz
	 dsae4L8IAAejcQao5Eq0yPvWhVBxkSDqR8EXjocBLVBlzpobRM4nMFc9k5LSotCb95mMa
	 qsLxNvBuNdjoFcsRHnrUlWMRs+evfc3Te1kcamoYy1i5et/d4v0Vkj9wRr+uGlLlUlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=syntevo.com;
	spf=pass smtp.mailfrom=syntevo.com;
	dkim=pass header.d=syntevo.com header.i=@syntevo.com header.a=rsa-sha256 header.s=dkim header.b=cTJbAixs;
	arc=none smtp.remote-ip=213.145.225.180
Received: from host45.ssl-net.net (host45.ssl-net.net [213.145.225.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C1606D821
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 891C1606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syntevo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntevo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=syntevo.com header.i=@syntevo.com header.a=rsa-sha256 header.s=dkim header.b=cTJbAixs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=syntevo.com; s=dkim; h=Message-ID:Date:MIME-Version:User-Agent:
	Subject:To:References:From:Content-Language:Cc:In-Reply-To:
	Content-Type:Content-Transfer-Encoding; bh=8cRp1ilJvI00JWUW2yF7c
	NrGZEf1axtuM85a3lL+HsU=; b=cTJbAixs6FE9ywil1KaMg+4YJk1NhAcyFBdvS
	xEMQ4523dS8at+gvS861i3SSMRpgGK7BRszEH8Aipap5UbQ+BQr7O9BRfFcCTG36
	JSS8rS70VvelMRZAL1xbDkVs1hKitB4QjDGj9AGLM2b1PIHydutAfeEYza+2ZNJs
	7A3JOvxl5gt/uoBWKnhopfJ6PcTHcdZYghswAAG8tmFQ/YdTJ341p6TnRROB/Ohh
	VuJ3PityhL5UQ8r5GG5Qj+rIJ4bpd4mqNDGhP0VcvcFEqBff7Ycp9qOC63nJb46B
	7XNjxygzcUWLIWOzti9g2Sq49eKTgpWhBzU0FvBnt9Vb3WrIg==
Received: (qmail 2545320 invoked by uid 7799); 4 Nov 2026 18:14:12 +0100
Received: by simscan 1.4.0 ppid: 2545278, pid: 2545313, t: 0.5829s
         scanners: clamav: 1.4.3/m:63/d:28173
Received: from unknown (HELO ?192.168.92.21?) (marc.strapetz@syntevo.com@91.113.179.170) by host45.ssl-net.net with SMTP [55222]; 4 Nov 2026 18:14:12 +0100
Message-ID: <54bbe02c-3319-477e-a9d9-024ef7027142@syntevo.com>
Date: Wed, 4 Nov 2026 18:13:55 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] send-pack: avoid resending unchanged objects after
 rebasing
To: git@vger.kernel.org
References: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
From: Marc Strapetz <marc.strapetz@syntevo.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2026 16:46, Marc Strapetz via GitGitGadget wrote:
> This series teaches send-pack to request inspection of the old tip's tree
> before packing, so more receiver-known objects can be excluded.
I'd like to give this series one more try, because I think the default
push path still misses a worthwhile optimization opportunity.

Rebase-and-force-update workflows are common enough that avoiding
redundant transfer on the default path appears worth evaluating. Junio
pointed out that push negotiation addresses the same general problem.
This series instead targets the non-negotiated default path: it uses the
already advertised old destination tip, with no additional round trip,
server change, or protocol change.

For qualifying non-fast-forward branch updates, this series can avoid
resending objects already present at the destination. This can reduce
pack size and network transfer, as well as client-side packing and
server-side receive and indexing work. The scope is narrow: ordinary
fast-forward pushes are unaffected, and the additional inspection is
limited to forced updates with a locally available old tip.

The current measurements show both the potential and the tradeoff: the
small cases improve, while the low-benefit worst-case fixture adds about
8% packing time for a negligible size reduction. These measurements
cover only local pack generation; they do not include the primary
expected benefits of a smaller pack: reduced network transfer and less
receive and indexing work on the server. I would appreciate another look
at whether this targeted optimization is worthwhile on the default path,
and whether its current scope is narrow enough.

I've added Taylor and Derrick because of their work on pack generation
and revision traversal. I'd be interested to hear whether this looks
like a reasonable tradeoff for rewritten branch updates, or whether
there is a simpler approach worth exploring.

-Marc




