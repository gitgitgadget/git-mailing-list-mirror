Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DD3115AD
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349765; cv=none; b=HiEs65Qmvd9soqptgp6Tzglo/da307yxaqdmW5xpEfHZYqPSfOXALEc/vsIpZiToxkJ2eq76mlWHWnuJW8aixqVQuHfJ8A+8YoF/Q2BsjI+xuWGQSelQH5YkRI6ram7fg7xRd40DOjq8LP2ERQ1WCwW9Vbd4czcbC5fsxhsQnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349765; c=relaxed/simple;
	bh=wWe+gYWP+dGFkXEkdMLC4eFYntSRHrOq2TJeeaD1WSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkT0HqsaRxyqizi6YKDCKDmab5FkXtXX8DKojHy4invr72KqjMSGS10f3szsx79hxnKMEXwG8Clf1dw1+EWkq907YwVea8kfnIroUWeCe8pJ2aB8yAvjOCPemqM3+2uLvbjT5/Tm2w5V5aSwb2kM1xmOBXSzTRPPnQEC97IYcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c6CXoHJ/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c6CXoHJ/"
Received: (qmail 21848 invoked by uid 109); 8 Sep 2025 16:42:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wWe+gYWP+dGFkXEkdMLC4eFYntSRHrOq2TJeeaD1WSI=; b=c6CXoHJ/wrJ9hTfkalCrQzEZ4dlsqUjcWF690tP3dbp2MkqqpI1AnBual1Qhi7Pv3c5gbdwc4u/1CiSR9S99Puvc5B06Uw8+a+x8F1C+ALMfKZYo+XlZGk8HoVT5W2PDuEYTG9miS4DM8xgto0cEFKRg5JKkYjcWAEqyceVkLmewgtmnSn7MVO8HAuoIHQJxNEU5PV2qF/iLVGGrM/wLeja2dGcUMJ0sbjmDz1NHmtm0A0lQF0ao5i75YW4oEcFonWmGVZdj7uv0fdADjYVEcWFJGilzZAmHhyCWAad3h0PXRNNTz9uQ5gYl4EjujLIZlmoR9Mq8ul15IxVem5wuAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:42:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36180 invoked by uid 111); 8 Sep 2025 16:42:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:42:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:42:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/4] contrib/diff-highlight: mention interactive.diffFilter
Message-ID: <20250908164242.GD1323964@coredump.intra.peff.net>
References: <20250908164157.GA1323487@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908164157.GA1323487@coredump.intra.peff.net>

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
2.51.0.462.g0a0e5b9b75
