Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18B2E8B89
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760972; cv=none; b=F2JzdIT9ZdOfqzj4eHqkcuIlOE9ZYqBssrq7BbZP4DA/tUy1lFf3mK3rj8fZuDQ5UTDA63aPE2eHqSNrxCuH9NtT6bWdcdzUqAFq74ud1QM12yeYAkIi9D0pb+AMW4VEA+a/kNPLco8w36b/lddqe4TeI611R4MxkwajNEXX7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760972; c=relaxed/simple;
	bh=E11XoCrx32623KQevWTlb5NfBFqPJ/DVygjRxagln9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCB5aGPyytBoxshC/ql5Vl5Nap3h9b5sYMMRLCSRXvA9hhVNMZj7YysyUjYDxmNl3EYwXHVSXLgT5VRBPMWQEW8z+HsQkhoI4OKOegMPIR+OF52P+uWzw/cOS3Z6gIyBrhSUs4pGeMbcdZNdjj6OMdBFBwPtEYFbTTLl6NRlm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G8Gh9lvd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G8Gh9lvd"
Received: (qmail 42139 invoked by uid 109); 21 Aug 2025 07:22:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=E11XoCrx32623KQevWTlb5NfBFqPJ/DVygjRxagln9M=; b=G8Gh9lvd9WNHBgL4fPaBqBLi4DIda9mKHvqsV7fFR5shuMUVaoxGRxP6jDK8+sxBMh8W85ZKYdr0a3eoKVX0IoNDIpqLII5pbvRfD0JlaXSI0OGR8cJCtGAM7pPJK7dEKuvr449VDZch6qzVMUHyy3mLyc+YXGL2FyrR/AyTrmXX96ooT5fhM89sgqku8QyWvvkuhLlEzQtI5K0/omE8o71BXxeGbTVVfG8uMWoZq76gsZXTGGEG3m0G9waxvmqhKd+HwWiBuJdekcT5nrRnK05zYmSuJv21hJY9ugkIYpc/mM0VGEzYEB5SXyMHNG6oui+dpLodLY5BVYelEg5gvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72382 invoked by uid 111); 21 Aug 2025 07:22:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:22:49 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:22:49 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: git@vger.kernel.org
Subject: [PATCH 4/4] contrib/diff-highlight: mention interactive.diffFilter
Message-ID: <20250821072249.GD1839835@coredump.intra.peff.net>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821070740.GA3356411@coredump.intra.peff.net>

When the README for diff-highlight was written, there was no way to
trigger it for the `add -p` interactive patch mode. We've since grown a
feature to support that, but it was documented only on the Git side.
Let's also let people coming the other direction, from diff-highlight,
know that it's an option.

Suggested-by: Isaac Oscar Gariano <IsaacOscar@live.com.au>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/README | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index d4c2343175..1db4440e68 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -58,6 +58,14 @@ following in your git configuration:
 	diff = diff-highlight | less
 ---------------------------------------------
 
+If you use the interactive patch mode of `git add -p`, `git checkout
+-p`, etc, you may also want to configure it to be used there:
+
+---------------------------------------------
+[interactive]
+        diffFilter = diff-highlight
+---------------------------------------------
+
 
 Color Config
 ------------
-- 
2.51.0.356.g99d8374de0
