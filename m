Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531E145A1F
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639980; cv=none; b=jpLf7rX7hX+cKhbxBYtdyNx1CmXYdGQQbpmmEtEKfRWI41PfV9YNa1tpzrLcpBhvAWpWN7LHICZO9HTkSjqOqPx7JcSNfrJ+0fF3pF8AR/WSmwn1LETNggdqeXsiJext80hGDVIE9blex8U1JUV6iASM1ycvFGIi+DiQeHSz0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639980; c=relaxed/simple;
	bh=yh72o1LfPMdkgELBwTE9UEWbuXCguRFAZBtwyjsVy/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXJJibv0fClDRJxYDi0EJgZ4J391GCyN4wMSbI/mcBH+QMChPPOokaB8qoVzhyOXeVZZq9jqQ4Mq9qLA+EEVGFgrhI/o6oODgVb2/MLPwMy+GDOXa8y763bUd5Cu0cfkF/gWy+YOvSK1I2QFVTXqBm5TJWKdBTTpqZUvq2Y7DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qHCoHiUI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qHCoHiUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764639969;
	bh=yh72o1LfPMdkgELBwTE9UEWbuXCguRFAZBtwyjsVy/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=qHCoHiUIA+a6TFuuYgMunO1pa3p6kDF38Ea5kxc1Tq5p/Y7JP29nO4oAQrsMFCZmv
	 DA2/4Ksa4Bt9ziZxus1rS2243C5Yj5g2jFPgJRe+Pcq4lc3h1rIvAF1VBpc7GeL7Uv
	 nuLUD0lHLI0qzq9FzI22eUv40X4pBejcllJ14YqI0W/oBwyfYqY9JlmsvO7QBMmaoy
	 K02YmeiBuubStRCc9aWoPjb8fM0LINGtMccEmgMze5FPhCDdKA3q9SVtUOqkxgYKIt
	 lVyGQhRE/3UXokCFZKIorhoDkJmHj5vsfWf5XDQhuBtTRFlwe0yZ6FVI2HG07t9W19
	 YUcTM7nDK1bvcy212sPGjzxytR1S205g7WOwHT4BJ7UdKV8ycD3YAwmln5YjaTmIJ3
	 dr9XwZT77LrauUYkSA7AIGF2gpkYV38FiRN/bzjYpsfau6lg2lxsZr5Wq88K38/cg/
	 eOmi4MSjoYp4NDeT8sTh+RajJwmEKoyXDGfjTBMZ8mbrewc6AgD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0a:dd97:4aaa:b0f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B9C632007F;
	Tue,  2 Dec 2025 01:46:09 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/4] docs: update git hash algorithm for breaking changes mode
Date: Tue,  2 Dec 2025 01:46:02 +0000
Message-ID: <20251202014605.52110-2-sandals@crustytoothpaste.net>
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
the main git manual page to reflect the correct algorithm in this case.

Be sure to conditionalize only full sentences to aid in localization.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..6123ebcb1b 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -576,7 +576,13 @@ double-quotes and respecting backslash escapes. E.g., the value
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is
 	ignored when cloning and the setting of the remote repository
-	is always used. The default is "sha1".
+	is always used.
+ifndef::with-breaking-changes[]
+	The default is "sha1".
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	The default is "sha256".
+endif::with-breaking-changes[]
 	See `--object-format` in linkgit:git-init[1].
 
 `GIT_DEFAULT_REF_FORMAT`::
