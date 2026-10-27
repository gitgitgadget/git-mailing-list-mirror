Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123084;
	b=SdIKX9ocWgRTIgx1vrGXlJ63LSA4fOVBctDNLOB+W5auk671waHGyVoIRtOzHsJHWXQY
	 HEam75E8UHdhql1U+UAspCeJDJESnYTT+DO6V5OZjkyfICCUg6tcO96XvjVLUdb0QK6zX
	 jcZEflSFYOzQbqaleZaYwjs4PfLQAhL7omfCsAMCGBro7PABoIC0pu7KbtuGoJ3cEPIKg
	 j/o1tmAiRjBwzg5zAvaQ/Yun5D+4IySDhLuauCom86GSe6u4r05PwAnS4q0pXkkNQf2qT
	 +0gPWhMWhpUQsidAG2lP9yQzBdJOvomoYXLB8LbyZnmqx7y4KpF+7NFw5xiclQCGtkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123084;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Lsmf6poNODJP67yJ+yeHV6YanQsNTX+gZfidstaisjg=;
	b=tV0D2CGFQxE94GoQM5KdZfhvABfrgHh+5g8x1K2YVZdeQUGWb9Xyrg1JhXTE/G+tXDcy
	 vCwKTkc4Y9/5YS5vO0u56JS8lGw4CCUAHEclVtWzPlqeiDck0j135iAzdcYFf79Ob9hmV
	 JWmjxXLlDTaY4fKvGCRpTKFce6Xwb0pV23gAI5sH2i3cvJR7WHt8aq8W8iQacf+BrBX6X
	 Z3dL7F2CmFz3JK1C2bi0CUox4EhRojxP3S5p7BxeJwF+vJVq7QtPLbQ7AYy2mL693e1r3
	 u4NEROfGZ9LtYWM76hRdK1sC1DMNEOW/+YrEVth2jcv7kruen8M2coPBA4A3pnnvUnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=huPPiinx;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DD606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E13DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=huPPiinx
Received: (qmail 38430 invoked by uid 106); 27 Oct 2026 17:44:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/9Xc/Fhu+GkQHKajGhfQszfapOgut6qB+6QM5FcrOBk=; b=huPPiinxwzvAPH/2O7p0yeYvnI/xI8kGP66Ecxgby7jNwzved3UMCc/MNyDcQ7EcZvWI+i6rLo0oUzI5Kd6M4TOdo1h83HnuyLaVztm6odohg7UuBiKUs7g3qAxevUKhMCg5oM4xfkf2w7+NY5yzqfnZOzJEHDLm1c9DaTSHvvbpPsUGXQUW00DPcylzdHI636DTnmC2uCtRbm7ETkuXHFY7xZhBD3jF8Ie3hhvQRy+KLH1C1V/9dD45DxV45nixyzvnqb6ranVuDtoNDlDzrlPM+iKjq4f04K2Ce1AYghHEaeZLa/O70wb4/n8ErQhtM9Q07AY91nyisf3iYoGz5g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:44:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 276075 invoked by uid 111); 27 Oct 2026 17:44:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:44:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:44:42 -0400
From: Jeff King <peff@peff.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/2] Make our clar tests ignore the long-tests argument
Message-ID: <20261027174442.GA97882@coredump.intra.peff.net>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
 <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>
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
In-Reply-To: <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>

On Mon, Oct 26, 2026 at 01:01:03PM +0530, Kaartic Sivaraam wrote:

> On searching for how these were handled before, I stumbled across
> 9faf3963b6 (t: introduce compatibility options to clar-based tests,
> 2024-12-13) which handled this by adding such arguments as NOOP
> arguments to t/unit-tests/unit-test.c. So, this patch does the same
> to make unit-test ignore the '-l' passed to it.

Your patch looks obviously good, but it prompted me to polish and send
in a much larger fix that I think makes this fallback option parsing
obsolete:

  https://lore.kernel.org/git/20261027173205.GA97799@coredump.intra.peff.net/

I don't propose to replace your series here with mine, but just that you
might be interested in it. ;)

-Peff
