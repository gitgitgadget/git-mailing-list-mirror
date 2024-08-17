Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4BC12FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882922; cv=none; b=kTyfSveo4UuDst6LTRawuIKnuDbg6XOhAtUetX/Cgr+TEJGqfgUZdsA45fbqgN2QQYNuxY4yE17gSxBjGdl7WtdatSpWZLRjqOelVfwMSNdvGp9YsuuX8oHVHFXC3Ie+b0sesogaIVc9aXLbrGkrKNdEOTo4f3uEXXR6A17J/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882922; c=relaxed/simple;
	bh=0NqesQBTTLSv5taP0t+lulgewfFLps+O6yP/E/I/mf8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwJab9O3RuVKm+yb0CvdRnaW1aSyWdV3DkeWLUwXlBtwlvErf7BIsX4H8NUHXV2aarVi5yWUzWdcyIuhv2Qxv5/vu5j2U3wv71l1a+tT2TCxKhvhrlCiPT1Uo1BKkOJ/Z/i9LgmoXpK0cCGXc3cdY67lxV4pzkWpKUcJQYT7hCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24679 invoked by uid 109); 17 Aug 2024 08:21:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:21:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27935 invoked by uid 111); 17 Aug 2024 08:22:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:22:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:21:57 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 02/15] update-ref: mark more unused parameters in parser
 callbacks
Message-ID: <20240817082157.GB10287@coredump.intra.peff.net>
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

This is a continuation of 44ad082968 (update-ref: mark unused parameter
in parser callbacks, 2023-08-29), as we've grown a few more virtual
functions since then.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/update-ref.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6a6a2ff55d..8f31da9a4b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -274,7 +274,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_update(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+				    const char *next, const char *end UNUSED)
 {
 	char *refname, *new_target, *old_arg;
 	char *old_target = NULL;
@@ -360,7 +360,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 
 
 static void parse_cmd_symref_create(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+				    const char *next, const char *end UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *new_target;
@@ -423,7 +423,7 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 
 
 static void parse_cmd_symref_delete(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+				    const char *next, const char *end UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *old_target;
@@ -479,7 +479,7 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+				    const char *next, const char *end UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
-- 
2.46.0.585.gd6679c16d8

