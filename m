Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136231;
	b=yvuIByKcx83FScJJYCIWA3+awGILr2BNm2txyCz+xSb3hDmPTF+GrTYnchuOOlpdQ3II
	 XR4QX06d9ph6rFttBFv9GnrHlpo5fdgZJcnpfbhCWBiyGUo5FKl/5/0QPfwNuUQj/n42l
	 k+ANfMllES+cP+7n9uzuICmz8FGCrL7jysdWxCqlK452MTEqo1wPGBx76jtLSFfDT4AWo
	 h/SZyqRnwd6n28lwZ9xb4qZqByZEVWwKrzMkJYVvTTwPzzUyvT4c3onbju3aV6+yCaDoA
	 4rjMb2j2nQNqhP5IbGXmp1feDBWFDMpMhk3MJFptOUaXvRG6Qy7ADas9wHiIhXy364w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136231;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YFc2xReHOfW6IkRZgNSfBkpOwZNSPy44gb1VRaK3/VQ=;
	b=s/9vCe7MnRAZ5uN8mR1yt1kt+1SO6Cj9UxGiI+q0ZBCGqChMXSq8jHDl0LGUTBRI4R6U
	 gQ0jDyXSZuZr2fjb3dHTEgBbPdE56We5vmOxYnic84HiaIAAx2Q9fv/YeOn5YQflkS3GK
	 7IesOFWScHHm9ZASkFdkBkIYakbHvjzdGpw+iSZG4pGMXa4edbD4nxfCXWY34pxrTEoJh
	 M4hYSHFQQmbuSCIFC9RWhZVdYg8kTUM9Hl3fTDM7iVjqTrh7aVrG1BrGZCKU4QJA75ZUX
	 0YUA/enqAtN4NlKKj3DjsbNxlhhZ7AzamcF460uWBwbSbv5gxVrayjlFVduEZxTxsRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=fowRoHFp;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E3606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 21:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=fowRoHFp
Received: (qmail 39185 invoked by uid 106); 27 Oct 2026 21:23:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=997pNS8A9NZoBH+mBetqNyQU+OZ3H6FeQp9x1MfWwts=; b=fowRoHFp/n/kYhzym/S0pPIic4KHzE+XY+elubfPOp3FTO1TBKxftst0bstEj6AzWkfVpXnKvoxsNeMjwW9PtB53AwsNZXxGCMPAXj4yJkjAcDOc8484wJYX0Mz7MQmM9AkUZlCUeC3ucwK3sIPEw8B/0sjeditUslq5HT+VqXoi9hoagr7ifKNSUx9piJdpuBi1Mz3f2jVkyQfbWNmsw0pR8XipBmcAoVPBVTWGqU/osx7pyodIFmRxqab1qic2M2BjCey9MpLMd4yUA100/z0LFjeijhl3mF1JhpkbOqrR7JG7fV3XMRP54ck2/eGz72l6v/s1D0XAXuR3PHuy+A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 21:23:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 278681 invoked by uid 111); 27 Oct 2026 21:23:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 17:23:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 17:23:49 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
Message-ID: <20261027212349.GA774120@coredump.intra.peff.net>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
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
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>

On Tue, Oct 27, 2026 at 09:18:28AM +0100, Patrick Steinhardt wrote:

> Due to the job being special it has a higher potential of failing even
> though a local test run succeeds. But running these tests locally with
> the same environment is somewhat painful, as the developer has to
> manually set all of these environment variables.

OK. I've usually just cut-and-paste them, as my first step is figuring
out which is the culprit anyway. My biggest question was: what if the
culprit is a build flag, and indeed, we leave the one build flag here:

>  linux-feature-testbed)
>  	export OPENSSL_SHA1_UNSAFE=YesPlease
> -	export GIT_TEST_SPLIT_INDEX=yes
> -	export GIT_TEST_FULL_IN_PACK_ARRAY=true
> -	export GIT_TEST_OE_SIZE=10
> -	export GIT_TEST_OE_DELTA_SIZE=5
> -	export GIT_TEST_COMMIT_GRAPH=1
> -	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
> -	export GIT_TEST_MULTI_PACK_INDEX=1
> -	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
> -	export GIT_TEST_NO_WRITE_REV_INDEX=1
> -	export GIT_TEST_CHECKOUT_WORKERS=2
> -	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
> +	GIT_TEST_OPTS="$GIT_TEST_OPTS --feature-testbed"

which makes this feature only half-work (well, 11/12 if we want to be
pedantic).

IMHO this whole thing isn't really worth the complexity, but if we are
going to do it, should it be "make FEATURE_TESTBED=1", and then that
enables the right build knobs, and test-lib.sh respects that variable
coming from BUILD-OPTIONS rather than the command line?

-Peff
