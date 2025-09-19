Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE023D7F0
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244187; cv=none; b=XWW/zYteYq+k8zX7TWR7UGMGmI7CeoYuLt4BL7NQTt0wwqiEbJ9GwYO6qkjvXcyBiPcUApRsOU3SdQVs/4RMUfQ20+9IcTQycfGxqwlglL4+TYyiHBWGr8zHgzo5XzfZqe4pgF8WgyB0/GiAiti97jHVOBu7wauzZonnxcNV4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244187; c=relaxed/simple;
	bh=fbRcbaApBAly3c6y2oaxuf1zNfU0uTtsTJu9iXEO9bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYTRu2AXLFlnOSEhCFzwRMAIU/y4TVT4MuNb6tW++ngOD4QVQyfCtYIrmw2TG5rMER2Ejt0jJ/SCwimTpvvjeG3MppSDo5yyif5FbF/R5wGU2aM9vbax0Uuwa3RD66aslCzV6uh+ECWbal8kzP4EUNNGH1mBmc3wLurpqiPhif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=e5JiaCU9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="e5JiaCU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=fbRcbaApBAly3c6y2oaxuf1zNfU0uTtsTJu9iXEO9bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=e5JiaCU9+q/VSXabCtuLRWILec14peSrmxvH9A0a2AomN9AzdcGIQHWKdYCnrDkh9
	 Ju/Tu8ZhUIWZHtSn+wIDt52GEh+9HeDULpvcm4VD36t0Pq1YEXT+YMZbRMykc69zGb
	 A9iCao/Z/uvAUxpq2za/GhSYCNGb04vePjcPtR27qOGk3yACFwKxTpNjYOiDrtnoEx
	 Qu9POZIxk6w1z7mkF055q3YstPu3FnWNPDFkfOaZiSsNf9BC8m01Qn8VcAvOnbpIkW
	 FTrJMiAvJeaVaXQtCTn7nCRYUrUSBYOqVkcrvGxvfdFvZh4pEfay5LQI6tEN8wSxjt
	 CIIq/9Ee1+e+rwEK6ZJhzYNFcqesk+s1fMujZxpDdN/mWEvyR1VIHn3G1fBYtxss4T
	 YEsYNcXJ5lsDtlEnJB20qo6sEqok630/Lnjzk7dfyFbvsQ6/mUCVX980+3elRQbMxn
	 xm+IAOM4NRg4lk3V3FEak5n0lR/DmpabTXQDbb0u3VNsIa/S1UL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 66C9B2019E;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 9/9] t: add a prerequisite for a compatibility hash
Date: Fri, 19 Sep 2025 01:09:11 +0000
Message-ID: <20250919010911.649831-10-sandals@crustytoothpaste.net>
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

In some cases, we'll need to adjust our test suite to work in a proper
way with a compatibility hash.  For example, in such a case, we'll only
use pack index v3, since v1 and v2 lack support for multiple algorithms.
Since we won't want to write those older formats, we'll need to skip
tests that do so.

Let's add a COMPAT_HASH prerequisite and define the BROKEN_OBJECTS
prerequisite in terms of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 14c777e4e2..a4bb9ab2d8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1922,7 +1922,13 @@ test_lazy_prereq DEFAULT_REPO_FORMAT '
 # compatibility, we cannot write such objects because there's no SHA-1
 # compatibility value for a nonexistent object.
 test_lazy_prereq BROKEN_OBJECTS '
-	test -z "$test_repo_compat_hash_algo"
+	! test_have_prereq COMPAT_HASH
+'
+
+# COMPAT_HASH is a test if we're operating in a repository with SHA-256 with
+# SHA-1 compatibility.
+test_lazy_prereq COMPAT_HASH '
+	test -n "$test_repo_compat_hash_algo"
 '
 
 # Ensure that no test accidentally triggers a Git command
