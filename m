Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380851ADC93
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244183; cv=none; b=dlY48aQDO85QMr+qw5YQK4UH1SYDC+MPS956wyTGU6zxnYIioaWAjgxQ4H2uVWgQ58/S/TqjnPgxMGHJG2zd3QSv6l/5lEeP4ykYiHyhEWpzs6sATKcWgd2KU+x5T1NpBTRtA2p+Dzpe4r5aR3Zuon7dhKsWUNEZFX0+i5I30f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244183; c=relaxed/simple;
	bh=wPpAOH1u8cUDiO1vgSeyAgSMVtd7060c+U/Qdp1N6yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF63cCTuBbarm9i5pp4dD435xps8nK07akvL1i5XcCRe8/ZeScDvxwaBxWRHLy7yRC/8nL6i8V4KpbI1bNdFWp2w3IcvrbKSZBPEzgEVxvU+QlSntVVFhaSNyufXVgqNwpMbBGUlJwKYj2+qXEZ8rPVmFCR/toXlerFYCulJP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KAQNL/HQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KAQNL/HQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=wPpAOH1u8cUDiO1vgSeyAgSMVtd7060c+U/Qdp1N6yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=KAQNL/HQ776o5o3Vq3Cfu8xtNa6q6ISAXWjkpzLydWrkCnj+veqi/W6jBC+xhuC5W
	 iqevH4BVT7dliSc6bC1TXd8XO84IY6Lw7RPbo9YIQbl/btzyKehAdqYihqfQEeJeFg
	 EfieMvJeoTkVEyB4j9jl+Z+KGDNvm2506VBVaX4f/ZaVE6I92AVYwt8cYz+Vmw2lat
	 5uTaJumh3cPlcVsZM5iHWUdUreT72LOV3PxEfbjPipa27bFA89kGSgre1dOEmb+z8e
	 dn2vLX5OFtFCF65Zi2PDNB9T0OAKo0B5LbakJclx1KJ7ZBaN+GDx4eK4isAiThaE+L
	 j8+/6gfD8gimHRTUjb6v+6t1GTu6GN8qUY/7OUyWw4IUQSROe6L2Lrn1CdHkj3ItgV
	 5iq/6iOmz7KwBb3SSHg5WLFZjMmq5ProSIxzxRBL1THX0YMirxvSwLZ6Dbd3QGpgW6
	 bc5rJo8j5eaW05X1dioBBtYZPWWaYUl1kH8soFfyvs0u8BJJbBE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 324E720155;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 3/9] docs: reflect actual double signature for tags
Date: Fri, 19 Sep 2025 01:09:05 +0000
Message-ID: <20250919010911.649831-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20250919010911.649831-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
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
index 11c4f2950a..27c90e3729 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -425,17 +425,19 @@ ordinary unsigned commit.
 
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
