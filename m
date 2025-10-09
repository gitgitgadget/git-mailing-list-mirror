Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CB283683
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046998; cv=none; b=S1v07Hl3V+41cG879jzJ8y/sDzzNqQhVJ7/36jJwPgGEZuXCZoZn1sSv6uzqu5SNSqSTTQnU+iOQXfhAsE7lpEGdGmD1tUrY09d3MhbBl4WZF5fdI39NVVdSLDmW2DTMTLwHO2X9GEVJFLE2Dri9jQOYs+beK5C1Bm9Lm5nwXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046998; c=relaxed/simple;
	bh=UjkdROINfKPiyxuQaZ1/051puFgfH90eDfnv4v59pG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adHQhqtwq2FgQ8lZDZQ2uC31VvPLHwX2RXJiDRYUN6HsWG3AG5t2b5pAFGiDiDaohmR8u4TcYpRv8iwLIq0MOIua9mHspAdxFiGsTClY1r9kNv8Ezwhf3iIkiiMiS9JWoVb7XvazZUHPwhWZznsB6Mr5rRmdTCCsXbOwF3Ltm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=aYLQGvy+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aYLQGvy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=UjkdROINfKPiyxuQaZ1/051puFgfH90eDfnv4v59pG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=aYLQGvy+FAfOly13ZVMMzJnIEigkASOtJyse80OEfcpiksbJtcILVdZAW4z7BqvdJ
	 zUsRC9sBtZteCQtp1+FiwSPeALENBbguURtbC2Fgxv/l8dfqTLdRo6XyRi+sW5CPQJ
	 iD8M3d+oum7LgbHUvZDmF8sAqmcQi3mz40Nz2DqMcxmc8pHfSmpAhdN6R1npZRwEOA
	 +DzEmCK3DkasjNGecuVEsjp25GeRqCvp3DPNR6viBY8dG3c7LrxT3d8HYYgKOWAW28
	 1FAKx0MfptM3bnDmtSFS1wLpaWtHCes4ujsvDdp8m1sEJCLzrcphNSFN2jb7KlHSag
	 BVmqOd8UkT3cuB7ajY7LiNEzaKADcgNVVl1PX6k0l639biZy21oWWR0wDikSGhqyvm
	 dIVc2G2XVMyQlIs/s8WV4y+xfRtFhJTC+u7ztDpirLbVcvrVfPhxChOEWJ13X0XMHH
	 1I9LRJp4pD2DSTvOHu3rq7Hj5SV+ULahXMxVoD3PjqifdObXV1t
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7333220159;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/9] docs: reflect actual double signature for tags
Date: Thu,  9 Oct 2025 21:56:20 +0000
Message-ID: <20251009215626.3089287-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251009215626.3089287-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for the hash function transition reflects the original
design where the SHA-256 signature would always be placed in a header.
However, due to a missed patch in Git 2.29, we shipped SHA-256 support
such that the signature for the current algorithm is always an in-body
signature and the opposite algorithm is always in a header.  Since the
documentation is inaccurate, update it to reflect the correct
information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .../technical/hash-function-transition.adoc   | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index adb0c61e53..2359d7d106 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -429,17 +429,19 @@ ordinary unsigned commit.
 
 Signed Tags
 ~~~~~~~~~~~
-We add a new field "gpgsig-sha256" to the tag object format to allow
-signing tags without relying on SHA-1. Its signed payload is the
-SHA-256 content of the tag with its gpgsig-sha256 field and "-----BEGIN PGP
-SIGNATURE-----" delimited in-body signature removed.
+We add new fields "gpgsig" and "gpgsig-sha256" to the tag object format to
+allow signing tags in both formats.  The in-body signature is used for the
+signature in the current hash algorithm and the header is used for the
+signature in the other algorithm.  Thus, a dual-signature tag will contain both
+an in-body signature and a gpgsig-sha256 header for the SHA-1 format of an
+object or both an in-body signature and a gpgsig header for the SHA-256 format
+of and object.
 
-This means tags can be signed
+The signed payload of the tag is the content of the tag in the current
+algorithm with both its gpgsig and gpgsig-sha256 fields and
+"-----BEGIN PGP SIGNATURE-----" delimited in-body signature removed.
 
-1. using SHA-1 only, as in existing signed tag objects
-2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
-   signature.
-3. using only SHA-256, by only using the gpgsig-sha256 field.
+This means tags can be signed using one or both algorithms.
 
 Mergetag embedding
 ~~~~~~~~~~~~~~~~~~
