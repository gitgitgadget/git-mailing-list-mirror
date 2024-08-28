Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5F13210D
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817481; cv=none; b=isRXDB+4RpApkG+XuL6cvyAC/LdolelgYs47uO4aCfufQ3nCN2oV+BJyFNLEXgLwpCq/LphhV5HoUJcDkZFNUDTR3nQqxY0S+svCk6nXT2OD3ZHjocVB7u/r70yXbeQAgp7QOFfSW0cFN0e3NilBBv4ipInFDvJEzZ47jm63naw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817481; c=relaxed/simple;
	bh=jaNY1Uk0yL4exkPjWntlXUgqtYzzm0ITQxM/+jifDMc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubsvp49lANqWNwXAz2MeY2QlmF7y7bljwd71WuBBZ9OPk3m3pSO1uiGXIN2YvVwsEE+Z/fmSIKdMAbsDPY3Xt5/jyupQ7XBsjEWANm9Oz6o2ETINFHYp3/Qs1xuwMJMr9EJB96VkfY0pSRYKpxeTLp6ECXFt48V1wZQjOQLrgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20538 invoked by uid 109); 28 Aug 2024 03:57:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 03:57:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23054 invoked by uid 111); 28 Aug 2024 03:58:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2024 23:58:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Aug 2024 23:57:58 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/6] t-reftable-readwrite: mark unused parameter in callback
 function
Message-ID: <20240828035758.GB3999193@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

This spot was originally marked in in 4695c3f3a9 (reftable: mark unused
parameters in virtual functions, 2024-08-17), but was copied in
5b539a5361 (t: move reftable/readwrite_test.c to the unit testing
framework, 2024-08-13).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/t-reftable-readwrite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 1eae36cc60..178296891c 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -26,7 +26,7 @@ static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
 	return sz;
 }
 
-static int noop_flush(void *arg)
+static int noop_flush(void *arg UNUSED)
 {
 	return 0;
 }
-- 
2.46.0.754.g24c813f009

