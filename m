Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B22737E0
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444749; cv=none; b=dEDvA4YyCK9SPp7lUP39qTBYB/Hv+lSVRoMhNvNKdH+P6emQGwBd61y3ZdK8+5K1F1fKTHXsd9Mw0QcdfwHw8cjNomGjfQK0GLHZtOZOr0ySGwo5AWjcUPi36CIvttTVARt52nRpNt9DEtGi0Ry9GwP3nC0l/b/6SKt49G+VSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444749; c=relaxed/simple;
	bh=nvdTVKSNT3WaRh05WUOIi1Gg49VraFI0PjaBVvMPPpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ladsI7aUqeTlxzSUSgbJ5jNSxiiTWNbNHWUNZ5OqRGgT3NSE2b9Hxm2avPxPpNQ6uO0jrGXH+fA8mI4RE/x8Xq9oGUPQ/boU8VXLxWNXceeD2g0zzg7SGlRal3icQzOt/D1HkSewtzHXSHG/cGeFoi2IWcSCzFqwmtdTMgSBNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DF7lzEu0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DF7lzEu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759444746;
	bh=nvdTVKSNT3WaRh05WUOIi1Gg49VraFI0PjaBVvMPPpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=DF7lzEu0UdjOjhQrxsoxfqTQXlb6qan67zaNirpnd65yE6gzfIECId2LSmpz0aqXI
	 uVBNu87af25rH35+QQdeiaucbdx+Mz6BSNkkWMNoVbe2Khicuj/7iARGIigLZOMgu8
	 e8WrBWJvJ/vJm4p0W1+0EX+plMBTZH47+i3qfda0rAWHfVfQFE8U3VNjgM4tf92rz/
	 fecOIOxj1/qpXFbKDtFzn96v/+zt3Kc3OSjBH42CMY3LNLrcCt5H1YEIxZbqToOLG5
	 2qbiSGj3o4eKdKK+TocsPcwRzsyxB+fUgNLXrzoXFG0pDfQBSnE+wzhXrlkoE462cL
	 jAW/cy5Ck/dspKWiU4dWWRnvGNfweGMkhETYYRHscLcGiJs0lLe6m0PttCAwRsEMr/
	 ed1BX4Xn4TzAb0/xA3H8ugEFKMzMNju89lKHbYJtQKFENjUuKlCL6L9wX1abh0uMxG
	 OubCr/YgXmM/4SenMjRZBgmRdjYfIuK47PenhfQ8QaL8T+d63fx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b8e7:3022:3f31:478d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 36EA620158;
	Thu,  2 Oct 2025 22:39:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/9] docs: update offset order for pack index v3
Date: Thu,  2 Oct 2025 22:38:48 +0000
Message-ID: <20251002223855.1022847-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251002223855.1022847-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-1-sandals@crustytoothpaste.net>
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
