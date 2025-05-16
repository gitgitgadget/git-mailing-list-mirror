Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D34B1E44
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370972; cv=none; b=R5PgWRMiR1/pnALBDn4ZMARQxPK+Bq4atypEjESh1MIa9+zsQMW9fhZ5Pg+G+KasifkImhJJkjmq8Q2mwbqWqcP36kENHVJggIEYnXl2gn38UgMC8jkEOfSzlQF3Mr7aB5OssuFOShY3DcAVq294AYDpL7t2mimIyu7zoNxXWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370972; c=relaxed/simple;
	bh=YKTrAVDeKgu6BuXukVQy6/p9vhjm8Zn9TO29Qf7kOs0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J44UoR/kvwopBHaxt1nJ+/T2+vvAgnfOXRwJnC7bKReIaIO3tT39g20ruALvPuzMoWyephcwLv2UMrmJTgy/nwjKhx0ukuIcVIkMSDH5EyfGgZub6jvN9H6skwpFis1M926SIGlW7DIfIgxDQe+x4HCFNsZ9L4cDAAYq1rMm6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=goUOCuSa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="goUOCuSa"
Received: (qmail 5145 invoked by uid 109); 16 May 2025 04:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YKTrAVDeKgu6BuXukVQy6/p9vhjm8Zn9TO29Qf7kOs0=; b=goUOCuSaU1SnhhwNaAPBIVI7qeX6juSgJHUhh3xJu1mC4AsrkUqxLQobh7vFKB+BYyyRzustTHV/iirGUUGNC4+nr+FkNRGAssfl1fGRr+ijIzMZ9L4JTPxmyEtJ5ZI43lQ9s6MJ5rnR2aCYAQBanO3IeIqq4LjJYKzC0pcW/QjuHNsn2nPewcHK3HEnbee5+crz6wAj6R4vBqs7IJqrXmEyHvEMeB38dP/CHSqrqnzi1b/RlamO1R1Juu/MZAP1CiHlbZv5z7Ug1s+pBMm64CqaezUtwFfFTqX5QObpLWs/hIXqyHvwD0vDtr4AkUJXa3YE1+q3Q2c0hJCETtVIMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4889 invoked by uid 111); 16 May 2025 04:49:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 01/13] object-file.h: fix typo in variable declaration
Message-ID: <20250516044928.GA22242@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516044916.GA21985@coredump.intra.peff.net>

This should be "compat", not "comapt".

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.h b/object-file.h
index a85b2e5b49..fd715663fb 100644
--- a/object-file.h
+++ b/object-file.h
@@ -180,7 +180,7 @@ enum {
 
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
-			    struct object_id *comapt_oid_in, unsigned flags);
+			    struct object_id *compat_oid_in, unsigned flags);
 static inline int write_object_file(const void *buf, unsigned long len,
 				    enum object_type type, struct object_id *oid)
 {
-- 
2.49.0.896.g93578ceaaf

