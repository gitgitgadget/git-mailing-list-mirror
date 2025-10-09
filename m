Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C536283C93
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046999; cv=none; b=dzPuWaowGDJ4g+gSmKuMbRmxvHpVxhP/lwjvOqXhtLCEOu/6WEnfY4LiIN7yny4i5kXfpzIFQVKuQ3Xt78sKXMVJc8aFVZ9Wp7Ptksqt8kPAIuR+pcjkFTwjVsFCxlghbEC0VxtY5Tt8D1rKbkRpTdeuQ7lFfo6Y8P1RI70hJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046999; c=relaxed/simple;
	bh=nvdTVKSNT3WaRh05WUOIi1Gg49VraFI0PjaBVvMPPpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8uy6zNqJQHI+4dd2Hle5whMCzFI2GrmWs6GJPKDJ1wAdvk7OhOq9tTE6qaxDX51xqlxMhk4fkY5C71IC05GJN9rVEbpaEEVxvf56njoH9OiAEdl40RkD/oqwHFXLSAcQavlMe2iF+ajQ1z6LKm4Y+0imTWgT5WJq8LOg38KQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pgzyNruD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pgzyNruD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=nvdTVKSNT3WaRh05WUOIi1Gg49VraFI0PjaBVvMPPpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=pgzyNruDNxFUx38ssVk0cKE2ZFgdxJqwozc2TXYACGCqCseQSW+vs+X3cJ/bCd6Cf
	 M8ji2ZGoJCC63d7yOATlnzluN/XHQSPq7LJpbwNdEZwi8/MbF869H6GUOJLLN+epaw
	 ms8VsgCkkIkFpwUFKdEjYEW+Ffr6qhrK397SMul74Mkz1AWIy76Gx3Es1yJkiWEY2T
	 uVU0944wPir/wTaeQzkKkziZ1BqNVXI61PvCeLbgb+nevSensjxhZZoo/F40XByeQM
	 kfKGzGp0bSVF8NQKTvBGqyx2euluPVYhWY4BxRJLz8zaITHSehisu6JO2aaTC3TjAQ
	 hSIKUzov+kIEvYtrRrzmbPMyeuJTMVnwxOMfkubPhhHtux6dDe/xNY3DmqYpCdVyzM
	 CPt7U0GhrnmvWXJ0AcNGtDvcD1OM45CoMsVQ/3xhVSQ/76Udm6lPU7eWUjLOkFkLQ6
	 xDdpy+ES8DLar3Uj9YfkvNWC1vcVA3NuUq+L1KFBpxhjZWqlDeP
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6BB7720144;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/9] docs: update offset order for pack index v3
Date: Thu,  9 Oct 2025 21:56:19 +0000
Message-ID: <20251009215626.3089287-3-sandals@crustytoothpaste.net>
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

The current design of pack index v3 has items in two different orders:
sorted shortened object ID order and pack order.  The shortened object
IDs and the pack index offset values are in the former order and
everything else is in the latter.

This, however, poses some problems.  We have many parts of the packfile
code that expect to find out data about an object knowing only its index
in pack order.  With the current design, to find the pack offset after
having looked up the index in pack order, we must then look up the full
object ID and use that to look up the shortened object ID to find the
pack offset, which is inconvenient, inefficient, and leads to poor cache
usage.

Instead, let's change the offset values to be looked up by pack order.
This works better because once we know the pack order offset, we can
find the full object name and its location in the pack with a simple
index into their respective tables.  This makes many operations much
more efficient, especially with the functions we already have, and it
avoids the need for the revindex with pack index v3.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/hash-function-transition.adoc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index 274dc993d4..adb0c61e53 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -260,12 +260,10 @@ network byte order):
     compressed data to be copied directly from pack to pack during
     repacking without undetected data corruption.
 
-  * A table of 4-byte offset values. For an object in the table of
-    sorted shortened object names, the value at the corresponding
-    index in this table indicates where that object can be found in
-    the pack file. These are usually 31-bit pack file offsets, but
-    large offsets are encoded as an index into the next table with the
-    most significant bit set.
+  * A table of 4-byte offset values. The index of this table in pack order
+    indicates where that object can be found in the pack file. These are
+    usually 31-bit pack file offsets, but large offsets are encoded as
+    an index into the next table with the most significant bit set.
 
   * A table of 8-byte offset entries (empty for pack files less than
     2 GiB). Pack files are organized with heavily used objects toward
