Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654FAD4B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245239; cv=none; b=CTlmL2SUwhOtDxNC+dQjTOrY/rQ2lYDsnMdfiw/CV4SM7F7ITpje+A2tyN5C6Ic2YpZUXoq5YzDWSK85kIgeqgdnZZoiE3r18s1mA47GJncFP/HmA58F8/xM5CroAOzbUODYzx+RyEFh850xjFiNSg/uFsD+JMV/O5Y3QcZLHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245239; c=relaxed/simple;
	bh=Xi68dwvvYODRlclv+jIvitW+x58GBNPtiA+CO1Wa9XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axoyn3PN58CMMq39lmXifsVs5x3B76F9y4VQxMrTssozm5dAj76DAl9M5/RwnlKtfgMtRSQM2BcdFcEcsHzx0ijDbI/Ah9bjbgRqTUdKh2lB+yK7tk7NvU4rU4iDfLQ0JIVDXcrKsXrFs19Ozr3hIyZ8xDc1vERwAR+F7brW5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GqS2wI9w; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GqS2wI9w"
Received: (qmail 110100 invoked by uid 106); 23 Mar 2026 05:53:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Xi68dwvvYODRlclv+jIvitW+x58GBNPtiA+CO1Wa9XA=; b=GqS2wI9wLS3hPO2t2jNzxewODVY7gcX2MxNyss4GtT+IsK14RXcAWotH9iJfddpyHMl/e7ksNzE/YjoPp7c84G8US9i2fEDyI5ZTTeKS18yzGZv++gQOMs7jpsZcp8eYlMwbOYwrhFi9KJTwTdnTrB+RJZ60uptu5dPuGGWx7rJX3+TojtaEppOXSGFmiWL+KupCX9aTgFqAgO66w1a6984047jV+7UwokhkHkBVieXJv41l4xOaZJ4Jp/Gg0maQuIMIc+ZzIx3M2i9dpddPVI2GyycpTq48Igj+IW40kLFKodCioyIXl7HwBLID3HRGSz+xCVtiAQ3UVcyt+oaPkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 05:53:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146817 invoked by uid 111); 23 Mar 2026 05:53:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 01:53:55 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 01:53:55 -0400
From: Jeff King <peff@peff.net>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH 5/8] diff-highlight: use test_decode_color in tests
Message-ID: <20260323055355.GA9976@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004436.GE3654226@coredump.intra.peff.net>
 <b992e118-f948-4145-8d77-96f00b497f99@gmail.com>
 <20260322204750.GB2047044@coredump.intra.peff.net>
 <b1064c6b-21df-4ea1-b753-549e0ca1f346@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1064c6b-21df-4ea1-b753-549e0ca1f346@gmail.com>

On Mon, Mar 23, 2026 at 01:48:49PM +0800, Tian Yuchen wrote:

> To be honest, I didn't think about it in that much detail. I just noticed
> this tiny issue and wanted to take the opportunity to remind you to check
> other parts as well. I'm not saying we should remove those pipe commands :P

Ah, OK. I think that is the only spot, then. Thanks for pointing it out!
Without the fix it was missing the whole point of patch 3. ;)

-Peff
