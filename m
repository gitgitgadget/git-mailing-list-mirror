Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B03A7F61
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723279; cv=none; b=Tz0iAzyR+39xZxFvHDney0EwCJDoECRAkezOnAYfiamSwifEdVaXXR8WHHKsxnbLx4oX9WPA33zxGbP6F6WJUtgze6efp7npKu6scsGqfyK0r/o4diW0+klpi0txcUbEU+t/2Z/+Ry1D3s3rKD5/HSyvV7pWF5p4lMAQoojlTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723279; c=relaxed/simple;
	bh=xxyXi1qV1OJMgwi2zGKJXTjI0j8ZvTUWove0WajEQdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVyHMClBabOrlNM61kwy3RhHO2KTRc+iwnti2FKb2+qWiRGy93UnAMc5XzNbTUPSI47jOhKTguYaluaeoWULQ0J8GObylXpFSVIjVXS/lovuCgfO69mm8TMZil9t4pAcjfvGe0KGo3HTElhp6jAx1sRpkvZ9Z1u/bqbmbzDJGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xSjhNNlp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xSjhNNlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776723277;
	bh=xxyXi1qV1OJMgwi2zGKJXTjI0j8ZvTUWove0WajEQdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=xSjhNNlpKTURs5T2Se0jG5S6qRwz79oT71jNx8JaYxcHQB4uTcte35HouI/8aWSMI
	 W59NLBbrXkXVOwVVFabw6XtMGHO+aqpaW+GdJ+iOGj9cIPuajiaS0vMnwxUGTqCCe5
	 9UPu+GWx6vh004slenqcnJH2ksMTkXRYMSWtGf2qJvEmn6W5IHQu8IIWoOh3ZgOlO1
	 u95KKayRMzDl1NnNy/nAL8qisxy0Axx1JN40MgEyOS4gzt7nkMZWHicMnjpixEkdi0
	 8wSoEArI7X4Z8fyyETyzN9fSky9BrWdzW9vgXTrP9cLLb7l9eK2F6c0yjaUvZ/B19d
	 xMxor3LG1dAHaZ/aREa3225/3ezwsijJUdMTN21TAH5qjUJ3pxCLG5LeDC2CuE0DXm
	 Lu2UnQXWJN7Hg0jCL2SG/l4HdgXx1QmVcpg7qxdr+TWRZ54zllzL48pAvn2iC5PfdA
	 voZ1elT5VYxu6inzLJQcUPxfwx698EnQhDVtgvDg07WkUsl37jt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:57bc:7ea2:ca35:d24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 556AD200FF;
	Mon, 20 Apr 2026 22:14:37 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kushal Das <kushal@sunet.se>
Subject: [PATCH 1/2] commit: name UTF-8 function appropriately
Date: Mon, 20 Apr 2026 22:14:24 +0000
Message-ID: <20260420221425.2763661-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a function named verify_utf8, but it does more than verify, it
modifies the buffer if it is not UTF-8.  This is different from what
most people would expect, so call the function ensure_utf8, since it
mutates the buffer in some cases.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 80d8d07875..790dd2faed 100644
--- a/commit.c
+++ b/commit.c
@@ -1637,12 +1637,12 @@ static int find_invalid_utf8(const char *buf, int len)
 }
 
 /*
- * This verifies that the buffer is in proper utf8 format.
+ * This ensures that the buffer is in proper utf8 format.
  *
  * If it isn't, it assumes any non-utf8 characters are Latin1,
  * and does the conversion.
  */
-static int verify_utf8(struct strbuf *buf)
+static int ensure_utf8(struct strbuf *buf)
 {
 	int ok = 1;
 	long pos = 0;
@@ -1819,7 +1819,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	}
 
 	/* And check the encoding. */
-	if (encoding_is_utf8 && (!verify_utf8(&buffer) || !verify_utf8(&compat_buffer)))
+	if (encoding_is_utf8 && (!ensure_utf8(&buffer) || !ensure_utf8(&compat_buffer)))
 		fprintf(stderr, _(commit_utf8_warn));
 
 	if (r->compat_hash_algo) {
