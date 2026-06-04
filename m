Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A7224234
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535386; cv=none; b=mBRGFtXsmh/6ek6bwCnSLWRYXtdW4NXzZDOWDg10OMzxNxkGLuJba8hQ9jq3DdP+ej/2Ikozw5AhSNlxkBpT62KkOA8Ub3VEVJ2KARgIVGJeJ/6roDE5sJDr6rbcZoxH98zYkM4t5CBbOkd5E9oCSBaji7hhn14Wmp+L7bTgYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535386; c=relaxed/simple;
	bh=kMzqZ7EqPKr6GreOmzr7qTZ+e6zZdKyXwpWiIEB15Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eveOBNi2Rdp7Qakin0x8plfmwC8zXBK4z185O30/uqxo9A++8kOOinXHzlxBznLpav/6Cq1Sk4GHto5b3xGAIxhP+U3YgFG/fPzi+lobzdk+VWS+qALPe0XGN5qIpPmTVT3ZI/SI64K5/1SQflO6XAlSFaeXIOOWgfDNjsfEe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iCDjGIbz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkhg4m3g; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iCDjGIbz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkhg4m3g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 78C9214000CB;
	Wed,  3 Jun 2026 21:09:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 21:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780535384; x=1780621784; bh=xsx3DMv1CZ
	jR6tevD3vBGUpFtm7CzzHXHWdsAI3JaFw=; b=iCDjGIbzMEj8wkzBJk7lYBsjVI
	0oUUC566tNBO9Jvl5Cuibk2gj+KppzXUJt3xCkz35RcF4B9Pdv0qLxDDBvTpwfku
	mKOGRUL74E3Up085+X055VZxf7KxnlNwUOPFvAWRpEtl+vEtEU243aVwIObBbOXs
	RsP05r+Q2JrbbR9lCYZSKh6MxaLYL1ykM2DJE0Mf25zJzQiEvTTaAuQvQb+5+lIC
	hRMzvjTRGHrKa6+2oNOT7tHwkhIxR16elAe9j9CSUlvxWkOyytnRgCmxQRLwPkoF
	kCHeS7wyH7MSPEnLLlCr+MHzjBZCjMLz27SQSid4TTwcX/qofxi8GlAT0Eew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780535384; x=1780621784; bh=xsx3DMv1CZjR6tevD3vBGUpFtm7CzzHXHWd
	sAI3JaFw=; b=hkhg4m3gjZPqnOZqwGuvzH1N7oLStOmXWiBJjwEHxGTRmEATZF1
	wjjEDxWzei+61OfOs53wDkGCeH/a2vMxT5YefsNB0XTP6tp8PS8q6DjFfOqBIV1S
	do21W28BEpIjVgh2nAUGPfOvT0b8tENEDe2N1PbYSefWxMvCIN9fFKCWKvNyQHaK
	KyueUE0emjvm1q/XQsFKIoKLJHlsaAB059yeGK8upislvD1k83SSH11OzoH4cQD8
	fupN1R2NGz1GmGPfzNezsQqtvSBcvoN4KrFkJ0zcsLRtuXbwFkTLUEIvXDvks454
	k3TErrWNvRlXtlm7jHR6LTQpT21F0VEjQzQ==
X-ME-Sender: <xms:WNAgasGWkJlHCc-Q9h6RYwQII6wfDNO1NLIn5j3xEwOXsEp5KLIbDg>
    <xme:WNAgasVWHAXuC3cLsAH89nr8tBdkgneb49bTGkPor0ovyy88sEcKdjGO-MFa_zpeG
    S7kuTpPEYhg8HRy9iaurTWHmxlU_TNkwWZNW44uank9hLm4-ty6-Q>
X-ME-Received: <xmr:WNAgarL9i-ShCnRQRpnRsKfi6kloNvMMPCu4NN56vQdujy50KKFjf0B89HyHqxctSlF0R2SXyIKwM3M2GS-M6QEuCDXZqcRrA-aL>
X-ME-Proxy-Cause: dmFkZTEf5jOQN56N+PrC68+68EuVO2CQzF7pUqcSYNt5BhvbaKy9mv5I/xZ0U5LQgiOFAx
    y4vdv6u6jNaCM0PKlnFP3Y10WiVciN2rhgu/o5VB6NT+N3F9ZWF9u2mhTklNOpSFe1XzsW
    Lg2huv7ZXlF3oYM8rQOKQ2ZDcZviOHRRTLS7lT9L4eSlMGcMdkURdljWqE6vPYPhLYza6N
    5FwomSrfGGXvBn/CpC6E+vLK0HqOclsYLaYUZlCyhYeZU2QZhqD9PrZFgcFhrm6A4kMz4Q
    PtISmyAzDaF9uiz8S7yjewSD7mxViYVEc2ngJVywOYjhwVkVLUbodwen+Gi2ayJtKQHosp
    z4BPaVfXc1H2bdOcZSw1HxSREdmAn/gsAwvW6YhMq92uwqXCiemQQZ9FYsAlANxd/Cl+xN
    8T0FbtdRZlH75dUQIj7RCDMML3BMPtbPIdcWvD2/3f2P9tBmGmrV/H5HQGbqSKOIH5W9BX
    0ONEkgCmSR85lleh98IdUJU+0ihDFP5vIlBNBM+1GXRqx3oo3D2fNXekB8VlGFhyZvE6L8
    kmTOJBzVnt1CcRs3T5ivh+0rp+Y9TS/nxRdJKMpEVkwMvhHEE0atmzdej4vpmXBFdikcSr
    KJD0+RfqEviKXeZ+nqvK81tX4ERXsg90RKSVG5tMbN5qYKUgx2b63HcfXeTg
X-ME-Proxy: <xmx:WNAgas_-wCrHQayvUN1Ux-PJ3RRTaCJMtduyxmkgmxGBV5k7HHJQNg>
    <xmx:WNAgauKtL6_Gs0IBLJlrGh6mLTl_Zp3WmJIibweCodPHP_SeQb-eGQ>
    <xmx:WNAgahljdARctpWKr7ogJ3Cy4hTAEk1Kad0ZiJIRjvEmDoEh66Q_yQ>
    <xmx:WNAgaiO7jQepqQyPJiOUJ_IsMHYkpug28lM_wtIAbaQzG8o7Yxq6Tg>
    <xmx:WNAgahEcAHqf1ZydtDObDVY5OtenkMAeHS3A9wQFIR82259LchRSPUE5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 21:09:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] transport-helper: fix TSAN race in transfer_debug()
In-Reply-To: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Tue, 2 Jun 2026 20:13:10 +0000")
References: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com>
Date: Thu, 04 Jun 2026 10:09:43 +0900
Message-ID: <xmqqv7bzp0vc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> +static int transfer_debug_enabled = -1;
> ...
> -	if (debug_enabled < 0)
> -		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
> -	if (!debug_enabled)
> +	if (!transfer_debug_enabled)
>  		return;

Would it be possible that transfer_debug_enabled is still -1 at this
point?  We would proceed in such a case, which is a bit different from
what would have happened in the original.

Perhaps

	if (transfer_debug_enabled <= 0)
		return;

is what you want?  I dunno.

> @@ -1648,6 +1640,9 @@ int bidirectional_transfer_loop(int input, int output)
>  {
>  	struct bidirectional_transfer_state state;
>  
> +	if (transfer_debug_enabled < 0)
> +		transfer_debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
> +
>  	/* Fill the state fields. */
>  	state.ptg.src = input;
>  	state.ptg.dest = 1;
