Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33E224CC
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489287; cv=none; b=lB5sjkIEbDd/yU47tK8/VoNYEkRzZ2ruA75vQdWHpwOSTP2Kj+TIJS7KdrQaTdsEcRbUEDl2vvuIwparxJuj7NbqQ8FJ8oRpQK8duNpw8uGjx0wdlK3qj0tuPe1r8qq96wAtpJGsmCBTjIYwtEPDKwDfDxvOxf6eLgnluyoYy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489287; c=relaxed/simple;
	bh=I5z1NNZCzzcfdzsTBIl8GcAKOysq3zllzOnQDwLOlxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/DUJ4GxlunFynksJySsr2wPtlKcOfvTOTnIzgr6tU4xjBERVrJz793wsm+NBDz4xZt12hJ2Fb1u5EZjkjN30Hp8kvM3y2C9yGECGc2JKTiUyF6MuOb4KwbxyHIGs1R6vLSF++fov91XPQ6TbZFDLEvAMAG8VtUMjrew/I3JXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e7W+Ekau; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e7W+Ekau"
Received: (qmail 4625 invoked by uid 109); 9 Mar 2025 03:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=I5z1NNZCzzcfdzsTBIl8GcAKOysq3zllzOnQDwLOlxI=; b=e7W+EkaulDKJZPKkbPr4nNDeaX1kcgzSn/+z29WxsjdcZZF22o/xXu0I7YkeWNVvAql3pk69yWO9jYLTUJ3eSx6f3cbqeL6p4MCfR6mi/QAyV+ocA1IS/STv/DxM1tIWVFbUjDmd93W9/9OxN1lm4i8PNd+Tzc1v95yxknbuoZNbaAYdKwtTP0ZltbBgjF0Tu0yl/OIHlIJ5z+XA8gCCCGY/DoQCmxOnPdjXb0Es1c4Oyt6xyF+zFR/VuL98CoYHR5HbM1mA5V4VdTwCOYuYRyFEVw7oT7atMFKCI9gfHW5Y3HD2BOd9H4ATkCgQki2HFbYRJd81uucgD7UFdLIW6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:01:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4807 invoked by uid 111); 9 Mar 2025 03:01:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:01:24 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:01:23 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 1/9] t5702: fix typo in test name
Message-ID: <20250309030123.GA2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5702-protocol-v2.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d3df81e785..cea8f92a3d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -665,7 +665,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	test-tool -C server serve-v2 --stateless-rpc <in >/dev/null
 '
 
-test_expect_success 'default refspec is used to filter ref when fetchcing' '
+test_expect_success 'default refspec is used to filter ref when fetching' '
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
-- 
2.49.0.rc1.381.gc60f5426ff

