Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63E320A14
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473085; cv=none; b=NuFa86A5YXpTKrvSE8YLB5P83bZw+jTKJjyTN3Fbv5mPsqKT+pNxDEf01xCyYviB77eV8PpuyYSJtyU7jPgN7e7Dmosw4uNs6Vt8PuqWTMXyWni/HWEbBfqa7pZn5e/We25L8tgbBbbWNjN3yCUbw5gedOUmICWKQY6wVThLS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473085; c=relaxed/simple;
	bh=0+ZdXseRIhatNaOx//tLlNLUqqn3uZ9kKAS0+GbfMi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4n+pbbwvW/altGfVIAt/OFfqNY0eXyRo2EMTWdxqG3SQMi3CVSD+/RppsOT97JvvbRNowKBkUjGxG72PI8h0OSsv0pkSe8n3aiVahmJlp50yx9PyBDYS0+OB6xmPbrKL3WMAZsIs3+Oigj3nf++9apy/ZGiPhaLlWfLG0SbkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=EDwQKbCC; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="EDwQKbCC"
Date: Wed, 3 Jun 2026 15:50:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780473081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+ZdXseRIhatNaOx//tLlNLUqqn3uZ9kKAS0+GbfMi0=;
	b=EDwQKbCC+eV/yoN+jsBdmdDdkj/ngFR/hDBcpkRwrVLR2K1/YjTu/Hc1nJRWst6DEaEyqn
	+/52iSV2XS6H2T0+KWd+KYNet0xO3+Fc/uJ61AgeKtr1zUWqSw2jy6ZraoBmNnvs7iOWCy
	WGB+Cqnq+C4j/yIrkizP1/MEeilxTtueKZpufmgrfifmh87GZZ5SgW6ujGSrkemUFV/FVZ
	uiqjGFiK6PWtr1sf3iylJ1trCcQ0JBDbRp2eKLqlVsevdInBNdhc4qpvQWwR2yRt6LeYkx
	15H+w7NNkR0agR8fELx4bS0xJyYiHdSq9g9Lw8C5tpfhw+ZTlUrxw5C6JeJNbA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <ah_c3kgmfRh3bXns@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_PyDwO1Sffr5yq@pks.im>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 03, 2026 at 08:55:04AM +0200, Patrick Steinhardt wrote:
> So this quote is definitely at odds with the configuration I have
> proposed. It's actually quite surprising to me that we recommend deep
> threading -- I personally find it extremely hard to navigate as the
> nesting eventually gets way too deep.

Sorry I'm a little confused. The example thread at git-scm.com:

https://git-scm.com/docs/MyFirstContribution#ready-to-share

Isn't this actually supporting shallow nesting?

> It's actually quite surprising to me that we recommend deep
> threading -- I personally find it extremely hard to navigate as the
> nesting eventually gets way too deep.

In my understanding, deep threading == --chain-reply-to, so can you
point out where do Git recommend deep threading? I always thought Git
supports shallow threading.

Thanks! And please forgive me if I am wrong :-)
