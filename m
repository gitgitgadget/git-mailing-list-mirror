Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80657F9E8
	for <git@vger.kernel.org>; Wed, 20 May 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235829; cv=none; b=QW2zCiaX5iJSJH4FxpPZ6XYWY6da4RbQy5+Kc4/1Tqbs1mGwvne2AXlUWqOHBsKkx2e6VI0mapR/QmfvmZFGmjK4pPwqwc+SPYILHcFBwudDniOuBZmLposuOkEEGXUJ4EHUZ9OhTzzc/rtHqf22LAvZMPIizmU+6AwxDaJiwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235829; c=relaxed/simple;
	bh=nyfvazgeZZQnOs5OWBhdvdza0Dz5H+cqYphFC1l9gBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMyX8HfeOXWHNcbwSQkl94lyWVMPBNlbjFnIWf17pJmXk5AojWSYpUj9XSc6bC6P+r+cCDJiGX+qr6JDw+haD4nmuqM5P/vDkeWRHPU5HX08KK6oMS1QwK4aKevO9k/mNO4acKPZa57NI+0SCbLiIYCGEasJAHavlsHsqmWMgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ULWWbbPU; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ULWWbbPU"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65dead17c24so3958270d50.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 17:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779235827; x=1779840627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrEZ+QDP38lDR4IxsATNYDTeVmljG5Vv52M4vvaqFp0=;
        b=ULWWbbPU8VljG/XgReRnWsNzlSn1Gd5PfkgMdttg2nESDAUsNu4kqpB9bFGKZ3j9yg
         BrG5nRA7LpSQVH5MmbrJswXEUiJWGGm7WU26NXB0+Vr4FX4ZiCs46Ql13ieDGPnUZWjL
         SjHyTAUG/4iQ7D+4hvBA6QBqPsiftrnYVeQplh8xmJQOG4oXzp246/mYZsTlTo0fjsJP
         baKUHYrzorL7wRiPBc9erIoVzNHBcQevZBkZl7eCBIFZyTT3pN+z7cI1f2LIkAhrMV2h
         MIAanJvv7SIJAJejzWaBR5XQtT9LWM//iVa6RsHvOKc/XAScPXFCShR0QBArBm5gb0Yi
         lSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779235827; x=1779840627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrEZ+QDP38lDR4IxsATNYDTeVmljG5Vv52M4vvaqFp0=;
        b=i9CeWTM+qaWXkqmCeTSRgUZR31y8dT1lClDaAkHdH/fNKmlv0wVbYWxoolLVTQbH+9
         /T/9eSd9+R8D1twwwtWAZNNmp6VOpwsO76xZP9+cWoamd3pM8y00VPEhXk+k7MznAb9P
         b/BaK/Z3+e8XCqx+s+6curWwO82iXyFvAJJ5E9cHIiGU8QWcG5yCvyCuVf/HaGCHCiO4
         l5iM7yXSZZuNtld7COawM3FKBBgRA5MFR4nKGbGRFTRWTuz2IEqeQEKRxtl03Ga2PtZx
         lKRi1YlksFnec0MrLMkjuMQS0rr5dX9GI37nyvjLJik57RHuhNyyTIuAx6WnQ6F/47Wa
         vllA==
X-Forwarded-Encrypted: i=1; AFNElJ/ho3g4IOR8+eQ2xfsObIZBXYVBMeIYmOZJ+xw2+egmjyf7GMRC0Y287afszfga+IpRnQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPsaYVUvUZi847n+DneZZlQrVJ5LZObFMVyC0ShXJoUtFUIiB
	ZqQv1xe7vDuD6ddO5wimVOKgu00SQ8pVTaWdwmFis9RHc8802E/k3krQRf40gv8DjrP9s+hQjbo
	Mcbg2TaA=
X-Gm-Gg: Acq92OE4tL16MyH+1iJzLMSj446GH/41OkQJLclAdBpEuphxRalHyWVGWTKr+VzIe0v
	bVjKGsC06+yu4pMn9BhA8Ir7zVorvcqDcHsN4wQc2BnSQ4EWWNZSmAu2kBgxtBMP62ISgIkBS+1
	aoF13kV0QbCwXerhVUgED0/yL24CtsvDsp4pA/3uncY5dFni7kRKmWltTANTvFHm+xii4cSm4yc
	+VhMTQnSvgQR+uSJKEMf8X1fa/21qC6K4RJWft0JcSNSvajClaLmRtyIfHQnByuSXVaa+GWhdug
	tg6DQ6m5xqmN6VMcxi5s3FbaUZpkXz5XIrv+RZXj+F6Cw7IiuaTw4vW1Cz/WbpKzc947KDUM9tV
	OLyaGc380Ca2uGay+g9/NircE5HAZ/T1Xg6/FSNTda6W6AsVKaKxioiFmq9qGdHwtCN9CXlaIAz
	8spzJAKDU3aARzut0CHW+WrY500ut6CgstBwRhHIr5vgl4lJe8asT5l7prpcYz3tP56aoFYy3QU
	FM1rBsa81mD8h/ryFmRwV/ML1K+7WctfrEMDGhBNzKiHreeRabcVBLe/Mw9XOQ5kYBxNQR6yPmU
	GAG/MvK2YossOWL1
X-Received: by 2002:a53:d008:0:b0:65c:5329:788e with SMTP id 956f58d0204a3-65e227bacc0mr18658401d50.32.1779235827527;
        Tue, 19 May 2026 17:10:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6cd4f5sm45326217b3.35.2026.05.19.17.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:10:27 -0700 (PDT)
Date: Tue, 19 May 2026 20:10:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/2] builtin/maintenance: fix locking with "--detach"
Message-ID: <agz78jjYEAif4lZt@nand.local>
References: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
 <20260513-pks-maintenance-fix-lock-with-detach-v3-1-f27a1ac82891@pks.im>
 <xmqqy0hnipy4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0hnipy4.fsf@gitster.g>

On Wed, May 13, 2026 at 07:06:27PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Note that this is a broader fix, as we now always reassign tempfiles
> > when daemonizing. This is a natural consequence of the semantics of
> > `daemonize()` though, as it essentially promises to continue running the
> > current process in the background.
>
> Exactly.  I do agree that it is the right wy to look at it.  The
> process that daemonise creates and leaves in the background is
> logically the process that continues to execute the service the
> process the user started, and unless the original process explicitly
> says "we are done serving this thing" and cleans up tempfile or
> lockfile it needed to serve that thing, it is natural to make the
> surviving process to take over the responsibility.

Yeah, this is how I had been thinking about it as well.

Thanks, Patrick, for making the change. I think that this series is in a
good spot, though I'd like to hear from Peff who had some comments on
the second patch from the previous round.

Once this is merged, I would suggest that we consider tagging a v2.54.1
with this in it, as the failure mode is pretty significant for users who
have concurrent maintenance processes running.

Thanks,
Taylor
