Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540719067C
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639979; cv=none; b=X2anI+2e5PHq/6KZLhqJjhQeQBAysTUJtfHl0lg7Bf3KR3JLKc2akpgcC+QwNY51/ks7ZiMyaM00G4+lrQ8mixpJhMQfNd6FwJpEaaQKMn+3q5wHprG0WmD++jx9x9L8iCo7cMZqOBsUo5+Jd7fCX15wDLj4H1IUdX92HD7eAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639979; c=relaxed/simple;
	bh=rltqiBO4HN+J7wl8bzPueLHdxvWVfDbVEojrJah2vOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTGiahH9gTmD3uJFWxQd7SzFEEYS/9owyjzNeLrASHBLno20RZT27GRjhH66w9kQiSHKiiqEVYReK7OXZLcMIUQyHhZa+2xkgOQXHdeR1fOR1W53zgD5bqmXjuaGPa3FkEyimsa8FyBCtgPqsmkcI7KfOc4GeHN+PfeOoNW8tYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ryZlywuh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ryZlywuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764639969;
	bh=rltqiBO4HN+J7wl8bzPueLHdxvWVfDbVEojrJah2vOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ryZlywuhVthACF1sDngGcMqK/OAqEDeWsby64VwRBKA0tZxBeTIICI6qw8cgK7t+s
	 ypN82YPMsZjT9ClN3UdaOIEXBak0ukaQbVq9CLg3I+nbe6KlT5f+O0zjAJdMdvT1+L
	 tjwqyY8fAALt07G1GiBGQQlO6Luckr+AcM/ZcgxezGVwq9olzxpl1vzvt2b8QhX1sU
	 ho7cuPbHY6SqPui0nQVia5BifMNLUafij2Uz2D2If0SG9yrWRt9y2CykqE/dvM/R0z
	 KNlTSIO1qiNzgyaaal9HggrGDVRmBHSwDdEcUEAMhEVvnbRGaKvr7uB0NunQfDOVh0
	 teBqJ79WLVOhwQ1lg320oInqvFMSugDhmx+38AE+LPY8Q/Bo8/PMn07q0lsBYHHiej
	 U4cxWqkBSSfQhPg+ZyThaIB5LYlR/SJfRB5btQmNIiQ8HjZvDaM5NvGakn+TGcEE8d
	 UrNKDLOZAbi3ecbN+i1al/9EVQHiOYgaL8ZVSzFSqJNMrJ8nSgG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0a:dd97:4aaa:b0f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CE80B25535;
	Tue,  2 Dec 2025 01:46:09 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/4] docs: update show-index hash algorithm for breaking changes mode
Date: Tue,  2 Dec 2025 01:46:05 +0000
Message-ID: <20251202014605.52110-5-sandals@crustytoothpaste.net>
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
the show-index manual page to reflect the correct algorithm in this
case.

Be sure to conditionalize only full sentences to aid in localization.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-show-index.adoc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show-index.adoc b/Documentation/git-show-index.adoc
index 00b3a908cd..af5c114bb8 100644
--- a/Documentation/git-show-index.adoc
+++ b/Documentation/git-show-index.adoc
@@ -41,9 +41,17 @@ OPTIONS
 
 --object-format=<hash-algorithm>::
 	Specify the given object format (hash algorithm) for the index file.  The
-	valid values are 'sha1' and (if enabled) 'sha256'.  The default is the
-	algorithm for the current repository (set by `extensions.objectFormat`), or
-	'sha1' if no value is set or outside a repository..
+	valid values are 'sha1' and (if enabled) 'sha256'.
+ifndef::with-breaking-changes[]
+	The default is the algorithm for the current repository (set by
+	`extensions.objectFormat`), or 'sha1' if no value is set or outside a
+	repository.
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	The default is the algorithm for the current repository (set by
+	`extensions.objectFormat`), or 'sha256' if no value is set or outside a
+	repository.
+endif::with-breaking-changes[]
 +
 include::object-format-disclaimer.adoc[]
 
