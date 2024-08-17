Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2612FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883119; cv=none; b=etPFYGErhOJkg/nmISeKMmVK+/9AEofjHvnHvJlfqauUNU/xqWaGC+fwvYEKVF1SOVgcTP7ylPgpanFqZvn4KJDITull0QR5wdag1dvMDguGsw7rB8EMI/X+dWFX/rHn9lB0JZXNz6A/0JeCvUl9mDt4PytSLVdlPsukkahuGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883119; c=relaxed/simple;
	bh=GmqyYhz8tCXU+YWeizDVYj+RttLj2Aw+HeNtvEhaPVY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCLY8ERvGWCNBAhIS2T7F700MB7JDzVel9u3NlnBCGtWqoe9DMnfWD84pm1bKCWqPERqIjGdDHe+EiypwvSH/13KvCGh0/oHSFU5NpoNVLBWHpPtSCVElM2Tqzuj+SAMga5Xt4Kqqy2ipPHWop6JPsFKLDlTz6bHWj/u7SSRrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24748 invoked by uid 109); 17 Aug 2024 08:25:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:25:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28039 invoked by uid 111); 17 Aug 2024 08:25:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:25:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:25:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 13/15] setup: mark unused parameter in config callback
Message-ID: <20240817082516.GM10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

This is logically a continuation of 783a86c142 (config: mark unused
callback parameters, 2022-08-19), but this case was introduced much
later in 4412a04fe6 (init.templateDir: consider this config setting
protected, 2024-03-29).

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 5f81d9fac0..bd44ca21cc 100644
--- a/setup.c
+++ b/setup.c
@@ -1907,7 +1907,7 @@ struct template_dir_cb_data {
 };
 
 static int template_dir_cb(const char *key, const char *value,
-			   const struct config_context *ctx, void *d)
+			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct template_dir_cb_data *data = d;
 
-- 
2.46.0.585.gd6679c16d8

