Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4A1E32D6
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244184; cv=none; b=iPCfkWDT7gTC3QhwiYC5iiIiCVo7mClUJ7np2lX3phAqor/8D9TjoAuGeXMFVHGlpXOcIT163IJsJWLxpth4qsb5TxjHgg1ZUrfmNh/3I4U6iZpz0faICag6SpjzyZws3mhdlX0X5KXBJlpqPrdYI4KExQxoP3oXP6XIxbEYi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244184; c=relaxed/simple;
	bh=8T2BoRcQ1PMZp0OrV3naLWRrJ+HXEppBMbrCvph8Wus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqDBcAT2lwn23ITOZcP8WhpW41tst2AjY5RJu51NWbreJGQh005g4ZA5+IKxXjOoDOaHqKsYF9hZvX71NtTjPLT9Sbm07h3yHGcjl6MKQZGXKKGUNjG5GSuvWAxsCqq1KwHbUUSaBl1MuPT6B6K7TdSFj5k83N7jPWKGjIV7UFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=A8Duw1Sq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A8Duw1Sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=8T2BoRcQ1PMZp0OrV3naLWRrJ+HXEppBMbrCvph8Wus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=A8Duw1SqZpJoqsGdpSVANlRXaeB7IX6pKR5dsJUGgJ8lz1JieHaY8pQVWujPz3Vet
	 fuyT655AK09cGM+lG2vE7Lql5PpzObbcbCdt5Y1kurLMojaOxyWWZpVX/Ksk/yFM3S
	 8yZ7b0XlVSAOP3s29VEpe2tVl9ABS7yJmuZ7DrVik9mK5Y+bKCspF09tZrBAJmOAz6
	 FPhWRuV/RbdzvDbK2rCbh2sYw/QUeLnjJ65lm7Bl0xWVELCVD2CVCagF2iHOIx7Yh/
	 Md4895kfn5di/rh8l99u1/GzUKQHjeH9HtesgpNDcLh6A+ayBt69DIrl88Uw2cBgCv
	 q//CW33HqAK+jHm9ZBxj76p8cP128bepDn6eNDRqctLX0W5yYUn0ct4Iw9tdO2mX2s
	 t25wAcMGaqg3otAqzEVIvNXxy6XCCHBaRzRFl0s+C0dA6QS3leJPhrysRR8px2it21
	 NgHpQhOjwg5vdSbPLwOkXLeNoCNK6mVHXGPD810wuftHf7cGp/7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 29B8E20144;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 2/9] docs: update offset order for pack index v3
Date: Fri, 19 Sep 2025 01:09:04 +0000
Message-ID: <20250919010911.649831-3-sandals@crustytoothpaste.net>
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
index f2df1d618d..11c4f2950a 100644
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
