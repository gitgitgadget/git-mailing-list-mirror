Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99884D02
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568171; cv=none; b=Rdu69FrOggt4Y/JB/sltMhNKbNMpsFb1aTbYyHfixSgeI8OzcdmGcxsM7QJocKT9OQXucZYzSLCSepI0OmJ3tCR36UeDuUUveRFvg6I1mOtJ7uj8nllzLv8FbsLzQ2SSRttJIRxrF7DaurGL6No8HXqa2UVBf7X3YRyVGIcJTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568171; c=relaxed/simple;
	bh=d9BBQ/nnxsheGoQPvpK8d9/Ul9jMalLryhmjjq3wY9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2b1jF0yI7iVCq8zxL+Scofea1LbWeANA7gJa586Kh1L7BTaeV7lotSG/iANEvsdRcslUTVWYwtiDSp+M38GX0KFQKUkNVObsi8YsoameC/esRGNxPLtpEuakOQYbNEPEw/IBvnG/uxe8Q59clbNlyz6kQiN5gJrkJOdLaDk1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O0OdSn5j; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O0OdSn5j"
Received: (qmail 161877 invoked by uid 109); 22 Sep 2025 19:09:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=d9BBQ/nnxsheGoQPvpK8d9/Ul9jMalLryhmjjq3wY9Q=; b=O0OdSn5jRUj4ZZqc79JFOQWQ13wlUDpS1y475dYqW5pfdih+VSdnPGbzAJuvMaOrYP8A3Aw5o/eBUTVDrb1RdGF3qNiqi4goZAEWKwdSyCbzaE9GeV7ww6PUaPBci581JUBQED/cubaew9eigqDf4qzDiuSe0twXOBbxoZfYOlaPiVYg56N8R/8jjYEBbv9aTclMxgDq2v10la7X8VQbYY+fpgEFk6ExmFLS73tESTNaezukutbvlsHSUzbSxjfxaYV3xhhoW20PyXBMZTpFAj63tL02mBQiTRGzg/OuyBWeWOhJrXKjIl3z7WzwZoLJG6zf9II+2tCL9CrpZxYvGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 19:09:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 258801 invoked by uid 111); 22 Sep 2025 19:09:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 15:09:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 15:09:28 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH] t/unit-tests: update to 10e96bc
Message-ID: <20250922190928.GB2205919@coredump.intra.peff.net>
References: <20250922-pks-clar-update-v1-1-9154e7d1b7a1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922-pks-clar-update-v1-1-9154e7d1b7a1@pks.im>

On Mon, Sep 22, 2025 at 03:16:11PM +0200, Patrick Steinhardt wrote:

> Update to 10e96bc (Merge pull request #127 from
> pks-gitlab/pks-ci-improvements, 2025-09-22). This commit includes a
> couple of changes:
> 
>   - The GitHub CI has been updated to include a 32 bit CI job.
>     Furthermore, the jobs now compile with "-Werror" and more warnings
>     enabled.
> 
>   - An issue was addressed where `uintptr_t` is not available on
>     NonStop [1].

Thanks, the uintptr_t solution looks reasonable to me based on the
earlier discussion. I don't really have the context to review the rest
of it, but it builds and passes tests for me here. ;)

-Peff
