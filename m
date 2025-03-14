Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622101E5B9E
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977694; cv=none; b=PwnvjFvUQEbtIzdzQCjKfNaNjGJqlIKy86BrEQFowshJTxdTULphuDlzAaTkJaMzQgGQPGGCWbLYdZC/bdbKgOxeX7dJ8frUizxJftROx3a/aP864YqiPGOt72WFQsU4lSQFqYwzmXPbAC6RSYmy2gzTcnb+tMZFxtZyrTaOivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977694; c=relaxed/simple;
	bh=8Py0mWF16hVt2lTe3cIV5NqWPCJ8J7LJ3CZrdLtfIJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFrc7lVeL4StAeMyb5L42mCCVmmH3T07D42j8FLuZvLwY34fXH/JCCQh1ZIUra/Vx9aiudOkBqFk5t+Ipq0BCSHDQCeBbrvlED2qRtl77sDdxRculGVx3vDaKVJ1w1M+8sJCxkSux/45ryyB7cefqtzehRx7wz3eM4kLmGm/7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WkJ1h8vR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WkJ1h8vR"
Received: (qmail 23138 invoked by uid 109); 14 Mar 2025 18:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8Py0mWF16hVt2lTe3cIV5NqWPCJ8J7LJ3CZrdLtfIJU=; b=WkJ1h8vRfSjFdkIgJ0MNwdUbnaAL2FMEfwUGxudUgFi4a4n/K8lR4ecXLEpXE0/JgRZpdeiGbikedXcy70YGLRhySc/YNBfxaR6qC+Oyih5uF1CYn0YePPJNg9SdPOWrcQ9GnwxkbaFlodXR8HBZCbTCym/Bc7otrd7lEhWOdZQDCs8OcWN3zacy/MC2a0uDwN5miJXvhsBwRZKpoO8tvn/pCwlrrfd024isZc+6wCmgyvFP1fX3Y1zYMGgfel5VQy+noa8cStP+6MyODt6rU+9QvE3mKlNROpHL838Ow4t+ADN34GodaNlcXF+1nWCOQO1wObrkBRMvDTGe04Wx4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 18:41:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7734 invoked by uid 111); 14 Mar 2025 18:41:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 14:41:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 14:41:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #04; Fri, 14)
Message-ID: <20250314184130.GA578421@coredump.intra.peff.net>
References: <xmqqv7sbfra0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7sbfra0.fsf@gitster.g>

On Fri, Mar 14, 2025 at 10:36:39AM -0700, Junio C Hamano wrote:

> * ps/ci-meson-check-build-docs (2025-03-12) 1 commit
>  - ci: perform build and smoke tests for Meson docs
> 
>  CI update.
> 
>  Will merge to 'next'.
>  source: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>

I didn't dig into it, but I'd imagine this topic is the source of CI
failures on the "documentation" job like this:

  2025-03-14T17:50:13.8749066Z + meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
  2025-03-14T17:50:13.8752287Z ci/test-documentation.sh: line 50: meson: command not found
  2025-03-14T17:50:13.8769502Z ##[error]Process completed with exit code 127.

that I'm seeing in jch (and looks like you have a similar one in the
latest build of 'seen')

-Peff
