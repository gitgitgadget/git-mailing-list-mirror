Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953721494C2
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639980; cv=none; b=O95rMoASoZ4JVRoDVlmnFD2BohSMFkk2FoTsAHCK1Mp0ozJaO8Lvqr2edn7+lLtpTN2SPnwN+I498V5FnT9b+VEN+IixaezKHlfGSOVSargMx0dDsqY2D5I98H61yqVmG+Wa8k96rJQwYPWewEn1FPP416qt5i7JsZgg7XGQB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639980; c=relaxed/simple;
	bh=JPFgF3F7iKwBUd/ewgnEVYAxloNGAuWDQN6y9H4Grlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTvh5oHOFKbOFm5EiHn9S+ksLc4p5zLPy9RpxRNK2GYAiQMfljFp/RWTA6uiHu+1ZwQqwk/Dz+jRUmCIeWwks33R7KG7giagav+Cwb78te18u//9rYg0Z2SD8BY7uMX0DDFnan96aOABVtkknebd/QigFkwUBQUuWEpO3+IGyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=y6N4+FQC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y6N4+FQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764639969;
	bh=JPFgF3F7iKwBUd/ewgnEVYAxloNGAuWDQN6y9H4Grlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=y6N4+FQCgMPa+lqoRNFuSn4wHZDVacvIHtNzoMYVrZLzHxlshhQYE9Q7CSRfup7VQ
	 O6GTFiYNDuhFdj/SGhM9OGS70B0O7K2nyJxKdOnoLBKA1WW5Wvkrpbxv7YlHCvBF/c
	 JV4MBR9An75sBKdOP3EaXX49YoN3JQsrj2m8WcK3uZkw47/ArS2eUDw1bj81QHRMnb
	 5qXic9dgsDJUgJY5WYo8WqrN86fdt4PfdN9RtP8EeSacszYeUMGzGefPFVBRghXmFy
	 xdAt7wuVvTFG4G45wglrqYzoA3gpXCjwq74ar18hFYcoU2MTHXrh7IIGuA1BkKaQ0f
	 GKGGzqfXNJ1K/yNYMrYDYgo/SYu/dfqkFKDLZJh9eLd4tsutudLWQzoOLOXaVQkUU7
	 6xdeqdPL06MkfW1bjWzX1vGokQAXlTm09VNvFjBlWnoE3MuAYQ1DxDAsC3S9EUnscU
	 Bg4NZDTkyT7Gz6W/aiwbFQwvjqAPZRGs7dzgDZ8h/0CXKJg7stE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0a:dd97:4aaa:b0f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C851F25531;
	Tue,  2 Dec 2025 01:46:09 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/4] docs: update init hash algorithm for breaking changes mode
Date: Tue,  2 Dec 2025 01:46:04 +0000
Message-ID: <20251202014605.52110-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251202014605.52110-1-sandals@crustytoothpaste.net>
References: <20251202014605.52110-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiled with WITH_BREAKING_CHANGES, the default hash algorithm
switches to SHA-256, but the documentation doesn't reflect this.  Update
the init manual page to reflect the correct algorithm in this case.

Be sure to conditionalize only full sentences to aid in localization.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-init.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index bab99b9b47..17dfef4654 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -53,7 +53,13 @@ current working directory.
 
 `--object-format=<format>`::
 Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
-values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
+values are `sha1` and (if enabled) `sha256`.
+ifndef::with-breaking-changes[]
+	`sha1` is the default.
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	`sha256` is the default.
+endif::with-breaking-changes[]
 +
 include::object-format-disclaimer.adoc[]
 
