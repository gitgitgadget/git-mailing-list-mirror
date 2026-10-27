Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122368;
	b=gijLjbq9hSF8iXOttX/v/5xGRqD173DCwnombqHtPfuLEpiQRTKXMnD2LI/7BLcTRX8I
	 2mAbhY/7p12c77KgIVSvSxjSSYIKrZA5gpfsEwMy2Dy5Xy2Bdot/63O+dubn+CMwIkn1H
	 7QF8UV5G1/pszDz6KYh3iHOCVIMbf/uDpyTrMoJwD/IRLpWb9dMX+By+WUKmUJrMaz0uM
	 Tw9EomuUQye87scpmIZyx2nnwdIgDVsMrnI7dTIyP5n2TNqT26SKfC4jOGtxe6lRByfS6
	 UhG2Wz0a73E+ZIDXtbaB6O/L5xi7JINo5BFOvF+EbTA3NizEbNJ8horbnd1N6hTo2yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122368;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=i5H+mWG4h3l1K/YLZDPzt608fJuetzjumiCdOoCqu90=;
	b=dEdD//gymreLvq54Ij0MWuKE0Nq/ogMJPB0czettOeF0ymCiLVYAq/iB6B8cdG4SxkyN
	 wV90PFjzXkarK2/j8LdxU0ZpCVqG3kSOGpDUjnb3XMDwHF4iBNt/oyoMiXBNVbtNaezBm
	 dzS4sne8Iq3vapUtzFU2v8C/gPf4RVnuP631C30/K4BJqppRFBixNSPiDkfRYsrFR8nBz
	 u0a4wCU3/QenumLOPTU56WoLm37ZR+aomGlTgn9Ef7hINYYZCBS2mOoa6f0gHpi+nsVQF
	 gSOpORK7rMXXA6W3yzi94+QkNrtMpmhpD6Tr2KK4Icq4R4GyKlZWfiIdF8itj0pbPQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=CszhfZKC;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A56606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A56606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=CszhfZKC
Received: (qmail 38340 invoked by uid 106); 27 Oct 2026 17:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xwwa6+Weu5a+CsNvmiAVbWuQtkQ4LOl59jhA388GbFs=; b=CszhfZKC6ClqrrxEENJVECbDj8CP6LINfmWMEUN9azzSALcayxeoL1DgyY7sWjyGhaYoJLw14bljdBx8SgqAwYKyprp5aYD6B5YKmpaw5rHpMqs8aAH1uAQvCs5rbuyiGlYubgYjvf82Z463h2woAob0U/OFR8TY8WYuB3EAdtfV6ope/RVzfM4kajBSJupS6IE0HKk5NhLuz7XmMywUAqyALHgwA/q0O7QT8AK/v5oZ8lB0s8IElx16IXvj9zFsd042dfQuajvuKYN/ejnuXP97SU6e16DRNkZFNEDrhItkbPNviMeREQq2ogT8CvPOQtv+XY8ekkbrlqyDFFZb5g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:32:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275899 invoked by uid 111); 27 Oct 2026 17:32:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:32:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:32:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/8] test-lib: drop unused test_external_has_tap variable
Message-ID: <20261027173245.GB136740@coredump.intra.peff.net>
References: <20261027173205.GA97799@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027173205.GA97799@coredump.intra.peff.net>

The test_external_has_tap variable was used by test_external to remember
whether an external test produced TAP output. But we dropped
test_external in 5beca49a0b (test-lib: simplify by removing
test_external, 2022-07-28). Drop this leftover initialization.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a893963f86..3d001b91da 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -771,8 +771,6 @@ test_success=0
 
 test_missing_prereq=
 
-test_external_has_tap=0
-
 die () {
 	code=$?
 	# This is responsible for running the atexit commands even when a
-- 
2.56.0.559.g7c1a1d8168

