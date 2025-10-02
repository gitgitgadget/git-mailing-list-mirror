Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490E273D9F
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444750; cv=none; b=eXdpUs//oUZt/0X/LHQEyQrMpNmlk5AFmUdqAYURwxpQmF8rgZWHqKurC5/VoumlZ2ktbmNN+9OnT6iVxiNxnnwzJG1bAiamDmhy7VQKdHnVX7vnl/u3RnjKWGJ7IpGZ7LiLDVgeTrkjKkIZjF5d4IyharIpkIsayQLoNe2sQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444750; c=relaxed/simple;
	bh=KTB6yX3WfOYLpAKs3QhqvOGz6nAMaHsvHGVaj+Ps2B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9YTj/in8KoxOHVb9d0Ay7ZnVrJVNLePg5X5RDK+Y7Et8HHXQH7XP1BVCc0+iVXgquV8lCp1A6w/RgNLDiNrRvuCCyFK07jyNMq5D8PqneEvOTIF+22yF0vsTZGVb3KaJsmYyNalPQn3W1q1MYQO1L/5csU6Kta/CbQjmlsUe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nav61Dyt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nav61Dyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759444746;
	bh=KTB6yX3WfOYLpAKs3QhqvOGz6nAMaHsvHGVaj+Ps2B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=nav61DytOiOcdCPgUsM4Vv+eQ9jMFAOJFWoemLKDjYEap1bQYLPtfl46iNO0y+sfP
	 rezr2x5WrOOP+7eXhPeA002pjbSkf4qCFFSz7+e9DTnHUhHfJHtoCy+Bf7ZM4YffH8
	 kvMpPRGmu/qgVlaKqXlaeqnnXQ56BpN2+Ct7tRb8M6fIoUV8EP0O2mNmpjGrUNJ1wi
	 p3zT1w1WQqOIJwLSjGzW2qZ9m9yKw89XKasDc752taQUgX7/lDi3aQ4KRZeCdZIUC/
	 kGRs7VKroCoaGr/3krZzuJN/7DIz7KecwHr/ckrZJ9KU4C5RfY5nAaN/2h92Rlv8xr
	 6s/m/DLTbB/kPN4XoQFRAgMOaogF6I6TBjzl2Hq5Q2j7xEM0IcLgVFXjHfyWTzK77p
	 OMuPMK/HL4lyR96lX60xqoVKpaE6Vmb+GNZPnUH/GCW3b3xgyOd5UWDwmIOjxSaIcS
	 KcRbTWcvMUrQlh/+hSZy1pyeWHatnf9EB4zxVKTzAuXHUzVTXCi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b8e7:3022:3f31:478d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 48B772019A;
	Thu,  2 Oct 2025 22:39:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/9] docs: improve ambiguous areas of pack format documentation
Date: Thu,  2 Oct 2025 22:38:50 +0000
Message-ID: <20251002223855.1022847-5-sandals@crustytoothpaste.net>
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

It is fair to say that our pack and indexing code is quite complex.
Contributors who wish to work on this code or implementors of other
implementations would benefit from clear, unambiguous documentation
about how our data formats are structured and encoded and what data is
used in the computation of certain values.  Unfortunately, some of this
data is missing, which leads to confusion and frustration.

Let's document some of this data to help clarify things.  Specify over
what data CRC32 values are computed and also note which CRC32 algorithm
is used, since Wikipedia mentions at least four 32-bit CRC algorithms
and notes that it's possible to use different bit orderings.

In addition, note how we encode objects in the pack.  One might be led
to believe that packed objects are always stored with the "<type>
<size>\0" prefix of loose objects, but that is not the case, although
for obvious reasons this data is included in the computation of the
object ID.  Explain why this is for the curious reader.

Finally, indicate what the size field of the packed object represents.
Otherwise, a reader might think that the size of a delta is the size of
the full object or that it might contain the offset or object ID,
neither of which are the case.  Explain clearly, however, that the
values represent uncompressed sizes to avoid confusion.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitformat-pack.adoc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/gitformat-pack.adoc b/Documentation/gitformat-pack.adoc
index d6ae229be5..9b7af5c184 100644
--- a/Documentation/gitformat-pack.adoc
+++ b/Documentation/gitformat-pack.adoc
@@ -32,6 +32,10 @@ In a repository using the traditional SHA-1, pack checksums, index checksums,
 and object IDs (object names) mentioned below are all computed using SHA-1.
 Similarly, in SHA-256 repositories, these values are computed using SHA-256.
 
+CRC32 checksums are always computed over the entire packed object, including
+the header (n-byte type and length); the base object name or offset, if any;
+and the entire compressed object.  The CRC32 algorithm used is that of zlib.
+
 == pack-*.pack files have the following format:
 
    - A header appears at the beginning and consists of the following:
@@ -80,6 +84,15 @@ Valid object types are:
 
 Type 5 is reserved for future expansion. Type 0 is invalid.
 
+=== Object encoding
+
+Unlike loose objects, packed objects do not have a prefix containing the type,
+size, and a NUL byte. These are not necessary because they can be determined by
+the n-byte type and length that prefixes the data and so they are omitted from
+the compressed and deltified data.
+
+The computation of the object ID still uses this prefix, however.
+
 === Size encoding
 
 This document uses the following "size encoding" of non-negative
@@ -92,6 +105,11 @@ values are more significant.
 This size encoding should not be confused with the "offset encoding",
 which is also used in this document.
 
+When encoding the size of an undeltified object in a pack, the size is that of
+the uncompressed raw object. For deltified objects, it is the size of the
+uncompressed delta.  The base object name or offset is not included in the size
+computation.
+
 === Deltified representation
 
 Conceptually there are only four object types: commit, tree, tag and
